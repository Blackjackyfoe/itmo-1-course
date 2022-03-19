#!/usr/bin/env python3
from ev3dev.ev3 import *
import math
import time


def Uvalue(value):
    if (value < -100):
        return -100
    if (value > 100):
        return 100
    return value

def azimuthfind(x_current,y_current,x_goal,y_goal):
    if(x_goal != x_current) and (y_goal != y_current):
        return math.atan2((y_goal-y_current),(x_goal-x_current))
    elif (x_goal == x_current) and (y_goal > y_current):
        return (math.pi)/2
    elif (x_goal == x_current) and (y_goal < y_current):
        return -(math.pi)/2
    elif (x_goal > x_current) and (y_goal == y_current):
        return 0
    elif (x_goal < x_current) and (y_goal == y_current):
        return pi

current_time = 0
start_time = 0

f = open('lab-pid.txt','w')
f.write('0'+'0'+'\n')

motorR = LargeMotor('outA')
motorL = LargeMotor('outD')

motorR.position = 0
motorL.position = 0

theta = 0
azimuth = 0

left_angle = 0
right_angle = 0

#Цели, в которые следует робот
robotgoals = [(1, 1), (-1, 1), (-1, -1), (1, -1), (1, 1), (0, 0)]

x_current = 0
y_current = 0

x_goal = 0
y_goal = 0

#ширина колеса
r = 28
#ширина колеи
B = 160

#Какие-то коэфф
Ks = 6
Kr = 2

for points in robotgoals:
    x_goal = points[0]
    y_goal = points[1]

    #start_time = time.time()

    p_x = x_goal - x_current
    p_y = y_goal - y_current
    p_length = math.sqrt(p_x ** 2 + p_y ** 2)
    azimuth = azimuthfind(x_current, y_current, x_goal, y_goal)
    while (p_length>0.01):
        x_previous = x_current
        y_previous = y_current
        theta_previous = theta
        prev_left_angle = left_angle
        prev_right_angle = right_angle

        right_angle = motorR.position*(math.pi)/180
        left_angle = motorL.position * (math.pi) / 180
        diffRA = right_angle - prev_right_angle
        diffLA = left_angle - prev_left_angle

        x_current = x_previous + math.cos((diffRA+diffLA)/2)*r
        y_current = y_previous + math.sin((diffRA+diffLA)/2)*r
        theta = theta_previous + (diffRA-diffLA)*(r/B)

        p_length = math.sqrt(p_x ** 2 + p_y ** 2)

        Ustraight = Uvalue(Ks * p_length)
        Urotate = Uvalue(Kr * (azimuth - theta))

        U_leftmotor = Uvalue(Ustraight - Urotate)
        U_rightmotor = Uvalue(Ustraight + Urotate)

        motorR.run_direct(duty_cycle_sp = U_rightmotor)
        motorL.run_direct(duty_cycle_sp = U_leftmotor)

        f.write(str(x_current) + ' ' + str(y_current) + '\n')

motorR.run_direct(duty_cycle_sp=0)
motorL.run_direct(duty_cycle_sp=0)