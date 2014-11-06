function varargout = setlp(varargin)
% SETLP MATLAB code for setlp.fig
%      SETLP, by itself, creates a new SETLP or raises the existing
%      singleton*.
%
%      H = SETLP returns the handle to a new SETLP or the handle to
%      the existing singleton*.
%
%      SETLP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETLP.M with the given input arguments.
%
%      SETLP('Property','Value',...) creates a new SETLP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before setlp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to setlp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setlp

% Last Modified by GUIDE v2.5 21-Jul-2014 18:46:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @setlp_OpeningFcn, ...
   'gui_OutputFcn',  @setlp_OutputFcn, ...
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


% --- Executes just before setlp is made visible.
function setlp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to setlp (see VARARGIN)
global globallp globalfl;
if isnumeric(globallp)
   set(handles.lightparam_rb9_setlp,'value',1);
   set(handles.slider1_setlp,'enable','on');
   set(handles.slider2_setlp,'enable','on');
   set(handles.slider3_setlp,'enable','on');
   set(handles.slider4_setlp,'enable','on');
   set(handles.edit1_setlp,'enable','on');
   set(handles.edit2_setlp,'enable','on');
   set(handles.edit3_setlp,'enable','on');
   set(handles.edit4_setlp,'enable','on');
   set(handles.slider1_setlp,'value',globallp(1));
   set(handles.slider2_setlp,'value',globallp(2));
   set(handles.slider3_setlp,'value',globallp(3));
   set(handles.slider4_setlp,'value',globallp(4));
   set(handles.edit1_setlp,'string',sprintf('%4.2f',globallp(1)));
   set(handles.edit2_setlp,'string',sprintf('%4.2f',globallp(2)));
   set(handles.edit3_setlp,'string',sprintf('%4.2f',globallp(3)));
   set(handles.edit4_setlp,'string',sprintf('%d',round(globallp(4))));
else
   switch globallp
      case 'default', set(handles.lightparam_rb1_setlp,'value',1);
         set(handles.slider1_setlp,'value',0.8);
         set(handles.slider2_setlp,'value',0.8);
         set(handles.slider3_setlp,'value',0.8);
         set(handles.slider4_setlp,'value',1);
         set(handles.edit1_setlp,'string','');
         set(handles.edit2_setlp,'string','');
         set(handles.edit3_setlp,'string','');
         set(handles.edit4_setlp,'string','');
      case 'chalk', set(handles.lightparam_rb2_setlp,'value',1);
         set(handles.slider1_setlp,'value',0.25);
         set(handles.slider2_setlp,'value',0.75);
         set(handles.slider3_setlp,'value',0);
         set(handles.slider4_setlp,'value',1);
         set(handles.edit1_setlp,'string','0.25');
         set(handles.edit2_setlp,'string','0.75');
         set(handles.edit3_setlp,'string','0.00');
         set(handles.edit4_setlp,'string','1');
      case 'china', set(handles.lightparam_rb3_setlp,'value',1);
         set(handles.slider1_setlp,'value',0.25);
         set(handles.slider2_setlp,'value',0.75);
         set(handles.slider3_setlp,'value',1);
         set(handles.slider4_setlp,'value',30);
         set(handles.edit1_setlp,'string','0.25');
         set(handles.edit2_setlp,'string','0.75');
         set(handles.edit3_setlp,'string','1.00');
         set(handles.edit4_setlp,'string','30');
      case 'glass', set(handles.lightparam_rb4_setlp,'value',1);
         set(handles.slider1_setlp,'value',0.5);
         set(handles.slider2_setlp,'value',0);
         set(handles.slider3_setlp,'value',1);
         set(handles.slider4_setlp,'value',20);
         set(handles.edit1_setlp,'string','0.50');
         set(handles.edit2_setlp,'string','0.00');
         set(handles.edit3_setlp,'string','1.00');
         set(handles.edit4_setlp,'string','20');
      case 'metal', set(handles.lightparam_rb5_setlp,'value',1);
         set(handles.slider1_setlp,'value',0.5);
         set(handles.slider2_setlp,'value',0.1);
         set(handles.slider3_setlp,'value',0.9);
         set(handles.slider4_setlp,'value',1);
         set(handles.edit1_setlp,'string','0.50');
         set(handles.edit2_setlp,'string','0.10');
         set(handles.edit3_setlp,'string','0.90');
         set(handles.edit4_setlp,'string','1');
      case 'plastic', set(handles.lightparam_rb6_setlp,'value',1);
         set(handles.slider1_setlp,'value',0.75);
         set(handles.slider2_setlp,'value',0.75);
         set(handles.slider3_setlp,'value',1);
         set(handles.slider4_setlp,'value',9);
         set(handles.edit1_setlp,'string','0.75');
         set(handles.edit2_setlp,'string','0.75');
         set(handles.edit3_setlp,'string','1.00');
         set(handles.edit4_setlp,'string','9');
      case 'rubber', set(handles.lightparam_rb7_setlp,'value',1);
         set(handles.slider1_setlp,'value',0.75);
         set(handles.slider2_setlp,'value',0.75);
         set(handles.slider3_setlp,'value',0);
         set(handles.slider4_setlp,'value',1);
         set(handles.edit1_setlp,'string','0.75');
         set(handles.edit2_setlp,'string','0.75');
         set(handles.edit3_setlp,'string','0.00');
         set(handles.edit4_setlp,'string','1');
      case 'wax', set(handles.lightparam_rb8_setlp,'value',1);
         set(handles.slider1_setlp,'value',0.2);
         set(handles.slider2_setlp,'value',1);
         set(handles.slider3_setlp,'value',0.5);
         set(handles.slider4_setlp,'value',10);
         set(handles.edit1_setlp,'string','0.20');
         set(handles.edit2_setlp,'string','1.00');
         set(handles.edit3_setlp,'string','0.50');
         set(handles.edit4_setlp,'string','10');
   end
end
switch globalfl
   case 'none', set(handles.facelighting_rb1_setlp,'value',1);
   case 'flat', set(handles.facelighting_rb2_setlp,'value',1);
   case 'gouraud', set(handles.facelighting_rb3_setlp,'value',1);
   case 'phong', set(handles.facelighting_rb4_setlp,'value',1);
end
% Choose default command line output for setlp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes setlp wait for user response (see UIRESUME)
% uiwait(handles.setlp);


% --- Outputs from this function are returned to the command line.
function varargout = setlp_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_setlp_Callback(hObject, eventdata, handles)
% hObject    handle to slider1_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit1_setlp,'string',sprintf('%4.2f',value));

% --- Executes during object creation, after setting all properties.
function slider1_setlp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_setlp_Callback(hObject, eventdata, handles)
% hObject    handle to slider2_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit2_setlp,'string',sprintf('%4.2f',value));

% --- Executes during object creation, after setting all properties.
function slider2_setlp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_setlp_Callback(hObject, eventdata, handles)
% hObject    handle to slider3_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit3_setlp,'string',sprintf('%4.2f',value));

% --- Executes during object creation, after setting all properties.
function slider3_setlp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_setlp_Callback(hObject, eventdata, handles)
% hObject    handle to slider4_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit4_setlp,'string',sprintf('%d',round(value)));

% --- Executes during object creation, after setting all properties.
function slider4_setlp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in OK_setlp.
function OK_setlp_Callback(hObject, eventdata, handles)
% hObject    handle to OK_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global globalfl globallp functionlist;
v1=get(get(handles.lightparam_setlp,'selectedobject'),'tag');
switch v1
   case 'lightparam_rb1_setlp', templp='default';
   case 'lightparam_rb2_setlp', templp='chalk';
   case 'lightparam_rb3_setlp', templp='china';
   case 'lightparam_rb4_setlp', templp='glass';
   case 'lightparam_rb5_setlp', templp='metal';
   case 'lightparam_rb6_setlp', templp='plastic';
   case 'lightparam_rb7_setlp', templp='rubber';
   case 'lightparam_rb8_setlp', templp='wax';
   case 'lightparam_rb9_setlp',
      templp=[get(handles.slider1_setlp,'value'),get(handles.slider2_setlp,'value'),...
         get(handles.slider3_setlp,'value'),get(handles.slider4_setlp,'value')];
end
v4=get(get(handles.facelighting_setlp,'selectedobject'),'tag');
switch v4
   case 'facelighting_rb1_setlp', tempfl='none';
   case 'facelighting_rb2_setlp', tempfl='flat';
   case 'facelighting_rb3_setlp', tempfl='gouraud';
   case 'facelighting_rb4_setlp', tempfl='phong';
end
globalfl=tempfl; globallp=templp;
uiresume;

% --- Executes on button press in cancel_setlp.
function cancel_setlp_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;


function edit1_setlp_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_setlp as text
%        str2double(get(hObject,'String')) returns contents of edit1_setlp as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.slider1_setlp,'value',value);
else 
   value=handles.default(1);
   set(hObject,'string',num2str(round(value))); set(handles.slider1_setlp,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit1_setlp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function edit2_setlp_Callback(hObject, eventdata, handles)
% hObject    handle to edit2_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2_setlp as text
%        str2double(get(hObject,'String')) returns contents of edit2_setlp as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.slider2_setlp,'value',value);
else 
   value=handles.default(2);
   set(hObject,'string',num2str(round(value))); set(handles.slider2_setlp,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit2_setlp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function edit3_setlp_Callback(hObject, eventdata, handles)
% hObject    handle to edit3_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3_setlp as text
%        str2double(get(hObject,'String')) returns contents of edit3_setlp as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.slider3_setlp,'value',value);
else 
   value=handles.default(3);
   set(hObject,'string',num2str(round(value))); set(handles.slider3_setlp,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit3_setlp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function edit4_setlp_Callback(hObject, eventdata, handles)
% hObject    handle to edit4_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4_setlp as text
%        str2double(get(hObject,'String')) returns contents of edit4_setlp as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=1)&&(value<=30)&&(value==round(value)) set(handles.slider4_setlp,'value',value);
else 
   value=handles.default(4);
   set(hObject,'string',num2str(round(value))); set(handles.slider4_setlp,'value',value);
   waitfor(msgbox('Please enter an integer between 1 and 30.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit4_setlp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4_setlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in lightparam_setlp.
function lightparam_setlp_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in lightparam_setlp
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag')
   case 'lightparam_rb1_setlp'
      set(handles.slider1_setlp,'value',0.8);
      set(handles.slider2_setlp,'value',0.8);
      set(handles.slider3_setlp,'value',0.8);
      set(handles.slider4_setlp,'value',1);
      set(handles.edit1_setlp,'string','');
      set(handles.edit2_setlp,'string','');
      set(handles.edit3_setlp,'string','');
      set(handles.edit4_setlp,'string','');
   case 'lightparam_rb2_setlp'
      set(handles.slider1_setlp,'value',0.25);
      set(handles.slider2_setlp,'value',0.75);
      set(handles.slider3_setlp,'value',0);
      set(handles.slider4_setlp,'value',1);
      set(handles.edit1_setlp,'string','0.25');
      set(handles.edit2_setlp,'string','0.75');
      set(handles.edit3_setlp,'string','0.00');
      set(handles.edit4_setlp,'string','1');
   case 'lightparam_rb3_setlp'
      set(handles.slider1_setlp,'value',0.25);
      set(handles.slider2_setlp,'value',0.75);
      set(handles.slider3_setlp,'value',1);
      set(handles.slider4_setlp,'value',30);
      set(handles.edit1_setlp,'string','0.25');
      set(handles.edit2_setlp,'string','0.75');
      set(handles.edit3_setlp,'string','1.00');
      set(handles.edit4_setlp,'string','30');
   case 'lightparam_rb4_setlp'
      set(handles.slider1_setlp,'value',0.5);
      set(handles.slider2_setlp,'value',0);
      set(handles.slider3_setlp,'value',1);
      set(handles.slider4_setlp,'value',20);
      set(handles.edit1_setlp,'string','0.50');
      set(handles.edit2_setlp,'string','0.00');
      set(handles.edit3_setlp,'string','1.00');
      set(handles.edit4_setlp,'string','20');
   case 'lightparam_rb5_setlp'
      set(handles.slider1_setlp,'value',0.5);
      set(handles.slider2_setlp,'value',0.1);
      set(handles.slider3_setlp,'value',0.9);
      set(handles.slider4_setlp,'value',1);
      set(handles.edit1_setlp,'string','0.50');
      set(handles.edit2_setlp,'string','0.10');
      set(handles.edit3_setlp,'string','0.90');
      set(handles.edit4_setlp,'string','1');
   case 'lightparam_rb6_setlp'
      set(handles.slider1_setlp,'value',0.75);
      set(handles.slider2_setlp,'value',0.75);
      set(handles.slider3_setlp,'value',1);
      set(handles.slider4_setlp,'value',9);
      set(handles.edit1_setlp,'string','0.75');
      set(handles.edit2_setlp,'string','0.75');
      set(handles.edit3_setlp,'string','1.00');
      set(handles.edit4_setlp,'string','9');
   case 'lightparam_rb7_setlp'
      set(handles.slider1_setlp,'value',0.75);
      set(handles.slider2_setlp,'value',0.75);
      set(handles.slider3_setlp,'value',0);
      set(handles.slider4_setlp,'value',1);
      set(handles.edit1_setlp,'string','0.75');
      set(handles.edit2_setlp,'string','0.75');
      set(handles.edit3_setlp,'string','0.00');
      set(handles.edit4_setlp,'string','1');
   case 'lightparam_rb8_setlp'
      set(handles.slider1_setlp,'value',0.2);
      set(handles.slider2_setlp,'value',1);
      set(handles.slider3_setlp,'value',0.5);
      set(handles.slider4_setlp,'value',10);
      set(handles.edit1_setlp,'string','0.20');
      set(handles.edit2_setlp,'string','1.00');
      set(handles.edit3_setlp,'string','0.50');
      set(handles.edit4_setlp,'string','10');
   case 'lightparam_rb9_setlp'
      set(handles.slider1_setlp,'enable','on');
      set(handles.slider2_setlp,'enable','on');
      set(handles.slider3_setlp,'enable','on');
      set(handles.slider4_setlp,'enable','on');
      set(handles.edit1_setlp,'enable','on','string',sprintf('%4.2f',get(handles.slider1_setlp,'value')));
      set(handles.edit2_setlp,'enable','on','string',sprintf('%4.2f',get(handles.slider2_setlp,'value')));
      set(handles.edit3_setlp,'enable','on','string',sprintf('%4.2f',get(handles.slider3_setlp,'value')));
      set(handles.edit4_setlp,'enable','on','string',sprintf('%d',get(handles.slider4_setlp,'value')));
end
switch get(eventdata.OldValue,'Tag')
   case 'lightparam_rb9_setlp'
      set(handles.slider1_setlp,'enable','off');
      set(handles.slider2_setlp,'enable','off');
      set(handles.slider3_setlp,'enable','off');
      set(handles.slider4_setlp,'enable','off');
      set(handles.edit1_setlp,'enable','off');
      set(handles.edit2_setlp,'enable','off');
      set(handles.edit3_setlp,'enable','off');
      set(handles.edit4_setlp,'enable','off');
end
