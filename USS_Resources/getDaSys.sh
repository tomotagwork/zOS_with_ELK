#!/bin/sh

export PATH=$PATH:/u/tag/REXX:/u/tag/Shell
export TZ=JST-9
thisDateTime=$(date '+%Y/%m/%d %T')

#thisDate=$(date '+%Y%m%d')
#echo ${thisDateTime} / ${thisDate}

da_sys.rex ${thisDateTime}


