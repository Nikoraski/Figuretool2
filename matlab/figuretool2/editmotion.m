function varargout = editmotion(varargin)
% EDITMOTION MATLAB code for editmotion.fig
%      EDITMOTION, by itself, creates a new EDITMOTION or raises the existing
%      singleton*.
%
%      H = EDITMOTION returns the handle to a new EDITMOTION or the handle to
%      the existing singleton*.
%
%      EDITMOTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDITMOTION.M with the given input arguments.
%
%      EDITMOTION('Property','Value',...) creates a new EDITMOTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before editmotion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to editmotion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help editmotion

% Last Modified by GUIDE v2.5 27-Aug-2014 17:04:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @editmotion_OpeningFcn, ...
                   'gui_OutputFcn',  @editmotion_OutputFcn, ...
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


% --- Executes just before editmotion is made visible.
function editmotion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to editmotion (see VARARGIN)

% Choose default command line output for editmotion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes editmotion wait for user response (see UIRESUME)
% uiwait(handles.editmotion);


% --- Outputs from this function are returned to the command line.
function varargout = editmotion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function start_editmotion_Callback(hObject, eventdata, handles)
% hObject    handle to start_editmotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global nframe;
frangeold=get(get(hObject,'parent'),'userdata');
temp=str2double(get(hObject,'String'));
if (temp<1)||(temp>nframe)||(temp~=round(temp)) set(hObject,'string',num2str(frangeold(1)));
   waitfor(msgbox(['Please enter an integer between 1 and ',num2str(nframe)])); return;
end
% Hints: get(hObject,'String') returns contents of start_editmotion as text
%        str2double(get(hObject,'String')) returns contents of start_editmotion as a double


% --- Executes during object creation, after setting all properties.
function start_editmotion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start_editmotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function end_editmotion_Callback(hObject, eventdata, handles)
% hObject    handle to end_editmotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global nframe;
frangeold=get(get(hObject,'parent'),'userdata');
temp=str2double(get(hObject,'String'));
if (temp<1)||(temp>nframe)||(temp~=round(temp)) set(hObject,'string',num2str(frangeold(2)));
   waitfor(msgbox(['Please enter an integer between 1 and ',num2str(nframe)])); return;
end
% Hints: get(hObject,'String') returns contents of end_editmotion as text
%        str2double(get(hObject,'String')) returns contents of end_editmotion as a double


% --- Executes during object creation, after setting all properties.
function end_editmotion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to end_editmotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in next_editmotion.
function next_editmotion_Callback(hObject, eventdata, handles)
% hObject    handle to next_editmotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fstart=str2double(get(handles.start_editmotion,'string'));
fend=str2double(get(handles.end_editmotion,'string'));
if fstart>=fend waitfor(msgbox('The starting frame must be earlier than ending frame.','Figuretool2')); return; end
set(get(hObject,'parent'),'userdata',[fstart,fend]);
uiresume;

% --- Executes on button press in cancel_editmotion.
function cancel_editmotion_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_editmotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;