function varargout = insertfigure(varargin)
% INSERTFIGURE MATLAB code for insertfigure.fig
%      INSERTFIGURE, by itself, creates a new INSERTFIGURE or raises the existing
%      singleton*.
%
%      H = INSERTFIGURE returns the handle to a new INSERTFIGURE or the handle to
%      the existing singleton*.
%
%      INSERTFIGURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INSERTFIGURE.M with the given input arguments.
%
%      INSERTFIGURE('Property','Value',...) creates a new INSERTFIGURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before insertfigure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to insertfigure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help insertfigure

% Last Modified by GUIDE v2.5 03-Nov-2014 16:43:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @insertfigure_OpeningFcn, ...
                   'gui_OutputFcn',  @insertfigure_OutputFcn, ...
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


% --- Executes just before insertfigure is made visible.
function insertfigure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to insertfigure (see VARARGIN)

% Choose default command line output for insertfigure
handles.output = hObject;
global globallp globalfl;
handles.output = hObject;
if isempty(get(hObject,'Userdata'))
st0=struct('function','insertfigure','file','','img','','ct','c','pos',zeros(4,3),'sa',1,'fl',globalfl,'lp',globallp,'res','default');
set(hObject,'Userdata',st0);
else
   st0=get(hObject,'Userdata');
   set(handles.file_insertfigure,'string',st0.file);
   set(handles.browse_insertfigure,'userdata',st0.img);
   abbrval=struct('a',1,'r',2,'c',3); abbrval2=struct('r',1,'c',2);
   if numel(st0.ct)==1
      set(handles.pt_rb1_insertfigure,'value',abbrval.(st0.ct));
      if strcmpi(st0.ct,'a')
         set(handles.yul_insertfigure,'enable','off');
         set(handles.zul_insertfigure,'enable','off');
         set(handles.calc_ul_insertfigure,'enable','off');
         set(handles.yll_insertfigure,'enable','off');
         set(handles.zll_insertfigure,'enable','off');
         set(handles.calc_ll_insertfigure,'enable','off');
         set(handles.ylr_insertfigure,'enable','off');
         set(handles.zlr_insertfigure,'enable','off');
         set(handles.calc_lr_insertfigure,'enable','off');
         set(handles.yur_insertfigure,'enable','off');
         set(handles.zur_insertfigure,'enable','off');
         set(handles.calc_ur_insertfigure,'enable','off');
         set(handles.xul_insertfigure,'string',st0.pos(1));
         set(handles.xll_insertfigure,'string',st0.pos(2));
         set(handles.xlr_insertfigure,'string',st0.pos(3));
         set(handles.xur_insertfigure,'string',st0.pos(4));
      else
         set(handles.xul_insertfigure,'string',st0.pos(1,1));
         set(handles.xll_insertfigure,'string',st0.pos(2,1));
         set(handles.xlr_insertfigure,'string',st0.pos(3,1));
         set(handles.xur_insertfigure,'string',st0.pos(4,1));
         set(handles.yul_insertfigure,'string',st0.pos(1,2));
         set(handles.yll_insertfigure,'string',st0.pos(2,2));
         set(handles.ylr_insertfigure,'string',st0.pos(3,2));
         set(handles.yur_insertfigure,'string',st0.pos(4,2));
         set(handles.zul_insertfigure,'string',st0.pos(1,3));
         set(handles.zll_insertfigure,'string',st0.pos(2,3));
         set(handles.zlr_insertfigure,'string',st0.pos(3,3));
         set(handles.zur_insertfigure,'string',st0.pos(4,3));
      end
   else
      set(handles.pt_rb1_insertfigure,'enable','off');
      set(handles.xul_insertfigure,'enable','off');
      set(handles.yul_insertfigure,'enable','off');
      set(handles.zul_insertfigure,'enable','off');
      set(handles.calc_ul_insertfigure,'enable','off');
      set(handles.xll_insertfigure,'enable','off');
      set(handles.yll_insertfigure,'enable','off');
      set(handles.zll_insertfigure,'enable','off');
      set(handles.calc_ll_insertfigure,'enable','off');
      set(handles.xlr_insertfigure,'enable','off');
      set(handles.ylr_insertfigure,'enable','off');
      set(handles.zlr_insertfigure,'enable','off');
      set(handles.calc_lr_insertfigure,'enable','off');
      set(handles.xur_insertfigure,'enable','off');
      set(handles.yur_insertfigure,'enable','off');
      set(handles.zur_insertfigure,'enable','off');
      set(handles.calc_ur_insertfigure,'enable','off');
      set(handles.rb2_pos_insertfigure,'value',1);
      set(handles.ct_rb2_insertfigure,'enable','on','value',abbrval.(st0.ct(1)));
      set(handles.cx_insertfigure,'enable','on','string',num2str(st0.pos{1}(1)));
      if ~strcmpi(st0.ct(1),'a')
         set(handles.cy_insertfigure,'enable','on','string',num2str(st0.pos{1}(2)));
         set(handles.cz_insertfigure,'enable','on','string',num2str(st0.pos{1}(3)));
      end
      set(handles.xt_rb2_insertfigure,'enable','on','value',abbrval2.(st0.ct(2)));
      set(handles.xx_insertfigure,'enable','on','string',num2str(st0.pos{2}(1,1)));
      set(handles.xy_insertfigure,'enable','on','string',num2str(st0.pos{2}(1,2)));
      set(handles.xz_insertfigure,'enable','on','string',num2str(st0.pos{2}(1,3)));
      set(handles.yx_insertfigure,'enable','on','string',num2str(st0.pos{2}(2,1)));
      set(handles.yy_insertfigure,'enable','on','string',num2str(st0.pos{2}(2,2)));
      set(handles.yz_insertfigure,'enable','on','string',num2str(st0.pos{2}(2,3)));
   end
   set(handles.alpha_edit_insertfigure,'string',sprintf('%4.2f',st0.sa));
   set(handles.alpha_slider_insertfigure,'value',st0.sa);
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes insertfigure wait for user response (see UIRESUME)
% uiwait(handles.insertfigure);


% --- Outputs from this function are returned to the command line.
function varargout = insertfigure_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
JEdit=findjobj(handles.file_insertfigure);
JEdit.Editable=0;
% Get default command line output from handles structure
varargout{1} = handles.output;



function file_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to file_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of file_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of file_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function file_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse_insertfigure.
function browse_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to browse_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.png;*.bmp;*.tif;*.jpg','Supported image files (.png,.bmp,.tif,.jpg)'},'Figuretool2');
if isnumeric(filename) return; end
figdata=imread([pathname,filename]);
set(hObject,'userdata',figdata);
set(handles.file_insertfigure,'string',[pathname,filename]);


% --- Executes on selection change in pt_rb1_insertfigure.
function pt_rb1_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to pt_rb1_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
if get(hObject,'Value')==1
   set(handles.yul_insertfigure,'enable','off');
   set(handles.zul_insertfigure,'enable','off');
   set(handles.calc_ul_insertfigure,'enable','off');
   set(handles.yll_insertfigure,'enable','off');
   set(handles.zll_insertfigure,'enable','off');
   set(handles.calc_ll_insertfigure,'enable','off');
   set(handles.ylr_insertfigure,'enable','off');
   set(handles.zlr_insertfigure,'enable','off');
   set(handles.calc_lr_insertfigure,'enable','off');
   set(handles.yur_insertfigure,'enable','off');
   set(handles.zur_insertfigure,'enable','off');
   set(handles.calc_ur_insertfigure,'enable','off');
   flag=0;
   temp=str2double(get(handles.xul_insertfigure,'string'));
   if isnan(temp)||(temp<=0)||(temp>numel(atomlist))||(temp~=round(temp)) set(handles.xul_insertfigure,'string','1'); flag=1; end
   temp=str2double(get(handles.xll_insertfigure,'string'));
   if isnan(temp)||(temp<=0)||(temp>numel(atomlist))||(temp~=round(temp)) set(handles.xll_insertfigure,'string','1'); flag=1; end
   temp=str2double(get(handles.xlr_insertfigure,'string'));
   if isnan(temp)||(temp<=0)||(temp>numel(atomlist))||(temp~=round(temp)) set(handles.xlr_insertfigure,'string','1'); flag=1; end
   temp=str2double(get(handles.xur_insertfigure,'string'));
   if isnan(temp)||(temp<=0)||(temp>numel(atomlist))||(temp~=round(temp)) set(handles.xur_insertfigure,'string','1'); flag=1; end
   if flag==1 waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2')); return; end
else
   set(handles.yul_insertfigure,'enable','on');
   set(handles.zul_insertfigure,'enable','on');
   set(handles.calc_ul_insertfigure,'enable','on');
   set(handles.yll_insertfigure,'enable','on');
   set(handles.zll_insertfigure,'enable','on');
   set(handles.calc_ll_insertfigure,'enable','on');
   set(handles.ylr_insertfigure,'enable','on');
   set(handles.zlr_insertfigure,'enable','on');
   set(handles.calc_lr_insertfigure,'enable','on');
   set(handles.yur_insertfigure,'enable','on');
   set(handles.zur_insertfigure,'enable','on');
   set(handles.calc_ur_insertfigure,'enable','on');
end
% Hints: contents = cellstr(get(hObject,'String')) returns pt_rb1_insertfigure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pt_rb1_insertfigure


% --- Executes during object creation, after setting all properties.
function pt_rb1_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pt_rb1_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xul_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to xul_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=str2double(get(hObject,'String'));
if get(handles.pt_rb1_insertfigure,'value')==1
   if isnan(temp)||(temp<0)||(temp>numel(atomlist))||(temp~=round(temp))
      set(hObject,'string',1); waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
      return;
   end
else
   if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
end
% Hints: get(hObject,'String') returns contents of xul_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of xul_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function xul_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xul_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yul_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to yul_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of yul_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of yul_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function yul_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yul_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zul_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to zul_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of zul_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of zul_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function zul_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zul_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xll_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to xll_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=str2double(get(hObject,'String'));
if get(handles.pt_rb1_insertfigure,'value')==1
   if isnan(temp)||(temp<0)||(temp>numel(atomlist))||(temp~=round(temp))
      set(hObject,'string',1); waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
      return;
   end
else
   if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
end
% Hints: get(hObject,'String') returns contents of xll_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of xll_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function xll_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xll_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yll_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to yll_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of yll_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of yll_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function yll_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yll_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zll_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to zll_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of zll_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of zll_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function zll_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zll_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xlr_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to xlr_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=str2double(get(hObject,'String'));
if get(handles.pt_rb1_insertfigure,'value')==1
   if isnan(temp)||(temp<0)||(temp>numel(atomlist))||(temp~=round(temp))
      set(hObject,'string',1); waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
      return;
   end
else
   if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
end
% Hints: get(hObject,'String') returns contents of xlr_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of xlr_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function xlr_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xlr_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ylr_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to ylr_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of ylr_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of ylr_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function ylr_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ylr_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zlr_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to zlr_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of zlr_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of zlr_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function zlr_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zlr_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xur_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to xur_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=str2double(get(hObject,'String'));
if get(handles.pt_rb1_insertfigure,'value')==1
   if isnan(temp)||(temp<0)||(temp>numel(atomlist))||(temp~=round(temp))
      set(hObject,'string',1); waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
      return;
   end
else
   if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
end
% Hints: get(hObject,'String') returns contents of xur_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of xur_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function xur_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xur_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yur_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to yur_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of yur_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of yur_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function yur_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yur_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zur_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to zur_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of zur_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of zur_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function zur_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zur_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in calc_ul_insertfigure.
function calc_ul_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to calc_ul_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xll=str2double(get(handles.xll_insertfigure,'string'));
yll=str2double(get(handles.yll_insertfigure,'string'));
zll=str2double(get(handles.zll_insertfigure,'string'));
xlr=str2double(get(handles.xlr_insertfigure,'string'));
ylr=str2double(get(handles.ylr_insertfigure,'string'));
zlr=str2double(get(handles.zlr_insertfigure,'string'));
xur=str2double(get(handles.xur_insertfigure,'string'));
yur=str2double(get(handles.yur_insertfigure,'string'));
zur=str2double(get(handles.zur_insertfigure,'string'));
set(handles.xul_insertfigure,'string',num2str(xll+xur-xlr));
set(handles.yul_insertfigure,'string',num2str(yll+yur-ylr));
set(handles.zul_insertfigure,'string',num2str(zll+zur-zlr));

% --- Executes on button press in calc_ll_insertfigure.
function calc_ll_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to calc_ll_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xul=str2double(get(handles.xul_insertfigure,'string'));
yul=str2double(get(handles.yul_insertfigure,'string'));
zul=str2double(get(handles.zul_insertfigure,'string'));
xlr=str2double(get(handles.xlr_insertfigure,'string'));
ylr=str2double(get(handles.ylr_insertfigure,'string'));
zlr=str2double(get(handles.zlr_insertfigure,'string'));
xur=str2double(get(handles.xur_insertfigure,'string'));
yur=str2double(get(handles.yur_insertfigure,'string'));
zur=str2double(get(handles.zur_insertfigure,'string'));
set(handles.xll_insertfigure,'string',num2str(xul+xlr-xur));
set(handles.yll_insertfigure,'string',num2str(yul+ylr-yur));
set(handles.zll_insertfigure,'string',num2str(zul+zlr-zur));

% --- Executes on button press in calc_lr_insertfigure.
function calc_lr_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to calc_lr_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xll=str2double(get(handles.xll_insertfigure,'string'));
yll=str2double(get(handles.yll_insertfigure,'string'));
zll=str2double(get(handles.zll_insertfigure,'string'));
xul=str2double(get(handles.xul_insertfigure,'string'));
yul=str2double(get(handles.yul_insertfigure,'string'));
zul=str2double(get(handles.zul_insertfigure,'string'));
xur=str2double(get(handles.xur_insertfigure,'string'));
yur=str2double(get(handles.yur_insertfigure,'string'));
zur=str2double(get(handles.zur_insertfigure,'string'));
set(handles.xlr_insertfigure,'string',num2str(xll+xur-xul));
set(handles.ylr_insertfigure,'string',num2str(yll+yur-yul));
set(handles.zlr_insertfigure,'string',num2str(zll+zur-zul));

% --- Executes on button press in calc_ur_insertfigure.
function calc_ur_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to calc_ur_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xul=str2double(get(handles.xul_insertfigure,'string'));
yul=str2double(get(handles.yul_insertfigure,'string'));
zul=str2double(get(handles.zul_insertfigure,'string'));
xlr=str2double(get(handles.xlr_insertfigure,'string'));
ylr=str2double(get(handles.ylr_insertfigure,'string'));
zlr=str2double(get(handles.zlr_insertfigure,'string'));
xll=str2double(get(handles.xll_insertfigure,'string'));
yll=str2double(get(handles.yll_insertfigure,'string'));
zll=str2double(get(handles.zll_insertfigure,'string'));
set(handles.xur_insertfigure,'string',num2str(xul+xlr-xll));
set(handles.yur_insertfigure,'string',num2str(yul+ylr-yll));
set(handles.zur_insertfigure,'string',num2str(zul+zlr-zll));

% --- Executes on selection change in ct_rb2_insertfigure.
function ct_rb2_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to ct_rb2_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
if get(hObject,'Value')==1
   set(handles.cy_insertfigure,'enable','off');
   set(handles.cz_insertfigure,'enable','off');
   temp=str2double(get(handles.cx_insertfigure,'string'));
   if isnan(temp)||(temp<=0)||(temp>numel(atomlist))||(temp~=round(temp)) set(handles.cx_insertfigure,'string','1');
      waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2')); return; 
   end
else
   set(handles.cy_insertfigure,'enable','on');
   set(handles.cz_insertfigure,'enable','on');
end
% Hints: contents = cellstr(get(hObject,'String')) returns ct_rb2_insertfigure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ct_rb2_insertfigure


% --- Executes during object creation, after setting all properties.
function ct_rb2_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ct_rb2_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cx_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to cx_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=str2double(get(hObject,'String'));
if get(handles.pt_rb1_insertfigure,'value')==1
   if isnan(temp)||(temp<0)||(temp>numel(atomlist))||(temp~=round(temp))
      set(hObject,'string',1); waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
      return;
   end
else
   if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
end
% Hints: get(hObject,'String') returns contents of cx_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of cx_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function cx_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cx_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cy_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to cy_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of cy_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of cy_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function cy_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cy_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cz_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to cz_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of cz_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of cz_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function cz_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cz_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xx_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to xx_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of xx_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of xx_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function xx_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xx_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xy_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to xy_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of xy_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of xy_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function xy_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xy_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xz_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to xz_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of xz_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of xz_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function xz_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xz_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yx_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to yx_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of yx_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of yx_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function yx_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yx_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yy_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to yy_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of yy_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of yy_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function yy_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yy_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yz_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to yz_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of yz_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of yz_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function yz_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yz_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in xt_rb2_insertfigure.
function xt_rb2_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to xt_rb2_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns xt_rb2_insertfigure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from xt_rb2_insertfigure


% --- Executes during object creation, after setting all properties.
function xt_rb2_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xt_rb2_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function alpha_slider_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_slider_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.alpha_edit_insertfigure,'string',sprintf('%4.2f',value));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function alpha_slider_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_slider_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function alpha_edit_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_edit_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=1) set(handles.alpha_slider_insertfigure,'value',value);
else set(hObject,'string','1.00'); set(handles.alpha_slider_insertfigure,'value',1); waitfor(msgbox('Please enter a number between 0 and 1.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of alpha_edit_insertfigure as text
%        str2double(get(hObject,'String')) returns contents of alpha_edit_insertfigure as a double


% --- Executes during object creation, after setting all properties.
function alpha_edit_insertfigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_edit_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_insertfigure.
function OK_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to OK_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist xyzlist unitcell coordtype;
tchar={'a','r','c'}; tchar2={'r','c'};
st0=get(get(hObject,'parent'),'userdata');
imgdata=get(handles.browse_insertfigure,'userdata');
if isempty(imgdata) waitfor(msgbox('Please specify an image file.','Figuretool2')); return; end
st0.img=imgdata;
st0.file=get(handles.file_insertfigure,'string');
if get(handles.rb1_pos_insertfigure,'value')==1
   st0.ct=tchar{get(handles.pt_rb1_insertfigure,'value')};
   xul=str2double(get(handles.xul_insertfigure,'string'));
   yul=str2double(get(handles.yul_insertfigure,'string'));
   zul=str2double(get(handles.zul_insertfigure,'string'));
   xll=str2double(get(handles.xll_insertfigure,'string'));
   yll=str2double(get(handles.yll_insertfigure,'string'));
   zll=str2double(get(handles.zll_insertfigure,'string'));
   xlr=str2double(get(handles.xlr_insertfigure,'string'));
   ylr=str2double(get(handles.ylr_insertfigure,'string'));
   zlr=str2double(get(handles.zlr_insertfigure,'string'));
   xur=str2double(get(handles.xur_insertfigure,'string'));
   yur=str2double(get(handles.yur_insertfigure,'string'));
   zur=str2double(get(handles.zur_insertfigure,'string'));
   if strcmpi(st0.ct,'a')
      xyztemp=xyzlist([xul,xll,xlr,xur],:); st0.pos=[xul,xll,xlr,xur]';
      if strcmpi(coordtype,'direct') xyztemp=xyztemp*unitcell; end
   else
      st0.pos=[xul,yul,zul;xll,yll,zll;xlr,ylr,zlr;xur,yur,zur];
      if strcmpi(st0.ct,'c') xyztemp=st0.pos*unitcell; else xyztemp=st0.pos; end
   end
   if (norm(xyztemp(1,:)-xyztemp(2,:))<1E-3)||(norm(xyztemp(3,:)-xyztemp(2,:))<1E-3)||...
         (norm(xyztemp(1,:)+xyztemp(3,:)-xyztemp(2,:)-xyztemp(4,:))>1E-2)||(abs(norm(xyztemp(1,:)-xyztemp(3,:))-norm(xyztemp(2,:)-xyztemp(4,:)))>1E-2)
      waitfor(msgbox('The specified points do not form a rectangle.','Figuretool2')); return;
   end
else
   st0.ct=[tchar{get(handles.ct_rb2_insertfigure,'value')},tchar2{get(handles.xt_rb2_insertfigure,'value')}];
   cx=str2double(get(handles.cx_insertfigure,'string'));
   cy=str2double(get(handles.cy_insertfigure,'string'));
   cz=str2double(get(handles.cz_insertfigure,'string'));
   xx=str2double(get(handles.xx_insertfigure,'string'));
   xy=str2double(get(handles.xy_insertfigure,'string'));
   xz=str2double(get(handles.xz_insertfigure,'string'));
   yx=str2double(get(handles.yx_insertfigure,'string'));
   yy=str2double(get(handles.yy_insertfigure,'string'));
   yz=str2double(get(handles.yz_insertfigure,'string'));
   if strcmpi(st0.ct(1),'a') pos1=cx; else pos1=[cx,cy,cz]; end
   pos2=[xx,xy,xz;yx,yy,yz];
   if strcmpi(st0.ct(1),'c') xyztemp=pos2*unitcell; else xyztemp=pos2; end
   if (norm(xyztemp(1,:))<1E-3)||(norm(xyztemp(2,:))<1E-3)||(xyztemp(1,:)*xyztemp(2,:)'>1E-2)
      waitfor(msgbox('The specified x and y vectors do not form a rectangle.','Figuretool2')); return;
   end
   st0.pos={pos1,pos2};
end
st0.sa=get(handles.alpha_slider_insertfigure,'value');
set(get(hObject,'parent'),'userdata',st0);
uiresume;

% --- Executes on button press in cancel_insertfigure.
function cancel_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes on button press in advanced_insertfigure.
function advanced_insertfigure_Callback(hObject, eventdata, handles)
% hObject    handle to advanced_insertfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st0=get(get(hObject,'parent'),'Userdata');
h0=adv_settings('Userdata',{st0.lp,[1,0.6,0.9,1],st0.res,st0.fl});
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


% --- Executes when selected object is changed in pos_insertfigure.
function pos_insertfigure_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in pos_insertfigure 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_pos_insertfigure')
   set(handles.pt_rb1_insertfigure,'enable','on');
   set(handles.xul_insertfigure,'enable','on');
   set(handles.xll_insertfigure,'enable','on');
   set(handles.xlr_insertfigure,'enable','on');
   set(handles.xur_insertfigure,'enable','on');
   if get(handles.pt_rb1_insertfigure,'value')~=1
      set(handles.yul_insertfigure,'enable','on');
      set(handles.zul_insertfigure,'enable','on');
      set(handles.calc_ul_insertfigure,'enable','on');
      set(handles.yll_insertfigure,'enable','on');
      set(handles.zll_insertfigure,'enable','on');
      set(handles.calc_ll_insertfigure,'enable','on');
      set(handles.ylr_insertfigure,'enable','on');
      set(handles.zlr_insertfigure,'enable','on');
      set(handles.calc_lr_insertfigure,'enable','on');
      set(handles.yur_insertfigure,'enable','on');
      set(handles.zur_insertfigure,'enable','on');
      set(handles.calc_ur_insertfigure,'enable','on');
   end
   set(handles.ct_rb2_insertfigure,'enable','off');
   set(handles.cx_insertfigure,'enable','off');
   set(handles.cy_insertfigure,'enable','off');
   set(handles.cz_insertfigure,'enable','off');
   set(handles.xt_rb2_insertfigure,'enable','off');
   set(handles.xx_insertfigure,'enable','off');
   set(handles.xy_insertfigure,'enable','off');
   set(handles.xz_insertfigure,'enable','off');
   set(handles.yx_insertfigure,'enable','off');
   set(handles.yy_insertfigure,'enable','off');
   set(handles.yz_insertfigure,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_pos_insertfigure')
   set(handles.pt_rb1_insertfigure,'enable','off');
   set(handles.xul_insertfigure,'enable','off');
   set(handles.yul_insertfigure,'enable','off');
   set(handles.zul_insertfigure,'enable','off');
   set(handles.calc_ul_insertfigure,'enable','off');
   set(handles.xll_insertfigure,'enable','off');
   set(handles.yll_insertfigure,'enable','off');
   set(handles.zll_insertfigure,'enable','off');
   set(handles.calc_ll_insertfigure,'enable','off');
   set(handles.xlr_insertfigure,'enable','off');
   set(handles.ylr_insertfigure,'enable','off');
   set(handles.zlr_insertfigure,'enable','off');
   set(handles.calc_lr_insertfigure,'enable','off');
   set(handles.xur_insertfigure,'enable','off');
   set(handles.yur_insertfigure,'enable','off');
   set(handles.zur_insertfigure,'enable','off');
   set(handles.calc_ur_insertfigure,'enable','off');
   set(handles.ct_rb2_insertfigure,'enable','on');
   set(handles.cx_insertfigure,'enable','on');
   if get(handles.ct_rb2_insertfigure,'value')~=1
      set(handles.cy_insertfigure,'enable','on');
      set(handles.cz_insertfigure,'enable','on');
   end
   set(handles.xt_rb2_insertfigure,'enable','on');
   set(handles.xx_insertfigure,'enable','on');
   set(handles.xy_insertfigure,'enable','on');
   set(handles.xz_insertfigure,'enable','on');
   set(handles.yx_insertfigure,'enable','on');
   set(handles.yy_insertfigure,'enable','on');
   set(handles.yz_insertfigure,'enable','on');
end
