function [segmentData] = clearDouble(segmentData)

% entfernt alle doppelten Werte aus den Vektoren
% mit doppelten x Werten kann nicht interpoliert werden

deltad = diff(segmentData.distance);
logicDiff = deltad ~= 0;

logicDiff = logical(logicDiff);

resultDataVars = evalin('base', 'resultData.Vars');

for n = 1:length(resultDataVars)
    segmentData.(resultDataVars(n)) = segmentData.(resultDataVars(n))(logicDiff);
end
