function [segmentData] = interpolSegments(segmentData, currentDistance, stoppingDistance)
% Interpoliert alle Simulink Größen auf distance mit Schrittweite
% init.deltaS

interpD = [currentDistance:evalin('base', 'init.deltaS'):stoppingDistance]';

resultDataVars = evalin('base', 'resultData.Vars');

for n = 2:length(resultDataVars) % an 1. Stelle steht Distance
    segmentData.(resultDataVars(n)) = ...
        interp1(segmentData.distance, segmentData.(resultDataVars(n)), interpD, 'linear', 'extrap');
end

segmentData.distance = interpD;