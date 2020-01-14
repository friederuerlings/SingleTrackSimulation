%% Lap Information

disp('___________________')
disp('Lap Time')
tempstring = [num2str(resultData.tout), ' sec'];
disp(tempstring)
% disp('Max Velocity')
% disp(max(resultData.velocity)*3.6)
% disp('Acceleration Time')
% disp(accelData.tout(end))
% disp('Max Velocity')
% disp(max(accelData.velocity(end))*3.6)
disp('Fuel Consumption')
tempstring = [num2str(resultData.fuel*22), ' liter'];
disp(tempstring)
disp('___________________')

clear tempstring
%% Plots

% Plot Velocity über Distance
%     figure('Name', 'Velocity - Distance')
%     plot(resultData.distance, resultData.velocity)
%     grid
%     title('Velocity - Distance')
%     xlabel('Distance [m]')
%     ylabel('Velocity [m/s]')

% % Plot Velocity über Kurs
%     figure('Name', 'Velocity - Course')
%     interpVel = interp1(resultData.distance, resultData.velocity, distance);
%     x = course(:,1)';
%     y = course(:,2)';
%     z = interpVel'.*3.6;
%     C = interpVel'.*3.6;
% 
%     surface([x;x],[y;y],[z;z],[C;C],...
%         'FaceColor','none',...
%         'EdgeColor','interp', 'LineWidth', 3);
%     title('Velocity - Course')
%     colorbar
%     set(gca,'XTickLabel',[],'YTickLabel',[]);
% 
%     clear x y z C n interpVel

%% Plot DRS über Kurs

%     figure('Name', 'DRS Open - Course')
%     interpDRS = interp1(resultData.distance, resultData.drs_open, distance);
%     x = course(:,1)';
%     y = course(:,2)';
%     z = interpDRS';
%     C = interpDRS';
% 
%     surface([x;x],[y;y],[z;z],[C;C],...
%         'FaceColor','none',...
%         'EdgeColor','interp', 'LineWidth', 3);
%     title('DRS Open - Course')
%     colorbar
%     set(gca,'XTickLabel',[],'YTickLabel',[]);
% 
%     clear x y z C n interpDRS

%% Plot Segments

% for n = 21:1:21
%     figure(n)
%     plot(segmentData{n,2}.distance, segmentData{n,2}.velocity)
%     hold on
%     grid
%     plot(segmentData{n,1}.distance, segmentData{n,1}.velocity)
%     hold off
% end

%% Plot Segment Radius

% for n = 51:1:51
%     
%     figure(100 + n)
%     plot(1:1:length(segments{n}), segments{n})
%     grid
%     
%     figure()
%     plot(segmentData{n,2}.distance, segmentData{n,2}.radius)
%     grid
%     hold on
%     plot(segmentData{n,1}.distance, segmentData{n,1}.radius)
%     ylim ([0 200])
% end

%% Plottet das ggv-Diagramm mit Punkten

% figure('Name', 'ggV Diagramm')
% plot3(ggv.Data_pos(:,1),ggv.Data_pos(:,2),ggv.Data_pos(:,3),'*')
% hold on
% plot3(ggv.Data_neg(:,1),ggv.Data_neg(:,2),ggv.Data_neg(:,3),'*')
% hold off
% grid
% title('ggV-Diagram')
% xlabel('a_x [m/s²]')
% ylabel('a_y [m/s²]')
% zlabel('velocity [km/h]')


%% Plottet das ggv-Diagramm mit Flächen

%Positiver Bereich

figure('Name', 'ggV Diagramm')
plot3([0 0 0],[0 0 0],[0 0 0])

for o = 1:init.ggvAySteps:length(ggv.Data_pos)-init.ggvAySteps
    
    vertices = [];
    faces = [];
    cdata = [];
    
for n = 1:1:init.ggvAySteps-1
    
    p = n+o-1;
    
    pt1 = ggv.Data_pos(p,:);
    pt2 = ggv.Data_pos(p+1,:);
    pt3 = ggv.Data_pos(p+init.ggvAySteps,:);
    pt4 = ggv.Data_pos(p+init.ggvAySteps+1,:);
    
    facesn = n*4;
    facesVek = [facesn - 3, facesn - 2, facesn, facesn - 1];
    
    pt1_cdata = ggv.Data_pos(p,3);
    pt2_cdata = ggv.Data_pos(p+1,3);
    pt3_cdata = ggv.Data_pos(p+init.ggvAySteps,3);
    pt4_cdata = ggv.Data_pos(p+init.ggvAySteps+1,3);
    
    vertices = [vertices; pt1; pt2; pt3; pt4];
    faces = [faces; facesVek];
    cdata = [cdata; pt1_cdata; pt2_cdata; pt3_cdata; pt4_cdata];
    
    patch('Faces', faces, 'Vertices', vertices,'FaceVertexCData',cdata, 'FaceColor','interp')
    
end
end

% Negativer Bereich

for o = 1:init.ggvAySteps:length(ggv.Data_neg)-init.ggvAySteps
    
    vertices = [];
    faces = [];
    cdata = [];
    
for n = 1:1:init.ggvAySteps-1
    
    p = n+o-1;
    
    pt1 = ggv.Data_neg(p,:);
    pt2 = ggv.Data_neg(p+1,:);
    pt3 = ggv.Data_neg(p+init.ggvAySteps,:);
    pt4 = ggv.Data_neg(p+init.ggvAySteps+1,:);
    
    facesn = n*4;
    facesVek = [facesn - 3, facesn - 2, facesn, facesn - 1];
    
    pt1_cdata = ggv.Data_neg(p,3);
    pt2_cdata = ggv.Data_neg(p+1,3);
    pt3_cdata = ggv.Data_neg(p+init.ggvAySteps,3);
    pt4_cdata = ggv.Data_neg(p+init.ggvAySteps+1,3);
    
    vertices = [vertices; pt1; pt2; pt3; pt4];
    faces = [faces; facesVek];
    cdata = [cdata; pt1_cdata; pt2_cdata; pt3_cdata; pt4_cdata];
    
    patch('Faces', faces, 'Vertices', vertices,'FaceVertexCData',cdata, 'FaceColor','interp')
    
end
end

for o = init.ggvAySteps:init.ggvAySteps:length(ggv.Data_neg)-init.ggvAySteps
    
    vertices = [];
    faces = [];
    cdata = [];
    
    pt1 = ggv.Data_pos(o,:);
    pt2 = ggv.Data_neg(o,:);
    pt3 = ggv.Data_pos(o+init.ggvAySteps,:);
    pt4 = ggv.Data_neg(o+init.ggvAySteps,:);
    
    pt1_cdata = ggv.Data_pos(o,3);
    pt2_cdata = ggv.Data_neg(o,3);
    pt3_cdata = ggv.Data_pos(o+init.ggvAySteps,3);
    pt4_cdata = ggv.Data_neg(o+init.ggvAySteps,3);
    
    vertices = [pt1; pt2; pt3; pt4];
    faces = [1, 2, 4, 3];
    cdata = [pt1_cdata; pt2_cdata; pt3_cdata; pt4_cdata];
        
    patch('Faces', faces, 'Vertices', vertices,'FaceVertexCData',cdata, 'FaceColor','interp')
    
end

grid
title('ggV-Diagram')
xlabel('a_x [m/s²]')
ylabel('a_y [m/s²]')
zlabel('velocity [m/s]')

clear n o p pt1 pt2 pt3 pt4 pt1_cdata pt2_cdata pt3_cdata pt4_cdata ...
    faces facesn facesVek vertices
    