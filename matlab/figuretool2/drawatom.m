function varargout = drawatom(varargin)
% DRAWATOM MATLAB code for drawatom.fig
%      DRAWATOM, by itself, creates a new DRAWATOM or raises the existing
%      singleton*.
%
%      H = DRAWATOM returns the handle to a new DRAWATOM or the handle to
%      the existing singleton*.
%
%      DRAWATOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWATOM.M with the given input arguments.
%
%      DRAWATOM('Property','Value',...) creates a new DRAWATOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drawatom_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drawatom_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drawatom

% Last Modified by GUIDE v2.5 30-Jul-2014 15:05:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @drawatom_OpeningFcn, ...
   'gui_OutputFcn',  @drawatom_OutputFcn, ...
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


% --- Executes just before drawatom is made visible.
function drawatom_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawatom (see VARARGIN)

% Choose default command line output for drawatom
global globallp globalfl;
handles.output = hObject;
if isempty(get(hObject,'Userdata'))
st0=struct('function','drawatom','site','','ac','default','aa',1.0,'r','metallic 0.25',...
   'o','off','ow',0.05,'oc',[1,1,1],'dl',[2,1],'fl',globalfl,'lp',globallp,'res','default');
set(hObject,'Userdata',st0);
else
   st0=get(hObject,'Userdata');
   set(handles.site_edit_drawatom,'string',st0.site);
   if isnumeric(st0.ac)
      set(handles.color_rb3_drawatom,'value',1);
      hcolor=st0.ac;
      set(handles.color_r_edit_drawatom,'String',num2str(round(hcolor(1)*255)));
      set(handles.color_g_edit_drawatom,'String',num2str(round(hcolor(2)*255)));
      set(handles.color_b_edit_drawatom,'String',num2str(round(hcolor(3)*255)));
      set(handles.color_r_slider_drawatom,'value',hcolor(1)*255);
      set(handles.color_g_slider_drawatom,'value',hcolor(2)*255);
      set(handles.color_b_slider_drawatom,'value',hcolor(3)*255);
      set(handles.color_prev_drawatom,'backgroundcolor',hcolor);
      set(handles.color_r_edit_drawatom,'enable','on');
      set(handles.color_g_edit_drawatom,'enable','on');
      set(handles.color_b_edit_drawatom,'enable','on');
      set(handles.color_r_slider_drawatom,'enable','on');
      set(handles.color_g_slider_drawatom,'enable','on');
      set(handles.color_b_slider_drawatom,'enable','on');
      set(handles.color_setcolor_drawatom,'enable','on');
   elseif iscell(st0.ac)
      set(handles.color_rb4_drawatom,'value',1);
      set(handles.color_mixed_define_drawatom,'enable','on','userdata',st0.ac);
   else
      switch st0.ac
         case 'default', set(handles.color_def_rb1_drawatom,'value',1);
         case 'light', set(handles.color_def_rb2_drawatom,'value',1);
         case 'dark', set(handles.color_def_rb3_drawatom,'value',1);
         case 'inverse', set(handles.color_def_rb4_drawatom,'value',1);
         case 'verylight', set(handles.color_def_rb5_drawatom,'value',1);
         case 'verydark', set(handles.color_def_rb6_drawatom,'value',1);
         case 'cpk', set(handles.color_rb2_drawatom,'value',1);
      end
   end
   if ~ischar(st0.ac)||~ismember(st0.ac,{'default','light','dark','inverse','verylight','verydark'})
      set(handles.color_def_rb1_drawatom,'enable','off');
      set(handles.color_def_rb2_drawatom,'enable','off');
      set(handles.color_def_rb3_drawatom,'enable','off');
      set(handles.color_def_rb4_drawatom,'enable','off');
      set(handles.color_def_rb5_drawatom,'enable','off');
      set(handles.color_def_rb6_drawatom,'enable','off');
   end
   set(handles.alpha_slider_drawatom,'value',st0.aa);
   set(handles.alpha_edit_drawatom,'string',sprintf('%4.2f',st0.aa));
   if ischar(st0.r)
      temp=regexpi(st0.r,' ','split');
      switch(temp{1})
         case 'metallic', set(handles.radius_def_popup_drawatom,'value',1);
         case 'atomic', set(handles.radius_def_popup_drawatom,'value',2);
         case 'vdw', set(handles.radius_def_popup_drawatom,'value',3);
      end
      set(handles.radius_def_edit_drawatom,'string',temp{2});
   else
      set(handles.radius_rb2_drawatom,'value',1);
      set(handles.radius_cus_drawatom,'string',sprintf('%4.2f',st0.r));
      set(handles.radius_cus_drawatom,'enable','on');
      set(handles.radius_def_popup_drawatom,'enable','off');
      set(handles.radius_def_edit_drawatom,'enable','off');
   end
   if ismember(st0.o,{'on','dashed'})
      set(handles.ol_on_drawatom,'value',1);
      if strcmp(st0.o,'dashed')
         set(handles.ol_rb2_drawatom,'value',1);
         set(handles.ol_dl1_drawatom,'enable','on');
         set(handles.ol_dl2_drawatom,'enable','on');
      end
      set(handles.ol_width_drawatom,'enable','on');
      set(handles.ol_rb1_drawatom,'enable','on');
      set(handles.ol_rb2_drawatom,'enable','on');
      set(handles.ol_r_edit_drawatom,'enable','on');
      set(handles.ol_g_edit_drawatom,'enable','on');
      set(handles.ol_b_edit_drawatom,'enable','on');
      set(handles.ol_r_slider_drawatom,'enable','on');
      set(handles.ol_g_slider_drawatom,'enable','on');
      set(handles.ol_b_slider_drawatom,'enable','on');
      set(handles.ol_setcolor_drawatom,'enable','on');
   end
   set(handles.ol_width_drawatom,'string',sprintf('%4.2f',st0.ow));
   set(handles.ol_dl1_drawatom,'string',num2str(st0.dl(1)));
   set(handles.ol_dl2_drawatom,'string',num2str(st0.dl(2)));
   hcolor=st0.oc;
   set(handles.ol_r_edit_drawatom,'String',num2str(round(hcolor(1)*255)));
   set(handles.ol_g_edit_drawatom,'String',num2str(round(hcolor(2)*255)));
   set(handles.ol_b_edit_drawatom,'String',num2str(round(hcolor(3)*255)));
   set(handles.ol_r_slider_drawatom,'value',hcolor(1)*255);
   set(handles.ol_g_slider_drawatom,'value',hcolor(2)*255);
   set(handles.ol_b_slider_drawatom,'value',hcolor(3)*255);
   set(handles.ol_prev_drawatom,'backgroundcolor',hcolor);
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drawatom wait for user response (see UIRESUME)
% uiwait(handles.drawatom);


% --- Outputs from this function are returned to the command line.
function varargout = drawatom_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function site_edit_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to site_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of site_edit_drawatom as text
%        str2double(get(hObject,'String')) returns contents of site_edit_drawatom as a double


% --- Executes during object creation, after setting all properties.
function site_edit_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to site_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in OK_drawatom.
function OK_drawatom_Callback(hObject, eventdata, handles)
temp=get(handles.site_edit_drawatom,'string');
if isempty(temp) waitfor(msgbox('Please specify the atoms you wish to draw.','Figuretool2')); return; end
[stackin,~,status]=siterefparser(temp);
if (status==0)||~strcmp(stackin,'B') waitfor(msgbox('The specified atom group is invalid.','Figuretool2')); return; end
st0=get(get(hObject,'parent'),'UserData');
st0.site=temp;
switch get(get(handles.color_drawatom,'selectedobject'),'tag')
   case 'color_rb1_drawatom'
      switch get(get(handles.color_def_drawatom,'selectedobject'),'tag')
         case 'color_def_rb1_drawatom', st0.ac='default';
         case 'color_def_rb2_drawatom', st0.ac='light';
         case 'color_def_rb3_drawatom', st0.ac='dark';
         case 'color_def_rb4_drawatom', st0.ac='inverse';
         case 'color_def_rb5_drawatom', st0.ac='verylight';
         case 'color_def_rb6_drawatom', st0.ac='verydark';
      end
   case 'color_rb2_drawatom', st0.ac='cpk';
   case 'color_rb3_drawatom'
      rvalue=get(handles.color_r_slider_drawatom,'value');
      gvalue=get(handles.color_g_slider_drawatom,'value');
      bvalue=get(handles.color_b_slider_drawatom,'value');
      st0.ac=[rvalue,gvalue,bvalue]/255;
   case 'color_rb4_drawatom', st0.ac=get(handles.color_mixed_define_drawatom,'userdata');
end
st0.aa=get(handles.alpha_slider_drawatom,'value');
switch get(get(handles.radius_drawatom,'selectedobject'),'tag')
   case 'radius_rb1_drawatom'
      switch get(handles.radius_def_popup_drawatom,'value')
         case 1, temp='metallic ';
         case 2, temp='atomic ';
         case 3, temp='vdw ';
      end
      st0.r=[temp,get(handles.radius_def_edit_drawatom,'string')];
   case 'radius_rb2_drawatom'
      st0.r=str2double(get(handles.radius_cus_drawatom,'string'));
end
if get(handles.ol_on_drawatom,'value')==0 st0.o='off';
elseif get(handles.ol_rb2_drawatom,'value')==1 st0.o='dashed';
else st0.o='on';
end
st0.ow=str2double(get(handles.ol_width_drawatom,'string'));
st0.dl=[str2double(get(handles.ol_dl1_drawatom,'string')),str2double(get(handles.ol_dl2_drawatom,'string'))];
rvalue=get(handles.ol_r_slider_drawatom,'value');
gvalue=get(handles.ol_g_slider_drawatom,'value');
bvalue=get(handles.ol_b_slider_drawatom,'value');
st0.oc=[rvalue,gvalue,bvalue]/255;
set(get(hObject,'parent'),'Userdata',st0);
uiresume;
% hObject    handle to OK_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cancel_drawatom.
function cancel_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes on button press in site_gredit_drawatom.
function site_gredit_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to site_gredit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.site_edit_drawatom,'string');
[stackin,reflistin,status]=siterefparser(temp);
if status==0 h0=groupeditor;
else h0=groupeditor('userdata',{temp,stackin,reflistin});
end
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if strcmpi(temp,'cancelled') return; end
set(handles.site_edit_drawatom,'string',temp);


function color_r_edit_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to color_r_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_r_slider_drawatom,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawatom,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawatom,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawatom,'String'));
   set(handles.color_prev_drawatom,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.color_r_slider_drawatom,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_r_slider_drawatom,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end


% --- Executes during object creation, after setting all properties.
function color_r_edit_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_r_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_g_edit_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to color_g_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of color_g_edit_drawatom as text
%        str2double(get(hObject,'String')) returns contents of color_g_edit_drawatom as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_g_slider_drawatom,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawatom,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawatom,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawatom,'String'));
   set(handles.color_prev_drawatom,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.color_g_slider_drawatom,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_g_slider_drawatom,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function color_g_edit_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_g_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function color_b_edit_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to color_b_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of color_b_edit_drawatom as text
%        str2double(get(hObject,'String')) returns contents of color_b_edit_drawatom as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_b_slider_drawatom,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawatom,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawatom,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawatom,'String'));
   set(handles.color_prev_drawatom,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.color_b_slider_drawatom,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_b_slider_drawatom,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function color_b_edit_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_b_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in color_mixed_define_drawatom.
function color_mixed_define_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to color_mixed_define_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(hObject,'userdata');
if isempty(temp) h0=atomcolormix;
else h0=atomcolormix('userdata',temp);
end
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata')
delete(h0);
if strcmpi(temp,'cancelled') return;
else set(hObject,'userdata',temp);
end

% --- Executes on selection change in radius_def_popup_drawatom.
function radius_def_popup_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to radius_def_popup_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns radius_def_popup_drawatom contents as cell array
%        contents{get(hObject,'Value')} returns selected item from radius_def_popup_drawatom


% --- Executes during object creation, after setting all properties.
function radius_def_popup_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius_def_popup_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function radius_def_edit_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to radius_def_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius_def_edit_drawatom as text
%        str2double(get(hObject,'String')) returns contents of radius_def_edit_drawatom as a double
value=str2double(get(hObject,'string'));
if isnan(value)||value<=0 set(hObject,'string','0.25'); waitfor(msgbox('Please enter a number greater than 0.','Figuretool2')); 
end

% --- Executes during object creation, after setting all properties.
function radius_def_edit_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius_def_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function radius_cus_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to radius_cus_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius_cus_drawatom as text
%        str2double(get(hObject,'String')) returns contents of radius_cus_drawatom as a double
value=str2double(get(hObject,'string'));
if isnan(value)||value<=0 set(hObject,'string','0.4'); waitfor(msgbox('Please enter a number greater than 0.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function radius_cus_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius_cus_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function color_r_slider_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to color_r_slider_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.color_r_edit_drawatom,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawatom,'String'));
gvalue=str2double(get(handles.color_g_edit_drawatom,'String'));
bvalue=str2double(get(handles.color_b_edit_drawatom,'String'));
set(handles.color_prev_drawatom,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% --- Executes during object creation, after setting all properties.
function color_r_slider_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_r_slider_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_g_slider_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to color_g_slider_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.color_g_edit_drawatom,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawatom,'String'));
gvalue=str2double(get(handles.color_g_edit_drawatom,'String'));
bvalue=str2double(get(handles.color_b_edit_drawatom,'String'));
set(handles.color_prev_drawatom,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% --- Executes during object creation, after setting all properties.
function color_g_slider_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_g_slider_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_b_slider_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to color_b_slider_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.color_b_edit_drawatom,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawatom,'String'));
gvalue=str2double(get(handles.color_g_edit_drawatom,'String'));
bvalue=str2double(get(handles.color_b_edit_drawatom,'String'));
set(handles.color_prev_drawatom,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% --- Executes during object creation, after setting all properties.
function color_b_slider_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_b_slider_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in color_setcolor_drawatom.
function color_setcolor_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to color_setcolor_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.color_r_edit_drawatom,'String'));
gvalue=str2double(get(handles.color_g_edit_drawatom,'String'));
bvalue=str2double(get(handles.color_b_edit_drawatom,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.color_r_edit_drawatom,'String',num2str(round(hcolor(1)*255)));
   set(handles.color_g_edit_drawatom,'String',num2str(round(hcolor(2)*255)));
   set(handles.color_b_edit_drawatom,'String',num2str(round(hcolor(3)*255)));
   set(handles.color_r_slider_drawatom,'value',hcolor(1)*255);
   set(handles.color_g_slider_drawatom,'value',hcolor(2)*255);
   set(handles.color_b_slider_drawatom,'value',hcolor(3)*255);
   set(handles.color_prev_drawatom,'backgroundcolor',hcolor);
end

% --- Executes on slider movement.
function alpha_slider_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_slider_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.alpha_edit_drawatom,'string',sprintf('%4.2f',value));

% --- Executes during object creation, after setting all properties.
function alpha_slider_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_slider_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function alpha_edit_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha_edit_drawatom as text
%        str2double(get(hObject,'String')) returns contents of alpha_edit_drawatom as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.alpha_slider_drawatom,'value',value);
else set(hObject,'string','1.00'); set(handles.alpha_slider_drawatom,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function alpha_edit_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in advanced_drawatom.
function advanced_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to advanced_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'Userdata');
h0=adv_settings('Userdata',{st0.lp,[0.6,0.6,0.9,10],st0.res,st0.fl});
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


% --- Executes on button press in ol_on_drawatom.
function ol_on_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to ol_on_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ol_on_drawatom
if get(hObject,'value')==1
   set(handles.ol_width_drawatom,'enable','on');
   set(handles.ol_rb1_drawatom,'enable','on');
   set(handles.ol_rb2_drawatom,'enable','on');
   set(handles.ol_r_edit_drawatom,'enable','on');
   set(handles.ol_g_edit_drawatom,'enable','on');
   set(handles.ol_b_edit_drawatom,'enable','on');
   set(handles.ol_r_slider_drawatom,'enable','on');
   set(handles.ol_g_slider_drawatom,'enable','on');
   set(handles.ol_b_slider_drawatom,'enable','on');
   set(handles.ol_setcolor_drawatom,'enable','on');
   if get(handles.ol_rb2_drawatom,'value')==1
      set(handles.ol_dl1_drawatom,'enable','on');
      set(handles.ol_dl2_drawatom,'enable','on');
   end
else
   set(handles.ol_width_drawatom,'enable','off');
   set(handles.ol_rb1_drawatom,'enable','off');
   set(handles.ol_rb2_drawatom,'enable','off');
   set(handles.ol_r_edit_drawatom,'enable','off');
   set(handles.ol_g_edit_drawatom,'enable','off');
   set(handles.ol_b_edit_drawatom,'enable','off');
   set(handles.ol_r_slider_drawatom,'enable','off');
   set(handles.ol_g_slider_drawatom,'enable','off');
   set(handles.ol_b_slider_drawatom,'enable','off');
   set(handles.ol_setcolor_drawatom,'enable','off');
   set(handles.ol_dl1_drawatom,'enable','off');
   set(handles.ol_dl2_drawatom,'enable','off');
end



function ol_width_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to ol_width_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ol_width_drawatom as text
%        str2double(get(hObject,'String')) returns contents of ol_width_drawatom as a double
value=str2double(get(hObject,'string'));
if isnan(value)||value<=0 set(hObject,'string','0.05'); waitfor(msgbox('Please enter a number greater than 0.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function ol_width_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_width_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function ol_r_edit_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to ol_r_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ol_r_edit_drawatom as text
%        str2double(get(hObject,'String')) returns contents of ol_r_edit_drawatom as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.ol_r_slider_drawatom,'value',value);
   rvalue=str2double(get(handles.ol_r_edit_drawatom,'String'));
   gvalue=str2double(get(handles.ol_g_edit_drawatom,'String'));
   bvalue=str2double(get(handles.ol_b_edit_drawatom,'String'));
   set(handles.ol_prev_drawatom,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.ol_r_slider_drawatom,'value');
   set(hObject,'string',num2str(round(value))); set(handles.ol_r_slider_drawatom,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function ol_r_edit_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_r_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function ol_g_edit_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to ol_g_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ol_g_edit_drawatom as text
%        str2double(get(hObject,'String')) returns contents of ol_g_edit_drawatom as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.ol_g_slider_drawatom,'value',value);
   rvalue=str2double(get(handles.ol_r_edit_drawatom,'String'));
   gvalue=str2double(get(handles.ol_g_edit_drawatom,'String'));
   bvalue=str2double(get(handles.ol_b_edit_drawatom,'String'));
   set(handles.ol_prev_drawatom,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.ol_g_slider_drawatom,'value');
   set(hObject,'string',num2str(round(value))); set(handles.ol_g_slider_drawatom,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function ol_g_edit_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_g_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function ol_b_edit_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to ol_b_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ol_b_edit_drawatom as text
%        str2double(get(hObject,'String')) returns contents of ol_b_edit_drawatom as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.ol_b_slider_drawatom,'value',value);
   rvalue=str2double(get(handles.ol_r_edit_drawatom,'String'));
   gvalue=str2double(get(handles.ol_g_edit_drawatom,'String'));
   bvalue=str2double(get(handles.ol_b_edit_drawatom,'String'));
   set(handles.ol_prev_drawatom,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.ol_b_slider_drawatom,'value');
   set(hObject,'string',num2str(round(value))); set(handles.ol_b_slider_drawatom,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function ol_b_edit_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_b_edit_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function ol_r_slider_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to ol_r_slider_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.ol_r_edit_drawatom,'string',num2str(round(value)));
rvalue=str2double(get(handles.ol_r_edit_drawatom,'String'));
gvalue=str2double(get(handles.ol_g_edit_drawatom,'String'));
bvalue=str2double(get(handles.ol_b_edit_drawatom,'String'));
set(handles.ol_prev_drawatom,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% --- Executes during object creation, after setting all properties.
function ol_r_slider_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_r_slider_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function ol_g_slider_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to ol_g_slider_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.ol_g_edit_drawatom,'string',num2str(round(value)));
rvalue=str2double(get(handles.ol_r_edit_drawatom,'String'));
gvalue=str2double(get(handles.ol_g_edit_drawatom,'String'));
bvalue=str2double(get(handles.ol_b_edit_drawatom,'String'));
set(handles.ol_prev_drawatom,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% --- Executes during object creation, after setting all properties.
function ol_g_slider_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_g_slider_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function ol_b_slider_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to ol_b_slider_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.ol_b_edit_drawatom,'string',num2str(round(value)));
rvalue=str2double(get(handles.ol_r_edit_drawatom,'String'));
gvalue=str2double(get(handles.ol_g_edit_drawatom,'String'));
bvalue=str2double(get(handles.ol_b_edit_drawatom,'String'));
set(handles.ol_prev_drawatom,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% --- Executes during object creation, after setting all properties.
function ol_b_slider_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_b_slider_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in ol_setcolor_drawatom.
function ol_setcolor_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to ol_setcolor_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.ol_r_edit_drawatom,'String'));
gvalue=str2double(get(handles.ol_g_edit_drawatom,'String'));
bvalue=str2double(get(handles.ol_b_edit_drawatom,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.ol_r_edit_drawatom,'String',num2str(round(hcolor(1)*255)));
   set(handles.ol_g_edit_drawatom,'String',num2str(round(hcolor(2)*255)));
   set(handles.ol_b_edit_drawatom,'String',num2str(round(hcolor(3)*255)));
   set(handles.ol_r_slider_drawatom,'value',hcolor(1)*255);
   set(handles.ol_g_slider_drawatom,'value',hcolor(2)*255);
   set(handles.ol_b_slider_drawatom,'value',hcolor(3)*255);
   set(handles.ol_prev_drawatom,'backgroundcolor',hcolor);
end

% --- Executes on button press in ol_rb1_drawatom.
function ol_rb1_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to ol_rb1_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ol_rb1_drawatom


% --- Executes on button press in ol_rb2_drawatom.
function ol_rb2_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to ol_rb2_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ol_rb2_drawatom



function ol_dl1_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to ol_dl1_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ol_dl1_drawatom as text
%        str2double(get(hObject,'String')) returns contents of ol_dl1_drawatom as a double
value=str2double(get(hObject,'string'));
if isnan(value)||value<=0||round(value)~=value set(hObject,'string','2'); waitfor(msgbox('Please enter a positive integer.','Figuretool2')); 
end

% --- Executes during object creation, after setting all properties.
function ol_dl1_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_dl1_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function ol_dl2_drawatom_Callback(hObject, eventdata, handles)
% hObject    handle to ol_dl2_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ol_dl2_drawatom as text
%        str2double(get(hObject,'String')) returns contents of ol_dl2_drawatom as a double
value=str2double(get(hObject,'string'));
if isnan(value)||value<=0||round(value)~=value set(hObject,'string','1'); waitfor(msgbox('Please enter a positive integer.','Figuretool2'));
end


% --- Executes during object creation, after setting all properties.
function ol_dl2_drawatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_dl2_drawatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in color_drawatom.
function color_drawatom_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in color_drawatom
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag')
   case 'color_rb1_drawatom'
      set(handles.color_def_rb1_drawatom,'enable','on');
      set(handles.color_def_rb2_drawatom,'enable','on');
      set(handles.color_def_rb3_drawatom,'enable','on');
      set(handles.color_def_rb4_drawatom,'enable','on');
      set(handles.color_def_rb5_drawatom,'enable','on');
      set(handles.color_def_rb6_drawatom,'enable','on');
   case 'color_rb3_drawatom'
      set(handles.color_r_edit_drawatom,'enable','on');
      set(handles.color_g_edit_drawatom,'enable','on');
      set(handles.color_b_edit_drawatom,'enable','on');
      set(handles.color_r_slider_drawatom,'enable','on');
      set(handles.color_g_slider_drawatom,'enable','on');
      set(handles.color_b_slider_drawatom,'enable','on');
      set(handles.color_setcolor_drawatom,'enable','on');
   case 'color_rb4_drawatom'
      set(handles.color_mixed_define_drawatom,'enable','on');
end
switch get(eventdata.OldValue,'Tag')
   case 'color_rb1_drawatom'
      set(handles.color_def_rb1_drawatom,'enable','off');
      set(handles.color_def_rb2_drawatom,'enable','off');
      set(handles.color_def_rb3_drawatom,'enable','off');
      set(handles.color_def_rb4_drawatom,'enable','off');
      set(handles.color_def_rb5_drawatom,'enable','off');
      set(handles.color_def_rb6_drawatom,'enable','off');
   case 'color_rb3_drawatom'
      set(handles.color_r_edit_drawatom,'enable','off');
      set(handles.color_g_edit_drawatom,'enable','off');
      set(handles.color_b_edit_drawatom,'enable','off');
      set(handles.color_r_slider_drawatom,'enable','off');
      set(handles.color_g_slider_drawatom,'enable','off');
      set(handles.color_b_slider_drawatom,'enable','off');
      set(handles.color_setcolor_drawatom,'enable','off');
   case 'color_rb4_drawatom'
      set(handles.color_mixed_define_drawatom,'enable','off');
end


% --- Executes when selected object is changed in radius_drawatom.
function radius_drawatom_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in radius_drawatom
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag')
   case 'radius_rb1_drawatom'
      set(handles.radius_def_popup_drawatom,'enable','on');
      set(handles.radius_def_edit_drawatom,'enable','on');
   case 'radius_rb2_drawatom'
      set(handles.radius_cus_drawatom,'enable','on');
end
switch get(eventdata.OldValue,'Tag')
   case 'radius_rb1_drawatom'
      set(handles.radius_def_popup_drawatom,'enable','off');
      set(handles.radius_def_edit_drawatom,'enable','off');
   case 'radius_rb2_drawatom'
      set(handles.radius_cus_drawatom,'enable','off');
end


% --- Executes when selected object is changed in ol_drawatom.
function ol_drawatom_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in ol_drawatom
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag')
   case 'ol_rb1_drawatom'
      set(handles.ol_dl1_drawatom,'enable','off');
      set(handles.ol_dl2_drawatom,'enable','off');
   case 'ol_rb2_drawatom'
      set(handles.ol_dl1_drawatom,'enable','on');
      set(handles.ol_dl2_drawatom,'enable','on');
end
