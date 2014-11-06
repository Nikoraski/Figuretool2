function varargout = inserttext(varargin)
% INSERTTEXT MATLAB code for inserttext.fig
%      INSERTTEXT, by itself, creates a new INSERTTEXT or raises the existing
%      singleton*.
%
%      H = INSERTTEXT returns the handle to a new INSERTTEXT or the handle to
%      the existing singleton*.
%
%      INSERTTEXT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INSERTTEXT.M with the given input arguments.
%
%      INSERTTEXT('Property','Value',...) creates a new INSERTTEXT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before inserttext_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to inserttext_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help inserttext

% Last Modified by GUIDE v2.5 03-Nov-2014 22:27:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @inserttext_OpeningFcn, ...
                   'gui_OutputFcn',  @inserttext_OutputFcn, ...
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


% --- Executes just before inserttext is made visible.
function inserttext_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to inserttext (see VARARGIN)

% Choose default command line output for inserttext
handles.output = hObject;
if isempty(get(hObject,'Userdata'))
st0=struct('function','inserttext','str','','dist',1,'tex','on','tc',[0,0,0],'al','left','tfn','Helvetica','tfs',10,'tfa','normal','tfw','normal');
set(hObject,'Userdata',st0);
else
   st0=get(hObject,'Userdata');
   set(handles.text_inserttext,'string',st0.str);
   set(handles.dist_inserttext,'string',num2str(st0.dist));
   set(handles.fontname_inserttext,'string',st0.tfn);
   set(handles.fontsize_inserttext,'string',num2str(st0.tfs));
   if strcmpi(st0.tfw,'normal')&&strcmpi(st0.tfa,'normal')
      set(handles.fontstyle_inserttext,'string','plain');
   elseif strcmpi(st0.tfw,'bold')&&strcmpi(st0.tfa,'normal')
      set(handles.fontstyle_inserttext,'string','bold');
   elseif strcmpi(st0.tfw,'normal')&&strcmpi(st0.tfa,'italic')
      set(handles.fontstyle_inserttext,'string','italic');
   elseif strcmpi(st0.tfw,'bold')&&strcmpi(st0.tfa,'italic')
      set(handles.fontstyle_inserttext,'string','bold italic');
   end
   if strcmpi(st0.tex,'off') set(handles.usetex_inserttext,'value',0); end
   hcolor=st0.tc;
   set(handles.edit_r_inserttext,'string',num2str(round(hcolor(1)*255)));
   set(handles.edit_g_inserttext,'string',num2str(round(hcolor(2)*255)));
   set(handles.edit_b_inserttext,'string',num2str(round(hcolor(3)*255)));
   set(handles.slider_r_inserttext,'value',hcolor(1)*255);
   set(handles.slider_g_inserttext,'value',hcolor(2)*255);
   set(handles.slider_b_inserttext,'value',hcolor(3)*255);
   set(handles.prev_inserttext,'backgroundcolor',hcolor);
   if strcmpi(st0.al,'center') set(handles.rb2_al_inserttext,'value',1);
   elseif strcmpi(st0.al,'right') set(handles.rb3_al_inserttext,'value',1);
   end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes inserttext wait for user response (see UIRESUME)
% uiwait(handles.inserttext);


% --- Outputs from this function are returned to the command line.
function varargout = inserttext_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_inserttext.
function OK_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to OK_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'UserData');
st0.str=get(handles.text_inserttext,'string');
if isempty(st0.str) waitfor(msgbox('Please enter the text to be displayed.','Figuretool2')); return; end
if get(handles.usetex_inserttext,'value')==1 st0.tex='on'; else st0.tex='off'; end
st0.dist=str2double(get(handles.dist_inserttext,'string'));
st0.tfn=get(handles.fontname_inserttext,'string');
st0.tfs=str2double(get(handles.fontsize_inserttext,'string'));
fontstyle=get(handles.fontstyle_inserttext,'string');
if strcmpi(fontstyle,'plain') st0.tfw='normal'; st0.tfa='normal';
elseif strcmpi(fontstyle,'bold') st0.tfw='bold'; st0.tfa='normal';
elseif strcmpi(fontstyle,'italic') st0.tfw='normal'; st0.tfa='italic';
elseif strcmpi(fontstyle,'bond italic') st0.tfw='bold'; st0.tfa='italic';
end
rvalue=get(handles.slider_r_inserttext,'value');
gvalue=get(handles.slider_g_inserttext,'value');
bvalue=get(handles.slider_b_inserttext,'value');
st0.tc=[rvalue,gvalue,bvalue]/255;
if get(handles.rb1_al_inserttext,'value')==1 st0.al='left';
elseif get(handles.rb2_al_inserttext,'value')==1 st0.al='center';
elseif get(handles.rb3_al_inserttext,'value')==1 st0.al='right';
end
set(get(hObject,'parent'),'userdata',st0);
uiresume;

% --- Executes on button press in cancel_inserttext.
function cancel_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;


function edit_r_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to edit_r_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_r_inserttext as text
%        str2double(get(hObject,'String')) returns contents of edit_r_inserttext as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.slider_r_inserttext,'value',value);
   rvalue=str2double(get(handles.edit_r_inserttext,'String'));
   gvalue=str2double(get(handles.edit_g_inserttext,'String'));
   bvalue=str2double(get(handles.edit_b_inserttext,'String'));
   set(handles.prev_inserttext,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.slider_r_inserttext,'value');
   set(hObject,'string',num2str(round(value))); set(handles.slider_r_inserttext,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit_r_inserttext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_r_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_g_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to edit_g_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_g_inserttext as text
%        str2double(get(hObject,'String')) returns contents of edit_g_inserttext as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.slider_g_inserttext,'value',value);
   rvalue=str2double(get(handles.edit_r_inserttext,'String'));
   gvalue=str2double(get(handles.edit_g_inserttext,'String'));
   bvalue=str2double(get(handles.edit_b_inserttext,'String'));
   set(handles.prev_inserttext,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.slider_g_inserttext,'value');
   set(hObject,'string',num2str(round(value))); set(handles.slider_g_inserttext,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit_g_inserttext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_g_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b_inserttext as text
%        str2double(get(hObject,'String')) returns contents of edit_b_inserttext as a double
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.slider_b_inserttext,'value',value);
   rvalue=str2double(get(handles.edit_r_inserttext,'String'));
   gvalue=str2double(get(handles.edit_g_inserttext,'String'));
   bvalue=str2double(get(handles.edit_b_inserttext,'String'));
   set(handles.prev_inserttext,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.slider_b_inserttext,'value');
   set(hObject,'string',num2str(round(value))); set(handles.slider_b_inserttext,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end

% --- Executes during object creation, after setting all properties.
function edit_b_inserttext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_r_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to slider_r_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit_r_inserttext,'string',num2str(round(value)));
rvalue=str2double(get(handles.edit_r_inserttext,'String'));
gvalue=str2double(get(handles.edit_g_inserttext,'String'));
bvalue=str2double(get(handles.edit_b_inserttext,'String'));
set(handles.prev_inserttext,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% --- Executes during object creation, after setting all properties.
function slider_r_inserttext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_r_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_g_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to slider_g_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit_g_inserttext,'string',num2str(round(value)));
rvalue=str2double(get(handles.edit_r_inserttext,'String'));
gvalue=str2double(get(handles.edit_g_inserttext,'String'));
bvalue=str2double(get(handles.edit_b_inserttext,'String'));
set(handles.prev_inserttext,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% --- Executes during object creation, after setting all properties.
function slider_g_inserttext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_g_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_b_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to slider_b_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'value');
set(handles.edit_b_inserttext,'string',num2str(round(value)));
rvalue=str2double(get(handles.edit_r_inserttext,'String'));
gvalue=str2double(get(handles.edit_g_inserttext,'String'));
bvalue=str2double(get(handles.edit_b_inserttext,'String'));
set(handles.prev_inserttext,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);

% --- Executes during object creation, after setting all properties.
function slider_b_inserttext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_b_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in setcolor_inserttext.
function setcolor_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to setcolor_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.edit_r_inserttext,'String'));
gvalue=str2double(get(handles.edit_g_inserttext,'String'));
bvalue=str2double(get(handles.edit_b_inserttext,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.edit_r_inserttext,'String',num2str(round(hcolor(1)*255)));
   set(handles.edit_g_inserttext,'String',num2str(round(hcolor(2)*255)));
   set(handles.edit_b_inserttext,'String',num2str(round(hcolor(3)*255)));
   set(handles.slider_r_inserttext,'value',hcolor(1)*255);
   set(handles.slider_g_inserttext,'value',hcolor(2)*255);
   set(handles.slider_b_inserttext,'value',hcolor(3)*255);
   set(handles.prev_inserttext,'backgroundcolor',hcolor);
end


function text_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to text_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_inserttext as text
%        str2double(get(hObject,'String')) returns contents of text_inserttext as a double


% --- Executes during object creation, after setting all properties.
function text_inserttext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in usetex_inserttext.
function usetex_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to usetex_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of usetex_inserttext



function dist_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to dist_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if isnan(value)||(value<=0) set(hObject,'string','1'); waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end
% Hints: get(hObject,'String') returns contents of dist_inserttext as text
%        str2double(get(hObject,'String')) returns contents of dist_inserttext as a double


% --- Executes during object creation, after setting all properties.
function dist_inserttext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dist_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fontname_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to fontname_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fontname_inserttext as text
%        str2double(get(hObject,'String')) returns contents of fontname_inserttext as a double


% --- Executes during object creation, after setting all properties.
function fontname_inserttext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fontname_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fontstyle_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to fontstyle_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fontstyle_inserttext as text
%        str2double(get(hObject,'String')) returns contents of fontstyle_inserttext as a double


% --- Executes during object creation, after setting all properties.
function fontstyle_inserttext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fontstyle_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fontsize_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to fontsize_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fontsize_inserttext as text
%        str2double(get(hObject,'String')) returns contents of fontsize_inserttext as a double


% --- Executes during object creation, after setting all properties.
function fontsize_inserttext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fontsize_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in getfont_inserttext.
function getfont_inserttext_Callback(hObject, eventdata, handles)
% hObject    handle to getfont_inserttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fontname=get(handles.fontname_inserttext,'string');
fontsize=str2double(get(handles.fontsize_inserttext,'string'));
fontstyle=get(handles.fontstyle_inserttext,'string');
if strcmpi(fontstyle,'plain') fontweight='normal'; fontangle='normal';
elseif strcmpi(fontstyle,'bold') fontweight='bold'; fontangle='normal';
elseif strcmpi(fontstyle,'italic') fontweight='normal'; fontangle='italic';
elseif strcmpi(fontstyle,'bold italic') fontweight='bold'; fontangle='italic';
end
sf0=struct('FontName',fontname,'FontSize',fontsize,'FontWeight',fontweight,'FontAngle',fontangle);
sfnew=uisetfont(sf0);
if isnumeric(sfnew) return; end
set(handles.fontname_inserttext,'string',sfnew.FontName);
set(handles.fontsize_inserttext,'string',num2str(sfnew.FontSize));
if strcmpi(sfnew.FontWeight,'normal')&&strcmpi(sfnew.FontAngle,'normal')
   set(handles.fontstyle_inserttext,'string','plain');
elseif strcmpi(sfnew.FontWeight,'bold')&&strcmpi(sfnew.FontAngle,'normal')
   set(handles.fontstyle_inserttext,'string','bold');
elseif strcmpi(sfnew.FontWeight,'normal')&&strcmpi(sfnew.FontAngle,'italic')
   set(handles.fontstyle_inserttext,'string','italic');
elseif strcmpi(sfnew.FontWeight,'bold')&&strcmpi(sfnew.FontAngle,'italic')
   set(handles.fontstyle_inserttext,'string','bold italic');
end
