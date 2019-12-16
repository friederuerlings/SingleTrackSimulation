clear segmentData
warning off MATLAB:polyfit:RepeatedPointsOrRescale
warning off 'Simulink:blocks:SquareRootOfNegative'
resultData.velocity = []; resultData.distance = []; resultData.tout = 0; ...
    resultData.a_x = []; resultData.a_y = []; resultData.radius = []; resultData.energy = 0;

%Apex Velocity Backup 
apexData.velocity(:,2) = apexData.velocity(:,1);

%Track umdrehen für Braking Simulation
flippedLocs = (length(course(:,3)) + 1) - flip(apexData.locs(:,1));
flippedCourse = flip(course);
flippedVel = flip(apexData.velocity(:,1));

%Simulink initialisieren
load_system ('segmentCalcPos');
set_param('segmentCalcPos','FastRestart','off');
set_param('segmentCalcPos','StartTime','0','StopTime','inf','FixedStep','1e-3');
% set_param('segmentCalcPos','StartTime','0','StopTime','inf','MinStep','auto','MaxStep','1e-3');
set_param('segmentCalcPos','FastRestart','on');
set_param('segmentCalcPos','AlgebraicLoopSolver','LineSearch');
% set_param('segmentCalcPos','AlgebraicLoopSolver','TrustRegion');


%% max Apex Velocity über Braking 

init.state = 1; % Braking

for n = 1:1:length(flippedLocs)-1
    
    currentDistance = (flippedLocs(n) - 1) * init.ptDistance;
    apexVelocity = flippedVel(n);
    stoppingDistance = (flippedLocs(n+1) - 1) * init.ptDistance;
       
    segmentData{length(apexData.locs)-n,1} = sim('segmentCalcPos');
    
    % Velocity überschreiben
    if max(segmentData{length(apexData.locs)-n,1}.velocity) < flippedVel(n+1)
        flippedVel(n+1) = max(segmentData{length(apexData.locs)-n,1}.velocity);
    end
    
    % Distance, Velocity und a_x umdrehen
    segmentData{length(apexData.locs)-n,1}.distance = flip((TrackLength) - segmentData{length(apexData.locs)-n,1}.distance);
    segmentData{length(apexData.locs)-n,1}.velocity = flip(segmentData{length(apexData.locs)-n,1}.velocity);
    segmentData{length(apexData.locs)-n,1}.a_x = flip(segmentData{length(apexData.locs)-n,1}.a_x);
    segmentData{length(apexData.locs)-n,1}.a_y = flip(segmentData{length(apexData.locs)-n,1}.a_y);
    segmentData{length(apexData.locs)-n,1}.radius = flip(segmentData{length(apexData.locs)-n,1}.radius);
    segmentData{length(apexData.locs)-n,1}.tout = flip(segmentData{length(apexData.locs)-n,1}.tout);
    segmentData{length(apexData.locs)-n,1}.energy = flip(segmentData{length(apexData.locs)-n,1}.energy);
    
end

% Apex Velocity anpassen für den Fall, dass Bremspunkt vor Apex liegt
apexData.velocity(:,2) = flip(flippedVel);

%% max Apex Velocity über Acceleration

init.state = 0; % Acceleration

for n = 1:1:length(apexData.locs)-1
    
    currentDistance = (apexData.locs(n,1) - 1) * init.ptDistance;
    apexVelocity = apexData.velocity(n,2);
    stoppingDistance = (apexData.locs(n+1,1) - 1) * init.ptDistance;
    
    segmentData{n,2} = sim('segmentCalcPos');
    
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

clear currentDistance apexVelocity stoppingDistance n 
clear flippedCourse flippedLocs flippedVel

%% temp section







