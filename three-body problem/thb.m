function thb
options = odeset('AbsTol', 1e-11, 'RelTol', 1e-11);
[T,Y]=ode45(@tbp, 0:50:150000, [0 0 0 0 0 0 -1.49e11 0 0 0 0 -3.5e8 1.08e11 0 0 0 0 4.2e8], options); 
minx = min(min(Y(:,[1 7 13])));
maxx = max(max(Y(:,[1 7 13])));
miny = min(min(Y(:,[2 8 14])));
maxy = max(max(Y(:,[3 8 14])));
minz = min(min(Y(:,[3 9 15])));
maxz = max(max(Y(:,[3 9 15])));
for i=1:size(Y,1)
    plot3(Y(i,1),Y(i,2), Y(i,3), '.r', Y(i,7), Y(i,8), Y(i,9), '.b', Y(i,13), Y(i,14), Y(i,15), '.g');
    axis([minx, maxx, miny-1e-6, maxy, minz, maxz]);
    view(0,0)
    pause(0.1)
end

