CONF_FILE="/etc/pbm.conf"
MOUNT_DIR="/mnt/pbm"

drive_parse () {
    local IFS= DLIST= DNUM=0

    IFS="
"
    
    echo "Scanning and mounting drives listed in ${CONF_FILE}..."

    for drv in `grep DRIVE ${CONF_FILE}`; do
        DP=`echo $drv | sed 's#DRIVE ##'`
        DF=`echo $DP | sed 's#.*/by-label/##'`

        e2fsck -y $DP

        RC=$?

        if [ $RC -eq 0 -o $RC -eq 1 ]; then
            mkdir -p ${MOUNT_DIR}/$DF
            mount -o $DP ${MOUNT_DIR}/$DF
        
            RC=$?
        fi

        if [ $RC -eq 0 -o $RC -eq 64 ]; then
            DLIST=${DP},${DLIST}
            let DNUM++
        fi

    done

    echo "done."
}

drive_parse
