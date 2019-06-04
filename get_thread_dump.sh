#!/bin/bash
PID=$1
if [ -z ${PID} ]; then
        echo 'not input process id'
        echo ' ex) ./get_thread_dump.sh 5990'
        exit
fi
rm -f ${PID}*.txt
top -b -d 1 -n 1 -Hp ${PID} > ${PID}_top.txt
function getThread()
{
        local TIME=`date +'%Y%m%d_%H%M%S'`
        pidstat -t -p ${PID} > ${PID}_${TIME}_pidstat.txt
        ps -mo pid,lwp,pcpu ${PID} > ${PID}_${TIME}_ps.txt
        jstack -l ${PID} > ${PID}_${TIME}_jstack.txt
}
function printTime()
{
        local TIME=`date +'%Y%m%d_%H%M%S'`
        echo ${TIME}
}
for ((i=0;i<5;i++))
do
        getThread
        echo $((${i}+1)) ' loop success'
        sleep 5s
done
