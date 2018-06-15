#!/bin/bash

stdproc_main() {

    echo -n $$ > /var/lock/ggse_stdproc
    
    for file in /data/*-TLK.data; do
        
        if [ ! -e /data/.ggsedatalock~${file##*/} -a ! -e /data/.ggsefftlock~${file##*/} ]; then
            echo -n $$ > /data/.ggsefftlock~${file##*/}
            
            /usr/ggse/bin/process.py $file
            
            if [ $? == 0 ] ; then
                mv $file /data/processed/
            fi

            rm /data/.ggsefftlock~${file##*/}
        fi
    
    done
    
    rm /var/lock/ggse_stdproc
}

if [ -e /var/lock/ggse_stdproc ]; then
    pid=`cat /var/lock/ggse_stdproc`
    extant=`ps -p $pid | grep proc`
    if [ ! -z "$extant" ]; then
        echo "stdproc.sh: lockfile found, stdproc already running."
        exit 3
    else
        echo "stdproc.sh: lockfile found, but no process; deleting."
        rm /var/lock/ggse_stdproc
        stdproc_main
    fi
else
    stdproc_main
fi
