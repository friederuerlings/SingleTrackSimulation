n = 2;

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