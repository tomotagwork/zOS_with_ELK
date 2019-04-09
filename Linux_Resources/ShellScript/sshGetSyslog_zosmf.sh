#!/bin/sh

outputDir=/var/log/zos_syslog/
yyyymmdd=$(date '+%Y%m%d')
outputFile=${outputDir}syslog_zosmf_${yyyymmdd}.txt

ssh TAG@zosmf "REXX/getSyslog.sh" >> ${outputFile}

