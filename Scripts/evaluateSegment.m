function [resultData] = evaluateSegment(resultData, segmentData_accel, segmentData_brake)

%% Berechnet Bremspunkt

brakePt = intersection(segmentData_accel.distance, segmentData_accel.velocity, ...
    segmentData_brake.distance, segmentData_brake.velocity);

% Rundet Brake Point auf die initialisierte Schrittweite
brakePt = round(brakePt*(1/evalin('base', 'init.deltaS')))/(1/evalin('base', 'init.deltaS'));


%% Segment in dem nur gebremst wird
% �bernimmt das Segment vom Bremsvorgang

if segmentData_brake.velocity(1) <= segmentData_accel.velocity(1) ...
        | brakePt <= segmentData_accel.distance(1)
    
    for n = 1:length(resultData.VarsVektor)
        resultData.(resultData.VarsVektor(n)) = ...
            vertcat(resultData.(resultData.VarsVektor(n)), ...
            segmentData_brake.(resultData.VarsVektor(n)));
            resultData.(resultData.VarsVektor(n))(end) = [];
        
    end
    
    for n = 1:length(resultData.VarsSum)
        resultData.(resultData.VarsSum(n)) = ...
            resultData.(resultData.VarsSum(n)) + ...
            max(segmentData_brake.(resultData.VarsSum(n)));
    end
    
    return
end

%% Segment in dem nur beschleunigt wird
% �bernimmt das Segment vom Beschleunigungsvorgang

if max(segmentData_accel.velocity) <= min(segmentData_brake.velocity) ...
        | brakePt >= segmentData_accel.distance(end)
    
        for n = 1:length(resultData.VarsVektor)
        resultData.(resultData.VarsVektor(n)) = ...
            vertcat(resultData.(resultData.VarsVektor(n)), ...
            segmentData_accel.(resultData.VarsVektor(n)));
            resultData.(resultData.VarsVektor(n))(end) = [];  
    end
    
    for n = 1:length(resultData.VarsSum)
        resultData.(resultData.VarsSum(n)) = ...
            resultData.(resultData.VarsSum(n)) + ...
            max(segmentData_accel.(resultData.VarsSum(n)));
    end

    return
end

%% Segment mit Bremspunkt
% Erzeugt einen Vektor mit interpolierten Werten von apex1 zu Bremspunkt
% und von Bremspunkt zu apex2

% Interpoliert Accel-Vektoren von Apex1 zu Brake Point und Brake-Vektoren von Brake Point zu
% Apex2
logicAccel = segmentData_accel.distance < brakePt;
logicBrake = segmentData_brake.distance >= brakePt;

for n = 1:length(resultData.VarsVektor)
   resultData.(resultData.VarsVektor(n)) = vertcat(resultData.(resultData.VarsVektor(n)), ...
       segmentData_accel.(resultData.VarsVektor(n))(logicAccel), ...
       segmentData_brake.(resultData.VarsVektor(n))(logicBrake)); 
   
   resultData.(resultData.VarsVektor(n))(end) = [];
end

for n = 1:length(resultData.VarsSum)
   resultData.(resultData.VarsSum(n)) = resultData.(resultData.VarsSum(n)) + ...
       max(segmentData_accel.(resultData.VarsSum(n))(logicAccel)) + ...
       max(segmentData_brake.(resultData.VarsSum(n))(logicBrake)); 
end

%% temp section





    