/* REXX */
/*--------------------------------------------------------*/
/* Arg1: date  (yyyy/mm/dd)                               */
/* Arg2: time  (hh:mm:ss)                                 */
/* Arg3: output file (xxx.txt)                            */
/*--------------------------------------------------------*/

parse arg mydate mytime output_file


rc=isfcalls('ON')

/***************************/
/* Access the DA display   */
/***************************/
Address SDSF "ISFEXEC DA"
lrc=rc
if lrc<>0 then
  exit 20

/***************************/
/* for SYSTEM              */
/***************************/
call stream output_file, 'C','CLEARFILE' 
rc = charout(output_file,,)

HEADER = "TIME,SYSNAME,SPAGING,SCPU,SZAAP,SZIIP,SLCPU"
/* rc = charout(output_file, HEADER,) */

LINE = MYDATE" "MYTIME","SYSNAME.1","SPAGING.1","SCPU.1","SZAAP.1","SZIIP.1","SLCPU.1
LINE = LINE || ESC_N
rc = charout(output_file, LINE,)

/***************************/
/* for JOB                 */
/***************************/

HEADER = "TIME,JNAME,STEPN,PROCS,JTYPE,JNUM,JOBID,OWNERID,JCLASS"
HEADER = HEADER",POS,DP,REAL,PAGING,EXCPRT,CPUPR,ASID,ASIDX,EXCP"
HEADER = HEADER",CPU,SWAPR,STATUS,SYSNAME,WORKLOAD,SRVCLASS"
HEADER = HEADER",PERIOD,RESGROUP,SERVER,QUIESCE,ECPU,ECPUPR,CPUCRIT"
HEADER = HEADER",STORCRIT,RPTCLASS,MEMLIMIT,TRANACT,TRANRES,SPIN,SECLABEL"
HEADER = HEADER",GCPTIME,ZAAPTIME,ZAAPCPTM,GCPUSE,ZAAPUSE"
HEADER = HEADER",PROMOTED,ZAAPNTIM,ZIIPTIME,ZIIPCPTM,ZIIPNTIM,ZIIPUSE"
HEADER = HEADER",IOPRIOGRP,JOBCORR"
/* rc = charout(output_file, HEADER,) */

/* Loop for all target jobs *****************************/

do ix=1 to JNAME.0
  LINE = MYDATE" "MYTIME","JNAME.ix","STEPN.ix","PROCS.ix","JTYPE.ix","JNUM.ix","JOBID.ix","OWNERID.ix","JCLASS.ix
  LINE = LINE","POS.ix","DP.ix","REAL.ix","PAGING.ix","EXCPRT.ix","CPUPR.ix","ASID.ix","ASIDX.ix","EXCP.ix
  LINE = LINE","CPU.ix","SWAPR.ix","STATUS.ix","SYSNAME.ix","WORKLOAD.ix","SRVCLASS.ix
  LINE = LINE","PERIOD.ix","RESGROUP.ix","SERVER.ix","QUIESCE.ix","ECPU.ix","ECPUPR.ix","CPUCRIT.ix
  LINE = LINE","STORCRIT.ix","RPTCLASS.ix","MEMLIMIT.ix","TRANACT.ix","TRANRES.ix","SPIN.ix","SECLABEL.ix
  LINE = LINE","GCPTIME.ix","ZAAPTIME.ix","ZAAPCPTM.ix","GCPUSE.ix","ZAAPUSE.ix
  LINE = LINE","PROMOTED.ix","ZAAPNTIM.ix","ZIIPTIME.ix","ZIIPCPTM.ix","ZIIPNTIM.ix","ZIIPUSE.ix
  LINE = LINE","IOPRIOGRP.ix","JOBCORR.ix
  /*say LINE*/
  LINE = LINE || ESC_N
  rc = charout(output_file, LINE,)
end

call stream output_file, 'C', 'CLOSE'

rc=isfcalls('OFF')
exit 0


