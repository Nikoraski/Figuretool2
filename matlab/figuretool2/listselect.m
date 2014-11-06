function varargout = listselect(varargin)
% LISTSELECT MATLAB code for listselect.fig
%      LISTSELECT, by itself, creates a new LISTSELECT or raises the existing
%      singleton*.
%
%      H = LISTSELECT returns the handle to a new LISTSELECT or the handle to
%      the existing singleton*.
%
%      LISTSELECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LISTSELECT.M with the given input arguments.
%
%      LISTSELECT('Property','Value',...) creates a new LISTSELECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before listselect_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to listselect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help listselect

% Last Modified by GUIDE v2.5 28-Jul-2014 04:02:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @listselect_OpeningFcn, ...
                   'gui_OutputFcn',  @listselect_OutputFcn, ...
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


% --- Executes just before listselect is made visible.
function listselect_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to listselect (see VARARGIN)
global atomlist xyzlist;
temp=cell(numel(atomlist),5);
temp(:,1)=num2cell(false(numel(atomlist),1));
temp(:,2)=atomlist;
temp(:,3:5)=num2cell(xyzlist);
set(handles.table_listselect,'data',temp);
jscroll=findjobj(handles.table_listselect);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
jtable.getColumnModel().getColumn(3).setResizable(false);
jtable.getColumnModel().getColumn(4).setResizable(false);
% Choose default command line output for listselect
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes listselect wait for user response (see UIRESUME)
% uiwait(handles.listselect);


% --- Outputs from this function are returned to the command line.
function varargout = listselect_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_listselect.
function OK_listselect_Callback(hObject, eventdata, handles)
% hObject    handle to OK_listselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.table_listselect,'data');
arrayout=find(cell2mat(temp(:,1))');
if isempty(arrayout) return; end
str='';
counter=0;
while(counter<numel(arrayout))
   nstart=counter+1;
   nend=find(arrayout(nstart+1:end)-arrayout(nstart)~=1:(numel(arrayout)-nstart),1);
   if isempty(nend) nend=numel(arrayout)+1-nstart; end
   if nend==1 str=[str,',',num2str(arrayout(nstart))];
   elseif nend==2 str=[str,',',num2str(arrayout(nstart)),',',num2str(arrayout(nstart+1))];
   else str=[str,',',num2str(arrayout(nstart)),':',num2str(arrayout(nstart+nend-1))];
   end
   counter=nstart+nend-1;
end
if isempty(findstr(',',str(2:end))) strout=str(2:end);
else strout=['[',str(2:end),']'];
end
set(get(hObject,'parent'),'userdata',strout);
uiresume;

% --- Executes on button press in cancel_listselect.
function cancel_listselect_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_listselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;
