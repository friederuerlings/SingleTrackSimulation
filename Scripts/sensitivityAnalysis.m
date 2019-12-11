%% Einfluss von Masse auf Lap Time

LapTime = [];

for o = 0.5:0.5:1.5
    init.cog_z = o;
    
    Initialisierung
    
    LapTime = [LapTime; resultData.tout];
    
end

%% Plotten

figure()
plot([0.5:0.5:1.5], LapTime, 'LineWidth', 2)
grid
title('Aero Balance - LapTime')
xlabel('Balance [% von Vorne]')
ylabel('LapTime [sec]')
    
    
