function varargout = setres(varargin)
% SETRES MATLAB code for setres.fig
%      SETRES, by itself, creates a new SETRES or raises the existing
%      singleton*.
%
%      H = SETRES returns the handle to a new SETRES or the handle to
%      the existing singleton*.
%
%      SETRES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETRES.M with the given input arguments.
%
%      SETRES('Property','Value',...) creates a new SETRES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before setres_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to setres_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setres

% Last Modified by GUIDE v2.5 08-Aug-2014 18:28:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @setres_OpeningFcn, ...
                   'gui_OutputFcn',  @setres_OutputFcn, ...
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


% --- Executes just before setres is made visible.
function setres_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to setres (see VARARGIN)
global res figres;
% Choose default command line output for setres
handles.output = hObject;
set(handles.edit1_setres,'string',num2str(res));
set(handles.edit2_setres,'string',num2str(figres));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes setres wait for user response (see UIRESUME)
% uiwait(handles.setres);


% --- Outputs from this function are returned to the command line.
function varargout = setres_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_setres_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_setres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global res;
resout=str2double(get(hObject,'string'));
if isnan(resout)||(resout<0)||(resout~=round(resout))
   set(hObject,'string',num2str(res)); waitfor(msgbox('Please enter a positive integer.','Figuretool2')); return;
end
% Hints: get(hObject,'String') returns contents of edit1_setres as text
%        str2double(get(hObject,'String')) returns contents of edit1_setres as a double


% --- Executes during object creation, after setting all properties.
function edit1_setres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_setres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_setres.
function OK_setres_Callback(hObject, eventdata, handles)
% hObject    handle to OK_setres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global res figres;
resout=str2double(get(handles.edit1_setres,'string'));
figresout=str2double(get(handles.edit2_setres,'string'));
if isnan(resout)||(resout<0)||(resout~=round(resout))||isnan(figresout)||(figresout<0)||(figresout~=round(figresout)) return; end
if resout>30 button=questdlg('Using such a high object resolution will make the rendering very slow. Are you sure?','Figuretool2','Yes','No','No');
   if ~strcmpi(button,'Yes') return; end
end
if (figresout<50) button=questdlg('The figure resolution is probably too low. Are you sure?','Figuretool2','Yes','No','No');
   if ~strcmpi(button,'Yes') return; end
end
res=resout; figres=figresout; uiresume;

% --- Executes on button press in cancel_setres.
function cancel_setres_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_setres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;



function edit2_setres_Callback(hObject, eventdata, handles)
% hObject    handle to edit2_setres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global figres;
resout=str2double(get(hObject,'string'));
if isnan(resout)||(resout<0)||(resout~=round(resout))
   set(hObject,'string',num2str(figres)); waitfor(msgbox('Please enter a positive integer.','Figuretool2')); return;
end
% Hints: get(hObject,'String') returns contents of edit2_setres as text
%        str2double(get(hObject,'String')) returns contents of edit2_setres as a double


% --- Executes during object creation, after setting all properties.
function edit2_setres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2_setres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
