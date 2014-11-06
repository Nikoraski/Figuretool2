function varargout = getbox(varargin)
% GETBOX MATLAB code for getbox.fig
%      GETBOX, by itself, creates a new GETBOX or raises the existing
%      singleton*.
%
%      H = GETBOX returns the handle to a new GETBOX or the handle to
%      the existing singleton*.
%
%      GETBOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GETBOX.M with the given input arguments.
%
%      GETBOX('Property','Value',...) creates a new GETBOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before getbox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to getbox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help getbox

% Last Modified by GUIDE v2.5 28-Jul-2014 15:46:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @getbox_OpeningFcn, ...
                   'gui_OutputFcn',  @getbox_OutputFcn, ...
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


% --- Executes just before getbox is made visible.
function getbox_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getbox (see VARARGIN)

% Choose default command line output for getbox
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes getbox wait for user response (see UIRESUME)
% uiwait(handles.getbox);


% --- Outputs from this function are returned to the command line.
function varargout = getbox_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_getbox.
function OK_getbox_Callback(hObject, eventdata, handles)
% hObject    handle to OK_getbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.rb1_cn_getbox,'value')==1 cnflag='r'; else cnflag='c'; end
if get(handles.rb1_rn_getbox,'value')==1 rnflag='r'; else rnflag='c'; end
cnstr=['[',get(handles.x_cn_getbox,'string'),',',get(handles.y_cn_getbox,'string'),',',get(handles.z_cn_getbox,'string'),']'];
rnstr=['[',get(handles.x_rn_getbox,'string'),',',get(handles.y_rn_getbox,'string'),',',get(handles.z_rn_getbox,'string'),']'];
set(get(hObject,'parent'),'userdata',['box<',cnflag,',',rnflag,'>(',cnstr,',',rnstr,')']);
uiresume;

% --- Executes on button press in cancel_getbox.
function cancel_getbox_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_getbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;


function z_rn_getbox_Callback(hObject, eventdata, handles)
% hObject    handle to z_rn_getbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0) set(hObject,'string','0.5'); waitfor(msgbox('Please enter a positive real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of z_rn_getbox as text
%        str2double(get(hObject,'String')) returns contents of z_rn_getbox as a double


% --- Executes during object creation, after setting all properties.
function z_rn_getbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_rn_getbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_rn_getbox_Callback(hObject, eventdata, handles)
% hObject    handle to y_rn_getbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0) set(hObject,'string','0.5'); waitfor(msgbox('Please enter a positive real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of y_rn_getbox as text
%        str2double(get(hObject,'String')) returns contents of y_rn_getbox as a double


% --- Executes during object creation, after setting all properties.
function y_rn_getbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_rn_getbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_rn_getbox_Callback(hObject, eventdata, handles)
% hObject    handle to x_rn_getbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0) set(hObject,'string','0.5'); waitfor(msgbox('Please enter a positive real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of x_rn_getbox as text
%        str2double(get(hObject,'String')) returns contents of x_rn_getbox as a double


% --- Executes during object creation, after setting all properties.
function x_rn_getbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_rn_getbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_cn_getbox_Callback(hObject, eventdata, handles)
% hObject    handle to x_cn_getbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of x_cn_getbox as text
%        str2double(get(hObject,'String')) returns contents of x_cn_getbox as a double


% --- Executes during object creation, after setting all properties.
function x_cn_getbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_cn_getbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_cn_getbox_Callback(hObject, eventdata, handles)
% hObject    handle to y_cn_getbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of y_cn_getbox as text
%        str2double(get(hObject,'String')) returns contents of y_cn_getbox as a double


% --- Executes during object creation, after setting all properties.
function y_cn_getbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_cn_getbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_cn_getbox_Callback(hObject, eventdata, handles)
% hObject    handle to z_cn_getbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of z_cn_getbox as text
%        str2double(get(hObject,'String')) returns contents of z_cn_getbox as a double


% --- Executes during object creation, after setting all properties.
function z_cn_getbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_cn_getbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
