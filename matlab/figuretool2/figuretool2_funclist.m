function varargout = figuretool2_funclist(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @figuretool2_funclist_OpeningFcn, ...
                   'gui_OutputFcn',  @figuretool2_funclist_OutputFcn, ...
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

function figuretool2_funclist_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = figuretool2_funclist_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function popupmenu1_Callback(hObject, eventdata, handles)

function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton1_Callback(hObject, eventdata, handles)
temp1=get(handles.popupmenu1,'string');temp2=get(handles.popupmenu1,'value');
set(get(hObject,'parent'),'Userdata',temp1{temp2});
uiresume;

function pushbutton2_Callback(hObject, eventdata, handles)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;
