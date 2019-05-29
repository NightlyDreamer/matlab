function Tria
f = figure('Position',[45,100,1100,510],'menubar','none');

hold on
n=50;
EdgePoints=0;
Counter=1;
Check=0;
ArrCoord=[];


X = randi([-10 10],n,2)
for i = 1:size(X,1)
    h(:,i) = sqrt((X(:,1)-X(i,1)).^2+(X(:,2)-X(i,2)).^2);
    h(1:i,i)=0;
end
[B,IND] = sort(h(:));
s=[n,n]
[I,J] = ind2sub(s,IND)
for i=1:n
    EdgePoints(i)=plot(X(:,1),X(:,2),'ko');
end
for i=1:size(B,1)
   if(B(i,1)~=0)
       if Check == 0
           PlotArr(Counter)=plot([X(I(i,1),1) X(J(i,1),1)],[X(I(i,1),2) X(J(i,1),2)],'k');
           ArrCoord(Counter,1)=X(I(i,1),1);
           ArrCoord(Counter,2)=X(J(i,1),1);
           ArrCoord(Counter,3)=X(I(i,1),2);
           ArrCoord(Counter,4)=X(J(i,1),2);
          Check=1;
       else 
          for j=1:Counter
               arrX=[X(I(i,1),1) ArrCoord(j,1); X(J(i,1),1) ArrCoord(j,2)];
               arrY=[X(I(i,1),2) ArrCoord(j,3); X(J(i,1),2) ArrCoord(j,4)];
               dx = diff(arrX);
               dy = diff(arrY);
               den = dx(1)*dy(2)-dy(1)*dx(2);
               ua = (dx(2)*(arrY(1)-arrY(3))-dy(2)*(arrX(1)-arrX(3)))/den;
               ub = (dx(1)*(arrY(1)-arrY(3))-dy(1)*(arrX(1)-arrX(3)))/den;
               isInSegment = all(([ua ub] > 0) & ([ua ub] < 1));
             if(isInSegment == 1)
                   break;
             else
               if(j == Counter)
                  Counter =Counter+1;
                  ArrCoord(Counter,1)=X(I(i,1),1);
                  ArrCoord(Counter,2)=X(J(i,1),1);
                  ArrCoord(Counter,3)=X(I(i,1),2);
                  ArrCoord(Counter,4)=X(J(i,1),2);
                  PlotArr(Counter)=plot([X(I(i,1),1) X(J(i,1),1)],[X(I(i,1),2) X(J(i,1),2)],'k');
               else continue;
               end
             end
          end
       end
   end
end