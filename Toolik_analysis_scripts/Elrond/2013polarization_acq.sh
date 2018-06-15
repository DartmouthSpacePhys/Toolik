#!/bin/sh

#####USER-DEFINED PARAMETERS###########
#N = number of samples per antenna per burst
N=98304
#TOTAL = total nmber of bursts
TOTAL=43005
#WAIT = NUMBER OF SECONDS BETWEEN BURSTS
WAIT=2.0
#FREQ = SAMPLING FREQUENCY IN HERTZ
FREQ=20000000
#NUM_CHANNELS = NUMBER OF CHANNELS
NUM_CHANNELS=2
#RANGE = 1 = +- 1V, 0 = +- 5V
RANGE=1111
########END USER-DEFINED PARAMETERS#####

OUTDIR=/daq 
OUTPRE=""
OUTPOST="-TLK"

TSTAMP=`date +%Y%m%d-%H%M%S`

OUTNAME=$OUTPRE$TSTAMP$OUTPOST.polarization.data
OUTFULL=$OUTDIR/$OUTNAME
LOCKFULL=$OUTDIR/.ggsedatalock~$OUTNAME

# Lock data file
echo $$ > $LOCKFULL

echo "Writing data to $OUTFULL."
#/usr/local/bin/acq_d -d 2 -N 98304 -x 42300 -o $OUTFULL -m /tmp/rtd/latest_acquisition.data
#/usr/src/acq_d/acq_d -d 2 -N 98304 -x 21650 -o $OUTFULL -m /tmp/rtd/latest_acq$
#/usr/src/acq_d/acq_d -d 2 -N 245760 -x 3600 -o $OUTFULL -m /tmp/rtd/latest_acq$
/usr/src/acq_d/acq_d -N $N -x $TOTAL -n $NUM_CHANNELS -F $FREQ -d $WAIT -r $RANGE -o $OUTFULL

# write 'header'
#/usr/ggse/bin/addhead.py $OUTFULL

# Remove lock
rm $LOCKFULL

#mv completed datafile to undone directory

mv $OUTFULL /daq/undone/
