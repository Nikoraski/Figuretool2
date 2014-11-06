function varargout = dataviewer(varargin)
% DATAVIEWER MATLAB code for dataviewer.fig
%      DATAVIEWER, by itself, creates a new DATAVIEWER or raises the existing
%      singleton*.
%
%      H = DATAVIEWER returns the handle to a new DATAVIEWER or the handle to
%      the existing singleton*.
%
%      DATAVIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATAVIEWER.M with the given input arguments.
%
%      DATAVIEWER('Property','Value',...) creates a new DATAVIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dataviewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dataviewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dataviewer

% Last Modified by GUIDE v2.5 08-Jul-2014 18:56:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dataviewer_OpeningFcn, ...
                   'gui_OutputFcn',  @dataviewer_OutputFcn, ...
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


% --- Executes just before dataviewer is made visible.
function dataviewer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dataviewer (see VARARGIN)
global CPdata CMdata mu3data raMOdata XSFdata MOdata;
% Choose default command line output for dataviewer
handles.output = hObject;
if ~isempty(CPdata)
   set(handles.CPfile_dataviewer,'enable','inactive','string',CPdata.file);
   set(handles.CPdetails_dataviewer,'enable','on');
end
if ~isempty(CMdata)
   set(handles.CMfile_dataviewer,'enable','inactive','string',CMdata.file);
   set(handles.CMdetails_dataviewer,'enable','on');
end
if ~isempty(raMOdata)
   set(handles.raMOfile_dataviewer,'enable','inactive','string',raMOdata.file);
   set(handles.raMOdetails_dataviewer,'enable','on');
end
if ~isempty(mu3data)
   set(handles.mu3file_dataviewer,'enable','inactive','string',mu3data.file);
   set(handles.mu3details_dataviewer,'enable','on');
end
if ~isempty(XSFdata)
   set(handles.XSFfile_dataviewer,'enable','inactive','string',XSFdata.file);
   set(handles.XSFdetails_dataviewer,'enable','on');
end
if ~isempty(MOdata)
   set(handles.MOfile_dataviewer,'enable','inactive','string',MOdata.file);
   set(handles.MOdetails_dataviewer,'enable','on');
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dataviewer wait for user response (see UIRESUME)
% uiwait(handles.dataviewer);


% --- Outputs from this function are returned to the command line.
function varargout = dataviewer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function CPfile_dataviewer_Callback(hObject, eventdata, handles)
% hObject    handle to CPfile_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CPfile_dataviewer as text
%        str2double(get(hObject,'String')) returns contents of CPfile_dataviewer as a double


% --- Executes during object creation, after setting all properties.
function CPfile_dataviewer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CPfile_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CPdetails_dataviewer.
function CPdetails_dataviewer_Callback(hObject, eventdata, handles)
% hObject    handle to CPdetails_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h0=detailCP;
uiwait(h0);
if ishandle(h0) delete(h0); end


function CMfile_dataviewer_Callback(hObject, eventdata, handles)
% hObject    handle to CMfile_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CMfile_dataviewer as text
%        str2double(get(hObject,'String')) returns contents of CMfile_dataviewer as a double


% --- Executes during object creation, after setting all properties.
function CMfile_dataviewer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CMfile_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CMdetails_dataviewer.
function CMdetails_dataviewer_Callback(hObject, eventdata, handles)
% hObject    handle to CMdetails_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h0=detailCM;
uiwait(h0);
if ishandle(h0) delete(h0); end



function mu3file_dataviewer_Callback(hObject, eventdata, handles)
% hObject    handle to mu3file_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mu3file_dataviewer as text
%        str2double(get(hObject,'String')) returns contents of mu3file_dataviewer as a double


% --- Executes during object creation, after setting all properties.
function mu3file_dataviewer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mu3file_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mu3details_dataviewer.
function mu3details_dataviewer_Callback(hObject, eventdata, handles)
% hObject    handle to mu3details_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h0=detailmu3;
uiwait(h0);
if ishandle(h0) delete(h0); end


function raMOfile_dataviewer_Callback(hObject, eventdata, handles)
% hObject    handle to raMOfile_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of raMOfile_dataviewer as text
%        str2double(get(hObject,'String')) returns contents of raMOfile_dataviewer as a double


% --- Executes during object creation, after setting all properties.
function raMOfile_dataviewer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to raMOfile_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in raMOdetails_dataviewer.
function raMOdetails_dataviewer_Callback(hObject, eventdata, handles)
% hObject    handle to raMOdetails_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function XSFfile_dataviewer_Callback(hObject, eventdata, handles)
% hObject    handle to XSFfile_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XSFfile_dataviewer as text
%        str2double(get(hObject,'String')) returns contents of XSFfile_dataviewer as a double


% --- Executes during object creation, after setting all properties.
function XSFfile_dataviewer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XSFfile_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in XSFdetails_dataviewer.
function XSFdetails_dataviewer_Callback(hObject, eventdata, handles)
% hObject    handle to XSFdetails_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h0=detailXSF;
uiwait(h0);
if ishandle(h0) delete(h0); end


function MOfile_dataviewer_Callback(hObject, eventdata, handles)
% hObject    handle to MOfile_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MOfile_dataviewer as text
%        str2double(get(hObject,'String')) returns contents of MOfile_dataviewer as a double


% --- Executes during object creation, after setting all properties.
function MOfile_dataviewer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MOfile_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MOdetails_dataviewer.
function MOdetails_dataviewer_Callback(hObject, eventdata, handles)
% hObject    handle to MOdetails_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h0=detailMO;
uiwait(h0);
if ishandle(h0) delete(h0); end

% --- Executes on button press in OK_dataviewer.
function OK_dataviewer_Callback(hObject, eventdata, handles)
% hObject    handle to OK_dataviewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;
