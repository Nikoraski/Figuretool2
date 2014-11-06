function varargout = drawchannel(varargin)
% DRAWCHANNEL MATLAB code for drawchannel.fig
%      DRAWCHANNEL, by itself, creates a new DRAWCHANNEL or raises the existing
%      singleton*.
%
%      H = DRAWCHANNEL returns the handle to a new DRAWCHANNEL or the handle to
%      the existing singleton*.
%
%      DRAWCHANNEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWCHANNEL.M with the given input arguments.
%
%      DRAWCHANNEL('Property','Value',...) creates a new DRAWCHANNEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drawchannel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drawchannel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drawchannel

% Last Modified by GUIDE v2.5 14-Oct-2014 16:54:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @drawchannel_OpeningFcn, ...
   'gui_OutputFcn',  @drawchannel_OutputFcn, ...
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


% --- Executes just before drawchannel is made visible.
function drawchannel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawchannel (see VARARGIN)
global globalfl globallp;
% Choose default command line output for drawchannel
handles.output = hObject;
if isempty(get(hObject,'Userdata'))
   st0=struct('function','drawchannel','r','vdw 1.0','sc',[0.5,0.5,0.5],'sa',1,'rn',[0,1,0,1,0,1],...
      'sm','on','sms',3,'smd',0.65,'fl',globalfl,'lp',globallp,'res','default');
   set(hObject,'Userdata',st0);
else
   st0=get(hObject,'Userdata');
   if numel(st0.sc)==3
      set(handles.rb1_fc_drawchannel,'value',1);
      hcolor=st0.sc;
      set(handles.color_r_edit_drawchannel,'String',num2str(round(hcolor(1)*255)));
      set(handles.color_g_edit_drawchannel,'String',num2str(round(hcolor(2)*255)));
      set(handles.color_b_edit_drawchannel,'String',num2str(round(hcolor(3)*255)));
      set(handles.color_r_slider_drawchannel,'value',hcolor(1)*255);
      set(handles.color_g_slider_drawchannel,'value',hcolor(2)*255);
      set(handles.color_b_slider_drawchannel,'value',hcolor(3)*255);
      set(handles.color_prev_drawchannel,'backgroundcolor',hcolor);
   elseif numel(st0.sc)==6
      set(handles.rb2_fc_drawchannel,'value',1);
      set(handles.color_r_edit_drawchannel,'enable','off');
      set(handles.color_g_edit_drawchannel,'enable','off');
      set(handles.color_b_edit_drawchannel,'enable','off');
      set(handles.color_r_slider_drawchannel,'enable','off');
      set(handles.color_g_slider_drawchannel,'enable','off');
      set(handles.color_b_slider_drawchannel,'enable','off');
      set(handles.color_setcolor_drawchannel,'enable','off');
      set(handles.define_rb2_drawchannel,'enable','on','userdata',[num2cell(st0.sc),{'Outside color:','Inside color:','Figuretool2: drawchannel'}]);
   end
   set(handles.alpha_slider_drawchannel,'value',st0.sa);
   set(handles.alpha_edit_drawchannel,'string',sprintf('%4.2f',st0.sa));
   set(handles.xmin_drawchannel,'string',num2str(st0.rn(1)));
   set(handles.xmax_drawchannel,'string',num2str(st0.rn(2)));
   set(handles.ymin_drawchannel,'string',num2str(st0.rn(3)));
   set(handles.ymax_drawchannel,'string',num2str(st0.rn(4)));
   set(handles.zmin_drawchannel,'string',num2str(st0.rn(5)));
   set(handles.zmax_drawchannel,'string',num2str(st0.rn(6)));
   if ischar(st0.r)
      temp=regexpi(st0.r,' ','split');
      switch(temp{1})
         case 'metallic', set(handles.radius_def_popup_drawchannel,'value',1);
         case 'atomic', set(handles.radius_def_popup_drawchannel,'value',2);
         case 'vdw', set(handles.radius_def_popup_drawchannel,'value',3);
      end
      set(handles.radius_def_edit_drawchannel,'string',temp{2});
   else
      set(handles.radius_rb2_drawchannel,'value',1);
      set(handles.radius_cus_drawchannel,'string',sprintf('%4.2f',st0.r));
      set(handles.radius_cus_drawchannel,'enable','on');
      set(handles.radius_def_popup_drawchannel,'enable','off');
      set(handles.radius_def_edit_drawchannel,'enable','off');
   end
   if strcmpi(st0.sm,'on')
      set(handles.sm_on_drawchannel,'value',1);
      set(handles.size_sm_drawchannel,'string',num2str(st0.sms));
      set(handles.dev_sm_drawchannel,'string',num2str(st0.smd));
   else
      set(handles.sm_on_drawchannel,'value',0);
      set(handles.size_sm_drawchannel,'enable','off');
      set(handles.dev_sm_drawchannel,'enable','off');
   end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drawchannel wait for user response (see UIRESUME)
% uiwait(handles.drawchannel);


% --- Outputs from this function are returned to the command line.
function varargout = drawchannel_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function iso0_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to iso0_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of iso0_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of iso0_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function iso0_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iso0_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function alpha_slider_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_slider_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.alpha_edit_drawchannel,'string',sprintf('%4.2f',value));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function alpha_slider_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_slider_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function alpha_edit_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_edit_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.alpha_slider_drawchannel,'value',value);
else set(hObject,'string','1.00'); set(handles.alpha_slider_drawchannel,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end

% Hints: get(hObject,'String') returns contents of alpha_edit_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of alpha_edit_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function alpha_edit_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_edit_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_drawchannel.
function OK_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to OK_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'UserData');
if get(handles.rb1_fc_drawchannel,'value')==1
   rvalue=get(handles.color_r_slider_drawchannel,'value');
   gvalue=get(handles.color_g_slider_drawchannel,'value');
   bvalue=get(handles.color_b_slider_drawchannel,'value');
   st0.sc=[rvalue,gvalue,bvalue]/255;
elseif get(handles.rb2_fc_drawchannel,'value')==1
   temp=get(handles.define_rb2_drawchannel,'userdata');
   if isempty(temp) waitfor(msgbox('Please specify the colors for drawing two-colored surfaces.','Figuretool2')); return; end
   st0.sc=cell2mat(temp(1:6));
end
st0.sa=get(handles.alpha_slider_drawchannel,'value');
xmin=str2double(get(handles.xmin_drawchannel,'string'));
xmax=str2double(get(handles.xmax_drawchannel,'string'));
ymin=str2double(get(handles.ymin_drawchannel,'string'));
ymax=str2double(get(handles.ymax_drawchannel,'string'));
zmin=str2double(get(handles.zmin_drawchannel,'string'));
zmax=str2double(get(handles.zmax_drawchannel,'string'));
if (xmin>=xmax)||(ymin>=ymax)||(zmin>=zmax) waitfor(msgbox('The lower bound of the range must be less than the upper bound.','Figuretool2')); return; end
st0.rn=[xmin,xmax,ymin,ymax,zmin,zmax];
if get(handles.sm_on_drawchannel,'value')==1
   st0.sm='on';
   st0.sms=str2double(get(handles.size_sm_drawchannel,'string'));
   st0.smd=str2double(get(handles.dev_sm_drawchannel,'string'));
else
   st0.sm='off';
end
if get(handles.radius_rb1_drawchannel,'value')==1
   switch get(handles.radius_def_popup_drawchannel,'value')
      case 1, temp='metallic ';
      case 2, temp='atomic ';
      case 3, temp='vdw ';
   end
   st0.r=[temp,get(handles.radius_def_edit_drawchannel,'string')];
else
   st0.r=str2double(get(handles.radius_cus_drawchannel,'string'));
end
set(get(hObject,'parent'),'userdata',st0);
uiresume;


% --- Executes on button press in cancel_drawchannel.
function cancel_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes on button press in advanced_drawchannel.
function advanced_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to advanced_drawchannel (see GCBO)
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

% --- Executes on button press in sm_on_drawchannel.
function sm_on_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to sm_on_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
   set(handles.size_sm_drawchannel,'enable','on');
   set(handles.dev_sm_drawchannel,'enable','on');
else
   set(handles.size_sm_drawchannel,'enable','off');
   set(handles.dev_sm_drawchannel,'enable','off');
end
% Hint: get(hObject,'Value') returns toggle state of sm_on_drawchannel



function size_sm_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to size_sm_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0)||(round(temp)~=temp) set(hObject,'string','3'); waitfor(msgbox('Please enter a positive integer.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of size_sm_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of size_sm_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function size_sm_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to size_sm_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function dev_sm_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to dev_sm_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0) set(hObject,'string','0.65'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of dev_sm_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of dev_sm_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function dev_sm_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dev_sm_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_r_edit_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to color_r_edit_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_r_slider_drawchannel,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawchannel,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawchannel,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawchannel,'String'));
   set(handles.color_prev_drawchannel,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_r_slider_drawchannel,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_r_slider_drawchannel,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_r_edit_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of color_r_edit_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function color_r_edit_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_r_edit_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_g_edit_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to color_g_edit_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_g_slider_drawchannel,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawchannel,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawchannel,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawchannel,'String'));
   set(handles.color_prev_drawchannel,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_g_slider_drawchannel,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_g_slider_drawchannel,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_g_edit_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of color_g_edit_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function color_g_edit_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_g_edit_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_b_edit_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to color_b_edit_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_b_slider_drawchannel,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawchannel,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawchannel,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawchannel,'String'));
   set(handles.color_prev_drawchannel,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_b_slider_drawchannel,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_b_slider_drawchannel,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_b_edit_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of color_b_edit_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function color_b_edit_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_b_edit_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function color_r_slider_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to color_r_slider_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_r_edit_drawchannel,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawchannel,'String'));
gvalue=str2double(get(handles.color_g_edit_drawchannel,'String'));
bvalue=str2double(get(handles.color_b_edit_drawchannel,'String'));
set(handles.color_prev_drawchannel,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_r_slider_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_r_slider_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_g_slider_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to color_g_slider_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_g_edit_drawchannel,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawchannel,'String'));
gvalue=str2double(get(handles.color_g_edit_drawchannel,'String'));
bvalue=str2double(get(handles.color_b_edit_drawchannel,'String'));
set(handles.color_prev_drawchannel,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_g_slider_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_g_slider_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_b_slider_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to color_b_slider_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_b_edit_drawchannel,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawchannel,'String'));
gvalue=str2double(get(handles.color_g_edit_drawchannel,'String'));
bvalue=str2double(get(handles.color_b_edit_drawchannel,'String'));
set(handles.color_prev_drawchannel,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_b_slider_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_b_slider_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in color_setcolor_drawchannel.
function color_setcolor_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to color_setcolor_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.color_r_edit_drawchannel,'String'));
gvalue=str2double(get(handles.color_g_edit_drawchannel,'String'));
bvalue=str2double(get(handles.color_b_edit_drawchannel,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.color_r_edit_drawchannel,'String',num2str(round(hcolor(1)*255)));
   set(handles.color_g_edit_drawchannel,'String',num2str(round(hcolor(2)*255)));
   set(handles.color_b_edit_drawchannel,'String',num2str(round(hcolor(3)*255)));
   set(handles.color_r_slider_drawchannel,'value',hcolor(1)*255);
   set(handles.color_g_slider_drawchannel,'value',hcolor(2)*255);
   set(handles.color_b_slider_drawchannel,'value',hcolor(3)*255);
   set(handles.color_prev_drawchannel,'backgroundcolor',hcolor);
end


% --- Executes on button press in define_rb2_drawchannel.
function define_rb2_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to define_rb2_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(hObject,'userdata');
if isempty(temp) temp={1,1,1,0,0,0,'Outside color:','Inside color:','Figuretool2: drawchannel'}; end
h0=bicolordef('userdata',temp);
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if strcmpi(temp,'cancelled') return; end
set(hObject,'userdata',temp);


% --- Executes on button press in define_rb3_drawchannel.
function define_rb3_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to define_rb3_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function xmin_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to xmin_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end

% Hints: get(hObject,'String') returns contents of xmin_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of xmin_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function xmin_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmin_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function xmax_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to xmax_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of xmax_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of xmax_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function xmax_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmax_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function ymin_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to ymin_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of ymin_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of ymin_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function ymin_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymin_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function ymax_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to ymax_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of ymax_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of ymax_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function ymax_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymax_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function zmin_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to zmin_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of zmin_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of zmin_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function zmin_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmin_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function zmax_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to zmax_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of zmax_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of zmax_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function zmax_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmax_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in fc_drawchannel.
function fc_drawchannel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in fc_drawchannel
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_fc_drawchannel')
   set(handles.color_r_edit_drawchannel,'enable','on');
   set(handles.color_g_edit_drawchannel,'enable','on');
   set(handles.color_b_edit_drawchannel,'enable','on');
   set(handles.color_r_slider_drawchannel,'enable','on');
   set(handles.color_g_slider_drawchannel,'enable','on');
   set(handles.color_b_slider_drawchannel,'enable','on');
   set(handles.color_setcolor_drawchannel,'enable','on');
   set(handles.define_rb2_drawchannel,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_fc_drawchannel')
   set(handles.color_r_edit_drawchannel,'enable','off');
   set(handles.color_g_edit_drawchannel,'enable','off');
   set(handles.color_b_edit_drawchannel,'enable','off');
   set(handles.color_r_slider_drawchannel,'enable','off');
   set(handles.color_g_slider_drawchannel,'enable','off');
   set(handles.color_b_slider_drawchannel,'enable','off');
   set(handles.color_setcolor_drawchannel,'enable','off');
   set(handles.define_rb2_drawchannel,'enable','on');
end


% --- Executes on selection change in radius_def_popup_drawchannel.
function radius_def_popup_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to radius_def_popup_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns radius_def_popup_drawchannel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from radius_def_popup_drawchannel


% --- Executes during object creation, after setting all properties.
function radius_def_popup_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius_def_popup_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function radius_def_edit_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to radius_def_edit_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'string'));
if isnan(value)||value<=0 set(hObject,'string','1.0'); waitfor(msgbox('Please enter a number greater than 0.','Figuretool2')); 
end
% Hints: get(hObject,'String') returns contents of radius_def_edit_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of radius_def_edit_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function radius_def_edit_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius_def_edit_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function radius_cus_drawchannel_Callback(hObject, eventdata, handles)
% hObject    handle to radius_cus_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'string'));
if isnan(value)||value<=0 set(hObject,'string','1.0'); waitfor(msgbox('Please enter a number greater than 0.','Figuretool2')); 
end
% Hints: get(hObject,'String') returns contents of radius_cus_drawchannel as text
%        str2double(get(hObject,'String')) returns contents of radius_cus_drawchannel as a double


% --- Executes during object creation, after setting all properties.
function radius_cus_drawchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius_cus_drawchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in radius_drawchannel.
function radius_drawchannel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in radius_drawchannel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'Tag'),'radius_rb1_drawchannel')
   set(handles.radius_def_popup_drawchannel,'enable','on');
   set(handles.radius_def_edit_drawchannel,'enable','on');
   set(handles.radius_cus_drawchannel,'enable','off');
else
   set(handles.radius_def_popup_drawchannel,'enable','off');
   set(handles.radius_def_edit_drawchannel,'enable','off');
   set(handles.radius_cus_drawchannel,'enable','on');
end

