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
        -o /data/renweijie/Software/SV_tools/GRIDSS/HCC1395/EA_N_1/all_calls.vcf \
        -b /data/renweijie/Software/SV_tools/GRIDSS/example/ENCFF356LFX.bed \
        /data/share/Genomics_datasets/HCC1395/WGS/WGS_EA_N_1.bwa.dedup.bam \
        /data/share/Genomics_datasets/HCC1395/WGS/WGS_EA_T_1.bwa.dedup.bam

