n = 3;

%% Acceleration

init.state = 0;

currentDistance = (apexData.locs(n,1) - 1) * init.ptDistance;
apexVelocity = apexData.velocity(n,2);
stoppingDistance = (apexData.locs(n+1,1) - 1) * init.ptDistance;


%% Braking

init.state = 1;

flippedLocs = (length(course(:,3)) + 1) - flip(apexData.locs(:,1));
flippedCourse = flip(course);
flippedVel = flip(apexData.velocity(:,1));

currentDistance = (flippedLocs(n) - 1) * init.ptDistance;
apexVelocity = flippedVel(n);
stoppingDistance = (flippedLocs(n+1) - 1) * init.ptDistance;

%% 

% interp_dist = [0:0.001:TrackLength]';
% 
% interp_rad = interp1(distance, course(:,3), interp_dist, 'makima');
% 
% figure()
% subplot(211)
% plot(distance, course(:,3))
% grid
% hold on
% subplot(212)
% plot(interp_dist, interp_rad)
% grid
