# GRIDSS
## 一、通过conda安装 GRIDSS
### 1.根据官方命令安装[GRIDSS](https://github.com/PapenfussLab/gridss/blob/master/QuickStart.md#install-grid)

        conda create -n gridss gridss
        conda activate gridss
### 2.本地下载GRIDSS并上传到服务器
* 进入软件目录

        cd /data/renweijie/Software/SV_tools/
* 解压缩

        unzip gridss-master.zip
* 将解压缩的文件重命名

        mv gridss-master GRIDSS
## 二、运行GRIDSS
### 1.准备命令所需的bed文件
在使用人类测序数据时，推荐使用 ENCODE 计划提供的排除列表文件
* 文件路径

        /data/renweijie/Software/SV_tools/GRIDSS/example/ENCFF356LFX.bed
### 2.运行

        gridss \
        -r /data/share/Genomics_datasets/HCC1395/reference_genome/GRCh38/GRCh38.d1.vd1.fa \
        -o /data/renweijie/Software/SV_tools/GRIDSS/HCC1395/EA_T_1/all_calls.vcf \
        -b /data/renweijie/Software/SV_tools/GRIDSS/example/ENCFF356LFX.bed \
        /data/share/Genomics_datasets/HCC1395/WGS/WGS_EA_N_1.bwa.dedup.bam \
        /data/share/Genomics_datasets/HCC1395/WGS/WGS_EA_T_1.bwa.dedup.bam
### 3.安装 [GRIPSS](https://bioconda.github.io/recipes/hmftools-gripss/README.html) 过滤体细胞突变
* 安装 GRIPSS

        conda install hmftools-gripss
* 找安装在conda里面的 jar包

        find $CONDA_PREFIX -name "gripss.jar"
* 找到的路径

        /data/renweijie/anaconda3/envs/gridss/share/hmftools-gripss-2.4-0/gripss.jar
* 看GRIPSS的版本及参数 v2.4

        gripss -help
### 4.运行 GRIPSS

        java -jar /data/renweijie/anaconda3/envs/gridss/share/hmftools-gripss-2.4-0/gripss.jar \
        -sample WGS_EA_T_1 \
        -reference WGS_EA_N_1 \
        -ref_genome_version 38 \
        -ref_genome /data/share/Genomics_datasets/HCC1395/reference_genome/GRCh38/GRCh38.d1.vd1.fa \
        -vcf /data/renweijie/Software/SV_tools/GRIDSS/HCC1395/EA_T_1/all_calls.vcf \
        -output_dir /data/renweijie/Software/SV_tools/GRIDSS/HCC1395/EA_T_1
### 5.[脚本](https://github.com/rwj0621/GRIPSS/blob/main/HCC1395_ALL_samples_run_SV.sh)批量处理
* 创建[样本路径列表](https://github.com/rwj0621/GRIPSS/blob/main/HCC1395_list.txt)
* 创建批量运行脚本
* 运行脚本

        chmod +x /data/renweijie/Software/SV_tools/GRIDSS/HCC1395/HCC1395_ALL_samples_run_SV.sh
        cd /data/renweijie/Software/SV_tools/GRIDSS/HCC1395/
        nohup ./HCC1395_ALL_samples_run_SV.sh > batch_pipeline_final.log 2>&1 &
        
        


