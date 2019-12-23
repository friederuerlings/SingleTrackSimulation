clear apexData ggV interpVel resultData segmentData segments apexData

%Gesamtfahrzeug
init.m            = 165 + 70;  % in kg
init.cog_z        = 0.267;  % in m
init.cog_x        = 51.7;   % in % von Vorne
init.wheelbase    = 1.550; % in m
init.inertia_z    = 60; %in kg*m²

%Aerodynamics
init.ae_A           = 1;  % in m²
init.c_L            = 3.16;
init.c_D            = 1.5;
init.aeroBalance    = 50;   % in % von Vorne
init.ae_z           = 0.267; % in m
init.DRS_active     = 0;
init.c_L_DRS        = 2.35;
init.c_D_DRS        = 0.99;

%Suspension
init.my           = 1.5;

%Powertrain
init.P_engine          = 47; % in kW
init.AllWD             = 0;
init.Heizwert_fuel     = 6.3; %in kWh/L
init.engine_efficiency = 0.3; %in %

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
init.hebel_drag = init.ae_z - init.cog_z;


%% Lap Time Simulation durchführen



calcggV
Acceleration
calcSegments
evaluation







