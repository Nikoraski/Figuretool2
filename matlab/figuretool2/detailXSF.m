function varargout = detailXSF(varargin)
% DETAILXSF MATLAB code for detailXSF.fig
%      DETAILXSF, by itself, creates a new DETAILXSF or raises the existing
%      singleton*.
%
%      H = DETAILXSF returns the handle to a new DETAILXSF or the handle to
%      the existing singleton*.
%
%      DETAILXSF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETAILXSF.M with the given input arguments.
%
%      DETAILXSF('Property','Value',...) creates a new DETAILXSF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before detailXSF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to detailXSF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help detailXSF

% Last Modified by GUIDE v2.5 08-Oct-2014 22:39:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @detailXSF_OpeningFcn, ...
                   'gui_OutputFcn',  @detailXSF_OutputFcn, ...
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


% --- Executes just before detailXSF is made visible.
function detailXSF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to detailXSF (see VARARGIN)

% Choose default command line output for detailXSF
global XSFdata;
handles.output = hObject;
set(handles.filename_detailXSF,'string',XSFdata.file);
set(handles.atoms_detailXSF,'data',[XSFdata.XSFatomlist,num2cell(XSFdata.XSFxyzlist)]);
set(handles.cell_detailXSF,'data',XSFdata.XSFunitcell);
set(handles.ngx_detailXSF,'string',num2str(XSFdata.XSFngfft(1)));
set(handles.ngy_detailXSF,'string',num2str(XSFdata.XSFngfft(2)));
set(handles.ngz_detailXSF,'string',num2str(XSFdata.XSFngfft(3)));
set(handles.fmin_detailXSF,'string',num2str(XSFdata.XSFrange(1)));
set(handles.fmax_detailXSF,'string',num2str(XSFdata.XSFrange(2)));
jscroll=findjobj(handles.atoms_detailXSF);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
jtable.getColumnModel().getColumn(3).setResizable(false);
jscroll=findjobj(handles.cell_detailXSF);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes detailXSF wait for user response (see UIRESUME)
% uiwait(handles.detailXSF);


% --- Outputs from this function are returned to the command line.
function varargout = detailXSF_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function filename_detailXSF_Callback(hObject, eventdata, handles)
% hObject    handle to filename_detailXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename_detailXSF as text
%        str2double(get(hObject,'String')) returns contents of filename_detailXSF as a double


% --- Executes during object creation, after setting all properties.
function filename_detailXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename_detailXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_detailXSF.
function OK_detailXSF_Callback(hObject, eventdata, handles)
% hObject    handle to OK_detailXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;



function ngx_detailXSF_Callback(hObject, eventdata, handles)
% hObject    handle to ngx_detailXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ngx_detailXSF as text
%        str2double(get(hObject,'String')) returns contents of ngx_detailXSF as a double


% --- Executes during object creation, after setting all properties.
function ngx_detailXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ngx_detailXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ngy_detailXSF_Callback(hObject, eventdata, handles)
% hObject    handle to ngy_detailXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ngy_detailXSF as text
%        str2double(get(hObject,'String')) returns contents of ngy_detailXSF as a double


% --- Executes during object creation, after setting all properties.
function ngy_detailXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ngy_detailXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ngz_detailXSF_Callback(hObject, eventdata, handles)
% hObject    handle to ngz_detailXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ngz_detailXSF as text
%        str2double(get(hObject,'String')) returns contents of ngz_detailXSF as a double


% --- Executes during object creation, after setting all properties.
function ngz_detailXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ngz_detailXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fmin_detailXSF_Callback(hObject, eventdata, handles)
% hObject    handle to fmin_detailXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fmin_detailXSF as text
%        str2double(get(hObject,'String')) returns contents of fmin_detailXSF as a double


% --- Executes during object creation, after setting all properties.
function fmin_detailXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmin_detailXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fmax_detailXSF_Callback(hObject, eventdata, handles)
% hObject    handle to fmax_detailXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fmax_detailXSF as text
%        str2double(get(hObject,'String')) returns contents of fmax_detailXSF as a double


% --- Executes during object creation, after setting all properties.
function fmax_detailXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmax_detailXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
