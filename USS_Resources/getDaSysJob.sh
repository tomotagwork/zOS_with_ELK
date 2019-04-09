#!/bin/sh

export PATH=$PATH:/u/tag/REXX:/u/tag/Shell
export TZ=JST-9
thisDateTime=$(date '+%Y/%m/%d %T')

#thisDate=$(date '+%Y%m%d')
#echo ${thisDateTime} / ${thisDate}

outputFile=daSysJob_temp$(date '+%Y%m%d%H%M%S').txt

#get DA panel info
da_sys_job.rex ${thisDateTime} ${outputFile} > /dev/null 2>&1
rc=$?

### Error Handling
if [ ${rc} -gt 0 ]; then
  # do nothing
  # echo Error!: ${rc}
  rm ${outputFile}
  exit 1
fi


### Output
cat ${outputFile}
rm ${outputFile}

exit 0






