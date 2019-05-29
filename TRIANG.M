function Triang
f=figure('position',[230 250 570 510],'menubar','none');
hold on
axis equal
n=5;
global i;
check=1;
NP=1;
Eps=0.05;
arrR=[];
x=randi([-1000,1000],n,1);
y=randi([-1000,1000],n,1);
arrPlot=[];
s=struct('R1',[],'R2',[],'R3',[],'A',[],'B',[],'C',[],'nA',[],'nB',[],'nC',[],'CO',[]);
Coordinates=[];
minX=x(1,1);
minY=y(1,1);
maxX=x(1,1);
maxY=y(1,1);
ArrCoor=[];
coun=1;
EdgePoints=[];
for i=1:n
    EdgePoints(i) = plot(x(i,1), y(i,1),'ko');
    if (x(i,1) < minX) minX = x(i,1);
    end
        if (x(i,1) > maxX) maxX = x(i,1);
        end
            if (y(i,1) < minY) minY = y(i,1);
            end
                if (y(i,1) > maxY) maxY = y(i,1);
                end
    Coordinates(i,1) = x(i);
    Coordinates(i,2) = y(i);

end
minX = minX-200;
maxX = maxX+200;
minY = minY-200;
maxY = maxY+200;

Coordinates(n+1,1) = minX;
Coordinates(n+1,2) = minY;

Coordinates(n+2,1) = minX;
Coordinates(n+2,2) = maxY;

Coordinates(n+3,1) = maxX;
Coordinates(n+3,2) = maxY;

Coordinates(n+4,1) = maxX;
Coordinates(n+4,2) = minY;

plot ([minX minX],[minY maxY],'k');
plot ([minX maxX],[maxY maxY],'k');
plot ([maxX maxX],[maxY minY],'k');
plot ([minX maxX],[minY minY],'k');
plot ([minX maxX],[maxY minY],'k');

arrR(coun,1)=n+1;
arrR(coun,2)=n+2;
arrR(coun,1:2)=sort(arrR(coun,1:2));
arrR(coun+1,1)=n+2;
arrR(coun+1,2)=n+3;
arrR(coun+1,1:2)=sort(arrR(coun+1,1:2));
arrR(coun+2,1)=n+3;
arrR(coun+2,2)=n+4;
arrR(coun+2,1:2)=sort(arrR(coun+2,1:2));
arrR(coun+3,1)=n+1;
arrR(coun+3,2)=n+4;
arrR(coun+3,1:2)=sort(arrR(coun+3,1:2));
arrR(coun+4,1)=n+2;
arrR(coun+4,2)=n+4;
arrR(coun+4,1:2)=sort(arrR(coun+4,1:2));

s(coun)=Createstr(2,3,5);

plot(s(coun).CO(1),s(coun).CO(2),'o');
coun=coun+1;
s(coun)=Createstr(1,4,5);


for i = n+1:length(Coordinates)
    EdgePoints(i)=plot(Coordinates(i,1), Coordinates(i,2),'ko');
end

    for i=1:n
    plot(Coordinates(i,1), Coordinates(i,2),'ro');    
    Tria(i,1);
    end   
    
    function Tria (numbPoint,numbStr) 
    for lf= 5:length(arrR)    
    [ToF]=DoesItBelong(Coordinates(numbPoint,1:2),lf);
    if ToF==1
        for lg=1:coun
            if lf==s(lg).R1
            RemNumb1=lg;
            elseif lf==s(lg).R2
            RemNumb1=lg;
            elseif lf==s(lg).R3
            RemNumb1=lg;
            end
        end
        for lg=1:coun
            if lf==s(lg).R1
                if lg==RemNumb1
                    continue;
                end
            RemNumb2=lg;
            elseif lf==s(lg).R2
                if lg==RemNumb1
                    continue;
                end
            RemNumb2=lg;
            elseif lf==s(lg).R3
                if lg==RemNumb1
                    continue;
                end
            RemNumb2=lg;
            end
        end
        k11=[numbPoint,s(RemNumb1).nA];
        k11=sort(k11);
        arrR(end+1,1:2)=k11;
        NubmArR1=length(arrR);
        k12=[numbPoint,s(RemNumb1).nB];
        k12=sort(k12);
        arrR(end+1,1:2)=k12;
        NubmArR2=length(arrR);
        
        k21=[s(RemNumb1).nA,s(RemNumb1).nB];
        k21=sort(k21);
        
        k13=[numbPoint,s(RemNumb1).nC];
        k13=sort(k13);
        arrR(end+1,1:2)=k13;
        NubmArR3=length(arrR);
        
        k22=[s(RemNumb1).nB,k13(1,2)];
        k22=sort(k22);
        
        if s(RemNumb2).nA~=arrR(lf,1)&&s(RemNumb2).nA~=arrR(lf,2)
        k14=[numbPoint,s(RemNumb2).nA];
        k14=sort(k14);
        arrR(end+1,1:2)=k14;
        elseif s(RemNumb2).nB~=arrR(lf,1)&&s(RemNumb2).nB~=arrR(lf,2)
        k14=[numbPoint,s(RemNumb2).nB];
        k14=sort(k14);
        arrR(end+1,1:2)=k14;
        elseif s(RemNumb2).nC~=arrR(lf,1)&&s(RemNumb2).nC~=arrR(lf,2)
        k14=[numbPoint,s(RemNumb2).nC];
        k14=sort(k14);
        arrR(end+1,1:2)=k14;
        end
        
        k23=[s(RemNumb1).nC,k13(1,2)];
        k23=sort(k23);
        
        k24=[k13(1,2),s(RemNumb1).nA];
        k24=sort(k24);
        
        NubmArR4=length(arrR);
        
        for b1=1:length(arrR)
           if all(k11(1,1:2)==arrR(b1,1:2))
               m11=b1;
           elseif all(k12(1,1:2)==arrR(b1,1:2))
               m12=b1;
           elseif all(k13(1,1:2)==arrR(b1,1:2))
               m13=b1;
           elseif all(k14(1,1:2)==arrR(b1,1:2))
               m14=b1;
           end
           if all(k21(1,1:2)==arrR(b1,1:2))
               m21=b1;
           elseif all(k22(1,1:2)==arrR(b1,1:2))
               m22=b1;
           elseif all(k23(1,1:2)==arrR(b1,1:2))
               m23=b1;
           elseif all(k24(1,1:2)==arrR(b1,1:2))
               m24=b1;
           end
           
        end
        s(end+1)=Createstr(m11,m12,m21);
        s(end+1)=Createstr(m12,m13,m22);
        s(end+1)=Createstr(m13,m14,m23);
        s(end+1)=Createstr(m14,m11,m24);
        
        
        arrPlot(NP)=plot([s(RemNumb1).A(1,1) Coordinates(numbPoint,1)],[s(RemNumb1).A(1,2) Coordinates(numbPoint,2)],'k');
        NP=NP+1;
        arrPlot(NP)=plot([s(RemNumb1).B(1,1) Coordinates(numbPoint,1)],[s(RemNumb1).B(1,2) Coordinates(numbPoint,2)],'k');
        NP=NP+1;
        arrPlot(NP)=plot([s(RemNumb1).C(1,1) Coordinates(numbPoint,1)],[s(RemNumb1).C(1,2) Coordinates(numbPoint,2)],'k');
        NP=NP+1;
        arrPlot(NP)=plot([Coordinates(k14(1,2),1) Coordinates(numbPoint,1)],[Coordinates(k14(1,2),2) Coordinates(numbPoint,2)],'k');
        NP=NP+1;

        s(RemNumb1)=[];
        s(RemNumb2)=[];
        arrR(lf)=[];
        return;
    end
    end
    [isInSegment1]=DidItCross(Coordinates(numbPoint,1),Coordinates(numbPoint,2),s(numbStr).A(1,1),s(numbStr).B(1,1),s(numbStr).A(1,2),s(numbStr).B(1,2),s(numbStr).CO(1),s(numbStr).CO(2));
    [isInSegment2]=DidItCross(Coordinates(numbPoint,1),Coordinates(numbPoint,2),s(numbStr).B(1,1),s(numbStr).C(1,1),s(numbStr).B(1,2),s(numbStr).C(1,2),s(numbStr).CO(1),s(numbStr).CO(2));
    [isInSegment3]=DidItCross(Coordinates(numbPoint,1),Coordinates(numbPoint,2),s(numbStr).C(1,1),s(numbStr).A(1,1),s(numbStr).C(1,2),s(numbStr).A(1,2),s(numbStr).CO(1),s(numbStr).CO(2));
    
    for p=1:length(Coordinates)
            if all(s(numbStr).A(1,1:2)==Coordinates(p,1:2))
                newCOEF1=p;
            elseif all(s(numbStr).B(1,1:2)==Coordinates(p,1:2))
                newCOEF2=p;
            elseif all(s(numbStr).C(1,1:2)==Coordinates(p,1:2))
                newCOEF3=p;
            end
    end
    NewArrPer1=0;
    NewArrPer2=0;
    NewArrPer3=0;
    NewArrR1=[newCOEF1,newCOEF2];
    NewArrR1=sort(NewArrR1);
    NewArrR2=[newCOEF2,newCOEF3];
    NewArrR2=sort(NewArrR2);
    NewArrR3=[newCOEF1,newCOEF3];
    NewArrR3=sort(NewArrR3);
    
    for l=1:length(arrR)
        if all(NewArrR1(1,1:2)==arrR(l,1:2))
            NewArrPer1=l;
        elseif all(NewArrR2(1,1:2)==arrR(l,1:2))
            NewArrPer2=l;
        elseif all(NewArrR3(1,1:2)==arrR(l,1:2))
            NewArrPer3=l;
        end
    end
      if isInSegment1==1
      for k=1:coun
          if k==numbStr
              continue;
          end
          if s(k).R1==NewArrPer1
              numbStr=k;
              Tria (numbPoint,numbStr);
              break;
          elseif s(k).R2==NewArrPer1
              numbStr=k;
              Tria (numbPoint,numbStr);
              break;
          elseif s(k).R3==NewArrPer1
              numbStr=k;
              Tria (numbPoint,numbStr);
              break;
          end
      end
      elseif isInSegment2==1
      for k=1:coun
          if k==numbStr
              continue;
          end
          if s(k).R1==NewArrPer2
              numbStr=k;
              Tria (numbPoint,numbStr);
              break;
          elseif s(k).R2==NewArrPer2
              numbStr=k;
              Tria (numbPoint,numbStr);
              break;
          elseif s(k).R3==NewArrPer2
              numbStr=k;
              Tria (numbPoint,numbStr);
              break;
          end
      end
      elseif isInSegment3==1
      for k=1:coun
          if k==numbStr
              continue;
          end
          if s(k).R1==NewArrPer3
              numbStr=k;
              Tria (numbPoint,numbStr);
              break;
          elseif s(k).R2==NewArrPer3
              numbStr=k;
              Tria (numbPoint,numbStr);
              break;
          elseif s(k).R3==NewArrPer3
              numbStr=k;
              Tria (numbPoint,numbStr);
              break;
          end
      end 
      else 
       arrPlot(NP)=plot([s(numbStr).A(1,1) Coordinates(numbPoint,1)],[s(numbStr).A(1,2) Coordinates(numbPoint,2)],'k'); 
       NP=NP+1;
       arrPlot(NP)=plot([s(numbStr).B(1,1) Coordinates(numbPoint,1)],[s(numbStr).B(1,2) Coordinates(numbPoint,2)],'k');
       NP=NP+1;
       arrPlot(NP)=plot([s(numbStr).C(1,1) Coordinates(numbPoint,1)],[s(numbStr).C(1,2) Coordinates(numbPoint,2)],'k');
       NP=NP+1;
       Index1=0;
       Index2=0;
       Index3=0;
       for h=1:length(Coordinates)
       if all(s(numbStr).A(1,1:2)==Coordinates(h,1:2))
          Index1=h;
       elseif all(s(numbStr).B(1,1:2)==Coordinates(h,1:2))
          Index2=h;
       elseif all(s(numbStr).C(1,1:2)==Coordinates(h,1:2))
          Index3=h;
       end
       end
       
       k1=[i,Index1];
       k1=sort(k1);
       arrR(end+1,1:2)=k1;
       coun=coun+1;
       k2=[i,Index2];
       k2=sort(k2);
       arrR(end+1,1:2)=k2;
       coun=coun+1;
       k3=[i,Index3];
       k3=sort(k3);
       arrR(end+1,1:2)=k3;
       coun=coun+1;
       for b=1:length(arrR)
           if all(k1(1,1:2)==arrR(b,1:2))
               m1=b;
           elseif all(k2(1,1:2)==arrR(b,1:2))
               m2=b;
           elseif all(k3(1,1:2)==arrR(b,1:2))
               m3=b;
           end
       end
       s(end+1)=Createstr(NewArrPer1,m1,m2);
       s(end+1)=Createstr(NewArrPer2,m2,m3);
       s(end+1)=Createstr(NewArrPer3,m1,m3);
       s(numbStr)=[];
       coun=coun-1;  
      end
    end
     
    function [Xcen, Ycen] = Coord(cor1,cor2,cor3)
    a=sqrt((cor1(1,1)-cor3(1,1))^2+(cor1(1,2)-cor3(1,2))^2);
    b=sqrt((cor2(1,1)-cor1(1,1))^2+(cor2(1,2)-cor1(1,2))^2);
    c=sqrt((cor3(1,1)-cor2(1,1))^2+(cor3(1,2)-cor2(1,2))^2);

    Xcen = (a * cor2(1,1) + b * cor3(1,1) + c * cor1(1,1))/(a + b + c);
    Ycen = (a * cor2(1,2) + b * cor3(1,2) + c * cor1(1,2))/(a + b + c);
    end

    function [isInSegment] = DidItCross (x1,y1,xm2,mx2,ym2,my2,xx1,yy1)
        arrX=[xm2 xx1; mx2 x1];
        arrY=[ym2 yy1; my2 y1];
        dx = diff(arrX);  %# Take the differences down each column
        dy = diff(arrY);
        den = dx(1)*dy(2)-dy(1)*dx(2);  %# Precompute the denominator
        ua = (dx(2)*(arrY(1)-arrY(3))-dy(2)*(arrX(1)-arrX(3)))/den;
        ub = (dx(1)*(arrY(1)-arrY(3))-dy(1)*(arrX(1)-arrX(3)))/den;
        isInSegment = all(([ua ub] > 0) & ([ua ub] < 1));
    end
    
    function [ToF]=DoesItBelong (Co, NumR)
        newRub=(Co(1,1)-Coordinates(arrR(NumR,1),1))/(Coordinates(arrR(NumR,2),1)-Coordinates(arrR(NumR,1),1))-(Co(1,2)-Coordinates(arrR(NumR,1),2))/(Coordinates(arrR(NumR,2),2)-Coordinates(arrR(NumR,1),2));
        if newRub<Eps&&newRub>-Eps
            ToF=1;
        else 
            ToF=0;
        end
    end

    function [isInCircle] = DidItCross2(PointCenter,PointCor,Radius)
        d=sqrt((PointCenter(1,1)-PointCor(1,1))^2+(PointCenter(1,2)-PointCor(1,2))^2);
        if d<=Radius
        isInCircle=0;
        else
        isInCircle=1;
        end
    end
    function [s]=Createstr(indR1,indR2,indR3)
        s(1).R1=indR1;
        s(1).R2=indR2;
        s(1).R3=indR3;
        a(1,1)=Coordinates(arrR(indR1,1),1);
        a(1,2)=Coordinates(arrR(indR1,1),2);
        
        s(1).A=a;
        b(1,1)=Coordinates(arrR(indR1,2),1);
        b(1,2)=Coordinates(arrR(indR1,2),2);
        s(1).B=b;
        if (arrR(indR1,2)~=arrR(indR2,1))&&(arrR(indR1,1)~=arrR(indR2,1))
        c(1,1)=Coordinates(arrR(indR2,1),1);
        c(1,2)=Coordinates(arrR(indR2,1),2);
        elseif (arrR(indR1,2)~=arrR(indR2,2))&&(arrR(indR1,1)~=arrR(indR2,2))
        c(1,1)=Coordinates(arrR(indR2,2),1);
        c(1,2)=Coordinates(arrR(indR2,2),2);
        elseif (arrR(indR1,2)~=arrR(indR3,1))&&(arrR(indR1,1)~=arrR(indR3,1))
        c(1,1)=Coordinates(arrR(indR3,1),1);
        c(1,2)=Coordinates(arrR(indR3,1),2);
        elseif (arrR(indR1,2)~=arrR(indR3,2))&&(arrR(indR1,1)~=arrR(indR3,2))
        c(1,1)=Coordinates(arrR(indR3,2),1);
        c(1,2)=Coordinates(arrR(indR3,2),2);
        end
        s(1).C=c;
        for ker=1:length(Coordinates)
            if all(s(1).A(1,1:2)==Coordinates(ker,1:2))
            s(1).nA=ker;
            elseif all(s(1).B(1,1:2)==Coordinates(ker,1:2))
            s(1).nB=ker;
            elseif all(s(1).C(1,1:2)==Coordinates(ker,1:2))
            s(1).nC=ker;
            end
        end
        
        [xn,yn]=Coord(a,b,c);
        s(1).CO=[xn,yn];
        plot(s(1).CO(1),s(1).CO(2),'o');
    end
end