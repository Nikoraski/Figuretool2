function varargout = setdc(varargin)
% SETDC MATLAB code for setdc.fig
%      SETDC, by itself, creates a new SETDC or raises the existing
%      singleton*.
%
%      H = SETDC returns the handle to a new SETDC or the handle to
%      the existing singleton*.
%
%      SETDC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETDC.M with the given input arguments.
%
%      SETDC('Property','Value',...) creates a new SETDC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before setdc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to setdc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setdc

% Last Modified by GUIDE v2.5 14-Jul-2014 18:46:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @setdc_OpeningFcn, ...
   'gui_OutputFcn',  @setdc_OutputFcn, ...
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


% --- Executes just before setdc is made visible.
function setdc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to setdc (see VARARGIN)
global atomlist elemlist defaultcolor elemname CPKcolor;
% Choose default command line output for setdc
handles.output = hObject;
[mtree,~]=uitree('v0','root','Elements','position',[6,7,221,167],'SelectionChangeFcn',@tree_setdc_SelectionChangeFcn);
root=uitreenode('v0','Elements','Elements',[],false);
[elemlist0,~,ic]=unique(elemlist);
[sitelist,ia,~]=unique(atomlist);
elemnode=cell(size(elemlist0));
sitenode=cell(size(sitelist));
for j=1:numel(elemlist0)
   if isfield(defaultcolor,elemlist0{j})&&~strcmpi(defaultcolor.(elemlist0{j}),'default')
      defcolor=defaultcolor.(elemlist0{j});
   else
      [~,loc]=ismember(elemlist0{j},elemname);
      if loc~=0 defcolor=CPKcolor{loc}; else defcolor=[0,0,0]; end
   end
   str=[elemlist0{j},' [',num2str(defcolor(1)),',',num2str(defcolor(2)),',',num2str(defcolor(3)),']'];
   if ~isfield(defaultcolor,elemlist0{j})||strcmpi(defaultcolor.(elemlist0{j}),'default') str=[str,' (default)']; end
   elemnode{j}=uitreenode('v0',str,str,[],all(strcmpi(elemlist0{j},atomlist(j==ic))));
   root.add(elemnode{j});
end
for j=1:numel(sitelist)
   if strcmpi(sitelist{j},elemlist{ia(j)}) continue; end
   if isfield(defaultcolor,sitelist{j})&&~strcmpi(defaultcolor.(sitelist{j}),'default')
      defcolor=defaultcolor.(sitelist{j});
   elseif isfield(defaultcolor,elemlist0{ic(ia(j))})&&~strcmpi(defaultcolor.(elemlist0{ic(ia(j))}),'default')
      defcolor=defaultcolor.(elemlist0{ic(ia(j))});
   else
      [~,loc]=ismember(elemlist0{ic(ia(j))},elemname);
      if loc~=0 defcolor=CPKcolor{loc}; else defcolor=[0,0,0]; end
   end
   str=[sitelist{j},' [',num2str(defcolor(1)),',',num2str(defcolor(2)),',',num2str(defcolor(3)),']'];
   if ~isfield(defaultcolor,sitelist{j})||strcmpi(defaultcolor.(sitelist{j}),'default') str=[str,' (default)']; end
   sitenode{j}=uitreenode('v0',str,str,[],true);
   elemnode{ic(ia(j))}.add(sitenode{j});
end
mtree.setRoot(root);
mtree.expand(root);
handles.tree_setdc=mtree;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes setdc wait for user response (see UIRESUME)
% uiwait(handles.setdc);

function tree_setdc_SelectionChangeFcn(hObject,eventdata)
node=hObject.getSelectedNodes;
if ~isempty(node)
   temp=regexp(char(node(1).getName),' ','split');
   if numel(temp)<2
      set(findobj('tag','r_edit_setdc'),'enable','off','string','0');
      set(findobj('tag','g_edit_setdc'),'enable','off','string','0');
      set(findobj('tag','b_edit_setdc'),'enable','off','string','0');
      set(findobj('tag','r_slider_setdc'),'enable','off','value',0);
      set(findobj('tag','g_slider_setdc'),'enable','off','value',0);
      set(findobj('tag','b_slider_setdc'),'enable','off','value',0);
      set(findobj('tag','setcolor_setdc'),'enable','off');
      set(findobj('tag','prev_setdc'),'backgroundcolor',[0,0,0]);
   else
      defcolor=str2num(temp{2});
      set(findobj('tag','r_edit_setdc'),'enable','on','string',num2str(defcolor(1)));
      set(findobj('tag','g_edit_setdc'),'enable','on','string',num2str(defcolor(2)));
      set(findobj('tag','b_edit_setdc'),'enable','on','string',num2str(defcolor(3)));
      set(findobj('tag','r_slider_setdc'),'enable','on','value',defcolor(1));
      set(findobj('tag','g_slider_setdc'),'enable','on','value',defcolor(2));
      set(findobj('tag','b_slider_setdc'),'enable','on','value',defcolor(3));
      set(findobj('tag','setcolor_setdc'),'enable','on');
      set(findobj('tag','prev_setdc'),'backgroundcolor',defcolor/255);
   end
end

% --- Outputs from this function are returned to the command line.
function varargout = setdc_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function r_edit_setdc_Callback(hObject, eventdata, handles)
% hObject    handle to r_edit_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.r_slider_setdc,'value',value);
   rvalue=str2double(get(handles.r_edit_setdc,'String'));
   gvalue=str2double(get(handles.g_edit_setdc,'String'));
   bvalue=str2double(get(handles.b_edit_setdc,'String'));
   set(handles.prev_setdc,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.r_slider_setdc,'value');
   set(hObject,'string',num2str(round(value))); set(handles.r_slider_setdc,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of r_edit_setdc as text
%        str2double(get(hObject,'String')) returns contents of r_edit_setdc as a double


% --- Executes during object creation, after setting all properties.
function r_edit_setdc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_edit_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function g_edit_setdc_Callback(hObject, eventdata, handles)
% hObject    handle to g_edit_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.g_slider_setdc,'value',value);
   rvalue=str2double(get(handles.r_edit_setdc,'String'));
   gvalue=str2double(get(handles.g_edit_setdc,'String'));
   bvalue=str2double(get(handles.b_edit_setdc,'String'));
   set(handles.prev_setdc,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.g_slider_setdc,'value');
   set(hObject,'string',num2str(round(value))); set(handles.g_slider_setdc,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of g_edit_setdc as text
%        str2double(get(hObject,'String')) returns contents of g_edit_setdc as a double


% --- Executes during object creation, after setting all properties.
function g_edit_setdc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_edit_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function b_edit_setdc_Callback(hObject, eventdata, handles)
% hObject    handle to b_edit_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=str2double(get(hObject,'String'));
if ~isnan(value)&&(value>=0)&&(value<=255) set(handles.b_slider_setdc,'value',value);
   rvalue=str2double(get(handles.r_edit_setdc,'String'));
   gvalue=str2double(get(handles.g_edit_setdc,'String'));
   bvalue=str2double(get(handles.b_edit_setdc,'String'));
   set(handles.prev_setdc,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
else 
   value=get(handles.b_slider_setdc,'value');
   set(hObject,'string',num2str(round(value))); set(handles.b_slider_setdc,'value',value);
   waitfor(msgbox('Please enter a number between 0 and 255.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of b_edit_setdc as text
%        str2double(get(hObject,'String')) returns contents of b_edit_setdc as a double


% --- Executes during object creation, after setting all properties.
function b_edit_setdc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_edit_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function r_slider_setdc_Callback(hObject, eventdata, handles)
% hObject    handle to r_slider_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.r_edit_setdc,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_setdc,'String'));
gvalue=str2double(get(handles.g_edit_setdc,'String'));
bvalue=str2double(get(handles.b_edit_setdc,'String'));
set(handles.prev_setdc,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function r_slider_setdc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_slider_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function g_slider_setdc_Callback(hObject, eventdata, handles)
% hObject    handle to g_slider_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.g_edit_setdc,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_setdc,'String'));
gvalue=str2double(get(handles.g_edit_setdc,'String'));
bvalue=str2double(get(handles.b_edit_setdc,'String'));
set(handles.prev_setdc,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function g_slider_setdc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_slider_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function b_slider_setdc_Callback(hObject, eventdata, handles)
% hObject    handle to b_slider_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'value');
set(handles.b_edit_setdc,'string',num2str(round(value)));
rvalue=str2double(get(handles.r_edit_setdc,'String'));
gvalue=str2double(get(handles.g_edit_setdc,'String'));
bvalue=str2double(get(handles.b_edit_setdc,'String'));
set(handles.prev_setdc,'backgroundcolor',[rvalue/255,gvalue/255,bvalue/255]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function b_slider_setdc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_slider_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in setcolor_setdc.
function setcolor_setdc_Callback(hObject, eventdata, handles)
% hObject    handle to setcolor_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rvalue=str2double(get(handles.r_edit_setdc,'String'));
gvalue=str2double(get(handles.g_edit_setdc,'String'));
bvalue=str2double(get(handles.b_edit_setdc,'String'));
hcolor=uisetcolor([rvalue/255,gvalue/255,bvalue/255],'Figuretool2');
if numel(hcolor)==3
   set(handles.r_edit_setdc,'String',num2str(round(hcolor(1)*255)));
   set(handles.g_edit_setdc,'String',num2str(round(hcolor(2)*255)));
   set(handles.b_edit_setdc,'String',num2str(round(hcolor(3)*255)));
   set(handles.r_slider_setdc,'value',hcolor(1)*255);
   set(handles.g_slider_setdc,'value',hcolor(2)*255);
   set(handles.b_slider_setdc,'value',hcolor(3)*255);
   set(handles.prev_setdc,'backgroundcolor',hcolor);
end

% --- Executes on button press in OK_setdc.
function OK_setdc_Callback(hObject, eventdata, handles)
% hObject    handle to OK_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;

% --- Executes on button press in cancel_setdc.
function cancel_setdc_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;

% --- Executes on button press in apply_setdc.
function apply_setdc_Callback(hObject, eventdata, handles)
% hObject    handle to apply_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global defaultcolor;
node=handles.tree_setdc.getSelectedNodes;
if ~isempty(node)
   temp=regexp(char(node(1).getName),' ','split');
   if numel(temp)>=2
      str=temp{1};
      rvalue=str2double(get(handles.r_edit_setdc,'String'));
      gvalue=str2double(get(handles.g_edit_setdc,'String'));
      bvalue=str2double(get(handles.b_edit_setdc,'String'));
      defaultcolor.(str)=[rvalue,gvalue,bvalue];
      node(1).setName([str,' [',num2str(rvalue),',',num2str(gvalue),',',num2str(bvalue),']']);
      if ~node(1).isLeaf
         count=node(1).getChildCount;
         for j=1:count
            temp=regexp(char(node(1).getChildAt(j-1).getName),' ','split');
            if numel(temp)==3
               node(1).getChildAt(j-1).setName([temp{1},' [',num2str(rvalue),',',num2str(gvalue),',',num2str(bvalue),'] (default)']);
            end
         end
      end
      handles.tree_setdc.reloadNode(node(1));
   end
end

% --- Executes on button press in default_setdc.
function default_setdc_Callback(hObject, eventdata, handles)
% hObject    handle to default_setdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global defaultcolor elemname CPKcolor;
node=handles.tree_setdc.getSelectedNodes;
if ~isempty(node)
   temp=regexp(char(node(1).getName),' ','split');
   if numel(temp)>=2
      str=temp{1};
      defaultcolor.(str)='default';
      if node(1).isLeaf
         temp=regexp(char(node(1).getParent.getName),' ','split');
         defcolor=str2num(temp{2});
         node(1).setName([str,' [',num2str(defcolor(1)),',',num2str(defcolor(2)),',',num2str(defcolor(3)),'] (default)']);
      else
         [~,loc]=ismember(temp{1},elemname);
         if loc~=0 defcolor=CPKcolor{loc}; else defcolor=[0,0,0]; end
         node(1).setName([str,' [',num2str(defcolor(1)),',',num2str(defcolor(2)),',',num2str(defcolor(3)),'] (default)']);
         count=node(1).getChildCount;
         for j=1:count
            temp=regexp(char(node(1).getChildAt(j-1).getName),' ','split');
            if numel(temp)==3
               node(1).getChildAt(j-1).setName([temp{1},' [',num2str(defcolor(1)),',',num2str(defcolor(2)),',',num2str(defcolor(3)),'] (default)']);
            end
         end
      end
      handles.tree_setdc.reloadNode(node(1));
   end
end
