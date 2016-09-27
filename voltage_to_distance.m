function distance_cm = voltage_to_distance(dscan)
dvoltage = dscan ./1024 .*5;
v = [404 560 445 326 250 210 173 150 134 124 113 104 91 82 75] ./1024 .*5;
x = 10:10:150;
distance_cm = interp1(v, x, dvoltage, 'linear');
end