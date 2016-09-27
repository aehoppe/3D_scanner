import serial
import time
import os

ser = serial.Serial('/dev/ttyACM0', 9600)
data_csv = ''
read = True
ser.write('scan\n')
while read:
    line = ser.readline()
    if 'received' in line:
        continue
    if 'end' in line:
        read = False
        break
    data_csv += line
path = '~/POE/lab_2/'
with open('3d_scan.csv', 'w') as f:
    f.write(data_csv)
os.system('matlab -nodesktop -nosplash -r "scan_plot(); pause; exit;"')
