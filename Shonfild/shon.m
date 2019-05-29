function shon

h = figure('Units','pixels','Position', [400 200 600 400], 'Resize', 'off', 'Toolbar', 'none', 'MenuBar', 'none');
% TOOLBAR start
toolBar = uitoolbar(h);
%1st icon
imgFileOpen = double(imread('file_open.png'))/65536;
imgFileOpen(imgFileOpen==0)=0.9;
pFileOpen = uipushtool(toolBar, 'ClickedCallback', @openFile);
pFileOpen.CData = imgFileOpen;
%2nd icon
imgFileSave = double(imread('file_save.png'))/65536;
imgFileSave(imgFileSave==0)=0.9;
pFileSave = uipushtool(toolBar, 'ClickedCallback', @saveFile);
pFileSave.CData = imgFileSave; 
%TOOLBAR end
labelCommandBox = uicontrol('Style', 'text', 'Position', [50 360 100 20], 'String', 'Commands');
commandBox = uicontrol('Style','edit', 'Position', [10 40 200 300], 'HorizontalAlignment', 'left', 'Max', 2);
startBtn = uicontrol('Style', 'pushbutton', 'String', 'Start', 'Position', [70 10 50 25], 'Callback', @run);
tableArray = zeros(1, 1000);
table = uitable(h,'Data', tableArray, 'Position', [230 300 370 60], 'UserData', 'array', 'ColumnEditable', true(size(tableArray)));
macrosField = uicontrol('Style','edit', 'Position', [230 40 370 250], 'HorizontalAlignment', 'left', 'Max', 2);
resultText = uicontrol('Style', 'text', 'Position', [230 10 200 20], 'String', 'Result', 'BackgroundColor', 'w', 'HorizontalAlignment', 'left', 'FontSize', 12);




function openFile(~,~)
[file,path] = uigetfile('*.txt');
fileID = fopen(path,'r');
formatSpec = '%s'; 
A = fscanf(fileID,formatSpec);

end

function saveFile(~,~)
    
            yy={'*.txt','Text'};
        [filename, pathname] = uiputfile(yy,'Pick a file');
        
        if strcmp(filename(end-2:end),'txt')
            fd = (get(commandBox,'string'));
            fileID = fopen([pathname,filename],'w');
            for i=1:size(fd,1)
            fprintf(fileID,'%s',fd(i,:));
            fprintf(fileID,'\n');
            end
            fclose(fileID);
        end
end

function run(~,~)
parse();


function parse(~,~)
i = 1;
j = 1;
numbRegistr = 0;
Counter = 1;
numbForCounter = 1;

text = (get(commandBox,'String'));
while i<=size(text,1) 
while text(i,j) ~= ';'
    comand(j) = text(i,j); 
    j = j+1;
end
    i = i+1;
    j = 1;
    if (comand(1) == 'I')
       numbRegistr = str2num(comand(5)); 
       Counter = Counter + 1;
       table.Data(numbRegistr) = table.Data(numbRegistr) + 1;
    elseif (comand(1) == 'D')
        numbRegistr = str2num(comand(5));
        numbForCounter = str2num(comand(8));
        if (table.Data(numbRegistr) > 0 )
            table.Data(numbRegistr) = table.Data(numbRegistr) - 1;
            Counter = numbForCounter;
            i = numbForCounter;
        elseif(table.Data(numbRegistr) == 0)
            Counter = Counter + 1;
            i = i +1; 
        end
               
    end
   comand = ' ';
end
 resultText.String = num2str(table.Data(1));
end
   
end
end



