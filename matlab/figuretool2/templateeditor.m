function varargout = templateeditor(varargin)
% TEMPLATEEDITOR MATLAB code for templateeditor.fig
%      TEMPLATEEDITOR, by itself, creates a new TEMPLATEEDITOR or raises the existing
%      singleton*.
%
%      H = TEMPLATEEDITOR returns the handle to a new TEMPLATEEDITOR or the handle to
%      the existing singleton*.
%
%      TEMPLATEEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEMPLATEEDITOR.M with the given input arguments.
%
%      TEMPLATEEDITOR('Property','Value',...) creates a new TEMPLATEEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before templateeditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to templateeditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help templateeditor

% Last Modified by GUIDE v2.5 16-Oct-2014 18:43:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @templateeditor_OpeningFcn, ...
                   'gui_OutputFcn',  @templateeditor_OutputFcn, ...
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


% --- Executes just before templateeditor is made visible.
function templateeditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to templateeditor (see VARARGIN)
global coordtype;
if strcmpi(coordtype,'Cartesian') set(handles.ct_rb1_tempedit,'value',1.0);
elseif strcmpi(coordtype,'direct') set(handles.ct_rb2_tempedit,'value',1.0);
end
temp=get(hObject,'Userdata');
set(handles.table_tempedit,'data',temp(:,[1,3:5]));
% Choose default command line output for templateeditor
set(hObject,'Userdata',[]);
handles.output = hObject;
jscroll=findjobj(handles.table_tempedit);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
jtable.getColumnModel().getColumn(3).setResizable(false);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes templateeditor wait for user response (see UIRESUME)
% uiwait(handles.tempedit);


% --- Outputs from this function are returned to the command line.
function varargout = templateeditor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in above_tempedit.
function above_tempedit_Callback(hObject, eventdata, handles)
% hObject    handle to above_tempedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
indices=get(get(hObject,'parent'),'Userdata');
if isempty(indices) return; end
nrow=unique(indices(:,1));
if numel(nrow)~=1 return; end
temp=get(handles.table_tempedit,'data');
temp(nrow+1:end+1,:)=temp(nrow:end,:);
temp(nrow,:)=cell(1,4); temp{nrow,1}='';
set(handles.table_tempedit,'data',temp);

% --- Executes on button press in below_tempedit.
function below_tempedit_Callback(hObject, eventdata, handles)
% hObject    handle to below_tempedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
indices=get(get(hObject,'parent'),'Userdata');
if isempty(indices) return; end
nrow=unique(indices(:,1));
if numel(nrow)~=1 return; end
temp=get(handles.table_tempedit,'data');
if nrow~=size(temp,1)
temp(nrow+2:end+1,:)=temp(nrow+1:end,:);
temp(nrow+1,:)=cell(1,4); temp{nrow+1,1}='';
else temp(nrow+1,:)=cell(1,4); temp{nrow+1,1}='';
end
set(handles.table_tempedit,'data',temp);

% --- Executes on button press in delete_tempedit.
function delete_tempedit_Callback(hObject, eventdata, handles)
% hObject    handle to delete_tempedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
indices=get(get(hObject,'parent'),'Userdata');
if isempty(indices) return; end
nrow=unique(indices(:,1));
temp=get(handles.table_tempedit,'data');
temp(nrow,:)=[];
if isempty(temp) temp=cell(1,4); temp{1}=''; end
set(handles.table_tempedit,'data',temp);

% --- Executes on button press in OK_tempedit.
function OK_tempedit_Callback(hObject, eventdata, handles)
% hObject    handle to OK_tempedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist xyzlist coordtype unitcell;
temp=get(handles.table_tempedit,'data');
if any(cellfun(@isempty,temp(:)))||any(any(cellfun(@isnan,temp(:,2:4))))
   waitfor(msgbox('Please make sure there is no empty or NaN cells in the table.','Figuretool2'));
   return;
end
if (get(handles.ct_rb1_tempedit,'value')==0)&&(get(handles.ct_rb2_tempedit,'value')==0)
   waitfor(msgbox('Please specify coordinate type.','Figuretool2'));
   return;
end
if get(handles.ct_rb1_tempedit,'value')==1 coordtype='Cartesian'; else coordtype='direct'; end
atomlist=temp(:,1);
cellvec=ismember(atomlist,{'&','<CELL>'});
atomlist=atomlist(~cellvec);
if any(cellvec)
   if sum(cellvec)==3
      if isempty(unitcell)
         unitcell=cell2mat(temp(cellvec,2:4));
      else
         button=questdlg('Do you wish to overwrite existing unit cell vectors?','Figuretool2','Yes','No','Yes');
         if strcmpi(button,'Yes') unitcell=cell2mat(temp(cellvec,2:4)); end
      end
   elseif sum(cellvec)>3
      h0=choosecell('userdata',cell2mat(temp(cellvec,2:4)));
      uiwait(h0);
      if ~ishandle(h0)
         msgbox('Cell vectors not imported. You can change cell vector settings in Parameters -> Unit cell .','Figuretool2');
      else ctemp=get(h0,'userdata');
         delete(h0);
         if strcmpi(ctemp,'cancelled')
            msgbox('Cell vectors not imported. You can change cell vector settings in Parameters -> Unit cell .','Figuretool2');
         else unitcell=ctemp;
         end
      end
   elseif sum(cellvec)<3
      msgbox('Cell vectors not imported. You can change cell vector settings in Parameters -> Unit cell.','Figuretool2');
   end
end
temp=temp(~cellvec,:);
xyzlist=cell2mat(temp(:,2:4));
elemgen();
set(get(hObject,'parent'),'Userdata',temp);
uiresume;

% --- Executes on button press in cancel_tempedit.
function cancel_tempedit_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_tempedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes when selected cell(s) is changed in table_tempedit.
function table_tempedit_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to table_tempedit (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata',eventdata.Indices);


% --- Executes when entered data in editable cell(s) in table_tempedit.
function table_tempedit_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to table_tempedit (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in paste_tempedit.
function paste_tempedit_Callback(hObject, eventdata, handles)
% hObject    handle to paste_tempedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=clipboard('paste');
data=regexp(data,'\n','split'); data=data(~cellfun(@isempty,data));
if isempty(data) return; end
rdata=cell(numel(data),4);
err=0;
for j=1:numel(data)
   temp=regexp(data{j},'\s','split'); temp=temp(~cellfun(@isempty,temp));
   if numel(temp)~=4 err=1; break;
   else tempx=str2double(temp{2}); tempy=str2double(temp{3}); tempz=str2double(temp{4});
      if any(isnan([tempx,tempy,tempz])) err=1; break; end
      rdata(j,:)={temp{1},tempx,tempy,tempz};
   end
end
if err==1 waitfor(msgbox(['The input string being pasted from the clipboard must have the format',char(10),...
      '<sitename> <x> <y> <z>.'],'Figuretool2')); return;
else set(handles.table_tempedit,'data',rdata);
end






