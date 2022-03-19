results = read("Y:\Labs\LabsVPD\Laba 1\ExperimentData\100.txt", -1, 3)
angle = results(:,2)*%pi/180
time = results(:,1)
speed = results(:,3)*%pi/180

aim = [time, speed]
aim = aim'
deff('e=func(k,z)', 'e=z(2)-k(1)*(1-exp(-z(1)/k(2)))')
att = [15;0.08]
[koeffs,errs] = datafit(func,aim,att)
Wnls = koeffs(1)
Tm = koeffs(2)
Mst = (0.0023*Wnls)/Tm

modelSp = Wnls*(1-exp(-time/Tm))

//Все, что относится к модели,связанной с угловой скоростью в рад/с
plot2d(time, speed, 2)
plot2d(time,modelSp,3)
plot2d(B.time, B.values, 5)
legend('Experiment','$\theta(t)=\omega_{nls}+\omega_{nls}\,exp\bigl(-\frac{t}{T_m}\bigr)$','Model',4)
g=get('current_axes');
g.x_label.text='Time,[sec]';
g.y_label.text='Angular velocity';'Model',2




//Строительство графика Tm(Voltage)
//voltage = read("Y:\Labs\Labs VPD\Laba 1\Tm and Wlns\Voltage.txt", -1, 1)
//TmInfo = read("Y:\Labs\Labs VPD\Laba 1\Tm and Wlns\TmInfo.txt", -1, 1)
//plot2d(voltage,TmInfo)

//Строительство графика Wlns(Voltage)
//WlnsInfo = read("Y:\Labs\Labs VPD\Laba 1\Tm and Wlns\WlnsInfo.txt", -1, 1)
//plot2d(voltage,WlnsInfo)
