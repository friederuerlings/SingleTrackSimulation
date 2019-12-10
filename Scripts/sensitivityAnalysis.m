%% Einfluss von Masse auf Lap Time

LapTime = [];

for o = 10:10:90
    init.aeroBalance = o;
    
    Initialisierung
    
    LapTime = [LapTime; resultData.tout];
    
end

%% Plotten

figure()
plot([10:10:90], LapTime, 'LineWidth', 2)
grid
title('Aero Balance - LapTime')
xlabel('Balance [% von Vorne]')
ylabel('LapTime [sec]')
    
    
