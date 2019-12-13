%Simulink initialisieren
load_system ('calcAcceleration');
set_param('calcAcceleration','StartTime','0','StopTime','inf','MinStep','auto','MaxStep','1e-3');

init.state = 0;
accelData = sim('calcAcceleration');