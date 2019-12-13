%% Plot Lap

disp('___________________')
disp('Lap Time')
disp(resultData.tout)
% disp('Max Velocity')
% disp(max(resultData.velocity)*3.6)
% disp('Acceleration Time')
% disp(accelData.tout(end))
% disp('Max Velocity')
% disp(max(accelData.velocity(end))*3.6)
disp('___________________')

% Plot Velocity über Distance
    % figure('Name', 'Velocity - Distance')
    % plot(resultData.distance, resultData.velocity)
    % grid
    % title('Velocity - Distance')
    % xlabel('Distance [m]')
    % ylabel('Velocity [m/s]')

% Plot Velocity über Kurs
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

%% Plot Segments

% for n = 10:1:10
%     figure(n)
%     plot(segmentData{n,2}.distance, segmentData{n,2}.velocity)
%     hold on
%     grid
%     plot(segmentData{n,1}.distance, segmentData{n,1}.velocity)
%     hold off
% end

%% Plot Segment Radius

% for n = 10:1:10
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
% end