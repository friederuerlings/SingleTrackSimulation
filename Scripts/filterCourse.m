function [filteredapexData] = filterCourse(apexData, maxRadius)

% entfernt alle Apex deren Geschwindigkeit gr��er als init.vmax ist

logicMat = apexData.radius(:,1) < maxRadius;
logicMat = horzcat(logicMat,logicMat,logicMat);

filteredapexData.radius = apexData.radius(logicMat(:,1));
filteredapexData.velocity = apexData.velocity(logicMat(:,1));
filteredapexData.locs = apexData.locs(logicMat(:,1));

x_werte = apexData.xy(:,1);
y_werte = apexData.xy(:,2);
r_werte = apexData.xy(:,3);

x_werte = x_werte(logicMat(:,1));
y_werte = y_werte(logicMat(:,1));
r_werte = r_werte(logicMat(:,1));

filteredapexData.xy = [x_werte y_werte r_werte];