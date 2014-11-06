function varargout = drawsurface(varargin)
% DRAWSURFACE MATLAB code for drawsurface.fig
%      DRAWSURFACE, by itself, creates a new DRAWSURFACE or raises the existing
%      singleton*.
%
%      H = DRAWSURFACE returns the handle to a new DRAWSURFACE or the handle to
%      the existing singleton*.
%
%      DRAWSURFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWSURFACE.M with the given input arguments.
%
%      DRAWSURFACE('Property','Value',...) creates a new DRAWSURFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drawsurface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drawsurface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drawsurface

% Last Modified by GUIDE v2.5 13-Oct-2014 15:19:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @drawsurface_OpeningFcn, ...
   'gui_OutputFcn',  @drawsurface_OutputFcn, ...
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


% --- Executes just before drawsurface is made visible.
function drawsurface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawsurface (see VARARGIN)
global globalfl globallp;
% Choose default command line output for drawsurface
handles.output = hObject;
if isempty(get(hObject,'Userdata'))
   st0=struct('function','drawsurface','fcnstr','','fcnct','direct','iso',0,'sc',[0.5,0.5,0.5],'sa',1,'rn',[0,1,0,1,0,1],...
      'rnct','direct','sm','on','sms',3,'smd',0.65,'fl',globalfl,'lp',globallp,'res','default');
   set(hObject,'Userdata',st0);
else
   st0=get(hObject,'Userdata');
   set(handles.fcnhdl_drawsurface,'string',st0.fcnstr);
   if strcmpi(st0.fcnct,'Cartesian') set(handles.rb1_fcn_drawsurface,'value',1); end
   if numel(st0.iso)==1
      set(handles.rb1_iso_drawsurface,'value',1);
      set(handles.iso0_drawsurface,'string',num2str(st0.iso));
   else
      set(handles.rb2_iso_drawsurface,'value',1);
      set(handles.isomin_drawsurface,'enable','on','string',num2str(st0.iso(1)));
      set(handles.isomax_drawsurface,'enable','on','string',num2str(st0.iso(2)));
      set(handles.iso0_drawsurface,'enable','off');
   end
   if iscell(st0.sc)
      set(handles.rb3_fc_drawsurface,'value',1);
      set(handles.color_r_edit_drawsurface,'enable','off');
      set(handles.color_g_edit_drawsurface,'enable','off');
      set(handles.color_b_edit_drawsurface,'enable','off');
      set(handles.color_r_slider_drawsurface,'enable','off');
      set(handles.color_g_slider_drawsurface,'enable','off');
      set(handles.color_b_slider_drawsurface,'enable','off');
      set(handles.color_setcolor_drawsurface,'enable','off');
      set(handles.define_rb2_drawsurface,'enable','off');
      set(handles.define_rb3_drawsurface,'enable','on','userdata',st0.sc);
   elseif numel(st0.sc)==3
      set(handles.rb1_fc_drawsurface,'value',1);
      hcolor=st0.sc;
      set(handles.color_r_edit_drawsurface,'String',num2str(round(hcolor(1)*255)));
      set(handles.color_g_edit_drawsurface,'String',num2str(round(hcolor(2)*255)));
      set(handles.color_b_edit_drawsurface,'String',num2str(round(hcolor(3)*255)));
      set(handles.color_r_slider_drawsurface,'value',hcolor(1)*255);
      set(handles.color_g_slider_drawsurface,'value',hcolor(2)*255);
      set(handles.color_b_slider_drawsurface,'value',hcolor(3)*255);
      set(handles.color_prev_drawsurface,'backgroundcolor',hcolor);
   elseif numel(st0.sc)==6
      set(handles.rb2_fc_drawsurface,'value',1);
      set(handles.color_r_edit_drawsurface,'enable','off');
      set(handles.color_g_edit_drawsurface,'enable','off');
      set(handles.color_b_edit_drawsurface,'enable','off');
      set(handles.color_r_slider_drawsurface,'enable','off');
      set(handles.color_g_slider_drawsurface,'enable','off');
      set(handles.color_b_slider_drawsurface,'enable','off');
      set(handles.color_setcolor_drawsurface,'enable','off');
      set(handles.define_rb2_drawsurface,'enable','on','userdata',[num2cell(st0.sc),{'Positive side/outside color:','Negative side/inside color:','Figuretool2: drawsurface'}]);
      set(handles.define_rb3_drawsurface,'enable','off');
   end
   set(handles.alpha_slider_drawsurface,'value',st0.sa);
   set(handles.alpha_edit_drawsurface,'string',sprintf('%4.2f',st0.sa));
   set(handles.xmin_drawsurface,'string',num2str(st0.rn(1)));
   set(handles.xmax_drawsurface,'string',num2str(st0.rn(2)));
   set(handles.ymin_drawsurface,'string',num2str(st0.rn(3)));
   set(handles.ymax_drawsurface,'string',num2str(st0.rn(4)));
   set(handles.zmin_drawsurface,'string',num2str(st0.rn(5)));
   set(handles.zmax_drawsurface,'string',num2str(st0.rn(6)));
   if strcmpi(st0.rnct,'Cartesian') set(handles.rb1_rn_drawsurface,'value',1); end
   if strcmpi(st0.sm,'on')
      set(handles.sm_on_drawsurface,'value',1);
      set(handles.size_sm_drawsurface,'string',num2str(st0.sms));
      set(handles.dev_sm_drawsurface,'string',num2str(st0.smd));
   else
      set(handles.sm_on_drawsurface,'value',0);
      set(handles.size_sm_drawsurface,'enable','off');
      set(handles.dev_sm_drawsurface,'enable','off');
   end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drawsurface wait for user response (see UIRESUME)
% uiwait(handles.drawsurface);


% --- Outputs from this function are returned to the command line.
function varargout = drawsurface_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function iso0_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to iso0_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of iso0_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of iso0_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function iso0_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iso0_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function alpha_slider_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_slider_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.alpha_edit_drawsurface,'string',sprintf('%4.2f',value));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function alpha_slider_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_slider_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function alpha_edit_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_edit_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.alpha_slider_drawsurface,'value',value);
else set(hObject,'string','1.00'); set(handles.alpha_slider_drawsurface,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end

% Hints: get(hObject,'String') returns contents of alpha_edit_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of alpha_edit_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function alpha_edit_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_edit_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_drawsurface.
function OK_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to OK_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'UserData');
temp=str2func(['@(x,y,z)',get(handles.fcnhdl_drawsurface,'string')]);
if fcntest(temp) st0.fcnstr=get(handles.fcnhdl_drawsurface,'string');
else waitfor(msgbox('f(x,y,z) must be a real-valued function of variables x, y and z.','Figuretool2')); return; end
if get(handles.rb1_fcn_drawsurface,'value')==1 st0.fcnct='Cartesian'; else st0.fcnct='direct'; end
if get(handles.rb1_iso_drawsurface,'value')==1 st0.iso=str2double(get(handles.iso0_drawsurface,'string'));
else
   temp1=str2double(get(handles.isomin_drawsurface,'string'));
   temp2=str2double(get(handles.isomax_drawsurface,'string'));
   if temp1>=temp2 waitfor(msgbox('The lower bound of isolevel must be less than the upper bound.','Figuretool2')); return; end
   st0.iso=[temp1,temp2];
end
if get(handles.rb1_fc_drawsurface,'value')==1
   rvalue=get(handles.color_r_slider_drawsurface,'value');
   gvalue=get(handles.color_g_slider_drawsurface,'value');
   bvalue=get(handles.color_b_slider_drawsurface,'value');
   st0.sc=[rvalue,gvalue,bvalue]/255;
elseif get(handles.rb2_fc_drawsurface,'value')==1
   temp=get(handles.define_rb2_drawsurface,'userdata');
   if isempty(temp) waitfor(msgbox('Please specify the colors for drawing two-colored surfaces.','Figuretool2')); return; end
   st0.sc=cell2mat(temp(1:6));
else
   st0.sc=get(handles.define_rb3_drawsurface,'userdata');
end
st0.sa=get(handles.alpha_slider_drawsurface,'value');
xmin=str2double(get(handles.xmin_drawsurface,'string'));
xmax=str2double(get(handles.xmax_drawsurface,'string'));
ymin=str2double(get(handles.ymin_drawsurface,'string'));
ymax=str2double(get(handles.ymax_drawsurface,'string'));
zmin=str2double(get(handles.zmin_drawsurface,'string'));
zmax=str2double(get(handles.zmax_drawsurface,'string'));
if (xmin>=xmax)||(ymin>=ymax)||(zmin>=zmax) waitfor(msgbox('The lower bound of the range must be less than the upper bound.','Figuretool2')); return; end
st0.rn=[xmin,xmax,ymin,ymax,zmin,zmax];
if get(handles.rb1_rn_drawsurface,'value')==1 st0.rnct='Cartesian'; else st0.rnct='direct'; end
if get(handles.sm_on_drawsurface,'value')==1
   st0.sm='on';
   st0.sms=str2double(get(handles.size_sm_drawsurface,'string'));
   st0.smd=str2double(get(handles.dev_sm_drawsurface,'string'));
else
   st0.sm='off';
end
set(get(hObject,'parent'),'userdata',st0);
uiresume;


% --- Executes on button press in cancel_drawsurface.
function cancel_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes on button press in advanced_drawsurface.
function advanced_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to advanced_drawsurface (see GCBO)
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

% --- Executes on button press in sm_on_drawsurface.
function sm_on_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to sm_on_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
   set(handles.size_sm_drawsurface,'enable','on');
   set(handles.dev_sm_drawsurface,'enable','on');
else
   set(handles.size_sm_drawsurface,'enable','off');
   set(handles.dev_sm_drawsurface,'enable','off');
end
% Hint: get(hObject,'Value') returns toggle state of sm_on_drawsurface



function size_sm_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to size_sm_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0)||(round(temp)~=temp) set(hObject,'string','3'); waitfor(msgbox('Please enter a positive integer.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of size_sm_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of size_sm_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function size_sm_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to size_sm_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function dev_sm_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to dev_sm_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0) set(hObject,'string','0.65'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of dev_sm_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of dev_sm_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function dev_sm_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dev_sm_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_r_edit_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to color_r_edit_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_r_slider_drawsurface,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawsurface,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawsurface,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawsurface,'String'));
   set(handles.color_prev_drawsurface,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_r_slider_drawsurface,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_r_slider_drawsurface,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_r_edit_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of color_r_edit_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function color_r_edit_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_r_edit_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_g_edit_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to color_g_edit_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_g_slider_drawsurface,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawsurface,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawsurface,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawsurface,'String'));
   set(handles.color_prev_drawsurface,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_g_slider_drawsurface,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_g_slider_drawsurface,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_g_edit_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of color_g_edit_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function color_g_edit_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_g_edit_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_b_edit_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to color_b_edit_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_b_slider_drawsurface,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawsurface,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawsurface,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawsurface,'String'));
   set(handles.color_prev_drawsurface,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_b_slider_drawsurface,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_b_slider_drawsurface,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_b_edit_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of color_b_edit_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function color_b_edit_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_b_edit_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function color_r_slider_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to color_r_slider_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_r_edit_drawsurface,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawsurface,'String'));
gvalue=str2double(get(handles.color_g_edit_drawsurface,'String'));
bvalue=str2double(get(handles.color_b_edit_drawsurface,'String'));
set(handles.color_prev_drawsurface,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_r_slider_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_r_slider_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_g_slider_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to color_g_slider_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_g_edit_drawsurface,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawsurface,'String'));
gvalue=str2double(get(handles.color_g_edit_drawsurface,'String'));
bvalue=str2double(get(handles.color_b_edit_drawsurface,'String'));
set(handles.color_prev_drawsurface,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_g_slider_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_g_slider_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_b_slider_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to color_b_slider_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_b_edit_drawsurface,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawsurface,'String'));
gvalue=str2double(get(handles.color_g_edit_drawsurface,'String'));
bvalue=str2double(get(handles.color_b_edit_drawsurface,'String'));
set(handles.color_prev_drawsurface,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_b_slider_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_b_slider_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in color_setcolor_drawsurface.
function color_setcolor_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to color_setcolor_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.color_r_edit_drawsurface,'String'));
gvalue=str2double(get(handles.color_g_edit_drawsurface,'String'));
bvalue=str2double(get(handles.color_b_edit_drawsurface,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.color_r_edit_drawsurface,'String',num2str(round(hcolor(1)*255)));
   set(handles.color_g_edit_drawsurface,'String',num2str(round(hcolor(2)*255)));
   set(handles.color_b_edit_drawsurface,'String',num2str(round(hcolor(3)*255)));
   set(handles.color_r_slider_drawsurface,'value',hcolor(1)*255);
   set(handles.color_g_slider_drawsurface,'value',hcolor(2)*255);
   set(handles.color_b_slider_drawsurface,'value',hcolor(3)*255);
   set(handles.color_prev_drawsurface,'backgroundcolor',hcolor);
end


% --- Executes on button press in define_rb2_drawsurface.
function define_rb2_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to define_rb2_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(hObject,'userdata');
if isempty(temp) temp={1,1,1,0,0,0,'Positive side/outside color:','Negative side/inside color:','Figuretool2: drawsurface'}; end
h0=bicolordef('userdata',temp);
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if strcmpi(temp,'cancelled') return; end
set(hObject,'userdata',temp);


% --- Executes on button press in define_rb3_drawsurface.
function define_rb3_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to define_rb3_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function xmin_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to xmin_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end

% Hints: get(hObject,'String') returns contents of xmin_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of xmin_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function xmin_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmin_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function xmax_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to xmax_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of xmax_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of xmax_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function xmax_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmax_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function ymin_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to ymin_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of ymin_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of ymin_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function ymin_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymin_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function ymax_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to ymax_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of ymax_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of ymax_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function ymax_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymax_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function zmin_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to zmin_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of zmin_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of zmin_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function zmin_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmin_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function zmax_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to zmax_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of zmax_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of zmax_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function zmax_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmax_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function fcnhdl_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to fcnhdl_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fcnhdl_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of fcnhdl_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function fcnhdl_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fcnhdl_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function isomin_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to isomin_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','-0.1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of isomin_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of isomin_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function isomin_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isomin_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function isomax_drawsurface_Callback(hObject, eventdata, handles)
% hObject    handle to isomax_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0.1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of isomax_drawsurface as text
%        str2double(get(hObject,'String')) returns contents of isomax_drawsurface as a double


% --- Executes during object creation, after setting all properties.
function isomax_drawsurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isomax_drawsurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in iso0_drawsurface.
function iso_drawsurface_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in iso0_drawsurface
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_iso_drawsurface')
   set(handles.iso0_drawsurface,'enable','on');
   set(handles.isomin_drawsurface,'enable','off');
   set(handles.isomax_drawsurface,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_iso_drawsurface')
   set(handles.iso0_drawsurface,'enable','off');
   set(handles.isomin_drawsurface,'enable','on');
   set(handles.isomax_drawsurface,'enable','on');
end


% --- Executes when selected object is changed in fc_drawsurface.
function fc_drawsurface_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in fc_drawsurface
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_fc_drawsurface')
   set(handles.color_r_edit_drawsurface,'enable','on');
   set(handles.color_g_edit_drawsurface,'enable','on');
   set(handles.color_b_edit_drawsurface,'enable','on');
   set(handles.color_r_slider_drawsurface,'enable','on');
   set(handles.color_g_slider_drawsurface,'enable','on');
   set(handles.color_b_slider_drawsurface,'enable','on');
   set(handles.color_setcolor_drawsurface,'enable','on');
   set(handles.define_rb2_drawsurface,'enable','off');
   set(handles.define_rb3_drawsurface,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_fc_drawsurface')
   set(handles.color_r_edit_drawsurface,'enable','off');
   set(handles.color_g_edit_drawsurface,'enable','off');
   set(handles.color_b_edit_drawsurface,'enable','off');
   set(handles.color_r_slider_drawsurface,'enable','off');
   set(handles.color_g_slider_drawsurface,'enable','off');
   set(handles.color_b_slider_drawsurface,'enable','off');
   set(handles.color_setcolor_drawsurface,'enable','off');
   set(handles.define_rb2_drawsurface,'enable','on');
   set(handles.define_rb3_drawsurface,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb3_fc_drawsurface')
   set(handles.color_r_edit_drawsurface,'enable','off');
   set(handles.color_g_edit_drawsurface,'enable','off');
   set(handles.color_b_edit_drawsurface,'enable','off');
   set(handles.color_r_slider_drawsurface,'enable','off');
   set(handles.color_g_slider_drawsurface,'enable','off');
   set(handles.color_b_slider_drawsurface,'enable','off');
   set(handles.color_setcolor_drawsurface,'enable','off');
   set(handles.define_rb2_drawsurface,'enable','off');
   set(handles.define_rb3_drawsurface,'enable','on');
end

function boolout=fcntest(fcnhdl)
boolout=true;
xtest=rand(3,3,3); ytest=rand(3,3,3); ztest=rand(3,3,3); rtest=zeros(3,3,3);
try
   for j=1:numel(xtest)
      rtest(j)=fcnhdl(xtest(j),ytest(j),ztest(j));
   end
catch
   boolout=false; return;
end
if any(isnan(rtest(:)))||any(~isreal(rtest(:))) boolout=false; return; end
