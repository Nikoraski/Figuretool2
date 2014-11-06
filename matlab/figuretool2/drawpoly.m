function varargout = drawpoly(varargin)
% DRAWPOLY MATLAB code for drawpoly.fig
%      DRAWPOLY, by itself, creates a new DRAWPOLY or raises the existing
%      singleton*.
%
%      H = DRAWPOLY returns the handle to a new DRAWPOLY or the handle to
%      the existing singleton*.
%
%      DRAWPOLY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWPOLY.M with the given input arguments.
%
%      DRAWPOLY('Property','Value',...) creates a new DRAWPOLY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drawpoly_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drawpoly_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drawpoly

% Last Modified by GUIDE v2.5 30-Jul-2014 15:41:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @drawpoly_OpeningFcn, ...
   'gui_OutputFcn',  @drawpoly_OutputFcn, ...
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


% --- Executes just before drawpoly is made visible.
function drawpoly_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawpoly (see VARARGIN)

% Choose default command line output for drawpoly
global globallp globalfl;
handles.output = hObject;
if isempty(get(hObject,'Userdata'))
   st0=struct('function','drawpoly','site','','fc','default','fa',1.0,'dt',1.0,'o','off','ow',0.05,'oc',[1,1,1],'b','on','bc','default',...
      'rn','default','bw',0.15,'ba',1.0,'fl',globalfl,'lp',globallp,'res','default');
   set(hObject,'Userdata',st0);
else
   st0=get(hObject,'userdata');
   set(handles.site_edit_drawpoly,'string',st0.site);
   if isnumeric(st0.fc)
      hcolor=st0.fc;
      set(handles.rb2_fc_drawpoly,'value',1);
      set(handles.r_edit_fc_drawpoly,'enable','on','string',num2str(round(hcolor(1)*255)));
      set(handles.g_edit_fc_drawpoly,'enable','on','string',num2str(round(hcolor(2)*255)));
      set(handles.b_edit_fc_drawpoly,'enable','on','string',num2str(round(hcolor(3)*255)));
      set(handles.r_slider_fc_drawpoly,'enable','on','value',hcolor(1)*255);
      set(handles.g_slider_fc_drawpoly,'enable','on','value',hcolor(2)*255);
      set(handles.b_slider_fc_drawpoly,'enable','on','value',hcolor(3)*255);
      set(handles.setcolor_fc_drawpoly,'enable','on');
      set(handles.prev_fc_drawpoly,'backgroundcolor',hcolor);
   elseif iscell(st0.fc)
      set(handles.rb3_fc_drawpoly,'value',1);
      set(handles.define_fc_drawpoly,'enable','on','userdata',st0.fc);
   end
   set(handles.edit_fa_drawpoly,'string',sprintf('%.2f',st0.fa));
   set(handles.slider_fa_drawpoly,'value',st0.fa);
   set(handles.dt_drawpoly,'string',sprintf('%.1f',st0.dt));
   if strcmpi(st0.o,'on')
      hcolor=st0.oc;
      set(handles.ol_on_drawpoly,'value',1);
      set(handles.ow_drawpoly,'enable','on','string',sprintf('%.2f',st0.ow));
      set(handles.r_edit_ol_drawpoly,'enable','on','String',num2str(round(hcolor(1)*255)));
      set(handles.g_edit_ol_drawpoly,'enable','on','String',num2str(round(hcolor(2)*255)));
      set(handles.b_edit_ol_drawpoly,'enable','on','String',num2str(round(hcolor(3)*255)));
      set(handles.r_slider_ol_drawpoly,'enable','on','value',hcolor(1)*255);
      set(handles.g_slider_ol_drawpoly,'enable','on','value',hcolor(2)*255);
      set(handles.b_slider_ol_drawpoly,'enable','on','value',hcolor(3)*255);
      set(handles.setcolor_ol_drawpoly,'enable','on');
      set(handles.prev_ol_drawpoly,'backgroundcolor',hcolor);
   end
   if strcmpi(st0.b,'on')
      set(handles.b_on_drawpoly,'value',1);
      set(handles.rb1_bc_drawpoly,'enable','on');
      set(handles.rb2_bc_drawpoly,'enable','on');
      set(handles.rb3_bc_drawpoly,'enable','on');
      if isnumeric(st0.bc)
         hcolor=st0.bc;
         set(handles.rb2_bc_drawpoly,'value',1);
         set(handles.r_edit_bc_drawpoly,'enable','on','String',num2str(round(hcolor(1)*255)));
         set(handles.g_edit_bc_drawpoly,'enable','on','String',num2str(round(hcolor(2)*255)));
         set(handles.b_edit_bc_drawpoly,'enable','on','String',num2str(round(hcolor(3)*255)));
         set(handles.r_slider_bc_drawpoly,'enable','on','value',hcolor(1)*255);
         set(handles.g_slider_bc_drawpoly,'enable','on','value',hcolor(2)*255);
         set(handles.b_slider_bc_drawpoly,'enable','on','value',hcolor(3)*255);
         set(handles.setcolor_bc_drawpoly,'enable','on');
         set(handles.prev_bc_drawpoly,'backgroundcolor',hcolor);
      elseif strcmpi(st0.bc,'bicolored')
         set(handles.rb3_bc_drawpoly,'value',1);
      end
      set(handles.rb1_rn_drawpoly,'enable','on');
      set(handles.rb2_rn_drawpoly,'enable','on');
      if isnumeric(st0.rn)
         set(handles.rb2_rn_drawpoly,'value',1);
         set(handles.dmin_drawpoly,'enable','on','string',sprintf('%.2f',st0.rn(1)));
         set(handles.dmax_drawpoly,'enable','on','string',sprintf('%.2f',st0.rn(2)));
      end
      set(handles.bw_drawpoly,'enable','on','string',sprintf('%.2f',st0.bw));
      set(handles.slider_ba_drawpoly,'enable','on','string',sprintf('%.2f',st0.ba));
      set(handles.edit_ba_drawpoly,'enable','on','value',st0.ba);
   else
      set(handles.b_on_drawpoly,'value',0);
      set(handles.rb1_bc_drawpoly,'enable','off');
      set(handles.rb2_bc_drawpoly,'enable','off');
      set(handles.rb3_bc_drawpoly,'enable','off');
      set(handles.rb1_rn_drawpoly,'enable','off');
      set(handles.rb2_rn_drawpoly,'enable','off');
      set(handles.bw_drawpoly,'enable','off');
      set(handles.slider_ba_drawpoly,'enable','off');
      set(handles.edit_ba_drawpoly,'enable','off');
   end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drawpoly wait for user response (see UIRESUME)
% uiwait(handles.drawpoly);


% --- Outputs from this function are returned to the command line.
function varargout = drawpoly_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function site_edit_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to site_edit_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of site_edit_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of site_edit_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function site_edit_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to site_edit_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in site_gredit_drawpoly.
function site_gredit_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to site_gredit_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.site_edit_drawpoly,'string');
[stackin,reflistin,status]=siterefparser(temp);
if status==0 h0=groupeditor;
else h0=groupeditor('userdata',{temp,stackin,reflistin});
end
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if strcmpi(temp,'cancelled') return; end
set(handles.site_edit_drawpoly,'string',temp);

% --- Executes on button press in ol_on_drawpoly.
function ol_on_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to ol_on_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'value')==1
   set(handles.ow_drawpoly,'enable','on');
   set(handles.r_edit_ol_drawpoly,'enable','on');
   set(handles.g_edit_ol_drawpoly,'enable','on');
   set(handles.b_edit_ol_drawpoly,'enable','on');
   set(handles.r_slider_ol_drawpoly,'enable','on');
   set(handles.g_slider_ol_drawpoly,'enable','on');
   set(handles.b_slider_ol_drawpoly,'enable','on');
   set(handles.setcolor_ol_drawpoly,'enable','on');
else
   set(handles.ow_drawpoly,'enable','off');
   set(handles.r_edit_ol_drawpoly,'enable','off');
   set(handles.g_edit_ol_drawpoly,'enable','off');
   set(handles.b_edit_ol_drawpoly,'enable','off');
   set(handles.r_slider_ol_drawpoly,'enable','off');
   set(handles.g_slider_ol_drawpoly,'enable','off');
   set(handles.b_slider_ol_drawpoly,'enable','off');
   set(handles.setcolor_ol_drawpoly,'enable','off');
end

% Hint: get(hObject,'Value') returns toggle state of ol_on_drawpoly



function ow_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to ow_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<0) set(hObject,'string','0.05'); waitfor(msgbox('Please enter a positive real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of ow_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of ow_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function ow_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ow_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function r_edit_ol_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to r_edit_ol_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.r_slider_ol_drawpoly,'value',value);
   rvalue=str2double(get(handles.r_edit_ol_drawpoly,'String'));
   gvalue=str2double(get(handles.g_edit_ol_drawpoly,'String'));
   bvalue=str2double(get(handles.b_edit_ol_drawpoly,'String'));
   set(handles.prev_ol_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.r_slider_ol_drawpoly,'value');
   set(hObject,'string',num2str(round(value))); set(handles.r_slider_ol_drawpoly,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of r_edit_ol_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of r_edit_ol_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function r_edit_ol_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_edit_ol_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g_edit_ol_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to g_edit_ol_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.g_slider_ol_drawpoly,'value',value);
   rvalue=str2double(get(handles.r_edit_ol_drawpoly,'String'));
   gvalue=str2double(get(handles.g_edit_ol_drawpoly,'String'));
   bvalue=str2double(get(handles.b_edit_ol_drawpoly,'String'));
   set(handles.prev_ol_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.g_slider_ol_drawpoly,'value');
   set(hObject,'string',num2str(round(value))); set(handles.g_slider_ol_drawpoly,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of g_edit_ol_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of g_edit_ol_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function g_edit_ol_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_edit_ol_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_edit_ol_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to b_edit_ol_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.b_slider_ol_drawpoly,'value',value);
   rvalue=str2double(get(handles.r_edit_ol_drawpoly,'String'));
   gvalue=str2double(get(handles.g_edit_ol_drawpoly,'String'));
   bvalue=str2double(get(handles.b_edit_ol_drawpoly,'String'));
   set(handles.prev_ol_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.b_slider_ol_drawpoly,'value');
   set(hObject,'string',num2str(round(value))); set(handles.b_slider_ol_drawpoly,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of b_edit_ol_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of b_edit_ol_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function b_edit_ol_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_edit_ol_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function r_slider_ol_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to r_slider_ol_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.r_edit_ol_drawpoly,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_ol_drawpoly,'String'));
gvalue=str2double(get(handles.g_edit_ol_drawpoly,'String'));
bvalue=str2double(get(handles.b_edit_ol_drawpoly,'String'));
set(handles.prev_ol_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function r_slider_ol_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_slider_ol_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function g_slider_ol_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to g_slider_ol_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.g_edit_ol_drawpoly,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_ol_drawpoly,'String'));
gvalue=str2double(get(handles.g_edit_ol_drawpoly,'String'));
bvalue=str2double(get(handles.b_edit_ol_drawpoly,'String'));
set(handles.prev_ol_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function g_slider_ol_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_slider_ol_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function b_slider_ol_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to b_slider_ol_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.b_edit_ol_drawpoly,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_ol_drawpoly,'String'));
gvalue=str2double(get(handles.g_edit_ol_drawpoly,'String'));
bvalue=str2double(get(handles.b_edit_ol_drawpoly,'String'));
set(handles.prev_ol_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function b_slider_ol_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_slider_ol_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in setcolor_ol_drawpoly.
function setcolor_ol_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to setcolor_ol_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.r_edit_ol_drawpoly,'String'));
gvalue=str2double(get(handles.g_edit_ol_drawpoly,'String'));
bvalue=str2double(get(handles.b_edit_ol_drawpoly,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.r_edit_ol_drawpoly,'String',num2str(round(hcolor(1)*255)));
   set(handles.g_edit_ol_drawpoly,'String',num2str(round(hcolor(2)*255)));
   set(handles.b_edit_ol_drawpoly,'String',num2str(round(hcolor(3)*255)));
   set(handles.r_slider_ol_drawpoly,'value',hcolor(1)*255);
   set(handles.g_slider_ol_drawpoly,'value',hcolor(2)*255);
   set(handles.b_slider_ol_drawpoly,'value',hcolor(3)*255);
   set(handles.prev_ol_drawpoly,'backgroundcolor',hcolor);
end

% --- Executes on button press in define_fc_drawpoly.
function define_fc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to define_fc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function r_edit_fc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to r_edit_fc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.r_slider_fc_drawpoly,'value',value);
   rvalue=str2double(get(handles.r_edit_fc_drawpoly,'String'));
   gvalue=str2double(get(handles.g_edit_fc_drawpoly,'String'));
   bvalue=str2double(get(handles.b_edit_fc_drawpoly,'String'));
   set(handles.prev_fc_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.r_slider_fc_drawpoly,'value');
   set(hObject,'string',num2str(round(value))); set(handles.r_slider_fc_drawpoly,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of r_edit_fc_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of r_edit_fc_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function r_edit_fc_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_edit_fc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g_edit_fc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to g_edit_fc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.g_slider_fc_drawpoly,'value',value);
   rvalue=str2double(get(handles.r_edit_fc_drawpoly,'String'));
   gvalue=str2double(get(handles.g_edit_fc_drawpoly,'String'));
   bvalue=str2double(get(handles.b_edit_fc_drawpoly,'String'));
   set(handles.prev_fc_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.g_slider_fc_drawpoly,'value');
   set(hObject,'string',num2str(round(value))); set(handles.g_slider_fc_drawpoly,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of g_edit_fc_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of g_edit_fc_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function g_edit_fc_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_edit_fc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_edit_fc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to b_edit_fc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.b_slider_fc_drawpoly,'value',value);
   rvalue=str2double(get(handles.r_edit_fc_drawpoly,'String'));
   gvalue=str2double(get(handles.g_edit_fc_drawpoly,'String'));
   bvalue=str2double(get(handles.b_edit_fc_drawpoly,'String'));
   set(handles.prev_fc_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.b_slider_fc_drawpoly,'value');
   set(hObject,'string',num2str(round(value))); set(handles.b_slider_fc_drawpoly,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of b_edit_fc_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of b_edit_fc_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function b_edit_fc_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_edit_fc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function r_slider_fc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to r_slider_fc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.r_edit_fc_drawpoly,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_fc_drawpoly,'String'));
gvalue=str2double(get(handles.g_edit_fc_drawpoly,'String'));
bvalue=str2double(get(handles.b_edit_fc_drawpoly,'String'));
set(handles.prev_fc_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function r_slider_fc_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_slider_fc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function g_slider_fc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to g_slider_fc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.g_edit_fc_drawpoly,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_fc_drawpoly,'String'));
gvalue=str2double(get(handles.g_edit_fc_drawpoly,'String'));
bvalue=str2double(get(handles.b_edit_fc_drawpoly,'String'));
set(handles.prev_fc_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function g_slider_fc_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_slider_fc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function b_slider_fc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to b_slider_fc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.b_edit_fc_drawpoly,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_fc_drawpoly,'String'));
gvalue=str2double(get(handles.g_edit_fc_drawpoly,'String'));
bvalue=str2double(get(handles.b_edit_fc_drawpoly,'String'));
set(handles.prev_fc_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function b_slider_fc_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_slider_fc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in setcolor_fc_drawpoly.
function setcolor_fc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to setcolor_fc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.r_edit_fc_drawpoly,'String'));
gvalue=str2double(get(handles.g_edit_fc_drawpoly,'String'));
bvalue=str2double(get(handles.b_edit_fc_drawpoly,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.r_edit_fc_drawpoly,'String',num2str(round(hcolor(1)*255)));
   set(handles.g_edit_fc_drawpoly,'String',num2str(round(hcolor(2)*255)));
   set(handles.b_edit_fc_drawpoly,'String',num2str(round(hcolor(3)*255)));
   set(handles.r_slider_fc_drawpoly,'value',hcolor(1)*255);
   set(handles.g_slider_fc_drawpoly,'value',hcolor(2)*255);
   set(handles.b_slider_fc_drawpoly,'value',hcolor(3)*255);
   set(handles.prev_fc_drawpoly,'backgroundcolor',hcolor);
end

% --- Executes on slider movement.
function slider_fa_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to slider_fa_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.edit_fa_drawpoly,'string',sprintf('%4.2f',value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_fa_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_fa_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_fa_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fa_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.slider_fa_drawpoly,'value',value);
else set(hObject,'string','1.00'); set(handles.slider_fa_drawpoly,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of edit_fa_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of edit_fa_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function edit_fa_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fa_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dt_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to dt_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<0)||(value>180) set(hObject,'string','1.0'); waitfor(msgbox('Please enter a number between 0 and 180.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of dt_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of dt_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function dt_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dt_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in b_on_drawpoly.
function b_on_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to b_on_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'value')==1
   set(handles.rb1_bc_drawpoly,'enable','on');
   set(handles.rb2_bc_drawpoly,'enable','on');
   set(handles.rb3_bc_drawpoly,'enable','on');
   if get(handles.rb2_bc_drawpoly,'value')==1
      set(handles.r_edit_bc_drawpoly,'enable','on');
      set(handles.g_edit_bc_drawpoly,'enable','on');
      set(handles.b_edit_bc_drawpoly,'enable','on');
      set(handles.r_slider_bc_drawpoly,'enable','on');
      set(handles.g_slider_bc_drawpoly,'enable','on');
      set(handles.b_slider_bc_drawpoly,'enable','on');
      set(handles.setcolor_bc_drawpoly,'enable','on');
   end
   set(handles.rb1_rn_drawpoly,'enable','on');
   set(handles.rb2_rn_drawpoly,'enable','on');
   if get(handles.rb2_rn_drawpoly,'value')==1
      set(handles.dmin_drawpoly,'enable','on');
      set(handles.dmax_drawpoly,'enable','on');
   end
   set(handles.bw_drawpoly,'enable','on');
   set(handles.slider_ba_drawpoly,'enable','on');
   set(handles.edit_ba_drawpoly,'enable','on');
else
   set(handles.rb1_bc_drawpoly,'enable','off');
   set(handles.rb2_bc_drawpoly,'enable','off');
   set(handles.rb3_bc_drawpoly,'enable','off');
   set(handles.r_edit_bc_drawpoly,'enable','off');
   set(handles.g_edit_bc_drawpoly,'enable','off');
   set(handles.b_edit_bc_drawpoly,'enable','off');
   set(handles.r_slider_bc_drawpoly,'enable','off');
   set(handles.g_slider_bc_drawpoly,'enable','off');
   set(handles.b_slider_bc_drawpoly,'enable','off');
   set(handles.setcolor_bc_drawpoly,'enable','off');
   set(handles.rb1_rn_drawpoly,'enable','off');
   set(handles.rb2_rn_drawpoly,'enable','off');
   set(handles.dmin_drawpoly,'enable','off');
   set(handles.dmax_drawpoly,'enable','off');
   set(handles.bw_drawpoly,'enable','off');
   set(handles.slider_ba_drawpoly,'enable','off');
   set(handles.edit_ba_drawpoly,'enable','off');
end
% Hint: get(hObject,'Value') returns toggle state of b_on_drawpoly


% --- Executes on button press in setcolor_bc_drawpoly.
function setcolor_bc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to setcolor_bc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.r_edit_bc_drawpoly,'String'));
gvalue=str2double(get(handles.g_edit_bc_drawpoly,'String'));
bvalue=str2double(get(handles.b_edit_bc_drawpoly,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.r_edit_bc_drawpoly,'String',num2str(round(hcolor(1)*255)));
   set(handles.g_edit_bc_drawpoly,'String',num2str(round(hcolor(2)*255)));
   set(handles.b_edit_bc_drawpoly,'String',num2str(round(hcolor(3)*255)));
   set(handles.r_slider_bc_drawpoly,'value',hcolor(1)*255);
   set(handles.g_slider_bc_drawpoly,'value',hcolor(2)*255);
   set(handles.b_slider_bc_drawpoly,'value',hcolor(3)*255);
   set(handles.prev_bc_drawpoly,'backgroundcolor',hcolor);
end

% --- Executes on slider movement.
function b_slider_bc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to b_slider_bc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.b_edit_bc_drawpoly,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_bc_drawpoly,'String'));
gvalue=str2double(get(handles.g_edit_bc_drawpoly,'String'));
bvalue=str2double(get(handles.b_edit_bc_drawpoly,'String'));
set(handles.prev_bc_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function b_slider_bc_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_slider_bc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function g_slider_bc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to g_slider_bc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.g_edit_bc_drawpoly,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_bc_drawpoly,'String'));
gvalue=str2double(get(handles.g_edit_bc_drawpoly,'String'));
bvalue=str2double(get(handles.b_edit_bc_drawpoly,'String'));
set(handles.prev_bc_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function g_slider_bc_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_slider_bc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function r_slider_bc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to r_slider_bc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.r_edit_bc_drawpoly,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_bc_drawpoly,'String'));
gvalue=str2double(get(handles.g_edit_bc_drawpoly,'String'));
bvalue=str2double(get(handles.b_edit_bc_drawpoly,'String'));
set(handles.prev_bc_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function r_slider_bc_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_slider_bc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function b_edit_bc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to b_edit_bc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.b_slider_bc_drawpoly,'value',value);
   rvalue=str2double(get(handles.r_edit_bc_drawpoly,'String'));
   gvalue=str2double(get(handles.g_edit_bc_drawpoly,'String'));
   bvalue=str2double(get(handles.b_edit_bc_drawpoly,'String'));
   set(handles.prev_bc_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.b_slider_bc_drawpoly,'value');
   set(hObject,'string',num2str(round(value))); set(handles.b_slider_bc_drawpoly,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of b_edit_bc_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of b_edit_bc_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function b_edit_bc_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_edit_bc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g_edit_bc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to g_edit_bc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.g_slider_bc_drawpoly,'value',value);
   rvalue=str2double(get(handles.r_edit_bc_drawpoly,'String'));
   gvalue=str2double(get(handles.g_edit_bc_drawpoly,'String'));
   bvalue=str2double(get(handles.b_edit_bc_drawpoly,'String'));
   set(handles.prev_bc_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.g_slider_bc_drawpoly,'value');
   set(hObject,'string',num2str(round(value))); set(handles.g_slider_bc_drawpoly,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of g_edit_bc_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of g_edit_bc_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function g_edit_bc_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_edit_bc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function r_edit_bc_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to r_edit_bc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.r_slider_bc_drawpoly,'value',value);
   rvalue=str2double(get(handles.r_edit_bc_drawpoly,'String'));
   gvalue=str2double(get(handles.g_edit_bc_drawpoly,'String'));
   bvalue=str2double(get(handles.b_edit_bc_drawpoly,'String'));
   set(handles.prev_bc_drawpoly,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.r_slider_bc_drawpoly,'value');
   set(hObject,'string',num2str(round(value))); set(handles.r_slider_bc_drawpoly,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of r_edit_bc_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of r_edit_bc_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function r_edit_bc_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_edit_bc_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dmin_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to dmin_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<0) set(hObject,'string','2.00'); waitfor(msgbox('Please enter a positive real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of dmin_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of dmin_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function dmin_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dmin_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dmax_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to dmax_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<0) set(hObject,'string','4.00'); waitfor(msgbox('Please enter a positive real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of dmax_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of dmax_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function dmax_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dmax_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bw_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to bw_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<0) set(hObject,'string','0.15'); waitfor(msgbox('Please enter a positive real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of bw_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of bw_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function bw_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bw_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_ba_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to slider_ba_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.edit_ba_drawpoly,'string',sprintf('%4.2f',value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_ba_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_ba_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_ba_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ba_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.slider_ba_drawpoly,'value',value);
else set(hObject,'string','1.00'); set(handles.slider_ba_drawpoly,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of edit_ba_drawpoly as text
%        str2double(get(hObject,'String')) returns contents of edit_ba_drawpoly as a double


% --- Executes during object creation, after setting all properties.
function edit_ba_drawpoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ba_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_drawpoly.
function OK_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to OK_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'userdata');
temp=get(handles.site_edit_drawpoly,'string');
if isempty(temp) waitfor(msgbox('Please specify the atoms for polyhedron drawing.','Figuretool2')); return; end
[stackin,~,status]=siterefparser(temp);
if (status==0)||~strcmp(stackin,'B') waitfor(msgbox('The specified atom group for polyhedron drawing is invalid.','Figuretool2')); return; end
st0.site=temp;
if get(handles.rb1_fc_drawpoly,'value')==1
   st0.fc='default';
elseif get(handles.rb2_fc_drawpoly,'value')==1
   rvalue=get(handles.r_slider_fc_drawpoly,'value');
   gvalue=get(handles.g_slider_fc_drawpoly,'value');
   bvalue=get(handles.b_slider_fc_drawpoly,'value');
   st0.fc=[rvalue,gvalue,bvalue]/255;
else
   temp=get(handles.define_fc_drawpoly,'userdata');
   if isempty(temp) waitfor(msgbox('Face color data has not been defined.','Figuretool2')); return;
   else st0.fc=temp;
   end
end
st0.fa=get(handles.slider_fa_drawpoly,'value');
st0.dt=str2double(get(handles.dt_drawpoly,'string'));
rvalue=get(handles.r_slider_ol_drawpoly,'value');
gvalue=get(handles.g_slider_ol_drawpoly,'value');
bvalue=get(handles.b_slider_ol_drawpoly,'value');
st0.oc=[rvalue,gvalue,bvalue]/255;
if get(handles.ol_on_drawpoly,'value')==1 st0.o='on'; else st0.o='off'; end
st0.ow=str2double(get(handles.ow_drawpoly,'string'));
if get(handles.b_on_drawpoly,'value')==1 st0.b='on'; else st0.b='off'; end
st0.bw=str2double(get(handles.bw_drawpoly,'string'));
st0.ba=get(handles.slider_ba_drawpoly,'value');
if get(handles.rb1_bc_drawpoly,'value')==1 st0.bc='default';
elseif get(handles.rb3_bc_drawpoly,'value')==1 st0.bc='bicolored';
else
   rvalue=get(handles.r_slider_bc_drawpoly,'value');
gvalue=get(handles.g_slider_bc_drawpoly,'value');
bvalue=get(handles.b_slider_bc_drawpoly,'value');
st0.bc=[rvalue,gvalue,bvalue]/255;
end
if get(handles.rb1_rn_drawpoly,'value')==1 st0.rn='default';
else
   dmin=str2double(get(handles.dmin_drawpoly,'string'));
   dmax=str2double(get(handles.dmax_drawpoly,'string'));
   if dmin>=dmax waitfor(msgbox('Minimum bond distance must be shorter than maximum distance!','Figuretool2')); return;
   else st0.rn=[dmin,dmax];
   end
end
set(get(hObject,'parent'),'userdata',st0);
uiresume;


% --- Executes on button press in cancel_drawpoly.
function cancel_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes on button press in advanced_drawpoly.
function advanced_drawpoly_Callback(hObject, eventdata, handles)
% hObject    handle to advanced_drawpoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'Userdata');
h0=adv_settings('Userdata',{st0.lp,[0.9,0.6,0.3,10],st0.res,st0.fl});
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

% --- Executes when selected object is changed in fc_drawpoly.
function fc_drawpoly_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in fc_drawpoly 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_fc_drawpoly')
   set(handles.r_edit_fc_drawpoly,'enable','off');
   set(handles.g_edit_fc_drawpoly,'enable','off');
   set(handles.b_edit_fc_drawpoly,'enable','off');
   set(handles.r_slider_fc_drawpoly,'enable','off');
   set(handles.g_slider_fc_drawpoly,'enable','off');
   set(handles.b_slider_fc_drawpoly,'enable','off');
   set(handles.setcolor_fc_drawpoly,'enable','off');
   set(handles.define_fc_drawpoly,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_fc_drawpoly')
   set(handles.r_edit_fc_drawpoly,'enable','on');
   set(handles.g_edit_fc_drawpoly,'enable','on');
   set(handles.b_edit_fc_drawpoly,'enable','on');
   set(handles.r_slider_fc_drawpoly,'enable','on');
   set(handles.g_slider_fc_drawpoly,'enable','on');
   set(handles.b_slider_fc_drawpoly,'enable','on');
   set(handles.setcolor_fc_drawpoly,'enable','on');
   set(handles.define_fc_drawpoly,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb3_fc_drawpoly')
   set(handles.r_edit_fc_drawpoly,'enable','off');
   set(handles.g_edit_fc_drawpoly,'enable','off');
   set(handles.b_edit_fc_drawpoly,'enable','off');
   set(handles.r_slider_fc_drawpoly,'enable','off');
   set(handles.g_slider_fc_drawpoly,'enable','off');
   set(handles.b_slider_fc_drawpoly,'enable','off');
   set(handles.setcolor_fc_drawpoly,'enable','off');
   set(handles.define_fc_drawpoly,'enable','on');
end


% --- Executes when selected object is changed in bc_drawpoly.
function bc_drawpoly_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in bc_drawpoly 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb2_bc_drawpoly')
   set(handles.r_edit_bc_drawpoly,'enable','on');
   set(handles.g_edit_bc_drawpoly,'enable','on');
   set(handles.b_edit_bc_drawpoly,'enable','on');
   set(handles.r_slider_bc_drawpoly,'enable','on');
   set(handles.g_slider_bc_drawpoly,'enable','on');
   set(handles.b_slider_bc_drawpoly,'enable','on');
   set(handles.setcolor_bc_drawpoly,'enable','on');
elseif strcmpi(get(eventdata.OldValue,'tag'),'rb2_bc_drawpoly')
   set(handles.r_edit_bc_drawpoly,'enable','off');
   set(handles.g_edit_bc_drawpoly,'enable','off');
   set(handles.b_edit_bc_drawpoly,'enable','off');
   set(handles.r_slider_bc_drawpoly,'enable','off');
   set(handles.g_slider_bc_drawpoly,'enable','off');
   set(handles.b_slider_bc_drawpoly,'enable','off');
   set(handles.setcolor_bc_drawpoly,'enable','off');
end
   
% --- Executes when selected object is changed in rn_drawpoly.
function rn_drawpoly_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in rn_drawpoly 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb2_rn_drawpoly')
      set(handles.dmin_drawpoly,'enable','on');
      set(handles.dmax_drawpoly,'enable','on');
elseif strcmpi(get(eventdata.OldValue,'tag'),'rb2_rn_drawpoly')
      set(handles.dmin_drawpoly,'enable','off');
      set(handles.dmax_drawpoly,'enable','off');   
end
