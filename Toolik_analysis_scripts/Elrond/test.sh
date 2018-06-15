#!/bin/sh

OUTDIR=/data 
OUTPRE=""
OUTPOST="-TLK"

TSTAMP=`date +%Y%m%d-%H%M%S`

OUTNAME=$OUTDIR/$OUTPRE$TSTAMP$OUTPOST.data

echo "Writing data to $OUTNAME." >> /root/test.sh.out
echo /usr/local/bin/acq_d -d 1 -N 98304 -x 84600 -o $OUTNAME >> /root/test.sh.out
