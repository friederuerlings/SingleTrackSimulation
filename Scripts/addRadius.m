function  [course, radiusLookUp] = addRadius(input)

%Input ist x und y Coordinaten des Tracks
%F�gt Kurvenradien als 3. Spaltenvektor hinzu

%input(:,1) = input(:,1).*(-1);
input(:,3) = 0;
course = input;

for n = 2:1:length(input)-1
    rad = calcRadius(input(n-1,:),input(n,:),input(n+1,:));
%     if rad > 300 || isnan(rad) == 1
%         rad = 300;
%     end
    course(n,3) = rad;        
end

%Start und Endradius definieren
[course(1,3)] = calcRadius(input(length(input),:),input(1,:),input(2,:));
[course(length(input),3)] = calcRadius(input(length(input)-1,:),input(length(input),:),input(1,:));

%% Radius Interpolieren
%RadiusLookUp(:,1) = Radius
%RadiusLookUp(:,2) = Distance

radiusLookUp(:,2) = [0:0.01:evalin('base','TrackLength')]';
radius = course(:,3);
radiusLookUp(:,1) = interp1(evalin('base','distance'), radius, radiusLookUp(:,2), 'makima');


