function varargout = choosecell(varargin)
% CHOOSECELL MATLAB code for choosecell.fig
%      CHOOSECELL, by itself, creates a new CHOOSECELL or raises the existing
%      singleton*.
%
%      H = CHOOSECELL returns the handle to a new CHOOSECELL or the handle to
%      the existing singleton*.
%
%      CHOOSECELL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHOOSECELL.M with the given input arguments.
%
%      CHOOSECELL('Property','Value',...) creates a new CHOOSECELL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before choosecell_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to choosecell_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help choosecell

% Last Modified by GUIDE v2.5 28-Oct-2014 17:04:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @choosecell_OpeningFcn, ...
                   'gui_OutputFcn',  @choosecell_OutputFcn, ...
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


% --- Executes just before choosecell is made visible.
function choosecell_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to choosecell (see VARARGIN)
global unitcell;
% Choose default command line output for choosecell
handles.output = hObject;
oldcell=get(hObject,'userdata');
if isempty(oldcell)
temp=cell(size(unitcell,1),4);
temp(:,1)=num2cell(true(size(unitcell,1),1));
temp(:,2:4)=num2cell(unitcell);
else
   temp=cell(size(oldcell,1),4);
   temp(:,1)=num2cell(true(size(oldcell,1),1));
   temp(:,2:4)=num2cell(oldcell);
end
set(handles.table_choosecell,'data',temp);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes choosecell wait for user response (see UIRESUME)
% uiwait(handles.choosecell);


% --- Outputs from this function are returned to the command line.
function varargout = choosecell_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_choosecell.
function OK_choosecell_Callback(hObject, eventdata, handles)
% hObject    handle to OK_choosecell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global unitcell;
oldcell=get(get(hObject,'parent'),'userdata');
temp=get(handles.table_choosecell,'data');
if sum(cell2mat(temp(:,1)))~=3 waitfor(msgbox('Please choose 3 cell vectors.','Figuretool2')); return;
else
   if isempty(oldcell) unitcell=unitcell(cell2mat(temp(:,1)),:);
   else set(get(hObject,'parent'),'userdata',oldcell(cell2mat(temp(:,1)),:));
   end
   uiresume;
end

% --- Executes on button press in cancel_choosecell.
function cancel_choosecell_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_choosecell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;
