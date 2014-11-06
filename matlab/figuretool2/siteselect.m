function varargout = siteselect(varargin)
% SITESELECT MATLAB code for siteselect.fig
%      SITESELECT, by itself, creates a new SITESELECT or raises the existing
%      singleton*.
%
%      H = SITESELECT returns the handle to a new SITESELECT or the handle to
%      the existing singleton*.
%
%      SITESELECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SITESELECT.M with the given input arguments.
%
%      SITESELECT('Property','Value',...) creates a new SITESELECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before siteselect_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to siteselect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help siteselect

% Last Modified by GUIDE v2.5 28-Jul-2014 04:08:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @siteselect_OpeningFcn, ...
                   'gui_OutputFcn',  @siteselect_OutputFcn, ...
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


% --- Executes just before siteselect is made visible.
function siteselect_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to siteselect (see VARARGIN)
global atomlist elemlist;
% Choose default command line output for siteselect
handles.output = hObject;
[elemlist0,~,ic]=unique(elemlist);
[sitelist,ia,~]=unique(atomlist);
sites=cell(size(elemlist0));
counter=0;
for j=1:numel(sitelist)
   if ~strcmpi(sitelist{j},elemlist{ia(j)}) sites{ic(ia(j))}(end+1)=j; counter=counter+1; end
end
eslist=cell(counter+numel(elemlist0),1);
iselem=[];
counter=1;
for j=1:numel(elemlist0)
   eslist{counter}=elemlist0{j};
   iselem=[iselem,counter];
   eslist(counter+1:counter+numel(sites{j}))=sitelist(sites{j});
   counter=counter+numel(sites{j})+1;
end
iselem=[iselem,counter];
temp=cell(size(eslist,1),2);
temp(:,1)=num2cell(false(size(eslist,1),1));
temp(:,2)=eslist;
set(hObject,'userdata',iselem);
set(handles.table_siteselect,'data',temp);
jscroll=findjobj(handles.table_siteselect);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes siteselect wait for user response (see UIRESUME)
% uiwait(handles.siteselect);


% --- Outputs from this function are returned to the command line.
function varargout = siteselect_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_siteselect.
function OK_siteselect_Callback(hObject, eventdata, handles)
% hObject    handle to OK_siteselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.table_siteselect,'data');
arrayout=find(cell2mat(temp(:,1))');
if ~any(arrayout) return; end
iselem=get(get(hObject,'parent'),'userdata');
sitelist={}; nextelem=0;
for j=1:numel(arrayout)
   elemno=find(arrayout(j)==iselem,1);
   if ~isempty(elemno) sitelist{end+1}=temp{arrayout(j),2}; nextelem=iselem(elemno+1)-1;
   elseif arrayout(j)>nextelem sitelist{end+1}=temp{arrayout(j),2};
   end
end
set(get(hObject,'parent'),'userdata',sitelist);
uiresume;

% --- Executes on button press in cancel_siteselect.
function cancel_siteselect_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_siteselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;

% --- Executes when entered data in editable cell(s) in table_siteselect.
function table_siteselect_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to table_siteselect (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
index=eventdata.Indices(:,1);
if numel(index)~=1 return; end
iselem=get(get(hObject,'parent'),'userdata');
data=get(hObject,'data');
elemno=find(index==iselem,1);
if ~isempty(elemno) data(iselem(elemno):(iselem(elemno+1)-1),1)=num2cell(eventdata.NewData);
else
   elemno=find(index<iselem,1)-1;
   if (data{iselem(elemno),1}==true)&&(eventdata.NewData==false) data{iselem(elemno),1}=false; end
end
set(hObject,'data',data);
   











