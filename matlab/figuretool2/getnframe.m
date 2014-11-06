function varargout = getnframe(varargin)
% GETNFRAME MATLAB code for getnframe.fig
%      GETNFRAME, by itself, creates a new GETNFRAME or raises the existing
%      singleton*.
%
%      H = GETNFRAME returns the handle to a new GETNFRAME or the handle to
%      the existing singleton*.
%
%      GETNFRAME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GETNFRAME.M with the given input arguments.
%
%      GETNFRAME('Property','Value',...) creates a new GETNFRAME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before getnframe_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to getnframe_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help getnframe

% Last Modified by GUIDE v2.5 15-Oct-2014 19:20:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @getnframe_OpeningFcn, ...
                   'gui_OutputFcn',  @getnframe_OutputFcn, ...
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


% --- Executes just before getnframe is made visible.
function getnframe_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getnframe (see VARARGIN)

% Choose default command line output for getnframe
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes getnframe wait for user response (see UIRESUME)
% uiwait(handles.getnframe);


% --- Outputs from this function are returned to the command line.
function varargout = getnframe_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_getnframe_Callback(hObject, eventdata, handles)
% hObject    handle to edit_getnframe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=1)||(temp~=round(temp)) set(hObject,'String','30'); waitfor(msgbox('Please enter an integer greater than 1.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of edit_getnframe as text
%        str2double(get(hObject,'String')) returns contents of edit_getnframe as a double


% --- Executes during object creation, after setting all properties.
function edit_getnframe_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_getnframe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_getnframe.
function OK_getnframe_Callback(hObject, eventdata, handles)
% hObject    handle to OK_getnframe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global nframe;
nframe=str2double(get(handles.edit_getnframe,'String'));
uiresume;


% --- Executes on button press in cancel_getnframe.
function cancel_getnframe_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_getnframe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;
