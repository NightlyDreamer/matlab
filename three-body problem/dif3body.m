function dif3body
    
    % устанавливаем константы для задачи трех тел
    mt = zeros(3,1);
    mt(1) = 20000;
    mt(2) = 200;
    mt(3) = 200;
    g = 6.67408 * 10e-2;
    
    % задаем начальные координаты тел
    % начальные скорости задаем нулями
    d = zeros(18,1);
    % solar
    d(1) = 0;
    d(2) = 0;
    d(3) = 0;
    % eath
    d(4) = 1000;
    d(5) = 0;
    d(6) = 0;
    % mars
    d(7) = 1000;
    d(8) = 1000;
    d(9) = 0;
    
    function dv = dfunc(t,d)
        dv = zeros(18,1);
        % 1telo
        dv(1) = d(10);
        dv(2) = d(11);
        dv(3) = d(12);
        % 2telo
        dv(4)=d(13);
        dv(5)=d(14);
        dv(6)=d(15);
        % 3telo
        dv(7)=d(16);
        dv(8)=d(17);
        dv(9)=d(18);

        r1r2 = (sqrt((d(1) - d(4))^2 + (d(2) - d(5))^2 + (d(3) - d(6))^2))^3;
        r1r3 = (sqrt((d(1) - d(7))^2 + (d(2) - d(8))^2 + (d(3) - d(9))^2))^3;
        r2r3 = (sqrt((d(4) - d(7))^2 + (d(5) - d(8))^2 + (d(6) - d(9))^2))^3;
        
        % v1telo
        dv(10) = g*mt(2)*(d(4)-d(1))/r1r2 + g*mt(3)*(d(7)-d(1))/r1r3;
        dv(11) = g*mt(2)*(d(5)-d(2))/r1r2 + g*mt(3)*(d(8)-d(2))/r1r3;
        dv(12) = g*mt(2)*(d(6)-d(3))/r1r2 + g*mt(3)*(d(9)-d(3))/r1r3;
        % v2telo
        dv(13) = g*mt(1)*(d(1)-d(4))/r1r2 + g*mt(3)*(d(7)-d(4))/r2r3;
        dv(14) = g*mt(1)*(d(2)-d(5))/r1r2 + g*mt(3)*(d(8)-d(5))/r2r3;
        dv(15) = g*mt(1)*(d(3)-d(6))/r1r2 + g*mt(3)*(d(9)-d(6))/r2r3;
        % v3telo
        dv(16) = g*mt(2)*(d(4)-d(7))/r2r3 + g*mt(1)*(d(1)-d(7))/r1r3;
        dv(17) = g*mt(2)*(d(5)-d(8))/r2r3 + g*mt(1)*(d(2)-d(8))/r1r3;
        dv(18) = g*mt(2)*(d(6)-d(9))/r2r3 + g*mt(1)*(d(3)-d(9))/r1r3;
    end
opt = odeset('RelTol',1e-2);
[T,Y] = ode45(@dfunc,[0:0.1:200],d,opt);
hold on;


minx = min(min(Y(:,[1, 4 , 7])));
miny = min(min(Y(:,[2, 5 , 8])));
minz = min(min(Y(:,[3, 6 , 9])));

maxx = max(max(Y(:,[1, 4 , 7])));
maxy = max(max(Y(:,[2, 5 , 8])));
maxz = max(max(Y(:,[3, 6 , 9])));

axis( [minx maxx miny maxy minz maxz+1e-9]);  
grid on;
for i=1:size(T,1)
    cla;
    plot3(Y(i,1),Y(i,2),Y(i,3),'*');
    plot3(Y(i,4),Y(i,5),Y(i,6),'*');
    plot3(Y(i,7),Y(i,8),Y(i,9),'*');
    pause(0.00001);
    title(num2str(i));
end
end


    