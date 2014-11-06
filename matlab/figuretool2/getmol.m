function varargout = getmol(varargin)
% GETMOL MATLAB code for getmol.fig
%      GETMOL, by itself, creates a new GETMOL or raises the existing
%      singleton*.
%
%      H = GETMOL returns the handle to a new GETMOL or the handle to
%      the existing singleton*.
%
%      GETMOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GETMOL.M with the given input arguments.
%
%      GETMOL('Property','Value',...) creates a new GETMOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before getmol_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to getmol_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help getmol

% Last Modified by GUIDE v2.5 28-Jul-2014 05:53:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @getmol_OpeningFcn, ...
                   'gui_OutputFcn',  @getmol_OutputFcn, ...
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


% --- Executes just before getmol is made visible.
function getmol_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getmol (see VARARGIN)

% Choose default command line output for getmol
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes getmol wait for user response (see UIRESUME)
% uiwait(handles.getmol);


% --- Outputs from this function are returned to the command line.
function varargout = getmol_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_getmol.
function OK_getmol_Callback(hObject, eventdata, handles)
% hObject    handle to OK_getmol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.rb1_getmol,'value')==1
   str='default';
else
   dmin=str2double(get(handles.dmin_getmol,'string'));
   dmax=str2double(get(handles.dmax_getmol,'string'));
   if dmin>=dmax waitfor(msgbox('Minimum range must be shorter than maximum range!','Figuretool2')); return; end
   str=[get(handles.dmin_getmol,'string'),',',get(handles.dmax_getmol,'string')];
end
set(get(hObject,'parent'),'userdata',['getmol<',str,'>(']);
uiresume;

% --- Executes on button press in cancel_getmol.
function cancel_getmol_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_getmol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;


function dmin_getmol_Callback(hObject, eventdata, handles)
% hObject    handle to dmin_getmol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<0) set(hObject,'string','2.00'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of dmin_getmol as text
%        str2double(get(hObject,'String')) returns contents of dmin_getmol as a double


% --- Executes during object creation, after setting all properties.
function dmin_getmol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dmin_getmol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dmax_getmol_Callback(hObject, eventdata, handles)
% hObject    handle to dmax_getmol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<0) set(hObject,'string','4.00'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of dmax_getmol as text
%        str2double(get(hObject,'String')) returns contents of dmax_getmol as a double


% --- Executes during object creation, after setting all properties.
function dmax_getmol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dmax_getmol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in rn_getmol.
function rn_getmol_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in rn_getmol 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_getmol')
   set(handles.dmin_getmol,'enable','off');
   set(handles.dmax_getmol,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_getmol')
   set(handles.dmin_getmol,'enable','on');
   set(handles.dmax_getmol,'enable','on');
end
