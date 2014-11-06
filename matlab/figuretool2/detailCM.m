function varargout = detailCM(varargin)
% DETAILCM MATLAB code for detailCM.fig
%      DETAILCM, by itself, creates a new DETAILCM or raises the existing
%      singleton*.
%
%      H = DETAILCM returns the handle to a new DETAILCM or the handle to
%      the existing singleton*.
%
%      DETAILCM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETAILCM.M with the given input arguments.
%
%      DETAILCM('Property','Value',...) creates a new DETAILCM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before detailCM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to detailCM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help detailCM

% Last Modified by GUIDE v2.5 22-Sep-2014 20:38:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @detailCM_OpeningFcn, ...
                   'gui_OutputFcn',  @detailCM_OutputFcn, ...
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


% --- Executes just before detailCM is made visible.
function detailCM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to detailCM (see VARARGIN)

% Choose default command line output for detailCM
global CMdata;
handles.output = hObject;
set(handles.filename_detailCM,'string',CMdata.file);
set(handles.lmax_detailCM,'string',num2str(CMdata.CMlmax));
set(handles.atoms_detailCM,'data',[CMdata.CMatomlist,num2cell(CMdata.CMxyzlist),num2cell(CMdata.CMcoeff(1,:)'*104280)]);
set(handles.cell_detailCM,'data',CMdata.CMunitcell);
jscroll=findjobj(handles.atoms_detailCM);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
jtable.getColumnModel().getColumn(3).setResizable(false);
jtable.getColumnModel().getColumn(4).setResizable(false);
jscroll=findjobj(handles.cell_detailCM);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes detailCM wait for user response (see UIRESUME)
% uiwait(handles.detailCM);


% --- Outputs from this function are returned to the command line.
function varargout = detailCM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function filename_detailCM_Callback(hObject, eventdata, handles)
% hObject    handle to filename_detailCM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename_detailCM as text
%        str2double(get(hObject,'String')) returns contents of filename_detailCM as a double


% --- Executes during object creation, after setting all properties.
function filename_detailCM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename_detailCM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lmax_detailCM_Callback(hObject, eventdata, handles)
% hObject    handle to lmax_detailCM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lmax_detailCM as text
%        str2double(get(hObject,'String')) returns contents of lmax_detailCM as a double


% --- Executes during object creation, after setting all properties.
function lmax_detailCM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lmax_detailCM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_detailCM.
function OK_detailCM_Callback(hObject, eventdata, handles)
% hObject    handle to OK_detailCM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;
