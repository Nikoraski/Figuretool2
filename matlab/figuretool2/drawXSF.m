function varargout = drawXSF(varargin)
% DRAWXSF MATLAB code for drawXSF.fig
%      DRAWXSF, by itself, creates a new DRAWXSF or raises the existing
%      singleton*.
%
%      H = DRAWXSF returns the handle to a new DRAWXSF or the handle to
%      the existing singleton*.
%
%      DRAWXSF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWXSF.M with the given input arguments.
%
%      DRAWXSF('Property','Value',...) creates a new DRAWXSF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drawXSF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drawXSF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drawXSF

% Last Modified by GUIDE v2.5 13-Oct-2014 21:43:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @drawXSF_OpeningFcn, ...
   'gui_OutputFcn',  @drawXSF_OutputFcn, ...
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


% --- Executes just before drawXSF is made visible.
function drawXSF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawXSF (see VARARGIN)
global globalfl globallp;
% Choose default command line output for drawXSF
handles.output = hObject;
if isempty(get(hObject,'Userdata'))
   st0=struct('function','drawXSF','iso',0,'sc',[0.5,0.5,0.5],'sa',1,'rn',[0,1,0,1,0,1],...
      'sm','on','sms',3,'smd',0.65,'sec','off','secc',[0.8,0.8,0.8],'seca',1,'fl',globalfl,'lp',globallp,'res','default');
   set(hObject,'Userdata',st0);
else
   st0=get(hObject,'Userdata');
   if numel(st0.iso)==1
      set(handles.rb1_iso_drawXSF,'value',1);
      set(handles.iso0_drawXSF,'string',num2str(st0.iso));
   else
      set(handles.rb2_iso_drawXSF,'value',1);
      set(handles.isomin_drawXSF,'enable','on','string',num2str(st0.iso(1)));
      set(handles.isomax_drawXSF,'enable','on','string',num2str(st0.iso(2)));
      set(handles.iso0_drawXSF,'enable','off');
   end
   if numel(st0.sc)==3
      set(handles.rb1_fc_drawXSF,'value',1);
      hcolor=st0.sc;
      set(handles.color_r_edit_drawXSF,'String',num2str(round(hcolor(1)*255)));
      set(handles.color_g_edit_drawXSF,'String',num2str(round(hcolor(2)*255)));
      set(handles.color_b_edit_drawXSF,'String',num2str(round(hcolor(3)*255)));
      set(handles.color_r_slider_drawXSF,'value',hcolor(1)*255);
      set(handles.color_g_slider_drawXSF,'value',hcolor(2)*255);
      set(handles.color_b_slider_drawXSF,'value',hcolor(3)*255);
      set(handles.color_prev_drawXSF,'backgroundcolor',hcolor);
   elseif numel(st0.sc)==6
      set(handles.rb2_fc_drawXSF,'value',1);
      set(handles.color_r_edit_drawXSF,'enable','off');
      set(handles.color_g_edit_drawXSF,'enable','off');
      set(handles.color_b_edit_drawXSF,'enable','off');
      set(handles.color_r_slider_drawXSF,'enable','off');
      set(handles.color_g_slider_drawXSF,'enable','off');
      set(handles.color_b_slider_drawXSF,'enable','off');
      set(handles.color_setcolor_drawXSF,'enable','off');
      set(handles.define_rb2_drawXSF,'enable','on','userdata',[num2cell(st0.sc),{'Positive side/outside color:','Negative side/inside color:','Figuretool2: drawXSF'}]);
   end
   set(handles.alpha_slider_drawXSF,'value',st0.sa);
   set(handles.alpha_edit_drawXSF,'string',sprintf('%4.2f',st0.sa));
   set(handles.xmin_drawXSF,'string',num2str(st0.rn(1)));
   set(handles.xmax_drawXSF,'string',num2str(st0.rn(2)));
   set(handles.ymin_drawXSF,'string',num2str(st0.rn(3)));
   set(handles.ymax_drawXSF,'string',num2str(st0.rn(4)));
   set(handles.zmin_drawXSF,'string',num2str(st0.rn(5)));
   set(handles.zmax_drawXSF,'string',num2str(st0.rn(6)));
   if strcmpi(st0.sec,'on')
      set(handles.sec_on_drawXSF,'value',1);
      hcolor=st0.secc;
      set(handles.secc_r_edit_drawXSF,'enable','on','string',num2str(round(hcolor(1)*255)));
      set(handles.secc_g_edit_drawXSF,'enable','on','string',num2str(round(hcolor(2)*255)));
      set(handles.secc_b_edit_drawXSF,'enable','on','string',num2str(round(hcolor(3)*255)));
      set(handles.secc_r_slider_drawXSF,'enable','on','value',hcolor(1)*255);
      set(handles.secc_g_slider_drawXSF,'enable','on','value',hcolor(2)*255);
      set(handles.secc_b_slider_drawXSF,'enable','on','value',hcolor(3)*255);
      set(handles.secc_setcolor_drawXSF,'enable','on');
      set(handles.secc_prev_drawXSF,'backgroundcolor',hcolor);
      set(handles.seca_edit_drawXSF,'enable','on','string',sprintf('%4.2f',st0.seca));
      set(handles.seca_slider_drawXSF,'enable','on','value',st0.seca);
   end
   if strcmpi(st0.sm,'on')
      set(handles.sm_on_drawXSF,'value',1);
      set(handles.size_sm_drawXSF,'string',num2str(st0.sms));
      set(handles.dev_sm_drawXSF,'string',num2str(st0.smd));
   else
      set(handles.sm_on_drawXSF,'value',0);
      set(handles.size_sm_drawXSF,'enable','off');
      set(handles.dev_sm_drawXSF,'enable','off');
   end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drawXSF wait for user response (see UIRESUME)
% uiwait(handles.drawXSF);


% --- Outputs from this function are returned to the command line.
function varargout = drawXSF_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function iso0_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to iso0_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of iso0_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of iso0_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function iso0_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iso0_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function alpha_slider_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.alpha_edit_drawXSF,'string',sprintf('%4.2f',value));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function alpha_slider_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function alpha_edit_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.alpha_slider_drawXSF,'value',value);
else set(hObject,'string','1.00'); set(handles.alpha_slider_drawXSF,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end

% Hints: get(hObject,'String') returns contents of alpha_edit_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of alpha_edit_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function alpha_edit_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_drawXSF.
function OK_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to OK_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'UserData');
if get(handles.rb1_iso_drawXSF,'value')==1 st0.iso=str2double(get(handles.iso0_drawXSF,'string'));
else
   temp1=str2double(get(handles.isomin_drawXSF,'string'));
   temp2=str2double(get(handles.isomax_drawXSF,'string'));
   if temp1>=temp2 waitfor(msgbox('The lower bound of isolevel must be less than the upper bound.','Figuretool2')); return; end
   st0.iso=[temp1,temp2];
end
if get(handles.rb1_fc_drawXSF,'value')==1
   rvalue=get(handles.color_r_slider_drawXSF,'value');
   gvalue=get(handles.color_g_slider_drawXSF,'value');
   bvalue=get(handles.color_b_slider_drawXSF,'value');
   st0.sc=[rvalue,gvalue,bvalue]/255;
elseif get(handles.rb2_fc_drawXSF,'value')==1
   temp=get(handles.define_rb2_drawXSF,'userdata');
   if isempty(temp) waitfor(msgbox('Please specify the colors for drawing two-colored surfaces.','Figuretool2')); return; end
   st0.sc=cell2mat(temp(1:6));
end
st0.sa=get(handles.alpha_slider_drawXSF,'value');
xmin=str2double(get(handles.xmin_drawXSF,'string'));
xmax=str2double(get(handles.xmax_drawXSF,'string'));
ymin=str2double(get(handles.ymin_drawXSF,'string'));
ymax=str2double(get(handles.ymax_drawXSF,'string'));
zmin=str2double(get(handles.zmin_drawXSF,'string'));
zmax=str2double(get(handles.zmax_drawXSF,'string'));
if (xmin>=xmax)||(ymin>=ymax)||(zmin>=zmax) waitfor(msgbox('The lower bound of the range must be less than the upper bound.','Figuretool2')); return; end
st0.rn=[xmin,xmax,ymin,ymax,zmin,zmax];
if get(handles.sm_on_drawXSF,'value')==1
   st0.sm='on';
   st0.sms=str2double(get(handles.size_sm_drawXSF,'string'));
   st0.smd=str2double(get(handles.dev_sm_drawXSF,'string'));
else
   st0.sm='off';
end
if get(handles.sec_on_drawXSF,'value')==1
   st0.sec='on';
   rvalue=get(handles.secc_r_slider_drawXSF,'value');
   gvalue=get(handles.secc_g_slider_drawXSF,'value');
   bvalue=get(handles.secc_b_slider_drawXSF,'value');
   st0.secc=[rvalue,gvalue,bvalue]/255;
   st0.seca=get(handles.seca_slider_drawXSF,'value');
else
   st0.sec='off';
end
set(get(hObject,'parent'),'userdata',st0);
uiresume;


% --- Executes on button press in cancel_drawXSF.
function cancel_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes on button press in advanced_drawXSF.
function advanced_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to advanced_drawXSF (see GCBO)
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

% --- Executes on button press in sm_on_drawXSF.
function sm_on_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to sm_on_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
   set(handles.size_sm_drawXSF,'enable','on');
   set(handles.dev_sm_drawXSF,'enable','on');
else
   set(handles.size_sm_drawXSF,'enable','off');
   set(handles.dev_sm_drawXSF,'enable','off');
end
% Hint: get(hObject,'Value') returns toggle state of sm_on_drawXSF



function size_sm_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to size_sm_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0)||(round(temp)~=temp) set(hObject,'string','3'); waitfor(msgbox('Please enter a positive integer.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of size_sm_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of size_sm_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function size_sm_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to size_sm_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function dev_sm_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to dev_sm_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0) set(hObject,'string','0.65'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of dev_sm_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of dev_sm_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function dev_sm_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dev_sm_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_r_edit_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to color_r_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_r_slider_drawXSF,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawXSF,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawXSF,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawXSF,'String'));
   set(handles.color_prev_drawXSF,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_r_slider_drawXSF,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_r_slider_drawXSF,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_r_edit_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of color_r_edit_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function color_r_edit_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_r_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_g_edit_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to color_g_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_g_slider_drawXSF,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawXSF,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawXSF,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawXSF,'String'));
   set(handles.color_prev_drawXSF,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_g_slider_drawXSF,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_g_slider_drawXSF,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_g_edit_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of color_g_edit_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function color_g_edit_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_g_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_b_edit_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to color_b_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_b_slider_drawXSF,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawXSF,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawXSF,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawXSF,'String'));
   set(handles.color_prev_drawXSF,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_b_slider_drawXSF,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_b_slider_drawXSF,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_b_edit_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of color_b_edit_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function color_b_edit_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_b_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function color_r_slider_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to color_r_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_r_edit_drawXSF,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawXSF,'String'));
gvalue=str2double(get(handles.color_g_edit_drawXSF,'String'));
bvalue=str2double(get(handles.color_b_edit_drawXSF,'String'));
set(handles.color_prev_drawXSF,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_r_slider_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_r_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_g_slider_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to color_g_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_g_edit_drawXSF,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawXSF,'String'));
gvalue=str2double(get(handles.color_g_edit_drawXSF,'String'));
bvalue=str2double(get(handles.color_b_edit_drawXSF,'String'));
set(handles.color_prev_drawXSF,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_g_slider_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_g_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_b_slider_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to color_b_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_b_edit_drawXSF,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawXSF,'String'));
gvalue=str2double(get(handles.color_g_edit_drawXSF,'String'));
bvalue=str2double(get(handles.color_b_edit_drawXSF,'String'));
set(handles.color_prev_drawXSF,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_b_slider_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_b_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in color_setcolor_drawXSF.
function color_setcolor_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to color_setcolor_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.color_r_edit_drawXSF,'String'));
gvalue=str2double(get(handles.color_g_edit_drawXSF,'String'));
bvalue=str2double(get(handles.color_b_edit_drawXSF,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.color_r_edit_drawXSF,'String',num2str(round(hcolor(1)*255)));
   set(handles.color_g_edit_drawXSF,'String',num2str(round(hcolor(2)*255)));
   set(handles.color_b_edit_drawXSF,'String',num2str(round(hcolor(3)*255)));
   set(handles.color_r_slider_drawXSF,'value',hcolor(1)*255);
   set(handles.color_g_slider_drawXSF,'value',hcolor(2)*255);
   set(handles.color_b_slider_drawXSF,'value',hcolor(3)*255);
   set(handles.color_prev_drawXSF,'backgroundcolor',hcolor);
end


% --- Executes on button press in define_rb2_drawXSF.
function define_rb2_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to define_rb2_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(hObject,'userdata');
if isempty(temp) temp={1,1,1,0,0,0,'Positive side/outside color:','Negative side/inside color:','Figuretool2: drawXSF'}; end
h0=bicolordef('userdata',temp);
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if strcmpi(temp,'cancelled') return; end
set(hObject,'userdata',temp);


% --- Executes on button press in define_rb3_drawXSF.
function define_rb3_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to define_rb3_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function xmin_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to xmin_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end

% Hints: get(hObject,'String') returns contents of xmin_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of xmin_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function xmin_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmin_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function xmax_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to xmax_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of xmax_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of xmax_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function xmax_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmax_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function ymin_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to ymin_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of ymin_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of ymin_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function ymin_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymin_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function ymax_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to ymax_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of ymax_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of ymax_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function ymax_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymax_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function zmin_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to zmin_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of zmin_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of zmin_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function zmin_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmin_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function zmax_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to zmax_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of zmax_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of zmax_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function zmax_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmax_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function fcnhdl_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to fcnhdl_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fcnhdl_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of fcnhdl_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function fcnhdl_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fcnhdl_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function isomin_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to isomin_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','-0.1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of isomin_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of isomin_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function isomin_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isomin_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function isomax_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to isomax_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string','0.1'); waitfor(msgbox('Please enter a real number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of isomax_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of isomax_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function isomax_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isomax_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in iso0_drawXSF.
function iso_drawXSF_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in iso0_drawXSF
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_iso_drawXSF')
   set(handles.iso0_drawXSF,'enable','on');
   set(handles.isomin_drawXSF,'enable','off');
   set(handles.isomax_drawXSF,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_iso_drawXSF')
   set(handles.iso0_drawXSF,'enable','off');
   set(handles.isomin_drawXSF,'enable','on');
   set(handles.isomax_drawXSF,'enable','on');
end


% --- Executes when selected object is changed in fc_drawXSF.
function fc_drawXSF_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in fc_drawXSF
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_fc_drawXSF')
   set(handles.color_r_edit_drawXSF,'enable','on');
   set(handles.color_g_edit_drawXSF,'enable','on');
   set(handles.color_b_edit_drawXSF,'enable','on');
   set(handles.color_r_slider_drawXSF,'enable','on');
   set(handles.color_g_slider_drawXSF,'enable','on');
   set(handles.color_b_slider_drawXSF,'enable','on');
   set(handles.color_setcolor_drawXSF,'enable','on');
   set(handles.define_rb2_drawXSF,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_fc_drawXSF')
   set(handles.color_r_edit_drawXSF,'enable','off');
   set(handles.color_g_edit_drawXSF,'enable','off');
   set(handles.color_b_edit_drawXSF,'enable','off');
   set(handles.color_r_slider_drawXSF,'enable','off');
   set(handles.color_g_slider_drawXSF,'enable','off');
   set(handles.color_b_slider_drawXSF,'enable','off');
   set(handles.color_setcolor_drawXSF,'enable','off');
   set(handles.define_rb2_drawXSF,'enable','on');
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


% --- Executes on button press in secc_setcolor_drawXSF.
function secc_setcolor_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to secc_setcolor_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.secc_r_edit_drawXSF,'String'));
gvalue=str2double(get(handles.secc_g_edit_drawXSF,'String'));
bvalue=str2double(get(handles.secc_b_edit_drawXSF,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.secc_r_edit_drawXSF,'String',num2str(round(hcolor(1)*255)));
   set(handles.secc_g_edit_drawXSF,'String',num2str(round(hcolor(2)*255)));
   set(handles.secc_b_edit_drawXSF,'String',num2str(round(hcolor(3)*255)));
   set(handles.secc_r_slider_drawXSF,'value',hcolor(1)*255);
   set(handles.secc_g_slider_drawXSF,'value',hcolor(2)*255);
   set(handles.secc_b_slider_drawXSF,'value',hcolor(3)*255);
   set(handles.secc_prev_drawXSF,'backgroundcolor',hcolor);
end

% --- Executes on slider movement.
function secc_b_slider_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to secc_b_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.secc_b_edit_drawXSF,'string',num2str(round(value)));
rvalue=str2double(get(handles.secc_r_edit_drawXSF,'String'));
gvalue=str2double(get(handles.secc_g_edit_drawXSF,'String'));
bvalue=str2double(get(handles.secc_b_edit_drawXSF,'String'));
set(handles.secc_prev_drawXSF,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function secc_b_slider_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secc_b_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function secc_g_slider_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to secc_g_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.secc_g_edit_drawXSF,'string',num2str(round(value)));
rvalue=str2double(get(handles.secc_r_edit_drawXSF,'String'));
gvalue=str2double(get(handles.secc_g_edit_drawXSF,'String'));
bvalue=str2double(get(handles.secc_b_edit_drawXSF,'String'));
set(handles.secc_prev_drawXSF,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function secc_g_slider_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secc_g_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function secc_r_slider_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to secc_r_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.secc_r_edit_drawXSF,'string',num2str(round(value)));
rvalue=str2double(get(handles.secc_r_edit_drawXSF,'String'));
gvalue=str2double(get(handles.secc_g_edit_drawXSF,'String'));
bvalue=str2double(get(handles.secc_b_edit_drawXSF,'String'));
set(handles.secc_prev_drawXSF,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function secc_r_slider_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secc_r_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function secc_b_edit_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to secc_b_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.secc_b_slider_drawXSF,'value',value);
   rvalue=str2double(get(handles.secc_r_edit_drawXSF,'String'));
   gvalue=str2double(get(handles.secc_g_edit_drawXSF,'String'));
   bvalue=str2double(get(handles.secc_b_edit_drawXSF,'String'));
   set(handles.secc_prev_drawXSF,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.secc_b_slider_drawXSF,'value');
   set(hObject,'string',num2str(round(value))); set(handles.secc_b_slider_drawXSF,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of secc_b_edit_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of secc_b_edit_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function secc_b_edit_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secc_b_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function secc_g_edit_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to secc_g_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.secc_g_slider_drawXSF,'value',value);
   rvalue=str2double(get(handles.secc_r_edit_drawXSF,'String'));
   gvalue=str2double(get(handles.secc_g_edit_drawXSF,'String'));
   bvalue=str2double(get(handles.secc_b_edit_drawXSF,'String'));
   set(handles.secc_prev_drawXSF,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.secc_g_slider_drawXSF,'value');
   set(hObject,'string',num2str(round(value))); set(handles.secc_g_slider_drawXSF,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of secc_g_edit_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of secc_g_edit_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function secc_g_edit_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secc_g_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function secc_r_edit_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to secc_r_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.secc_r_slider_drawXSF,'value',value);
   rvalue=str2double(get(handles.secc_r_edit_drawXSF,'String'));
   gvalue=str2double(get(handles.secc_g_edit_drawXSF,'String'));
   bvalue=str2double(get(handles.secc_b_edit_drawXSF,'String'));
   set(handles.secc_prev_drawXSF,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.secc_r_slider_drawXSF,'value');
   set(hObject,'string',num2str(round(value))); set(handles.secc_r_slider_drawXSF,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of secc_r_edit_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of secc_r_edit_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function secc_r_edit_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secc_r_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function seca_slider_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to seca_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.seca_edit_drawXSF,'string',sprintf('%4.2f',value));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function seca_slider_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seca_slider_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function seca_edit_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to seca_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.seca_slider_drawXSF,'value',value);
else set(hObject,'string','1.00'); set(handles.seca_slider_drawXSF,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of seca_edit_drawXSF as text
%        str2double(get(hObject,'String')) returns contents of seca_edit_drawXSF as a double


% --- Executes during object creation, after setting all properties.
function seca_edit_drawXSF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seca_edit_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sec_on_drawXSF.
function sec_on_drawXSF_Callback(hObject, eventdata, handles)
% hObject    handle to sec_on_drawXSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
   set(handles.secc_r_edit_drawXSF,'enable','on');
   set(handles.secc_g_edit_drawXSF,'enable','on');
   set(handles.secc_b_edit_drawXSF,'enable','on');
   set(handles.secc_r_slider_drawXSF,'enable','on');
   set(handles.secc_g_slider_drawXSF,'enable','on');
   set(handles.secc_b_slider_drawXSF,'enable','on');
   set(handles.secc_setcolor_drawXSF,'enable','on');
   set(handles.seca_edit_drawXSF,'enable','on');
   set(handles.seca_slider_drawXSF,'enable','on');
else
   set(handles.secc_r_edit_drawXSF,'enable','off');
   set(handles.secc_g_edit_drawXSF,'enable','off');
   set(handles.secc_b_edit_drawXSF,'enable','off');
   set(handles.secc_r_slider_drawXSF,'enable','off');
   set(handles.secc_g_slider_drawXSF,'enable','off');
   set(handles.secc_b_slider_drawXSF,'enable','off');
   set(handles.secc_setcolor_drawXSF,'enable','off');
   set(handles.seca_edit_drawXSF,'enable','off');
   set(handles.seca_slider_drawXSF,'enable','off');
end
% Hint: get(hObject,'Value') returns toggle state of sec_on_drawXSF
