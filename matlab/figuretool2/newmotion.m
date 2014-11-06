function varargout = newmotion(varargin)
% NEWMOTION MATLAB code for newmotion.fig
%      NEWMOTION, by itself, creates a new NEWMOTION or raises the existing
%      singleton*.
%
%      H = NEWMOTION returns the handle to a new NEWMOTION or the handle to
%      the existing singleton*.
%
%      NEWMOTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWMOTION.M with the given input arguments.
%
%      NEWMOTION('Property','Value',...) creates a new NEWMOTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before newmotion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to newmotion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help newmotion

% Last Modified by GUIDE v2.5 25-Aug-2014 16:25:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @newmotion_OpeningFcn, ...
                   'gui_OutputFcn',  @newmotion_OutputFcn, ...
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


% --- Executes just before newmotion is made visible.
function newmotion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to newmotion (see VARARGIN)

% Choose default command line output for newmotion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes newmotion wait for user response (see UIRESUME)
% uiwait(handles.newmotion);


% --- Outputs from this function are returned to the command line.
function varargout = newmotion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_newmotion.
function listbox_newmotion_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_newmotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_newmotion contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_newmotion


% --- Executes during object creation, after setting all properties.
function listbox_newmotion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_newmotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_newmotion.
function OK_newmotion_Callback(hObject, eventdata, handles)
% hObject    handle to OK_newmotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cancel_newmotion.
function cancel_newmotion_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_newmotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
