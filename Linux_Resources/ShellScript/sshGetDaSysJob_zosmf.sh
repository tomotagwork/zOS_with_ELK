#!/bin/sh

outputDir=/var/log/zos_da/
yyyymmdd=$(date '+%Y%m%d')
outputFile1=${outputDir}daSys_zosmf_${yyyymmdd}.txt
outputFile2=${outputDir}daJob_zosmf_${yyyymmdd}.txt

idx=0
ssh TAG@zosmf "REXX/getDaSysJob.sh" | while read line
do
	if [ ${idx} = 0 ]
	then
		echo ${line} >> ${outputFile1}
	else
		echo ${line} >> ${outputFile2}
	fi
	
	idx=$((idx+1))
done


