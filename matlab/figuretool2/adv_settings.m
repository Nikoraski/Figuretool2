function varargout = adv_settings(varargin)
% ADV_SETTINGS MATLAB code for adv_settings.fig
%      ADV_SETTINGS, by itself, creates a new ADV_SETTINGS or raises the existing
%      singleton*.
%
%      H = ADV_SETTINGS returns the handle to a new ADV_SETTINGS or the handle to
%      the existing singleton*.
%
%      ADV_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADV_SETTINGS.M with the given input arguments.
%
%      ADV_SETTINGS('Property','Value',...) creates a new ADV_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before adv_settings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to adv_settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help adv_settings

% Last Modified by GUIDE v2.5 10-Jul-2014 19:14:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @adv_settings_OpeningFcn, ...
   'gui_OutputFcn',  @adv_settings_OutputFcn, ...
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


% --- Executes just before adv_settings is made visible.
function adv_settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to adv_settings (see VARARGIN)
global res;
datain=get(hObject,'Userdata');
if isnumeric(datain{1})
   set(handles.lightparam_rb9_advset,'value',1);
   set(handles.slider1_advset,'enable','on');
   set(handles.slider2_advset,'enable','on');
   set(handles.slider3_advset,'enable','on');
   set(handles.slider4_advset,'enable','on');
   set(handles.edit1_advset,'enable','on');
   set(handles.edit2_advset,'enable','on');
   set(handles.edit3_advset,'enable','on');
   set(handles.edit4_advset,'enable','on');
   set(handles.slider1_advset,'value',datain{1}(1));
   set(handles.slider2_advset,'value',datain{1}(2));
   set(handles.slider3_advset,'value',datain{1}(3));
   set(handles.slider4_advset,'value',datain{1}(4));
   set(handles.edit1_advset,'string',sprintf('%4.2f',datain{1}(1)));
   set(handles.edit2_advset,'string',sprintf('%4.2f',datain{1}(2)));
   set(handles.edit3_advset,'string',sprintf('%4.2f',datain{1}(3)));
   set(handles.edit4_advset,'string',sprintf('%d',round(datain{1}(4))));
else
   switch datain{1}
      case 'default', set(handles.lightparam_rb1_advset,'value',1);
         set(handles.slider1_advset,'value',datain{2}(1));
         set(handles.slider2_advset,'value',datain{2}(2));
         set(handles.slider3_advset,'value',datain{2}(3));
         set(handles.slider4_advset,'value',datain{2}(4));
         set(handles.edit1_advset,'string',sprintf('%4.2f',datain{2}(1)));
         set(handles.edit2_advset,'string',sprintf('%4.2f',datain{2}(2)));
         set(handles.edit3_advset,'string',sprintf('%4.2f',datain{2}(3)));
         set(handles.edit4_advset,'string',sprintf('%d',round(datain{2}(4))));
      case 'chalk', set(handles.lightparam_rb2_advset,'value',1);
         set(handles.slider1_advset,'value',0.25);
         set(handles.slider2_advset,'value',0.75);
         set(handles.slider3_advset,'value',0);
         set(handles.slider4_advset,'value',1);
         set(handles.edit1_advset,'string','0.25');
         set(handles.edit2_advset,'string','0.75');
         set(handles.edit3_advset,'string','0.00');
         set(handles.edit4_advset,'string','1');
      case 'china', set(handles.lightparam_rb3_advset,'value',1);
         set(handles.slider1_advset,'value',0.25);
         set(handles.slider2_advset,'value',0.75);
         set(handles.slider3_advset,'value',1);
         set(handles.slider4_advset,'value',30);
         set(handles.edit1_advset,'string','0.25');
         set(handles.edit2_advset,'string','0.75');
         set(handles.edit3_advset,'string','1.00');
         set(handles.edit4_advset,'string','30');
      case 'glass', set(handles.lightparam_rb4_advset,'value',1);
         set(handles.slider1_advset,'value',0.5);
         set(handles.slider2_advset,'value',0);
         set(handles.slider3_advset,'value',1);
         set(handles.slider4_advset,'value',20);
         set(handles.edit1_advset,'string','0.50');
         set(handles.edit2_advset,'string','0.00');
         set(handles.edit3_advset,'string','1.00');
         set(handles.edit4_advset,'string','20');
      case 'metal', set(handles.lightparam_rb5_advset,'value',1);
         set(handles.slider1_advset,'value',0.5);
         set(handles.slider2_advset,'value',0.1);
         set(handles.slider3_advset,'value',0.9);
         set(handles.slider4_advset,'value',1);
         set(handles.edit1_advset,'string','0.50');
         set(handles.edit2_advset,'string','0.10');
         set(handles.edit3_advset,'string','0.90');
         set(handles.edit4_advset,'string','1');
      case 'plastic', set(handles.lightparam_rb6_advset,'value',1);
         set(handles.slider1_advset,'value',0.75);
         set(handles.slider2_advset,'value',0.75);
         set(handles.slider3_advset,'value',1);
         set(handles.slider4_advset,'value',9);
         set(handles.edit1_advset,'string','0.75');
         set(handles.edit2_advset,'string','0.75');
         set(handles.edit3_advset,'string','1.00');
         set(handles.edit4_advset,'string','9');
      case 'rubber', set(handles.lightparam_rb7_advset,'value',1);
         set(handles.slider1_advset,'value',0.75);
         set(handles.slider2_advset,'value',0.75);
         set(handles.slider3_advset,'value',0);
         set(handles.slider4_advset,'value',1);
         set(handles.edit1_advset,'string','0.75');
         set(handles.edit2_advset,'string','0.75');
         set(handles.edit3_advset,'string','0.00');
         set(handles.edit4_advset,'string','1');
      case 'wax', set(handles.lightparam_rb8_advset,'value',1);
         set(handles.slider1_advset,'value',0.2);
         set(handles.slider2_advset,'value',1);
         set(handles.slider3_advset,'value',0.5);
         set(handles.slider4_advset,'value',10);
         set(handles.edit1_advset,'string','0.20');
         set(handles.edit2_advset,'string','1.00');
         set(handles.edit3_advset,'string','0.50');
         set(handles.edit4_advset,'string','10');
   end
end
if ischar(datain{3})&&strcmpi(datain{3},'default')
   set(handles.res_rb1_advset,'value',1);
else
   set(handles.res_rb2_advset,'value',1); set(handles.res_cus_advset,'string',num2str(round(datain{3})));
   set(handles.res_cus_advset,'enable','on');
end
set(handles.res_glo_advset,'string',num2str(res));
switch datain{4}
   case 'none', set(handles.facelighting_rb1_advset,'value',1);
   case 'flat', set(handles.facelighting_rb2_advset,'value',1);
   case 'gouraud', set(handles.facelighting_rb3_advset,'value',1);
   case 'phong', set(handles.facelighting_rb4_advset,'value',1);
end
handles.default=datain{2};
% Choose default command line output for adv_settings
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes adv_settings wait for user response (see UIRESUME)
% uiwait(handles.advset);


% --- Outputs from this function are returned to the command line.
function varargout = adv_settings_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function res_cus_advset_Callback(hObject, eventdata, handles)
% hObject    handle to res_cus_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of res_cus_advset as text
%        str2double(get(hObject,'String')) returns contents of res_cus_advset as a double


% --- Executes during object creation, after setting all properties.
function res_cus_advset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to res_cus_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function res_glo_advset_Callback(hObject, eventdata, handles)
% hObject    handle to res_glo_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of res_glo_advset as text
%        str2double(get(hObject,'String')) returns contents of res_glo_advset as a double


% --- Executes during object creation, after setting all properties.
function res_glo_advset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to res_glo_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_advset_Callback(hObject, eventdata, handles)
% hObject    handle to slider1_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit1_advset,'string',sprintf('%4.2f',value));

% --- Executes during object creation, after setting all properties.
function slider1_advset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_advset_Callback(hObject, eventdata, handles)
% hObject    handle to slider2_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit2_advset,'string',sprintf('%4.2f',value));

% --- Executes during object creation, after setting all properties.
function slider2_advset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_advset_Callback(hObject, eventdata, handles)
% hObject    handle to slider3_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit3_advset,'string',sprintf('%4.2f',value));

% --- Executes during object creation, after setting all properties.
function slider3_advset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_advset_Callback(hObject, eventdata, handles)
% hObject    handle to slider4_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit4_advset,'string',sprintf('%d',round(value)));

% --- Executes during object creation, after setting all properties.
function slider4_advset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in OK_advset.
function OK_advset_Callback(hObject, eventdata, handles)
% hObject    handle to OK_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v1=get(get(handles.lightparam_advset,'selectedobject'),'tag');
switch v1
   case 'lightparam_rb1_advset', rout1='default';
   case 'lightparam_rb2_advset', rout1='chalk';
   case 'lightparam_rb3_advset', rout1='china';
   case 'lightparam_rb4_advset', rout1='glass';
   case 'lightparam_rb5_advset', rout1='metal';
   case 'lightparam_rb6_advset', rout1='plastic';
   case 'lightparam_rb7_advset', rout1='rubber';
   case 'lightparam_rb8_advset', rout1='wax';
   case 'lightparam_rb9_advset',
      rout1=[get(handles.slider1_advset,'value'),get(handles.slider2_advset,'value'),...
         get(handles.slider3_advset,'value'),get(handles.slider4_advset,'value')];
end
v3=get(get(handles.res_advset,'selectedobject'),'tag');
switch v3
   case 'res_rb1_advset', rout3='default';
   case 'res_rb2_advset', rout3=str2double(get(handles.res_cus_advset,'string'));
end
v4=get(get(handles.facelighting_advset,'selectedobject'),'tag');
switch v4
   case 'facelighting_rb1_advset', rout4='none';
   case 'facelighting_rb2_advset', rout4='flat';
   case 'facelighting_rb3_advset', rout4='gouraud';
   case 'facelighting_rb4_advset', rout4='phong';
end
set(get(hObject,'parent'),'Userdata',{rout1,rout3,rout4});
uiresume;

% --- Executes on button press in cancel_advset.
function cancel_advset_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;


function edit1_advset_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_advset as text
%        str2double(get(hObject,'String')) returns contents of edit1_advset as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.slider1_advset,'value',value);
else 
   value=handles.default(1);
   set(hObject,'string',num2str(round(value))); set(handles.slider1_advset,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit1_advset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function edit2_advset_Callback(hObject, eventdata, handles)
% hObject    handle to edit2_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2_advset as text
%        str2double(get(hObject,'String')) returns contents of edit2_advset as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.slider2_advset,'value',value);
else 
   value=handles.default(2);
   set(hObject,'string',num2str(round(value))); set(handles.slider2_advset,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit2_advset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function edit3_advset_Callback(hObject, eventdata, handles)
% hObject    handle to edit3_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3_advset as text
%        str2double(get(hObject,'String')) returns contents of edit3_advset as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.slider3_advset,'value',value);
else 
   value=handles.default(3);
   set(hObject,'string',num2str(round(value))); set(handles.slider3_advset,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit3_advset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function edit4_advset_Callback(hObject, eventdata, handles)
% hObject    handle to edit4_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4_advset as text
%        str2double(get(hObject,'String')) returns contents of edit4_advset as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=1)&&(value<=30)&&(value==round(value)) set(handles.slider4_advset,'value',value);
else 
   value=handles.default(4);
   set(hObject,'string',num2str(round(value))); set(handles.slider4_advset,'value',value);
   waitfor(msgbox('Please enter an integer between 1 and 30.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit4_advset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4_advset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in res_advset.
function res_advset_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in res_advset
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag')
   case 'res_rb1_advset'
      set(handles.res_cus_advset,'enable','off');
   case 'res_rb2_advset'
      set(handles.res_cus_advset,'enable','on');
end


% --- Executes when selected object is changed in lightparam_advset.
function lightparam_advset_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in lightparam_advset
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag')
   case 'lightparam_rb1_advset'
      set(handles.slider1_advset,'value',handles.default(1));
      set(handles.slider2_advset,'value',handles.default(2));
      set(handles.slider3_advset,'value',handles.default(3));
      set(handles.slider4_advset,'value',handles.default(4));
      set(handles.edit1_advset,'string',sprintf('%4.2f',handles.default(1)));
      set(handles.edit2_advset,'string',sprintf('%4.2f',handles.default(2)));
      set(handles.edit3_advset,'string',sprintf('%4.2f',handles.default(3)));
      set(handles.edit4_advset,'string',sprintf('%d',handles.default(4)));
   case 'lightparam_rb2_advset'
      set(handles.slider1_advset,'value',0.25);
      set(handles.slider2_advset,'value',0.75);
      set(handles.slider3_advset,'value',0);
      set(handles.slider4_advset,'value',1);
      set(handles.edit1_advset,'string','0.25');
      set(handles.edit2_advset,'string','0.75');
      set(handles.edit3_advset,'string','0.00');
      set(handles.edit4_advset,'string','1');
   case 'lightparam_rb3_advset'
      set(handles.slider1_advset,'value',0.25);
      set(handles.slider2_advset,'value',0.75);
      set(handles.slider3_advset,'value',1);
      set(handles.slider4_advset,'value',30);
      set(handles.edit1_advset,'string','0.25');
      set(handles.edit2_advset,'string','0.75');
      set(handles.edit3_advset,'string','1.00');
      set(handles.edit4_advset,'string','30');
   case 'lightparam_rb4_advset'
      set(handles.slider1_advset,'value',0.5);
      set(handles.slider2_advset,'value',0);
      set(handles.slider3_advset,'value',1);
      set(handles.slider4_advset,'value',20);
      set(handles.edit1_advset,'string','0.50');
      set(handles.edit2_advset,'string','0.00');
      set(handles.edit3_advset,'string','1.00');
      set(handles.edit4_advset,'string','20');
   case 'lightparam_rb5_advset'
      set(handles.slider1_advset,'value',0.5);
      set(handles.slider2_advset,'value',0.1);
      set(handles.slider3_advset,'value',0.9);
      set(handles.slider4_advset,'value',1);
      set(handles.edit1_advset,'string','0.50');
      set(handles.edit2_advset,'string','0.10');
      set(handles.edit3_advset,'string','0.90');
      set(handles.edit4_advset,'string','1');
   case 'lightparam_rb6_advset'
      set(handles.slider1_advset,'value',0.75);
      set(handles.slider2_advset,'value',0.75);
      set(handles.slider3_advset,'value',1);
      set(handles.slider4_advset,'value',9);
      set(handles.edit1_advset,'string','0.75');
      set(handles.edit2_advset,'string','0.75');
      set(handles.edit3_advset,'string','1.00');
      set(handles.edit4_advset,'string','9');
   case 'lightparam_rb7_advset'
      set(handles.slider1_advset,'value',0.75);
      set(handles.slider2_advset,'value',0.75);
      set(handles.slider3_advset,'value',0);
      set(handles.slider4_advset,'value',1);
      set(handles.edit1_advset,'string','0.75');
      set(handles.edit2_advset,'string','0.75');
      set(handles.edit3_advset,'string','0.00');
      set(handles.edit4_advset,'string','1');
   case 'lightparam_rb8_advset'
      set(handles.slider1_advset,'value',0.2);
      set(handles.slider2_advset,'value',1);
      set(handles.slider3_advset,'value',0.5);
      set(handles.slider4_advset,'value',10);
      set(handles.edit1_advset,'string','0.20');
      set(handles.edit2_advset,'string','1.00');
      set(handles.edit3_advset,'string','0.50');
      set(handles.edit4_advset,'string','10');
   case 'lightparam_rb9_advset'
      set(handles.slider1_advset,'enable','on');
      set(handles.slider2_advset,'enable','on');
      set(handles.slider3_advset,'enable','on');
      set(handles.slider4_advset,'enable','on');
      set(handles.edit1_advset,'enable','on');
      set(handles.edit2_advset,'enable','on');
      set(handles.edit3_advset,'enable','on');
      set(handles.edit4_advset,'enable','on');
end
switch get(eventdata.OldValue,'Tag')
   case 'lightparam_rb9_advset'
      set(handles.slider1_advset,'enable','off');
      set(handles.slider2_advset,'enable','off');
      set(handles.slider3_advset,'enable','off');
      set(handles.slider4_advset,'enable','off');
      set(handles.edit1_advset,'enable','off');
      set(handles.edit2_advset,'enable','off');
      set(handles.edit3_advset,'enable','off');
      set(handles.edit4_advset,'enable','off');
end
