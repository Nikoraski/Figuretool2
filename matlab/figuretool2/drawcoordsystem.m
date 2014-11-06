function varargout = drawcoordsystem(varargin)
% DRAWCOORDSYSTEM MATLAB code for drawcoordsystem.fig
%      DRAWCOORDSYSTEM, by itself, creates a new DRAWCOORDSYSTEM or raises the existing
%      singleton*.
%
%      H = DRAWCOORDSYSTEM returns the handle to a new DRAWCOORDSYSTEM or the handle to
%      the existing singleton*.
%
%      DRAWCOORDSYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWCOORDSYSTEM.M with the given input arguments.
%
%      DRAWCOORDSYSTEM('Property','Value',...) creates a new DRAWCOORDSYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drawcoordsystem_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drawcoordsystem_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drawcoordsystem

% Last Modified by GUIDE v2.5 04-Nov-2014 18:58:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @drawcoordsystem_OpeningFcn, ...
                   'gui_OutputFcn',  @drawcoordsystem_OutputFcn, ...
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


% --- Executes just before drawcoordsystem is made visible.
function drawcoordsystem_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawcoordsystem (see VARARGIN)

% Choose default command line output for drawcoordsystem
handles.output = hObject;
if isempty(get(hObject,'Userdata'))
   st0=struct('function','drawcoordsystem','dist',1,'size',1,'style','black','label','on');
   set(hObject,'Userdata',st0);
else
   st0=get(hObject,'userdata');
   set(handles.dist_drawcoordsystem,'string',num2str(st0.dist));
   set(handles.size_drawcoordsystem,'string',num2str(st0.size));
   if strcmpi(st0.style,'colored') set(handles.rb2_style_drawcoordsystem,'value',1); end
   if strcmpi(st0.label,'off') set(handles.label_on_drawcoordsystem,'value',0); end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drawcoordsystem wait for user response (see UIRESUME)
% uiwait(handles.drawcoordsystem);


% --- Outputs from this function are returned to the command line.
function varargout = drawcoordsystem_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in label_on_drawcoordsystem.
function label_on_drawcoordsystem_Callback(hObject, eventdata, handles)
% hObject    handle to label_on_drawcoordsystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of label_on_drawcoordsystem


% --- Executes on button press in OK_drawcoordsystem.
function OK_drawcoordsystem_Callback(hObject, eventdata, handles)
% hObject    handle to OK_drawcoordsystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'userdata');
st0.dist=str2double(get(handles.dist_drawcoordsystem,'string'));
st0.size=str2double(get(handles.size_drawcoordsystem,'string'));
if get(handles.rb1_style_drawcoordsystem,'value')==1 st0.style='black'; else st0.style='colored'; end
if get(handles.label_on_drawcoordsystem,'value')==1 st0.label='on'; else st0.label='off'; end
set(get(hObject,'parent'),'userdata',st0);
uiresume;

% --- Executes on button press in cancel_drawcoordsystem.
function cancel_drawcoordsystem_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_drawcoordsystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;


function dist_drawcoordsystem_Callback(hObject, eventdata, handles)
% hObject    handle to dist_drawcoordsystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<0) set(hObject,'string','1'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of dist_drawcoordsystem as text
%        str2double(get(hObject,'String')) returns contents of dist_drawcoordsystem as a double


% --- Executes during object creation, after setting all properties.
function dist_drawcoordsystem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dist_drawcoordsystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function size_drawcoordsystem_Callback(hObject, eventdata, handles)
% hObject    handle to size_drawcoordsystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0) set(hObject,'string','1'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of size_drawcoordsystem as text
%        str2double(get(hObject,'String')) returns contents of size_drawcoordsystem as a double


% --- Executes during object creation, after setting all properties.
function size_drawcoordsystem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to size_drawcoordsystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
