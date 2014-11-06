function varargout = adjustcamera(varargin)
% ADJUSTCAMERA MATLAB code for adjustcamera.fig
%      ADJUSTCAMERA, by itself, creates a new ADJUSTCAMERA or raises the existing
%      singleton*.
%
%      H = ADJUSTCAMERA returns the handle to a new ADJUSTCAMERA or the handle to
%      the existing singleton*.
%
%      ADJUSTCAMERA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADJUSTCAMERA.M with the given input arguments.
%
%      ADJUSTCAMERA('Property','Value',...) creates a new ADJUSTCAMERA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before adjustcamera_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to adjustcamera_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help adjustcamera

% Last Modified by GUIDE v2.5 04-Nov-2014 15:53:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @adjustcamera_OpeningFcn, ...
                   'gui_OutputFcn',  @adjustcamera_OutputFcn, ...
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


% --- Executes just before adjustcamera is made visible.
function adjustcamera_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to adjustcamera (see VARARGIN)
% Choose default command line output for adjustcamera
handles.output = hObject;
adjustcamera_FocusGainedFcn(hObject,eventdata,handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes adjustcamera wait for user response (see UIRESUME)
% uiwait(handles.adjustcamera);

function adjustcamera_FocusGainedFcn(jAxis,jEventData,handles)
global figurestack;
if isempty(figurestack) return; end
currfig=findobj('tag',figurestack{end,1});
if numel(currfig)~=1 waitfor(msgbox('Cannot find the current axis.','Figuretool2')); return; end
curraxis=findall(currfig,'type','axes');
curraxis=curraxis(end);
cv=campos(curraxis)-camtarget(curraxis); cv=cv/norm(cv); cu=camup(curraxis);
set(handles.vx_adjcam,'enable','on','string',sprintf('%6.3f',cv(1)));
set(handles.vy_adjcam,'enable','on','string',sprintf('%6.3f',cv(2)));
set(handles.vz_adjcam,'enable','on','string',sprintf('%6.3f',cv(3)));
set(handles.set_cv_adjcam,'enable','on');
set(handles.use_cv_adjcam,'enable','on');
set(handles.ux_adjcam,'enable','on','string',sprintf('%6.3f',cu(1)));
set(handles.uy_adjcam,'enable','on','string',sprintf('%6.3f',cu(2)));
set(handles.uz_adjcam,'enable','on','string',sprintf('%6.3f',cu(3)));
set(handles.set_cu_adjcam,'enable','on');
set(handles.use_cu_adjcam,'enable','on');
set(handles.cr_adjcam,'enable','on','string',0);
set(handles.set_cr_adjcam,'enable','on');
set(handles.cz_adjcam,'enable','on','string',1);
set(handles.set_cz_adjcam,'enable','on');
set(handles.use_cz_adjcam,'enable','on');
set(handles.OK_adjcam,'enable','on');


function adjustcamera_FocusLostFcn(jAxis,jEventData,handles)
try
   set(handles.vx_adjcam,'enable','off');
   set(handles.vy_adjcam,'enable','off');
   set(handles.vz_adjcam,'enable','off');
   set(handles.set_cv_adjcam,'enable','off');
   set(handles.use_cv_adjcam,'enable','off');
   set(handles.ux_adjcam,'enable','off');
   set(handles.uy_adjcam,'enable','off');
   set(handles.uz_adjcam,'enable','off');
   set(handles.set_cu_adjcam,'enable','off');
   set(handles.use_cu_adjcam,'enable','off');
   set(handles.cr_adjcam,'enable','off');
   set(handles.set_cr_adjcam,'enable','off');
   set(handles.cz_adjcam,'enable','off');
   set(handles.set_cz_adjcam,'enable','off');
   set(handles.use_cz_adjcam,'enable','off');
catch
   return;
end

% --- Outputs from this function are returned to the command line.
function varargout = adjustcamera_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
jFig=getjframe(hObject);
set(jFig,'WindowGainedFocusCallback',{@adjustcamera_FocusGainedFcn,handles});
set(jFig,'WindowLostFocusCallback',{@adjustcamera_FocusLostFcn,handles});
% Get default command line output from handles structure
varargout{1} = handles.output;



function vx_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to vx_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vx_adjcam as text
%        str2double(get(hObject,'String')) returns contents of vx_adjcam as a double


% --- Executes during object creation, after setting all properties.
function vx_adjcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vx_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vy_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to vy_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vy_adjcam as text
%        str2double(get(hObject,'String')) returns contents of vy_adjcam as a double


% --- Executes during object creation, after setting all properties.
function vy_adjcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vy_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vz_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to vz_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vz_adjcam as text
%        str2double(get(hObject,'String')) returns contents of vz_adjcam as a double


% --- Executes during object creation, after setting all properties.
function vz_adjcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vz_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ux_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to ux_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ux_adjcam as text
%        str2double(get(hObject,'String')) returns contents of ux_adjcam as a double


% --- Executes during object creation, after setting all properties.
function ux_adjcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ux_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function uy_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to uy_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of uy_adjcam as text
%        str2double(get(hObject,'String')) returns contents of uy_adjcam as a double


% --- Executes during object creation, after setting all properties.
function uy_adjcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uy_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function uz_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to uz_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of uz_adjcam as text
%        str2double(get(hObject,'String')) returns contents of uz_adjcam as a double


% --- Executes during object creation, after setting all properties.
function uz_adjcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uz_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cr_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to cr_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cr_adjcam as text
%        str2double(get(hObject,'String')) returns contents of cr_adjcam as a double


% --- Executes during object creation, after setting all properties.
function cr_adjcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cr_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cz_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to cz_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cz_adjcam as text
%        str2double(get(hObject,'String')) returns contents of cz_adjcam as a double


% --- Executes during object creation, after setting all properties.
function cz_adjcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cz_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in set_cv_adjcam.
function set_cv_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to set_cv_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global figurestack;
if isempty(figurestack) return; end
currfig=findobj('tag',figurestack{end,1});
if numel(currfig)~=1 waitfor(msgbox('Cannot find the current axis.','Figuretool2')); return; end
curraxis=findall(currfig,'type','axes');
curraxis=curraxis(end);
vx=str2double(get(handles.vx_adjcam,'string'));
vy=str2double(get(handles.vy_adjcam,'string'));
vz=str2double(get(handles.vz_adjcam,'string'));
ux=str2double(get(handles.ux_adjcam,'string'));
uy=str2double(get(handles.uy_adjcam,'string'));
uz=str2double(get(handles.uz_adjcam,'string'));
if any(isnan([ux,uy,uz,vx,vy,vz])) waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
if norm([vx,vy,vz])<1E-6 waitfor(msgbox('The viewing direction cannot be the zero vector.')); return; end
if norm(cross([ux,uy,uz],[vx,vy,vz]))<1E-3 waitfor(msgbox('The viewing direction and up direction cannot be collinear.','Figuretool2')); return; end
view(curraxis,[vx,vy,vz]);

% --- Executes on button press in set_cu_adjcam.
function set_cu_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to set_cu_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global figurestack;
if isempty(figurestack) return; end
currfig=findobj('tag',figurestack{end,1});
if numel(currfig)~=1 waitfor(msgbox('Cannot find the current axis.','Figuretool2')); return; end
curraxis=findall(currfig,'type','axes');
curraxis=curraxis(end);
vx=str2double(get(handles.vx_adjcam,'string'));
vy=str2double(get(handles.vy_adjcam,'string'));
vz=str2double(get(handles.vz_adjcam,'string'));
ux=str2double(get(handles.ux_adjcam,'string'));
uy=str2double(get(handles.uy_adjcam,'string'));
uz=str2double(get(handles.uz_adjcam,'string'));
if any(isnan([ux,uy,uz,vx,vy,vz])) waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
if norm([ux,uy,uz])<1E-6 waitfor(msgbox('The up direction cannot be the zero vector.')); return; end
if norm(cross([ux,uy,uz],[vx,vy,vz]))<1E-3 waitfor(msgbox('The viewing direction and up direction cannot be collinear.','Figuretool2')); return; end
camup(curraxis,[ux,uy,uz]);
set(handles.cr_adjcam,'string','0');

% --- Executes on button press in set_cr_adjcam.
function set_cr_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to set_cr_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global figurestack;
if isempty(figurestack) return; end
currfig=findobj('tag',figurestack{end,1});
if numel(currfig)~=1 waitfor(msgbox('Cannot find the current axis.','Figuretool2')); return; end
curraxis=findall(currfig,'type','axes');
curraxis=curraxis(end);
cr=str2double(get(handles.cr_adjcam,'string'));
ux=str2double(get(handles.ux_adjcam,'string'));
uy=str2double(get(handles.uy_adjcam,'string'));
uz=str2double(get(handles.uz_adjcam,'string'));
if any(isnan([cr,ux,uy,uz])) waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
if norm([ux,uy,uz])<1E-6 waitfor(msgbox('The up direction cannot be the zero vector.')); return; end
camroll(curraxis,cr);
cu=camup(curraxis);
set(handles.ux_adjcam,'string',sprintf('%6.3f',cu(1)));
set(handles.uy_adjcam,'string',sprintf('%6.3f',cu(2)));
set(handles.uz_adjcam,'string',sprintf('%6.3f',cu(3)));
set(handles.cr_adjcam,'string','0');

% --- Executes on button press in set_cz_adjcam.
function set_cz_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to set_cz_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global figurestack;
if isempty(figurestack) return; end
currfig=findobj('tag',figurestack{end,1});
if numel(currfig)~=1 waitfor(msgbox('Cannot find the current axis.','Figuretool2')); return; end
curraxis=findall(currfig,'type','axes');
curraxis=curraxis(end);
cz=str2double(get(handles.cz_adjcam,'string'));
if isnan(cz)||(cz<=0) waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
camzoom(curraxis,cz);
set(handles.cz_adjcam,'string',1);


% --- Executes on button press in use_cv_adjcam.
function use_cv_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to use_cv_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camparam figurestack;
if isempty(figurestack) return; end
currfig=findobj('tag',figurestack{end,1});
if numel(currfig)~=1 waitfor(msgbox('Cannot find the current axis.','Figuretool2')); return; end
curraxis=findall(currfig,'type','axes');
curraxis=curraxis(end);
vx=str2double(get(handles.vx_adjcam,'string'));
vy=str2double(get(handles.vy_adjcam,'string'));
vz=str2double(get(handles.vz_adjcam,'string'));
ux=str2double(get(handles.ux_adjcam,'string'));
uy=str2double(get(handles.uy_adjcam,'string'));
uz=str2double(get(handles.uz_adjcam,'string'));
if any(isnan([ux,uy,uz,vx,vy,vz])) waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
if norm([vx,vy,vz])<1E-6 waitfor(msgbox('The viewing direction cannot be the zero vector.')); return; end
if norm(cross([ux,uy,uz],[vx,vy,vz]))<1E-3 waitfor(msgbox('The viewing direction and up direction cannot be collinear.','Figuretool2')); return; end
view(curraxis,[vx,vy,vz]);
camparam.cv=[vx,vy,vz];
camparam.cp='default';
camparam.ct='default';

% --- Executes on button press in use_cu_adjcam.
function use_cu_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to use_cu_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camparam figurestack;
if isempty(figurestack) return; end
currfig=findobj('tag',figurestack{end,1});
if numel(currfig)~=1 waitfor(msgbox('Cannot find the current axis.','Figuretool2')); return; end
curraxis=findall(currfig,'type','axes');
curraxis=curraxis(end);
vx=str2double(get(handles.vx_adjcam,'string'));
vy=str2double(get(handles.vy_adjcam,'string'));
vz=str2double(get(handles.vz_adjcam,'string'));
ux=str2double(get(handles.ux_adjcam,'string'));
uy=str2double(get(handles.uy_adjcam,'string'));
uz=str2double(get(handles.uz_adjcam,'string'));
if any(isnan([ux,uy,uz,vx,vy,vz])) waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
if norm([ux,uy,uz])<1E-6 waitfor(msgbox('The up direction cannot be the zero vector.')); return; end
if norm(cross([ux,uy,uz],[vx,vy,vz]))<1E-3 waitfor(msgbox('The viewing direction and up direction cannot be collinear.','Figuretool2')); return; end
camup(curraxis,[ux,uy,uz]);
set(handles.cr_adjcam,'string','0');
camparam.cu=[ux,uy,uz];
camparam.cr='default';


% --- Executes on button press in use_cz_adjcam.
function use_cz_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to use_cz_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camparam figurestack;
if isempty(figurestack) return; end
currfig=findobj('tag',figurestack{end,1});
if numel(currfig)~=1 waitfor(msgbox('Cannot find the current axis.','Figuretool2')); return; end
curraxis=findall(currfig,'type','axes');
curraxis=curraxis(end);
cz=str2double(get(handles.cz_adjcam,'string'));
if isnan(cz)||(cz<=0) waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
camzoom(curraxis,cz);
set(handles.cz_adjcam,'string',1);
camvaold=figurestack{end,2};
camvanew=camva(curraxis);
camparam.cz=camparam.cz*tand(camvaold/2)/tand(camvanew/2);

% --- Executes on button press in OK_adjcam.
function OK_adjcam_Callback(hObject, eventdata, handles)
% hObject    handle to OK_adjcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;
