function binary_segmentation
f= figure('units','pixels','position',[100 100 1000 600],'menubar','none');
ax=axes('units','pixels','position',[330 20 660 570])%,'xtick',[],'ytick',[]);

tb=uitoolbar(f);
img = double(imread('C:\Users\Admin\Desktop\Новая папка (3)\icons\file_open.png','backgroundcolor',get(f,'Color')))/65536;
[img_2,map]=(imread('C:\Users\Admin\Desktop\Новая папка (3)\icons\tool_rectangle.gif'));
icon = ind2rgb(img_2,map);

bt_open=uipushtool(tb,'clickedcallback',@open_image,'CData',img);
bt_mask=uitoggletool(tb,'clickedcallback',@create_mask,'CData',icon);

sld = uicontrol('Style', 'slider',...
        'Min',0,'Max',256,'Value',150,...
        'Position', [20 20 250 20],...
        'Callback', @surfzlim);
txt_3 = uicontrol('Style','text',...
        'Position',[20 45 100 20],...
        'String','Порог (0-256)',...
        'HorizontalAlignment','left');
    
txt_1 = uicontrol('Style','text',...
        'Position',[20 120 100 20],...
        'String','Ошибка',...
        'HorizontalAlignment','left');
edit_1 = uicontrol('Style','edit',...
        'Position',[160 120 40 20],...
        'String','45');
    
txt_2 = uicontrol('Style','text',...
        'Position',[20 80 200 20],...
        'String','Количество итераций',...
        'HorizontalAlignment','left');
edit_2 = uicontrol('Style','edit',...
        'Position',[160 80 40 20],...
        'String','1');
    
ch_b = uicontrol('Style','checkbox',...
        'Position',[20 160 200 20],...
        'Callback', @ch_box,'String','Промежуточный результат',...
        'HorizontalAlignment','left');
    
txt_4 = uicontrol('Style','text',...
        'Position',[20 200 100 20],...
        'String','Весовой коэф-т',...
        'HorizontalAlignment','left');
edit_4 = uicontrol('Style','edit',...
        'Position',[160 200 40 20],...
        'String','0.5');    

txt_5 = uicontrol('Style','text',...
        'Position',[20 240 100 20],...
        'String','ITS',...
        'HorizontalAlignment','left');
edit_5 = uicontrol('Style','edit',...
        'Position',[160 240 40 20],...
        'String','20');    
    
im=0;rct=0;F=0;

function open_image(~,~)
% [fn,path,fi]=uigetfile;
% if ~fn==0
% fn=[path,'\',fn];

   fn='C:\Users\Admin\Desktop\Новая папка (3)\3.jpg';
   im=imread(fn);
   im=rgb2gray(im);
   imshow(im)
end

function create_mask(~,~)
    set(f,'pointer','crosshair','windowbuttondownfcn',@mwbd)
end

function mwbd(~,~)
        firstpoint=get(ax,'currentpoint');
        rect=rectangle('position',[firstpoint(1,1),firstpoint(1,2),1,1]);
        set(f,'windowbuttonmotionfcn',@mwbm,'windowbuttonupfcn',@mwbu)
        function mwbm(~,~)
            cp=get(ax,'currentpoint');
            w=abs(cp(1,1)-firstpoint(1,1));
            h=abs(cp(1,2)-firstpoint(1,2));
            l=min(firstpoint(1,1),cp(1,1));
            r=min(firstpoint(1,2),cp(1,2));
            rct=floor([l,r,w,h]);
            set(rect,'position',rct)
        end
        function mwbu(~,~)
            set(f,'pointer','arrow','windowbuttondownfcn','','windowbuttonmotionfcn','','windowbuttonupfcn','')
            Mask_m=false(size(im,1),size(im,2));
            Mask_m(size(im,1)-rct(2)-rct(4):size(im,1)-rct(2),rct(1):rct(1)+rct(3))=1;
%             im(Mask_m)=0;imshow(im)

            DMat=double(bwdist(Mask_m)-bwdist(1-Mask_m)); % (получение SDF)- маркированая карта растояний
            eps=str2double(get(edit_1,'string'));%ошибка
            thr=get(sld,'value');%Порог
            a=str2double(get(edit_4,'string'));%весовой коэффициент
            N=str2double(get(edit_2,'string'));%кол-во итераций            
                
            for i=1:N
                
                DFun=double(eps-(abs(flipud(im)-thr))); %D(I)
                H = curvature(DMat); %кривизна
                F =((a.*DFun)+(1-a)*H); %Коэффициент скорости 
                
                grad=gradF(DMat);
                dt =.5/max(max(max(abs(F.*grad))));
                
                DMat = DMat + dt.*(F).*grad;
 
     
              [x,y]=meshgrid(1:819 ,1:460);%график
               mesh(x,y,double(DMat));
               rotate3d
%                 contour(DMat,[0 0])
                axis equal
                drawnow
            end    
%             l=(repmat(Mask_m,[1 1 3]));
%             im(l)=0;
%             imshow(im)

        end
        function M=shift(l,M) %вычисление производных с помощью сдвига матриц 
           if l==0  %left
              M(:,1:end-1) = M(:,2:end);
           elseif  l==1   %right
              M(:,2:end) = M(:,1:end-1);
           elseif l==2   %up
              M(1:end-1,:) = M(2:end,:);
           elseif l==3   %down
              M(2:end,:) = M(1:end-1,:);
           end
        end

    function H=curvature(M)%кривизна 
        
        DX=(shift(1,M)-shift(0,M))/2;
        DY=(shift(2,M)-shift(3,M))/2;               
        %/2 
        DXp=(shift(1,M)-M);
        DYp=(shift(2,M)-M);
        DXm=(M-shift(0,M));        
        DYm=(M-shift(3,M));
        
        DXpY=(shift(2,shift(1,M))-shift(2,shift(0,M)))/2;
        DXmY=(shift(3,shift(1,M))-shift(3,shift(0,M)))/2;
        DYpX=(shift(1,shift(2,M))-shift(1,shift(3,M)))/2;
        DYmX=(shift(0,shift(2,M))-shift(0,shift(3,M)))/2;              
        
        %Значение Нормалей n+.n-.
        NpX=DXp./sqrt(eps+(DXp.^2)+((DYpX+DY)/2).^2);
        NpY=DYp./sqrt(eps+(DYp.^2)+((DXpY+DX)/2).^2);
        NmX=DXm./sqrt(eps+(DXm.^2)+((DYmX+DY)/2).^2);
        NmY=DYm./sqrt(eps+(DYm.^2)+((DXmY+DX)/2).^2);
        
        H=((NpX-NmX)+(NpY-NmY))/2;        
    end

    function grad=gradF(M)%градиент
        
        DXp=(shift(1,M)-M)/2;
        DXm=(M-shift(0,M))/2;
        DYp=(shift(2,M)-M)/2;
        DYm=(M-shift(3,M))/2;
        
        gradmax_x=sqrt(max(DXp,0).^2+max(-DXm,0).^2);
        gradmin_x=sqrt(min(DXp,0).^2+min(-DXm,0).^2);
        gradmax_y=sqrt(max(DYp,0).^2+max(-DYm,0).^2);
        gradmin_y=sqrt(min(DYp,0).^2+min(-DYm,0).^2);
        
        gradmax=sqrt((gradmax_x.^2)+(gradmax_y.^2));
        gradmin=sqrt((gradmin_x.^2)+(gradmin_y.^2));
        
        grad=(F>0).*(gradmax)+(F<0).*(gradmin);      
        
    end
end
    
end