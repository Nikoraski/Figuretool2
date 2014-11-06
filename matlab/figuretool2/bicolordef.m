function varargout = bicolordef(varargin)
% BICOLORDEF MATLAB code for bicolordef.fig
%      BICOLORDEF, by itself, creates a new BICOLORDEF or raises the existing
%      singleton*.
%
%      H = BICOLORDEF returns the handle to a new BICOLORDEF or the handle to
%      the existing singleton*.
%
%      BICOLORDEF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BICOLORDEF.M with the given input arguments.
%
%      BICOLORDEF('Property','Value',...) creates a new BICOLORDEF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bicolordef_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bicolordef_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bicolordef

% Last Modified by GUIDE v2.5 13-Oct-2014 15:28:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bicolordef_OpeningFcn, ...
                   'gui_OutputFcn',  @bicolordef_OutputFcn, ...
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


% --- Executes just before bicolordef is made visible.
function bicolordef_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bicolordef (see VARARGIN)

% Choose default command line output for bicolordef
handles.output = hObject;
temp=get(hObject,'userdata');
   hcolor=cell2mat(temp(1:3));
   set(handles.r1_edit_bicolordef,'String',num2str(round(hcolor(1)*255)));
   set(handles.g1_edit_bicolordef,'String',num2str(round(hcolor(2)*255)));
   set(handles.b1_edit_bicolordef,'String',num2str(round(hcolor(3)*255)));
   set(handles.r1_slider_bicolordef,'value',hcolor(1)*255);
   set(handles.g1_slider_bicolordef,'value',hcolor(2)*255);
   set(handles.b1_slider_bicolordef,'value',hcolor(3)*255);
   set(handles.prev1_bicolordef,'backgroundcolor',hcolor);
   hcolor=cell2mat(temp(4:6));
   set(handles.r2_edit_bicolordef,'String',num2str(round(hcolor(1)*255)));
   set(handles.g2_edit_bicolordef,'String',num2str(round(hcolor(2)*255)));
   set(handles.b2_edit_bicolordef,'String',num2str(round(hcolor(3)*255)));
   set(handles.r2_slider_bicolordef,'value',hcolor(1)*255);
   set(handles.g2_slider_bicolordef,'value',hcolor(2)*255);
   set(handles.b2_slider_bicolordef,'value',hcolor(3)*255);
   set(handles.prev2_bicolordef,'backgroundcolor',hcolor);
   set(handles.text1_bicolordef,'string',temp{7});
   set(handles.text2_bicolordef,'string',temp{8});
   set(hObject,'name',temp{9});
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bicolordef wait for user response (see UIRESUME)
% uiwait(handles.bicolordef);


% --- Outputs from this function are returned to the command line.
function varargout = bicolordef_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function r1_edit_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to r1_edit_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.r1_slider_bicolordef,'value',value);
   rvalue=str2double(get(handles.r1_edit_bicolordef,'String'));
   gvalue=str2double(get(handles.g1_edit_bicolordef,'String'));
   bvalue=str2double(get(handles.b1_edit_bicolordef,'String'));
   set(handles.prev1_bicolordef,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.r1_slider_bicolordef,'value');
   set(hObject,'string',num2str(round(value))); set(handles.r1_slider_bicolordef,'value',value);
    waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of r1_edit_bicolordef as text
%        str2double(get(hObject,'String')) returns contents of r1_edit_bicolordef as a double


% --- Executes during object creation, after setting all properties.
function r1_edit_bicolordef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r1_edit_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g1_edit_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to g1_edit_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.g1_slider_bicolordef,'value',value);
   rvalue=str2double(get(handles.r1_edit_bicolordef,'String'));
   gvalue=str2double(get(handles.g1_edit_bicolordef,'String'));
   bvalue=str2double(get(handles.b1_edit_bicolordef,'String'));
   set(handles.prev1_bicolordef,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.g1_slider_bicolordef,'value');
   set(hObject,'string',num2str(round(value))); set(handles.g1_slider_bicolordef,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of g1_edit_bicolordef as text
%        str2double(get(hObject,'String')) returns contents of g1_edit_bicolordef as a double


% --- Executes during object creation, after setting all properties.
function g1_edit_bicolordef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g1_edit_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b1_edit_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to b1_edit_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.b1_slider_bicolordef,'value',value);
   rvalue=str2double(get(handles.r1_edit_bicolordef,'String'));
   gvalue=str2double(get(handles.g1_edit_bicolordef,'String'));
   bvalue=str2double(get(handles.b1_edit_bicolordef,'String'));
   set(handles.prev1_bicolordef,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.b1_slider_bicolordef,'value');
   set(hObject,'string',num2str(round(value))); set(handles.b1_slider_bicolordef,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of b1_edit_bicolordef as text
%        str2double(get(hObject,'String')) returns contents of b1_edit_bicolordef as a double


% --- Executes during object creation, after setting all properties.
function b1_edit_bicolordef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b1_edit_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function r1_slider_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to r1_slider_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.r1_edit_bicolordef,'string',num2str(round(value)));
rvalue=str2double(get(handles.r1_edit_bicolordef,'String'));
gvalue=str2double(get(handles.g1_edit_bicolordef,'String'));
bvalue=str2double(get(handles.b1_edit_bicolordef,'String'));
set(handles.prev1_bicolordef,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function r1_slider_bicolordef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r1_slider_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function g1_slider_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to g1_slider_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.g1_edit_bicolordef,'string',num2str(round(value)));
rvalue=str2double(get(handles.r1_edit_bicolordef,'String'));
gvalue=str2double(get(handles.g1_edit_bicolordef,'String'));
bvalue=str2double(get(handles.b1_edit_bicolordef,'String'));
set(handles.prev1_bicolordef,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function g1_slider_bicolordef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g1_slider_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function b1_slider_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to b1_slider_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.b1_edit_bicolordef,'string',num2str(round(value)));
rvalue=str2double(get(handles.r1_edit_bicolordef,'String'));
gvalue=str2double(get(handles.g1_edit_bicolordef,'String'));
bvalue=str2double(get(handles.b1_edit_bicolordef,'String'));
set(handles.prev1_bicolordef,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function b1_slider_bicolordef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b1_slider_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in setcolor1_bicolordef.
function setcolor1_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to setcolor1_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.r1_edit_bicolordef,'String'));
gvalue=str2double(get(handles.g1_edit_bicolordef,'String'));
bvalue=str2double(get(handles.b1_edit_bicolordef,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.r1_edit_bicolordef,'String',num2str(round(hcolor(1)*255)));
   set(handles.g1_edit_bicolordef,'String',num2str(round(hcolor(2)*255)));
   set(handles.b1_edit_bicolordef,'String',num2str(round(hcolor(3)*255)));
   set(handles.r1_slider_bicolordef,'value',hcolor(1)*255);
   set(handles.g1_slider_bicolordef,'value',hcolor(2)*255);
   set(handles.b1_slider_bicolordef,'value',hcolor(3)*255);
   set(handles.prev1_bicolordef,'backgroundcolor',hcolor);
end


function r2_edit_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to r2_edit_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.r2_slider_bicolordef,'value',value);
   rvalue=str2double(get(handles.r2_edit_bicolordef,'String'));
   gvalue=str2double(get(handles.g2_edit_bicolordef,'String'));
   bvalue=str2double(get(handles.b2_edit_bicolordef,'String'));
   set(handles.prev2_bicolordef,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.r2_slider_bicolordef,'value');
   set(hObject,'string',num2str(round(value))); set(handles.r2_slider_bicolordef,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of r2_edit_bicolordef as text
%        str2double(get(hObject,'String')) returns contents of r2_edit_bicolordef as a double


% --- Executes during object creation, after setting all properties.
function r2_edit_bicolordef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r2_edit_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g2_edit_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to g2_edit_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.g2_slider_bicolordef,'value',value);
   rvalue=str2double(get(handles.r2_edit_bicolordef,'String'));
   gvalue=str2double(get(handles.g2_edit_bicolordef,'String'));
   bvalue=str2double(get(handles.b2_edit_bicolordef,'String'));
   set(handles.prev2_bicolordef,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.g2_slider_bicolordef,'value');
   set(hObject,'string',num2str(round(value))); set(handles.g2_slider_bicolordef,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of g2_edit_bicolordef as text
%        str2double(get(hObject,'String')) returns contents of g2_edit_bicolordef as a double


% --- Executes during object creation, after setting all properties.
function g2_edit_bicolordef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g2_edit_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b2_edit_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to b2_edit_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.b2_slider_bicolordef,'value',value);
   rvalue=str2double(get(handles.r2_edit_bicolordef,'String'));
   gvalue=str2double(get(handles.g2_edit_bicolordef,'String'));
   bvalue=str2double(get(handles.b2_edit_bicolordef,'String'));
   set(handles.prev2_bicolordef,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.b2_slider_bicolordef,'value');
   set(hObject,'string',num2str(round(value))); set(handles.b2_slider_bicolordef,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of b2_edit_bicolordef as text
%        str2double(get(hObject,'String')) returns contents of b2_edit_bicolordef as a double


% --- Executes during object creation, after setting all properties.
function b2_edit_bicolordef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b2_edit_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function r2_slider_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to r2_slider_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.r2_edit_bicolordef,'string',num2str(round(value)));
rvalue=str2double(get(handles.r2_edit_bicolordef,'String'));
gvalue=str2double(get(handles.g2_edit_bicolordef,'String'));
bvalue=str2double(get(handles.b2_edit_bicolordef,'String'));
set(handles.prev2_bicolordef,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function r2_slider_bicolordef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r2_slider_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function g2_slider_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to g2_slider_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.g2_edit_bicolordef,'string',num2str(round(value)));
rvalue=str2double(get(handles.r2_edit_bicolordef,'String'));
gvalue=str2double(get(handles.g2_edit_bicolordef,'String'));
bvalue=str2double(get(handles.b2_edit_bicolordef,'String'));
set(handles.prev2_bicolordef,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function g2_slider_bicolordef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g2_slider_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function b2_slider_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to b2_slider_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.b2_edit_bicolordef,'string',num2str(round(value)));
rvalue=str2double(get(handles.r2_edit_bicolordef,'String'));
gvalue=str2double(get(handles.g2_edit_bicolordef,'String'));
bvalue=str2double(get(handles.b2_edit_bicolordef,'String'));
set(handles.prev2_bicolordef,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function b2_slider_bicolordef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b2_slider_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in setcolor2_bicolordef.
function setcolor2_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to setcolor2_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.r2_edit_bicolordef,'String'));
gvalue=str2double(get(handles.g2_edit_bicolordef,'String'));
bvalue=str2double(get(handles.b2_edit_bicolordef,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.r2_edit_bicolordef,'String',num2str(round(hcolor(1)*255)));
   set(handles.g2_edit_bicolordef,'String',num2str(round(hcolor(2)*255)));
   set(handles.b2_edit_bicolordef,'String',num2str(round(hcolor(3)*255)));
   set(handles.r2_slider_bicolordef,'value',hcolor(1)*255);
   set(handles.g2_slider_bicolordef,'value',hcolor(2)*255);
   set(handles.b2_slider_bicolordef,'value',hcolor(3)*255);
   set(handles.prev2_bicolordef,'backgroundcolor',hcolor);
end

% --- Executes on button press in OK_bicolordef.
function OK_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to OK_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue1=str2double(get(handles.r1_edit_bicolordef,'String'));
gvalue1=str2double(get(handles.g1_edit_bicolordef,'String'));
bvalue1=str2double(get(handles.b1_edit_bicolordef,'String'));
rvalue2=str2double(get(handles.r2_edit_bicolordef,'String'));
gvalue2=str2double(get(handles.g2_edit_bicolordef,'String'));
bvalue2=str2double(get(handles.b2_edit_bicolordef,'String'));
temp=get(get(hObject,'parent'),'userdata');
temp(1:6)=num2cell([rvalue1,gvalue1,bvalue1,rvalue2,gvalue2,bvalue2]/255);
set(get(hObject,'parent'),'userdata',temp);
uiresume;

% --- Executes on button press in cancel_bicolordef.
function cancel_bicolordef_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_bicolordef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;
