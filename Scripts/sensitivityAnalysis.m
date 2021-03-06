LapTime = [];
LapTimeRow = [];

%% Ein Parameter

for n = 45:1:55
    init.cog_x = n;
    
    Initialisierung
    
    LapTime = [LapTime; resultData.tout];
    
end

%% Plotten

figure()
plot(45:1:55, LapTime)
grid
% xlabel('Drag Height [m]')
% ylabel('LapTime [s]')
% title('CoG Height 0.267m')



%% Zwei Parameter

for n = 3:0.2:4.6
    
    init.c_L = n;
    
    
    for o = 1:0.2:2
        init.c_D = o;
        
        Initialisierung
        
        LapTimeRow = [LapTimeRow resultData.tout];
        
    end
    
    LapTime = [LapTime; LapTimeRow];
    LapTimeRow = [];
    
end

%% Plotten

% figure()
% plot([10:10:90], LapTime, 'LineWidth', 2)
% grid
% title('Aero Balance - LapTime')
% xlabel('Balance [% von Vorne]')
% ylabel('LapTime [sec]')

figure()
surf([1:0.2:2],[3:0.2:4.6], LapTime, 'FaceColor','interp')
title('Aero Coefficients on LapTime')
xlabel('c_D')
ylabel('c_L')
zlabel('LapTime')
xlim([1;2])
ylim([3;4.6])

    
    
