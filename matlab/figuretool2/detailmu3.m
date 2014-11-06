function varargout = detailmu3(varargin)
% DETAILMU3 MATLAB code for detailmu3.fig
%      DETAILMU3, by itself, creates a new DETAILMU3 or raises the existing
%      singleton*.
%
%      H = DETAILMU3 returns the handle to a new DETAILMU3 or the handle to
%      the existing singleton*.
%
%      DETAILMU3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETAILMU3.M with the given input arguments.
%
%      DETAILMU3('Property','Value',...) creates a new DETAILMU3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before detailmu3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to detailmu3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help detailmu3

% Last Modified by GUIDE v2.5 22-Sep-2014 20:45:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @detailmu3_OpeningFcn, ...
                   'gui_OutputFcn',  @detailmu3_OutputFcn, ...
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


% --- Executes just before detailmu3 is made visible.
function detailmu3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to detailmu3 (see VARARGIN)

% Choose default command line output for detailmu3
global mu3data;
handles.output = hObject;
set(handles.filename_detailmu3,'string',mu3data.file);
set(handles.atoms_detailmu3,'data',[mu3data.mu3atomlist,num2cell(mu3data.mu3xyzlist),num2cell((mu3data.mu3occ_id-mu3data.mu3occ_act)*10)]);
set(handles.cell_detailmu3,'data',mu3data.mu3unitcell);
jscroll=findjobj(handles.atoms_detailmu3);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
jtable.getColumnModel().getColumn(3).setResizable(false);
jtable.getColumnModel().getColumn(4).setResizable(false);
jscroll=findjobj(handles.cell_detailmu3);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes detailmu3 wait for user response (see UIRESUME)
% uiwait(handles.detailmu3);


% --- Outputs from this function are returned to the command line.
function varargout = detailmu3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function filename_detailmu3_Callback(hObject, eventdata, handles)
% hObject    handle to filename_detailmu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename_detailmu3 as text
%        str2double(get(hObject,'String')) returns contents of filename_detailmu3 as a double


% --- Executes during object creation, after setting all properties.
function filename_detailmu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename_detailmu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_detailmu3.
function OK_detailmu3_Callback(hObject, eventdata, handles)
% hObject    handle to OK_detailmu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;
