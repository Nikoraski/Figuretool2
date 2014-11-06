function varargout = setconn(varargin)
% SETCONN MATLAB code for setconn.fig
%      SETCONN, by itself, creates a new SETCONN or raises the existing
%      singleton*.
%
%      H = SETCONN returns the handle to a new SETCONN or the handle to
%      the existing singleton*.
%
%      SETCONN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETCONN.M with the given input arguments.
%
%      SETCONN('Property','Value',...) creates a new SETCONN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before setconn_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to setconn_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setconn

% Last Modified by GUIDE v2.5 29-Sep-2014 15:03:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @setconn_OpeningFcn, ...
                   'gui_OutputFcn',  @setconn_OutputFcn, ...
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


% --- Executes just before setconn is made visible.
function setconn_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to setconn (see VARARGIN)
global atomlist connmap;
% Choose default command line output for setconn
handles.output = hObject;
elemlist0=cell(size(atomlist));
for j=1:numel(atomlist)
   elemlist0{j}=regexprep(atomlist{j},'[0-9]','');
end
elemlist0=unique(elemlist0);
nrows=numel(elemlist0)*(numel(elemlist0)+1)/2;
data=cell(nrows,5);
counter=0;
for j=1:numel(elemlist0)
   for k=j:numel(elemlist0)
      counter=counter+1;
      data{counter,2}=elemlist0{j};
      data{counter,3}=elemlist0{k};
      for l=1:size(connmap,1)
         if strcmpi(connmap{l,2},elemlist0{j})&&strcmpi(connmap{l,3},elemlist0{k})
            data{counter,1}=connmap{l,1}; data{counter,4}=connmap{l,4}; data{counter,5}=connmap{l,5}; break;
         end
      end
      if isempty(data{counter,1})
         data{counter,1}=true; data{counter,4}=2.0; data{counter,5}=4.0;
      end
   end
end
set(handles.table_setconn,'data',data);
jscroll=findjobj(handles.table_setconn);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
jtable.getColumnModel().getColumn(3).setResizable(false);
jtable.getColumnModel().getColumn(4).setResizable(false);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes setconn wait for user response (see UIRESUME)
% uiwait(handles.setconn);


% --- Outputs from this function are returned to the command line.
function varargout = setconn_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_setconn.
function OK_setconn_Callback(hObject, eventdata, handles)
% hObject    handle to OK_setconn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global connmap;
temp=get(handles.table_setconn,'data');
dmm=cell2mat(temp(:,4:5));
if any(isempty(dmm(:)))||any(isnan(dmm(:))) waitfor(msgbox('Please make sure there is no empty or NaN cells in the table.','Figuretool2')); return;
elseif any(dmm(:,1)>=dmm(:,2)) waitfor(msgbox('Minimum distance must be shorter than maximum distance.','Figuretool2')); return;
elseif any(dmm(:,1)<=0) waitfor(msgbox('Minimum distance must be positive.','Figuretool2')); return;
end
connmap=temp;
uiresume;

% --- Executes on button press in cancel_setconn.
function cancel_setconn_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_setconn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;


% --- Executes on selection change in calc_setconn.
function calc_setconn_Callback(hObject, eventdata, handles)
% hObject    handle to calc_setconn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global elemname metalrad atomrad vdwrad;
conndata=get(handles.table_setconn,'data');
switch get(hObject,'Value')
   case 2,
      for j=1:size(conndata,1)
         elem1=conndata{j,2}; elem2=conndata{j,3};
         if ~ismember(elem1,elemname)||~ismember(elem2,elemname) continue;
         else radsum=metalrad(strcmpi(elem1,elemname))+metalrad(strcmpi(elem2,elemname));
            conndata{j,4}=radsum*0.8; conndata{j,5}=radsum*1.2;
         end
      end
   case 3,
      for j=1:size(conndata,1)
         elem1=conndata{j,2}; elem2=conndata{j,3};
         if ~ismember(elem1,elemname)||~ismember(elem2,elemname) continue;
         else radsum=atomrad(strcmpi(elem1,elemname))+atomrad(strcmpi(elem2,elemname));
            conndata{j,4}=radsum*0.8; conndata{j,5}=radsum*1.2;
         end
      end
   case 4,
      for j=1:size(conndata,1)
         elem1=conndata{j,2}; elem2=conndata{j,3};
         if ~ismember(elem1,elemname)||~ismember(elem2,elemname) continue;
         else radsum=vdwrad(strcmpi(elem1,elemname))+vdwrad(strcmpi(elem2,elemname));
            conndata{j,4}=radsum*0.8; conndata{j,5}=radsum*1.2;
         end
      end
end
set(handles.table_setconn,'data',conndata);
% Hints: contents = cellstr(get(hObject,'String')) returns calc_setconn contents as cell array
%        contents{get(hObject,'Value')} returns selected item from calc_setconn


% --- Executes during object creation, after setting all properties.
function calc_setconn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to calc_setconn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
