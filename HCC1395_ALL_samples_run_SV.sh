#!/bin/bash
# 功能: 自动逐行读取样本列表，提取SM标签，依次执行 GRIDSS 和 GRIPSS

# ==========================================
# 1. 全局路径与工具配置
# ==========================================
REF="/data/share/Genomics_datasets/HCC1395/reference_genome/GRCh38/GRCh38.d1.vd1.fa"
BED_FILE="/data/renweijie/Software/SV_tools/GRIDSS/example/ENCFF356LFX.bed"
GRIPSS_JAR="/data/renweijie/anaconda3/envs/gridss/share/hmftools-gripss-2.4-0/gripss.jar"
OUT_ROOT="/data/renweijie/Software/SV_tools/GRIDSS/HCC1395"


# ==========================================
# 2. 循环读取样本列表
# ==========================================
while read SAMPLE_ID NORMAL_BAM TUMOR_BAM; do
    
    # 为当前样本创建专属的输出目录
    OUT_DIR="${OUT_ROOT}/${SAMPLE_ID}"
    mkdir -p ${OUT_DIR}
    
    N_SM=$(basename ${NORMAL_BAM} .bwa.dedup.bam)
    T_SM=$(basename ${TUMOR_BAM} .bwa.dedup.bam)

    # ---------------------------------------------------------
    # 步骤 1: 运行 GRIDSS
    # ---------------------------------------------------------
    gridss \
        -r ${REF} \
        -o ${OUT_DIR}/all_calls.vcf \
        -b ${BED_FILE} \
        -w ${OUT_DIR} \
        -t 8 \
        ${NORMAL_BAM} ${TUMOR_BAM}

    # 检查 GRIDSS 是否成功生成了结果文件，如果没有，跳过下一步
    if [ ! -f "${OUT_DIR}/all_calls.vcf" ]; then
        echo "  [错误] GRIDSS 运行失败，未生成 VCF！跳过此样本的 GRIPSS 过滤..."
        continue
    fi

    # ---------------------------------------------------------
    # 步骤 2: 运行 GRIPSS 过滤
    # ---------------------------------------------------------
    java -jar ${GRIPSS_JAR} \
        -sample ${T_SM} \
        -reference ${N_SM} \
        -ref_genome_version 38 \
        -ref_genome ${REF} \
        -vcf ${OUT_DIR}/all_calls.vcf \
        -output_dir ${OUT_DIR}

done < /data/renweijie/Software/SV_tools/GRIDSS/HCC1395/HCC1395_list.txt