#!/usr/bin/env python3
from ev3dev.ev3 import *

import time
mA = LargeMotor('outA')
mD = LargeMotor('outD')
sensor = UltrasonicSensor('in3')
sensor.mode = 'US-DIST-CM'

dist = 400
s = 0
e = 360
eprev = edef = 0
U=0
dt = 0
mA.position = current_time = start_time = 0
f = open('data-move.txt','w')
f.write('0'+'0'+'\n')
start_time = time.time()
kd=0.75
ki=0.05
kp=10
//плохие значения
tprev = 0

while True:
    eprev = e
    if dt == 0:
        dt = 0.0000001
    else:
        dt = current_time - tprev
    e=dist-sensor.value()
    s+=e*dt
    edef=(e-eprev)/dt
    U=-(kp*e+ki*s+kd*edef)
    if U>100:
        U = 100
    if U < -100:
        U = -100
    mA.run_direct(duty_cycle_sp=U)
    mD.run_direct(duty_cycle_sp=U)
    tprev = current_time
    current_time = time.time()-start_time
    if current_time > 15:
        break
    else:
        f.write(str(current_time)+ ' ' + str(sensor.value()) + '\n')

mA.stop(stop_action = 'brake')
mB.stop(stop_action = 'brake')
f.close
