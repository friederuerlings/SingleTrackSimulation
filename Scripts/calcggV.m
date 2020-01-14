warning off 'MATLAB:singularMatrix'

ggv.Data_pos = [];
ggv.Data_neg = [];

%Maximale Geschwindigkeit berechnen
init.state = 0;
load_system ('maxVelocity')
set_param('maxVelocity','FastRestart','on');
maxVsimu = sim('maxVelocity');
init.maxV = max(maxVsimu.maxV);
clear maxVsimu

%Initialisierung um max Beschleunigung zu ermitteln
%für obere Interpolationsgrenze




%% Erstellt das ggv Diagramm

load_system ('ggv_simu');

%ggv für Bremsen
set_param('ggv_simu','FastRestart','off');
init.state = 1;

set_param('ggv_simu','FastRestart','on');
for ggvVelocity = 0:init.deltaV:30
    ggvsim = sim('ggv_simu');
    ggv.Data_neg = vertcat(ggv.Data_neg, [ggvsim.a_x ggvsim.a_y ggvsim.velocity]);
end

%ggv für Beschleunigung
set_param('ggv_simu','FastRestart','off');
init.state = 0;

set_param('ggv_simu','FastRestart','on');
for ggvVelocity = 0:init.deltaV:30
    ggvsim = sim('ggv_simu');
    ggv.Data_pos = vertcat(ggv.Data_pos, [ggvsim.a_x ggvsim.a_y ggvsim.velocity]);
end
set_param('ggv_simu','FastRestart','off');

clear ggv_v ggvsim

%% Radius und Apex Berechnung

%Fügt dem Kurs den Radius zu jedem Punkt hinzu
%Alles über minimalem Radius bei vmax wird zu minimalem Radius bei vmax
%radiusLookUp wird für Simulink Look Up Table benötigt
[course] = addRadius(course);

%apexData enthält die Position und maximale Geschwindigkeit an allen Apex
[apexData, segments] = maxVelocityatApex(course);











