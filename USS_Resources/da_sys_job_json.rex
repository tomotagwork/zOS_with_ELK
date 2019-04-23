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

DATETIME=MYDATE||" "||MYTIME

/***************************/
/* for SYSTEM              */
/***************************/
call stream output_file, 'C','CLEARFILE' 
rc = charout(output_file,,)


LINE = "{"||jsonStr("RecType", "SYSTEM")||","||jsonStr("date_time",DATETIME)||","||jsonStr("sysname",SYSNAME.1)||","||jsonNum("spaging",SPAGING.1)||","
LINE = LINE||jsonNum("scpu", SCPU.1)||","||jsonNum("szaap",SZAAP.1)||","||jsonNum("sziip",SZIIP.1)||","||jsonNum("slcpu",SLCPU.1)||"}"
LINE = LINE || ESC_N

rc = charout(output_file, LINE,)

/***************************/
/* for JOB                 */
/***************************/


/* Loop for all target jobs *****************************/

do ix=1 to JNAME.0
  LINE = "{"||jsonStr("RecType", "JOB")||","||jsonStr("date_time",DATETIME)||","||jsonStr("sysname",SYSNAME.ix)||","
  LINE = LINE||jsonStr("jname",JNAME.ix)||","||jsonStr("stepn",STEPN.ix)||","||jsonStr("procs",PROCS.ix)||","||jsonStr("jtype",JTYPE.ix)||","||jsonStr("jobid",JOBID.ix)||","||jsonStr("ownerid",OWNERID.ix)||","||jsonStr("jclass",JCLASS.ix)||","
  LINE = LINE||jsonStr("pos",POS.ix)||","||jsonStr("dp",DP.ix)||","||jsonNum("real",REAL.ix)||","||jsonNum("paging",PAGING.ix)||","||jsonNum("excprt",EXCPRT.ix)||","||jsonNum("cpupr",CPUPR.ix)||","||jsonNum("asid",ASID.ix)||","||jsonStr("asidx",ASIDX.ix)||","||jsonNum("excp",EXCP.ix)||","
  LINE = LINE||jsonNum("cpu",CPU.ix)||","||jsonStr("swapr",SWAPR.ix)||","||jsonStr("status",STATUS.ix)||","||jsonStr("workload",WORKLOAD.ix)||","||jsonStr("srvclass",SRVCLASS.ix)||","
  LINE = LINE||jsonNum("period",PERIOD.ix)||","||jsonStr("resgroup",RESGROUP.ix)||","||jsonStr("server",SERVER.ix)||","||jsonStr("quiesce",QUIESCE.ix)||","||jsonNum("ecpu",ECPU.ix)||","||jsonNum("ecpupr",ECPUPR.ix)||","||jsonStr("cpucrit",CPUCRIT.ix)||","
  LINE = LINE||jsonStr("storcrit",STORCRIT.ix)||","||jsonStr("rptclass",RPTCLASS.ix)||","||jsonStr("memlimit",MEMLIMIT.ix)||","||jsonStr("tranact",TRANACT.ix)||","||jsonStr("tranres",TRANRES.ix)||","||jsonStr("spin",SPIN.ix)||","||jsonStr("seclabel",SECLABEL.ix)||","
  LINE = LINE||jsonNum("gcptime",GCPTIME.ix)||","||jsonNum("zaaptime",ZAAPTIME.ix)||","||jsonNum("zaapcptm",ZAAPCPTM.ix)||","||jsonNum("gcpuse",GCPUSE.ix)||","||jsonNum("zaapuse",ZAAPUSE.ix)||","
  LINE = LINE||jsonStr("promoted",PROMOTED.ix)||","||jsonNum("zaapntim",ZAAPNTIM.ix)||","||jsonNum("ziiptime",ZIIPTIME.ix)||","||jsonNum("ziipcptm",ZIIPCPTM.ix)||","||jsonNum("ziipntim",ZIIPNTIM.ix)||","||jsonNum("ziipuse",ZIIPUSE.ix)||","
  LINE = LINE||jsonStr("iopriogrp",IOPRIOGRP.ix)||","||jsonStr("jobcorr",JOBCORR.ix)||"}"
  /*say LINE*/
  LINE = LINE || ESC_N
  rc = charout(output_file, LINE,)
end

call stream output_file, 'C', 'CLOSE'

rc=isfcalls('OFF')
exit 0


/******************************/
/* function for JSON format   */
/******************************/
jsonItem:
 key=arg(1)
 value=arg(2)
 if datatype(value, "N")=1 then do
  /* say value " is Number" */
  result = """"||key||""":"||value
 end
 else do
  /* say value "is not Number" */
  result = """"||key||""":"""||value||""""
 end
 return result

jsonNum:
 key=arg(1)
 value=arg(2)
 if value="" then do
  value=0
 end
 result = """"||key||""":"||value
 return result

jsonStr:
 key=arg(1)
 value=arg(2)
 result = """"||key||""":"""||value||""""
 return result
