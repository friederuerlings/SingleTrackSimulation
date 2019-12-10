clear apexData ggV interpVel resultData segmentData segments vRLookUp

%Gesamtfahrzeug
init.m            = 250;  % in kg
init.cog_z        = 222;  % in mm
init.cog_x        = 51;   % in % von Vorne
init.wheelbase    = 1550; % in m
init.inertia_z    = 360;

%Aerodynamics
init.ae_A         = 1.2;  % in m²
init.c_L          = 3.16;
init.c_D          = 1.5;
init.aeroBalance  = 50;   % in % von Vorne

%Suspension
init.my           = 1.3;

%Powertrain
init.P_engine     = 45; % in kW
init.AllWD        = 1;

%Physikalische Größen
init.g = 9.81;
init.rhoAir = 1.2;

%Simulation
init.deltaV       = 5;    % in m/s
init.ptDistance   = 0.1;  % in Meter
init.deltaS       = 0.01; % in Meter

%% weitere Größen berechnen

init.l_cog_front = (init.cog_x/100) * init.wheelbase;
init.l_cog_rear  = init.wheelbase - init.l_cog_front;
init.l_ae_front = (init.aeroBalance/100) * init.wheelbase;
init.l_ae_rear = init.wheelbase - init.l_ae_front;


%% Lap Time Simulation durchführen

calcggV
calcSegments






