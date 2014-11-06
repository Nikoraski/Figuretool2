function varargout = detailCP(varargin)
% DETAILCP MATLAB code for detailCP.fig
%      DETAILCP, by itself, creates a new DETAILCP or raises the existing
%      singleton*.
%
%      H = DETAILCP returns the handle to a new DETAILCP or the handle to
%      the existing singleton*.
%
%      DETAILCP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETAILCP.M with the given input arguments.
%
%      DETAILCP('Property','Value',...) creates a new DETAILCP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before detailCP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to detailCP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help detailCP

% Last Modified by GUIDE v2.5 22-Sep-2014 20:24:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @detailCP_OpeningFcn, ...
                   'gui_OutputFcn',  @detailCP_OutputFcn, ...
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


% --- Executes just before detailCP is made visible.
function detailCP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to detailCP (see VARARGIN)

% Choose default command line output for detailCP
global CPdata;
handles.output = hObject;
set(handles.filename_detailCP,'string',CPdata.file);
set(handles.lmax_detailCP,'string',num2str(CPdata.CPlmax));
set(handles.atoms_detailCP,'data',[CPdata.CPatomlist,num2cell(CPdata.CPxyzlist),num2cell(CPdata.CPcoeff(1,:)'*104280)]);
set(handles.cell_detailCP,'data',CPdata.CPunitcell);
jscroll=findjobj(handles.atoms_detailCP);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
jtable.getColumnModel().getColumn(3).setResizable(false);
jtable.getColumnModel().getColumn(4).setResizable(false);
jscroll=findjobj(handles.cell_detailCP);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes detailCP wait for user response (see UIRESUME)
% uiwait(handles.detailCP);


% --- Outputs from this function are returned to the command line.
function varargout = detailCP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function filename_detailCP_Callback(hObject, eventdata, handles)
% hObject    handle to filename_detailCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename_detailCP as text
%        str2double(get(hObject,'String')) returns contents of filename_detailCP as a double


% --- Executes during object creation, after setting all properties.
function filename_detailCP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename_detailCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lmax_detailCP_Callback(hObject, eventdata, handles)
% hObject    handle to lmax_detailCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lmax_detailCP as text
%        str2double(get(hObject,'String')) returns contents of lmax_detailCP as a double


% --- Executes during object creation, after setting all properties.
function lmax_detailCP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lmax_detailCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_detailCP.
function OK_detailCP_Callback(hObject, eventdata, handles)
% hObject    handle to OK_detailCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;
