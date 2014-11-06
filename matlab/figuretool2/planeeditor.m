function varargout = planeeditor(varargin)
% PLANEEDITOR MATLAB code for planeeditor.fig
%      PLANEEDITOR, by itself, creates a new PLANEEDITOR or raises the existing
%      singleton*.
%
%      H = PLANEEDITOR returns the handle to a new PLANEEDITOR or the handle to
%      the existing singleton*.
%
%      PLANEEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLANEEDITOR.M with the given input arguments.
%
%      PLANEEDITOR('Property','Value',...) creates a new PLANEEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before planeeditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to planeeditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help planeeditor

% Last Modified by GUIDE v2.5 29-Oct-2014 18:03:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @planeeditor_OpeningFcn, ...
   'gui_OutputFcn',  @planeeditor_OutputFcn, ...
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


% --- Executes just before planeeditor is made visible.
function planeeditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to planeeditor (see VARARGIN)
% Choose default command line output for planeeditor
handles.output = hObject;
valstr=get(hObject,'userdata');
abbrval=struct('a',1,'r',2,'c',3);
if ~isempty(valstr)
   if (numel(valstr)<6)||(~strcmp(valstr([2,5,6]),''''','))
      set(handles.site_edit_planeeditor,'string',valstr(2:end-1));
   elseif strcmp(valstr(3),'3')
      set(handles.site_edit_planeeditor,'enable','off');
      set(handles.site_gredit_planeeditor,'enable','off');
      set(handles.rb4_planeeditor,'value',1);
      set(handles.pt_ppp_planeeditor,'enable','on','value',abbrval.(valstr(4)));
      temp=regexp(valstr,'[{}\[\],]','split');
      if strcmpi(valstr(4),'a')
         set(handles.x1_ppp_planeeditor,'enable','on','string',temp{3});
         set(handles.x2_ppp_planeeditor,'enable','on','string',temp{4});
         set(handles.x3_ppp_planeeditor,'enable','on','string',temp{5});
      else
         set(handles.x1_ppp_planeeditor,'enable','on','string',temp{4});
         set(handles.y1_ppp_planeeditor,'enable','on','string',temp{5});
         set(handles.z1_ppp_planeeditor,'enable','on','string',temp{6});
         set(handles.x2_ppp_planeeditor,'enable','on','string',temp{9});
         set(handles.y2_ppp_planeeditor,'enable','on','string',temp{10});
         set(handles.z2_ppp_planeeditor,'enable','on','string',temp{11});
         set(handles.x3_ppp_planeeditor,'enable','on','string',temp{14});
         set(handles.y3_ppp_planeeditor,'enable','on','string',temp{15});
         set(handles.z3_ppp_planeeditor,'enable','on','string',temp{16});
      end
   elseif strcmp(valstr(3),'e')
      set(handles.site_edit_planeeditor,'enable','off');
      set(handles.site_gredit_planeeditor,'enable','off');
      set(handles.rb5_planeeditor,'value',1);
      set(handles.rb1_eq_planeeditor,'enable','on');
      set(handles.rb2_eq_planeeditor,'enable','on');
      if strcmpi(valstr(4),'r') set(handles.rb1_eq_planeeditor,'value',1); end
      temp=regexp(valstr,'[\[\],]','split');
      set(handles.x_eq_planeeditor,'enable','on','string',temp{3});
      set(handles.y_eq_planeeditor,'enable','on','string',temp{4});
      set(handles.z_eq_planeeditor,'enable','on','string',temp{5});
      set(handles.c_eq_planeeditor,'enable','on','string',temp{6});
   elseif strcmp(valstr(4),'m')
      set(handles.site_edit_planeeditor,'enable','off');
      set(handles.site_gredit_planeeditor,'enable','off');
      set(handles.rb2_planeeditor,'value',1);
      set(handles.pt_pm_planeeditor,'enable','on','value',abbrval.(valstr(3)));
      temp=regexp(valstr,'[\[\],]','split');
      if strcmp(valstr(3),'a')
         set(handles.px_pm_planeeditor,'enable','on','string',temp{2});
         set(handles.h_pm_planeeditor,'enable','on','string',temp{4});
         set(handles.k_pm_planeeditor,'enable','on','string',temp{5});
         set(handles.l_pm_planeeditor,'enable','on','string',temp{6});
      else
         set(handles.px_pm_planeeditor,'enable','on','string',temp{3});
         set(handles.py_pm_planeeditor,'enable','on','string',temp{4});
         set(handles.pz_pm_planeeditor,'enable','on','string',temp{5});
         set(handles.h_pm_planeeditor,'enable','on','string',temp{8});
         set(handles.k_pm_planeeditor,'enable','on','string',temp{9});
         set(handles.l_pm_planeeditor,'enable','on','string',temp{10});
      end
   else
      set(handles.site_edit_planeeditor,'enable','off');
      set(handles.site_gredit_planeeditor,'enable','off');
      set(handles.rb3_planeeditor,'value',1);
      set(handles.pt_pn_planeeditor,'enable','on','value',abbrval.(valstr(3)));
      temp=regexp(valstr,'[\[\],]','split');
      if strcmp(valstr(3),'a')
         set(handles.px_pn_planeeditor,'enable','on','string',temp{2});
         set(handles.nx_pn_planeeditor,'enable','on','string',temp{4});
         set(handles.ny_pn_planeeditor,'enable','on','string',temp{5});
         set(handles.nz_pn_planeeditor,'enable','on','string',temp{6});
      else
         set(handles.px_pn_planeeditor,'enable','on','string',temp{3});
         set(handles.py_pn_planeeditor,'enable','on','string',temp{4});
         set(handles.pz_pn_planeeditor,'enable','on','string',temp{5});
         set(handles.nx_pn_planeeditor,'enable','on','string',temp{8});
         set(handles.ny_pn_planeeditor,'enable','on','string',temp{9});
         set(handles.nz_pn_planeeditor,'enable','on','string',temp{10});
      end
      set(handles.rb1_pn_planeeditor,'enable','on');
      set(handles.rb2_pn_planeeditor,'enable','on');
      if strcmpi(valstr(4),'r') set(handles.rb1_pn_planeeditor,'value',1); end
   end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes planeeditor wait for user response (see UIRESUME)
% uiwait(handles.planeeditor);


% --- Outputs from this function are returned to the command line.
function varargout = planeeditor_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_planeeditor.
function OK_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to OK_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist xyzlist;
tchar={'a','r','c'};
if get(handles.rb1_planeeditor,'value')==1
   temp=get(handles.site_edit_planeeditor,'string');
   if isempty(temp) waitfor(msgbox('Please specify the atoms you wish to draw.','Figuretool2')); return; end
   [stackin,~,status]=siterefparser(temp);
   if (status==0)||~strcmp(stackin,'B') waitfor(msgbox('The specified atom group is invalid.','Figuretool2')); return; end
   valstr=['{',temp,'}'];
elseif get(handles.rb2_planeeditor,'value')==1
   t1=tchar{get(handles.pt_pm_planeeditor,'value')};
   t2='m';
   if strcmpi(t1,'a')
      if isempty(atomlist) waitfor(msgbox('No template has been read in.','Figuretool2')); return; end
      c2str=get(handles.px_pm_planeeditor,'string');
   else 
      c2str=['[',get(handles.px_pm_planeeditor,'string'),',',get(handles.py_pm_planeeditor,'string'),',',get(handles.pz_pm_planeeditor,'string'),']'];
   end
   c3=[str2double(get(handles.h_pm_planeeditor,'string')),str2double(get(handles.k_pm_planeeditor,'string')),...
      str2double(get(handles.l_pm_planeeditor,'string'))];
   c3str=['[',get(handles.h_pm_planeeditor,'string'),',',get(handles.k_pm_planeeditor,'string'),',',get(handles.l_pm_planeeditor,'string'),']'];
   if norm(c3)<1E-6 waitfor(msgbox('The hkl indices cannot be all zero.','Figuretool2')); return; end
   valstr=['{''',t1,t2,''',',c2str,',',c3str,'}'];
elseif get(handles.rb3_planeeditor,'value')==1
   t1=tchar{get(handles.pt_pn_planeeditor,'value')};
   if get(handles.rb1_pn_planeeditor,'value')==1 t2='r'; else t2='c'; end
   if strcmpi(t1,'a')
      if isempty(atomlist) waitfor(msgbox('No template has been read in.','Figuretool2')); return; end
      c2str=get(handles.px_pn_planeeditor,'string');
   else
      c2str=['[',get(handles.px_pn_planeeditor,'string'),',',get(handles.py_pn_planeeditor,'string'),',',get(handles.pz_pn_planeeditor,'string'),']'];
   end
   c3=[str2double(get(handles.nx_pn_planeeditor,'string')),str2double(get(handles.ny_pn_planeeditor,'string')),...
      str2double(get(handles.nz_pn_planeeditor,'string'))];
   c3str=['[',get(handles.nx_pn_planeeditor,'string'),',',get(handles.ny_pn_planeeditor,'string'),',',get(handles.nz_pn_planeeditor,'string'),']'];
   if norm(c3)<1E-6 waitfor(msgbox('The normal vector must be non-zero.','Figuretool2')); return; end
   valstr=['{''',t1,t2,''',',c2str,',',c3str,'}'];
elseif get(handles.rb4_planeeditor,'value')==1
   t1=tchar{get(handles.pt_ppp_planeeditor,'value')};
   if strcmpi(t1,'a')
      c2=str2double(get(handles.x1_ppp_planeeditor,'string'));
      c3=str2double(get(handles.x2_ppp_planeeditor,'string'));
      c4=str2double(get(handles.x3_ppp_planeeditor,'string'));
      if isempty(atomlist) waitfor(msgbox('No template has been read in.','Figuretool2')); return; end
      temp=cross(xyzlist(c2,:)-xyzlist(c3,:),xyzlist(c2,:)-xyzlist(c4,:));
      if norm(temp)<1E-3 waitfor(msgbox('The specified atoms are coplanar.','Figuretool2')); return; end
      c2str=get(handles.x1_ppp_planeeditor,'string');
      c3str=get(handles.x2_ppp_planeeditor,'string');
      c4str=get(handles.x3_ppp_planeeditor,'string');
   else
      c2=[str2double(get(handles.x1_ppp_planeeditor,'string')),str2double(get(handles.y1_ppp_planeeditor,'string')),...
         str2double(get(handles.z1_ppp_planeeditor,'string'))];
      c3=[str2double(get(handles.x2_ppp_planeeditor,'string')),str2double(get(handles.y2_ppp_planeeditor,'string')),...
         str2double(get(handles.z2_ppp_planeeditor,'string'))];
      c4=[str2double(get(handles.x3_ppp_planeeditor,'string')),str2double(get(handles.y3_ppp_planeeditor,'string')),...
         str2double(get(handles.z3_ppp_planeeditor,'string'))];
      temp=cross(c2-c3,c2-c4);
      if norm(temp)<1E-3 waitfor(msgbox('The specified points are coplanar.','Figuretool2')); return; end
      c2str=['[',get(handles.x1_ppp_planeeditor,'string'),',',get(handles.y1_ppp_planeeditor,'string'),',',get(handles.z1_ppp_planeeditor,'string'),']'];
      c3str=['[',get(handles.x2_ppp_planeeditor,'string'),',',get(handles.y2_ppp_planeeditor,'string'),',',get(handles.z2_ppp_planeeditor,'string'),']'];
      c4str=['[',get(handles.x3_ppp_planeeditor,'string'),',',get(handles.y3_ppp_planeeditor,'string'),',',get(handles.z3_ppp_planeeditor,'string'),']'];
   end
   valstr=['{''3',t1,''',',c2str,',',c3str,',',c4str,'}'];
elseif get(handles.rb5_planeeditor,'value')==1
   if get(handles.rb1_eq_planeeditor,'value')==1 t2='r'; else t2='c'; end
   xstr=get(handles.x_eq_planeeditor,'string');
   ystr=get(handles.y_eq_planeeditor,'string');
   zstr=get(handles.z_eq_planeeditor,'string');
   cstr=get(handles.c_eq_planeeditor,'string');
   if norm([str2double(xstr),str2double(ystr),str2double(zstr)])<1E-6 waitfor(msgbox('The x, y and z coefficients cannot be all zero.','Figuretool2')); return; end
   valstr=['{''e',t2,''',[',xstr,',',ystr,',',zstr,',',cstr,']}'];
end
set(get(hObject,'parent'),'userdata',valstr);
uiresume;


% --- Executes on button press in cancel_planeeditor.
function cancel_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes on selection change in pt_pn_planeeditor.
function pt_pn_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to pt_pn_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
if get(hObject,'Value')==1
   set(handles.py_pn_planeeditor,'enable','off');
   set(handles.pz_pn_planeeditor,'enable','off');
   temp=str2double(get(handles.px_pn_planeeditor,'string'));
   if isnan(temp)||(temp<=0)||(temp>numel(atomlist))||(temp~=round(temp)) set(handles.px_pn_planeeditor,'string','1');
      waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2')); return;
   end
else
   set(handles.py_pn_planeeditor,'enable','on');
   set(handles.pz_pn_planeeditor,'enable','on');
end
% Hints: contents = cellstr(get(hObject,'String')) returns pt_pn_planeeditor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pt_pn_planeeditor


% --- Executes during object creation, after setting all properties.
function pt_pn_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pt_pn_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pt_ppp_planeeditor.
function pt_ppp_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to pt_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
if get(hObject,'Value')==1
   set(handles.y1_ppp_planeeditor,'enable','off');
   set(handles.z1_ppp_planeeditor,'enable','off');
   set(handles.y2_ppp_planeeditor,'enable','off');
   set(handles.z2_ppp_planeeditor,'enable','off');
   set(handles.y3_ppp_planeeditor,'enable','off');
   set(handles.z3_ppp_planeeditor,'enable','off');
   flag=0;
   temp=str2double(get(handles.x1_ppp_planeeditor,'string'));
   if isnan(temp)||(temp<=0)||(temp>numel(atomlist))||(temp~=round(temp)) set(handles.x1_ppp_planeeditor,'string','1'); flag=1; end
   temp=str2double(get(handles.x2_ppp_planeeditor,'string'));
   if isnan(temp)||(temp<=0)||(temp>numel(atomlist))||(temp~=round(temp)) set(handles.x2_ppp_planeeditor,'string','1'); flag=1; end
   temp=str2double(get(handles.x3_ppp_planeeditor,'string'));
   if isnan(temp)||(temp<=0)||(temp>numel(atomlist))||(temp~=round(temp)) set(handles.x3_ppp_planeeditor,'string','1'); flag=1; end
   if flag==1 waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2')); return; end
else
   set(handles.y1_ppp_planeeditor,'enable','on');
   set(handles.z1_ppp_planeeditor,'enable','on');
   set(handles.y2_ppp_planeeditor,'enable','on');
   set(handles.z2_ppp_planeeditor,'enable','on');
   set(handles.y3_ppp_planeeditor,'enable','on');
   set(handles.z3_ppp_planeeditor,'enable','on');
end
% Hints: contents = cellstr(get(hObject,'String')) returns pt_ppp_planeeditor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pt_ppp_planeeditor


% --- Executes during object creation, after setting all properties.
function pt_ppp_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pt_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function px_pn_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to px_pn_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=str2double(get(hObject,'String'));
if get(handles.pt_pn_planeeditor,'value')==1
   if isnan(temp)||(temp<0)||(temp>numel(atomlist))||(temp~=round(temp))
      set(hObject,'string',1); waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
      return;
   end
else
   if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
end
% Hints: get(hObject,'String') returns contents of px_pn_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of px_pn_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function px_pn_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to px_pn_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function py_pn_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to py_pn_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of py_pn_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of py_pn_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function py_pn_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to py_pn_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pz_pn_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to pz_pn_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of pz_pn_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of pz_pn_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function pz_pn_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pz_pn_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nx_pn_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to nx_pn_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of nx_pn_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of nx_pn_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function nx_pn_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nx_pn_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ny_pn_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to ny_pn_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of ny_pn_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of ny_pn_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function ny_pn_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ny_pn_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nz_pn_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to nz_pn_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of nz_pn_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of nz_pn_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function nz_pn_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nz_pn_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x1_ppp_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to x1_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=str2double(get(hObject,'String'));
if get(handles.pt_ppp_planeeditor,'value')==1
   if isnan(temp)||(temp<0)||(temp>numel(atomlist))||(temp~=round(temp))
      set(hObject,'string',1); waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
      return;
   end
else
   if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
end
% Hints: get(hObject,'String') returns contents of x1_ppp_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of x1_ppp_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function x1_ppp_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y1_ppp_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to y1_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of y1_ppp_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of y1_ppp_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function y1_ppp_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y1_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z1_ppp_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to z1_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of z1_ppp_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of z1_ppp_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function z1_ppp_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z1_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x2_ppp_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to x2_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=str2double(get(hObject,'String'));
if get(handles.pt_ppp_planeeditor,'value')==1
   if isnan(temp)||(temp<0)||(temp>numel(atomlist))||(temp~=round(temp))
      set(hObject,'string',1); waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
      return;
   end
else
   if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
end
% Hints: get(hObject,'String') returns contents of x2_ppp_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of x2_ppp_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function x2_ppp_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x2_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y2_ppp_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to y2_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of y2_ppp_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of y2_ppp_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function y2_ppp_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y2_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z2_ppp_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to z2_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of z2_ppp_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of z2_ppp_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function z2_ppp_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z2_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x3_ppp_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to x3_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=str2double(get(hObject,'String'));
if get(handles.pt_ppp_planeeditor,'value')==1
   if isnan(temp)||(temp<0)||(temp>numel(atomlist))||(temp~=round(temp))
      set(hObject,'string',1); waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
      return;
   end
else
   if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
end
% Hints: get(hObject,'String') returns contents of x3_ppp_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of x3_ppp_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function x3_ppp_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x3_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y3_ppp_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to y3_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of y3_ppp_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of y3_ppp_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function y3_ppp_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y3_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z3_ppp_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to z3_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of z3_ppp_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of z3_ppp_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function z3_ppp_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z3_ppp_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in rbg_planeeditor.
function rbg_planeeditor_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in rbg_planeeditor 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_planeeditor')
   set(handles.site_edit_planeeditor,'enable','on');
   set(handles.site_gredit_planeeditor,'enable','on');
   set(handles.pt_pm_planeeditor,'enable','off');
   set(handles.px_pm_planeeditor,'enable','off');
   set(handles.py_pm_planeeditor,'enable','off');
   set(handles.pz_pm_planeeditor,'enable','off');
   set(handles.h_pm_planeeditor,'enable','off');
   set(handles.k_pm_planeeditor,'enable','off');
   set(handles.l_pm_planeeditor,'enable','off');
   set(handles.pt_pn_planeeditor,'enable','off');
   set(handles.px_pn_planeeditor,'enable','off');
   set(handles.py_pn_planeeditor,'enable','off');
   set(handles.pz_pn_planeeditor,'enable','off');
   set(handles.nx_pn_planeeditor,'enable','off');
   set(handles.ny_pn_planeeditor,'enable','off');
   set(handles.nz_pn_planeeditor,'enable','off');
   set(handles.rb1_pn_planeeditor,'enable','off');
   set(handles.rb2_pn_planeeditor,'enable','off');
   set(handles.pt_ppp_planeeditor,'enable','off');
   set(handles.x1_ppp_planeeditor,'enable','off');
   set(handles.y1_ppp_planeeditor,'enable','off');
   set(handles.z1_ppp_planeeditor,'enable','off');
   set(handles.x2_ppp_planeeditor,'enable','off');
   set(handles.y2_ppp_planeeditor,'enable','off');
   set(handles.z2_ppp_planeeditor,'enable','off');
   set(handles.x3_ppp_planeeditor,'enable','off');
   set(handles.y3_ppp_planeeditor,'enable','off');
   set(handles.z3_ppp_planeeditor,'enable','off');
   set(handles.x_eq_planeeditor,'enable','off');
   set(handles.y_eq_planeeditor,'enable','off');
   set(handles.z_eq_planeeditor,'enable','off');
   set(handles.c_eq_planeeditor,'enable','off');
   set(handles.rb1_eq_planeeditor,'enable','off');
   set(handles.rb2_eq_planeeditor,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_planeeditor')
   set(handles.site_edit_planeeditor,'enable','off');
   set(handles.site_gredit_planeeditor,'enable','off');
   set(handles.pt_pm_planeeditor,'enable','on');
   set(handles.px_pm_planeeditor,'enable','on');
   if get(handles.pt_pm_planeeditor,'value')~=1
      set(handles.py_pm_planeeditor,'enable','on');
      set(handles.pz_pm_planeeditor,'enable','on');
   end
   set(handles.h_pm_planeeditor,'enable','on');
   set(handles.k_pm_planeeditor,'enable','on');
   set(handles.l_pm_planeeditor,'enable','on');
   set(handles.pt_pn_planeeditor,'enable','off');
   set(handles.px_pn_planeeditor,'enable','off');
   set(handles.py_pn_planeeditor,'enable','off');
   set(handles.pz_pn_planeeditor,'enable','off');
   set(handles.nx_pn_planeeditor,'enable','off');
   set(handles.ny_pn_planeeditor,'enable','off');
   set(handles.nz_pn_planeeditor,'enable','off');
   set(handles.rb1_pn_planeeditor,'enable','off');
   set(handles.rb2_pn_planeeditor,'enable','off');
   set(handles.pt_ppp_planeeditor,'enable','off');
   set(handles.x1_ppp_planeeditor,'enable','off');
   set(handles.y1_ppp_planeeditor,'enable','off');
   set(handles.z1_ppp_planeeditor,'enable','off');
   set(handles.x2_ppp_planeeditor,'enable','off');
   set(handles.y2_ppp_planeeditor,'enable','off');
   set(handles.z2_ppp_planeeditor,'enable','off');
   set(handles.x3_ppp_planeeditor,'enable','off');
   set(handles.y3_ppp_planeeditor,'enable','off');
   set(handles.z3_ppp_planeeditor,'enable','off');
   set(handles.x_eq_planeeditor,'enable','off');
   set(handles.y_eq_planeeditor,'enable','off');
   set(handles.z_eq_planeeditor,'enable','off');
   set(handles.c_eq_planeeditor,'enable','off');
   set(handles.rb1_eq_planeeditor,'enable','off');
   set(handles.rb2_eq_planeeditor,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb3_planeeditor')
   set(handles.site_edit_planeeditor,'enable','off');
   set(handles.site_gredit_planeeditor,'enable','off');
   set(handles.pt_pm_planeeditor,'enable','off');
   set(handles.px_pm_planeeditor,'enable','off');
   set(handles.py_pm_planeeditor,'enable','off');
   set(handles.pz_pm_planeeditor,'enable','off');
   set(handles.h_pm_planeeditor,'enable','off');
   set(handles.k_pm_planeeditor,'enable','off');
   set(handles.l_pm_planeeditor,'enable','off');
   set(handles.pt_pn_planeeditor,'enable','on');
   set(handles.px_pn_planeeditor,'enable','on');
   if get(handles.pt_pn_planeeditor,'value')~=1
      set(handles.py_pn_planeeditor,'enable','on');
      set(handles.pz_pn_planeeditor,'enable','on');
   end
   set(handles.nx_pn_planeeditor,'enable','on');
   set(handles.ny_pn_planeeditor,'enable','on');
   set(handles.nz_pn_planeeditor,'enable','on');
   set(handles.rb1_pn_planeeditor,'enable','on');
   set(handles.rb2_pn_planeeditor,'enable','on');
   set(handles.pt_ppp_planeeditor,'enable','off');
   set(handles.x1_ppp_planeeditor,'enable','off');
   set(handles.y1_ppp_planeeditor,'enable','off');
   set(handles.z1_ppp_planeeditor,'enable','off');
   set(handles.x2_ppp_planeeditor,'enable','off');
   set(handles.y2_ppp_planeeditor,'enable','off');
   set(handles.z2_ppp_planeeditor,'enable','off');
   set(handles.x3_ppp_planeeditor,'enable','off');
   set(handles.y3_ppp_planeeditor,'enable','off');
   set(handles.z3_ppp_planeeditor,'enable','off');
   set(handles.x_eq_planeeditor,'enable','off');
   set(handles.y_eq_planeeditor,'enable','off');
   set(handles.z_eq_planeeditor,'enable','off');
   set(handles.c_eq_planeeditor,'enable','off');
   set(handles.rb1_eq_planeeditor,'enable','off');
   set(handles.rb2_eq_planeeditor,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb4_planeeditor')
   set(handles.site_edit_planeeditor,'enable','off');
   set(handles.site_gredit_planeeditor,'enable','off');
   set(handles.pt_pm_planeeditor,'enable','off');
   set(handles.px_pm_planeeditor,'enable','off');
   set(handles.py_pm_planeeditor,'enable','off');
   set(handles.pz_pm_planeeditor,'enable','off');
   set(handles.h_pm_planeeditor,'enable','off');
   set(handles.k_pm_planeeditor,'enable','off');
   set(handles.l_pm_planeeditor,'enable','off');
   set(handles.pt_pn_planeeditor,'enable','off');
   set(handles.px_pn_planeeditor,'enable','off');
   set(handles.py_pn_planeeditor,'enable','off');
   set(handles.pz_pn_planeeditor,'enable','off');
   set(handles.nx_pn_planeeditor,'enable','off');
   set(handles.ny_pn_planeeditor,'enable','off');
   set(handles.nz_pn_planeeditor,'enable','off');
   set(handles.rb1_pn_planeeditor,'enable','off');
   set(handles.rb2_pn_planeeditor,'enable','off');
   set(handles.pt_ppp_planeeditor,'enable','on');
   set(handles.x1_ppp_planeeditor,'enable','on');
   set(handles.x2_ppp_planeeditor,'enable','on');
   set(handles.x3_ppp_planeeditor,'enable','on');
   if get(handles.pt_ppp_planeeditor,'value')~=1
      set(handles.y1_ppp_planeeditor,'enable','on');
      set(handles.z1_ppp_planeeditor,'enable','on');
      set(handles.y2_ppp_planeeditor,'enable','on');
      set(handles.z2_ppp_planeeditor,'enable','on');
      set(handles.y3_ppp_planeeditor,'enable','on');
      set(handles.z3_ppp_planeeditor,'enable','on');
   end
   set(handles.x_eq_planeeditor,'enable','off');
   set(handles.y_eq_planeeditor,'enable','off');
   set(handles.z_eq_planeeditor,'enable','off');
   set(handles.c_eq_planeeditor,'enable','off');
   set(handles.rb1_eq_planeeditor,'enable','off');
   set(handles.rb2_eq_planeeditor,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb5_planeeditor')
   set(handles.site_edit_planeeditor,'enable','off');
   set(handles.site_gredit_planeeditor,'enable','off');
   set(handles.pt_pm_planeeditor,'enable','off');
   set(handles.px_pm_planeeditor,'enable','off');
   set(handles.py_pm_planeeditor,'enable','off');
   set(handles.pz_pm_planeeditor,'enable','off');
   set(handles.h_pm_planeeditor,'enable','off');
   set(handles.k_pm_planeeditor,'enable','off');
   set(handles.l_pm_planeeditor,'enable','off');
   set(handles.pt_pn_planeeditor,'enable','off');
   set(handles.px_pn_planeeditor,'enable','off');
   set(handles.py_pn_planeeditor,'enable','off');
   set(handles.pz_pn_planeeditor,'enable','off');
   set(handles.nx_pn_planeeditor,'enable','off');
   set(handles.ny_pn_planeeditor,'enable','off');
   set(handles.nz_pn_planeeditor,'enable','off');
   set(handles.rb1_pn_planeeditor,'enable','off');
   set(handles.rb2_pn_planeeditor,'enable','off');
   set(handles.pt_ppp_planeeditor,'enable','off');
   set(handles.x1_ppp_planeeditor,'enable','off');
   set(handles.y1_ppp_planeeditor,'enable','off');
   set(handles.z1_ppp_planeeditor,'enable','off');
   set(handles.x2_ppp_planeeditor,'enable','off');
   set(handles.y2_ppp_planeeditor,'enable','off');
   set(handles.z2_ppp_planeeditor,'enable','off');
   set(handles.x3_ppp_planeeditor,'enable','off');
   set(handles.y3_ppp_planeeditor,'enable','off');
   set(handles.z3_ppp_planeeditor,'enable','off');
   set(handles.x_eq_planeeditor,'enable','on');
   set(handles.y_eq_planeeditor,'enable','on');
   set(handles.z_eq_planeeditor,'enable','on');
   set(handles.c_eq_planeeditor,'enable','on');
   set(handles.rb1_eq_planeeditor,'enable','on');
   set(handles.rb2_eq_planeeditor,'enable','on');
end



function site_edit_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to site_edit_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of site_edit_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of site_edit_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function site_edit_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to site_edit_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in site_gredit_planeeditor.
function site_gredit_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to site_gredit_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.site_edit_planeeditor,'string');
[stackin,reflistin,status]=siterefparser(temp);
if status==0 h0=groupeditor;
else h0=groupeditor('userdata',{temp,stackin,reflistin});
end
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if strcmpi(temp,'cancelled') return; end
set(handles.site_edit_planeeditor,'string',temp);


function x_eq_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to x_eq_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of x_eq_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of x_eq_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function x_eq_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_eq_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_eq_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to y_eq_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of y_eq_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of y_eq_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function y_eq_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_eq_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_eq_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to z_eq_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of z_eq_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of z_eq_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function z_eq_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_eq_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c_eq_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to c_eq_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of c_eq_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of c_eq_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function c_eq_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_eq_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pt_pm_planeeditor.
function pt_pm_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to pt_pm_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
if get(hObject,'Value')==1
   set(handles.py_pm_planeeditor,'enable','off');
   set(handles.pz_pm_planeeditor,'enable','off');
   temp=str2double(get(handles.px_pm_planeeditor,'string'));
   if isnan(temp)||(temp<=0)||(temp>numel(atomlist))||(temp~=round(temp)) set(handles.px_pm_planeeditor,'string','1');
      waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2')); return;
   end
else
   set(handles.py_pm_planeeditor,'enable','on');
   set(handles.pz_pm_planeeditor,'enable','on');
end
% Hints: contents = cellstr(get(hObject,'String')) returns pt_pm_planeeditor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pt_pm_planeeditor


% --- Executes during object creation, after setting all properties.
function pt_pm_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pt_pm_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function px_pm_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to px_pm_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=str2double(get(hObject,'String'));
if get(handles.pt_pm_planeeditor,'value')==1
   if isnan(temp)||(temp<0)||(temp>numel(atomlist))||(temp~=round(temp))
      set(hObject,'string',1); waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
      return;
   end
else
   if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
end
% Hints: get(hObject,'String') returns contents of px_pm_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of px_pm_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function px_pm_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to px_pm_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function py_pm_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to py_pm_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of py_pm_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of py_pm_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function py_pm_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to py_pm_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pz_pm_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to pz_pm_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of pz_pm_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of pz_pm_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function pz_pm_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pz_pm_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_pm_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to h_pm_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of h_pm_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of h_pm_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function h_pm_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_pm_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function k_pm_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to k_pm_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of k_pm_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of k_pm_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function k_pm_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k_pm_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function l_pm_planeeditor_Callback(hObject, eventdata, handles)
% hObject    handle to l_pm_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(get(hObject,'String'));
if isnan(temp) set(hObject,'string',0); waitfor(msgbox('Please enter a real number.','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of l_pm_planeeditor as text
%        str2double(get(hObject,'String')) returns contents of l_pm_planeeditor as a double


% --- Executes during object creation, after setting all properties.
function l_pm_planeeditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to l_pm_planeeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
