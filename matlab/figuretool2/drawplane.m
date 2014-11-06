function varargout = drawplane(varargin)
% DRAWPLANE MATLAB code for drawplane.fig
%      DRAWPLANE, by itself, creates a new DRAWPLANE or raises the existing
%      singleton*.
%
%      H = DRAWPLANE returns the handle to a new DRAWPLANE or the handle to
%      the existing singleton*.
%
%      DRAWPLANE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWPLANE.M with the given input arguments.
%
%      DRAWPLANE('Property','Value',...) creates a new DRAWPLANE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drawplane_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drawplane_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drawplane

% Last Modified by GUIDE v2.5 28-Oct-2014 17:53:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @drawplane_OpeningFcn, ...
   'gui_OutputFcn',  @drawplane_OutputFcn, ...
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


% --- Executes just before drawplane is made visible.
function drawplane_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawplane (see VARARGIN)
global globalfl globallp;
% Choose default command line output for drawplane
handles.output = hObject;
JEdit=findjobj(handles.pl_drawplane);
JEdit.Editable=0;
if isempty(get(hObject,'Userdata'))
   st0=struct('function','drawplane','pl','','sc',[0.5,0.5,0.5],'sa',1,'rn',[0,1,0,1,0,1],...
      'rnct','direct','fl',globalfl,'lp',globallp,'res','default');
   set(hObject,'Userdata',st0);
else
   st0=get(hObject,'Userdata');
   if ~isempty(st0.pl)
      set(handles.pledit_drawplane,'userdata',st0.pl);
      set(handles.pl_drawplane,'string',dispplane(st0.pl));
   end
   if iscell(st0.sc)
      set(handles.rb2_fc_drawplane,'value',1);
      set(handles.color_r_edit_drawplane,'enable','off');
      set(handles.color_g_edit_drawplane,'enable','off');
      set(handles.color_b_edit_drawplane,'enable','off');
      set(handles.color_r_slider_drawplane,'enable','off');
      set(handles.color_g_slider_drawplane,'enable','off');
      set(handles.color_b_slider_drawplane,'enable','off');
      set(handles.color_setcolor_drawplane,'enable','off');
      set(handles.define_fc_drawplane,'enable','on','userdata',st0.sc);
   elseif numel(st0.sc)==3
      set(handles.rb1_fc_drawplane,'value',1);
      hcolor=st0.sc;
      set(handles.color_r_edit_drawplane,'String',num2str(round(hcolor(1)*255)));
      set(handles.color_g_edit_drawplane,'String',num2str(round(hcolor(2)*255)));
      set(handles.color_b_edit_drawplane,'String',num2str(round(hcolor(3)*255)));
      set(handles.color_r_slider_drawplane,'value',hcolor(1)*255);
      set(handles.color_g_slider_drawplane,'value',hcolor(2)*255);
      set(handles.color_b_slider_drawplane,'value',hcolor(3)*255);
      set(handles.color_prev_drawplane,'backgroundcolor',hcolor);
   end
   set(handles.alpha_slider_drawplane,'value',st0.sa);
   set(handles.alpha_edit_drawplane,'string',sprintf('%4.2f',st0.sa));
   set(handles.xmin_drawplane,'string',num2str(st0.rn(1)));
   set(handles.xmax_drawplane,'string',num2str(st0.rn(2)));
   set(handles.ymin_drawplane,'string',num2str(st0.rn(3)));
   set(handles.ymax_drawplane,'string',num2str(st0.rn(4)));
   set(handles.zmin_drawplane,'string',num2str(st0.rn(5)));
   set(handles.zmax_drawplane,'string',num2str(st0.rn(6)));
   if strcmpi(st0.rnct,'Cartesian') set(handles.rb1_rn_drawplane,'value',1); end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drawplane wait for user response (see UIRESUME)
% uiwait(handles.drawplane);


% --- Outputs from this function are returned to the command line.
function varargout = drawplane_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function alpha_slider_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_slider_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.alpha_edit_drawplane,'string',sprintf('%4.2f',value));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function alpha_slider_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_slider_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function alpha_edit_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_edit_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.alpha_slider_drawplane,'value',value);
else set(hObject,'string','1.00'); set(handles.alpha_slider_drawplane,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end

% Hints: get(hObject,'String') returns contents of alpha_edit_drawplane as text
%        str2double(get(hObject,'String')) returns contents of alpha_edit_drawplane as a double


% --- Executes during object creation, after setting all properties.
function alpha_edit_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_edit_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_drawplane.
function OK_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to OK_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'UserData');
temp=get(handles.pledit_drawplane,'userdata');
if isempty(temp) waitfor(msgbox('Please specify the plane to be drawn.','Figuretool2')); return; end
st0.pl=temp;
if get(handles.rb1_fc_drawplane,'value')==1
   rvalue=get(handles.color_r_slider_drawplane,'value');
   gvalue=get(handles.color_g_slider_drawplane,'value');
   bvalue=get(handles.color_b_slider_drawplane,'value');
   st0.sc=[rvalue,gvalue,bvalue]/255;
else
   st0.sc=get(handles.define_fc_drawplane,'userdata');
end
st0.sa=get(handles.alpha_slider_drawplane,'value');
xmin=str2double(get(handles.xmin_drawplane,'string'));
xmax=str2double(get(handles.xmax_drawplane,'string'));
ymin=str2double(get(handles.ymin_drawplane,'string'));
ymax=str2double(get(handles.ymax_drawplane,'string'));
zmin=str2double(get(handles.zmin_drawplane,'string'));
zmax=str2double(get(handles.zmax_drawplane,'string'));
if (xmin>=xmax)||(ymin>=ymax)||(zmin>=zmax) waitfor(msgbox('The lower bound of the range must be less than the upper bound.','Figuretool2')); return; end
st0.rn=[xmin,xmax,ymin,ymax,zmin,zmax];
if get(handles.rb1_rn_drawplane,'value')==1 st0.rnct='Cartesian'; else st0.rnct='direct'; end
set(get(hObject,'parent'),'userdata',st0);
uiresume;


% --- Executes on button press in cancel_drawplane.
function cancel_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes on button press in advanced_drawplane.
function advanced_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to advanced_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'Userdata');
h0=adv_settings('Userdata',{st0.lp,[0.8,0.6,0.9,10],st0.res,st0.fl});
uiwait(h0);
if ~ishandle(h0) return; end
res0=get(h0,'Userdata');
delete(h0);
if ischar(res0)&&strcmpi(res0,'cancelled') return; end
st0.lp=res0{1};
st0.res=res0{2};
st0.fl=res0{3};
set(get(hObject,'parent'),'Userdata',st0);
return;


function color_r_edit_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to color_r_edit_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_r_slider_drawplane,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawplane,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawplane,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawplane,'String'));
   set(handles.color_prev_drawplane,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_r_slider_drawplane,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_r_slider_drawplane,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_r_edit_drawplane as text
%        str2double(get(hObject,'String')) returns contents of color_r_edit_drawplane as a double


% --- Executes during object creation, after setting all properties.
function color_r_edit_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_r_edit_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_g_edit_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to color_g_edit_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_g_slider_drawplane,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawplane,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawplane,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawplane,'String'));
   set(handles.color_prev_drawplane,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_g_slider_drawplane,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_g_slider_drawplane,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_g_edit_drawplane as text
%        str2double(get(hObject,'String')) returns contents of color_g_edit_drawplane as a double


% --- Executes during object creation, after setting all properties.
function color_g_edit_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_g_edit_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_b_edit_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to color_b_edit_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_b_slider_drawplane,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawplane,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawplane,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawplane,'String'));
   set(handles.color_prev_drawplane,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_b_slider_drawplane,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_b_slider_drawplane,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_b_edit_drawplane as text
%        str2double(get(hObject,'String')) returns contents of color_b_edit_drawplane as a double


% --- Executes during object creation, after setting all properties.
function color_b_edit_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_b_edit_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function color_r_slider_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to color_r_slider_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_r_edit_drawplane,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawplane,'String'));
gvalue=str2double(get(handles.color_g_edit_drawplane,'String'));
bvalue=str2double(get(handles.color_b_edit_drawplane,'String'));
set(handles.color_prev_drawplane,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_r_slider_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_r_slider_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_g_slider_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to color_g_slider_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_g_edit_drawplane,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawplane,'String'));
gvalue=str2double(get(handles.color_g_edit_drawplane,'String'));
bvalue=str2double(get(handles.color_b_edit_drawplane,'String'));
set(handles.color_prev_drawplane,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_g_slider_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_g_slider_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_b_slider_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to color_b_slider_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_b_edit_drawplane,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawplane,'String'));
gvalue=str2double(get(handles.color_g_edit_drawplane,'String'));
bvalue=str2double(get(handles.color_b_edit_drawplane,'String'));
set(handles.color_prev_drawplane,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_b_slider_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_b_slider_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in color_setcolor_drawplane.
function color_setcolor_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to color_setcolor_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.color_r_edit_drawplane,'String'));
gvalue=str2double(get(handles.color_g_edit_drawplane,'String'));
bvalue=str2double(get(handles.color_b_edit_drawplane,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.color_r_edit_drawplane,'String',num2str(round(hcolor(1)*255)));
   set(handles.color_g_edit_drawplane,'String',num2str(round(hcolor(2)*255)));
   set(handles.color_b_edit_drawplane,'String',num2str(round(hcolor(3)*255)));
   set(handles.color_r_slider_drawplane,'value',hcolor(1)*255);
   set(handles.color_g_slider_drawplane,'value',hcolor(2)*255);
   set(handles.color_b_slider_drawplane,'value',hcolor(3)*255);
   set(handles.color_prev_drawplane,'backgroundcolor',hcolor);
end


% --- Executes on button press in define_fc_drawplane.
function define_fc_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to define_fc_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function xmin_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to xmin_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end

% Hints: get(hObject,'String') returns contents of xmin_drawplane as text
%        str2double(get(hObject,'String')) returns contents of xmin_drawplane as a double


% --- Executes during object creation, after setting all properties.
function xmin_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmin_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function xmax_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to xmax_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of xmax_drawplane as text
%        str2double(get(hObject,'String')) returns contents of xmax_drawplane as a double


% --- Executes during object creation, after setting all properties.
function xmax_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmax_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function ymin_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to ymin_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of ymin_drawplane as text
%        str2double(get(hObject,'String')) returns contents of ymin_drawplane as a double


% --- Executes during object creation, after setting all properties.
function ymin_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymin_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function ymax_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to ymax_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of ymax_drawplane as text
%        str2double(get(hObject,'String')) returns contents of ymax_drawplane as a double


% --- Executes during object creation, after setting all properties.
function ymax_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymax_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function zmin_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to zmin_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of zmin_drawplane as text
%        str2double(get(hObject,'String')) returns contents of zmin_drawplane as a double


% --- Executes during object creation, after setting all properties.
function zmin_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmin_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function zmax_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to zmax_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of zmax_drawplane as text
%        str2double(get(hObject,'String')) returns contents of zmax_drawplane as a double


% --- Executes during object creation, after setting all properties.
function zmax_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmax_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in fc_drawplane.
function fc_drawplane_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in fc_drawplane
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_fc_drawplane')
   set(handles.color_r_edit_drawplane,'enable','on');
   set(handles.color_g_edit_drawplane,'enable','on');
   set(handles.color_b_edit_drawplane,'enable','on');
   set(handles.color_r_slider_drawplane,'enable','on');
   set(handles.color_g_slider_drawplane,'enable','on');
   set(handles.color_b_slider_drawplane,'enable','on');
   set(handles.color_setcolor_drawplane,'enable','on');
   set(handles.define_fc_drawplane,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_fc_drawplane')
   set(handles.color_r_edit_drawplane,'enable','off');
   set(handles.color_g_edit_drawplane,'enable','off');
   set(handles.color_b_edit_drawplane,'enable','off');
   set(handles.color_r_slider_drawplane,'enable','off');
   set(handles.color_g_slider_drawplane,'enable','off');
   set(handles.color_b_slider_drawplane,'enable','off');
   set(handles.color_setcolor_drawplane,'enable','off');
   set(handles.define_fc_drawplane,'enable','on');
end


% --- Executes on button press in pledit_drawplane.
function pledit_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to pledit_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valstr=get(hObject,'userdata');
if isempty(valstr) h0=planeeditor();
else h0=planeeditor('userdata',valstr);
end
uiwait(h0);
if ~ishandle(h0) return; end
valstrnew=get(h0,'userdata');
delete(h0);
if strcmpi(valstrnew,'cancelled') return; end
set(hObject,'userdata',valstrnew);
set(handles.pl_drawplane,'string',dispplane(valstrnew));


function pl_drawplane_Callback(hObject, eventdata, handles)
% hObject    handle to pl_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pl_drawplane as text
%        str2double(get(hObject,'String')) returns contents of pl_drawplane as a double


% --- Executes during object creation, after setting all properties.
function pl_drawplane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pl_drawplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
