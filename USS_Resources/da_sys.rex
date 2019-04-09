/* REXX */
parse arg mydatetime

rc=isfcalls('ON')

/***************************/
/* Access the DA display   */
/***************************/
Address SDSF "ISFEXEC DA"
lrc=rc
if lrc<>0 then
  exit 20

HEADER = "TIME,SYSNAME,SPAGING,SCPU,SZAAP,SZIIP,SLCPU"
/* say HEADER */

/***********************************/
/* get common field within system  */
/***********************************/
LINE = MYDATETIME","SYSNAME.1","SPAGING.1","SCPU.1","SZAAP.1","SZIIP.1","SLCPU.1
say LINE

rc=isfcalls('OFF')
exit


