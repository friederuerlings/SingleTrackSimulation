clear segmentData
warning off 'Simulink:blocks:SquareRootOfNegative'

%Initialisiert die Größen, welche im Simulink Modell berechnet und
%ausgegeben werden. Größen wie Zeit, Sprit etc. die aufaddiert werden
%werden mit 0 initialisert, Vektoren wie distance etc. werden mit leerer
%Menge [] initialisiert
%Distance immer an erster Stelle lassen!
resultVarsVektor = ["distance"; "velocity"; "a_x"; "a_y"; "radius"; "drs_open"; "F_x_Front"];
resultVarsSum = ["tout"; "fuel"];
resultData = initResultData(resultVarsVektor, resultVarsSum);
clear resultVarsVektor resultVarsSum

%Apex Velocity Backup 
apexData.velocity(:,2) = apexData.velocity(:,1);

%Track umdrehen für Braking Simulation
flippedLocs = (length(course(:,3)) + 1) - flip(apexData.locs(:,1));
flippedCourse = flip(course);
flippedVel = flip(apexData.velocity(:,1));

%Simulink initialisieren
load_system ('segmentCalc');
set_param('segmentCalc','FastRestart','off');
set_param('segmentCalc','StartTime','0','StopTime','inf','FixedStep','1e-3');
% set_param('segmentCalc','StartTime','0','StopTime','inf','MinStep','auto','MaxStep','1e-3');
set_param('segmentCalc','FastRestart','on');
set_param('segmentCalc','AlgebraicLoopSolver','LineSearch');
% set_param('segmentCalc','AlgebraicLoopSolver','TrustRegion');


%% max Apex Velocity über Braking 

init.state = 1; % Braking

for n = 1:1:length(flippedLocs)-1
    
    currentDistance = (flippedLocs(n) - 1) * init.ptDistance;
    apexVelocity = flippedVel(n);
    stoppingDistance = (flippedLocs(n+1) - 1) * init.ptDistance;
       
    segmentData{length(apexData.locs)-n,1} = sim('segmentCalc');
    
    % Velocity überschreiben
    if max(segmentData{length(apexData.locs)-n,1}.velocity) < flippedVel(n+1)
        flippedVel(n+1) = max(segmentData{length(apexData.locs)-n,1}.velocity);
    end
    
    % Distance umdrehen
    segmentData{length(apexData.locs)-n,1}.distance ...
        = flip((TrackLength) - segmentData{length(apexData.locs)-n,1}.distance);
    
    % Alle restlichen Größen umdrehen
    for o = 2:length(resultData.Vars) % an erster Stelle steht distance
       segmentData{length(apexData.locs)-n,1}.(resultData.Vars(o)) ...
           = flip(segmentData{length(apexData.locs)-n,1}.(resultData.Vars(o))); 
    end    
end

% Apex Velocity anpassen für den Fall, dass Bremspunkt vor Apex liegt
apexData.velocity(:,2) = flip(flippedVel);

%% max Apex Velocity über Acceleration

init.state = 0; % Acceleration

for n = 1:1:length(apexData.locs)-1
    
    currentDistance = (apexData.locs(n,1) - 1) * init.ptDistance;
    apexVelocity = apexData.velocity(n,2);
    stoppingDistance = (apexData.locs(n+1,1) - 1) * init.ptDistance;
    
    segmentData{n,2} = sim('segmentCalc');
    
    %löscht doppelte Werte
    segmentData{n,2} = clearDouble(segmentData{n,2});
    segmentData{n,1} = clearDouble(segmentData{n,1});
    
    % Segmente auf Distance Interpolieren
    segmentData{n,2} = interpolSegments(segmentData{n,2}, currentDistance, stoppingDistance);
    segmentData{n,1} = interpolSegments(segmentData{n,1}, currentDistance, stoppingDistance);
    
    % max velocity überschreiben, falls velocity an nächstem Apex nicht
    % erreicht werden kann
    if max(segmentData{n,2}.velocity) < apexData.velocity(n+1,2)
        apexData.velocity(n+1,2) = max(segmentData{n,2}.velocity);
    end  
    
    resultData = evaluateSegment(resultData, segmentData{n,2}, segmentData{n,1});
    
    if isempty(resultData.tout) == 1
        error('no tout')
    end
end

clear currentDistance apexVelocity stoppingDistance n o
clear flippedCourse flippedLocs flippedVel

%% Skid Pad berechnen

resultData.SP_tout = 57.3341 / apexData.sp_velocity;


%% temp section







