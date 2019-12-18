function [resultData] = initResultData(tempVarsVektor, tempVarsSum)

for n = 1:length(tempVarsVektor)
    resultData.(tempVarsVektor(n)) = [];
end

for n = 1:length(tempVarsSum)
    resultData.(tempVarsSum(n)) = 0;
end

resultData.Vars = [tempVarsVektor; tempVarsSum];
resultData.VarsVektor = tempVarsVektor;
resultData.VarsSum = tempVarsSum;