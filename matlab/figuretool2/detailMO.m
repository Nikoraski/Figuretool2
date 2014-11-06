function varargout = detailMO(varargin)
% DETAILMO MATLAB code for detailMO.fig
%      DETAILMO, by itself, creates a new DETAILMO or raises the existing
%      singleton*.
%
%      H = DETAILMO returns the handle to a new DETAILMO or the handle to
%      the existing singleton*.
%
%      DETAILMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETAILMO.M with the given input arguments.
%
%      DETAILMO('Property','Value',...) creates a new DETAILMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before detailMO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to detailMO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help detailMO

% Last Modified by GUIDE v2.5 10-Oct-2014 11:31:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @detailMO_OpeningFcn, ...
                   'gui_OutputFcn',  @detailMO_OutputFcn, ...
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


% --- Executes just before detailMO is made visible.
function detailMO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to detailMO (see VARARGIN)

% Choose default command line output for detailMO
global MOdata;
handles.output = hObject;
set(handles.filename_detailMO,'string',MOdata.file);
set(handles.atoms_detailMO,'data',[MOdata.MOatomlist,num2cell(MOdata.MOxyzlist)]);
if ~isempty(MOdata.MOunitcell)
   set(handles.cell_detailMO,'data',MOdata.MOunitcell);
else
   set(handles.cell_detailMO,'enable','off');
end
set(handles.nao_detailMO,'string',num2str(size(MOdata.MOcoeff{1},1)));
set(handles.nmo_detailMO,'string',num2str(numel(MOdata.MOcoeff)));
if ~isempty(MOdata.MOkpt)
   set(handles.nkpt_detailMO,'string',num2str(size(MOdata.MOkpt,1)));
else
   set(handles.nkpt_detailMO,'enable','off');
end
jscroll=findjobj(handles.atoms_detailMO);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
jtable.getColumnModel().getColumn(3).setResizable(false);
jscroll=findjobj(handles.cell_detailMO);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes detailMO wait for user response (see UIRESUME)
% uiwait(handles.detailMO);


% --- Outputs from this function are returned to the command line.
function varargout = detailMO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function filename_detailMO_Callback(hObject, eventdata, handles)
% hObject    handle to filename_detailMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename_detailMO as text
%        str2double(get(hObject,'String')) returns contents of filename_detailMO as a double


% --- Executes during object creation, after setting all properties.
function filename_detailMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename_detailMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_detailMO.
function OK_detailMO_Callback(hObject, eventdata, handles)
% hObject    handle to OK_detailMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;


function nao_detailMO_Callback(hObject, eventdata, handles)
% hObject    handle to nao_detailMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nao_detailMO as text
%        str2double(get(hObject,'String')) returns contents of nao_detailMO as a double


% --- Executes during object creation, after setting all properties.
function nao_detailMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nao_detailMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nmo_detailMO_Callback(hObject, eventdata, handles)
% hObject    handle to nmo_detailMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nmo_detailMO as text
%        str2double(get(hObject,'String')) returns contents of nmo_detailMO as a double


% --- Executes during object creation, after setting all properties.
function nmo_detailMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nmo_detailMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nkpt_detailMO_Callback(hObject, eventdata, handles)
% hObject    handle to nkpt_detailMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nkpt_detailMO as text
%        str2double(get(hObject,'String')) returns contents of nkpt_detailMO as a double


% --- Executes during object creation, after setting all properties.
function nkpt_detailMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nkpt_detailMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
