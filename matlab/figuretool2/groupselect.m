function varargout = groupselect(varargin)
% GROUPSELECT MATLAB code for groupselect.fig
%      GROUPSELECT, by itself, creates a new GROUPSELECT or raises the existing
%      singleton*.
%
%      H = GROUPSELECT returns the handle to a new GROUPSELECT or the handle to
%      the existing singleton*.
%
%      GROUPSELECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GROUPSELECT.M with the given input arguments.
%
%      GROUPSELECT('Property','Value',...) creates a new GROUPSELECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before groupselect_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to groupselect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help groupselect

% Last Modified by GUIDE v2.5 28-Jul-2014 05:53:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @groupselect_OpeningFcn, ...
                   'gui_OutputFcn',  @groupselect_OutputFcn, ...
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
end

% --- Executes just before groupselect is made visible.
function groupselect_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to groupselect (see VARARGIN)
global grouplist;
% Choose default command line output for groupselect
handles.output = hObject;
if ~isempty(grouplist) set(handles.list_groupselect,'string',grouplist(:,1)'); end
jScrollPane = findjobj(handles.list_groupselect);
jListbox = jScrollPane.getViewport.getComponent(0);
jListbox = handle(jListbox, 'CallbackProperties');
set(jListbox, 'MousePressedCallback',{@mouseMovedCallback,handles.list_groupselect});
% Update handles structure
guidata(hObject, handles);
end
% UIWAIT makes groupselect wait for user response (see UIRESUME)
% uiwait(handles.groupselect);

function mouseMovedCallback(jListbox, jEventData, hListbox)
global grouplist;
% Get the currently-hovered list-item
mousePos = java.awt.Point(jEventData.getX, jEventData.getY);
hoverIndex = jListbox.locationToIndex(mousePos) + 1;
listValues = get(hListbox,'string');
if isempty(listValues) set(hListbox, 'Tooltip',''); return; end
set(hListbox, 'Tooltip',grouplist{hoverIndex,2});
end

% --- Outputs from this function are returned to the command line.
function varargout = groupselect_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on selection change in list_groupselect.
function list_groupselect_Callback(hObject, eventdata, handles)
% hObject    handle to list_groupselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_groupselect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_groupselect
end

% --- Executes during object creation, after setting all properties.
function list_groupselect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_groupselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in OK_groupselect.
function OK_groupselect_Callback(hObject, eventdata, handles)
% hObject    handle to OK_groupselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
list=get(handles.list_groupselect,'string');
value=get(handles.list_groupselect,'value');
if (value<=0)||(value>numel(list)) return;
else set(get(hObject,'parent'),'userdata',list{value}); uiresume;
end
end

% --- Executes on button press in cancel_groupselect.
function cancel_groupselect_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_groupselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;
end