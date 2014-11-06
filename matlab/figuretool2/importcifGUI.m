function varargout = importcifGUI(varargin)
% IMPORTCIFGUI MATLAB code for importcifGUI.fig
%      IMPORTCIFGUI, by itself, creates a new IMPORTCIFGUI or raises the existing
%      singleton*.
%
%      H = IMPORTCIFGUI returns the handle to a new IMPORTCIFGUI or the handle to
%      the existing singleton*.
%
%      IMPORTCIFGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPORTCIFGUI.M with the given input arguments.
%
%      IMPORTCIFGUI('Property','Value',...) creates a new IMPORTCIFGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before importcifGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to importcifGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help importcifGUI

% Last Modified by GUIDE v2.5 29-Oct-2014 17:59:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @importcifGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @importcifGUI_OutputFcn, ...
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


% --- Executes just before importcifGUI is made visible.
function importcifGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to importcifGUI (see VARARGIN)

% Choose default command line output for importcifGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes importcifGUI wait for user response (see UIRESUME)
% uiwait(handles.importcifGUI);


% --- Outputs from this function are returned to the command line.
function varargout = importcifGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
JEdit=findjobj(handles.edit_importcifGUI);
JEdit.Editable=0;
% Get default command line output from handles structure
varargout{1} = handles.output;



function xmin_importcifGUI_Callback(hObject, eventdata, handles)
% hObject    handle to xmin_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value) waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of xmin_importcifGUI as text
%        str2double(get(hObject,'String')) returns contents of xmin_importcifGUI as a double


% --- Executes during object creation, after setting all properties.
function xmin_importcifGUI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmin_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xmax_importcifGUI_Callback(hObject, eventdata, handles)
% hObject    handle to xmax_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value) waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of xmax_importcifGUI as text
%        str2double(get(hObject,'String')) returns contents of xmax_importcifGUI as a double


% --- Executes during object creation, after setting all properties.
function xmax_importcifGUI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmax_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ymin_importcifGUI_Callback(hObject, eventdata, handles)
% hObject    handle to ymin_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value) waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of ymin_importcifGUI as text
%        str2double(get(hObject,'String')) returns contents of ymin_importcifGUI as a double


% --- Executes during object creation, after setting all properties.
function ymin_importcifGUI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymin_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ymax_importcifGUI_Callback(hObject, eventdata, handles)
% hObject    handle to ymax_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value) waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of ymax_importcifGUI as text
%        str2double(get(hObject,'String')) returns contents of ymax_importcifGUI as a double


% --- Executes during object creation, after setting all properties.
function ymax_importcifGUI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymax_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zmin_importcifGUI_Callback(hObject, eventdata, handles)
% hObject    handle to zmin_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value) waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of zmin_importcifGUI as text
%        str2double(get(hObject,'String')) returns contents of zmin_importcifGUI as a double


% --- Executes during object creation, after setting all properties.
function zmin_importcifGUI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmin_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zmax_importcifGUI_Callback(hObject, eventdata, handles)
% hObject    handle to zmax_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value) waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of zmax_importcifGUI as text
%        str2double(get(hObject,'String')) returns contents of zmax_importcifGUI as a double


% --- Executes during object creation, after setting all properties.
function zmax_importcifGUI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmax_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_importcifGUI_Callback(hObject, eventdata, handles)
% hObject    handle to edit_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_importcifGUI as text
%        str2double(get(hObject,'String')) returns contents of edit_importcifGUI as a double


% --- Executes during object creation, after setting all properties.
function edit_importcifGUI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse_importcifGUI.
function browse_importcifGUI_Callback(hObject, eventdata, handles)
% hObject    handle to browse_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.cif','Crystallographic information file (.cif)'},'Figuretool2');
if isnumeric(filename) return; end
set(handles.edit_importcifGUI,'string',[pathname,filename]);

% --- Executes on button press in OK_importcifGUI.
function OK_importcifGUI_Callback(hObject, eventdata, handles)
% hObject    handle to OK_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xmin=str2double(get(handles.xmin_importcifGUI,'string'));
xmax=str2double(get(handles.xmax_importcifGUI,'string'));
ymin=str2double(get(handles.ymin_importcifGUI,'string'));
ymax=str2double(get(handles.ymax_importcifGUI,'string'));
zmin=str2double(get(handles.zmin_importcifGUI,'string'));
zmax=str2double(get(handles.zmax_importcifGUI,'string'));
if (xmin>=xmax)||(ymin>=ymax)||(zmin>=zmax) waitfor(msgbox('The lower bound must be lower than the upper bound.','Figuretool2')); return; end
importcif0(get(handles.edit_importcifGUI,'string'),[xmin,xmax,ymin,ymax,zmin,zmax]);
uiresume;

% --- Executes on button press in cancel_importcifGUI.
function cancel_importcifGUI_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_importcifGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;
