f = figure('position',[200 200 1000 600],'menubar','none');
fileID = fopen('C:\Users\Alex\Desktop\Протектор\деталь100.plt');
Text = textscan(fileID,'%s','Delimiter',';');
hold on;
axis equal 
Text = Text{1,1};
fclose(fileID);

n = 2;
m=50;
E=0.00005;
F=100;
delT=0.01;
Lambda=1/delT;

Vp=[];
Alfa=[];
Arr4plot=[];
arrR=[];
arrInsidePoints=[];
arrDistanceIP2IP=[];
arrDistanceIP2R=[];
arrDistanceIP2OP=[];
arrDistanceOP2R=[];
Fi=[];
Ksi=[];
arrOutsidePoints=[];
FirstPU=[];
Arr=[];
Var=1;
Eq=[];

for i=1:size(Text)
    b=Text{i,1};
    b=b(1:2);
    
    if strcmp(b,'PU')
        d=Text{i,1};
        d=str2num(d(3:end));
        Arr=[Arr;d];
        FirstPU=[FirstPU;Var];
        Var=Var+1;
    elseif strcmp(b,'PD')
        d=Text{i,1};
        d=str2num(d(3:end));
        Arr=[Arr;d];
        Var=Var+1;
    end
    
end

for i=1:(size(Arr)-1)
    
    if ((i+1)==FirstPU(n))
        if(n==2)
        n=n+1;
        continue;
        else
        continue;
        end
    end
    
    Arr4plot=plot([Arr(i,1) Arr(i+1,1)],[Arr(i,2) Arr(i+1,2)]);
    
    Arr4plot.LineWidth = 2;
    Arr4plot.Color = [0,0,0];
    Arr4plot.Marker = 'o';
    Arr4plot.MarkerSize = 5;
    Arr4plot.MarkerEdgeColor = [0.4,0,0];
    Arr4plot.MarkerFaceColor = [0.7,0,0];
    set(gca,'Visible', 'off ')
    
end  

arrR(1,1:2)=Arr(99,1:2);
for i=1:7
    arrR(1+i,1)=Arr(99,1)+(Arr(100,1)-Arr(99,1))*(i/8);
    arrR(1+i,2)=Arr(99,2);
end
arrR(end+1,1:2)=Arr(100,1:2);
for i=1:5
    arrR(end+1,1:2)=[Arr(100,1),Arr(100,2)+(Arr(101,2)-Arr(100,2))*(i/6)]; 
end
arrR(end+1,1:2)=Arr(101,1:2);
for i=1:7
    arrR(end+1,1:2)=[Arr(101,1)+(Arr(102,1)-Arr(101,1))*(i/8),Arr(101,2)];
end
arrR(end+1,1:2)=Arr(102,1:2);
for i=1:5
    arrR(end+1,1:2)=[Arr(102,1),Arr(102,2)+(Arr(103,2)-Arr(102,2))*(i/6)];
end

for i=1:length(arrR)-1
    Arr4plot=plot([arrR(i,1) arrR(i+1,1)],[arrR(i,2) arrR(i+1,2)]);
    
    Arr4plot.LineWidth = 2;
    Arr4plot.Color = [0,0,0];
    Arr4plot.Marker = 'o';
    Arr4plot.MarkerSize = 5;
    Arr4plot.MarkerEdgeColor = [0.4,0,0];
    Arr4plot.MarkerFaceColor = [0.7,0,0];
    set(gca,'Visible', 'off ')
end

arrInsidePoints(:,1)=randi([-2899,2901],m,1);
arrInsidePoints(:,2)=randi([-1313,2487],m,1);

for i=1:length(arrInsidePoints)
    for j=1:length(arrInsidePoints)
       arrDistanceIP2IP(i,j)=sqrt((arrInsidePoints(j,1)-arrInsidePoints(i,1)).^2+(arrInsidePoints(j,2)-arrInsidePoints(i,2)).^2);
    end
end
for i=1:length(arrInsidePoints)
    for j=1:length(arrR)
       arrDistanceIP2R(i,j)=sqrt((arrR(j,1)-arrInsidePoints(i,1)).^2+(arrR(j,2)-arrInsidePoints(i,2)).^2);
    end
end

xStart=Arr(99,1)+(Arr(101,1)-Arr(99,1))/2;
yStart=Arr(99,2)+(Arr(101,2)-Arr(99,2))/2;

t=0:pi/50:2*pi; 
x=sin(t)*10000+xStart; 
y=cos(t)*10000+yStart;

for i=1:100     
    arrOutsidePoints(i,1)=x(1,i);
    arrOutsidePoints(i,2)=y(1,i);
    Arr4plot=plot(arrOutsidePoints(i,1),arrOutsidePoints(i,2));
    
    Arr4plot.LineWidth = 2;
    Arr4plot.Color = [0,0,0];
    Arr4plot.Marker = 'o';
    Arr4plot.MarkerSize = 5;
    Arr4plot.MarkerEdgeColor = [0.4,0,0];
    Arr4plot.MarkerFaceColor = [0.7,0,0];
    set(gca,'Visible', 'off ')
end

for i=1:length(arrOutsidePoints)
    for j=1:length(arrR)
       arrDistanceOP2R(i,j)=sqrt((arrR(j,1)-arrOutsidePoints(i,1)).^2+(arrR(j,2)-arrOutsidePoints(i,2)).^2);
    end
end
for i=1:length(arrOutsidePoints)
    for j=1:length(arrInsidePoints)
       arrDistanceIP2OP(i,j)=sqrt((arrOutsidePoints(i,1)-arrInsidePoints(j,1)).^2+(arrOutsidePoints(i,2)-arrInsidePoints(j,2)).^2);
    end
end

for i=1:length(arrDistanceIP2IP)
    for j=1:length(arrDistanceIP2IP)
       Fi(i,j)=exp(-1*(E.*arrDistanceIP2IP(i,j)).^2);
    end
end

for i=1:length(arrDistanceIP2IP)
    for j=1:length(arrDistanceIP2IP)
       Ksi(i,j) = -exp(-E.^2 * arrDistanceIP2IP(i,j).^2)*(-4.*E.^4.*arrDistanceIP2IP(i,j).^2 + 4.*E.^2 + Lambda.^2);
    end
end

for i=1:length(arrDistanceIP2IP)
    for j=1:length(arrDistanceIP2IP)
    Alfa(i,j)=lsqr(Ksi(i,j),F);
    end
end

for i=1:length(Alfa)
    for j=1:length(Alfa)
        Vp(i,j)=(Alfa(i,j)*Ksi(i,j));
    end
end
arrInsidePoints(:,2)=randi([-1313,2487],m,1);

% -exp(-E^2*(x^2 + y^2))*(- 4*E^4*x^2 - 4*E^4*y^2 + 4*E^2 + l^2)  


