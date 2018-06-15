#!/bin/sh

OUTDIR=/daq
OUTPRE=""
OUTPOST="-TLK"

TSTAMP=`date +%Y%m%d-%H%M%S`

OUTNAME=$OUTPRE$TSTAMP$OUTPOST.data
OUTFULL=$OUTDIR/$OUTNAME
LOCKFULL=$OUTDIR/.ggsedatalock~$OUTNAME

# Lock data file
echo $$ > $LOCKFULL

echo "Writing data to $OUTFULL."
/usr/src/acq_c/acq_c -d 2 -X 1373291 -n 1 -F 20000000 -r 1 -o $OUTFULL -m /tmp/rtd/latest_acquisition.data

#process_continuous.sh $OUTFULL
#mv $OUTFULL /data/
# write 'header'
#/usr/ggse/bin/addhead.py $OUTFULL

# Remove lock
rm $LOCKFULL

process_continuous.sh $OUTFULL

