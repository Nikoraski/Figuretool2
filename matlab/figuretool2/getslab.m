function varargout = getslab(varargin)
% GETSLAB MATLAB code for getslab.fig
%      GETSLAB, by itself, creates a new GETSLAB or raises the existing
%      singleton*.
%
%      H = GETSLAB returns the handle to a new GETSLAB or the handle to
%      the existing singleton*.
%
%      GETSLAB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GETSLAB.M with the given input arguments.
%
%      GETSLAB('Property','Value',...) creates a new GETSLAB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before getslab_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to getslab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help getslab

% Last Modified by GUIDE v2.5 28-Oct-2014 20:01:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @getslab_OpeningFcn, ...
                   'gui_OutputFcn',  @getslab_OutputFcn, ...
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


% --- Executes just before getslab is made visible.
function getslab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getslab (see VARARGIN)

% Choose default command line output for getslab
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes getslab wait for user response (see UIRESUME)
% uiwait(handles.getslab);


% --- Outputs from this function are returned to the command line.
function varargout = getslab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
JEdit=findjobj(handles.pl_getslab);
JEdit.Editable=0;
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_getslab.
function OK_getslab_Callback(hObject, eventdata, handles)
% hObject    handle to OK_getslab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rnstr=get(handles.rn_getslab,'string');
valstr=get(handles.pledit_getslab,'userdata');
if isempty(valstr) waitfor(msgbox('Please specify the reference plane of slab selection.','Figuretool2')); return; end
set(get(hObject,'parent'),'userdata',['slab(',valstr,',',rnstr,')']);
uiresume;

% --- Executes on button press in cancel_getslab.
function cancel_getslab_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_getslab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;


function rn_getslab_Callback(hObject, eventdata, handles)
% hObject    handle to rn_getslab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0) set(hObject,'string','1'); waitfor(msgbox('Please enter a positive real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of rn_getslab as text
%        str2double(get(hObject,'String')) returns contents of rn_getslab as a double


% --- Executes during object creation, after setting all properties.
function rn_getslab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rn_getslab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pledit_getslab.
function pledit_getslab_Callback(hObject, eventdata, handles)
% hObject    handle to pledit_getslab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valstr=get(hObject,'userdata');
if isempty(valstr) h0=planeeditor();
else h0=planeeditor('userdata',valstr);
end
uiwait(h0);
if ~ishandle(h0) return; end
valstrnew=get(h0,'userdata');
delete(h0);
if strcmpi(valstrnew,'cancelled') return; end
set(hObject,'userdata',valstrnew);
set(handles.pl_getslab,'string',dispplane(valstrnew));


function pl_getslab_Callback(hObject, eventdata, handles)
% hObject    handle to pl_getslab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pl_getslab as text
%        str2double(get(hObject,'String')) returns contents of pl_getslab as a double


% --- Executes during object creation, after setting all properties.
function pl_getslab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pl_getslab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
