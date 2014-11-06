function varargout = groupmanager(varargin)
% GROUPMANAGER MATLAB code for groupmanager.fig
%      GROUPMANAGER, by itself, creates a new GROUPMANAGER or raises the existing
%      singleton*.
%
%      H = GROUPMANAGER returns the handle to a new GROUPMANAGER or the handle to
%      the existing singleton*.
%
%      GROUPMANAGER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GROUPMANAGER.M with the given input arguments.
%
%      GROUPMANAGER('Property','Value',...) creates a new GROUPMANAGER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before groupmanager_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to groupmanager_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help groupmanager

% Last Modified by GUIDE v2.5 03-Oct-2014 14:22:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @groupmanager_OpeningFcn, ...
   'gui_OutputFcn',  @groupmanager_OutputFcn, ...
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


% --- Executes just before groupmanager is made visible.
function groupmanager_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to groupmanager (see VARARGIN)
global grouplist;
% Choose default command line output for groupmanager
handles.output = hObject;
if ~isempty(grouplist) set(handles.list_groupmanager,'string',grouplist(:,1)'); end
jScrollPane = findjobj(handles.list_groupmanager);
jListbox = jScrollPane.getViewport.getComponent(0);
jListbox = handle(jListbox, 'CallbackProperties');
set(jListbox, 'MousePressedCallback',{@mouseMovedCallback,handles.list_groupmanager});
if ~isempty(grouplist)
   set(handles.name_groupmanager,'string',grouplist{1,1});
   set(handles.expr_groupmanager,'string',grouplist{1,2});
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes groupmanager wait for user response (see UIRESUME)
% uiwait(handles.groupmanager);

function mouseMovedCallback(jListbox, jEventData, hListbox)
global grouplist;
% Get the currently-hovered list-item
mousePos = java.awt.Point(jEventData.getX, jEventData.getY);
hoverIndex = jListbox.locationToIndex(mousePos) + 1;
listValues = get(hListbox,'string');
if isempty(listValues) set(hListbox, 'Tooltip',''); return; end
set(hListbox, 'Tooltip',grouplist{hoverIndex,2});

% --- Outputs from this function are returned to the command line.
function varargout = groupmanager_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in list_groupmanager.
function list_groupmanager_Callback(hObject, eventdata, handles)
% hObject    handle to list_groupmanager (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grouplist;
if isempty(grouplist) return; end
value0=get(hObject,'Value');
set(handles.name_groupmanager,'string',grouplist{value0,1});
set(handles.expr_groupmanager,'string',grouplist{value0,2});
% Hints: contents = cellstr(get(hObject,'String')) returns list_groupmanager contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_groupmanager


% --- Executes during object creation, after setting all properties.
function list_groupmanager_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_groupmanager (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in new_groupmanager.
function new_groupmanager_Callback(hObject, eventdata, handles)
% hObject    handle to new_groupmanager (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grouplist;
if isempty(grouplist)||(~ismember(upper('new_group'),upper(grouplist(:,1)))) newname='new_group';
else
   num=2;
   while true
      if ~ismember([upper('new_group'),num2str(num)],upper(grouplist(:,1))) newname=['new_group',num2str(num)]; break;
      else num=num+1;
      end
   end
end
grouplist(end+1,:)={newname,''};
set(handles.list_groupmanager,'string',grouplist(:,1)');
set(handles.list_groupmanager,'value',size(grouplist,1));
set(handles.name_groupmanager,'string',newname);
set(handles.expr_groupmanager,'string','');


% --- Executes on button press in delete_groupmanager.
function delete_groupmanager_Callback(hObject, eventdata, handles)
% hObject    handle to delete_groupmanager (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grouplist;
value0=get(handles.list_groupmanager,'value');
if (value0<=0)||(value0>size(grouplist,1)) return;
else grouplist(value0,:)=[];
   if ~isempty(grouplist) set(handles.list_groupmanager,'string',grouplist(:,1)');
   else set(handles.list_groupmanager,'string','');
   end
   value1=min(value0,size(grouplist,1));
   set(handles.list_groupmanager,'value',value1);
   if value1~=0
      set(handles.name_groupmanager,'string',grouplist{value1,1});
      set(handles.expr_groupmanager,'string',grouplist{value1,2});
   else
      set(handles.name_groupmanager,'string','');
      set(handles.expr_groupmanager,'string','');
   end
end

% --- Executes on button press in OK_groupmanager.
function OK_groupmanager_Callback(hObject, eventdata, handles)
% hObject    handle to OK_groupmanager (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grouplist;
if any(cellfun(@isempty,grouplist(:,2))) waitfor(msgbox('Please check that all groups have non-empty expressions.','Figuretool2')); return; end
uiresume;


% --- Executes on button press in dup_groupmanager.
function dup_groupmanager_Callback(hObject, eventdata, handles)
% hObject    handle to dup_groupmanager (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grouplist;
value0=get(handles.list_groupmanager,'value');
if isempty(grouplist)||(value0<1)||(value0>size(grouplist,1)) return; end
oldname=grouplist{value0,1};
temp=regexp(oldname,'-copy','split');
if numel(temp)>1
   str=temp{end};
   if isempty(str)||~isnan(str2double(str)) oldname=oldname(1:(end-5-numel(str))); end
end
if ~ismember(upper([oldname,'-copy']),upper(grouplist(:,1))) newname=[oldname,'-copy'];
else
   num=2;
   while true
      if ~ismember([upper([oldname,'-copy']),num2str(num)],upper(grouplist(:,1))) newname=[oldname,'-copy',num2str(num)]; break;
      else num=num+1;
      end
   end
end
grouplist(end+1,:)={newname,grouplist{value0,2}};
set(handles.list_groupmanager,'string',grouplist(:,1)');
set(handles.list_groupmanager,'value',size(grouplist,1));
set(handles.name_groupmanager,'string',newname);
set(handles.expr_groupmanager,'string',grouplist{value0,2});


function name_groupmanager_Callback(hObject, eventdata, handles)
% hObject    handle to name_groupmanager (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name_groupmanager as text
%        str2double(get(hObject,'String')) returns contents of name_groupmanager as a double


% --- Executes during object creation, after setting all properties.
function name_groupmanager_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name_groupmanager (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function expr_groupmanager_Callback(hObject, eventdata, handles)
% hObject    handle to expr_groupmanager (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of expr_groupmanager as text
%        str2double(get(hObject,'String')) returns contents of expr_groupmanager as a double


% --- Executes during object creation, after setting all properties.
function expr_groupmanager_CreateFcn(hObject, eventdata, handles)
% hObject    handle to expr_groupmanager (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gredit_groupmanager.
function gredit_groupmanager_Callback(hObject, eventdata, handles)
% hObject    handle to gredit_groupmanager (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grouplist;
value0=get(handles.list_groupmanager,'value');
if isempty(grouplist)||(value0<1)||(value0>size(grouplist,1)) return; end
temp=get(handles.expr_groupmanager,'string');
[stackin,reflistin,status]=siterefparser(temp);
if status==0 h0=groupeditor;
else h0=groupeditor('userdata',{temp,stackin,reflistin,1});
end
uiwait(h0);
if ~ishandle(h0) return; end
groupexpr=get(h0,'userdata');
delete(h0);
if strcmpi(groupexpr,'cancelled') return; end
set(handles.expr_groupmanager,'string',groupexpr);

% --- Executes on button press in update_groupmanger.
function update_groupmanger_Callback(hObject, eventdata, handles)
% hObject    handle to update_groupmanger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grouplist atomlist elemlist;
value0=get(handles.list_groupmanager,'value');
if isempty(grouplist)||(value0<1)||(value0>size(grouplist,1)) return; end
newname=get(handles.name_groupmanager,'string');
groupexpr=get(handles.expr_groupmanager,'string');
if isempty(groupexpr) waitfor(msgbox('The group expression is empty.','Figuretool2')); return; end
if isempty(newname) waitfor(msgbox('Please give a name to the group.','Figuretool2')); return;
elseif ~all(isstrprop(newname,'alphanum')|('_'==newname))
   waitfor(msgbox('The group name must contain only alphanumeric characters and underscores.','Figuretool2')); return;
end
if ~isnan(str2double(newname)) waitfor(msgbox('The group name must contain at least a letter or underscore.','Figuretool2')); return; end
if ismember(upper(newname),{'ALL','USED','BONDED','UNITCELL','BOX','SLAB','SPHERE','COORD','GETMOL','CONVHULL'})
   waitfor(msgbox('The group name is a reserved word. Please use a different name.','Figuretool2')); return;
end
if ~isempty(atomlist)
   if ismember(upper(newname),upper(atomlist))||ismember(upper(newname),upper(elemlist))
      waitfor(msgbox('Element/site names cannot be used as group names.','Figuretool2')); return;
   end
end
temp=grouplist(:,1);
temp(value0)=[];
if ismember(upper(newname),upper(temp)) waitfor(msgbox('A group with the specified name already exists!','Figuretool2')); return; end
[stackin,reflistin,status]=siterefparser(groupexpr);
if (status==0)||~strcmp(stackin,'B') waitfor(msgbox('The group expression is invalid.','Figuretool2')); return; end
templist=regexp(groupexpr,'[,()|&~{}]','split');
if any(ismember({'USED','BONDED'},upper(templist))) waitfor(msgbox('''used'' and ''bonded'' can only be used in function site references.','Figuretool2')); return; end
grouplist(value0,:)={newname,groupexpr};
temp=get(handles.list_groupmanager,'string');
temp{value0}=newname;
set(handles.list_groupmanager,'string',temp);
