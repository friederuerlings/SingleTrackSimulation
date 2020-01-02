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
%f�r obere Interpolationsgrenze




%% Erstellt das ggv Diagramm

load_system ('ggv_simu');

%ggv f�r Bremsen
set_param('ggv_simu','FastRestart','off');
init.state = 1;

set_param('ggv_simu','FastRestart','on');
for ggvVelocity = 0:init.deltaV:30
    ggvsim = sim('ggv_simu');
    ggv.Data_neg = vertcat(ggv.Data_neg, [ggvsim.a_x ggvsim.a_y ggvsim.velocity]);
end

%ggv f�r Beschleunigung
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

%F�gt dem Kurs den Radius zu jedem Punkt hinzu
%Alles �ber minimalem Radius bei vmax wird zu minimalem Radius bei vmax
%radiusLookUp wird f�r Simulink Look Up Table ben�tigt
[course] = addRadius(course);

%apexData enth�lt die Position und maximale Geschwindigkeit an allen Apex
[apexData, segments] = maxVelocityatApex(course);

%% Plottet das ggv-Diagramm

figure('Name', 'ggV Diagramm')
plot3(ggv.Data_pos(:,1),ggv.Data_pos(:,2),ggv.Data_pos(:,3),'*')
hold on
plot3(ggv.Data_neg(:,1),ggv.Data_neg(:,2),ggv.Data_neg(:,3),'*')
hold off
grid
title('ggV-Diagram')
xlabel('a_x [m/s�]')
ylabel('a_y [m/s�]')
zlabel('velocity [km/h]')

%% Erstellt Daten f�r Face Plot

vertices = [];
faces = [];

vertices = [ggv.Data_pos(1,:); ggv.Data_pos(2,:); ggv.Data_pos(7,:); ggv.Data_pos(8,:); ...
    ggv.Data_pos(2,:); ggv.Data_pos(3,:); ggv.Data_pos(8,:); ggv.Data_pos(9,:)];

faces = [1 2 4 3; 5 6 8 7];

cdata = [ggv.Data_pos(1,3); ggv.Data_pos(2,3); ggv.Data_pos(7,3); ggv.Data_pos(8,3); ...
    ggv.Data_pos(2,3); ggv.Data_pos(3,3); ggv.Data_pos(8,3); ggv.Data_pos(9,3)];

patch('Faces', faces, 'Vertices', vertices,'FaceVertexCData',cdata, 'FaceColor','interp')
grid







