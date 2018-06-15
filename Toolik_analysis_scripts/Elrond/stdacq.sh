#!/bin/sh

OUTDIR=/home/aurora
OUTPRE=""
OUTPOST="-TLK"

TSTAMP=`date +%Y%m%d-%H%M%S`

OUTNAME=$OUTPRE$TSTAMP$OUTPOST.data
OUTFULL=$OUTDIR/$OUTNAME
LOCKFULL=$OUTDIR/.ggsedatalock~$OUTNAME

# Lock data file
echo $$ > $LOCKFULL

echo "Writing data to $OUTFULL."
/usr/local/bin/acq_d -d 1 -N 65536 -x 30 -o $OUTFULL -m /tmp/rtd/latest_acquisition.data
#/usr/src/acq_d/acq_d -d 2 -N 98304 -x 21650 -o $OUTFULL -m /tmp/rtd/latest_acq$
#/usr/src/acq_d/acq_d -d 2 -N 245760 -x 3600 -o $OUTFULL -m /tmp/rtd/latest_acq$
# write 'header'
/usr/ggse/bin/addhead.py $OUTFULL

# Remove lock
rm $LOCKFULL
