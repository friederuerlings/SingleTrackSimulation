function [apexData, segments] = maxVelocityatApex(course)

%% Erstellt Apex Struct mit Locs und Radius
% Berechnung der Peaks (Apex)
[apexData.radius, apexData.locs] = findpeaks(course(:,3)*-1);
apexData.radius = apexData.radius * -1;

% Fügt ersten und letzten Punkt als Apex hinzu
apexData.locs = vertcat(1, apexData.locs, length(course));
apexData.radius = vertcat(course(1,3), apexData.radius, course(end,3));

%% Velocity am Apex berechnen
load_system ('velocityInRadiusOut');
set_param('velocityInRadiusOut','StartTime','0','StopTime','init.maxV','MinStep','auto','MaxStep','auto');
tempSim = sim('velocityInRadiusOut');

for n = 1:1:length(apexData.locs)
    apexData.velocity(n,1) = interp1(tempSim.radius, tempSim.velocity, apexData.radius(n));
    apexData.xy(n,:) = course(apexData.locs(n),:);
end

% Startgeschwindigkeit
% apexData.velocity(1) = 0;

% filtert apexData, entfernt alle apex mit v > vmax
[apexData] = filterCourse(apexData, tempSim.radius(end));

%% Erstellt Segments Cell
% Segements enthält die Radien der Segmente
for n = 1:(size(apexData.locs)-1)
    
    segments(:,n) = {course(apexData.locs(n):apexData.locs(n+1),3)};
    
end





