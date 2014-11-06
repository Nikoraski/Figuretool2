function varargout = simdiffract_GUI(varargin)
% SIMDIFFRACT_GUI MATLAB code for simdiffract_GUI.fig
%      SIMDIFFRACT_GUI, by itself, creates a new SIMDIFFRACT_GUI or raises the existing
%      singleton*.
%
%      H = SIMDIFFRACT_GUI returns the handle to a new SIMDIFFRACT_GUI or the handle to
%      the existing singleton*.
%
%      SIMDIFFRACT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMDIFFRACT_GUI.M with the given input arguments.
%
%      SIMDIFFRACT_GUI('Property','Value',...) creates a new SIMDIFFRACT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simdiffract_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simdiffract_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simdiffract_GUI

% Last Modified by GUIDE v2.5 03-Oct-2014 11:47:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simdiffract_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @simdiffract_GUI_OutputFcn, ...
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


% --- Executes just before simdiffract_GUI is made visible.
function simdiffract_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simdiffract_GUI (see VARARGIN)

% Choose default command line output for simdiffract_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simdiffract_GUI wait for user response (see UIRESUME)
% uiwait(handles.simd);


% --- Outputs from this function are returned to the command line.
function varargout = simdiffract_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function t1_simd_Callback(hObject, eventdata, handles)
% hObject    handle to t1_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t1_simd as text
%        str2double(get(hObject,'String')) returns contents of t1_simd as a double


% --- Executes during object creation, after setting all properties.
function t1_simd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t2_simd_Callback(hObject, eventdata, handles)
% hObject    handle to t2_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t2_simd as text
%        str2double(get(hObject,'String')) returns contents of t2_simd as a double


% --- Executes during object creation, after setting all properties.
function t2_simd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t3_simd_Callback(hObject, eventdata, handles)
% hObject    handle to t3_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t3_simd as text
%        str2double(get(hObject,'String')) returns contents of t3_simd as a double


% --- Executes during object creation, after setting all properties.
function t3_simd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t3_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hmin_simd_Callback(hObject, eventdata, handles)
% hObject    handle to hmin_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp~=round(temp)) set(hObject,'string','-5'); waitfor(msgbox('Please enter an integer.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of hmin_simd as text
%        str2double(get(hObject,'String')) returns contents of hmin_simd as a double


% --- Executes during object creation, after setting all properties.
function hmin_simd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hmin_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hmax_simd_Callback(hObject, eventdata, handles)
% hObject    handle to hmax_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp~=round(temp)) set(hObject,'string','5'); waitfor(msgbox('Please enter an integer.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of hmax_simd as text
%        str2double(get(hObject,'String')) returns contents of hmax_simd as a double


% --- Executes during object creation, after setting all properties.
function hmax_simd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hmax_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kmin_simd_Callback(hObject, eventdata, handles)
% hObject    handle to kmin_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp~=round(temp)) set(hObject,'string','-5'); waitfor(msgbox('Please enter an integer.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of kmin_simd as text
%        str2double(get(hObject,'String')) returns contents of kmin_simd as a double


% --- Executes during object creation, after setting all properties.
function kmin_simd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kmin_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kmax_simd_Callback(hObject, eventdata, handles)
% hObject    handle to kmax_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp~=round(temp)) set(hObject,'string','5'); waitfor(msgbox('Please enter an integer.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of kmax_simd as text
%        str2double(get(hObject,'String')) returns contents of kmax_simd as a double


% --- Executes during object creation, after setting all properties.
function kmax_simd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kmax_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lmin_simd_Callback(hObject, eventdata, handles)
% hObject    handle to lmin_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp~=round(temp)) set(hObject,'string','-5'); waitfor(msgbox('Please enter an integer.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of lmin_simd as text
%        str2double(get(hObject,'String')) returns contents of lmin_simd as a double


% --- Executes during object creation, after setting all properties.
function lmin_simd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lmin_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lmax_simd_Callback(hObject, eventdata, handles)
% hObject    handle to lmax_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp~=round(temp)) set(hObject,'string','5'); waitfor(msgbox('Please enter an integer.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of lmax_simd as text
%        str2double(get(hObject,'String')) returns contents of lmax_simd as a double


% --- Executes during object creation, after setting all properties.
function lmax_simd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lmax_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function uiso_simd_Callback(hObject, eventdata, handles)
% hObject    handle to uiso_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0) set(hObject,'string','0.01'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of uiso_simd as text
%        str2double(get(hObject,'String')) returns contents of uiso_simd as a double


% --- Executes during object creation, after setting all properties.
function uiso_simd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uiso_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in drawrec_simd.
function drawrec_simd_Callback(hObject, eventdata, handles)
% hObject    handle to drawrec_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawrec_simd


% --- Executes on button press in OK_simd.
function OK_simd_Callback(hObject, eventdata, handles)
% hObject    handle to OK_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str1=get(handles.t1_simd,'string');
if ~ishkl(str1) waitfor(msgbox('Please enter a linear function of h,k and l.','Figuretool2')); return; end
str2=get(handles.t2_simd,'string');
if ~ishkl(str2) waitfor(msgbox('Please enter a linear function of h,k and l.','Figuretool2')); return; end
str3=get(handles.t3_simd,'string');
if ~ishkl(str3) waitfor(msgbox('Please enter a linear function of h,k and l.','Figuretool2')); return; end
hmin=str2double(get(handles.hmin_simd,'string'));
hmax=str2double(get(handles.hmax_simd,'string'));
kmin=str2double(get(handles.kmin_simd,'string'));
kmax=str2double(get(handles.kmax_simd,'string'));
lmin=str2double(get(handles.lmin_simd,'string'));
lmax=str2double(get(handles.lmax_simd,'string'));
if (hmin>hmax)||(kmin>kmax)||(lmin>lmax) waitfor(msgbox('The minimum h,k,l cannot be greater than maximum.','Figuretool2')); return; end
Uiso=str2double(get(handles.uiso_simd,'string'));
drawreccell=get(handles.drawrec_simd,'value');
set(get(hObject,'parent'),'userdata',{{str1,str2,str3},[hmin,hmax,kmin,kmax,lmin,lmax],Uiso,drawreccell});
uiresume;

function boolout=ishkl(strin)
boolout=true;
if ~all(ismember(strin,'+-*()0123456789hkl')) boolout=false; return; end
temp=rand(3); temp=[temp;temp(1,:)+temp(2,:)-temp(3,:)]; result=zeros(4,1);
for j=1:4
   h=temp(j,1); k=temp(j,2); l=temp(j,3);
   try
      result(j)=eval(strin);
   catch err
      boolout=false; return;
   end
end
if result(1)+result(2)-result(3)~=result(4) boolout=false; return; end


% --- Executes on button press in cancel_simd.
function cancel_simd_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_simd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;
