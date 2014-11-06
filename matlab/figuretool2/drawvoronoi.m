function varargout = drawvoronoi(varargin)
% DRAWVORONOI MATLAB code for drawvoronoi.fig
%      DRAWVORONOI, by itself, creates a new DRAWVORONOI or raises the existing
%      singleton*.
%
%      H = DRAWVORONOI returns the handle to a new DRAWVORONOI or the handle to
%      the existing singleton*.
%
%      DRAWVORONOI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWVORONOI.M with the given input arguments.
%
%      DRAWVORONOI('Property','Value',...) creates a new DRAWVORONOI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drawvoronoi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drawvoronoi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drawvoronoi

% Last Modified by GUIDE v2.5 14-Oct-2014 19:03:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @drawvoronoi_OpeningFcn, ...
   'gui_OutputFcn',  @drawvoronoi_OutputFcn, ...
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


% --- Executes just before drawvoronoi is made visible.
function drawvoronoi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawvoronoi (see VARARGIN)

% Choose default command line output for drawvoronoi
global globallp globalfl;
handles.output = hObject;
if isempty(get(hObject,'Userdata'))
   st0=struct('function','drawvoronoi','site','','fc','default','fa',1.0,'o','off','ow',0.05,'oc',[1,1,1],'b','on','bc','default',...
      'bw',0.15,'ba',1.0,'sf',1.0,'fl',globalfl,'lp',globallp,'res','default');
   set(hObject,'Userdata',st0);
else
   st0=get(hObject,'userdata');
   set(handles.site_edit_drawvoronoi,'string',st0.site);
   if isnumeric(st0.fc)
      hcolor=st0.fc;
      set(handles.rb2_fc_drawvoronoi,'value',1);
      set(handles.r_edit_fc_drawvoronoi,'enable','on','string',num2str(round(hcolor(1)*255)));
      set(handles.g_edit_fc_drawvoronoi,'enable','on','string',num2str(round(hcolor(2)*255)));
      set(handles.b_edit_fc_drawvoronoi,'enable','on','string',num2str(round(hcolor(3)*255)));
      set(handles.r_slider_fc_drawvoronoi,'enable','on','value',hcolor(1)*255);
      set(handles.g_slider_fc_drawvoronoi,'enable','on','value',hcolor(2)*255);
      set(handles.b_slider_fc_drawvoronoi,'enable','on','value',hcolor(3)*255);
      set(handles.setcolor_fc_drawvoronoi,'enable','on');
      set(handles.prev_fc_drawvoronoi,'backgroundcolor',hcolor);
   end
   set(handles.edit_fa_drawvoronoi,'string',sprintf('%.2f',st0.fa));
   set(handles.slider_fa_drawvoronoi,'value',st0.fa);
   set(handles.sf_drawvoronoi,'string',sprintf('%.2f',st0.sf));
   if strcmpi(st0.o,'on')
      hcolor=st0.oc;
      set(handles.ol_on_drawvoronoi,'value',1);
      set(handles.ow_drawvoronoi,'enable','on','string',sprintf('%.2f',st0.ow));
      set(handles.r_edit_ol_drawvoronoi,'enable','on','String',num2str(round(hcolor(1)*255)));
      set(handles.g_edit_ol_drawvoronoi,'enable','on','String',num2str(round(hcolor(2)*255)));
      set(handles.b_edit_ol_drawvoronoi,'enable','on','String',num2str(round(hcolor(3)*255)));
      set(handles.r_slider_ol_drawvoronoi,'enable','on','value',hcolor(1)*255);
      set(handles.g_slider_ol_drawvoronoi,'enable','on','value',hcolor(2)*255);
      set(handles.b_slider_ol_drawvoronoi,'enable','on','value',hcolor(3)*255);
      set(handles.setcolor_ol_drawvoronoi,'enable','on');
      set(handles.prev_ol_drawvoronoi,'backgroundcolor',hcolor);
   end
   if strcmpi(st0.b,'on')
      set(handles.b_on_drawvoronoi,'value',1);
      set(handles.rb1_bc_drawvoronoi,'enable','on');
      set(handles.rb2_bc_drawvoronoi,'enable','on');
      if isnumeric(st0.bc)
         hcolor=st0.bc;
         set(handles.rb2_bc_drawvoronoi,'value',1);
         set(handles.r_edit_bc_drawvoronoi,'enable','on','String',num2str(round(hcolor(1)*255)));
         set(handles.g_edit_bc_drawvoronoi,'enable','on','String',num2str(round(hcolor(2)*255)));
         set(handles.b_edit_bc_drawvoronoi,'enable','on','String',num2str(round(hcolor(3)*255)));
         set(handles.r_slider_bc_drawvoronoi,'enable','on','value',hcolor(1)*255);
         set(handles.g_slider_bc_drawvoronoi,'enable','on','value',hcolor(2)*255);
         set(handles.b_slider_bc_drawvoronoi,'enable','on','value',hcolor(3)*255);
         set(handles.setcolor_bc_drawvoronoi,'enable','on');
         set(handles.prev_bc_drawvoronoi,'backgroundcolor',hcolor);
      end
      set(handles.bw_drawvoronoi,'enable','on','string',sprintf('%.2f',st0.bw));
      set(handles.slider_ba_drawvoronoi,'enable','on','string',sprintf('%.2f',st0.ba));
      set(handles.edit_ba_drawvoronoi,'enable','on','value',st0.ba);
   else
      set(handles.b_on_drawvoronoi,'value',0);
      set(handles.rb1_bc_drawvoronoi,'enable','off');
      set(handles.rb2_bc_drawvoronoi,'enable','off');
      set(handles.rb3_bc_drawvoronoi,'enable','off');
      set(handles.rb1_rn_drawvoronoi,'enable','off');
      set(handles.rb2_rn_drawvoronoi,'enable','off');
      set(handles.bw_drawvoronoi,'enable','off');
      set(handles.slider_ba_drawvoronoi,'enable','off');
      set(handles.edit_ba_drawvoronoi,'enable','off');
   end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drawvoronoi wait for user response (see UIRESUME)
% uiwait(handles.drawvoronoi);


% --- Outputs from this function are returned to the command line.
function varargout = drawvoronoi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function site_edit_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to site_edit_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of site_edit_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of site_edit_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function site_edit_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to site_edit_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in site_gredit_drawvoronoi.
function site_gredit_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to site_gredit_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.site_edit_drawvoronoi,'string');
[stackin,reflistin,status]=siterefparser(temp);
if status==0 h0=groupeditor;
else h0=groupeditor('userdata',{temp,stackin,reflistin});
end
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if strcmpi(temp,'cancelled') return; end
set(handles.site_edit_drawvoronoi,'string',temp);

% --- Executes on button press in ol_on_drawvoronoi.
function ol_on_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to ol_on_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'value')==1
   set(handles.ow_drawvoronoi,'enable','on');
   set(handles.r_edit_ol_drawvoronoi,'enable','on');
   set(handles.g_edit_ol_drawvoronoi,'enable','on');
   set(handles.b_edit_ol_drawvoronoi,'enable','on');
   set(handles.r_slider_ol_drawvoronoi,'enable','on');
   set(handles.g_slider_ol_drawvoronoi,'enable','on');
   set(handles.b_slider_ol_drawvoronoi,'enable','on');
   set(handles.setcolor_ol_drawvoronoi,'enable','on');
else
   set(handles.ow_drawvoronoi,'enable','off');
   set(handles.r_edit_ol_drawvoronoi,'enable','off');
   set(handles.g_edit_ol_drawvoronoi,'enable','off');
   set(handles.b_edit_ol_drawvoronoi,'enable','off');
   set(handles.r_slider_ol_drawvoronoi,'enable','off');
   set(handles.g_slider_ol_drawvoronoi,'enable','off');
   set(handles.b_slider_ol_drawvoronoi,'enable','off');
   set(handles.setcolor_ol_drawvoronoi,'enable','off');
end

% Hint: get(hObject,'Value') returns toggle state of ol_on_drawvoronoi



function ow_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to ow_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<0) set(hObject,'string','0.05'); waitfor(msgbox('Please enter a positive real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of ow_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of ow_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function ow_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ow_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function r_edit_ol_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to r_edit_ol_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.r_slider_ol_drawvoronoi,'value',value);
   rvalue=str2double(get(handles.r_edit_ol_drawvoronoi,'String'));
   gvalue=str2double(get(handles.g_edit_ol_drawvoronoi,'String'));
   bvalue=str2double(get(handles.b_edit_ol_drawvoronoi,'String'));
   set(handles.prev_ol_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.r_slider_ol_drawvoronoi,'value');
   set(hObject,'string',num2str(round(value))); set(handles.r_slider_ol_drawvoronoi,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of r_edit_ol_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of r_edit_ol_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function r_edit_ol_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_edit_ol_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g_edit_ol_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to g_edit_ol_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.g_slider_ol_drawvoronoi,'value',value);
   rvalue=str2double(get(handles.r_edit_ol_drawvoronoi,'String'));
   gvalue=str2double(get(handles.g_edit_ol_drawvoronoi,'String'));
   bvalue=str2double(get(handles.b_edit_ol_drawvoronoi,'String'));
   set(handles.prev_ol_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.g_slider_ol_drawvoronoi,'value');
   set(hObject,'string',num2str(round(value))); set(handles.g_slider_ol_drawvoronoi,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of g_edit_ol_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of g_edit_ol_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function g_edit_ol_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_edit_ol_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_edit_ol_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to b_edit_ol_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.b_slider_ol_drawvoronoi,'value',value);
   rvalue=str2double(get(handles.r_edit_ol_drawvoronoi,'String'));
   gvalue=str2double(get(handles.g_edit_ol_drawvoronoi,'String'));
   bvalue=str2double(get(handles.b_edit_ol_drawvoronoi,'String'));
   set(handles.prev_ol_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.b_slider_ol_drawvoronoi,'value');
   set(hObject,'string',num2str(round(value))); set(handles.b_slider_ol_drawvoronoi,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of b_edit_ol_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of b_edit_ol_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function b_edit_ol_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_edit_ol_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function r_slider_ol_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to r_slider_ol_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.r_edit_ol_drawvoronoi,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_ol_drawvoronoi,'String'));
gvalue=str2double(get(handles.g_edit_ol_drawvoronoi,'String'));
bvalue=str2double(get(handles.b_edit_ol_drawvoronoi,'String'));
set(handles.prev_ol_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function r_slider_ol_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_slider_ol_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function g_slider_ol_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to g_slider_ol_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.g_edit_ol_drawvoronoi,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_ol_drawvoronoi,'String'));
gvalue=str2double(get(handles.g_edit_ol_drawvoronoi,'String'));
bvalue=str2double(get(handles.b_edit_ol_drawvoronoi,'String'));
set(handles.prev_ol_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function g_slider_ol_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_slider_ol_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function b_slider_ol_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to b_slider_ol_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.b_edit_ol_drawvoronoi,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_ol_drawvoronoi,'String'));
gvalue=str2double(get(handles.g_edit_ol_drawvoronoi,'String'));
bvalue=str2double(get(handles.b_edit_ol_drawvoronoi,'String'));
set(handles.prev_ol_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function b_slider_ol_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_slider_ol_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in setcolor_ol_drawvoronoi.
function setcolor_ol_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to setcolor_ol_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.r_edit_ol_drawvoronoi,'String'));
gvalue=str2double(get(handles.g_edit_ol_drawvoronoi,'String'));
bvalue=str2double(get(handles.b_edit_ol_drawvoronoi,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.r_edit_ol_drawvoronoi,'String',num2str(round(hcolor(1)*255)));
   set(handles.g_edit_ol_drawvoronoi,'String',num2str(round(hcolor(2)*255)));
   set(handles.b_edit_ol_drawvoronoi,'String',num2str(round(hcolor(3)*255)));
   set(handles.r_slider_ol_drawvoronoi,'value',hcolor(1)*255);
   set(handles.g_slider_ol_drawvoronoi,'value',hcolor(2)*255);
   set(handles.b_slider_ol_drawvoronoi,'value',hcolor(3)*255);
   set(handles.prev_ol_drawvoronoi,'backgroundcolor',hcolor);
end


function r_edit_fc_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to r_edit_fc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.r_slider_fc_drawvoronoi,'value',value);
   rvalue=str2double(get(handles.r_edit_fc_drawvoronoi,'String'));
   gvalue=str2double(get(handles.g_edit_fc_drawvoronoi,'String'));
   bvalue=str2double(get(handles.b_edit_fc_drawvoronoi,'String'));
   set(handles.prev_fc_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.r_slider_fc_drawvoronoi,'value');
   set(hObject,'string',num2str(round(value))); set(handles.r_slider_fc_drawvoronoi,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of r_edit_fc_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of r_edit_fc_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function r_edit_fc_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_edit_fc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g_edit_fc_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to g_edit_fc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.g_slider_fc_drawvoronoi,'value',value);
   rvalue=str2double(get(handles.r_edit_fc_drawvoronoi,'String'));
   gvalue=str2double(get(handles.g_edit_fc_drawvoronoi,'String'));
   bvalue=str2double(get(handles.b_edit_fc_drawvoronoi,'String'));
   set(handles.prev_fc_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.g_slider_fc_drawvoronoi,'value');
   set(hObject,'string',num2str(round(value))); set(handles.g_slider_fc_drawvoronoi,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of g_edit_fc_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of g_edit_fc_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function g_edit_fc_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_edit_fc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_edit_fc_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to b_edit_fc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.b_slider_fc_drawvoronoi,'value',value);
   rvalue=str2double(get(handles.r_edit_fc_drawvoronoi,'String'));
   gvalue=str2double(get(handles.g_edit_fc_drawvoronoi,'String'));
   bvalue=str2double(get(handles.b_edit_fc_drawvoronoi,'String'));
   set(handles.prev_fc_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.b_slider_fc_drawvoronoi,'value');
   set(hObject,'string',num2str(round(value))); set(handles.b_slider_fc_drawvoronoi,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of b_edit_fc_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of b_edit_fc_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function b_edit_fc_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_edit_fc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function r_slider_fc_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to r_slider_fc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.r_edit_fc_drawvoronoi,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_fc_drawvoronoi,'String'));
gvalue=str2double(get(handles.g_edit_fc_drawvoronoi,'String'));
bvalue=str2double(get(handles.b_edit_fc_drawvoronoi,'String'));
set(handles.prev_fc_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function r_slider_fc_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_slider_fc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function g_slider_fc_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to g_slider_fc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.g_edit_fc_drawvoronoi,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_fc_drawvoronoi,'String'));
gvalue=str2double(get(handles.g_edit_fc_drawvoronoi,'String'));
bvalue=str2double(get(handles.b_edit_fc_drawvoronoi,'String'));
set(handles.prev_fc_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function g_slider_fc_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_slider_fc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function b_slider_fc_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to b_slider_fc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.b_edit_fc_drawvoronoi,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_fc_drawvoronoi,'String'));
gvalue=str2double(get(handles.g_edit_fc_drawvoronoi,'String'));
bvalue=str2double(get(handles.b_edit_fc_drawvoronoi,'String'));
set(handles.prev_fc_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function b_slider_fc_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_slider_fc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in setcolor_fc_drawvoronoi.
function setcolor_fc_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to setcolor_fc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.r_edit_fc_drawvoronoi,'String'));
gvalue=str2double(get(handles.g_edit_fc_drawvoronoi,'String'));
bvalue=str2double(get(handles.b_edit_fc_drawvoronoi,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.r_edit_fc_drawvoronoi,'String',num2str(round(hcolor(1)*255)));
   set(handles.g_edit_fc_drawvoronoi,'String',num2str(round(hcolor(2)*255)));
   set(handles.b_edit_fc_drawvoronoi,'String',num2str(round(hcolor(3)*255)));
   set(handles.r_slider_fc_drawvoronoi,'value',hcolor(1)*255);
   set(handles.g_slider_fc_drawvoronoi,'value',hcolor(2)*255);
   set(handles.b_slider_fc_drawvoronoi,'value',hcolor(3)*255);
   set(handles.prev_fc_drawvoronoi,'backgroundcolor',hcolor);
end

% --- Executes on slider movement.
function slider_fa_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to slider_fa_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.edit_fa_drawvoronoi,'string',sprintf('%4.2f',value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_fa_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_fa_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_fa_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fa_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.slider_fa_drawvoronoi,'value',value);
else set(hObject,'string','1.00'); set(handles.slider_fa_drawvoronoi,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of edit_fa_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of edit_fa_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function edit_fa_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fa_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in b_on_drawvoronoi.
function b_on_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to b_on_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'value')==1
   set(handles.rb1_bc_drawvoronoi,'enable','on');
   set(handles.rb2_bc_drawvoronoi,'enable','on');
   if get(handles.rb2_bc_drawvoronoi,'value')==1
      set(handles.r_edit_bc_drawvoronoi,'enable','on');
      set(handles.g_edit_bc_drawvoronoi,'enable','on');
      set(handles.b_edit_bc_drawvoronoi,'enable','on');
      set(handles.r_slider_bc_drawvoronoi,'enable','on');
      set(handles.g_slider_bc_drawvoronoi,'enable','on');
      set(handles.b_slider_bc_drawvoronoi,'enable','on');
      set(handles.setcolor_bc_drawvoronoi,'enable','on');
   end
   set(handles.bw_drawvoronoi,'enable','on');
   set(handles.slider_ba_drawvoronoi,'enable','on');
   set(handles.edit_ba_drawvoronoi,'enable','on');
else
   set(handles.rb1_bc_drawvoronoi,'enable','off');
   set(handles.rb2_bc_drawvoronoi,'enable','off');
   set(handles.r_edit_bc_drawvoronoi,'enable','off');
   set(handles.g_edit_bc_drawvoronoi,'enable','off');
   set(handles.b_edit_bc_drawvoronoi,'enable','off');
   set(handles.r_slider_bc_drawvoronoi,'enable','off');
   set(handles.g_slider_bc_drawvoronoi,'enable','off');
   set(handles.b_slider_bc_drawvoronoi,'enable','off');
   set(handles.setcolor_bc_drawvoronoi,'enable','off');
   set(handles.bw_drawvoronoi,'enable','off');
   set(handles.slider_ba_drawvoronoi,'enable','off');
   set(handles.edit_ba_drawvoronoi,'enable','off');
end
% Hint: get(hObject,'Value') returns toggle state of b_on_drawvoronoi


% --- Executes on button press in setcolor_bc_drawvoronoi.
function setcolor_bc_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to setcolor_bc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.r_edit_bc_drawvoronoi,'String'));
gvalue=str2double(get(handles.g_edit_bc_drawvoronoi,'String'));
bvalue=str2double(get(handles.b_edit_bc_drawvoronoi,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.r_edit_bc_drawvoronoi,'String',num2str(round(hcolor(1)*255)));
   set(handles.g_edit_bc_drawvoronoi,'String',num2str(round(hcolor(2)*255)));
   set(handles.b_edit_bc_drawvoronoi,'String',num2str(round(hcolor(3)*255)));
   set(handles.r_slider_bc_drawvoronoi,'value',hcolor(1)*255);
   set(handles.g_slider_bc_drawvoronoi,'value',hcolor(2)*255);
   set(handles.b_slider_bc_drawvoronoi,'value',hcolor(3)*255);
   set(handles.prev_bc_drawvoronoi,'backgroundcolor',hcolor);
end

% --- Executes on slider movement.
function b_slider_bc_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to b_slider_bc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.b_edit_bc_drawvoronoi,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_bc_drawvoronoi,'String'));
gvalue=str2double(get(handles.g_edit_bc_drawvoronoi,'String'));
bvalue=str2double(get(handles.b_edit_bc_drawvoronoi,'String'));
set(handles.prev_bc_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function b_slider_bc_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_slider_bc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function g_slider_bc_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to g_slider_bc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.g_edit_bc_drawvoronoi,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_bc_drawvoronoi,'String'));
gvalue=str2double(get(handles.g_edit_bc_drawvoronoi,'String'));
bvalue=str2double(get(handles.b_edit_bc_drawvoronoi,'String'));
set(handles.prev_bc_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function g_slider_bc_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_slider_bc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function r_slider_bc_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to r_slider_bc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.r_edit_bc_drawvoronoi,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_bc_drawvoronoi,'String'));
gvalue=str2double(get(handles.g_edit_bc_drawvoronoi,'String'));
bvalue=str2double(get(handles.b_edit_bc_drawvoronoi,'String'));
set(handles.prev_bc_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function r_slider_bc_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_slider_bc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function b_edit_bc_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to b_edit_bc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.b_slider_bc_drawvoronoi,'value',value);
   rvalue=str2double(get(handles.r_edit_bc_drawvoronoi,'String'));
   gvalue=str2double(get(handles.g_edit_bc_drawvoronoi,'String'));
   bvalue=str2double(get(handles.b_edit_bc_drawvoronoi,'String'));
   set(handles.prev_bc_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.b_slider_bc_drawvoronoi,'value');
   set(hObject,'string',num2str(round(value))); set(handles.b_slider_bc_drawvoronoi,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of b_edit_bc_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of b_edit_bc_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function b_edit_bc_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_edit_bc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g_edit_bc_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to g_edit_bc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.g_slider_bc_drawvoronoi,'value',value);
   rvalue=str2double(get(handles.r_edit_bc_drawvoronoi,'String'));
   gvalue=str2double(get(handles.g_edit_bc_drawvoronoi,'String'));
   bvalue=str2double(get(handles.b_edit_bc_drawvoronoi,'String'));
   set(handles.prev_bc_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.g_slider_bc_drawvoronoi,'value');
   set(hObject,'string',num2str(round(value))); set(handles.g_slider_bc_drawvoronoi,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of g_edit_bc_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of g_edit_bc_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function g_edit_bc_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_edit_bc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function r_edit_bc_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to r_edit_bc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.r_slider_bc_drawvoronoi,'value',value);
   rvalue=str2double(get(handles.r_edit_bc_drawvoronoi,'String'));
   gvalue=str2double(get(handles.g_edit_bc_drawvoronoi,'String'));
   bvalue=str2double(get(handles.b_edit_bc_drawvoronoi,'String'));
   set(handles.prev_bc_drawvoronoi,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.r_slider_bc_drawvoronoi,'value');
   set(hObject,'string',num2str(round(value))); set(handles.r_slider_bc_drawvoronoi,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of r_edit_bc_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of r_edit_bc_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function r_edit_bc_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_edit_bc_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bw_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to bw_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<0) set(hObject,'string','0.15'); waitfor(msgbox('Please enter a positive real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of bw_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of bw_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function bw_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bw_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_ba_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to slider_ba_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.edit_ba_drawvoronoi,'string',sprintf('%4.2f',value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_ba_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_ba_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_ba_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ba_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.slider_ba_drawvoronoi,'value',value);
else set(hObject,'string','1.00'); set(handles.slider_ba_drawvoronoi,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of edit_ba_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of edit_ba_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function edit_ba_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ba_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_drawvoronoi.
function OK_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to OK_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'userdata');
temp=get(handles.site_edit_drawvoronoi,'string');
if isempty(temp) waitfor(msgbox('Please specify the central atoms for polyhedron drawing.','Figuretool2')); return; end
[stackin,~,status]=siterefparser(temp);
if (status==0)||~strcmp(stackin,'B') waitfor(msgbox('The specified central atom group is invalid.','Figuretool2')); return; end
st0.site=temp;
if get(handles.rb1_fc_drawvoronoi,'value')==1
   st0.fc='central';
elseif get(handles.rb2_fc_drawvoronoi,'value')==1
   rvalue=get(handles.r_slider_fc_drawvoronoi,'value');
   gvalue=get(handles.g_slider_fc_drawvoronoi,'value');
   bvalue=get(handles.b_slider_fc_drawvoronoi,'value');
   st0.fc=[rvalue,gvalue,bvalue]/255;
end
st0.fa=get(handles.slider_fa_drawvoronoi,'value');
rvalue=get(handles.r_slider_ol_drawvoronoi,'value');
gvalue=get(handles.g_slider_ol_drawvoronoi,'value');
bvalue=get(handles.b_slider_ol_drawvoronoi,'value');
st0.oc=[rvalue,gvalue,bvalue]/255;
if get(handles.ol_on_drawvoronoi,'value')==1 st0.o='on'; else st0.o='off'; end
st0.ow=str2double(get(handles.ow_drawvoronoi,'string'));
if get(handles.b_on_drawvoronoi,'value')==1 st0.b='on'; else st0.b='off'; end
st0.bw=str2double(get(handles.bw_drawvoronoi,'string'));
st0.ba=get(handles.slider_ba_drawvoronoi,'value');
if get(handles.rb1_bc_drawvoronoi,'value')==1 st0.bc='central';
else
   rvalue=get(handles.r_slider_bc_drawvoronoi,'value');
   gvalue=get(handles.g_slider_bc_drawvoronoi,'value');
   bvalue=get(handles.b_slider_bc_drawvoronoi,'value');
   st0.bc=[rvalue,gvalue,bvalue]/255;
end
set(get(hObject,'parent'),'userdata',st0);
uiresume;


% --- Executes on button press in cancel_drawvoronoi.
function cancel_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes on button press in advanced_drawvoronoi.
function advanced_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to advanced_drawvoronoi (see GCBO)
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

% --- Executes when selected object is changed in fc_drawvoronoi.
function fc_drawvoronoi_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in fc_drawvoronoi 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_fc_drawvoronoi')
   set(handles.r_edit_fc_drawvoronoi,'enable','off');
   set(handles.g_edit_fc_drawvoronoi,'enable','off');
   set(handles.b_edit_fc_drawvoronoi,'enable','off');
   set(handles.r_slider_fc_drawvoronoi,'enable','off');
   set(handles.g_slider_fc_drawvoronoi,'enable','off');
   set(handles.b_slider_fc_drawvoronoi,'enable','off');
   set(handles.setcolor_fc_drawvoronoi,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_fc_drawvoronoi')
   set(handles.r_edit_fc_drawvoronoi,'enable','on');
   set(handles.g_edit_fc_drawvoronoi,'enable','on');
   set(handles.b_edit_fc_drawvoronoi,'enable','on');
   set(handles.r_slider_fc_drawvoronoi,'enable','on');
   set(handles.g_slider_fc_drawvoronoi,'enable','on');
   set(handles.b_slider_fc_drawvoronoi,'enable','on');
   set(handles.setcolor_fc_drawvoronoi,'enable','on');
end


% --- Executes when selected object is changed in bc_drawvoronoi.
function bc_drawvoronoi_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in bc_drawvoronoi 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb2_bc_drawvoronoi')
   set(handles.r_edit_bc_drawvoronoi,'enable','on');
   set(handles.g_edit_bc_drawvoronoi,'enable','on');
   set(handles.b_edit_bc_drawvoronoi,'enable','on');
   set(handles.r_slider_bc_drawvoronoi,'enable','on');
   set(handles.g_slider_bc_drawvoronoi,'enable','on');
   set(handles.b_slider_bc_drawvoronoi,'enable','on');
   set(handles.setcolor_bc_drawvoronoi,'enable','on');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb1_bc_drawvoronoi')
   set(handles.r_edit_bc_drawvoronoi,'enable','off');
   set(handles.g_edit_bc_drawvoronoi,'enable','off');
   set(handles.b_edit_bc_drawvoronoi,'enable','off');
   set(handles.r_slider_bc_drawvoronoi,'enable','off');
   set(handles.g_slider_bc_drawvoronoi,'enable','off');
   set(handles.b_slider_bc_drawvoronoi,'enable','off');
   set(handles.setcolor_bc_drawvoronoi,'enable','off');
end


function sf_drawvoronoi_Callback(hObject, eventdata, handles)
% hObject    handle to sf_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0)||(value>1) set(hObject,'string','1.0'); waitfor(msgbox('Please enter a positive number between 0 and 1.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of sf_drawvoronoi as text
%        str2double(get(hObject,'String')) returns contents of sf_drawvoronoi as a double


% --- Executes during object creation, after setting all properties.
function sf_drawvoronoi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sf_drawvoronoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
