function varargout = drawCP(varargin)
% DRAWCP MATLAB code for drawCP.fig
%      DRAWCP, by itself, creates a new DRAWCP or raises the existing
%      singleton*.
%
%      H = DRAWCP returns the handle to a new DRAWCP or the handle to
%      the existing singleton*.
%
%      DRAWCP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWCP.M with the given input arguments.
%
%      DRAWCP('Property','Value',...) creates a new DRAWCP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drawCP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drawCP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drawCP

% Last Modified by GUIDE v2.5 24-Sep-2014 16:56:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @drawCP_OpeningFcn, ...
                   'gui_OutputFcn',  @drawCP_OutputFcn, ...
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


% --- Executes just before drawCP is made visible.
function drawCP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawCP (see VARARGIN)

% Choose default command line output for drawCP
global globallp globalfl;
handles.output = hObject;
if isempty(get(hObject,'Userdata'))
st0=struct('function','drawCP','site','','m','CP','lm','max','scale',100,'lc','default','la',1.00,'o','off',...
   'ow',0.05,'oc',[1,1,1],'fl',globalfl,'lp',globallp,'res','default');
set(hObject,'Userdata',st0);
else
   st0=get(hObject,'Userdata');
   set(handles.site_edit_drawCP,'string',st0.site);
   if strcmpi(st0.m,'CP') set(handles.rb1_m_drawCP,'value',1);
   else set(handles.rb2_m_drawCP,'value',1);
   end
   set(handles.edit_la_drawCP,'string',sprintf('%.2f',st0.la));
   set(handles.slider_la_drawCP,'value',st0.la);
   set(handles.scale_drawCP,'string',num2str(st0.scale));
   if strcmpi(st0.lm,'max') set(handles.lm_drawCP,'string','max'); else set(handles.lm_drawCP,'string',num2str(st0.lm)); end
   if isnumeric(st0.lc)
      set(handles.rb3_lc_drawCP,'value',1);
      set(handles.define_lc_drawCP,'enable','on','userdata',[num2cell(st0.lc),{'Color of positive lobe:','Color of negative lobe:','Figuretool2: drawCP'}]);
   elseif strcmpi(st0.lc,'colored')
      set(handles.rb2_lc_drawCP,'value',1);
   end
   if strcmpi(st0.o,'on')
      hcolor=st0.oc;
      set(handles.ol_on_drawCP,'value',1);
      set(handles.ow_drawCP,'enable','on','string',sprintf('%.2f',st0.ow));
      set(handles.edit_r_ol_drawCP,'enable','on','string',num2str(round(hcolor(1)*255)));
      set(handles.edit_g_ol_drawCP,'enable','on','string',num2str(round(hcolor(2)*255)));
      set(handles.edit_b_ol_drawCP,'enable','on','string',num2str(round(hcolor(3)*255)));
      set(handles.slider_r_ol_drawCP,'enable','on','value',hcolor(1)*255);
      set(handles.slider_g_ol_drawCP,'enable','on','value',hcolor(2)*255);
      set(handles.slider_b_ol_drawCP,'enable','on','value',hcolor(3)*255);
      set(handles.setcolor_ol_drawCP,'enable','on');
      set(handles.prev_ol_drawCP,'backgroundcolor',hcolor);
   end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drawCP wait for user response (see UIRESUME)
% uiwait(handles.drawCP);


% --- Outputs from this function are returned to the command line.
function varargout = drawCP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function site_edit_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to site_edit_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of site_edit_drawCP as text
%        str2double(get(hObject,'String')) returns contents of site_edit_drawCP as a double


% --- Executes during object creation, after setting all properties.
function site_edit_drawCP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to site_edit_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in site_gredit_drawCP.
function site_gredit_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to site_gredit_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.site_edit_drawCP,'string');
[stackin,reflistin,status]=siterefparser(temp);
if status==0 h0=groupeditor;
else h0=groupeditor('userdata',{temp,stackin,reflistin});
end
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if strcmpi(temp,'cancelled') return; end
set(handles.site_edit_drawCP,'string',temp);


function scale_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to scale_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scale_drawCP as text
%        str2double(get(hObject,'String')) returns contents of scale_drawCP as a double
temp=str2double(get(hObject,'String'));
if isnan(temp)||temp<=0 set(hObject,'string','100'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end


% --- Executes during object creation, after setting all properties.
function scale_drawCP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_drawCP.
function OK_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to OK_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.site_edit_drawCP,'string');
if isempty(temp) waitfor(msgbox('Please specify the atoms for CP lobe drawing.','Figuretool2')); return; end
[stackin,~,status]=siterefparser(temp);
if (status==0)||~strcmp(stackin,'B') waitfor(msgbox('The specified atom group is invalid.','Figuretool2')); return; end
st0=get(get(hObject,'parent'),'UserData');
st0.site=temp;
if get(handles.rb1_m_drawCP,'value')==1 st0.m='CP'; else st0.m='CM'; end
if get(handles.rb1_lc_drawCP,'value')==1 st0.lc='default';
elseif get(handles.rb2_lc_drawCP,'value')==1 st0.lc='colored';
else temp=get(handles.define_lc_drawCP,'userdata');
   if isempty(temp) waitfor(msgbox('Please specify the custom colors for positive and negative lobes.','Figuretool2')); return;
   else st0.lc=cell2mat(temp(1:6));
   end
end
st0.la=get(handles.slider_la_drawCP,'value');
st0.scale=str2double(get(handles.scale_drawCP,'string'));
if strcmpi(get(handles.lm_drawCP,'string'),'max') st0.lm='max';
else st0.lm=str2double(get(handles.lm_drawCP,'string'));
end
if get(handles.ol_on_drawCP,'value')==0 st0.o='off';
else
   st0.o='on';
   st0.ow=str2double(get(handles.ow_drawCP,'string'));
   rvalue=get(handles.slider_r_ol_drawCP,'value');
   gvalue=get(handles.slider_g_ol_drawCP,'value');
   bvalue=get(handles.slider_b_ol_drawCP,'value');
   st0.oc=[rvalue,gvalue,bvalue]/255;
end
set(get(hObject,'parent'),'userdata',st0);
uiresume;

% --- Executes on button press in cancel_drawCP.
function cancel_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes on button press in advanced_drawCP.
function advanced_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to advanced_drawCP (see GCBO)
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

% --- Executes on button press in ol_on_drawCP.
function ol_on_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to ol_on_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ol_on_drawCP
if get(hObject,'value')==1
   set(handles.ow_drawCP,'enable','on');
   set(handles.edit_r_ol_drawCP,'enable','on');
   set(handles.edit_g_ol_drawCP,'enable','on');
   set(handles.edit_b_ol_drawCP,'enable','on');
   set(handles.slider_r_ol_drawCP,'enable','on');
   set(handles.slider_g_ol_drawCP,'enable','on');
   set(handles.slider_b_ol_drawCP,'enable','on');
   set(handles.setcolor_ol_drawCP,'enable','on');
else
   set(handles.ow_drawCP,'enable','off');
   set(handles.edit_r_ol_drawCP,'enable','off');
   set(handles.edit_g_ol_drawCP,'enable','off');
   set(handles.edit_b_ol_drawCP,'enable','off');
   set(handles.slider_r_ol_drawCP,'enable','off');
   set(handles.slider_g_ol_drawCP,'enable','off');
   set(handles.slider_b_ol_drawCP,'enable','off');
   set(handles.setcolor_ol_drawCP,'enable','off');
end


function ow_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to ow_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ow_drawCP as text
%        str2double(get(hObject,'String')) returns contents of ow_drawCP as a double
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0) set(hObject,'string','0.05'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end

% --- Executes during object creation, after setting all properties.
function ow_drawCP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ow_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_r_ol_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_r_ol_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_r_ol_drawCP as text
%        str2double(get(hObject,'String')) returns contents of edit_r_ol_drawCP as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.slider_r_ol_drawCP,'value',value);
   rvalue=str2double(get(handles.edit_r_ol_drawCP,'String'));
   gvalue=str2double(get(handles.edit_g_ol_drawCP,'String'));
   bvalue=str2double(get(handles.edit_b_ol_drawCP,'String'));
   set(handles.prev_ol_drawCP,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.slider_r_ol_drawCP,'value');
   set(hObject,'string',num2str(round(value))); set(handles.slider_r_ol_drawCP,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit_r_ol_drawCP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_r_ol_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_g_ol_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_g_ol_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_g_ol_drawCP as text
%        str2double(get(hObject,'String')) returns contents of edit_g_ol_drawCP as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.slider_g_ol_drawCP,'value',value);
   rvalue=str2double(get(handles.edit_r_ol_drawCP,'String'));
   gvalue=str2double(get(handles.edit_g_ol_drawCP,'String'));
   bvalue=str2double(get(handles.edit_b_ol_drawCP,'String'));
   set(handles.prev_ol_drawCP,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.slider_g_ol_drawCP,'value');
   set(hObject,'string',num2str(round(value))); set(handles.slider_g_ol_drawCP,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit_g_ol_drawCP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_g_ol_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b_ol_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b_ol_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b_ol_drawCP as text
%        str2double(get(hObject,'String')) returns contents of edit_b_ol_drawCP as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.slider_b_ol_drawCP,'value',value);
   rvalue=str2double(get(handles.edit_r_ol_drawCP,'String'));
   gvalue=str2double(get(handles.edit_g_ol_drawCP,'String'));
   bvalue=str2double(get(handles.edit_b_ol_drawCP,'String'));
   set(handles.prev_ol_drawCP,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.slider_b_ol_drawCP,'value');
   set(hObject,'string',num2str(round(value))); set(handles.slider_b_ol_drawCP,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit_b_ol_drawCP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b_ol_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_r_ol_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to slider_r_ol_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit_r_ol_drawCP,'string',num2str(round(value)));
rvalue=str2double(get(handles.edit_r_ol_drawCP,'String'));
gvalue=str2double(get(handles.edit_g_ol_drawCP,'String'));
bvalue=str2double(get(handles.edit_b_ol_drawCP,'String'));
set(handles.prev_ol_drawCP,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% --- Executes during object creation, after setting all properties.
function slider_r_ol_drawCP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_r_ol_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_g_ol_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to slider_g_ol_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit_g_ol_drawCP,'string',num2str(round(value)));
rvalue=str2double(get(handles.edit_r_ol_drawCP,'String'));
gvalue=str2double(get(handles.edit_g_ol_drawCP,'String'));
bvalue=str2double(get(handles.edit_b_ol_drawCP,'String'));
set(handles.prev_ol_drawCP,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% --- Executes during object creation, after setting all properties.
function slider_g_ol_drawCP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_g_ol_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_b_ol_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to slider_b_ol_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit_b_ol_drawCP,'string',num2str(round(value)));
rvalue=str2double(get(handles.edit_r_ol_drawCP,'String'));
gvalue=str2double(get(handles.edit_g_ol_drawCP,'String'));
bvalue=str2double(get(handles.edit_b_ol_drawCP,'String'));
set(handles.prev_ol_drawCP,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% --- Executes during object creation, after setting all properties.
function slider_b_ol_drawCP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_b_ol_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in setcolor_ol_drawCP.
function setcolor_ol_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to setcolor_ol_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.edit_r_ol_drawCP,'String'));
gvalue=str2double(get(handles.edit_g_ol_drawCP,'String'));
bvalue=str2double(get(handles.edit_b_ol_drawCP,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.edit_r_ol_drawCP,'String',num2str(round(hcolor(1)*255)));
   set(handles.edit_g_ol_drawCP,'String',num2str(round(hcolor(2)*255)));
   set(handles.edit_b_ol_drawCP,'String',num2str(round(hcolor(3)*255)));
   set(handles.slider_r_ol_drawCP,'value',hcolor(1)*255);
   set(handles.slider_g_ol_drawCP,'value',hcolor(2)*255);
   set(handles.slider_b_ol_drawCP,'value',hcolor(3)*255);
   set(handles.prev_ol_drawCP,'backgroundcolor',hcolor);
end


% --- Executes on slider movement.
function slider_la_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to slider_la_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit_la_drawCP,'string',sprintf('%4.2f',value));

% --- Executes during object creation, after setting all properties.
function slider_la_drawCP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_la_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_la_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_la_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_la_drawCP as text
%        str2double(get(hObject,'String')) returns contents of edit_la_drawCP as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.slider_la_drawCP,'value',value);
else set(hObject,'string','1.00'); set(handles.slider_la_drawCP,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit_la_drawCP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_la_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lm_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to lm_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lm_drawCP as text
%        str2double(get(hObject,'String')) returns contents of lm_drawCP as a double
if strcmpi(get(hObject,'String'),'max') return;
else
   temp=str2double(get(hObject,'String'));
   if isnan(temp)||temp<0||(temp~=round(temp))
      set(hObject,'string','max');
      waitfor(msgbox('Please enter a non-negative integer, or ''max'' to use all coefficients in -coeff file.','Figuretool2'));
   end
end

% --- Executes during object creation, after setting all properties.
function lm_drawCP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lm_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in define_lc_drawCP.
function define_lc_drawCP_Callback(hObject, eventdata, handles)
% hObject    handle to define_lc_drawCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(hObject,'userdata');
if isempty(temp) temp={0.8,0.8,0.8,0,0,0,'Color of positive lobe:','Color of negative lobe:','Figuretool2: drawCP'}; end
h0=bicolordef('userdata',temp);
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
if strcmpi(temp,'cancelled') return; end
set(hObject,'userdata',temp);
delete(h0);

% --- Executes when selected object is changed in lc_drawCP.
function lc_drawCP_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in lc_drawCP 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.OldValue,'tag'),'rb3_lc_drawCP')
   set(handles.define_lc_drawCP,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb3_lc_drawCP')
   set(handles.define_lc_drawCP,'enable','on');
end
