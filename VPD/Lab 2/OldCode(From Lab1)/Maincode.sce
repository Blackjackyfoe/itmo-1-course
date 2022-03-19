results = read("C:\Users\User\Desktop\ITMO Study\VPD\Lab 2\Labs2TXTData\data100.txt", -1, 3)
angle = results(:,2)*%pi/180
time = results(:,1)
speed = results(:,3)*%pi/180


aim = [time, angle]
aim = aim'
deff('e=func(k,z)','e=z(2)-k(1)*(z(1)-k(2)*(1-exp(-z(1)/k(2))))')
att = [-15;0.06]
[koeffs,errs] = datafit(func,aim,att)
Wnls = koeffs(1)
Tm = koeffs(2)
Mst = (0.0023*Wnls)/Tm
disp(Wnls)
model = Wnls*(time-Tm*(1-exp(-time/Tm)))

//Все, что относится к модели, связанной с углом поворота мотора в рад
plot2d(time, angle, 2)
plot2d(time,model,3)
//plot2d(A.time, A.values, 5)

legend('Experiment','Model',1)
g=get('current_axes');
g.x_label.text='Time,[sec]';
g.y_label.text='Angle,[rad]';

//Строительство графика Tm(Voltage)
//voltage = read("Y:\Labs\LabsVPD\Laba 1\TmWlnsMst\WithSP\Voltage.txt", -1, 1)
//TmInfo = read("Y:\Labs\LabsVPD\Laba 1\TmWlnsMst\WithSP\TmInfo.txt", -1, 1)
//plot2d(voltage,TmInfo)

Строительство графика Wlns(Voltage)
WlnsInfo = read("Y:\Labs\LabsVPD\Laba 1\TmWlnsMst\WithSP\WlnsInfo.txt", -1, 1)
plot2d(voltage,WlnsInfo)

