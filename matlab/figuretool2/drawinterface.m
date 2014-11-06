function varargout = drawinterface(varargin)
% DRAWINTERFACE MATLAB code for drawinterface.fig
%      DRAWINTERFACE, by itself, creates a new DRAWINTERFACE or raises the existing
%      singleton*.
%
%      H = DRAWINTERFACE returns the handle to a new DRAWINTERFACE or the handle to
%      the existing singleton*.
%
%      DRAWINTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWINTERFACE.M with the given input arguments.
%
%      DRAWINTERFACE('Property','Value',...) creates a new DRAWINTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drawinterface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drawinterface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drawinterface

% Last Modified by GUIDE v2.5 14-Oct-2014 17:11:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @drawinterface_OpeningFcn, ...
   'gui_OutputFcn',  @drawinterface_OutputFcn, ...
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


% --- Executes just before drawinterface is made visible.
function drawinterface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawinterface (see VARARGIN)
global globalfl globallp;
% Choose default command line output for drawinterface
handles.output = hObject;
if isempty(get(hObject,'Userdata'))
   st0=struct('function','drawinterface','site1','','site2','','cexp',[2.5,2.5],'r','vdw 1.0','sc',[0.5,0.5,0.5],'sa',1,'rn',[0,1,0,1,0,1],...
      'sm','on','sms',3,'smd',0.65,'fl',globalfl,'lp',globallp,'res','default');
   set(hObject,'Userdata',st0);
else
   st0=get(hObject,'Userdata');
   set(handles.site1_edit_drawinterface,'string',st0.site1);
   set(handles.site2_edit_drawinterface,'string',st0.site2);
   set(handles.cexp1_drawinterface,'string',num2str(st0.cexp(1)));
   set(handles.cexp2_drawinterface,'string',num2str(st0.cexp(2)));
   if numel(st0.sc)==3
      set(handles.rb1_fc_drawinterface,'value',1);
      hcolor=st0.sc;
      set(handles.color_r_edit_drawinterface,'String',num2str(round(hcolor(1)*255)));
      set(handles.color_g_edit_drawinterface,'String',num2str(round(hcolor(2)*255)));
      set(handles.color_b_edit_drawinterface,'String',num2str(round(hcolor(3)*255)));
      set(handles.color_r_slider_drawinterface,'value',hcolor(1)*255);
      set(handles.color_g_slider_drawinterface,'value',hcolor(2)*255);
      set(handles.color_b_slider_drawinterface,'value',hcolor(3)*255);
      set(handles.color_prev_drawinterface,'backgroundcolor',hcolor);
   elseif numel(st0.sc)==6
      set(handles.rb2_fc_drawinterface,'value',1);
      set(handles.color_r_edit_drawinterface,'enable','off');
      set(handles.color_g_edit_drawinterface,'enable','off');
      set(handles.color_b_edit_drawinterface,'enable','off');
      set(handles.color_r_slider_drawinterface,'enable','off');
      set(handles.color_g_slider_drawinterface,'enable','off');
      set(handles.color_b_slider_drawinterface,'enable','off');
      set(handles.color_setcolor_drawinterface,'enable','off');
      set(handles.define_rb2_drawinterface,'enable','on','userdata',[num2cell(st0.sc),{'Outside color:','Inside color:','Figuretool2: drawinterface'}]);
   end
   set(handles.alpha_slider_drawinterface,'value',st0.sa);
   set(handles.alpha_edit_drawinterface,'string',sprintf('%4.2f',st0.sa));
   set(handles.xmin_drawinterface,'string',num2str(st0.rn(1)));
   set(handles.xmax_drawinterface,'string',num2str(st0.rn(2)));
   set(handles.ymin_drawinterface,'string',num2str(st0.rn(3)));
   set(handles.ymax_drawinterface,'string',num2str(st0.rn(4)));
   set(handles.zmin_drawinterface,'string',num2str(st0.rn(5)));
   set(handles.zmax_drawinterface,'string',num2str(st0.rn(6)));
   set(handles.radius_drawinterface,'string',num2str(st0.r));
   if strcmpi(st0.sm,'on')
      set(handles.sm_on_drawinterface,'value',1);
      set(handles.size_sm_drawinterface,'string',num2str(st0.sms));
      set(handles.dev_sm_drawinterface,'string',num2str(st0.smd));
   else
      set(handles.sm_on_drawinterface,'value',0);
      set(handles.size_sm_drawinterface,'enable','off');
      set(handles.dev_sm_drawinterface,'enable','off');
   end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drawinterface wait for user response (see UIRESUME)
% uiwait(handles.drawinterface);


% --- Outputs from this function are returned to the command line.
function varargout = drawinterface_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function alpha_slider_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_slider_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.alpha_edit_drawinterface,'string',sprintf('%4.2f',value));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function alpha_slider_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_slider_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function alpha_edit_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_edit_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.alpha_slider_drawinterface,'value',value);
else set(hObject,'string','1.00'); set(handles.alpha_slider_drawinterface,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end

% Hints: get(hObject,'String') returns contents of alpha_edit_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of alpha_edit_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function alpha_edit_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_edit_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_drawinterface.
function OK_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to OK_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'UserData');
temp=get(handles.site1_edit_drawinterface,'string');
if isempty(temp) waitfor(msgbox('Please specify the atoms in Site1.','Figuretool2')); return; end
[stackin,~,status]=siterefparser(temp);
if (status==0)||~strcmp(stackin,'B') waitfor(msgbox('The specified atom group site1 is invalid.','Figuretool2')); return; end
temp2=get(handles.site2_edit_drawinterface,'string');
if isempty(temp2) waitfor(msgbox('Please specify the atoms in Site2.','Figuretool2')); return; end
[stackin,~,status]=siterefparser(temp2);
if (status==0)||~strcmp(stackin,'B') waitfor(msgbox('The specified atom group site2 is invalid.','Figuretool2')); return; end
st0.site1=temp;
st0.site2=temp2;
cexp1=str2double(get(handles.cexp1_drawinterface,'string'));
cexp2=str2double(get(handles.cexp2_drawinterface,'string'));
st0.cexp=[cexp1,cexp2];
if get(handles.rb1_fc_drawinterface,'value')==1
   rvalue=get(handles.color_r_slider_drawinterface,'value');
   gvalue=get(handles.color_g_slider_drawinterface,'value');
   bvalue=get(handles.color_b_slider_drawinterface,'value');
   st0.sc=[rvalue,gvalue,bvalue]/255;
elseif get(handles.rb2_fc_drawinterface,'value')==1
   temp=get(handles.define_rb2_drawinterface,'userdata');
   if isempty(temp) waitfor(msgbox('Please specify the colors for drawing two-colored surfaces.','Figuretool2')); return; end
   st0.sc=cell2mat(temp(1:6));
end
st0.sa=get(handles.alpha_slider_drawinterface,'value');
xmin=str2double(get(handles.xmin_drawinterface,'string'));
xmax=str2double(get(handles.xmax_drawinterface,'string'));
ymin=str2double(get(handles.ymin_drawinterface,'string'));
ymax=str2double(get(handles.ymax_drawinterface,'string'));
zmin=str2double(get(handles.zmin_drawinterface,'string'));
zmax=str2double(get(handles.zmax_drawinterface,'string'));
if (xmin>=xmax)||(ymin>=ymax)||(zmin>=zmax) waitfor(msgbox('The lower bound of the range must be less than the upper bound.','Figuretool2')); return; end
st0.rn=[xmin,xmax,ymin,ymax,zmin,zmax];
if get(handles.sm_on_drawinterface,'value')==1
   st0.sm='on';
   st0.sms=str2double(get(handles.size_sm_drawinterface,'string'));
   st0.smd=str2double(get(handles.dev_sm_drawinterface,'string'));
else
   st0.sm='off';
end
st0.r=str2double(get(handles.radius_drawinterface,'string'));
set(get(hObject,'parent'),'userdata',st0);
uiresume;


% --- Executes on button press in cancel_drawinterface.
function cancel_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes on button press in advanced_drawinterface.
function advanced_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to advanced_drawinterface (see GCBO)
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

% --- Executes on button press in sm_on_drawinterface.
function sm_on_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to sm_on_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
   set(handles.size_sm_drawinterface,'enable','on');
   set(handles.dev_sm_drawinterface,'enable','on');
else
   set(handles.size_sm_drawinterface,'enable','off');
   set(handles.dev_sm_drawinterface,'enable','off');
end
% Hint: get(hObject,'Value') returns toggle state of sm_on_drawinterface



function size_sm_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to size_sm_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0)||(round(temp)~=temp) set(hObject,'string','3'); waitfor(msgbox('Please enter a positive integer.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of size_sm_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of size_sm_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function size_sm_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to size_sm_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function dev_sm_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to dev_sm_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0) set(hObject,'string','0.65'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of dev_sm_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of dev_sm_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function dev_sm_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dev_sm_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_r_edit_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to color_r_edit_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_r_slider_drawinterface,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawinterface,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawinterface,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawinterface,'String'));
   set(handles.color_prev_drawinterface,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_r_slider_drawinterface,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_r_slider_drawinterface,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_r_edit_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of color_r_edit_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function color_r_edit_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_r_edit_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_g_edit_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to color_g_edit_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_g_slider_drawinterface,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawinterface,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawinterface,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawinterface,'String'));
   set(handles.color_prev_drawinterface,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_g_slider_drawinterface,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_g_slider_drawinterface,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_g_edit_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of color_g_edit_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function color_g_edit_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_g_edit_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_b_edit_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to color_b_edit_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_b_slider_drawinterface,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawinterface,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawinterface,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawinterface,'String'));
   set(handles.color_prev_drawinterface,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_b_slider_drawinterface,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_b_slider_drawinterface,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_b_edit_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of color_b_edit_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function color_b_edit_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_b_edit_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function color_r_slider_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to color_r_slider_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_r_edit_drawinterface,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawinterface,'String'));
gvalue=str2double(get(handles.color_g_edit_drawinterface,'String'));
bvalue=str2double(get(handles.color_b_edit_drawinterface,'String'));
set(handles.color_prev_drawinterface,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_r_slider_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_r_slider_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_g_slider_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to color_g_slider_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_g_edit_drawinterface,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawinterface,'String'));
gvalue=str2double(get(handles.color_g_edit_drawinterface,'String'));
bvalue=str2double(get(handles.color_b_edit_drawinterface,'String'));
set(handles.color_prev_drawinterface,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_g_slider_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_g_slider_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_b_slider_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to color_b_slider_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_b_edit_drawinterface,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawinterface,'String'));
gvalue=str2double(get(handles.color_g_edit_drawinterface,'String'));
bvalue=str2double(get(handles.color_b_edit_drawinterface,'String'));
set(handles.color_prev_drawinterface,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_b_slider_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_b_slider_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in color_setcolor_drawinterface.
function color_setcolor_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to color_setcolor_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.color_r_edit_drawinterface,'String'));
gvalue=str2double(get(handles.color_g_edit_drawinterface,'String'));
bvalue=str2double(get(handles.color_b_edit_drawinterface,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.color_r_edit_drawinterface,'String',num2str(round(hcolor(1)*255)));
   set(handles.color_g_edit_drawinterface,'String',num2str(round(hcolor(2)*255)));
   set(handles.color_b_edit_drawinterface,'String',num2str(round(hcolor(3)*255)));
   set(handles.color_r_slider_drawinterface,'value',hcolor(1)*255);
   set(handles.color_g_slider_drawinterface,'value',hcolor(2)*255);
   set(handles.color_b_slider_drawinterface,'value',hcolor(3)*255);
   set(handles.color_prev_drawinterface,'backgroundcolor',hcolor);
end


% --- Executes on button press in define_rb2_drawinterface.
function define_rb2_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to define_rb2_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(hObject,'userdata');
if isempty(temp) temp={1,1,1,0,0,0,'Outside color:','Inside color:','Figuretool2: drawinterface'}; end
h0=bicolordef('userdata',temp);
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if strcmpi(temp,'cancelled') return; end
set(hObject,'userdata',temp);


% --- Executes on button press in define_rb3_drawinterface.
function define_rb3_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to define_rb3_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function xmin_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to xmin_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end

% Hints: get(hObject,'String') returns contents of xmin_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of xmin_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function xmin_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmin_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function xmax_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to xmax_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of xmax_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of xmax_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function xmax_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmax_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function ymin_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to ymin_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of ymin_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of ymin_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function ymin_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymin_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function ymax_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to ymax_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of ymax_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of ymax_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function ymax_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymax_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function zmin_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to zmin_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of zmin_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of zmin_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function zmin_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmin_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function zmax_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to zmax_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of zmax_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of zmax_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function zmax_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmax_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function fcnhdl_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to fcnhdl_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fcnhdl_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of fcnhdl_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function fcnhdl_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fcnhdl_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in fc_drawinterface.
function fc_drawinterface_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in fc_drawinterface
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_fc_drawinterface')
   set(handles.color_r_edit_drawinterface,'enable','on');
   set(handles.color_g_edit_drawinterface,'enable','on');
   set(handles.color_b_edit_drawinterface,'enable','on');
   set(handles.color_r_slider_drawinterface,'enable','on');
   set(handles.color_g_slider_drawinterface,'enable','on');
   set(handles.color_b_slider_drawinterface,'enable','on');
   set(handles.color_setcolor_drawinterface,'enable','on');
   set(handles.define_rb2_drawinterface,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_fc_drawinterface')
   set(handles.color_r_edit_drawinterface,'enable','off');
   set(handles.color_g_edit_drawinterface,'enable','off');
   set(handles.color_b_edit_drawinterface,'enable','off');
   set(handles.color_r_slider_drawinterface,'enable','off');
   set(handles.color_g_slider_drawinterface,'enable','off');
   set(handles.color_b_slider_drawinterface,'enable','off');
   set(handles.color_setcolor_drawinterface,'enable','off');
   set(handles.define_rb2_drawinterface,'enable','on');
end


function site1_edit_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to site1_edit_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of site1_edit_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of site1_edit_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function site1_edit_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to site1_edit_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in site1_gredit_drawinterface.
function site1_gredit_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to site1_gredit_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.site1_edit_drawinterface,'string');
[stackin,reflistin,status]=siterefparser(temp);
if status==0 h0=groupeditor;
else h0=groupeditor('userdata',{temp,stackin,reflistin});
end
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if strcmpi(temp,'cancelled') return; end
set(handles.site1_edit_drawinterface,'string',temp);


function site2_edit_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to site2_edit_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of site2_edit_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of site2_edit_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function site2_edit_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to site2_edit_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in site2_gredit_drawinterface.
function site2_gredit_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to site2_gredit_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.site2_edit_drawinterface,'string');
[stackin,reflistin,status]=siterefparser(temp);
if status==0 h0=groupeditor;
else h0=groupeditor('userdata',{temp,stackin,reflistin});
end
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if strcmpi(temp,'cancelled') return; end
set(handles.site2_edit_drawinterface,'string',temp);


function cexp1_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to cexp1_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'string'));
if isnan(value)||value<=0 set(hObject,'string','2.5'); waitfor(msgbox('Please enter a number greater than 0.','Figuretool2')); 
end
% Hints: get(hObject,'String') returns contents of cexp1_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of cexp1_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function cexp1_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cexp1_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cexp2_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to cexp2_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'string'));
if isnan(value)||value<=0 set(hObject,'string','2.5'); waitfor(msgbox('Please enter a number greater than 0.','Figuretool2')); 
end
% Hints: get(hObject,'String') returns contents of cexp2_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of cexp2_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function cexp2_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cexp2_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function radius_drawinterface_Callback(hObject, eventdata, handles)
% hObject    handle to radius_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'string'));
if isnan(value)||value<=0 set(hObject,'string','6.0'); waitfor(msgbox('Please enter a number greater than 0.','Figuretool2')); 
end
% Hints: get(hObject,'String') returns contents of radius_drawinterface as text
%        str2double(get(hObject,'String')) returns contents of radius_drawinterface as a double


% --- Executes during object creation, after setting all properties.
function radius_drawinterface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius_drawinterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
