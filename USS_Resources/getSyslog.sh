#!/bin/sh

export TZ=JST-9

### REXX program to get SYSLOG
rexxFile=/u/tag/REXX/syslog.rex

#outputFile=$1
outputFile=syslog.txt
tempFile=previousDateTime.txt

toDate=$(date '+%Y/%m/%d')
toTime=$(date '+%T')

if [[ -e ${outputFile} ]]
then
        rm ${outputFile}
fi

if [[ -e ${tempFile} ]]
then
        read fromDate fromTime < ${tempFile}
else
        fromDate=${toDate}
        fromTime=00:00:00
fi

#echo From: ${fromDate} ${fromTime}.01
#echo To:   ${toDate} ${toTime}.00

### Get Syslog
${rexxFile} ${fromDate} ${fromTime}.01 ${toDate} ${toTime}.00 ${outputFile} > /dev/null 2>&1
rc=$?

### Error Handling
if [ ${rc} -gt 0 ]; then
  # do nothing
  # echo Error!: ${rc}
  rm ${outputFile}
  exit 1
fi

### Output
echo ${toDate} ${toTime} > ${tempFile}
cat ${outputFile}
rm ${outputFile}

exit 0

