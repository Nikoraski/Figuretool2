function varargout = atomcolormix(varargin)
% ATOMCOLORMIX MATLAB code for atomcolormix.fig
%      ATOMCOLORMIX, by itself, creates a new ATOMCOLORMIX or raises the existing
%      singleton*.
%
%      H = ATOMCOLORMIX returns the handle to a new ATOMCOLORMIX or the handle to
%      the existing singleton*.
%
%      ATOMCOLORMIX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ATOMCOLORMIX.M with the given input arguments.
%
%      ATOMCOLORMIX('Property','Value',...) creates a new ATOMCOLORMIX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before atomcolormix_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to atomcolormix_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help atomcolormix

% Last Modified by GUIDE v2.5 30-Sep-2014 13:56:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @atomcolormix_OpeningFcn, ...
                   'gui_OutputFcn',  @atomcolormix_OutputFcn, ...
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


% --- Executes just before atomcolormix is made visible.
function atomcolormix_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to atomcolormix (see VARARGIN)
global atomlist;
% Choose default command line output for atomcolormix
handles.output = hObject;
set(handles.table_acm,'columnformat',{unique(atomlist)','numeric'});
if isempty(get(hObject,'userdata'))
   temp=get(handles.table_acm,'data');
   set(handles.table_acm,'data',temp(1:2,:));
else
   set(handles.table_acm,'data',get(hObject,'userdata'));
end
jscroll=findjobj(handles.table_acm);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes atomcolormix wait for user response (see UIRESUME)
% uiwait(handles.acm);


% --- Outputs from this function are returned to the command line.
function varargout = atomcolormix_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_acm.
function OK_acm_Callback(hObject, eventdata, handles)
% hObject    handle to OK_acm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.table_acm,'data');
if any(isnan(cell2mat(temp(:,2)))) waitfor(msgbox('Please make sure there is no NaN entries in the table.','Figuretool2')); return;
elseif any(cell2mat(temp(:,2))<0) waitfor(msgbox('The occupancies cannot be negative.','Figuretool2')); return;
elseif sum(cell2mat(temp(:,2)))>1.00001 waitfor(msgbox('The total occupancy cannot be greater than 1.','Figuretool2')); return;
else set(get(hObject,'parent'),'userdata',temp(cell2mat(temp(:,2))>0,:)); uiresume;
end

% --- Executes on button press in cancel_acm.
function cancel_acm_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_acm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;

% --- Executes when selected cell(s) is changed in table_acm.
function table_acm_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to table_acm (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'userdata',eventdata.Indices);

% --- Executes on button press in add_acm.
function add_acm_Callback(hObject, eventdata, handles)
% hObject    handle to add_acm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.table_acm,'data');
set(handles.table_acm,'data',[temp;cell(1,2)]);

% --- Executes on button press in delete_acm.
function delete_acm_Callback(hObject, eventdata, handles)
% hObject    handle to delete_acm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.table_acm,'data');
indices=get(handles.table_acm,'userdata');
nrow=unique(indices(:,1));
temp(nrow,:)=[];
set(handles.table_acm,'data',temp);
