% Define transformation function836
function [r, h] = to_cylindrical(d,s, theta) 
    r = s - cosd(theta)*d;
    h = sind(theta) * d;    
end