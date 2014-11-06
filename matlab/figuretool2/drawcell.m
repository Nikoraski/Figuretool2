function varargout = drawcell(varargin) 
% DRAWCELL MATLAB code for drawcell.fig
%      DRAWCELL, by itself, creates a new DRAWCELL or raises the existing
%      singleton*.
%
%      H = DRAWCELL returns the handle to a new DRAWCELL or the handle to
%      the existing singleton*.
%
%      DRAWCELL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWCELL.M with the given input arguments.
%
%      DRAWCELL('Property','Value',...) creates a new DRAWCELL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drawcell_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drawcell_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drawcell

% Last Modified by GUIDE v2.5 16-Jul-2014 17:04:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @drawcell_OpeningFcn, ...
                   'gui_OutputFcn',  @drawcell_OutputFcn, ...
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


% --- Executes just before drawcell is made visible.
function drawcell_OpeningFcn(hObject, eventdata, handles, varargin) 
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawcell (see VARARGIN)

% Choose default command line output for drawcell
global globallp globalfl;
handles.output = hObject;
if isempty(get(hObject,'Userdata'))
   st0=struct('function','drawcell','rn','automatic','or',[0,0,0],'ct','direct','bt','regular','bc',[0,0,0],'bw',0.05,'ba',1.0,...
      'o','off','ow',0.05,'oc',[1,1,1],'dl',[2,1],'fl',globalfl,'lp',globallp,'res','default');
   set(hObject,'Userdata',st0);
else
   st0=get(hObject,'userdata');
   if isnumeric(st0.rn)
      set(handles.rb3_rn_drawcell,'value',1);
      set(handles.xmin_drawcell,'enable','on','string',num2str(st0.rn(1)));
      set(handles.xmax_drawcell,'enable','on','string',num2str(st0.rn(2)));
      set(handles.ymin_drawcell,'enable','on','string',num2str(st0.rn(3)));
      set(handles.ymax_drawcell,'enable','on','string',num2str(st0.rn(4)));
      set(handles.zmin_drawcell,'enable','on','string',num2str(st0.rn(5)));
      set(handles.zmax_drawcell,'enable','on','string',num2str(st0.rn(6)));
   elseif strcmpi(st0.rn,'unitcell')
      set(handles.rb2_rn_drawcell,'value',1);
   end
   set(handles.x_or_drawcell,'string',sprintf('%.4f',st0.or(1)));
   set(handles.y_or_drawcell,'string',sprintf('%.4f',st0.or(2)));
   set(handles.z_or_drawcell,'string',sprintf('%.4f',st0.or(3)));
   if strcmpi(st0.ct,'Cartesian') set(handles.rb1_or_drawcell,'value',1); end
   if strcmpi(st0.bt,'dashed') set(handles.rb2_bt_drawcell,'value',1); end
   set(handles.dl1_drawcell,'string',num2str(st0.dl(1)));
   set(handles.dl2_drawcell,'string',num2str(st0.dl(2)));
   hcolor=st0.bc;
   set(handles.r_edit_bc_drawcell,'String',num2str(round(hcolor(1)*255)));
   set(handles.g_edit_bc_drawcell,'String',num2str(round(hcolor(2)*255)));
   set(handles.b_edit_bc_drawcell,'String',num2str(round(hcolor(3)*255)));
   set(handles.r_slider_bc_drawcell,'value',hcolor(1)*255);
   set(handles.g_slider_bc_drawcell,'value',hcolor(2)*255);
   set(handles.b_slider_bc_drawcell,'value',hcolor(3)*255);
   set(handles.prev_bc_drawcell,'backgroundcolor',hcolor);
   set(handles.bw_drawcell,'string',sprintf('%.2f',st0.bw));
   set(handles.edit_ba_drawcell,'string',sprintf('%.2f',st0.ba));
   set(handles.slider_ba_drawcell,'value',st0.ba);
   if strcmpi(st0.o,'on')
      hcolor=st0.oc;
      set(handles.ol_on_drawcell,'value',1);
      set(handles.ow_drawcell,'enable','on','string',sprintf('%.2f',st0.ow));
      set(handles.r_edit_ol_drawcell,'enable','on','String',num2str(round(hcolor(1)*255)));
      set(handles.g_edit_ol_drawcell,'enable','on','String',num2str(round(hcolor(2)*255)));
      set(handles.b_edit_ol_drawcell,'enable','on','String',num2str(round(hcolor(3)*255)));
      set(handles.r_slider_ol_drawcell,'enable','on','value',hcolor(1)*255);
      set(handles.g_slider_ol_drawcell,'enable','on','value',hcolor(2)*255);
      set(handles.b_slider_ol_drawcell,'enable','on','value',hcolor(3)*255);
      set(handles.setcolor_ol_drawcell,'enable','on');
      set(handles.prev_ol_drawcell,'backgroundcolor',hcolor);
   end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drawcell wait for user response (see UIRESUME)
% uiwait(handles.drawcell);


% --- Outputs from this function are returned to the command line.
function varargout = drawcell_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function xmin_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to xmin_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value~=round(value)) 
   set(hObject,'string','0'); waitfor(msgbox('Please enter an integer.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of xmin_drawcell as text
%        str2double(get(hObject,'String')) returns contents of xmin_drawcell as a double


% --- Executes during object creation, after setting all properties.
function xmin_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmin_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xmax_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to xmax_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value~=round(value))
   set(hObject,'string','1'); waitfor(msgbox('Please enter an integer.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of xmax_drawcell as text
%        str2double(get(hObject,'String')) returns contents of xmax_drawcell as a double


% --- Executes during object creation, after setting all properties.
function xmax_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmax_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ymin_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to ymin_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value~=round(value))
   set(hObject,'string','0'); waitfor(msgbox('Please enter an integer.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of ymin_drawcell as text
%        str2double(get(hObject,'String')) returns contents of ymin_drawcell as a double


% --- Executes during object creation, after setting all properties.
function ymin_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymin_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ymax_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to ymax_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value~=round(value))
   set(hObject,'string','1'); waitfor(msgbox('Please enter an integer.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of ymax_drawcell as text
%        str2double(get(hObject,'String')) returns contents of ymax_drawcell as a double


% --- Executes during object creation, after setting all properties.
function ymax_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymax_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zmin_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to zmin_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value~=round(value))
   set(hObject,'string','0'); waitfor(msgbox('Please enter an integer.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of zmin_drawcell as text
%        str2double(get(hObject,'String')) returns contents of zmin_drawcell as a double


% --- Executes during object creation, after setting all properties.
function zmin_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmin_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zmax_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to zmax_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value~=round(value))
   set(hObject,'string','1'); waitfor(msgbox('Please enter an integer.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of zmax_drawcell as text
%        str2double(get(hObject,'String')) returns contents of zmax_drawcell as a double


% --- Executes during object creation, after setting all properties.
function zmax_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmax_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_or_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to x_or_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of x_or_drawcell as text
%        str2double(get(hObject,'String')) returns contents of x_or_drawcell as a double


% --- Executes during object creation, after setting all properties.
function x_or_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_or_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_or_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to y_or_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of y_or_drawcell as text
%        str2double(get(hObject,'String')) returns contents of y_or_drawcell as a double


% --- Executes during object creation, after setting all properties.
function y_or_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_or_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_or_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to z_or_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of z_or_drawcell as text
%        str2double(get(hObject,'String')) returns contents of z_or_drawcell as a double


% --- Executes during object creation, after setting all properties.
function z_or_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_or_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bw_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to bw_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0)
   set(hObject,'string','0.05'); waitfor(msgbox('Please enter a positive real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of bw_drawcell as text
%        str2double(get(hObject,'String')) returns contents of bw_drawcell as a double


% --- Executes during object creation, after setting all properties.
function bw_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bw_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_ba_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to slider_ba_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.edit_ba_drawcell,'string',sprintf('%4.2f',value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_ba_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_ba_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_ba_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ba_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.slider_ba_drawcell,'value',value);
else set(hObject,'string','1.00'); set(handles.slider_ba_drawcell,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of edit_ba_drawcell as text
%        str2double(get(hObject,'String')) returns contents of edit_ba_drawcell as a double


% --- Executes during object creation, after setting all properties.
function edit_ba_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ba_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function r_edit_bc_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to r_edit_bc_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.r_slider_bc_drawcell,'value',value);
   rvalue=str2double(get(handles.r_edit_bc_drawcell,'String'));
   gvalue=str2double(get(handles.g_edit_bc_drawcell,'String'));
   bvalue=str2double(get(handles.b_edit_bc_drawcell,'String'));
   set(handles.prev_bc_drawcell,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.r_slider_bc_drawcell,'value');
   set(hObject,'string',num2str(round(value))); set(handles.r_slider_bc_drawcell,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of r_edit_bc_drawcell as text
%        str2double(get(hObject,'String')) returns contents of r_edit_bc_drawcell as a double


% --- Executes during object creation, after setting all properties.
function r_edit_bc_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_edit_bc_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g_edit_bc_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to g_edit_bc_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.g_slider_bc_drawcell,'value',value);
   rvalue=str2double(get(handles.r_edit_bc_drawcell,'String'));
   gvalue=str2double(get(handles.g_edit_bc_drawcell,'String'));
   bvalue=str2double(get(handles.b_edit_bc_drawcell,'String'));
   set(handles.prev_bc_drawcell,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.g_slider_bc_drawcell,'value');
   set(hObject,'string',num2str(round(value))); set(handles.g_slider_bc_drawcell,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of g_edit_bc_drawcell as text
%        str2double(get(hObject,'String')) returns contents of g_edit_bc_drawcell as a double


% --- Executes during object creation, after setting all properties.
function g_edit_bc_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_edit_bc_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_edit_bc_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to b_edit_bc_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.b_slider_bc_drawcell,'value',value);
   rvalue=str2double(get(handles.r_edit_bc_drawcell,'String'));
   gvalue=str2double(get(handles.g_edit_bc_drawcell,'String'));
   bvalue=str2double(get(handles.b_edit_bc_drawcell,'String'));
   set(handles.prev_bc_drawcell,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.b_slider_bc_drawcell,'value');
   set(hObject,'string',num2str(round(value))); set(handles.b_slider_bc_drawcell,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of b_edit_bc_drawcell as text
%        str2double(get(hObject,'String')) returns contents of b_edit_bc_drawcell as a double


% --- Executes during object creation, after setting all properties.
function b_edit_bc_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_edit_bc_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function r_slider_bc_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to r_slider_bc_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.r_edit_bc_drawcell,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_bc_drawcell,'String'));
gvalue=str2double(get(handles.g_edit_bc_drawcell,'String'));
bvalue=str2double(get(handles.b_edit_bc_drawcell,'String'));
set(handles.prev_bc_drawcell,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function r_slider_bc_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_slider_bc_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function g_slider_bc_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to g_slider_bc_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.g_edit_bc_drawcell,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_bc_drawcell,'String'));
gvalue=str2double(get(handles.g_edit_bc_drawcell,'String'));
bvalue=str2double(get(handles.b_edit_bc_drawcell,'String'));
set(handles.prev_bc_drawcell,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function g_slider_bc_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_slider_bc_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function b_slider_bc_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to b_slider_bc_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.b_edit_bc_drawcell,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_bc_drawcell,'String'));
gvalue=str2double(get(handles.g_edit_bc_drawcell,'String'));
bvalue=str2double(get(handles.b_edit_bc_drawcell,'String'));
set(handles.prev_bc_drawcell,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function b_slider_bc_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_slider_bc_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in setcolor_bc_drawcell.
function setcolor_bc_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to setcolor_bc_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.r_edit_bc_drawcell,'String'));
gvalue=str2double(get(handles.g_edit_bc_drawcell,'String'));
bvalue=str2double(get(handles.b_edit_bc_drawcell,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.r_edit_bc_drawcell,'String',num2str(round(hcolor(1)*255)));
   set(handles.g_edit_bc_drawcell,'String',num2str(round(hcolor(2)*255)));
   set(handles.b_edit_bc_drawcell,'String',num2str(round(hcolor(3)*255)));
   set(handles.r_slider_bc_drawcell,'value',hcolor(1)*255);
   set(handles.g_slider_bc_drawcell,'value',hcolor(2)*255);
   set(handles.b_slider_bc_drawcell,'value',hcolor(3)*255);
   set(handles.prev_bc_drawcell,'backgroundcolor',hcolor);
end

% --- Executes on button press in OK_drawcell.
function OK_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to OK_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'userdata');
if get(handles.rb3_rn_drawcell,'value')==1
   xmin=str2double(get(handles.xmin_drawcell,'string'));
   xmax=str2double(get(handles.xmax_drawcell,'string'));
   ymin=str2double(get(handles.ymin_drawcell,'string'));
   ymax=str2double(get(handles.ymax_drawcell,'string'));
   zmin=str2double(get(handles.zmin_drawcell,'string'));
   zmax=str2double(get(handles.zmax_drawcell,'string'));
   if (xmax<=xmin)||(ymax<=ymin)||(zmax<=zmin) waitfor(msgbox('xmax, ymax and zmax must be greater than the corresponding xmin, ymin or zmin.','Figuretool2')); return; end
   st0.rn=[xmin,xmax,ymin,ymax,zmin,zmax];
elseif get(handles.rb1_rn_drawcell,'value')==1 st0.rn='automatic';
elseif get(handles.rb2_rn_drawcell,'value')==1 st0.rn='unitcell';
end
st0.or=[str2double(get(handles.x_or_drawcell,'string')),str2double(get(handles.y_or_drawcell,'string')),str2double(get(handles.z_or_drawcell,'string'))];
if get(handles.rb1_or_drawcell,'value')==1 st0.ct='Cartesian';
elseif get(handles.rb2_or_drawcell,'value')==1 st0.ct='direct';
end
if get(handles.rb1_bt_drawcell,'value')==1 st0.bt='regular';
elseif get(handles.rb2_bt_drawcell,'value')==1 st0.bt='dashed';
   st0.dl=[str2double(get(handles.dl1_drawcell,'string')),str2double(get(handles.dl2_drawcell,'string'))];
end
rvalue=get(handles.r_slider_bc_drawcell,'value');
gvalue=get(handles.g_slider_bc_drawcell,'value');
bvalue=get(handles.b_slider_bc_drawcell,'value');
st0.bc=[rvalue,gvalue,bvalue]/255;
rvalue=get(handles.r_slider_ol_drawcell,'value');
gvalue=get(handles.g_slider_ol_drawcell,'value');
bvalue=get(handles.b_slider_ol_drawcell,'value');
st0.oc=[rvalue,gvalue,bvalue]/255;
if get(handles.ol_on_drawcell,'value')==1 st0.o='on'; else st0.o='off'; end
st0.ow=str2double(get(handles.ow_drawcell,'string'));
st0.bw=str2double(get(handles.bw_drawcell,'string'));
st0.ba=get(handles.slider_ba_drawcell,'value');
set(get(hObject,'parent'),'userdata',st0);
uiresume;

% --- Executes on button press in cancel_drawcell.
function cancel_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes on button press in advanced_drawcell.
function advanced_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to advanced_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'Userdata');
h0=adv_settings('Userdata',{st0.lp,[0.4,0.6,0.9,10],st0.res,st0.fl});
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

% --- Executes on button press in ol_on_drawcell.
function ol_on_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to ol_on_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'value')==1
   set(handles.ow_drawcell,'enable','on');
   set(handles.r_edit_ol_drawcell,'enable','on');
   set(handles.g_edit_ol_drawcell,'enable','on');
   set(handles.b_edit_ol_drawcell,'enable','on');
   set(handles.r_slider_ol_drawcell,'enable','on');
   set(handles.g_slider_ol_drawcell,'enable','on');
   set(handles.b_slider_ol_drawcell,'enable','on');
   set(handles.setcolor_ol_drawcell,'enable','on');
else
   set(handles.ow_drawcell,'enable','off');
   set(handles.r_edit_ol_drawcell,'enable','off');
   set(handles.g_edit_ol_drawcell,'enable','off');
   set(handles.b_edit_ol_drawcell,'enable','off');
   set(handles.r_slider_ol_drawcell,'enable','off');
   set(handles.g_slider_ol_drawcell,'enable','off');
   set(handles.b_slider_ol_drawcell,'enable','off');
   set(handles.setcolor_ol_drawcell,'enable','off');
end
% Hint: get(hObject,'Value') returns toggle state of ol_on_drawcell



function ow_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to ow_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ow_drawcell as text
%        str2double(get(hObject,'String')) returns contents of ow_drawcell as a double


% --- Executes during object creation, after setting all properties.
function ow_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ow_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function r_edit_ol_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to r_edit_ol_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.r_slider_ol_drawcell,'value',value);
   rvalue=str2double(get(handles.r_edit_ol_drawcell,'String'));
   gvalue=str2double(get(handles.g_edit_ol_drawcell,'String'));
   bvalue=str2double(get(handles.b_edit_ol_drawcell,'String'));
   set(handles.prev_ol_drawcell,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.r_slider_ol_drawcell,'value');
   set(hObject,'string',num2str(round(value))); set(handles.r_slider_ol_drawcell,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of r_edit_ol_drawcell as text
%        str2double(get(hObject,'String')) returns contents of r_edit_ol_drawcell as a double


% --- Executes during object creation, after setting all properties.
function r_edit_ol_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_edit_ol_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g_edit_ol_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to g_edit_ol_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.g_slider_ol_drawcell,'value',value);
   rvalue=str2double(get(handles.r_edit_ol_drawcell,'String'));
   gvalue=str2double(get(handles.g_edit_ol_drawcell,'String'));
   bvalue=str2double(get(handles.b_edit_ol_drawcell,'String'));
   set(handles.prev_ol_drawcell,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.g_slider_ol_drawcell,'value');
   set(hObject,'string',num2str(round(value))); set(handles.g_slider_ol_drawcell,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of g_edit_ol_drawcell as text
%        str2double(get(hObject,'String')) returns contents of g_edit_ol_drawcell as a double


% --- Executes during object creation, after setting all properties.
function g_edit_ol_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_edit_ol_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_edit_ol_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to b_edit_ol_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.b_slider_ol_drawcell,'value',value);
   rvalue=str2double(get(handles.r_edit_ol_drawcell,'String'));
   gvalue=str2double(get(handles.g_edit_ol_drawcell,'String'));
   bvalue=str2double(get(handles.b_edit_ol_drawcell,'String'));
   set(handles.prev_ol_drawcell,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.b_slider_ol_drawcell,'value');
   set(hObject,'string',num2str(round(value))); set(handles.b_slider_ol_drawcell,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of b_edit_ol_drawcell as text
%        str2double(get(hObject,'String')) returns contents of b_edit_ol_drawcell as a double


% --- Executes during object creation, after setting all properties.
function b_edit_ol_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_edit_ol_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function r_slider_ol_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to r_slider_ol_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.r_edit_ol_drawcell,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_ol_drawcell,'String'));
gvalue=str2double(get(handles.g_edit_ol_drawcell,'String'));
bvalue=str2double(get(handles.b_edit_ol_drawcell,'String'));
set(handles.prev_ol_drawcell,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function r_slider_ol_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_slider_ol_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function g_slider_ol_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to g_slider_ol_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.g_edit_ol_drawcell,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_ol_drawcell,'String'));
gvalue=str2double(get(handles.g_edit_ol_drawcell,'String'));
bvalue=str2double(get(handles.b_edit_ol_drawcell,'String'));
set(handles.prev_ol_drawcell,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function g_slider_ol_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_slider_ol_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function b_slider_ol_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to b_slider_ol_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.b_edit_ol_drawcell,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_ol_drawcell,'String'));
gvalue=str2double(get(handles.g_edit_ol_drawcell,'String'));
bvalue=str2double(get(handles.b_edit_ol_drawcell,'String'));
set(handles.prev_ol_drawcell,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function b_slider_ol_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_slider_ol_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in setcolor_ol_drawcell.
function setcolor_ol_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to setcolor_ol_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.r_edit_ol_drawcell,'String'));
gvalue=str2double(get(handles.g_edit_ol_drawcell,'String'));
bvalue=str2double(get(handles.b_edit_ol_drawcell,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.r_edit_ol_drawcell,'String',num2str(round(hcolor(1)*255)));
   set(handles.g_edit_ol_drawcell,'String',num2str(round(hcolor(2)*255)));
   set(handles.b_edit_ol_drawcell,'String',num2str(round(hcolor(3)*255)));
   set(handles.r_slider_ol_drawcell,'value',hcolor(1)*255);
   set(handles.g_slider_ol_drawcell,'value',hcolor(2)*255);
   set(handles.b_slider_ol_drawcell,'value',hcolor(3)*255);
   set(handles.prev_ol_drawcell,'backgroundcolor',hcolor);
end


function dl1_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to dl1_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0)||(value~=round(value))
   set(hObject,'string','2'); waitfor(msgbox('Please enter a positive integer.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of dl1_drawcell as text
%        str2double(get(hObject,'String')) returns contents of dl1_drawcell as a double


% --- Executes during object creation, after setting all properties.
function dl1_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dl1_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dl2_drawcell_Callback(hObject, eventdata, handles)
% hObject    handle to dl2_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0)||(value~=round(value))
   set(hObject,'string','1'); waitfor(msgbox('Please enter a positive integer.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of dl2_drawcell as text
%        str2double(get(hObject,'String')) returns contents of dl2_drawcell as a double


% --- Executes during object creation, after setting all properties.
function dl2_drawcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dl2_drawcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in rn_drawcell.
function rn_drawcell_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in rn_drawcell 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb3_rn_drawcell')
   set(handles.xmin_drawcell,'enable','on');
   set(handles.xmax_drawcell,'enable','on');
   set(handles.ymin_drawcell,'enable','on');
   set(handles.ymax_drawcell,'enable','on');
   set(handles.zmin_drawcell,'enable','on');
   set(handles.zmax_drawcell,'enable','on');
elseif strcmpi(get(eventdata.OldValue,'tag'),'rb3_rn_drawcell')
   set(handles.xmin_drawcell,'enable','off');
   set(handles.xmax_drawcell,'enable','off');
   set(handles.ymin_drawcell,'enable','off');
   set(handles.ymax_drawcell,'enable','off');
   set(handles.zmin_drawcell,'enable','off');
   set(handles.zmax_drawcell,'enable','off');
end


% --- Executes when selected object is changed in bt_drawcell.
function bt_drawcell_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in bt_drawcell 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb2_bt_drawcell')
   set(handles.dl1_drawcell,'enable','on');
   set(handles.dl2_drawcell,'enable','on');
elseif strcmpi(get(eventdata.OldValue,'tag'),'rb2_bt_drawcell')
   set(handles.dl1_drawcell,'enable','off');
   set(handles.dl2_drawcell,'enable','off');
end
