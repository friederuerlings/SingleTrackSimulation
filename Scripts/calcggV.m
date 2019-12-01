warning off 'MATLAB:singularMatrix'

ggV.Data_pos = [];
ggV.Data_neg = [];
ggV.LookUp_pos = [];
ggV.LookUp_neg = []; 
vRLookUp = [];

%Maximale Geschwindigkeit berechnen
load_system ('maxVelocity')
maxVsimu = sim('maxVelocity');
init.maxV = max(maxVsimu.maxV);
clear maxVsimu

%Initialisierung um max Beschleunigung zu ermitteln
%f�r obere Interpolationsgrenze
ggV.simu_stopTime = 0;
ggV.simu_stepSize = 1;
ggV_v = init.maxV;

load_system ('ggV_simu')

ggVsim = sim('ggV_simu');
ggV.interpMax = ceil(ggVsim.a_x_neg) * -1;

%Initialisierung f�r ggV Simulation
ggV.simu_stopTime = pi/2;
ggV.simu_stepSize = (pi/2)/10;

%% Erstellt das ggV Diagramm

%Erstellt die Look Up Tables f�r a_x, a_y bei jeweiliger Geschwindigkeit
    for ggV_v = 0:init.deltaV:init.maxV
        ggVsim = sim('ggV_simu');
        ggV.LookUp_pos = horzcat(ggV.LookUp_pos, interp1(ggVsim.a_y,ggVsim.a_x_pos,[0:1:ggV.interpMax]'));
        ggV.LookUp_neg = horzcat(ggV.LookUp_neg, interp1(ggVsim.a_y,ggVsim.a_x_neg,[0:1:ggV.interpMax]'));
        ggV.Data_pos = vertcat(ggV.Data_pos, [ggVsim.a_x_pos, ggVsim.a_y, ggVsim.velocity]);
        ggV.Data_neg = vertcat(ggV.Data_neg, [ggVsim.a_x_neg ggVsim.a_y ggVsim.velocity]);
        vRLookUp = [vRLookUp; ggVsim.maxRadiusForVelocity(1:1)];
    end

clear ggV_v


%Erstellt LookUp f�r velocity und radius
%Ben�tigt um maximale Geschwindigkeit am Apex zu ermitteln
vRLookUp = [vRLookUp, [0:init.deltaV:init.maxV]'];

%F�gt dem Kurs den Radius zu jedem Punkt hinzu
%Alles �ber minimalem Radius bei vmax wird zu minimalem Radius bei vmax
course = addRadius(course);

%apexData enth�lt die Position und maximale Geschwindigkeit an allen Apex
[apexData, segments] = maxVelocityatApex(course, vRLookUp);

%% Plottet das ggV-Diagramm
figure()
plot3(ggV.Data_pos(:,1),ggV.Data_pos(:,2),ggV.Data_pos(:,3)*3.6,'*')
hold on
plot3(ggV.Data_neg(:,1),ggV.Data_neg(:,2),ggV.Data_neg(:,3)*3.6,'*')
hold off
grid
title('ggV-Diagram')
xlabel('a_x [m/s�]')
ylabel('a_y [m/s�]')
zlabel('velocity [km/h]')

