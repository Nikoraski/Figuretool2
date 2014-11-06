function varargout = moviemaker(varargin)
% MOVIEMAKER MATLAB code for moviemaker.fig
%      MOVIEMAKER, by itself, creates a new MOVIEMAKER or raises the existing
%      singleton*.
%
%      H = MOVIEMAKER returns the handle to a new MOVIEMAKER or the handle to
%      the existing singleton*.
%
%      MOVIEMAKER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOVIEMAKER.M with the given input arguments.
%
%      MOVIEMAKER('Property','Value',...) creates a new MOVIEMAKER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before moviemaker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to moviemaker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help moviemaker

% Last Modified by GUIDE v2.5 27-Aug-2014 16:53:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @moviemaker_OpeningFcn, ...
                   'gui_OutputFcn',  @moviemaker_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before moviemaker is made visible.
function moviemaker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to moviemaker (see VARARGIN)

% Choose default command line output for moviemaker
global nframe dataseries rowname0 atomlist xyzlist unitcell coordtype CPdata CMdata raMOdata mu3data XSFdata MOdata ...
   templatefile templatelist CPdatalist CMdatalist raMOdatalist mu3datalist XSFdatalist MOdatalist;
if isempty(templatelist) 
   temp=struct('file',templatefile,'atomlist',{atomlist},'xyzlist',xyzlist,'unitcell',unitcell,'coordtype',coordtype);
   templatelist={1,temp,'';nframe,temp,{'linear'}};
end
if isempty(CPdatalist)&&~isempty(CPdata) CPdatalist={1,CPdata,'';nframe,CPdata,{'linear'}}; end
if isempty(CMdatalist)&&~isempty(CMdata) CMdatalist={1,CMdata,'';nframe,CMdata,{'linear'}}; end
if isempty(raMOdatalist)&&~isempty(raMOdata) raMOdatalist={1,raMOdata,'';nframe,raMOdata,{'linear'}}; end
if isempty(mu3datalist)&&~isempty(mu3data) mu3datalist={1,mu3data,'';nframe,mu3data,{'linear'}}; end
if isempty(XSFdatalist)&&~isempty(XSFdata) XSFdatalist={1,XSFdata,'';nframe,XSFdata,{'linear'}}; end
if isempty(MOdatalist)&&~isempty(MOdata) MOdatalist={1,MOdata,'';nframe,MOdata,{'linear'}}; end
temp={templatelist,CPdatalist,CMdatalist,raMOdatalist,mu3datalist,XSFdatalist,MOdatalist};
temp2={'template';'CPdata';'CMdata';'raMOdata';'mu3data';'XSFdata';'MOdata'};
dataseries=temp(~cellfun(@isempty,temp));
rowname0=temp2(~cellfun(@isempty,temp));
handles.output = hObject;
import com.jidesoft.grid.*;
handles.output = hObject;
jscroll=findjobj(handles.table_mm);
jtable=jscroll.getViewport.getView;
jtable.setShowGrid(true);
jtable.setGridColor(java.awt.Color(0.5,0.5,0.5));
handles.jtable=jtable;
tableupdate(handles);
set(hObject,'userdata',[1,1;2,1]);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes moviemaker wait for user response (see UIRESUME)
% uiwait(handles.moviemaker);

function tableupdate(handles)
global functionlist fcnmovielist dataseries rowname0 nframe motionlist;
import com.jidesoft.grid.*;
jtable=handles.jtable;
cols=num2cell(1:nframe);
cols=cellfun(@(x)num2str(x),cols,'UniformOutput',0);
data0=cell(numel(dataseries),nframe);
for j=1:numel(dataseries)
   for k=1:size(dataseries{j},1)
      data0{j,dataseries{j}{k,1}}=colortext('K',1,[0.6,1,0.7]);
      if k~=1
         if isequal(dataseries{j}{k-1,2},dataseries{j}{k,2}) str=colortext('=',1,[0.6,1,0.7]); else str=colortext('&#8594',1,[0.6,1,0.7]); end
         for l=dataseries{j}{k-1,1}+1:dataseries{j}{k,1}-1
            data0{j,l}=str;
         end
      end
   end
end
data1=cell(numel(functionlist),nframe);
for j=1:numel(functionlist)
   for k=1:size(fcnmovielist{j},1)
      data1{j,fcnmovielist{j}{k,1}}=colortext('K',1,[0.7,0.8,1]);
      if k~=1
         if isequal(fcnmovielist{j}{k-1,2},fcnmovielist{j}{k,2}) str=colortext('=',1,[0.7,0.8,1]); else str=colortext('&#8594',1,[0.7,0.8,1]); end
         for l=fcnmovielist{j}{k-1,1}+1:fcnmovielist{j}{k,1}-1
            data1{j,l}=str;
         end
      end
   end
end
rowname1=cellfun(@(x)x.function,functionlist,'UniformOutput',0)';
data2=cell(size(motionlist,1),nframe);
for j=1:size(motionlist,1)
   data2{j,motionlist{j,1}(1)}=colortext(motionlist{j,2}.motion,motionlist{j,1}(2)-motionlist{j,1}(1)+1,[1,0.9,0.5]);
end
if isempty(motionlist) rowname2={};
else rowname2=cellfun(@(x)x.motion,motionlist(:,2),'UniformOutput',0);
end
jtable.setModel(DefaultSpanTableModel([data0;data1;data2;cell(1,nframe)],cols));
set(handles.table_mm,'RowName',[rowname0;rowname1;rowname2;{''}]);
ncolumns=jtable.getColumnCount();
ndigit=numel(num2str(ncolumns));
sclass=java.lang.String('').getClass;
renderer=jtable.getDefaultRenderer(sclass);
editor=jtable.getDefaultEditor(sclass);
editor.getComponent.setEditable(0);
editor.setClickCountToStart(65535);
for j=1:ncolumns
   jtable.getColumnModel.getColumn(j-1).setResizable(false);
   jtable.getColumnModel.getColumn(j-1).setPreferredWidth(10+6*ndigit);
   jtable.getColumnModel.getColumn(j-1).setCellRenderer(renderer);
   jtable.getColumnModel.getColumn(j-1).setCellEditor(editor);
end

function textout=colortext(text,col,color)
global nframe;
if all(isspace(text)) text='&#32'; end
ndigit=numel(num2str(nframe));
hex(:,2:7)=reshape(sprintf('%02X',round(color*255).'),6,[]).'; 
hex(:,1)='#';
textout=['<html><table border=0 width=',num2str(col*(10+6*ndigit)),' bgcolor=',hex,'><TR><TD align="center">',text,'</TD></TR> </table></html>'];

% --- Outputs from this function are returned to the command line.
function varargout = moviemaker_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in newkf_mm.
function newkf_mm_Callback(hObject, eventdata, handles)
% hObject    handle to newkf_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rowname0 dataseries fcnmovielist functionlist templatelist CPdatalist CMdatalist raMOdatalist mu3datalist XSFdatalist MOdatalist;
ind=get(get(hObject,'parent'),'userdata');
if (size(ind,1)~=1)||(ind(1)>numel(fcnmovielist)+numel(dataseries)) return; end
if ind(1)<=numel(dataseries)
   dataname=rowname0{ind(1)};
   templist=dataseries{ind(1)};
   framelist=cell2mat(templist(:,1)); if any(ind(2)==framelist) return; end
   prevframe=find(ind(2)>framelist,1,'last');
   nextframe=find(ind(2)<framelist,1);
   fcnhdl=str2func(['read',dataname]);
   dataout=fcnhdl(templist{prevframe,2});
   if isempty(dataout) return; end
   newlist=[templist(1:prevframe,:);{ind(2),dataout,{'linear'}};templist(prevframe+1:end,:)];
   dataseries{ind(1)}=newlist;
   switch dataname
      case 'template', templatelist=newlist;
      case 'CPdata', CPdatalist=newlist;
      case 'CMdata', CMdatalist=newlist;
      case 'raMOdata', raMOdatalist=newlist;
      case 'mu3data', mu3datalist=newlist;
      case 'XSFdata', XSFdatalist=newlist;
      case 'MOdata', MOdatalist=newlist;
   end
   handles.jtable.setValueAt(colortext('K',1,[0.6,1,0.7]),ind(1)-1,ind(2)-1);
   dataout.file=templist{prevframe,2}.file;
   if isequal(templist{prevframe,2},dataout) str=colortext('=',1,[0.6,1,0.7]); else str=colortext('&#8594',1,[0.6,1,0.7]); end
   for k=framelist(prevframe)+1:ind(2)-1
      handles.jtable.setValueAt(str,ind(1)-1,k-1);
   end
   dataout.file=templist{nextframe,2}.file;
   if isequal(templist{nextframe,2},dataout) str=colortext('=',1,[0.6,1,0.7]); else str=colortext('&#8594',1,[0.6,1,0.7]); end
   for k=ind(2)+1:framelist(nextframe)-1
      handles.jtable.setValueAt(str,ind(1)-1,k-1);
   end
else
   templist=fcnmovielist{ind(1)-numel(dataseries)};
   if ~isempty(templist) framelist=cell2mat(templist(:,1));
      if any(ind(2)==framelist) return; end
      prevframe=find(ind(2)>framelist,1,'last');
      nextframe=find(ind(2)<framelist,1);
   end
   if isempty(templist) prevframe=0; nextframe=[]; st0=functionlist{ind(1)-numel(dataseries)};
   elseif isempty(prevframe) prevframe=0; st0=templist{1,2};
   else st0=templist{prevframe,2};
   end
   fcnhdl=str2func(st0.function);
   h0=fcnhdl('userdata',st0);
   uiwait(h0);
   if ~ishandle(h0) return; end
   st1=get(h0,'Userdata');
   delete(h0);
   if ischar(st1)&&strcmpi(st1,'cancelled') return; end
   if ~structcmp(st1,functionlist{ind(1)-numel(dataseries)})
      waitfor(msgbox('Only numerical parameters can be modified in a function channel.','Figuretool2')); return;
   end
   newlist=[templist(1:prevframe,:);{ind(2),st1,{'linear'}};templist(prevframe+1:end,:)];
   fcnmovielist{ind(1)-numel(dataseries)}=newlist;
   handles.jtable.setValueAt(colortext('K',1,[0.7,0.8,1]),ind(1)-1,ind(2)-1);
   if prevframe~=0
      if isequal(templist{prevframe,2},st1) str=colortext('=',1,[0.7,0.8,1]); else str=colortext('&#8594',1,[0.7,0.8,1]); end
      for k=framelist(prevframe)+1:ind(2)-1
         handles.jtable.setValueAt(str,ind(1)-1,k-1);
      end
   end
   if ~isempty(nextframe)
      if isequal(templist{nextframe,2},st1) str=colortext('=',1,[0.7,0.8,1]); else str=colortext('&#8594',1,[0.7,0.8,1]); end
      for k=ind(2)+1:framelist(nextframe)-1
         handles.jtable.setValueAt(str,ind(1)-1,k-1);
      end
   end
end

% --- Executes on button press in editkf_mm.
function editkf_mm_Callback(hObject, eventdata, handles)
% hObject    handle to editkf_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rowname0 dataseries fcnmovielist functionlist templatelist CPdatalist CMdatalist raMOdatalist mu3datalist XSFdatalist MOdatalist;
ind=get(get(hObject,'parent'),'userdata');
if (size(ind,1)~=1)||(ind(1)>numel(fcnmovielist)+numel(dataseries)) return; end
if ind(1)<=numel(dataseries)
   dataname=rowname0{ind(1)};
   templist=dataseries{ind(1)};
   framelist=cell2mat(templist(:,1)); if ~any(ind(2)==framelist) return; end
   currdata=templist{ind(2)==framelist,2};
   prevframe=find(ind(2)>framelist,1,'last');
   nextframe=find(ind(2)<framelist,1);
   fcnhdl=str2func(['read',dataname]);
   dataout=fcnhdl(currdata);
   if isempty(dataout) return; end
   templist{ind(2)==framelist,2}=dataout;
   dataseries{ind(1)}=templist;
   switch dataname
      case 'template', templatelist=templist;
      case 'CPdata', CPdatalist=templist;
      case 'CMdata', CMdatalist=templist;
      case 'raMOdata', raMOdatalist=templist;
      case 'mu3data', mu3datalist=templist;
      case 'XSFdata', XSFdatalist=templist;
      case 'MOdata', MOdatalist=templist;
   end
   dataout.file=templist{prevframe,2}.file;
   if isequal(templist{prevframe,2},dataout) str=colortext('=',1,[0.6,1,0.7]); else str=colortext('&#8594',1,[0.6,1,0.7]); end
   for k=framelist(prevframe)+1:ind(2)-1
      handles.jtable.setValueAt(str,ind(1)-1,k-1);
   end
   dataout.file=templist{nextframe,2}.file;
   if isequal(templist{nextframe,2},dataout) str=colortext('=',1,[0.6,1,0.7]); else str=colortext('&#8594',1,[0.6,1,0.7]); end
   for k=ind(2)+1:framelist(nextframe)-1
      handles.jtable.setValueAt(str,ind(1)-1,k-1);
   end
else
   templist=fcnmovielist{ind(1)-numel(dataseries)};
   if isempty(templist) return; end
   framelist=cell2mat(templist(:,1));
   if ~any(ind(2)==framelist) return; end
   st0=templist{ind(2)==framelist,2};
   prevframe=find(ind(2)>framelist,1,'last');
   nextframe=find(ind(2)<framelist,1);
   fcnhdl=str2func(st0.function);
   h0=fcnhdl('userdata',st0);
   uiwait(h0);
   if ~ishandle(h0) return; end
   st1=get(h0,'Userdata');
   delete(h0);
   if ischar(st1)&&strcmpi(st1,'cancelled') return; end
   if ~structcmp(st1,functionlist{ind(1)-numel(dataseries)})
      waitfor(msgbox('Only numerical parameters can be modified in a function channel.','Figuretool2')); return;
   end
   templist{ind(2)==framelist,2}=st1;
   fcnmovielist{ind(1)-numel(dataseries)}=templist;
   if prevframe~=0
      if isequal(templist{prevframe,2},st1) str=colortext('=',1,[0.7,0.8,1]); else str=colortext('&#8594',1,[0.7,0.8,1]); end
      for k=framelist(prevframe)+1:ind(2)-1
         handles.jtable.setValueAt(str,ind(1)-1,k-1);
      end
   end
   if ~isempty(nextframe)
      if isequal(templist{nextframe,2},st1) str=colortext('=',1,[0.7,0.8,1]); else str=colortext('&#8594',1,[0.7,0.8,1]); end
      for k=ind(2)+1:framelist(nextframe)-1
         handles.jtable.setValueAt(str,ind(1)-1,k-1);
      end
   end
end

% --- Executes on button press in deletekf_mm.
function deletekf_mm_Callback(hObject, eventdata, handles)
% hObject    handle to deletekf_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rowname0 dataseries fcnmovielist nframe templatelist CPdatalist CMdatalist raMOdatalist mu3datalist XSFdatalist MOdatalist;
ind=get(get(hObject,'parent'),'userdata');
if (size(ind,1)~=1)||(ind(1)>numel(fcnmovielist)+numel(dataseries)) return; end
if ind(1)<=numel(dataseries)
   dataname=rowname0{ind(1)};
   templist=dataseries{ind(1)};
   framelist=cell2mat(templist(:,1));
   if ~any(ind(2)==framelist) return; end
   if (ind(2)==1)||(ind(2)==nframe) waitfor(msgbox('The first and last frames in a data series must be keyframes.','Figuretool2')); return; end
   prevframe=find(ind(2)>framelist,1,'last');
   nextframe=find(ind(2)<framelist,1);
   if isequal(templist{prevframe,2},templist{nextframe,2}) str=colortext('=',1,[0.6,1,0.7]); else str=colortext('&#8594',1,[0.6,1,0.7]); end
   for k=framelist(prevframe)+1:framelist(nextframe)-1
      handles.jtable.setValueAt(str,ind(1)-1,k-1);
   end
   templist(ind(2)==framelist,:)=[];
   dataseries{ind(1)}=templist;
   switch dataname
      case 'template', templatelist=templist;
      case 'CPdata', CPdatalist=templist;
      case 'CMdata', CMdatalist=templist;
      case 'raMOdata', raMOdatalist=templist;
      case 'mu3data', mu3datalist=templist;
      case 'XSFdata', XSFdatalist=templist;
      case 'MOdata', MOdatalist=templist;
   end
else
   templist=fcnmovielist{ind(1)-numel(dataseries)};
   if isempty(templist) return; end
   framelist=cell2mat(templist(:,1));
   if ~any(ind(2)==framelist) return; end
   if size(templist,1)==1
      handles.jtable.setValueAt('',ind(1)-1,ind(2)-1);
      fcnmovielist{ind(1)-numel(dataseries)}={};
      return;
   end
   prevframe=find(ind(2)>framelist,1,'last');
   nextframe=find(ind(2)<framelist,1);
   if isempty(prevframe)
      for k=1:framelist(nextframe)-1
         handles.jtable.setValueAt('',ind(1)-1,k-1);
      end
   elseif isempty(nextframe)
      for k=framelist(prevframe)+1:nframe
         handles.jtable.setValueAt('',ind(1)-1,k-1);
      end
   else
      if isequal(templist{prevframe,2},templist{nextframe,2}) str=colortext('=',1,[0.7,0.8,1]); else str=colortext('&#8594',1,[0.7,0.8,1]); end
      for k=framelist(prevframe)+1:framelist(nextframe)-1
         handles.jtable.setValueAt(str,ind(1)-1,k-1);
      end
   end
   templist(ind(2)==framelist,:)=[];
   fcnmovielist{ind(1)-numel(dataseries)}=templist;
end

function dataout=readtemplate(datain)
dataout=[];
[filename,pathname]=uigetfile({'*.prn','Diamond3 template file (.prn)';'*.xtl','VESTA template file (.xtl)';'*.xyz',...
   'atomic coordinate file (.xyz)'},'Figuretool2');
if isnumeric(filename) return; end
[~,~,fileext]=fileparts(filename);
inID=fopen([pathname,filename]);
linenum=1; nondata=0;
while(1)
   templine=fgetl(inID);
   if ~ischar(templine)||strcmpi(templine,'EOF') break;
   else
      if ~all(isspace(templine))
         temp=textscan(templine,'%s %f %f %f %s');
         if isempty(temp{4})||isnan(temp{4})||~isnan(str2double(temp{1}))||~isempty(temp{5}) nondata=linenum; end
      end
   end
   linenum=linenum+1;
end
frewind(inID); temp=textscan(inID,'%s %f %f %f','headerlines',nondata);
atomlistnew=temp{1}; atomlistnew=atomlistnew(~strcmpi('EOF',atomlistnew));
xyzlistnew=[temp{2}(1:numel(atomlistnew)),temp{3}(1:numel(atomlistnew)),temp{4}(1:numel(atomlistnew))];
isdummy=strcmpi('Dummy',atomlistnew); isdummy0=strcmpi('Dummy0',atomlistnew);
if any(isdummy)&&~any(isdummy0)
   button=questdlg('Figuretool detected atoms labelled as ''Dummy''. Do you wish to convert them to ''Dummy0''?','Figuretool','Yes','No','Yes');
   if strcmpi(button,'Yes') atomlistnew(isdummy)=repmat({'Dummy0'},sum(isdummy),1); end
end
temp=~ismember(atomlistnew,{'&','<CELL>'});
unitcellnew=xyzlistnew(~temp,:);
if size(unitcellnew,1)>3
   h0=choosecell('userdata',unitcellnew);
   uiwait(h0);
   if ishandle(h0) unitcellnew=get(h0,'userdata'); delete(h0); end
end
xyzlistnew=xyzlistnew(temp,:);
atomlistnew=atomlistnew(temp);
atomlistnew=atomlistnew(~isnan(xyzlistnew(:,3)));
xyzlistnew=xyzlistnew(~isnan(xyzlistnew(:,3)),:);
fclose(inID);
if strcmpi(fileext,'.xtl') coordtypenew='direct'; else coordtypenew='Cartesian'; end
if ~isequal(atomlistnew,datain.atomlist) waitfor(msgbox(['The content of this template file is inconsistent with the previous one.',...
      ' Please make sure they have identical list of atoms.'],'Figuretool2')); return; end
if ~isequal(size(unitcellnew),size(datain.unitcell)) waitfor(msgbox('The unit cell setting is inconsistent with the previous template.','Figuretool2')); return; end
if ~strcmpi(coordtypenew,datain.coordtype) waitfor(msgbox('The templates must use the same type of coordinates (Cartesian/direct).','Figuretool2')); return; end
dataout=struct('file',filename,'atomlist',{atomlistnew},'xyzlist',xyzlistnew,'unitcell',unitcellnew,'coordtype',coordtypenew);

function dataout=readCPdata(datain)
dataout=[];
[filename,pathname]=uigetfile({'*-coeff','CP/CM result file'},'Figuretool2');
if isnumeric(filename) return; end
[~,filestr,fileext]=fileparts(filename);
filestem=filename(1:end-6);
if ~exist([pathname,filestem,'-geo'],'file')||~exist([pathname,filestem,'-cell'],'file') waitfor(msgbox('Incomplete CP data set!','Figuretool2')); return; end
inID=fopen([pathname,filestem,'-geo']);
temp=textscan(inID,'%s %f %f %f');
CPatomlist=temp{1}; CPxyzlist=[temp{2},temp{3},temp{4}];
fclose(inID);
inID=fopen([pathname,filestem,'-cell']);
temp=textscan(inID,'%f %f %f');
CPunitcell=[temp{1},temp{2},temp{3}];
fclose(inID);
inID=fopen([pathname,filestem,'-coeff']);
temp=textscan(inID,'%s %f');
CPcomp=temp{1};
CPcoeff=reshape(temp{2},numel(temp{2})/numel(CPatomlist),numel(CPatomlist));
CPlmax=sqrt(size(CPcoeff,1))-1;
fclose(inID);
if ~isequal(CPatomlist,datain.CPatomlist) waitfor(msgbox('The atom list in this CP file is inconsistent with the previous one.','Figuretool2')); return; end
if CPlmax~=datain.CPlmax waitfor(msgbox('The specified lmax value is inconsistent with the previous data set.','Figuretool2')); return; end
dataout=struct('file',filestem,'CPatomlist',{CPatomlist},'CPxyzlist',CPxyzlist,'CPunitcell',CPunitcell,'CPcomp',{CPcomp},'CPcoeff',CPcoeff,'CPlmax',CPlmax);

function dataout=readCMdata(datain)
dataout=[];
[filename,pathname]=uigetfile({'*-coeff','CP/CM result file'},'Figuretool2');
if isnumeric(filename) return; end
[~,filestr,fileext]=fileparts(filename);
filestem=filename(1:end-6);
if ~exist([pathname,filestem,'-geo'],'file')||~exist([pathname,filestem,'-cell'],'file') waitfor(msgbox('Incomplete CM data set!','Figuretool2')); return; end
inID=fopen([pathname,filestem,'-geo']);
temp=textscan(inID,'%s %f %f %f');
CMatomlist=temp{1}; CMxyzlist=[temp{2},temp{3},temp{4}];
fclose(inID);
inID=fopen([pathname,filestem,'-cell']);
temp=textscan(inID,'%f %f %f');
CMunitcell=[temp{1},temp{2},temp{3}];
fclose(inID);
inID=fopen([pathname,filestem,'-coeff']);
temp=textscan(inID,'%s %f');
CMcomp=temp{1};
fclose(inID);
CMcoeff=reshape(temp{2},numel(temp{2})/numel(CPatomlist),numel(CPatomlist));
CMlmax=sqrt(size(CPcoeff,1))-1;
if ~isequal(CMatomlist,datain.CMatomlist) waitfor(msgbox('The atom list in this CM file is inconsistent with the previous one.','Figuretool2')); return; end
if CMlmax~=datain.CMlmax waitfor(msgbox('The specified lmax value is inconsistent with the previous data set.','Figuretool2')); return; end
dataout=struct('file',filestem,'CMatomlist',{CMatomlist},'CMxyzlist',CMxyzlist,'CMunitcell',CMunitcell,'CMcomp',{CMcomp},'CMcoeff',CMcoeff,'CMlmax',CMlmax);

function dataout=readmu3data(datain)
dataout=[];
[filename,pathname]=uigetfile({'*.mu3output','mu3-acidity result file'},'Figuretool2');
if isnumeric(filename) return; end
[~,filestr,fileext]=fileparts(filename);
if ~exist([pathname,filestr,'-geo'],'file')||~exist([pathname,filestr,'-cell'],'file') waitfor(msgbox('Incomplete mu3 data set!','Figuretool2')); return; end
inID=fopen([pathname,filestr,'-geo']);
temp=textscan(inID,'%s %f %f %f');
mu3atomlist=temp{1}; mu3xyzlist=[temp{2},temp{3},temp{4}];
fclose(inID);
inID=fopen([pathname,filestr,'-cell']);
temp=textscan(inID,'%f %f %f');
mu3unitcell=[temp{1},temp{2},temp{3}];
fclose(inID);
inID=fopen([pathname,filename]);
temp=textscan(inID,'%f %f %f');
mu3occ_id=temp{2}; mu3occ_act=temp{3};
fclose(inID);
if ~isequal(mu3atomlist,datain.mu3atomlist) waitfor(msgbox('The atom list in this mu3 file is inconsistent with the previous one.','Figuretool2')); return; end
dataout=struct('file',filestr,'mu3atomlist',{mu3atomlist},'mu3xyzlist',mu3xyzlist,'mu3unitcell',mu3unitcell,'mu3occ_id',mu3occ_id,'mu3occ_act',mu3occ_act);

% --- Executes on button press in newmotion_mm.
function newmotion_mm_Callback(hObject, eventdata, handles)
% hObject    handle to newmotion_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global nframe motionlist;
ind=get(get(hObject,'parent'),'userdata');
lastrow=handles.jtable.getRowCount();
if ~isequal(unique(ind(:,1)),lastrow) return; end
cols=unique(ind(:,2))'; if ~isequal(cols(1):cols(end),cols)||numel(cols)==1 return; end
import com.jidesoft.grid.*;
h0=newmotion;
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if ischar(temp)&&strcmpi(temp,'cancelled') return; end
fcnhdl=str2func(temp);
h0=fcnhdl();
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if ischar(temp)&&strcmpi(temp,'cancelled') return; end
handles.jtable.setValueAt(colortext(temp.motion,numel(cols),[1,0.9,0.5]),lastrow-1,cols(1)-1);
handles.jtable.getModel.addCellSpan(CellSpan(lastrow-1,cols(1)-1,1,numel(cols)));
handles.jtable.getModel.addRow(repmat({''},1,nframe));
motionlist=[motionlist;{[cols(1),cols(end)],temp,{'linear'}}];


% --- Executes on button press in editmotion_mm.
function editmotion_mm_Callback(hObject, eventdata, handles)
% hObject    handle to editmotion_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fcnmovielist dataseries motionlist;
ind=get(get(hObject,'parent'),'userdata');
lastrow=handles.jtable.getRowCount();
if (size(ind,1)~=1)||(ind(1)<=numel(fcnmovielist)+numel(dataseries))||(ind(1)==lastrow)||~isequal(ind(2),motionlist{ind(1)-numel(fcnmovielist)-numel(dataseries)}(1)) return; end
import com.jidesoft.grid.*;
h0=editmotion('userdata',motionlist{ind(1)-numel(fcnmovielist)-numel(dataseries),1});
uiwait(h0);
if ~ishandle(h0) return; end
frange=get(h0,'userdata');
delete(h0);
if ischar(frange)&&strcmpi(frange,'cancelled') return; end
fcnhdl=str2func(motionlist{ind(1)-numel(fcnmovielist)-numel(dataseries),2}.motion);
h0=fcnhdl('userdata',motionlist{ind(1)-numel(fcnmovielist)-numel(dataseries),2});
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if ischar(temp)&&strcmpi(temp,'cancelled') return; end
motionlist{ind(1)-numel(fcnmovielist)-numel(dataseries),1}=frange;
motionlist{ind(1)-numel(fcnmovielist)-numel(dataseries),2}=temp;
handles.jtable.getModel.removeCellSpan(ind(1)-1,ind(2)-1);
handles.jtable.getModel.setValueAt('',ind(1)-1,ind(2)-1);
handles.jtable.addCellSpan(CellSpan(ind(1)-1,frange(1)-1,1,frange(2)-frange(1)+1));
handles.jtable.getModel.setValueAt(colortext(temp.motion,frange(2)-frange(1)+1,[1,0.9,0.5]),ind(1)-1,frange(1)-1);


% --- Executes on button press in delmotion_mm.
function delmotion_mm_Callback(hObject, eventdata, handles)
% hObject    handle to delmotion_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fcnmovielist dataseries motionlist;
ind=get(get(hObject,'parent'),'userdata');
lastrow=handles.jtable.getRowCount();
if (size(ind,1)~=1)||(ind(1)<=numel(fcnmovielist)+numel(dataseries))||(ind(1)==lastrow)||~isequal(ind(2),motionlist{ind(1)-numel(fcnmovielist)-numel(dataseries)}(1)) return; end
import com.jidesoft.grid.*;
handles.jtable.getModel.removeCellSpan(ind(1)-1,ind(2)-1);
handles.jtable.getModel.removeRow(ind(1)-1);
motionlist(ind(1)-numel(fcnmovielist)-numel(dataseries),:)=[];
for j=ind(1)-numel(fcnmovielist)-numel(dataseries):size(motionlist,1)
   handles.jtable.getModel.removeCellSpan(j+numel(fcnmovielist)+numel(dataseries)-1,motionlist{j,1}(1)-1);
   handles.jtable.getModel.addCellSpan(j+numel(fcnmovielist)+numel(dataseries)-2,motionlist{j,1}(1)-1,1,motionlist{j,1}(2)-motionlist{j,1}(1)+1);
end

% --- Executes on button press in videoset_mm.
function videoset_mm_Callback(hObject, eventdata, handles)
% hObject    handle to videoset_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in start_mm.
function start_mm_Callback(hObject, eventdata, handles)
% hObject    handle to start_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in exit_mm.
function exit_mm_Callback(hObject, eventdata, handles)
% hObject    handle to exit_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in setaccel_mm.
function setaccel_mm_Callback(hObject, eventdata, handles)
% hObject    handle to setaccel_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in table_mm.
function table_mm_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to table_mm (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata',eventdata.Indices);

function isiden=structcmp(st1,st2)
isiden=true;
fieldlist=fieldnames(st1);
for j=1:numel(fieldlist)
   jname=fieldlist{j};
   if ~isnumeric(st1.(jname))||strncmpi(st1.(jname),'site',4)||strcmpi(st1.(jname),'res')
      if ~isequal(st1.(jname),st2.(jname)) isiden=false; return; end
   else
      if ~isequal(size(st1.(jname)),size(st2.(jname))) isiden=false; return; end
   end
end









