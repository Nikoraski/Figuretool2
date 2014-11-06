function varargout = drawbond(varargin)
% DRAWBOND MATLAB code for drawbond.fig
%      DRAWBOND, by itself, creates a new DRAWBOND or raises the existing
%      singleton*.
%
%      H = DRAWBOND returns the handle to a new DRAWBOND or the handle to
%      the existing singleton*.
%
%      DRAWBOND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWBOND.M with the given input arguments.
%
%      DRAWBOND('Property','Value',...) creates a new DRAWBOND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drawbond_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drawbond_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drawbond

% Last Modified by GUIDE v2.5 01-Oct-2014 13:13:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @drawbond_OpeningFcn, ...
                   'gui_OutputFcn',  @drawbond_OutputFcn, ...
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


% --- Executes just before drawbond is made visible.
function drawbond_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawbond (see VARARGIN)

% Choose default command line output for drawbond
global globallp globalfl;
handles.output = hObject;
if isempty(get(hObject,'Userdata'))
st0=struct('function','drawbond','site1','','site2','','bc','default','rn','default','bw',0.15,'ba',1.00,'bt','regular',...
   'w','off','bs',0.1,'dl',[2,1],'o','off','ow',0.05,'oc',[1,1,1],'fl',globalfl,'lp',globallp,'res','default');
set(hObject,'Userdata',st0);
else
   st0=get(hObject,'Userdata');
   set(handles.site1_edit_drawbond,'string',st0.site1);
   set(handles.site2_edit_drawbond,'string',st0.site2);
   if isnumeric(st0.bc)&&(numel(st0.bc)==3)
      set(handles.color_def_rb1_drawbond,'enable','off');
      set(handles.color_def_rb2_drawbond,'enable','off');
      set(handles.color_def_rb3_drawbond,'enable','off');
      set(handles.color_def_rb4_drawbond,'enable','off');
      set(handles.color_def_rb5_drawbond,'enable','off');
      set(handles.color_def_rb6_drawbond,'enable','off');
      set(handles.color_def_rb7_drawbond,'enable','off');
      set(handles.color_def_define_drawbond,'enable','off');
      set(handles.color_rb2_drawbond,'value',1);
      hcolor=st0.bc;
      set(handles.color_r_edit_drawbond,'enable','on','String',num2str(round(hcolor(1)*255)));
      set(handles.color_g_edit_drawbond,'enable','on','String',num2str(round(hcolor(2)*255)));
      set(handles.color_b_edit_drawbond,'enable','on','String',num2str(round(hcolor(3)*255)));
      set(handles.color_r_slider_drawbond,'enable','on','value',hcolor(1)*255);
      set(handles.color_g_slider_drawbond,'enable','on','value',hcolor(2)*255);
      set(handles.color_b_slider_drawbond,'enable','on','value',hcolor(3)*255);
      set(handles.color_setcolor_drawbond,'enable','on');
      set(handles.color_prev_drawbond,'backgroundcolor',hcolor);
   else
      set(handles.color_rb1_drawbond,'value',1);
      if isnumeric(st0.bc) set(handles.color_def_rb7_drawbond,'value',1);
         set(handles.color_def_define_drawbond,'enable','on','Userdata',[num2cell(st0.bc),{'Site 1 end color:','Site 2 end color:','Figuretool2: drawbond'}]);
      else
         switch st0.bc
            case 'default', set(handles.color_def_rb1_drawbond,'value',1);
            case 'light', set(handles.color_def_rb2_drawbond,'value',1);
            case 'dark', set(handles.color_def_rb3_drawbond,'value',1);
            case 'inverse', set(handles.color_def_rb4_drawbond,'value',1);
            case 'verylight', set(handles.color_def_rb5_drawbond,'value',1);
            case 'verydark', set(handles.color_def_rb6_drawbond,'value',1);
         end
      end
   end
   if isnumeric(st0.rn)
      set(handles.range_rb2_drawbond,'value',1);
      set(handles.range_dmin_drawbond,'enable','on','string',sprintf('%.2f',st0.rn(1)));
      set(handles.range_dmax_drawbond,'enable','on','string',sprintf('%.2f',st0.rn(2)));
   end
   set(handles.width_drawbond,'string',sprintf('%.2f',st0.bw));
   set(handles.alpha_edit_drawbond,'string',sprintf('%.2f',st0.ba));
   set(handles.alpha_slider_drawbond,'value',st0.ba);
   switch st0.bt
      case 'regular', set(handles.type_rb1_drawbond,'value',1);
      case 'dashed', set(handles.type_rb2_drawbond,'value',1);
         set(handles.dl1_drawbond,'enable','on','string',num2str(st0.dl(1)));
         set(handles.dl2_drawbond,'enable','on','string',num2str(st0.dl(2)));
      case 'double', set(handles.type_rb3_drawbond,'value',1);
         set(handles.bs_drawbond,'enable','on','string',sprintf('%.2f',st0.bs));
         set(handles.wedged_drawbond,'enable','off');
      case 'triple', set(handles.type_rb4_drawbond,'value',1);
         set(handles.bs_drawbond,'enable','on','string',sprintf('%.2f',st0.bs));
         set(handles.wedged_drawbond,'enable','off');
   end
   if strcmpi(st0.w,'on') set(handles.wedged_drawbond,'value',1); end
   if strcmpi(st0.o,'on')
      hcolor=st0.oc;
      set(handles.ol_on_drawbond,'value',1);
      set(handles.ol_width_drawbond,'enable','on','string',sprintf('%.2f',st0.ow));
      set(handles.ol_r_edit_drawbond,'enable','on','string',num2str(round(hcolor(1)*255)));
      set(handles.ol_g_edit_drawbond,'enable','on','string',num2str(round(hcolor(2)*255)));
      set(handles.ol_b_edit_drawbond,'enable','on','string',num2str(round(hcolor(3)*255)));
      set(handles.ol_r_slider_drawbond,'enable','on','value',hcolor(1)*255);
      set(handles.ol_g_slider_drawbond,'enable','on','value',hcolor(2)*255);
      set(handles.ol_b_slider_drawbond,'enable','on','value',hcolor(3)*255);
      set(handles.ol_setcolor_drawbond,'enable','on');
      set(handles.ol_prev_drawbond,'backgroundcolor',hcolor);
   end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drawbond wait for user response (see UIRESUME)
% uiwait(handles.drawbond);


% --- Outputs from this function are returned to the command line.
function varargout = drawbond_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_drawbond.
function OK_drawbond_Callback(hObject, eventdata, handles)
temp=get(handles.site1_edit_drawbond,'string');
if isempty(temp) waitfor(msgbox('Please specify the atoms for bond drawing in Site1.','Figuretool2')); return; end
[stackin,~,status]=siterefparser(temp);
if (status==0)||~strcmp(stackin,'B') waitfor(msgbox('The specified atom group site1 is invalid.','Figuretool2')); return; end
temp2=get(handles.site2_edit_drawbond,'string');
[stackin,~,status]=siterefparser(temp2);
if ~isempty(temp2)&&((status==0)||~strcmp(stackin,'B')) waitfor(msgbox('The specified atom group site2 is invalid.','Figuretool2')); return; end
st0=get(get(hObject,'parent'),'UserData');
st0.site1=temp;
st0.site2=temp2;
if get(handles.color_rb1_drawbond,'value')==1
   if get(handles.color_def_rb1_drawbond,'value')==1 st0.bc='default';
   elseif get(handles.color_def_rb2_drawbond,'value')==1 st0.bc='light';
   elseif get(handles.color_def_rb3_drawbond,'value')==1 st0.bc='dark';
   elseif get(handles.color_def_rb4_drawbond,'value')==1 st0.bc='inverse';
   elseif get(handles.color_def_rb5_drawbond,'value')==1 st0.bc='verylight';
   elseif get(handles.color_def_rb6_drawbond,'value')==1 st0.bc='verydark';
   else temp=get(handles.color_def_define_drawbond,'Userdata');
      if isempty(temp) waitfor(msgbox('Please specify the colors for drawing two-colored bonds.','Figuretool2')); return;
      else st0.bc=cell2mat(temp(1:6));
      end
   end
elseif get(handles.color_rb2_drawbond,'value')==1
   rvalue=get(handles.color_r_slider_drawbond,'value');
   gvalue=get(handles.color_g_slider_drawbond,'value');
   bvalue=get(handles.color_b_slider_drawbond,'value');
   st0.bc=[rvalue,gvalue,bvalue]/255;
end
if get(handles.range_rb1_drawbond,'value')==1
   st0.rn='default';
else dmin=str2double(get(handles.range_dmin_drawbond,'string')); dmax=str2double(get(handles.range_dmax_drawbond,'string'));
   if dmin>=dmax waitfor(msgbox('Minimum distance must be shorter than maximum distance!','Figuretool2')); return;
   else st0.rn=[dmin,dmax];
   end
end
st0.bw=str2double(get(handles.width_drawbond,'string'));
st0.ba=get(handles.alpha_slider_drawbond,'value');
if get(handles.type_rb1_drawbond,'value')==1 st0.bt='regular';
elseif get(handles.type_rb2_drawbond,'value')==1 st0.bt='dashed';
   st0.dl=[str2double(get(handles.dl1_drawbond,'string')),str2double(get(handles.dl2_drawbond,'string'))];
elseif get(handles.type_rb3_drawbond,'value')==1 st0.bt='double';
   st0.bs=str2double(get(handles.bs_drawbond,'string'));
elseif get(handles.type_rb4_drawbond,'value')==1 st0.bt='triple';
   st0.bs=str2double(get(handles.bs_drawbond,'string'));
end
if get(handles.wedged_drawbond,'value')==1 st0.w='on'; end
if get(handles.ol_on_drawbond,'value')==0 st0.o='off';
else
   st0.o='on';
   st0.ow=str2double(get(handles.ol_width_drawbond,'string'));
   rvalue=get(handles.ol_r_slider_drawbond,'value');
   gvalue=get(handles.ol_g_slider_drawbond,'value');
   bvalue=get(handles.ol_b_slider_drawbond,'value');
   st0.oc=[rvalue,gvalue,bvalue]/255;
end
set(get(hObject,'parent'),'userdata',st0);
uiresume;

function site1_edit_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to site1_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of site1_edit_drawbond as text
%        str2double(get(hObject,'String')) returns contents of site1_edit_drawbond as a double


% --- Executes during object creation, after setting all properties.
function site1_edit_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to site1_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in site1_gredit_drawbond.
function site1_gredit_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to site1_gredit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.site1_edit_drawbond,'string');
[stackin,reflistin,status]=siterefparser(temp);
if status==0 h0=groupeditor;
else h0=groupeditor('userdata',{temp,stackin,reflistin});
end
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if strcmpi(temp,'cancelled') return; end
set(handles.site1_edit_drawbond,'string',temp);


function site2_edit_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to site2_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of site2_edit_drawbond as text
%        str2double(get(hObject,'String')) returns contents of site2_edit_drawbond as a double


% --- Executes during object creation, after setting all properties.
function site2_edit_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to site2_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in site2_gredit_drawbond.
function site2_gredit_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to site2_gredit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.site2_edit_drawbond,'string');
[stackin,reflistin,status]=siterefparser(temp);
if status==0 h0=groupeditor;
else h0=groupeditor('userdata',{temp,stackin,reflistin});
end
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if strcmpi(temp,'cancelled') return; end
set(handles.site2_edit_drawbond,'string',temp);


function dl1_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to dl1_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0)||(value~=round(value)) set(hObject,'string','2'); waitfor(msgbox('Please enter a positive integer.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of dl1_drawbond as text
%        str2double(get(hObject,'String')) returns contents of dl1_drawbond as a double


% --- Executes during object creation, after setting all properties.
function dl1_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dl1_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dl2_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to dl2_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0)||(value~=round(value)) set(hObject,'string','1'); waitfor(msgbox('Please enter a positive integer.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of dl2_drawbond as text
%        str2double(get(hObject,'String')) returns contents of dl2_drawbond as a double


% --- Executes during object creation, after setting all properties.
function dl2_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dl2_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bs_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to bs_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0) set(hObject,'string','0.1'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of bs_drawbond as text
%        str2double(get(hObject,'String')) returns contents of bs_drawbond as a double


% --- Executes during object creation, after setting all properties.
function bs_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bs_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function width_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to width_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0) set(hObject,'string','0.15'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of width_drawbond as text
%        str2double(get(hObject,'String')) returns contents of width_drawbond as a double


% --- Executes during object creation, after setting all properties.
function width_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to width_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range_dmin_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to range_dmin_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<0) set(hObject,'string','2.00'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of range_dmin_drawbond as text
%        str2double(get(hObject,'String')) returns contents of range_dmin_drawbond as a double


% --- Executes during object creation, after setting all properties.
function range_dmin_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range_dmin_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range_dmax_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to range_dmax_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<0) set(hObject,'string','4.00'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of range_dmax_drawbond as text
%        str2double(get(hObject,'String')) returns contents of range_dmax_drawbond as a double


% --- Executes during object creation, after setting all properties.
function range_dmax_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range_dmax_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ol_on_drawbond.
function ol_on_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to ol_on_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'value')==1
   set(handles.ol_width_drawbond,'enable','on');
   set(handles.ol_r_edit_drawbond,'enable','on');
   set(handles.ol_g_edit_drawbond,'enable','on');
   set(handles.ol_b_edit_drawbond,'enable','on');
   set(handles.ol_r_slider_drawbond,'enable','on');
   set(handles.ol_g_slider_drawbond,'enable','on');
   set(handles.ol_b_slider_drawbond,'enable','on');
   set(handles.ol_setcolor_drawbond,'enable','on');
else
   set(handles.ol_width_drawbond,'enable','off');
   set(handles.ol_r_edit_drawbond,'enable','off');
   set(handles.ol_g_edit_drawbond,'enable','off');
   set(handles.ol_b_edit_drawbond,'enable','off');
   set(handles.ol_r_slider_drawbond,'enable','off');
   set(handles.ol_g_slider_drawbond,'enable','off');
   set(handles.ol_b_slider_drawbond,'enable','off');
   set(handles.ol_setcolor_drawbond,'enable','off');
end
% Hint: get(hObject,'Value') returns toggle state of ol_on_drawbond



function ol_width_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to ol_width_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0) set(hObject,'string','0.05'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of ol_width_drawbond as text
%        str2double(get(hObject,'String')) returns contents of ol_width_drawbond as a double


% --- Executes during object creation, after setting all properties.
function ol_width_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_width_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ol_r_edit_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to ol_r_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.ol_r_slider_drawbond,'value',value);
   rvalue=str2double(get(handles.ol_r_edit_drawbond,'String'));
   gvalue=str2double(get(handles.ol_g_edit_drawbond,'String'));
   bvalue=str2double(get(handles.ol_b_edit_drawbond,'String'));
   set(handles.ol_prev_drawbond,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.ol_r_slider_drawbond,'value');
   set(hObject,'string',num2str(round(value))); set(handles.ol_r_slider_drawbond,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of ol_r_edit_drawbond as text
%        str2double(get(hObject,'String')) returns contents of ol_r_edit_drawbond as a double


% --- Executes during object creation, after setting all properties.
function ol_r_edit_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_r_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ol_g_edit_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to ol_g_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.ol_g_slider_drawbond,'value',value);
   rvalue=str2double(get(handles.ol_r_edit_drawbond,'String'));
   gvalue=str2double(get(handles.ol_g_edit_drawbond,'String'));
   bvalue=str2double(get(handles.ol_b_edit_drawbond,'String'));
   set(handles.ol_prev_drawbond,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.ol_g_slider_drawbond,'value');
   set(hObject,'string',num2str(round(value))); set(handles.ol_g_slider_drawbond,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of ol_g_edit_drawbond as text
%        str2double(get(hObject,'String')) returns contents of ol_g_edit_drawbond as a double


% --- Executes during object creation, after setting all properties.
function ol_g_edit_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_g_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ol_b_edit_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to ol_b_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.ol_b_slider_drawbond,'value',value);
   rvalue=str2double(get(handles.ol_r_edit_drawbond,'String'));
   gvalue=str2double(get(handles.ol_g_edit_drawbond,'String'));
   bvalue=str2double(get(handles.ol_b_edit_drawbond,'String'));
   set(handles.ol_prev_drawbond,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.ol_b_slider_drawbond,'value');
   set(hObject,'string',num2str(round(value))); set(handles.ol_b_slider_drawbond,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of ol_b_edit_drawbond as text
%        str2double(get(hObject,'String')) returns contents of ol_b_edit_drawbond as a double


% --- Executes during object creation, after setting all properties.
function ol_b_edit_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_b_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function ol_r_slider_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to ol_r_slider_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.ol_r_edit_drawbond,'string',num2str(round(value)));
rvalue=str2double(get(handles.ol_r_edit_drawbond,'String'));
gvalue=str2double(get(handles.ol_g_edit_drawbond,'String'));
bvalue=str2double(get(handles.ol_b_edit_drawbond,'String'));
set(handles.ol_prev_drawbond,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function ol_r_slider_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_r_slider_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function ol_g_slider_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to ol_g_slider_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.ol_g_edit_drawbond,'string',num2str(round(value)));
rvalue=str2double(get(handles.ol_r_edit_drawbond,'String'));
gvalue=str2double(get(handles.ol_g_edit_drawbond,'String'));
bvalue=str2double(get(handles.ol_b_edit_drawbond,'String'));
set(handles.ol_prev_drawbond,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function ol_g_slider_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_g_slider_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function ol_b_slider_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to ol_b_slider_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.ol_b_edit_drawbond,'string',num2str(round(value)));
rvalue=str2double(get(handles.ol_r_edit_drawbond,'String'));
gvalue=str2double(get(handles.ol_g_edit_drawbond,'String'));
bvalue=str2double(get(handles.ol_b_edit_drawbond,'String'));
set(handles.ol_prev_drawbond,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function ol_b_slider_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ol_b_slider_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in ol_setcolor_drawbond.
function ol_setcolor_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to ol_setcolor_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.ol_r_edit_drawbond,'String'));
gvalue=str2double(get(handles.ol_g_edit_drawbond,'String'));
bvalue=str2double(get(handles.ol_b_edit_drawbond,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.ol_r_edit_drawbond,'String',num2str(round(hcolor(1)*255)));
   set(handles.ol_g_edit_drawbond,'String',num2str(round(hcolor(2)*255)));
   set(handles.ol_b_edit_drawbond,'String',num2str(round(hcolor(3)*255)));
   set(handles.ol_r_slider_drawbond,'value',hcolor(1)*255);
   set(handles.ol_g_slider_drawbond,'value',hcolor(2)*255);
   set(handles.ol_b_slider_drawbond,'value',hcolor(3)*255);
   set(handles.ol_prev_drawbond,'backgroundcolor',hcolor);
end

% --- Executes on slider movement.
function alpha_slider_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_slider_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.alpha_edit_drawbond,'string',sprintf('%4.2f',value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function alpha_slider_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_slider_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function alpha_edit_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.alpha_slider_drawbond,'value',value);
else set(hObject,'string','1.00'); set(handles.alpha_slider_drawbond,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of alpha_edit_drawbond as text
%        str2double(get(hObject,'String')) returns contents of alpha_edit_drawbond as a double


% --- Executes during object creation, after setting all properties.
function alpha_edit_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cancel_drawbond.
function cancel_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes on button press in advanced_drawbond.
function advanced_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to advanced_drawbond (see GCBO)
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


function color_r_edit_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to color_r_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_r_slider_drawbond,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawbond,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawbond,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawbond,'String'));
   set(handles.color_prev_drawbond,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.color_r_slider_drawbond,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_r_slider_drawbond,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_r_edit_drawbond as text
%        str2double(get(hObject,'String')) returns contents of color_r_edit_drawbond as a double


% --- Executes during object creation, after setting all properties.
function color_r_edit_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_r_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function color_g_edit_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to color_g_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_g_slider_drawbond,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawbond,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawbond,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawbond,'String'));
   set(handles.color_prev_drawbond,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else
   value=get(handles.color_g_slider_drawbond,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_g_slider_drawbond,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_g_edit_drawbond as text
%        str2double(get(hObject,'String')) returns contents of color_g_edit_drawbond as a double


% --- Executes during object creation, after setting all properties.
function color_g_edit_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_g_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function color_b_edit_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to color_b_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.color_b_slider_drawbond,'value',value);
   rvalue=str2double(get(handles.color_r_edit_drawbond,'String'));
   gvalue=str2double(get(handles.color_g_edit_drawbond,'String'));
   bvalue=str2double(get(handles.color_b_edit_drawbond,'String'));
   set(handles.color_prev_drawbond,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.color_b_slider_drawbond,'value');
   set(hObject,'string',num2str(round(value))); set(handles.color_b_slider_drawbond,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of color_b_edit_drawbond as text
%        str2double(get(hObject,'String')) returns contents of color_b_edit_drawbond as a double


% --- Executes during object creation, after setting all properties.
function color_b_edit_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_b_edit_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function color_r_slider_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to color_r_slider_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_r_edit_drawbond,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawbond,'String'));
gvalue=str2double(get(handles.color_g_edit_drawbond,'String'));
bvalue=str2double(get(handles.color_b_edit_drawbond,'String'));
set(handles.color_prev_drawbond,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_r_slider_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_r_slider_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_g_slider_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to color_g_slider_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_g_edit_drawbond,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawbond,'String'));
gvalue=str2double(get(handles.color_g_edit_drawbond,'String'));
bvalue=str2double(get(handles.color_b_edit_drawbond,'String'));
set(handles.color_prev_drawbond,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_g_slider_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_g_slider_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_b_slider_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to color_b_slider_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.color_b_edit_drawbond,'string',num2str(round(value)));
rvalue=str2double(get(handles.color_r_edit_drawbond,'String'));
gvalue=str2double(get(handles.color_g_edit_drawbond,'String'));
bvalue=str2double(get(handles.color_b_edit_drawbond,'String'));
set(handles.color_prev_drawbond,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color_b_slider_drawbond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_b_slider_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in color_setcolor_drawbond.
function color_setcolor_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to color_setcolor_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.color_r_edit_drawbond,'String'));
gvalue=str2double(get(handles.color_g_edit_drawbond,'String'));
bvalue=str2double(get(handles.color_b_edit_drawbond,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.color_r_edit_drawbond,'String',num2str(round(hcolor(1)*255)));
   set(handles.color_g_edit_drawbond,'String',num2str(round(hcolor(2)*255)));
   set(handles.color_b_edit_drawbond,'String',num2str(round(hcolor(3)*255)));
   set(handles.color_r_slider_drawbond,'value',hcolor(1)*255);
   set(handles.color_g_slider_drawbond,'value',hcolor(2)*255);
   set(handles.color_b_slider_drawbond,'value',hcolor(3)*255);
   set(handles.color_prev_drawbond,'backgroundcolor',hcolor);
end

% --- Executes on button press in color_def_define_drawbond.
function color_def_define_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to color_def_define_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(hObject,'userdata');
if isempty(temp) temp={1,1,1,0,0,0,'Site 1 end color:','Site 2 end color:','Figuretool2: drawbond'}; end
h0=bicolordef('userdata',temp);
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
if strcmpi(temp,'cancelled') return; end
set(hObject,'userdata',temp);
delete(h0);

% --- Executes when selected object is changed in color_drawbond.
function color_drawbond_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in color_drawbond 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'color_rb1_drawbond')
   set(handles.color_def_rb1_drawbond,'enable','on');
   set(handles.color_def_rb2_drawbond,'enable','on');
   set(handles.color_def_rb3_drawbond,'enable','on');
   set(handles.color_def_rb4_drawbond,'enable','on');
   set(handles.color_def_rb5_drawbond,'enable','on');
   set(handles.color_def_rb6_drawbond,'enable','on');
   set(handles.color_def_rb7_drawbond,'enable','on');
   if get(handles.color_def_rb7_drawbond,'value')==1 set(handles.color_def_define_drawbond,'enable','on'); end
   set(handles.color_r_edit_drawbond,'enable','off');
   set(handles.color_g_edit_drawbond,'enable','off');
   set(handles.color_b_edit_drawbond,'enable','off');
   set(handles.color_r_slider_drawbond,'enable','off');
   set(handles.color_g_slider_drawbond,'enable','off');
   set(handles.color_b_slider_drawbond,'enable','off');
   set(handles.color_setcolor_drawbond,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'color_rb2_drawbond')
   set(handles.color_def_rb1_drawbond,'enable','off');
   set(handles.color_def_rb2_drawbond,'enable','off');
   set(handles.color_def_rb3_drawbond,'enable','off');
   set(handles.color_def_rb4_drawbond,'enable','off');
   set(handles.color_def_rb5_drawbond,'enable','off');
   set(handles.color_def_rb6_drawbond,'enable','off');
   set(handles.color_def_rb7_drawbond,'enable','off');
   set(handles.color_def_define_drawbond,'enable','off');
   set(handles.color_r_edit_drawbond,'enable','on');
   set(handles.color_g_edit_drawbond,'enable','on');
   set(handles.color_b_edit_drawbond,'enable','on');
   set(handles.color_r_slider_drawbond,'enable','on');
   set(handles.color_g_slider_drawbond,'enable','on');
   set(handles.color_b_slider_drawbond,'enable','on');
   set(handles.color_setcolor_drawbond,'enable','on');
end

% --- Executes when selected object is changed in def_color_drawbond.
function def_color_drawbond_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in def_color_drawbond 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'color_def_rb7_drawbond')
   set(handles.color_def_define_drawbond,'enable','on');
elseif strcmpi(get(eventdata.OldValue,'tag'),'color_def_rb7_drawbond')
   set(handles.color_def_define_drawbond,'enable','off');
end

% --- Executes when selected object is changed in range_drawbond.
function range_drawbond_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in range_drawbond 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'range_rb1_drawbond')
   set(handles.range_dmin_drawbond,'enable','off');
   set(handles.range_dmax_drawbond,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'range_rb2_drawbond')
   set(handles.range_dmin_drawbond,'enable','on');
   set(handles.range_dmax_drawbond,'enable','on');
end
   
% --- Executes when selected object is changed in type_drawbond.
function type_drawbond_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in type_drawbond 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'type_rb1_drawbond')
   set(handles.dl1_drawbond,'enable','off');
   set(handles.dl2_drawbond,'enable','off');
   set(handles.bs_drawbond,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'type_rb2_drawbond')
   set(handles.dl1_drawbond,'enable','on');
   set(handles.dl2_drawbond,'enable','on');
   set(handles.bs_drawbond,'enable','off');
else
   set(handles.dl1_drawbond,'enable','off');
   set(handles.dl2_drawbond,'enable','off');
   set(handles.bs_drawbond,'enable','on');
   set(handles.wedged_drawbond,'enable','off','value',0);
end


% --- Executes on button press in wedged_drawbond.
function wedged_drawbond_Callback(hObject, eventdata, handles)
% hObject    handle to wedged_drawbond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of wedged_drawbond
