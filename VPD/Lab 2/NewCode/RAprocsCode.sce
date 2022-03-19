results = read("C:\Users\User\Desktop\ITMO Study\VPD\Lab 2\Labs2TXTData\data30.txt", -1, 3)
angle = results(:,2)*%pi/180
time = results(:,1)
speed = results(:,3)*%pi/180

//Напряжение от силы тока с плюсом
AmperesPlus = read("C:\Users\User\Desktop\ITMO Study\VPD\Lab 2\Labs2TXTData\Amperes and Volts\AmperesPlus.txt", -1, 1)
VoltsPlus = read("C:\Users\User\Desktop\ITMO Study\VPD\Lab 2\Labs2TXTData\Amperes and Volts\VoltsPlus.txt", -1, 1)
//plot2d(AmperesPlus,VoltsPlus,2)


//Напряжение от силы тока с минусом
AmperesMinus = read("C:\Users\User\Desktop\ITMO Study\VPD\Lab 2\Labs2TXTData\Amperes and Volts\AmperesMinus.txt", -1, 1)
VoltsMinus = read("C:\Users\User\Desktop\ITMO Study\VPD\Lab 2\Labs2TXTData\Amperes and Volts\VoltsMinus.txt", -1, 1)
//plot2d(AmperesMinus,VoltsMinus,2)

//Аппроксимация для R
/*
aim = [AmperesPlus,VoltsPlus]
aim = aim'
att = [0]
deff('e=func(k,z)','e=z(2) -k(1) *z(1)')
[koeffs,errs]=datafit(func,aim,att)
AmperesPlus = [0;AmperesPlus]
U = AmperesPlus*koeffs


aim = [AmperesMinus,VoltsMinus]
aim = aim'
att = [0]
deff('e=func(k,z)','e=z(2) -k(1) *z(1)')
[koeffs2,errs]=datafit(func,aim,att)


//Графики аппроксимации
AmperesPlus = [0;AmperesPlus]
U = AmperesPlus*koeffs
plot2d(AmperesPlus,U,3)

AmperesMinus = [0;AmperesMinus]
U2 = AmperesMinus*koeffs2
plot2d(AmperesMinus,U2,3)
*/

aim = [AmperesPlus,VoltsPlus]
aim = aim'
att = [0]
deff('e=func(k,z)','e=z(2) -k(1) *z(1)')
[koeffs,errs]=datafit(func,aim,att)
AmperesPlus = [0;AmperesPlus]
U = AmperesPlus*koeffs


//Аппроксимация для E
Wnls = read("C:\Users\User\Desktop\ITMO Study\VPD\Lab 2\Labs2TXTData\Amperes and Volts\Wnls.txt", -1, 1)
WnlsMinus = read("C:\Users\User\Desktop\ITMO Study\VPD\Lab 2\Labs2TXTData\Amperes and Volts\WnlsMinus.txt", -1, 1)
//aim = [VoltsPlus,Wnls]
aim = [VoltsMinus,WnlsMinus]
aim = aim'
att = [1]
deff('e=func(k,z)','e=z(1)-z(2)*k(1)')
[koeffs,errs]=datafit(func,aim,att)

Mst = ((-1)*VoltsMinus(1)*0.52)/8.895
//plot2d(C.time, C.values, 3)
//plot2d(A.time,A.values,5)
//plot2d(time,speed,2)

plot2d(A.time,A.values,3)

legend('I(t)',"I(t)","I(t)",1)
g=get('current_axes');
g.x_label.text='Time,[sec]';
g.y_label.text='I,[Amperes]';























