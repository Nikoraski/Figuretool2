function varargout = getsphere(varargin)
% GETSPHERE MATLAB code for getsphere.fig
%      GETSPHERE, by itself, creates a new GETSPHERE or raises the existing
%      singleton*.
%
%      H = GETSPHERE returns the handle to a new GETSPHERE or the handle to
%      the existing singleton*.
%
%      GETSPHERE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GETSPHERE.M with the given input arguments.
%
%      GETSPHERE('Property','Value',...) creates a new GETSPHERE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before getsphere_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to getsphere_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help getsphere

% Last Modified by GUIDE v2.5 28-Jul-2014 15:57:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @getsphere_OpeningFcn, ...
                   'gui_OutputFcn',  @getsphere_OutputFcn, ...
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


% --- Executes just before getsphere is made visible.
function getsphere_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getsphere (see VARARGIN)

% Choose default command line output for getsphere
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes getsphere wait for user response (see UIRESUME)
% uiwait(handles.getsphere);


% --- Outputs from this function are returned to the command line.
function varargout = getsphere_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_getsphere.
function OK_getsphere_Callback(hObject, eventdata, handles)
% hObject    handle to OK_getsphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.rb1_cn_getsphere,'value')==1 cnflag='r'; else cnflag='c'; end
cnstr=['[',get(handles.x_cn_getsphere,'string'),',',get(handles.y_cn_getsphere,'string'),',',get(handles.z_cn_getsphere,'string'),']'];
set(get(hObject,'parent'),'userdata',['sphere<',cnflag,'>(',cnstr,',',get(handles.r_getsphere,'string'),')']);
uiresume;

% --- Executes on button press in cancel_getsphere.
function cancel_getsphere_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_getsphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;



function x_cn_getsphere_Callback(hObject, eventdata, handles)
% hObject    handle to x_cn_getsphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of x_cn_getsphere as text
%        str2double(get(hObject,'String')) returns contents of x_cn_getsphere as a double


% --- Executes during object creation, after setting all properties.
function x_cn_getsphere_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_cn_getsphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_cn_getsphere_Callback(hObject, eventdata, handles)
% hObject    handle to y_cn_getsphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of y_cn_getsphere as text
%        str2double(get(hObject,'String')) returns contents of y_cn_getsphere as a double


% --- Executes during object creation, after setting all properties.
function y_cn_getsphere_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_cn_getsphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_cn_getsphere_Callback(hObject, eventdata, handles)
% hObject    handle to z_cn_getsphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of z_cn_getsphere as text
%        str2double(get(hObject,'String')) returns contents of z_cn_getsphere as a double


% --- Executes during object creation, after setting all properties.
function z_cn_getsphere_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_cn_getsphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function r_getsphere_Callback(hObject, eventdata, handles)
% hObject    handle to r_getsphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0) set(hObject,'string','3'); waitfor(msgbox('Please enter a positive real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of r_getsphere as text
%        str2double(get(hObject,'String')) returns contents of r_getsphere as a double


% --- Executes during object creation, after setting all properties.
function r_getsphere_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_getsphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
