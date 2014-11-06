function varargout = getcoord(varargin)
% GETCOORD MATLAB code for getcoord.fig
%      GETCOORD, by itself, creates a new GETCOORD or raises the existing
%      singleton*.
%
%      H = GETCOORD returns the handle to a new GETCOORD or the handle to
%      the existing singleton*.
%
%      GETCOORD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GETCOORD.M with the given input arguments.
%
%      GETCOORD('Property','Value',...) creates a new GETCOORD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before getcoord_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to getcoord_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help getcoord

% Last Modified by GUIDE v2.5 28-Jul-2014 05:56:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @getcoord_OpeningFcn, ...
                   'gui_OutputFcn',  @getcoord_OutputFcn, ...
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


% --- Executes just before getcoord is made visible.
function getcoord_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getcoord (see VARARGIN)

% Choose default command line output for getcoord
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes getcoord wait for user response (see UIRESUME)
% uiwait(handles.getcoord);


% --- Outputs from this function are returned to the command line.
function varargout = getcoord_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_getcoord.
function OK_getcoord_Callback(hObject, eventdata, handles)
% hObject    handle to OK_getcoord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.rb1_getcoord,'value')==1
   str='default';
else
   dmin=str2double(get(handles.dmin_getcoord,'string'));
   dmax=str2double(get(handles.dmax_getcoord,'string'));
   if dmin>=dmax waitfor(msgbox('Minimum range must be shorter than maximum range!','Figuretool2')); return; end
   str=[get(handles.dmin_getcoord,'string'),',',get(handles.dmax_getcoord,'string')];
end
set(get(hObject,'parent'),'userdata',['coord<',str,'>(']);
uiresume;

% --- Executes on button press in cancel_getcoord.
function cancel_getcoord_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_getcoord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;


function dmin_getcoord_Callback(hObject, eventdata, handles)
% hObject    handle to dmin_getcoord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<0) set(hObject,'string','2.00'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of dmin_getcoord as text
%        str2double(get(hObject,'String')) returns contents of dmin_getcoord as a double


% --- Executes during object creation, after setting all properties.
function dmin_getcoord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dmin_getcoord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dmax_getcoord_Callback(hObject, eventdata, handles)
% hObject    handle to dmax_getcoord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<0) set(hObject,'string','4.00'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of dmax_getcoord as text
%        str2double(get(hObject,'String')) returns contents of dmax_getcoord as a double


% --- Executes during object creation, after setting all properties.
function dmax_getcoord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dmax_getcoord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in rn_getcoord.
function rn_getcoord_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in rn_getcoord 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_getcoord')
   set(handles.dmin_getcoord,'enable','off');
   set(handles.dmax_getcoord,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_getcoord')
   set(handles.dmin_getcoord,'enable','on');
   set(handles.dmax_getcoord,'enable','on');
end
