function varargout = groupeditor(varargin)
% GROUPEDITOR MATLAB code for groupeditor.fig
%      GROUPEDITOR, by itself, creates a new GROUPEDITOR or raises the existing
%      singleton*.
%
%      H = GROUPEDITOR returns the handle to a new GROUPEDITOR or the handle to
%      the existing singleton*.
%
%      GROUPEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GROUPEDITOR.M with the given input arguments.
%
%      GROUPEDITOR('Property','Value',...) creates a new GROUPEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before groupeditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to groupeditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help groupeditor

% Last Modified by GUIDE v2.5 29-Oct-2014 00:06:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @groupeditor_OpeningFcn, ...
                   'gui_OutputFcn',  @groupeditor_OutputFcn, ...
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


% --- Executes just before groupeditor is made visible.
function groupeditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to groupeditor (see VARARGIN)
% Choose default command line output for groupeditor
handles.output = hObject;
temp=get(hObject,'userdata');
if isempty(temp)
   set(hObject,'userdata',{'','BS',{},0});
else
   set(handles.disp_gredit,'string',temp{1});
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes groupeditor wait for user response (see UIRESUME)
% uiwait(handles.gredit);


% --- Outputs from this function are returned to the command line.
function varargout = groupeditor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
JEdit=findjobj(handles.disp_gredit);
JEdit.Editable=0;
handles.jgredit=JEdit;
guidata(hObject, handles);
% Get default command line output from handles structure
varargout{1} = handles.output;



function disp_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to disp_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_gredit as text
%        str2double(get(hObject,'String')) returns contents of disp_gredit as a double


% --- Executes during object creation, after setting all properties.
function disp_gredit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in list_gredit.
function list_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to list_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
h0=listselect;
uiwait(h0);
if ~ishandle(h0) return; end
listout=get(h0,'userdata');
delete(h0);
if strcmpi(listout,'cancelled') return; end
rtemp{2}=statestack(1:end-1);
rtemp{3}=[reflist;{'list',listout}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,listout]);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in site_gredit.
function site_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to site_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
h0=siteselect;
uiwait(h0);
if ~ishandle(h0) return; end
listout=get(h0,'userdata');
delete(h0);
if strcmpi(listout,'cancelled') return; end
rtemp{2}=statestack(1:end-1);
if numel(listout)>1 useparen=true; else useparen=false; end
if useparen
   reflist=[reflist;{'lp','('}];
   siteexp=get(handles.disp_gredit,'string');
   set(handles.disp_gredit,'string',[siteexp,'(']);
end
for j=1:numel(listout)
   reflist=[reflist;{'site',listout{j}}];
   siteexp=get(handles.disp_gredit,'string');
   set(handles.disp_gredit,'string',[siteexp,listout{j}]);
   if j~=numel(listout)
      reflist=[reflist;{'or','|'}];
      siteexp=get(handles.disp_gredit,'string');
      set(handles.disp_gredit,'string',[siteexp,'|']);
   end
end
if useparen
   reflist=[reflist;{'rp',')'}];
   siteexp=get(handles.disp_gredit,'string');
   set(handles.disp_gredit,'string',[siteexp,')']);
end
rtemp{3}=reflist;
set(handles.gredit,'userdata',rtemp);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in all_gredit.
function all_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to all_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
rtemp{2}=statestack(1:end-1);
rtemp{3}=[reflist;{'all','all'}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,'all']);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in used_gredit.
function used_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to used_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
rtemp{2}=statestack(1:end-1);
rtemp{3}=[reflist;{'used','used'}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,'used']);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in bond_gredit.
function bond_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to bond_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
rtemp{2}=statestack(1:end-1);
rtemp{3}=[reflist;{'bonded','bonded'}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,'bonded']);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in unitcell_gredit.
function unitcell_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to unitcell_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
rtemp{2}=statestack(1:end-1);
rtemp{3}=[reflist;{'unitcell','unitcell'}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,'unitcell']);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in getmol_gredit.
function getmol_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to getmol_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
h0=getmol;
uiwait(h0);
if ~ishandle(h0) return; end
listout=get(h0,'userdata');
delete(h0);
if strcmpi(listout,'cancelled') return; end
rtemp{2}=[statestack(1:end-1),'PSCS'];
rtemp{3}=[reflist;{'getmol',listout}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,listout]);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in getbox_gredit.
function getbox_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to getbox_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
h0=getbox;
uiwait(h0);
if ~ishandle(h0) return; end
listout=get(h0,'userdata');
delete(h0);
if strcmpi(listout,'cancelled') return; end
rtemp{2}=statestack(1:end-1);
rtemp{3}=[reflist;{'getbox',listout}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,listout]);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in getsphere_gredit.
function getsphere_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to getsphere_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
h0=getsphere;
uiwait(h0);
if ~ishandle(h0) return; end
listout=get(h0,'userdata');
delete(h0);
if strcmpi(listout,'cancelled') return; end
rtemp{2}=statestack(1:end-1);
rtemp{3}=[reflist;{'getsphere',listout}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,listout]);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in getslab_gredit.
function getslab_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to getslab_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
h0=getslab;
uiwait(h0);
if ~ishandle(h0) return; end
listout=get(h0,'userdata');
delete(h0);
if strcmpi(listout,'cancelled') return; end
rtemp{2}=statestack(1:end-1);
rtemp{3}=[reflist;{'getslab',listout}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,listout]);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in coord_gredit.
function coord_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to coord_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
h0=getcoord;
uiwait(h0);
if ~ishandle(h0) return; end
listout=get(h0,'userdata');
delete(h0);
if strcmpi(listout,'cancelled') return; end
rtemp{2}=[statestack(1:end-1),'PSCS'];
rtemp{3}=[reflist;{'coord',listout}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,listout]);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in bksp_gredit.
function bksp_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to bksp_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if isempty(reflist) return; end
lastvar=reflist{end,1}; laststr=reflist{end,2};
switch lastvar
   case {'list','site','group','all','bonded','used','unitcell','getbox','getsphere','getslab'}, statestack=[statestack,'S'];
   case {'getmol','coord'}, statestack=[statestack(1:end-4),'S'];
   case {'lp','convhull'}, statestack=[statestack(1:end-2),'S'];
   case 'rp', statestack=[statestack,'P'];
   case 'comma', statestack=[statestack,'C'];
   case {'and','or'}, statestack=statestack(1:end-1);
end
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',siteexp(1:end-numel(laststr)));
rtemp{2}=statestack;
rtemp{3}=reflist(1:end-1,:);
set(handles.gredit,'userdata',rtemp);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in group_gredit.
function group_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to group_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
h0=groupselect;
uiwait(h0);
if ~ishandle(h0) return; end
listout=get(h0,'userdata');
delete(h0);
if strcmpi(listout,'cancelled') return; end
rtemp{2}=statestack(1:end-1);
rtemp{3}=[reflist;{'group',listout}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,listout]);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in convhull_gredit.
function convhull_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to convhull_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
rtemp{2}=[statestack(1:end-1),'PS'];
rtemp{3}=[reflist;{'convhull','convhull('}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,'convhull(']);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in lp_gredit.
function lp_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to lp_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
rtemp{2}=[statestack(1:end-1),'PS'];
rtemp{3}=[reflist;{'lp','('}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,'(']);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in rp_gredit.
function rp_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to rp_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'P') return; end
rtemp{2}=statestack(1:end-1);
rtemp{3}=[reflist;{'rp',')'}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,')']);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in comma_gredit.
function comma_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to comma_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'C') return; end
rtemp{2}=statestack(1:end-1);
rtemp{3}=[reflist;{'comma',','}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,',']);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in and_gredit.
function and_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to and_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~ismember(statestack(end),{'C','P','B'}) return; end
rtemp{2}=[statestack,'S'];
rtemp{3}=[reflist;{'and','&'}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,'&']);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in or_gredit.
function or_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to or_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~ismember(statestack(end),{'C','P','B'}) return; end
rtemp{2}=[statestack,'S'];
rtemp{3}=[reflist;{'or','|'}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,'|']);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in not_gredit.
function not_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to not_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3};
if ~strcmp(statestack(end),'S') return; end
rtemp{3}=[reflist;{'not','~'}];
set(handles.gredit,'userdata',rtemp);
siteexp=get(handles.disp_gredit,'string');
set(handles.disp_gredit,'string',[siteexp,'~']);
pause(0.01);
temp=handles.jgredit.getDocument.getLength;
pause(0.01);
handles.jgredit.setCaretPosition(temp);

% --- Executes on button press in clear_gredit.
function clear_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to clear_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
rtemp{2}='BS';
rtemp{3}={};
set(handles.gredit,'userdata',rtemp);
set(handles.disp_gredit,'string','');

% --- Executes on button press in OK_gredit.
function OK_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to OK_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rtemp=get(handles.gredit,'userdata');
statestack=rtemp{2}; reflist=rtemp{3}; if numel(rtemp)>=4 isgroup=rtemp{4}; else isgroup=0; end
siteexp=get(handles.disp_gredit,'string');
if isempty(siteexp) waitfor(msgbox('The atom group expression is empty.','Figuretool2')); return; 
elseif ~strcmp(statestack,'B') waitfor(msgbox('The atom group expression is incomplete.','Figuretool2')); return;
elseif (isgroup==1)&&any(ismember(reflist(:,1),{'used','bonded'}))
   waitfor(msgbox('The tokens ''used'' and ''bonded'' cannot be used in group specification.','Figuretool2')); return;
else set(get(hObject,'parent'),'userdata',siteexp);
   uiresume;
end

% --- Executes on button press in cancel_gredit.
function cancel_gredit_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;

% --- Executes on key press with focus on gredit or any of its controls.
function gredit_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to gredit (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if isempty(eventdata.Character) return; end
switch eventdata.Character
   case {'R','r'}, list_gredit_Callback('','',handles);
   case {'S','s'}, site_gredit_Callback('','',handles);
   case {'G','g'}, group_gredit_Callback('','',handles);
   case {'M','m'}, getmol_gredit_Callback('','',handles);
   case {'C','c'}, coord_gredit_Callback('','',handles);
   case {'A','a'}, all_gredit_Callback('','',handles);
   case {'U','u'}, used_gredit_Callback('','',handles);
   case {'B','b'}, bond_gredit_Callback('','',handles);
   case {'X','x'}, getbox_gredit_Callback('','',handles);
   case {'L','l'}, getslab_gredit_Callback('','',handles);
   case {'P','p'}, getsphere_gredit_Callback('','',handles);
   case {'I','i'}, unitcell_gredit_Callback('','',handles);
   case {'H','h'}, convhull_gredit_Callback('','',handles);
   case '(', lp_gredit_Callback('','',handles);
   case ')', rp_gredit_Callback('','',handles);
   case ',', comma_gredit_Callback('','',handles);
   case '&', and_gredit_Callback('','',handles);
   case '|', or_gredit_Callback('','',handles);
   case '~', not_gredit_Callback('','',handles);
   case char(8), bksp_gredit_Callback('','',handles);
   otherwise, return;
end


% --- Executes when user attempts to close gredit.
function gredit_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to gredit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
