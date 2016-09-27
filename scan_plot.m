function scan_plot()
close all;
% % Serial init
% s = serial('/dev/ttyACM0');
% set(s,'BaudRate',9600);
% fopen(s);
% fwrite(':scan:\n');
% out = fscanf(s);
% 
% print(out);
% Setup
figure
axis equal
dscan = importdata('3d_scan.csv');
base_length = 25;

% Convert input data to distance
dvoltage = dscan ./1024 .*5;
v = [404 560 445 326 250 210 173 150 134 124 113 104 91 82 75] ./1024 .*5;
x = 10:10:150;
ddistance = interp1(v, x, dvoltage, 'linear');
a = find(ddistance>base_length + 6);
ddistance(a) = NaN;


% Arrange data in vectors
% distance_vector = ddistance(:);
distance_vector = ddistance(1:2,:);
distance_vector = distance_vector(:);
tilt = 30:-1:-20;
tilt = repmat(tilt, 2, 1);
tilt_vector = tilt(:);
az_vector = repmat(0:5:175, 1, 2).*pi./180;
% [r, z] = arrayfun(@to_cylindrical, distance_vector, repmat(base_length,1836,1), tilt_vector); 
[r, z] = arrayfun(@to_cylindrical, distance_vector, repmat(base_length, numel(tilt_vector), 1), tilt_vector)
% filter out garbage

% Plot
[X, Y, Z] = pol2cart(zeros(numel(tilt_vector), 1), r, z);
scatter3(X(:), Y(:), Z(:), '.')
% surf(ddistance) 

% % Serial cleanup
% fclose(s)
% delete(s)
% clear s

end


