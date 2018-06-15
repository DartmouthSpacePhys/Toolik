#!/bin/sh

OUTDIR=/daq
OUTPRE=""
OUTPOST="-TLK"

TSTAMP=`date +%Y%m%d-%H%M%S`

OUTNAME=$OUTPRE$TSTAMP$OUTPOST.data
OUTFULL=$OUTDIR/$OUTNAME
LOCKFULL=$OUTDIR/.ggsedatalock~$OUTNAME


echo "Writing data to $OUTFULL."
/usr/src/acq_c/acq_c  -n 4 -X 2197265 -F 10000000 -o $OUTFULL

