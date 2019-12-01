clear apexData ggV interpVel resultData segmentData segments vRLookUp

%Gesamtfahrzeug
init.m            = 250;  % in kg
init.ae_A         = 1.2;  % in m²
init.CoG_z        = 222;  % in mm
init.CoG_x        = 51;   % in % hinten
init.wheelbase    = 1550; % in mm

%Aerodynamics
init.c_L          = 2.85;
init.c_D          = 1.3;
init.aeroBalance  = 60;   % in % hinten

%Suspension
init.my           = 1.3;

%Powertrain
init.P_engine     = 40; % in kW

%Physikalische Größen
init.g = 9.81;
init.rhoAir = 1.2;

%Simulation
init.deltaV       = 5;    % in m/s
init.ptDistance   = 0.5;  % in Meter
init.deltaS       = 0.01; % in Meter

%% Lap Time Simulation durchführen

calcggV
calcSegments






