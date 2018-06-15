#!/bin/sh
# collect 4 channels ( -n 4 ) for 10800 seconds (-s 10800 ) at 10Ms/s ( -F 10000000 )
OUTDIR=/data1
OUTPRE=""
OUTPOST="-TLK-INT"

TSTAMP=`date +%Y%m%d-%H%M%S`

OUTNAME=$OUTPRE${TSTAMP}${OUTPOST}.data
OUTFULL=$OUTDIR/$OUTNAME

echo "Writing data to $OUTFULL."
echo /usr/local/src/acq_c/acq_c -r 0000  -n 4 -s 10800 -F 10000000 -o $OUTFULL
/usr/local/src/acq_c/acq_c -r 0000 -n 4 -s 10800 -F 10000000 -o $OUTFULL > acq.out &

