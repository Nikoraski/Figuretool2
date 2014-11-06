function varargout = templateviewer(varargin)
% TEMPLATEVIEWER MATLAB code for templateviewer.fig
%      TEMPLATEVIEWER, by itself, creates a new TEMPLATEVIEWER or raises the existing
%      singleton*.
%
%      H = TEMPLATEVIEWER returns the handle to a new TEMPLATEVIEWER or the handle to
%      the existing singleton*.
%
%      TEMPLATEVIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEMPLATEVIEWER.M with the given input arguments.
%
%      TEMPLATEVIEWER('Property','Value',...) creates a new TEMPLATEVIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before templateviewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to templateviewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help templateviewer

% Last Modified by GUIDE v2.5 10-Jul-2014 19:11:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @templateviewer_OpeningFcn, ...
                   'gui_OutputFcn',  @templateviewer_OutputFcn, ...
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


% --- Executes just before templateviewer is made visible.
function templateviewer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to templateviewer (see VARARGIN)
global atomlist elemlist elemnolist xyzlist coordtype;
if isempty(xyzlist)
   temp=cell(1,5); temp{1}='';
   set(handles.table_tempview,'data',temp);
   set(handles.table_tempview,'enable','off');
else
   set(handles.table_tempview,'enable','on');
   temp=cell(numel(atomlist),5);
   temp(:,1)=atomlist;
   for j=1:size(temp,1)
      if elemnolist(j)>0 temp{j,2}=[elemlist{j},' (',num2str(elemnolist(j)),')'];
      elseif elemnolist(j)==0 temp{j,2}='Dummy';
      elseif ~strcmpi(elemlist{j},'Un') temp{j,2}=elemlist{j};
      else temp{j,2}='Unknown';
      end
   end
   temp(:,3:5)=num2cell(xyzlist);
   set(handles.table_tempview,'data',temp);
end
if strcmpi(coordtype,'direct') set(handles.text_tempview,'string','Coordinate type: direct');
elseif strcmpi(coordtype,'Cartesian') set(handles.text_tempview,'string','Coordinate type: Cartesian');
else set(handles.text_tempview,'string','No template file read in.');
end
jscroll=findjobj(handles.table_tempview);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
jtable.getColumnModel().getColumn(3).setResizable(false);
% Choose default command line output for templateviewer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes templateviewer wait for user response (see UIRESUME)
% uiwait(handles.tempview);


% --- Outputs from this function are returned to the command line.
function varargout = templateviewer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_tempview.
function OK_tempview_Callback(hObject, eventdata, handles)
% hObject    handle to OK_tempview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;


% --- Executes on button press in edit_tempview.
function edit_tempview_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tempview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global modified coordtype elemlist elemnolist;
temp=get(handles.table_tempview,'data');
if isempty(temp) temp=cell(1,4); end
h0=templateeditor('Userdata',temp);
uiwait(h0);
if ~ishandle(h0) return; end
temp0=get(h0,'Userdata');
if ischar(temp0)&&strcmpi(temp0,'cancelled') delete(h0); return; end
temp=cell(size(temp0,1),5);
temp(:,[1,3:5])=temp0;
for j=1:size(temp,1)
   if elemnolist(j)>0 temp{j,2}=[elemlist{j},' (',num2str(elemnolist(j)),')'];
   elseif elemnolist(j)==0 temp{j,2}='Dummy';
   elseif ~strcmpi(elemlist{j},'Un') temp{j,2}=elemlist{j};
   else temp{j,2}='Unknown';
   end
end
set(handles.table_tempview,'data',temp);
set(handles.table_tempview,'enable','on');
delete(h0);
modified=true;
if strcmpi(coordtype,'direct') set(handles.text_tempview,'string','Coordinate type: direct');
elseif strcmpi(coordtype,'Cartesian') set(handles.text_tempview,'string','Coordinate type: Cartesian');
else set(handles.text_tempview,'string','No template file read in.');
end
