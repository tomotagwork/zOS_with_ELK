#!/bin/sh

outputDir=/var/log/zos_da_json/
yyyymmdd=$(date '+%Y%m%d')
outputFile=${outputDir}da_eplexa_${yyyymmdd}.txt

ssh CICS004@eplexa "REXX/getDaSysJobJson.sh"  >> ${outputFile}


