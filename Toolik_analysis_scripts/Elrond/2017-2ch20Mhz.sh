#!/bin/sh
#  20-11-15 tkovacs added connectivity test and backup files rm -> mv
#  28-10-16 tkovacs changed OUTSYS to elros (defined in /etc/hosts)
#  24-08-24 shatch changed bkup strategy (now only keep .old, not .old and .oldold) due to insuff disk space when 2 channels are being recorded
INFILE=/daq/test-data-file

#OUTSYS=elros.hopto.org
OUTSYS=elros
OUTDIR=/data
OUTPRE=""
OUTPOST="-TLK-POL"

#TSTAMP=`date +%Y%m%d`
TSTAMP=`stat /daq/test-data-file | grep Modify | sed 's/Modify: //;s/\..* +0000//;s/-//g;s/://g;s/ /-/;'`

OUTNAME=${OUTPRE}${TSTAMP}${OUTPOST}.data
OUTFULL="${OUTDIR}/${OUTNAME}"

# check for connectivity
ping -c 1 ${OUTSYS} > /dev/null
while [ $? -ne 0 ]
do
 sleep 60
 ping -c 1 ${OUTSYS} > /dev/null
done

scp -i /home/aurora/.ssh/id_dsa -p ${INFILE} aurora@${OUTSYS}:${OUTFULL}

# save some backup files

#HEY: Can't afford to keep two datafiles anymore since we're recording two channels
#mv -f ${INFILE}.old ${INFILE}.oldold
mv -f ${INFILE} ${INFILE}.old
#rm ${INFILE}
