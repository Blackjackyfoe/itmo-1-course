#!/usr/bin/env python3
from ev3dev.ev3 import *
import time


motorA = LargeMotor('outA')
motorA.position = timeNow = timeStart = 0

timeStart = time.time()


try:
    for i in range(-100,101,10):
        timeStart = time.time()
        f = open( str(i) + '.txt', 'w')
        f.write('0 ' + '0 ' + '0' + '\n')
        while True:
            timeNow = time.time() - timeStart
            if timeNow > 5:
                break
            else:
                motorA.run_direct(duty_cycle_sp = i)
                f.write( str(timeNow) + ' ' + str(motorA.position) + ' ' +str(motorA.speed) + '\n')
        motorA.stop(stop_action='brake')
        time.sleep(1)
finally:
    motorA.stop(stop_action = 'brake')
    f.close
