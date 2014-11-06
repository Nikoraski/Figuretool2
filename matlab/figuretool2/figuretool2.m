function varargout = figuretool2(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @figuretool2_OpeningFcn, ...
   'gui_OutputFcn',  @figuretool2_OutputFcn, ...
   'gui_LayoutFcn',  [] , ...
   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
   [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
   gui_mainfcn(gui_State, varargin{:});
end

function figuretool2_OpeningFcn(hObject, eventdata, handles, varargin)
clear -global;
handles.output = hObject;
set(hObject,'Userdata',false);
guidata(hObject, handles);
funclistbox=handles.funclistbox;
jScrollPane = findjobj(funclistbox);
jListbox = jScrollPane.getViewport.getComponent(0);
jListbox = handle(jListbox, 'CallbackProperties');
set(jListbox, 'MousePressedCallback',{@mouseMovedCallback,funclistbox});
globalinit(handles);
constinit();

function globalinit(handles)
global functionlist fcnmovielist fgtfilename fgtpathname atomlist unitcell unitcelllist elemlist unitcellset xyzlist elemnolist coordtype...
   modified templatefile CPdata CMdata mu3data raMOdata XSFdata MOdata globallp globalfl usedlist bondlist imgbound cellbound res figurestack...
   figres camparam grouparray grouplist lighthdl objlist templatelist CPdatalist CMdatalist raMOdatalist mu3datalist XSFdatalist MOdatalist;
functionlist={};
fcnmovielist={};
modified=false;
templatefile='';
atomlist={};
unitcell=[];
unitcelllist=[];
unitcellset=[];
elemnolist=[];
elemlist={};
usedlist=[];
bondlist=[];
imgbound=[Inf,Inf,Inf,-Inf,-Inf,-Inf];
cellbound=[Inf,Inf,Inf,-Inf,-Inf,-Inf];
objlist={};
figurestack=cell(0,2);
xyzlist=[];
CPdata='';
CMdata='';
mu3data='';
raMOdata='';
XSFdata='';
MOdata='';
templatelist='';
CPdatalist='';
CMdatalist='';
raMOdatalist='';
mu3datalist='';
XSFdatalist='';
MOdatalist='';
fgtfilename='';
fgtpathname='';
globallp='default';
globalfl='gouraud';
coordtype='';
grouparray=[];
grouplist=cell(0,2);
lighthdl=[];
res=10;
figres=600;
camparam=struct('cv',[8,3,1],'cu',[0,0,1],'cp','default','ct','default','cr','default','cva','default',...
   'cz',1.0,'pt','orthographic','ld',[5,10,4],'lt','parallel','lc','relative','adv','off');
set(handles.funclistbox,'string',{});
set(handles.funclistbox,'value',1);
set(handles.figuretool2,'name','Untitled - Figuretool2');
exportupdate(handles);

function constinit()
global elemname CPKcolor metalrad atomrad vdwrad VEC;
elemname={'&','Dummy','H','He','Li','Be','B','C','N','O','F','Ne','Na','Mg','Al','Si','P','S','Cl','Ar','K','Ca',...
   'Sc','Ti','V','Cr','Mn','Fe','Co','Ni','Cu','Zn','Ga','Ge','As','Se','Br','Kr','Rb','Sr','Y','Zr','Nb','Mo',...
   'Tc','Ru','Rh','Pd','Ag','Cd','In','Sn','Sb','Te','I','Xe','Cs','Ba','La','Ce','Pr','Nd','Pm','Sm','Eu','Gd',...
   'Tb','Dy','Ho','Er','Tm','Yb','Lu','Hf','Ta','W','Re','Os','Ir','Pt','Au','Hg','Tl','Pb','Bi','Po','At','Rn','Fr',...
   'Ra','Ac','Th','Pa','U','Np','Pu','Am'};
CPKcolor={[0,0,0],[0,0,0],[255,255,255],[217,255,255],[204,128,255],[194,255,0],[255,181,181],[144,144,144],[48,80,248],...
   [255,13,13],[144,224,80],[179,227,245],[171,92,242],[138,255,0],[191,166,166],[240,200,160],[255,128,0],[255,255,48],...
   [31,240,31],[128,209,227],[143,64,212],[61,255,0],[230,230,230],[191,194,199],[166,166,171],[138,153,199],[156,122,199],...
   [224,102,51],[240,144,160],[80,208,80],[200,128,51],[125,128,176],[194,143,143],[102,143,143],[189,128,227],[255,161,0],...
   [166,41,41],[92,184,209],[112,46,176],[0,255,0],[148,255,255],[148,224,224],[115,194,201],[84,181,181],[59,158,158],...
   [36,143,143],[10,125,140],[0,105,133],[192,192,192],[255,217,143],[166,117,115],[102,128,128],[158,99,181],[212,122,0],...
   [148,0,148],[66,158,176],[87,23,143],[0,201,0],[112,212,255],[255,255,199],[217,255,199],[199,255,199],[163,255,199],...
   [143,255,199],[97,255,199],[69,255,199],[48,255,199],[31,255,199],[0,255,156],[0,230,117],[0,212,82],[0,191,56],[0,171,36],...
   [77,194,255],[77,166,255],[33,148,214],[38,125,171],[38,102,150],[23,84,135],[208,208,224],[255,209,35],[184,184,208],...
   [166,84,77],[87,89,97],[158,79,181],[171,92,0],[117,79,69],[66,130,150],[66,0,102],[0,125,0],[112,171,250],[0,186,255],...
   [0,161,255],[0,143,255],[0,128,255],[0,107,255],[84,92,242]};
metalrad=[0.5,1.0,0.75,1.0,1.52,1.12,1.0,1.0,1.0,1.0,1.0,1.0,1.86,1.6,1.43,1.3,1.2,1.2,1.1,1.1,2.27,1.97,1.62,1.47,1.34,1.28,1.27,1.26,1.25,1.24,...
   1.28,1.34,1.35,1.3,1.3,1.4,1.4,1.4,2.48,2.15,1.8,1.6,1.46,1.39,1.36,1.34,1.34,1.37,1.44,1.51,1.67,1.6,1.6,1.6,1.6,1.6,2.65,2.22,1.87,1.818,...
   1.824,1.814,1.834,1.804,2.084,1.804,1.773,1.781,1.762,1.761,1.759,1.933,1.738,1.59,1.46,1.39,1.37,1.35,1.355,1.385,1.44,1.51,1.6,1.7,1.78,1.68,...
   1.5,2.9,2.4,1.9,1.8,1.64,1.54,1.55,1.59,1.73];
atomrad=[0.5,1.0,0.25,0.31,1.45,1.05,0.85,0.7,0.65,0.6,0.5,0.38,1.8,1.5,1.25,1.1,1,1,1,0.71,2.2,1.8,1.6,1.4,1.35,1.4,1.4,1.4,1.35,1.35,1.35,1.35,...
   1.3,1.25,1.15,1.15,1.15,0.88,2.35,2,1.8,1.55,1.45,1.45,1.35,1.3,1.35,1.4,1.6,1.55,1.55,1.45,1.45,1.4,1.4,1.08,2.6,2.15,1.95,1.85,1.85,1.85,...
   1.85,1.85,1.85,1.8,1.75,1.75,1.75,1.75,1.75,1.75,1.75,1.55,1.45,1.35,1.35,1.3,1.35,1.35,1.35,1.5,1.9,1.8,1.6,1.9,1.9,1.8,2.7,2.15,1.95,1.80,1.80,...
   1.75,1.75,1.75,1.75];
vdwrad=[0.5,0.5,1.10,1.40,1.81,1.53,1.92,1.70,1.55,1.52,1.47,1.54,2.27,1.73,1.84,2.10,1.80,1.80,1.75,1.88,2.75,2.31,2.28,2.14,2.03,1.97,1.96,1.96,...
   1.95,1.94,2.00,2.02,1.87,2.11,1.85,1.90,1.83,2.02,3.03,2.49,2.45,2.25,2.13,2.06,2.04,2.02,2.02,2.05,2.13,2.17,1.93,2.17,2.06,2.06,1.98,2.16,3.43,...
   2.68,2.51,2.47,2.44,2.41,2.38,2.35,2.32,2.30,2.28,2.26,2.24,2.22,2.21,2.21,2.22,2.24,2.13,2.07,2.05,2.03,2.03,2.06,2.13,2.17,1.96,2.02,2.07,1.97,...
   2.02,2.20,3.48,2.83,2.65,2.61,2.57,2.53,2.49,2.45,2.41];
VEC=[0,0,1,0,1,2,3,4,5,6,7,0,1,2,3,4,5,6,7,0,1,2,3,4,5,6,7,8,9,10,11,2,3,4,5,6,7,0,1,2,3,4,5,6,7,8,9,10,11,2,3,4,5,6,7,0,1,2,3,4,5,6,7,8,9,10,11,12,13,...
   14,15,16,17,4,5,6,7,8,9,10,11,2,3,4,5,6,7,0,1,2,3,4,5,6,7,8,9];

function varargout = figuretool2_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

function funclistbox_Callback(hObject, eventdata, handles)

function funclistbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end

function mouseMovedCallback(jListbox, jEventData, hListbox)
% Get the currently-hovered list-item
mousePos = java.awt.Point(jEventData.getX, jEventData.getY);
hoverIndex = jListbox.locationToIndex(mousePos) + 1;
listValues = get(hListbox,'string');
if isempty(listValues) set(hListbox, 'Tooltip',''); return; end
msgStr=gettooltip(hoverIndex);
set(hListbox, 'Tooltip',msgStr);

function tooltipstr=gettooltip(hoverindex)
global functionlist;
st0=functionlist{hoverindex};
tooltipstr0=['<html><b><u>',st0.function,'</b></u>: '];
tooltipstr='';
fields=fieldnames(st0);
for j=1:numel(fields)
   if strcmpi(fields{j},'function') continue; end
   tooltipstr=[tooltipstr,',<b>',upper(fields{j}),'</b>:'];
   if ischar(st0.(fields{j}))
      if numel(st0.(fields{j}))<=20 tooltipstr=[tooltipstr,'''',st0.(fields{j}),''''];
      else tooltipstr=[tooltipstr,'<i>string</i>'];
      end
   elseif isnumeric(st0.(fields{j}))
      if size(st0.(fields{j}),1)==1
         temp='';
         for k=1:size(st0.(fields{j}),2)
            if st0.(fields{j})(k)==round(st0.(fields{j})(k)) temp=[temp,',',sprintf('%d',st0.(fields{j})(k))];
            else temp=[temp,',',sprintf('%.2f',st0.(fields{j})(k))];
            end
         end
         if size(st0.(fields{j}),2)==1 tooltipstr=[tooltipstr,temp(2:end)];
         elseif numel(temp)<=20 tooltipstr=[tooltipstr,'[',temp(2:end),']'];
         else tooltipstr=[tooltipstr,'<i>array</i>'];
         end
      else tooltipstr=[tooltipstr,'<i>matrix</i>'];
      end
   else tooltipstr=[tooltipstr,'<i>cellarray</i>'];
   end
end
tooltipstr=[tooltipstr0,tooltipstr(2:end),'</html>'];

function funcadd_Callback(hObject, eventdata, handles)
global functionlist fcnmovielist modified;
h0=figuretool2_funclist;
uiwait(h0);
if ~ishandle(h0) return; end
functiontype=get(h0,'Userdata');
delete(h0);
if strcmpi(functiontype,'cancelled') return;
else
   if strcmpi(functiontype,'drawraMO')
      fcnnames=cellfun(@(x)x.function,functionlist,'UniformOutput',0);
      if ismember('drawraMO',fcnnames) waitfor(msgbox('Only one drawraMO function can exist in each file.','Figuretool2')); return; end
   end
   funchdl=str2func(functiontype);
   h0=funchdl(); uiwait(h0);
end
if ~ishandle(h0) return; end
st0=get(h0,'Userdata');
delete(h0);
if ischar(st0)&&strcmpi(st0,'cancelled') return; end
functionlist{end+1}=st0;
fcnmovielist{end+1}={1,st0,''};
h0=findobj('tag','funclistbox');
temp=get(h0,'string');
temp{end+1}=st0.function;
set(h0,'string',temp);
if numel(get(handles.funclistbox,'string'))==1 set(handles.funclistbox,'value',1); end
modified=true;

function funcmoveup_Callback(hObject, eventdata, handles)
global functionlist fcnmovielist modified;
listvalue=get(handles.funclistbox,'value');
liststring=get(handles.funclistbox,'string');
if (listvalue<=1)||(listvalue>numel(functionlist)) return; end
temp=liststring{listvalue};
liststring{listvalue}=liststring{listvalue-1};
liststring{listvalue-1}=temp;
set(handles.funclistbox,'string',liststring);
temp=functionlist{listvalue};
functionlist{listvalue}=functionlist{listvalue-1};
functionlist{listvalue-1}=temp;
temp=fcnmovielist{listvalue};
fcnmovielist{listvalue}=fcnmovielist{listvalue-1};
fcnmovielist{listvalue-1}=temp;
set(handles.funclistbox,'value',listvalue-1);
modified=true;

function funcdelete_Callback(hObject, eventdata, handles)
global functionlist fcnmovielist modified;
listvalue=get(handles.funclistbox,'value');
liststring=get(handles.funclistbox,'string');
if (listvalue<=0)||(listvalue>numel(functionlist)) return; end
liststring(listvalue)=[];
functionlist(listvalue)=[];
fcnmovielist(listvalue)=[];
set(handles.funclistbox,'value',max(1,min(listvalue,numel(liststring))));
set(handles.funclistbox,'string',liststring);
modified=true;

function funcmovedown_Callback(hObject, eventdata, handles)
global functionlist fcnmovielist modified;
listvalue=get(handles.funclistbox,'value');
liststring=get(handles.funclistbox,'string');
if (listvalue<=0)||(listvalue>numel(functionlist)-1) return; end
temp=liststring{listvalue};
liststring{listvalue}=liststring{listvalue+1};
liststring{listvalue+1}=temp;
set(handles.funclistbox,'string',liststring);
temp=functionlist{listvalue};
functionlist{listvalue}=functionlist{listvalue+1};
functionlist{listvalue+1}=temp;
temp=fcnmovielist{listvalue};
fcnmovielist{listvalue}=fcnmovielist{listvalue+1};
fcnmovielist{listvalue+1}=temp;
set(handles.funclistbox,'value',listvalue+1);
modified=true;

function funcedit_Callback(hObject, eventdata, handles)
global functionlist fcnmovielist modified;
listvalue=get(handles.funclistbox,'value');
if (listvalue<=0)||(listvalue>numel(functionlist)) return; end
funchdl=str2func(functionlist{listvalue}.function);
h0=funchdl('Userdata',functionlist{listvalue}); uiwait(h0);
if ~ishandle(h0) return; end
st0=get(h0,'Userdata');
delete(h0);
if ischar(st0)&&strcmpi(st0,'cancelled') return; end
functionlist{listvalue}=st0;
fcnmovielist{listvalue}{1,2}=st0;
modified=true;

% --------------------------------------------------------------------
function file_new_Callback(hObject, eventdata, handles)
% hObject    handle to file_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fgtfilename fgtpathname modified;
if modified
   while true
      button=questdlg('Do you wish to save the modifications to the current file?','Figuretool2','Cancel');
      if strcmpi(button,'Yes')
         if isempty(fgtfilename)
            [filename,pathname]=uiputfile({'*.fgt','Figuretool2 file (.fgt)'});
            if isnumeric(filename) continue;
            else savefile(filename,pathname); break;
            end
         else savefile(fgtfilename,fgtpathname); break;
         end
      elseif strcmpi(button,'Cancel')
         return;
      else break;
      end
   end
end
globalinit(handles);

% --------------------------------------------------------------------
function file_open_Callback(hObject, eventdata, handles)
% hObject    handle to file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global modified functionlist fgtfilename fgtpathname;
[filenamein,pathnamein]=uigetfile({'*.fgt','Figuretool2 file (.fgt)'},'Figuretool2');
if isnumeric(filenamein) return; end
if modified
   while true
      button=questdlg('Do you wish to save the modifications to the current file?','Figuretool2','Cancel');
      if strcmpi(button,'Yes')
         if isempty(fgtfilename)
            [filename,pathname]=uiputfile({'*.fgt','Figuretool2 file (.fgt)'});
            if isnumeric(filename) continue;
            else savefile(filename,pathname); break;
            end
         else savefile(fgtfilename,fgtpathname); break;
         end
      elseif strcmpi(button,'Cancel')
         return;
      else break;
      end
   end
end
globalinit(handles);
load([pathnamein,filenamein],'-mat');
if ~isempty(functionlist)
   fcnnames=cell(size(functionlist));
   for j=1:numel(fcnnames)
      fcnnames{j}=functionlist{j}.function;
   end
   set(handles.funclistbox,'string',fcnnames);
   set(handles.funclistbox,'value',1);
else
   set(handles.funclistbox,'string','');
   set(handles.funclistbox,'value',1);
end
fgtfilename=filenamein;
fgtpathname=pathnamein;
[~,filestem,~]=fileparts(filenamein);
set(handles.figuretool2,'name',[filestem,' - Figuretool2']);
exportupdate(handles);

% --------------------------------------------------------------------
function file_openlast_Callback(hObject, eventdata, handles)
% hObject    handle to file_openlast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global modified functionlist fgtfilename fgtpathname;
lastfig=[fileparts(mfilename('fullpath')),'\lastfig.fgt'];
if ~exist(lastfig,'file') waitfor(msgbox('The last saved figure does not exist.','Figuretool2')); return; end
if modified
   while true
      button=questdlg('Do you wish to save the modifications to the current file?','Figuretool2','Cancel');
      if strcmpi(button,'Yes')
         if isempty(fgtfilename)
            [filename,pathname]=uiputfile({'*.fgt','Figuretool2 file (.fgt)'});
            if isnumeric(filename) continue;
            else savefile(filename,pathname); break;
            end
         else savefile(fgtfilename,fgtpathname); break;
         end
      elseif strcmpi(button,'Cancel')
         return;
      else break;
      end
   end
end
globalinit(handles);
load(lastfig,'-mat');
if ~isempty(functionlist)
   fcnnames=cell(size(functionlist));
   for j=1:numel(fcnnames)
      fcnnames{j}=functionlist{j}.function;
   end
   set(handles.funclistbox,'string',fcnnames);
   set(handles.funclistbox,'value',1);
else
   set(handles.funclistbox,'string',{});
   set(handles.funclistbox,'value',1);
end
[~,filestem,~]=fileparts(fgtfilename);
set(handles.figuretool2,'name',[filestem,' - Figuretool2']);
exportupdate(handles);

% --------------------------------------------------------------------
function file_save_Callback(hObject, eventdata, handles)
global fgtfilename fgtpathname;
if isempty(fgtfilename)
   [filename,pathname]=uiputfile({'*.fgt','Figuretool2 file (.fgt)'},'Figuretool2');
   if isnumeric(filename) return; end
else
   filename=fgtfilename;
   pathname=fgtpathname;
end
savefile(filename,pathname);
[~,filestem,~]=fileparts(filename);
set(handles.figuretool2,'name',[filestem,' - Figuretool2']);

function file_saveas_Callback(hObject, eventdata, handles)
[filename,pathname]=uiputfile({'*.fgt','Figuretool2 file (.fgt)'},'Figuretool2');
[~,filestem,~]=fileparts(filename);
if isnumeric(filename) return;
else savefile(filename,pathname);
end
set(handles.figuretool2,'name',[filestem,' - Figuretool2']);

function savefile(filename,pathname)
global functionlist atomlist xyzlist unitcell fgtfilename fgtpathname coordtype modified CPdata CMdata mu3data raMOdata XSFdata ...
   MOdata globallp globalfl res figres camparam grouplist unitcelllist elemnolist elemlist unitcellset defaultcolor connmap;
fgtfilename=filename;
fgtpathname=pathname;
temp={};
if ~isempty(fgtfilename) temp{end+1}='fgtfilename'; end
if ~isempty(fgtpathname) temp{end+1}='fgtpathname'; end
if ~isempty(functionlist) temp{end+1}='functionlist'; end
if ~isempty(atomlist) temp{end+1}='atomlist'; end
if ~isempty(xyzlist) temp{end+1}='xyzlist'; end
if ~isempty(coordtype) temp{end+1}='coordtype'; end
if ~isempty(unitcell) temp{end+1}='unitcell'; end
if ~isempty(unitcelllist) temp{end+1}='unitcelllist'; end
if ~isempty(elemlist) temp{end+1}='elemlist'; end
if ~isempty(elemnolist) temp{end+1}='elemnolist'; end
if ~isempty(unitcellset) temp{end+1}='unitcellset'; end
if ~isempty(defaultcolor) temp{end+1}='defaultcolor'; end
if ~isempty(connmap) temp{end+1}='connmap'; end
if ~isempty(CPdata) temp{end+1}='CPdata'; end
if ~isempty(CMdata) temp{end+1}='CMdata'; end
if ~isempty(mu3data) temp{end+1}='mu3data'; end
if ~isempty(raMOdata) temp{end+1}='raMOdata'; end
if ~isempty(XSFdata) temp{end+1}='XSFdata'; end
if ~isempty(MOdata) temp{end+1}='MOdata'; end
if ~isempty(globallp) temp{end+1}='globallp'; end
if ~isempty(globalfl) temp{end+1}='globalfl'; end
if ~isempty(res) temp{end+1}='res'; end
if ~isempty(figres) temp{end+1}='figres'; end
if ~isempty(camparam) temp{end+1}='camparam'; end
if ~isempty(grouplist) temp{end+1}='grouplist'; end
save([fgtpathname,fgtfilename],temp{:},'-mat');
save([fileparts(mfilename('fullpath')),'\lastfig.fgt'],temp{:},'-mat');
modified=false;

% --------------------------------------------------------------------
function import_template_Callback(hObject, eventdata, handles)
% hObject    handle to import_template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global templatefile atomlist xyzlist coordtype unitcell modified;
[filename,pathname]=uigetfile({'*.prn','Diamond3 template file (.prn)';'*.xtl','VESTA template file (.xtl)';'*.xyz',...
   'atomic coordinate file (.xyz)';'*-geo','CP/CM/raMO/mu3 -geo file'},'Figuretool2');
if isnumeric(filename) return; end
[~,filestr,fileext]=fileparts(filename);
if ~isempty(xyzlist) button=questdlg('A template coordinate list already exists. Do you wish to overwrite current coordinate data?','Figuretool2','Yes','No','No');
   if ~strcmpi(button,'Yes') return; end
end
switch fileext
   case {'.prn','.xtl','.xyz'}
      inID=fopen([pathname,filename]);
      linenum=1; nondata=0;
      while(1)
         templine=fgetl(inID);
         if ~ischar(templine)||strcmpi(templine,'EOF') break;
         else
            if ~all(isspace(templine))
               temp=textscan(templine,'%s %f %f %f %s',1);
               if isempty(temp{4})||isnan(temp{4})||~isnan(str2double(temp{1}))||~isempty(temp{5}) nondata=linenum; end
            end
         end
         linenum=linenum+1;
      end
      frewind(inID); temp=textscan(inID,'%s %f %f %f','headerlines',nondata);
      atomlist=temp{1}; atomlist=atomlist(~strcmpi('EOF',atomlist));
      xyzlist=[temp{2}(1:numel(atomlist)),temp{3}(1:numel(atomlist)),temp{4}(1:numel(atomlist))];
      isdummy=strcmpi('Dummy',atomlist); isdummy0=strcmpi('Dummy0',atomlist);
      if any(isdummy)&&~any(isdummy0)
         button=questdlg('Figuretool detected atoms labelled as ''Dummy''. Do you wish to convert them to ''Dummy0''?','Figuretool','Yes','No','Yes');
         if strcmpi(button,'Yes') atomlist(isdummy)=repmat({'Dummy0'},sum(isdummy),1); end
      end
      temp=~ismember(atomlist,{'&','<CELL>'});
      unitcell=xyzlist(~temp,:);
      if strcmpi(fileext,'.xtl')&&isempty(unitcell)
         button=questdlg('The imported .xtl file does not contain cell vector information. Do you wish to convert cell parameters to cell vectors?','Figuretool','Yes','No','Yes');
         if strcmpi(button,'Yes')
            frewind(inID);
            temp0=textscan(inID,'%f %f %f %f %f %f',1,'headerlines',2);
            a=temp0{1}; b=temp0{2}; c=temp0{3}; alpha=temp0{4}; beta=temp0{5}; gamma=temp0{6};
            tempa=[a,0,0]; tempb=[b*cosd(gamma),b*sind(gamma),0];
            tempcx=c*cosd(beta); tempcy=(c*cosd(alpha)-c*cosd(beta)*cosd(gamma))/sind(gamma);
            tempc=[tempcx,tempcy,sqrt(c^2-tempcx^2-tempcy^2)];
            [unitcell,~]=symsearch([tempa;tempb;tempc]);
         end
      end
      if size(unitcell,1)>3
         h0=choosecell;
         uiwait(h0);
         if ishandle(h0) delete(h0); end
         if size(unitcell,1)>3 msgbox('Cell vectors not imported. You can change cell vector settings in Parameters -> Unit cell .','Figuretool2'); unitcell=[]; end
      elseif isempty(unitcell) msgbox('No cell vectors found. You can add cell vectors in Parameters -> Unit cell.','Figuretool2');
      elseif size(unitcell,1)<3 msgbox('Less than 3 cell vectors are found. You can change cell vector settings in Parameters -> Unit cell.','Figuretool2');
      end
      if isequal(size(unitcell),[3,3])&&abs(det(unitcell))<1E-6 msgbox('The imported cell vectors are coplanar. You can change cell vector settings in Parameters -> Unit cell .','Figuretool2'); end
      xyzlist=xyzlist(temp,:);
      atomlist=atomlist(temp);
      atomlist=atomlist(~isnan(xyzlist(:,3)));
      elemgen();
      xyzlist=xyzlist(~isnan(xyzlist(:,3)),:);
      fclose(inID);
      set(handles.export_template,'enable','on');
      if strcmpi(fileext,'.xtl') coordtype='direct'; else coordtype='Cartesian'; end
      modified=true; set(handles.export_template,'enable','on'); templatefile=filename; return;
   otherwise
      inID=fopen([pathname,filename]);
      temp=textscan(inID,'%s %f %f %f');
      atomlist=temp{1}; xyzlist=[temp{2},temp{3},temp{4}];
      elemgen();
      coordtype='Cartesian';
      cellfile=[filestr(1:end-4),'-cell'];
      if ~exist([pathname,filestr(1:end-4),'-cell'],'file') msgbox('The -cell file is not found. You can change cell vector settings in Parameters -> Unit cell.','Figuretool2');
      else
         inID=fopen([pathname,cellfile]);
         temp=textscan(inID,'%f %f %f');
         unitcell=[temp{1},temp{2},temp{3}];
         fclose(inID);
      end
      modified=true; set(handles.export_template,'enable','on'); templatefile=filename; return;
end


% --------------------------------------------------------------------
function import_CP_Callback(hObject, eventdata, handles)
% hObject    handle to import_CP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CPdata templatefile atomlist xyzlist unitcell coordtype modified;
[filename,pathname]=uigetfile({'*-coeff','CP/CM result file'},'Figuretool2');
if isnumeric(filename) return; end
filestem=filename(1:end-6);
if ~exist([pathname,filestem,'-geo'],'file')||~exist([pathname,filestem,'-cell'],'file') waitfor(msgbox('Incomplete CP data set!','Figuretool2')); return;
else
   if ~isempty(CPdata) button=questdlg('A CP data set has already been read in. Do you wish to overwrite the current CP data?','Figuretool2','Yes','No','No');
      if ~strcmpi(button,'Yes') return; end
   end
   try
      inID=fopen([pathname,filestem,'-geo']);
      temp=textscan(inID,'%s %f %f %f');
      CPatomlist=temp{1}; CPxyzlist=[temp{2},temp{3},temp{4}];
      fclose(inID);
   catch
      fclose(inID); waitfor(msgbox(['Error reading file:',char(10),'  ',pathname,filestem,'-geo'],'Figuretool2')); return;
   end
   try
      inID=fopen([pathname,filestem,'-cell']);
      temp=textscan(inID,'%f %f %f');
      CPunitcell=[temp{1},temp{2},temp{3}];
      fclose(inID);
   catch
      fclose(inID); waitfor(msgbox(['Error reading file:',char(10),'  ',pathname,filestem,'-cell'],'Figuretool2')); return;
   end
   try
      inID=fopen([pathname,filestem,'-coeff']);
      temp=textscan(inID,'%s %f');
      CPcomp=temp{1};
      CPcoeff=reshape(temp{2},numel(temp{2})/numel(CPatomlist),numel(CPatomlist));
      CPlmax=sqrt(size(CPcoeff,1))-1;
      fclose(inID);
   catch
      fclose(inID); waitfor(msgbox(['Error reading file:',char(10),'  ',pathname,filestem,'-coeff'],'Figuretool2')); return;
   end
   if isempty(xyzlist)
      button=questdlg('No template file have been read in. Do you wish to use the -geo file as the template?','Figuretool2','Yes','No','Yes');
      if strcmpi(button,'Yes')
         templatefile=[filestem,'-geo'];
         atomlist=CPatomlist;
         elemgen();
         xyzlist=CPxyzlist;
         unitcell=CPunitcell;
         coordtype='Cartesian';
         set(handles.export_template,'enable','on');
      end
   elseif isempty(unitcell)
      button=questdlg('No cell vectors have been read in. Do you wish to import cell vectors from the -cell file?','Figuretool2','Yes','No','Yes');
      if strcmpi(button,'Yes')
         unitcell=CPunitcell;
      end
   end
   modified=true;
   CPdata=struct('file',filestem,'CPatomlist',{CPatomlist},'CPxyzlist',CPxyzlist,'CPunitcell',CPunitcell,'CPcomp',{CPcomp},'CPcoeff',CPcoeff,'CPlmax',CPlmax);
   set(handles.export_CP,'enable','on');
end


% --------------------------------------------------------------------
function import_CM_Callback(hObject, eventdata, handles)
% hObject    handle to import_CM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CMdata templatefile atomlist xyzlist unitcell coordtype modified;
[filename,pathname]=uigetfile({'*-coeff','CP/CM result file'},'Figuretool2');
if isnumeric(filename) return; end
filestem=filename(1:end-6);
if ~exist([pathname,filestem,'-geo'],'file')||~exist([pathname,filestem,'-cell'],'file') waitfor(msgbox('Incomplete CM data set!','Figuretool2')); return;
else
   if ~isempty(CMdata) button=questdlg('A CM data set has already been read in. Do you wish to overwrite the current CM data?','Figuretool2','Yes','No','No');
      if ~strcmpi(button,'Yes') return; end
   end
   try
      inID=fopen([pathname,filestem,'-geo']);
      temp=textscan(inID,'%s %f %f %f');
      CMatomlist=temp{1}; CMxyzlist=[temp{2},temp{3},temp{4}];
      fclose(inID);
   catch
      fclose(inID); waitfor(msgbox(['Error reading file:',char(10),'  ',pathname,filestem,'-geo'],'Figuretool2')); return;
   end
   try
      inID=fopen([pathname,filestem,'-cell']);
      temp=textscan(inID,'%f %f %f');
      CMunitcell=[temp{1},temp{2},temp{3}];
      fclose(inID);
   catch
      fclose(inID); waitfor(msgbox(['Error reading file:',char(10),'  ',pathname,filestem,'-cell'],'Figuretool2')); return;
   end
   try
      inID=fopen([pathname,filestem,'-coeff']);
      temp=textscan(inID,'%s %f');
      CMcomp=temp{1};
      CMcoeff=reshape(temp{2},numel(temp{2})/numel(CMatomlist),numel(CMatomlist));
      CMlmax=sqrt(size(CMcoeff,1))-1;
      fclose(inID);
   catch
      fclose(inID); waitfor(msgbox(['Error reading file:',char(10),'  ',pathname,filestem,'-coeff'],'Figuretool2')); return;
   end
   if isempty(xyzlist)
      button=questdlg('No template file have been read in. Do you wish to use the -geo file as the template?','Figuretool2','Yes','No','Yes');
      if strcmpi(button,'Yes')
         templatefile=[filestem,'-geo'];
         atomlist=CMatomlist;
         elemgen();
         xyzlist=CMxyzlist;
         unitcell=CMunitcell;
         coordtype='Cartesian';
         set(handles.export_template,'enable','on');
      end
   elseif isempty(unitcell)
      button=questdlg('No cell vectors have been read in. Do you wish to import cell vectors from the -cell file?','Figuretool2','Yes','No','Yes');
      if strcmpi(button,'Yes')
         unitcell=CMunitcell;
      end
   end
   modified=true;
   CMdata=struct('file',filestem,'CMatomlist',{CMatomlist},'CMxyzlist',CMxyzlist,'CMunitcell',CMunitcell,'CMcomp',{CMcomp},'CMcoeff',CMcoeff,'CMlmax',CMlmax);
   set(handles.export_CM,'enable','on');
end

% --------------------------------------------------------------------
function import_ramo_Callback(hObject, eventdata, handles)
% hObject    handle to import_ramo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function import_mu3_Callback(hObject, eventdata, handles)
% hObject    handle to import_mu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global templatefile xyzlist coordtype mu3data atomlist unitcell modified;
[filename,pathname]=uigetfile({'*.mu3output','mu3-acidity result file'},'Figuretool2');
if isnumeric(filename) return; end
[~,filestr,~]=fileparts(filename);
if ~exist([pathname,filestr,'-geo'],'file')||~exist([pathname,filestr,'-cell'],'file') waitfor(msgbox('Incomplete mu3 data set!','Figuretool2')); return;
else
   if ~isempty(mu3data) button=questdlg('A mu3 data set has already been read in. Do you wish to overwrite current mu3 data?','Figuretool2','Yes','No','No');
      if ~strcmpi(button,'Yes') return; end
   end
   try
      inID=fopen([pathname,filestr,'-geo']);
      temp=textscan(inID,'%s %f %f %f');
      mu3atomlist=temp{1}; mu3xyzlist=[temp{2},temp{3},temp{4}];
      fclose(inID);
   catch
      fclose(inID); waitfor(msgbox(['Error reading file:',char(10),'  ',pathname,filestr,'-geo'],'Figuretool2')); return;
   end
   try
      inID=fopen([pathname,filestr,'-cell']);
      temp=textscan(inID,'%f %f %f');
      mu3unitcell=[temp{1},temp{2},temp{3}];
      fclose(inID);
   catch
      fclose(inID); waitfor(msgbox(['Error reading file:',char(10),'  ',pathname,filestem,'-cell'],'Figuretool2')); return;
   end
   try
      inID=fopen([pathname,filename]);
      temp=textscan(inID,'%f %f %f');
      mu3occ_id=temp{2}; mu3occ_act=temp{3};
      fclose(inID);
   catch
      fclose(inID); waitfor(msgbox(['Error reading file:',char(10),'  ',pathname,filename],'Figuretool2')); return;
   end
   if isempty(xyzlist)
      button=questdlg('No template file have been read in. Do you wish to use the -geo file as the template?','Figuretool2','Yes','No','Yes');
      if strcmpi(button,'Yes')
         templatefile=[filestr,'-geo'];
         atomlist=mu3atomlist;
         elemgen();
         xyzlist=mu3xyzlist;
         unitcell=mu3unitcell;
         coordtype='Cartesian';
         set(handles.export_template,'enable','on');
      end
   elseif isempty(unitcell)
      button=questdlg('No cell vectors have been read in. Do you wish to import cell vectors from the -cell file?','Figuretool2','Yes','No','Yes');
      if strcmpi(button,'Yes')
         unitcell=mu3unitcell;
      end
   end
   mu3data=struct('file',filestr,'mu3atomlist',{mu3atomlist},'mu3xyzlist',mu3xyzlist,'mu3unitcell',mu3unitcell,'mu3occ_id',mu3occ_id,'mu3occ_act',mu3occ_act);
   modified=true;  set(handles.export_mu3,'enable','on');
end


% --------------------------------------------------------------------
function import_xsf_Callback(hObject, eventdata, handles)
% hObject    handle to import_xsf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global templatefile elemname xyzlist coordtype XSFdata atomlist unitcell modified;
[filename,pathname]=uigetfile({'*.xsf','XSF file (.xsf)'},'Figuretool2');
if isnumeric(filename) return; end
[~,filestr,~]=fileparts(filename);
if ~isempty(XSFdata) button=questdlg('An XSF data set has already been read in. Do you wish to overwrite current XSF data?','Figuretool2','Yes','No','No');
   if ~strcmpi(button,'Yes') return; end
end
try
   inID=fopen([pathname,filename]);
   while true
      templine=fgetl(inID);
      if ~isempty(findstr('PRIMVEC',templine))
         temp=textscan(inID,'%f %f %f',3);
         XSFunitcell=[temp{1},temp{2},temp{3}];
         break;
      end
   end
   while true
      templine=fgetl(inID);
      if ~isempty(findstr('ATOMS',templine))
         temp=textscan(inID,'%f %f %f %f');
         XSFatomlist=elemname(temp{1}+2)';
         XSFxyzlist=[temp{2},temp{3},temp{4}];
         break;
      end
   end
   while true
      templine=fgetl(inID);
      if ~isempty(findstr('DATAGRID_3D_DENSITY',templine))
         temp=textscan(inID,'%f %f %f',1);
         XSFngfft=[temp{1},temp{2},temp{3}]-1;
         textscan(inID,'%f %f %f',1,'headerlines',4);
         XSFgrid=fscanf(inID,'%f',prod(XSFngfft+1));
         XSFgrid=reshape(XSFgrid,XSFngfft+1);
         XSFfmax=max(XSFgrid(:)); XSFfmin=min(XSFgrid(:));
         break;
      end
   end
   fclose(inID);
catch
   fclose(inID); waitfor(msgbox(['Error reading file:',char(10),'  ',pathname,filename],'Figuretool2')); return;
end
if isempty(xyzlist)
   button=questdlg('No template file have been read in. Do you wish to use the XSF file as the template?','Figuretool2','Yes','No','Yes');
   if strcmpi(button,'Yes')
      templatefile=filestr;
      atomlist=XSFatomlist;
      elemgen();
      xyzlist=XSFxyzlist;
      unitcell=XSFunitcell;
      coordtype='Cartesian';
      set(handles.export_template,'enable','on');
   end
elseif isempty(unitcell)
   button=questdlg('No cell vectors have been read in. Do you wish to import cell vectors from the XSF file?','Figuretool2','Yes','No','Yes');
   if strcmpi(button,'Yes')
      unitcell=XSFunitcell;
   end
end
XSFdata=struct('file',filestr,'XSFatomlist',{XSFatomlist},'XSFxyzlist',XSFxyzlist,'XSFunitcell',XSFunitcell,'XSFngfft',XSFngfft,'XSFrange',[XSFfmin,XSFfmax],'XSFgrid',XSFgrid);
modified=true;  set(handles.export_xsf,'enable','on');


% --------------------------------------------------------------------
function import_MO_Callback(hObject, eventdata, handles)
% hObject    handle to import_MO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global templatefile xyzlist coordtype MOdata atomlist unitcell modified;
[filename,pathname]=uigetfile({'*.MO','YAeHMOP MO file (.MO)'},'Figuretool2');
if isnumeric(filename) return; end
[~,filestr,~]=fileparts(filename);
if ~exist([pathname,filestr],'file') waitfor(msgbox('The YAeHMOP input file is not found!','Figuretool2')); return; end
if ~isempty(MOdata) button=questdlg('An MO data set has already been read in. Do you wish to overwrite current MO data?','Figuretool2','Yes','No','No');
   if ~strcmpi(button,'Yes') return; end
end
try
   inID=fopen([pathname,filestr]);
   MOkpt=[]; MOkptwt=[];
   while true
      templine=fgetl(inID);
      if isnumeric(templine) break; end
      if strncmpi('Geometry',templine,8)
         temp=textscan(inID,'%f',1); natom=temp{1};
         temp=textscan(inID,'%f %s %f %f %f',natom);
         MOatomlist=temp{2}; MOxyzlist=[temp{3:5}];
         if any(strcmpi('&',MOatomlist))
            MOatomlist=MOatomlist(1:end-4); MOunitcell=bsxfun(@minus,MOxyzlist(end-2:end,:),MOxyzlist(end-3,:)); MOxyzlist=MOxyzlist(1:end-4,:); natom=natom-4;
         else
            MOunitcell=[];
         end
      end
      if strncmpi('MO Print',templine,8)
         temp=textscan(inID,'%f',1); monum=temp{1};
         temp=textscan(inID,'%f',monum);
         MOlist=temp{1};
      end
      if strncmpi('K POINTS',templine,8)
         temp=textscan(inID,'%f',1); nkpt=temp{1};
         temp=textscan(inID,'%f %f %f %f',nkpt);
         MOkpt=[temp{1:3}]; MOkptwt=temp{4};
      end
   end
   fclose(inID);
catch
   fclose(inID); waitfor(msgbox(['Error reading file:',char(10),'  ',pathname,filestr],'Figuretool2')); return;
end
try
   inID=fopen([pathname,filename]);
   counter=0;
   while true
      temp=textscan(inID,'%s',1,'headerlines',1);
      if strcmpi(temp{1}{1},'#end_parms') break; else counter=counter+1; end
   end
   frewind(inID);
   ehtparms=textscan(inID,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f',counter,'headerlines',1);
   ehtparms=[ehtparms{1},num2cell([ehtparms{2:end}])];
   temp=textscan(inID,'%s %f',2,'headerlines',2); aonum=temp{2}(1); monum=temp{2}(2);
   textscan(inID,'%s',2,'headerlines',monum);
   MOcoeff=cell(1,monum);
   orblist={'s','px','py','pz','dx2-y2','dz2','dxy','dxz','dyz','fz3','fxz2','fyz2','fxyz','fz(x2-y2)','fx(x2-3y2)','fy(3x2-y2)'};
   while true
      str=fgetl(inID);
      if strncmp(str,'#begin_mo',9) break; end
   end
   elemnum=arrayfun(@(x)find(strcmpi(MOatomlist{x},ehtparms(:,1)),1),1:numel(MOatomlist));
   currmo=cell(aonum,7); mocounter=1; atomcounter=0; aocounter=1; b2a=0.529177249;
   MOaonumlist=zeros(1,natom);
   while true
      str=fgetl(inID);
      if strncmp(str,'#begin_mo',9)
         currmo=cell(aonum,7); mocounter=mocounter+1; atomcounter=0; aocounter=1;
      elseif strncmp(str,'#end_mo',7)
         MOcoeff{mocounter}=currmo;
         if mocounter==1 MOaonumlist(end)=orbcounter-1; end
         if (mocounter>=monum) break; end
      elseif strncmp(str,';',1)
         if (mocounter==1)&&(atomcounter~=0) MOaonumlist(atomcounter)=orbcounter-1; end
         atomcounter=atomcounter+1; enum=elemnum(atomcounter); orbcounter=1;
      else
         tempnum=str2num(str); if numel(tempnum)==2 tempnum=tempnum(1)+tempnum(2)*1i; end
         switch orblist{orbcounter}(1)
            case 's', qn=ehtparms{enum,2}; zetalist={ehtparms{enum,3}/b2a,0,0,0};
            case 'p', qn=ehtparms{enum,5}; zetalist={ehtparms{enum,6}/b2a,0,0,0};
            case 'd', qn=ehtparms{enum,8}; zetalist={ehtparms{enum,9}/b2a,ehtparms{enum,11},ehtparms{enum,12}/b2a,ehtparms{enum,13}};
            case 'f', qn=ehtparms{enum,14}; zetalist={ehtparms{enum,15}/b2a,ehtparms{enum,17},ehtparms{enum,18}/b2a,ehtparms{enum,19}};
         end
         currmo(aocounter,:)=[{atomcounter,[num2str(qn),orblist{orbcounter}],tempnum},zetalist];
         aocounter=aocounter+1; orbcounter=orbcounter+1;
      end
   end
   fclose(inID);
catch
   fclose(inID); waitfor(msgbox(['Error reading file:',char(10),'  ',pathname,filename],'Figuretool2')); return;
end
if isempty(xyzlist)
   button=questdlg('No template file have been read in. Do you wish to use the MO file as the template?','Figuretool2','Yes','No','Yes');
   if strcmpi(button,'Yes')
      templatefile=filestr;
      atomlist=MOatomlist;
      elemgen();
      xyzlist=MOxyzlist;
      if ~isempty(MOunitcell) unitcell=MOunitcell; end
      coordtype='Cartesian';
      set(handles.export_template,'enable','on');
   end
elseif isempty(unitcell)&&~isempty(MOunitcell)
   button=questdlg('No cell vectors have been read in. Do you wish to import cell vectors from the MO file?','Figuretool2','Yes','No','Yes');
   if strcmpi(button,'Yes')
      unitcell=MOunitcell;
   end
end
MOdata=struct('file',filestr,'MOatomlist',{MOatomlist},'MOxyzlist',MOxyzlist,'MOunitcell',MOunitcell,...
   'MOlist',MOlist,'MOaonumlist',MOaonumlist,'MOkpt',MOkpt,'MOkptwt',MOkptwt,'MOehtparms',{ehtparms},'MOcoeff',{MOcoeff});
modified=true; set(handles.export_MO,'enable','on');

% --------------------------------------------------------------------
function export_template_Callback(hObject, eventdata, handles)
% hObject    handle to export_template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xyzlist coordtype atomlist unitcell;
[filename,pathname]=uiputfile({'*.prn','Diamond3 template file (.prn)';'*.xtl','VESTA template file (.xtl)';'*.xyz','atomic coordinate file (.xyz)'},'Figuretool2');
if isnumeric(filename) return; end
[~,~,fileext]=fileparts(filename);
switch(fileext)
   case '.prn'
      if strcmpi(coordtype,'Cartesian') xyzout=xyzlist;
      elseif strcmpi(coordtype,'direct')
         if (size(unitcell,1)~=3)||(abs(det(unitcell))<1E-6) msgbox('Incorrect cell parameters! Please make changes accordingly in Parameters -> Unit cell.','Figuretool2'); return;
         else xyzout=xyzlist*unitcell;
         end
      end
      outID=fopen([pathname,filename],'w');
      strlength=max(cell2mat(cellfun(@numel,atomlist,'UniformOutput',false)));
      fprintf(outID,'Atom   xr         yr         zr\n');
      for j=1:numel(atomlist)
         fprintf(outID,['%-',num2str(strlength+1),'s%10.5f %10.5f %10.5f\n'],atomlist{j},xyzout(j,:));
      end
      if ~((size(unitcell,1)~=3)||(abs(det(unitcell))<1E-6))
         for j=1:size(unitcell,1)
            fprintf(outID,['&',repmat(' ',1,strlength),'%10.5f %10.5f %10.5f\n'],unitcell(j,:));
         end
      end
   case '.xtl'
      if (size(unitcell,1)~=3)||(abs(det(unitcell))<1E-6) msgbox('Incorrect cell parameters! Please make changes accordingly in Parameters -> Unit cell.','Figuretool2'); return; end
      if strcmpi(coordtype,'direct') xyzout=xyzlist;
      elseif strcmpi(coordtype,'Cartesian') xyzout=xyzlist/unitcell;
      end
      outID=fopen([pathname,filename],'w');
      strlength=max(cell2mat(cellfun(@numel,atomlist,'UniformOutput',false)));
      alpha=acosd(dot(unitcell(2,:),unitcell(3,:))/(norm(unitcell(2,:))*norm(unitcell(3,:))));
      beta=acosd(dot(unitcell(3,:),unitcell(1,:))/(norm(unitcell(3,:))*norm(unitcell(1,:))));
      gamma=acosd(dot(unitcell(1,:),unitcell(2,:))/(norm(unitcell(1,:))*norm(unitcell(2,:))));
      fprintf(outID,'TITLE %s - Figuretool2\nCELL\n',filename);
      fprintf(outID,'%10.6f %10.6f %10.6f %10.6f %10.6f %10.6f\n',norm(unitcell(1,:)),norm(unitcell(2,:)),norm(unitcell(3,:)),alpha,beta,gamma);
      fprintf(outID,'SYMMETRY NUMBER 1\nSYMMETRY LABEL  P1\nATOMS\nNAME         X          Y          Z\n');
      for j=1:numel(atomlist)
         fprintf(outID,['%-',num2str(strlength+1),'s%10.5f %10.5f %10.5f\n'],regexprep(atomlist{j},'[0-9]',''),xyzout(j,:));
      end
   case '.xyz'
      if strcmpi(coordtype,'Cartesian') xyzout=xyzlist;
      elseif strcmpi(coordtype,'direct')
         if (size(unitcell,1)~=3)||(abs(det(unitcell))<1E-6) msgbox('Incorrect cell parameters! Please make changes accordingly in Parameters -> Unit cell.','Figuretool2'); return;
         else xyzout=xyzlist*unitcell;
         end
      end
      outID=fopen([pathname,filename],'w');
      strlength=max(cell2mat(cellfun(@numel,atomlist,'UniformOutput',false)));
      fprintf(outID,'%d\n',numel(atomlist));
      fprintf(outID,'%s - Figuretool2\n',filename);
      for j=1:numel(atomlist)
         fprintf(outID,['%-',num2str(strlength+1),'s%10.5f %10.5f %10.5f\n'],regexprep(atomlist{j},'[0-9]',''),xyzout(j,:));
      end
end
fclose(outID);

% --------------------------------------------------------------------
function export_CP_Callback(hObject, eventdata, handles)
% hObject    handle to export_CP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CPdata;
[filestem,pathname]=uiputfile({'*-coeff','CP result file'},'Figuretool2',CPdata.file);
if isnumeric(filestem) return; end
if exist([pathname,filestem,'-geo'],'file')||exist([pathname,filestem,'-cell'],'file')||exist([pathname,filestem,'-coeff'],'file')
   button=questdlg(['One or more of the following files:',char(10),'   ',filestem,'-geo',char(10),'   ',filestem,'-cell',char(10),...
      '   ',filestem,'-coeff',char(10),'already exists. Do you wish to replace them?'],'Figuretool2','Yes','No','No');
   if ~strcmpi(button,'Yes') return; end
end
outID=fopen([pathname,filestem,'-geo'],'w');
for j=1:numel(CPdata.CPatomlist)
   fprintf(outID,'%-6s %16.10f %16.10f %16.10f\n',CPdata.CPatomlist{j},CPdata.CPxyzlist(j,:));
end
fclose(outID);
outID=fopen([pathname,filestem,'-cell'],'w');
for j=1:3
   fprintf(outID,'%16.10f %16.10f %16.10f\n',CPdata.CPunitcell(j,:));
end
fclose(outID);
outID=fopen([pathname,filestem,'-coeff'],'w');
for j=1:numel(CPdata.CPcomp)
   fprintf(outID,'%-12s %16.10f\n',CPdata.CPcomp{j},CPdata.CPcoeff(j));
end
fclose(outID);

% --------------------------------------------------------------------
function export_CM_Callback(hObject, eventdata, handles)
% hObject    handle to export_CM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CMdata;
[filestem,pathname]=uiputfile({'*-coeff','CM result file'},'Figuretool2',CMdata.file);
if isnumeric(filestem) return; end
if exist([pathname,filestem,'-geo'],'file')||exist([pathname,filestem,'-cell'],'file')||exist([pathname,filestem,'-coeff'],'file')
   button=questdlg(['One or more of the following files:',char(10),'   ',filestem,'-geo',char(10),'   ',filestem,'-cell',char(10),...
      '   ',filestem,'-coeff',char(10),'already exists. Do you wish to replace them?'],'Figuretool2','Yes','No','No');
   if ~strcmpi(button,'Yes') return; end
end
outID=fopen([pathname,filestem,'-geo'],'w');
for j=1:numel(CMdata.CMatomlist)
   fprintf(outID,'%-6s %16.10f %16.10f %16.10f\n',CMdata.CMatomlist{j},CMdata.CMxyzlist(j,:));
end
fclose(outID);
outID=fopen([pathname,filestem,'-cell'],'w');
for j=1:3
   fprintf(outID,'%16.10f %16.10f %16.10f\n',CMdata.CMunitcell(j,:));
end
fclose(outID);
outID=fopen([pathname,filestem,'-coeff'],'w');
for j=1:numel(CMdata.CMcomp)
   fprintf(outID,'%-12s %16.10f\n',CMdata.CMcomp{j},CMdata.CMcoeff(j));
end
fclose(outID);

% --------------------------------------------------------------------
function export_ramo_Callback(hObject, eventdata, handles)
% hObject    handle to export_ramo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function export_mu3_Callback(hObject, eventdata, handles)
% hObject    handle to export_mu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mu3data;
[filename,pathname]=uiputfile({'*.mu3output','mu3 result file'},'Figuretool2',mu3data.file);
if isnumeric(filename) return; end
[~,filestem,fileext]=fileparts(filename);
if exist([pathname,filestem,'-geo'],'file')||exist([pathname,filestem,'-cell'],'file')
   button=questdlg(['One or more of the following files:',char(10),'   ',filestem,'-geo',char(10),'   ',filestem,'-cell',char(10),...
      'already exists. Do you wish to replace them?'],'Figuretool2','Yes','No','No');
   if ~strcmpi(button,'Yes') return; end
end
outID=fopen([pathname,filestem,'-geo'],'w');
for j=1:numel(mu3data.mu3atomlist)
   fprintf(outID,'%-6s %16.10f %16.10f %16.10f\n',mu3data.mu3atomlist{j},mu3data.mu3xyzlist(j,:));
end
fclose(outID);
outID=fopen([pathname,filestem,'-cell'],'w');
for j=1:3
   fprintf(outID,'%16.10f %16.10f %16.10f\n',mu3data.mu3unitcell(j,:));
end
fclose(outID);
outID=fopen([pathname,filename],'w');
for j=1:numel(mu3data.mu3occ_id)
   fprintf(outID,'%-4d %12.6f %12.6f\n',j,mu3data.mu3occ_id(j),mu3data.mu3occ_act(j));
end
fclose(outID);

% --------------------------------------------------------------------
function export_xsf_Callback(hObject, eventdata, handles)
% hObject    handle to export_xsf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global XSFdata elemname;
[filename,pathname]=uiputfile({'*.xsf','XSF file (.xsf)'},'Figuretool2',XSFdata.file);
if isnumeric(filename) return; end
outID=fopen([pathname,filename],'w');
fprintf(outID,' DIM-GROUP\n 3  1\n PRIMVEC\n');
for j=1:3
   fprintf(outID,'%16.12f %16.12f %16.12f\n',XSFdata.XSFunitcell(j,:));
end
fprintf(outID,' PRIMCOORD\n%d 1\n',numel(XSFdata.XSFatomlist));
for j=1:numel(XSFdata.XSFatomlist)
   [~,loc]=ismember(XSFdata.XSFatomlist{j},elemname);
   fprintf(outID,'      %3d %16.12f %16.12f %16.12f\n',loc-2,XSFdata.XSFxyzlist(j,:));
end
fprintf(outID,' ATOMS\n');
for j=1:numel(XSFdata.XSFatomlist)
   [~,loc]=ismember(XSFdata.XSFatomlist{j},elemname);
   fprintf(outID,'      %3d %16.12f %16.12f %16.12f\n',loc-2,XSFdata.XSFxyzlist(j,:));
end
fprintf(outID,' BEGIN_BLOCK_DATAGRID3D\n datagrids\n DATAGRID_3D_DENSITY\n');
fprintf(outID,'%11d%11d%11d\n0.0 0.0 0.0\n',XSFdata.XSFngfft(1)+1,XSFdata.XSFngfft(2)+1,XSFdata.XSFngfft(3)+1);
for j=1:3
   fprintf(outID,'%16.12f %16.12f %16.12f\n',XSFdata.XSFunitcell(j,:));
end
for j=1:floor(prod(XSFdata.XSFngfft+1)/6)
   fprintf(outID,' %16.12f %16.12f %16.12f %16.12f %16.12f %16.12f\n',XSFdata.XSFgrid(6*j-5),XSFdata.XSFgrid(6*j-4),...
      XSFdata.XSFgrid(6*j-3),XSFdata.XSFgrid(6*j-2),XSFdata.XSFgrid(6*j-1),XSFdata.XSFgrid(6*j));
end
for j=6*floor(prod(XSFdata.XSFngfft+1)/6)+1:prod(XSFdata.XSFngfft+1)
   fprintf(outID,' %16.12f',XSFdata.XSFgrid(j));
end
fprintf(outID,' END_DATAGRID_3D\n END_BLOCK_DATAGRID3D');
fclose(outID);
msgbox(['XSF file successfully exported to:',char(10),'  ',pathname,filename],'Figuretool2');

% --------------------------------------------------------------------
function export_MO_Callback(hObject, eventdata, handles)
% hObject    handle to export_MO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MOdata elemname VEC;
[filename,pathname]=uiputfile({'*.MO','YAeHMOP MO file (.MO)'},'Figuretool2',MOdata.file);
if isnumeric(filename) return; end
[~,filestem,~]=fileparts(filename);
if exist([pathname,filestem],'file')||exist([pathname,'eht_parms.dat'],'file')
   button=questdlg(['One of the following files:',char(10),'   ',filestem,char(10),'   eht_parms.dat',char(10),...
      'already exists. Do you wish to replace them?'],'Figuretool2','Yes','No','No');
   if ~strcmpi(button,'Yes') return; end
end
outID=fopen([pathname,filestem],'w');
fprintf(outID,'Not new3!\nInsert title here.\n\nGeometry\n');
if ~isempty(MOdata.MOunitcell)
   fprintf(outID,' %d\n',numel(MOdata.MOatomlist)+4);
   for j=1:numel(MOdata.MOatomlist)
      fprintf(outID,'%4d %5s %12.8f %12.8f %12.8f\n',j,MOdata.MOatomlist{j},MOdata.MOxyzlist(j,:));
   end
   fprintf(outID,'%4d %5s %12.8f %12.8f %12.8f\n',numel(MOdata.MOatomlist)+1,'&',0,0,0);
   for j=1:3
      fprintf(outID,'%4d %5s %12.8f %12.8f %12.8f\n',numel(MOdata.MOatomlist)+j+1,'&',MOdata.MOunitcell(j,:));
   end
else
   fprintf(outID,' %d\n',numel(MOdata.MOatomlist));
   for j=1:numel(MOdata.MOatomlist)
      fprintf(outID,'%4d %5s %12.8f %12.8f %12.8f\n',j,MOdata.MOatomlist{j},MOdata.MOxyzlist(j,:));
   end
end
fprintf(outID,'\nCharge\n 0\n\n');
if ~isempty(MOdata.MOunitcell)
   temp=numel(MOdata.MOatomlist)+[1,2,1,3,1,4];
   fprintf(outID,'Lattice\n3\n4 4 4\n%d %d\n%d %d\n%d %d\n\n',temp(:));
end
fprintf(outID,'The Constant\n 1.7500\nDiagwo\nNonweighted\n\nMO Print\n%d\n',numel(MOdata.MOlist));
for j=1:numel(MOdata.MOlist)
   fprintf(outID,'%d\n',MOdata.MOlist(j));
end
if ~isempty(MOdata.MOkpt)
   fprintf(outID,'\nAverage Properties\n\nK POINTS\n%d\n',size(MOdata.MOkpt,1));
   for j=1:size(MOdata.MOkpt,1)
      fprintf(outID,'%10.6f %10.6f %10.6f %10.6f\n',MOdata.MOkpt(j,:),MOdata.MOkptwt(j));
   end
end
fclose(outID);
outID=fopen([pathname,filename],'w');
fprintf(outID,'#begin_parms\n');
for j=1:size(MOdata.MOehtparms,1)
   fprintf(outID,'%s %d %.6f %.6f %d %.6f %.6f %d %.6f %.6f %.6f %.6f %.6f %d %.6f %.6f %.6f %.6f %.6f\n',MOdata.MOehtparms{j,:});
end
fprintf(outID,'#end_parms\n#Num_AOs %d\n#Num_MOs %d\n',size(MOdata.MOcoeff{1},1),numel(MOdata.MOcoeff));
if ~isempty(MOdata.MOkpt)
   for j=1:size(MOdata.MOkpt,1)
      for k=1:numel(MOdata.MOlist)
         fprintf(outID,'%d %.6f %.6f %.6f 1\n',MOdata.MOlist(k),MOdata.MOkpt(j,:));
      end
   end
else
   for k=1:numel(MOdata.MOlist)
      fprintf(outID,'%d 0 0 0 1\n',MOdata.MOlist(k));
   end
end
cumaonum=[0,cumsum(MOdata.MOaonumlist)];
for j=1:numel(MOdata.MOcoeff)
   fprintf(outID,'#begin_mo 0 0 0\n');
   aocounter=1;
   for k=1:size(MOdata.MOcoeff{1},1)
      if ismember(k-1,cumaonum) fprintf(outID,'; %d\n',aocounter); aocounter=aocounter+1; end
      temp=MOdata.MOcoeff{j}{k,3};
      if isreal(temp)
         fprintf(outID,'%.4f %.4f\n',real(temp),imag(temp));
      else
         fprintf(outID,'%.4f\n',temp);
      end
   end
   fprintf(outID,'#end_mo\n');
end
fclose(outID);
outID=fopen([pathname,'eht_parms.dat'],'w');
nlist=[2,5,8,14]; nzlist=[1,1,2,2]; orblist={'s','p','d','f'};
for j=1:size(MOdata.MOehtparms,1)
   loc=find(strcmpi(MOdata.MOehtparms{j,1},elemname),1); if isempty(loc)||(loc<3) continue; end
   for k=1:4
      if MOdata.MOehtparms{j,nlist(k)}==0 continue; end
      fprintf(outID,'%3s %3d %3d %3d %3d   %s  ',MOdata.MOehtparms{j,1},loc-2,VEC(loc),nzlist(k),MOdata.MOehtparms{j,nlist(k)},orblist{k});
      if k<3 fprintf(outID,'%8.4f %8.4f %8.4f %8.4f %8.4f\n',MOdata.MOehtparms{j,nlist(k)+[2,1]},0,1,0);
      else fprintf(outID,'%8.4f %8.4f %8.4f %8.4f %8.4f\n',MOdata.MOehtparms{j,nlist(k)+[2,1,4,3,5]});
      end
   end
end
fclose(outID);   

function exportupdate(handles)
global xyzlist CPdata CMdata mu3data raMOdata XSFdata MOdata;
if isempty(xyzlist) set(handles.export_template,'enable','off'); else set(handles.export_template,'enable','on'); end
if isempty(CPdata) set(handles.export_CP,'enable','off'); else set(handles.export_CP,'enable','on'); end
if isempty(CMdata) set(handles.export_CM,'enable','off'); else set(handles.export_CM,'enable','on'); end
if isempty(mu3data) set(handles.export_mu3,'enable','off'); else set(handles.export_mu3,'enable','on'); end
if isempty(raMOdata) set(handles.export_ramo,'enable','off'); else set(handles.export_ramo,'enable','on'); end
if isempty(XSFdata) set(handles.export_xsf,'enable','off'); else set(handles.export_xsf,'enable','on'); end
if isempty(MOdata) set(handles.export_MO,'enable','off'); else set(handles.export_MO,'enable','on'); end

% --------------------------------------------------------------------
function file_exit_Callback(hObject, eventdata, handles)
% hObject    handle to file_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;

% --------------------------------------------------------------------
function edit_template_Callback(hObject, eventdata, handles)
% hObject    handle to edit_template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xyzlist;
h0=templateviewer;
uiwait(h0);
if ~isempty(xyzlist) set(handles.export_template,'enable','on'); end
if ~ishandle(h0) return; end
delete(h0);

% --------------------------------------------------------------------
function edit_dataviewer_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h0=dataviewer;
uiwait(h0);
if ~ishandle(h0) return; end
delete(h0);

% --------------------------------------------------------------------
function edit_group_Callback(hObject, eventdata, handles)
% hObject    handle to edit_group (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global modified;
h0=groupmanager;
uiwait(h0);
if ~ishandle(h0) return; end
delete(h0);
modified=true;

% --------------------------------------------------------------------
function effects_depthcueing_Callback(hObject, eventdata, handles)
% hObject    handle to effects_depthcueing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function effects_fade_Callback(hObject, eventdata, handles)
% hObject    handle to effects_fade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function parameters_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to parameters_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camparam modified;
oldcamparam=camparam;
h0=setcam;
uiwait(h0);
if ~ishandle(h0) camparam=oldcamparam; return; end
delete(h0);
modified=true;

% --------------------------------------------------------------------
function parameters_setcell_Callback(hObject, eventdata, handles)
% hObject    handle to parameters_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global unitcell modified;
oldcell=unitcell;
h0=setcell;
uiwait(h0);
if ~ishandle(h0) unitcell=oldcell; return; end
text=get(h0,'Userdata');
if strcmpi(text,'cancelled') unitcell=oldcell; end
delete(h0);
modified=true;

% --------------------------------------------------------------------
function parameters_setcolor_Callback(hObject, eventdata, handles)
% hObject    handle to parameters_setcolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global defaultcolor modified;
oldcolor=defaultcolor;
h0=setdc;
uiwait(h0);
if ~ishandle(h0) defaultcolor=oldcolor; return; end
text=get(h0,'Userdata');
if strcmpi(text,'cancelled') defaultcolor=oldcolor; end
delete(h0);
modified=true;

% --------------------------------------------------------------------
function parameters_setconn_Callback(hObject, eventdata, handles)
% hObject    handle to parameters_setconn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global connmap modified;
oldmap=connmap;
h0=setconn;
uiwait(h0);
if ~ishandle(h0) connmap=oldmap; return; end
text=get(h0,'Userdata');
if strcmpi(text,'cancelled') connmap=oldmap; end
delete(h0);
modified=true;

% --------------------------------------------------------------------
function parameters_setlp_Callback(hObject, eventdata, handles)
% hObject    handle to parameters_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global modified;
h0=setlp;
uiwait(h0);
if ~ishandle(h0) return; end
delete(h0);
modified=true;

% --------------------------------------------------------------------
function parameters_setres_Callback(hObject, eventdata, handles)
% hObject    handle to parameters_setres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global modified;
h0=setres;
uiwait(h0);
if ~ishandle(h0) return; end
delete(h0);
modified=true;

% --------------------------------------------------------------------
function movie_prog_Callback(hObject, eventdata, handles)
% hObject    handle to movie_prog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xyzlist unitcell functionlist modified nframe;
if isempty(functionlist) waitfor(msgbox('The function list is empty.','Figuretool2')); return; end
if isempty(xyzlist) waitfor(msgbox('No template has been read in.','Figuretool2')); return; end
if ~isempty(unitcell)&&(size(unitcell,1)~=3)
   waitfor(msgbox('The unitcell information is incomplete. Please make changes accordingly in Parameters -> Unit cell.','Figuretool2')); return;
end
if isempty(nframe)
   h0=getnframe;
   uiwait(h0);
   if ~ishandle(h0) return; end
   delete(h0);
   if isempty(nframe) return; end
end
h0=moviemaker;
uiwait(h0);
if ~ishandle(h0) return; end
delete(h0);
modified=true;

% --------------------------------------------------------------------
function makeramo_prog_Callback(hObject, eventdata, handles)
% hObject    handle to makeramo_prog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function importcif_prog_Callback(hObject, eventdata, handles)
% hObject    handle to importcif_prog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global modified;
h0=importcifGUI;
uiwait(h0);
if ~ishandle(h0) return; end
delete(h0);
modified=true;

% --------------------------------------------------------------------
function simdiffract_prog_Callback(hObject, eventdata, handles)
% hObject    handle to simdiffract_prog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xyzlist unitcell elemnolist;
if isempty(xyzlist) msgbox('No template has been read in.','Figuretool2'); return;
elseif (~isequal(size(unitcell),[3,3]))||(abs(det(unitcell))<1E-6) msgbox('Unit cell vectors are not correctly specified.','Figuretool2'); return;
elseif any(elemnolist==-100) waitfor(msgbox('Some atom types are not found in the periodic table. They will be ignored in diffraction pattern calculation.','Figuretool2'));
end
h0=simdiffract_GUI;
uiwait(h0);
if ~ishandle(h0) return; end
params=get(h0,'userdata');
delete(h0);
if ischar(params)&&strcmpi(params,'cancelled') return; end
simdiffract(params{:});


% --------------------------------------------------------------------
function xplor2xsf_prog_Callback(hObject, eventdata, handles)
% hObject    handle to xplor2xsf_prog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xyzlist unitcell XSFdata elemlist unitcellset coordtype modified;
if isempty(xyzlist)||~isequal(size(unitcell),[3,3])||(abs(det(unitcell))<1E-6) 
   msgbox('The template file/unit cell is not set up properly.','Figuretool2'); return;
end
[filename,pathname]=uigetfile({'*.xplor','Electron density map file (.xplor)'},'Figuretool2');
if isnumeric(filename) return; end
[~,filestr,~]=fileparts(filename);
inID=fopen([pathname,filename]);
temp=textscan(inID,'%f %f %f %f %f %f %f %f %f',1,'headerlines',3); ngx=temp{1};ngy=temp{4};ngz=temp{7};
sizef=[ngx*ngy+1,ngz];
textscan(inID,'%s',1,'headerlines',2);
fvalue=fscanf(inID,'%f',sizef);
fvalue=padarray(reshape(fvalue(2:end,:),[ngx,ngy,ngz]),[1,1,1],'circular','post');
fmin=min(fvalue(:)); fmax=max(fvalue(:));
if strcmpi(coordtype,'Cartesian') xyzuse=xyzlist(unitcellset,:);
else xyzuse=xyzlist(unitcellset,:)*unitcell;
end
XSFdata=struct('file',filestr,'XSFatomlist',{elemlist(unitcellset)},'XSFxyzlist',xyzuse,'XSFunitcell',unitcell,'XSFngfft',[ngx,ngy,ngz],'XSFrange',[fmin,fmax],'XSFgrid',fvalue);
modified=true;  set(handles.export_xsf,'enable','on');
export_xsf_Callback(handles.export_xsf,eventdata,handles);


% --- Executes on button press in render.
function render_Callback(hObject, eventdata, handles)
% hObject    handle to render (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist xyzlist xyzcart atomdist unitcell functionlist coordtype CPdata CMdata mu3data raMOdata camparam viewcoord figurestack;
if isempty(functionlist) waitfor(msgbox('The function list is empty.','Figuretool2')); return; end
fcnnames=cellfun(@(x)x.function,functionlist,'UniformOutput',0);
if isempty(atomlist) waitfor(msgbox('No template has been read in.','Figuretool2')); return; end
if strcmpi(coordtype,'direct')
   if isequal(size(unitcell),[3,3])&&abs(det(unitcell))<1E-6 waitfor(msgbox('The unit cell vectors are coplanar.','Figuretool2')); return; end
   xyzcart=xyzlist*unitcell;
else xyzcart=xyzlist;
end
if any(ismember({'drawcell','drawCP','drawraMO','drawmu3'},fcnnames))&&(~isequal(size(unitcell),[3,3])||(abs(det(unitcell))<1E-6))
   waitfor(msgbox('Unit cell vectors are not correctly specified.','Figuretool2')); return;
end
temp=functionlist(cellfun(@(x)strcmpi(x.function,'drawCP'),functionlist));
temp=cellfun(@(x)x.m,temp,'UniformOutput',0);
if any(strcmpi('CP',temp))&&isempty(CPdata) waitfor(msgbox('No CP data has been read in.','Figuretool2')); return; end
if any(strcmpi('CM',temp))&&isempty(CMdata) waitfor(msgbox('No CM data has been read in.','Figuretool2')); return; end
if isempty(raMOdata)&&ismember('drawraMO',fcnnames) waitfor(msgbox('No raMO data has been read in.','Figuretool2')); return; end
if isempty(mu3data)&&ismember('drawmu3',fcnnames) waitfor(msgbox('No mu3 data has been read in.','Figuretool2')); return; end
if numel(camparam.cv)==2 [xx,yy,zz]=sph2cart(camparam.cv(1)/180*pi,camparam.cv(2)/180*pi,1); bnorm=[xx,yy,zz]; else bnorm=camparam.cv; end
bnorm=bnorm/norm(bnorm);
if numel(camparam.cu)==2 [xx,yy,zz]=sph2cart(camparam.cu(1)/180*pi,camparam.cu(2)/180*pi,1); aup=[xx,yy,zz]; else aup=camparam.cu; end
aup=aup-bnorm*dot(aup,bnorm); aup=aup/norm(aup);
cline=cross(aup,bnorm); viewcoord=[aup;bnorm;cline];
atomdist=sum(bsxfun(@minus,permute(xyzcart,[1,3,2]),permute(xyzcart,[3,1,2])).^2,3).^0.5;
preconnmap();
[errmsg,status]=groupprep();
if status==1 waitfor(msgbox(errmsg,'Figuretool2')); return; end
hdlall=findall(0,'type','figure');
hdlall=hdlall(strncmpi('figuretool2_fig',get(hdlall,'tag'),15));
currfig=figure('tag',['figuretool2_fig',num2str(numel(hdlall)+1)]); hold on;
figuretool0(functionlist);
jFig=getjframe(currfig);
set(jFig,'WindowGainedFocusCallback',{@figfocusgained,currfig});
set(currfig,'CloseRequestFcn',{@figwindowclosed,currfig});
figurestack(end+1,:)={get(currfig,'tag'),camva};

% --- Executes on button press in savefigure.
function savefigure_Callback(hObject, eventdata, handles)
% hObject    handle to savefigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global figres fgtfilename fgtpathname;
hdlall=findall(0,'type','figure');
hdlall=hdlall(strncmpi('figuretool2_fig',get(hdlall,'tag'),15));
if isempty(hdlall) waitfor(msgbox('There is no figure to be saved.','Figuretool2'));
else
   [filename,pathname]=uiputfile({'*.png','Portable network graphics (.png)';'*.tiff','Tagged image file (.tiff)';...
      '*.fig','MATLAB figure file (.fig)';'*.bmp','Bitmap image (.bmp)'},'Figuretool2',[fgtpathname,fgtfilename(1:end-4)]);
   if isnumeric(filename) return; end
   [~,filestem,fileext]=fileparts(filename);
   if numel(hdlall)==1
      if strcmpi(fileext,'.fig')
         savefig(hdlall,[pathname,filestem,fileext]);
      else
         print(hdlall,[pathname,filestem,fileext],['-d',fileext(2:end)],['-r',num2str(figres)]);
      end
   else
      for j=1:numel(hdlall)
         fignum=[repmat('0',1,numel(num2str(numel(hdlall)))-numel(num2str(j))),num2str(j)];
         if strcmpi(fileext,'.fig')
            savefig(hdlall(j),[pathname,filestem,'_',fignum,fileext]);
         else
            print(hdlall(j),[pathname,filestem,'_',fignum,fileext],['-d',fileext(2:end)],['-r',num2str(figres)]);
         end
      end
   end
   msgbox(['Image file(s) successfully saved to: ',pathname,filename],'Figuretool2');
end

% --- Executes on button press in adjustcamera.
function adjustcamera_Callback(hObject, eventdata, handles)
% hObject    handle to adjustcamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hdlall=findall(0,'type','figure');
hdlall=hdlall(strncmpi('figuretool2_fig',get(hdlall,'tag'),15));
if isempty(hdlall) return; end
h0=adjustcamera;
uiwait(h0);
if ishandle(h0) delete(h0); end


% --- Executes when user attempts to close figuretool2.
function figuretool2_CloseRequestFcn(hObject, eventdata, handles)
global modified fgtfilename fgtpathname;
if modified
   while true
      button=questdlg('Save before quitting?','Figuretool2','Cancel');
      if strcmpi(button,'Yes')
         if isempty(fgtfilename)
            [filename,pathname]=uiputfile({'*.fgt','Figuretool2 file (.fgt)'});
            if isnumeric(filename) continue;
            else savefile(filename,pathname); break;
            end
         else savefile(fgtfilename,fgtpathname); break;
         end
      elseif strcmpi(button,'Cancel')
         return;
      else break;
      end
   end
end
delete(hObject); close all; fclose all; clearvars -global;

% --------- Unused Functions & Callbacks ---------

function file_Callback(hObject, eventdata, handles)

function file_import_Callback(hObject, eventdata, handles)

function file_export_Callback(hObject, eventdata, handles)

function edit_Callback(hObject, eventdata, handles)

function parameters_Callback(hObject, eventdata, handles)

function effects_Callback(hObject, eventdata, handles)

function programs_Callback(hObject, eventdata, handles)

function for_app_packaging()
drawatom; drawbond; drawcell; drawpoly; drawcoord; drawCP; drawXSF; drawsurface;
drawchannel; drawinterface; drawvoronoi; drawraMO; drawmu3; drawplane; insertfigure; inserttext;
drawgreenline; drawcoordsystem;

% ------------End of Unused Callbacks ------------

function preconnmap()
global elemlist connmap spdmin spdmax;
spdmin=zeros(numel(elemlist),numel(elemlist))+2;
spdmax=zeros(numel(elemlist),numel(elemlist))+4;
for k=1:size(connmap,1)
   ind1=strcmpi(connmap{k,2},elemlist);ind2=strcmpi(connmap{k,3},elemlist);
   if connmap{k,1}
      spdmin(ind1,ind2)=connmap{k,4}; spdmin(ind2,ind1)=connmap{k,4};
      spdmax(ind1,ind2)=connmap{k,5}; spdmax(ind2,ind1)=connmap{k,5};
   else
      spdmin(ind1,ind2)=eps; spdmin(ind2,ind1)=eps;
      spdmax(ind1,ind2)=0; spdmax(ind2,ind1)=0;
   end
end
