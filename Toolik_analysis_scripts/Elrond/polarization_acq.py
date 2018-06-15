#!/usr/bin/env python
#!/usr/bin/env python
import serial, sys, os, subprocess

#open the serial port
ser = serial.Serial('/dev/ttyS0')

#Set the DTR to the polarization state
ser.setDTR(True)

#Call the acqusition program
subprocess.call(['/usr/local/bin/polarization_acq.sh'],cwd='/usr/local/bin',shell=True)

#close the serial port when the acqusition is complete
ser.close()

print "Program finished!"
