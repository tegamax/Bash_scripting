
Scripting by Example



Monitoring CPU utilization Part1
********************************


#!/bin/bash
do
        sleep 60
        USAGE=`ps -eo pcpu,pid -o conn= | sort -k1 -n -r | head -1 | awk '{ print $1}'`
        USAGE=${USAGE%.*}
        PID=`ps -eo pcpu,pid -o conn= | sort -k1 -n -r | head -1 | awk '{ print $2 }'`
        PNAME=`ps -eo pcpu,pid -o conn | sort -k1 -n -r | head -1 | awk '{ print $3 }'`
        if [ $USAGE -gt 80 ]
        then

            USAGE1=$USAGE 
            PID1=$PID
            PNAME1=$PNAME
            sleep 7
            USAGE2=`ps -eo pcpu,pid -o conn= | sort -k1 -n -r | head -1 | awk '{ print $1 }'`
            USAGE2=${USAGE2%.*}
            PID2=`ps -eo pcpu,pid -o conn= | sort -k1 -n -r | head -1 | awk '{ print $2 }'`
            PNAME2=`ps -eo pcpu,pid -o conn= | sort -k1 -n -r | head -1 | awk '{ print $3 }'`
            [ $USAGE2 -gt 80 ] && [ $PID1 = $PID2 ] && \
                mail -s "CPU load of $PNAME is above 80%" root@blah.com < .
        fi
done




