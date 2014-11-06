function varargout = drawgreenline(varargin)
% DRAWGREENLINE MATLAB code for drawgreenline.fig
%      DRAWGREENLINE, by itself, creates a new DRAWGREENLINE or raises the existing
%      singleton*.
%
%      H = DRAWGREENLINE returns the handle to a new DRAWGREENLINE or the handle to
%      the existing singleton*.
%
%      DRAWGREENLINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWGREENLINE.M with the given input arguments.
%
%      DRAWGREENLINE('Property','Value',...) creates a new DRAWGREENLINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drawgreenline_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drawgreenline_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drawgreenline

% Last Modified by GUIDE v2.5 03-Nov-2014 19:40:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @drawgreenline_OpeningFcn, ...
                   'gui_OutputFcn',  @drawgreenline_OutputFcn, ...
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


% --- Executes just before drawgreenline is made visible.
function drawgreenline_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawgreenline (see VARARGIN)

% Choose default command line output for drawgreenline
handles.output = hObject;
if isempty(get(hObject,'Userdata'))
   st0=struct('function','drawgreenline','dist',1,'len',3);
   set(hObject,'Userdata',st0);
else
   st0=get(hObject,'userdata');
   set(handles.dist_drawgreenline,'string',num2str(st0.dist));
   set(handles.length_drawgreenline,'string',num2str(st0.len));
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drawgreenline wait for user response (see UIRESUME)
% uiwait(handles.drawgreenline);


% --- Outputs from this function are returned to the command line.
function varargout = drawgreenline_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function dist_drawgreenline_Callback(hObject, eventdata, handles)
% hObject    handle to dist_drawgreenline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0) set(hObject,'string','1'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of dist_drawgreenline as text
%        str2double(get(hObject,'String')) returns contents of dist_drawgreenline as a double


% --- Executes during object creation, after setting all properties.
function dist_drawgreenline_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dist_drawgreenline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function length_drawgreenline_Callback(hObject, eventdata, handles)
% hObject    handle to length_drawgreenline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0) set(hObject,'string','3'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of length_drawgreenline as text
%        str2double(get(hObject,'String')) returns contents of length_drawgreenline as a double


% --- Executes during object creation, after setting all properties.
function length_drawgreenline_CreateFcn(hObject, eventdata, handles)
% hObject    handle to length_drawgreenline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_drawgreenline.
function OK_drawgreenline_Callback(hObject, eventdata, handles)
% hObject    handle to OK_drawgreenline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'userdata');
st0.dist=str2double(get(handles.dist_drawgreenline,'string'));
st0.len=str2double(get(handles.length_drawgreenline,'string'));
set(get(hObject,'parent'),'userdata',st0);
uiresume;

% --- Executes on button press in cancel_drawgreenline.
function cancel_drawgreenline_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_drawgreenline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;