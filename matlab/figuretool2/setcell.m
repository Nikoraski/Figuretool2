function varargout = setcell(varargin)
% SETCELL MATLAB code for setcell.fig
%      SETCELL, by itself, creates a new SETCELL or raises the existing
%      singleton*.
%
%      H = SETCELL returns the handle to a new SETCELL or the handle to
%      the existing singleton*.
%
%      SETCELL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETCELL.M with the given input arguments.
%
%      SETCELL('Property','Value',...) creates a new SETCELL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before setcell_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to setcell_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setcell

% Last Modified by GUIDE v2.5 11-Jul-2014 18:50:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @setcell_OpeningFcn, ...
                   'gui_OutputFcn',  @setcell_OutputFcn, ...
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


% --- Executes just before setcell is made visible.
function setcell_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to setcell (see VARARGIN)
global unitcell;
abbr=struct('aP','triclinic cell','mP','monoclinic conventional cell','mA','A-centered monoclinic primitive cell','mB','B-centered monoclinic primitive cell',...
   'mC','C-centered monoclinic primitive cell','oP','orthorhombic conventional cell','oA','A-centered orthorhombic primitive cell','oB',...
   'B-centered orthorhombic primitive cell','oC','C-centered orthorhombic primitive cell','oF','face-centered orthorhombic primitive cell',...
   'oI','body-centered orthorhombic primitive cell','tP','tetragonal conventional cell','tI','body-centered tetragonal primitive cell',...
   'hP','hexagonal cell','hR','rhombohedral cell','cP','cubic conventional cell','cF','face-centered cubic primitive cell','cI','body-centered cubic primitive cell');
% Choose default command line output for setcell
handles.output = hObject;
temp=cell(3,3);temp(1:size(unitcell,1),:)=num2cell(unitcell);
set(handles.table_setcell,'data',temp);
set(hObject,'userdata',[]);
if (size(unitcell,1)==3)&&all(sum(abs(unitcell),2)>1E-4)&&det(unitcell)>1E-6
   temp=unitcell;
   set(handles.a_setcell,'string',sprintf('%.4f',norm(temp(1,:))));
   set(handles.b_setcell,'string',sprintf('%.4f',norm(temp(2,:))));
   set(handles.c_setcell,'string',sprintf('%.4f',norm(temp(3,:))));
   set(handles.alpha_setcell,'string',sprintf('%.2f',acosd(dot(temp(2,:),temp(3,:))/(norm(temp(2,:))*norm(temp(3,:))))));
   set(handles.beta_setcell,'string',sprintf('%.2f',acosd(dot(temp(1,:),temp(3,:))/(norm(temp(1,:))*norm(temp(3,:))))));
   set(handles.gamma_setcell,'string',sprintf('%.2f',acosd(dot(temp(1,:),temp(2,:))/(norm(temp(1,:))*norm(temp(2,:))))));
   set(handles.volume_setcell,'string',sprintf('Cell volume: %.5f',abs(det(temp))));
   [~,strout]=symsearch(temp);
   set(handles.bravais_setcell,'string',['Cell type: ',getfield(abbr,strout)]);
end
jscroll=findjobj(handles.table_setcell);
jtable=jscroll.getViewport.getView;
jtable.getColumnModel().getColumn(0).setResizable(false);
jtable.getColumnModel().getColumn(1).setResizable(false);
jtable.getColumnModel().getColumn(2).setResizable(false);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes setcell wait for user response (see UIRESUME)
% uiwait(handles.setcell);


% --- Outputs from this function are returned to the command line.
function varargout = setcell_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in moveup_setcell.
function moveup_setcell_Callback(hObject, eventdata, handles)
% hObject    handle to moveup_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
indices=get(get(hObject,'parent'),'Userdata');
if isempty(indices) return; end
nrow=unique(indices(:,1));
if (numel(nrow)~=1)||(nrow==1) return; end
temp=get(handles.table_setcell,'data');
tempr=temp(nrow,:); temp(nrow,:)=temp(nrow-1,:); temp(nrow-1,:)=tempr;
set(handles.table_setcell,'data',temp);

% --- Executes on button press in movedown_setcell.
function movedown_setcell_Callback(hObject, eventdata, handles)
% hObject    handle to movedown_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
indices=get(get(hObject,'parent'),'Userdata');
if isempty(indices) return; end
nrow=unique(indices(:,1));
if (numel(nrow)~=1)||(nrow==3) return; end
temp=get(handles.table_setcell,'data');
tempr=temp(nrow,:); temp(nrow,:)=temp(nrow+1,:); temp(nrow+1,:)=tempr;
set(handles.table_setcell,'data',temp);

% --- Executes on button press in OK_setcell.
function OK_setcell_Callback(hObject, eventdata, handles)
% hObject    handle to OK_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
status=apply_setcell_Callback(handles.apply_setcell,eventdata,handles);
if status==0 uiresume; else return; end

% --- Executes on button press in cancel_setcell.
function cancel_setcell_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata','cancelled');
uiresume;

% --- Executes on button press in apply_setcell.
function status=apply_setcell_Callback(hObject, eventdata, handles)
% hObject    handle to apply_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global unitcell coordtype xyzlist;
status=1;
abbr=struct('aP','triclinic cell','mP','monoclinic conventional cell','mA','A-centered monoclinic primitive cell','mB','B-centered monoclinic primitive cell',...
   'mC','C-centered monoclinic primitive cell','oP','orthorhombic conventional cell','oA','A-centered orthorhombic primitive cell','oB',...
   'B-centered orthorhombic primitive cell','oC','C-centered orthorhombic primitive cell','oF','face-centered orthorhombic primitive cell',...
   'oI','body-centered orthorhombic primitive cell','tP','tetragonal conventional cell','tI','body-centered tetragonal primitive cell',...
   'hP','hexagonal cell','hR','rhombohedral cell','cP','cubic conventional cell','cF','face-centered cubic primitive cell','cI','body-centered cubic primitive cell');
strout=update_setcell_Callback(handles.update_setcell,eventdata,handles);
if strcmpi(strout,'undefined') return; end
oldcell=unitcell;
cellconv=get(handles.cellconv_setcell,'value');
switch cellconv
   case 1, convmatrix=[1,0,0;0,1,0;0,0,1];
   case 2, convmatrix=[0,0.5,0.5;0.5,0,0.5;0.5,0.5,0];
      if ~ismember(strout,{'oP','cP'}) button=questdlg(['The current unit cell is incompatible with the specified cell conversion. ',...
            'Do you want to continue anyway?'],'Figuretool2','Yes','No','No');
         if ~strcmpi(button,'Yes') return; end
      end
   case 3, convmatrix=[-1,1,1;1,-1,1;1,1,-1];
      if ~ismember(strout,{'oF','cF'}) button=questdlg(['The current unit cell is incompatible with the specified cell conversion. ',...
            'Do you want to continue anyway?'],'Figuretool2','Yes','No','No');
         if ~strcmpi(button,'Yes') return; end
      end
   case 4, convmatrix=[-0.5,0.5,0.5;0.5,-0.5,0.5;0.5,0.5,-0.5];
      if ~ismember(strout,{'oP','tP','cP'}) button=questdlg(['The current unit cell is incompatible with the specified cell conversion. ',...
            'Do you want to continue anyway?'],'Figuretool2','Yes','No','No');
         if ~strcmpi(button,'Yes') return; end
      end
   case 5, convmatrix=[0,1,1;1,0,1;1,1,0];
      if ~ismember(strout,{'oI','tI','cI'}) button=questdlg(['The current unit cell is incompatible with the specified cell conversion. ',...
            'Do you want to continue anyway?'],'Figuretool2','Yes','No','No');
         if ~strcmpi(button,'Yes') return; end
      end
   case 6, convmatrix=[1,0,0;0,0.5,0.5;0,-0.5,0.5];
      if ~ismember(strout,{'mP','oP'}) button=questdlg(['The current unit cell is incompatible with the specified cell conversion. ',...
            'Do you want to continue anyway?'],'Figuretool2','Yes','No','No');
         if ~strcmpi(button,'Yes') return; end
      end
   case 7, convmatrix=[1,0,0;0,1,-1;0,1,1];
      if ~ismember(strout,{'mA','oA'}) button=questdlg(['The current unit cell is incompatible with the specified cell conversion. ',...
            'Do you want to continue anyway?'],'Figuretool2','Yes','No','No');
         if ~strcmpi(button,'Yes') return; end
      end
   case 8, convmatrix=[0.5,0,0.5;0,1,0;-0.5,0,0.5];
      if ~ismember(strout,{'mP','oP'}) button=questdlg(['The current unit cell is incompatible with the specified cell conversion. ',...
            'Do you want to continue anyway?'],'Figuretool2','Yes','No','No');
         if ~strcmpi(button,'Yes') return; end
      end
   case 9, convmatrix=[1,0,-1;0,1,0;1,0,1];
      if ~ismember(strout,{'mB','oB'}) button=questdlg(['The current unit cell is incompatible with the specified cell conversion. ',...
            'Do you want to continue anyway?'],'Figuretool2','Yes','No','No');
         if ~strcmpi(button,'Yes') return; end
      end
   case 10, convmatrix=[0.5,0.5,0;-0.5,0.5,0;0,0,1];
      if ~ismember(strout,{'mP','oP'}) button=questdlg(['The current unit cell is incompatible with the specified cell conversion. ',...
            'Do you want to continue anyway?'],'Figuretool2','Yes','No','No');
         if ~strcmpi(button,'Yes') return; end
      end
   case 11, convmatrix=[1,-1,0;1,1,0;0,0,1];
      if ~ismember(strout,{'mC','oC'}) button=questdlg(['The current unit cell is incompatible with the specified cell conversion. ',...
            'Do you want to continue anyway?'],'Figuretool2','Yes','No','No');
         if ~strcmpi(button,'Yes') return; end
      end
   case 12, convmatrix=[1,-1,0;0,1,-1;1,1,1];
      if ~ismember(strout,{'hR','cP','cF','cI'}) button=questdlg(['The current unit cell is incompatible with the specified cell conversion. ',...
            'Do you want to continue anyway?'],'Figuretool2','Yes','No','No');
         if ~strcmpi(button,'Yes') return; end
      end
   case 13, convmatrix=[2,1,1;-1,1,1;-1,-2,1]/3;
      if ~strcmpi(strout,'hP') button=questdlg(['The current unit cell is incompatible with the specified cell conversion. ',...
            'Do you want to continue anyway?'],'Figuretool2','Yes','No','No');
         if ~strcmpi(button,'Yes') return; end
      end
end
unitcell=convmatrix*unitcell;
set(handles.cellconv_setcell,'value',1);
set(handles.table_setcell,'data',num2cell(unitcell));
if (size(unitcell,1)==3)&&all(sum(abs(unitcell),2)>1E-4)&&det(unitcell)>1E-6
   temp=unitcell;
   set(handles.a_setcell,'string',sprintf('%.4f',norm(temp(1,:))));
   set(handles.b_setcell,'string',sprintf('%.4f',norm(temp(2,:))));
   set(handles.c_setcell,'string',sprintf('%.4f',norm(temp(3,:))));
   set(handles.alpha_setcell,'string',sprintf('%.2f',acosd(dot(temp(2,:),temp(3,:))/(norm(temp(2,:))*norm(temp(3,:))))));
   set(handles.beta_setcell,'string',sprintf('%.2f',acosd(dot(temp(1,:),temp(3,:))/(norm(temp(1,:))*norm(temp(3,:))))));
   set(handles.gamma_setcell,'string',sprintf('%.2f',acosd(dot(temp(1,:),temp(2,:))/(norm(temp(1,:))*norm(temp(2,:))))));
   set(handles.volume_setcell,'string',sprintf('Cell volume: %.5f',abs(det(temp))));
   [~,strout]=symsearch(temp);
   set(handles.bravais_setcell,'string',['Cell type: ',abbr.(strout)]);
end
if ~isempty(xyzlist)&&(cellconv~=1)
   if strcmpi(coordtype,'direct') xyzlist=xyzlist*oldcell/unitcell; end
   celllistgen();
end
status=0;

% --- Executes on selection change in cellconv_setcell.
function cellconv_setcell_Callback(hObject, eventdata, handles)
% hObject    handle to cellconv_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cellconv_setcell contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cellconv_setcell


% --- Executes during object creation, after setting all properties.
function cellconv_setcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cellconv_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function a_setcell_Callback(hObject, eventdata, handles)
% hObject    handle to a_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_setcell as text
%        str2double(get(hObject,'String')) returns contents of a_setcell as a double
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0) waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end

% --- Executes during object creation, after setting all properties.
function a_setcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function b_setcell_Callback(hObject, eventdata, handles)
% hObject    handle to b_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b_setcell as text
%        str2double(get(hObject,'String')) returns contents of b_setcell as a double
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0) waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end

% --- Executes during object creation, after setting all properties.
function b_setcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c_setcell_Callback(hObject, eventdata, handles)
% hObject    handle to c_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c_setcell as text
%        str2double(get(hObject,'String')) returns contents of c_setcell as a double
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0) waitfor(msgbox('Please enter a positive number.','Figuretool2')); return; end

% --- Executes during object creation, after setting all properties.
function c_setcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alpha_setcell_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha_setcell as text
%        str2double(get(hObject,'String')) returns contents of alpha_setcell as a double
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0)||(temp>=180) waitfor(msgbox('Please enter a number between 0 and 180.','Figuretool2')); return; end

% --- Executes during object creation, after setting all properties.
function alpha_setcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function beta_setcell_Callback(hObject, eventdata, handles)
% hObject    handle to beta_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of beta_setcell as text
%        str2double(get(hObject,'String')) returns contents of beta_setcell as a double
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0)||(temp>=180) waitfor(msgbox('Please enter a number between 0 and 180.','Figuretool2')); return; end

% --- Executes during object creation, after setting all properties.
function beta_setcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function gamma_setcell_Callback(hObject, eventdata, handles)
% hObject    handle to gamma_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma_setcell as text
%        str2double(get(hObject,'String')) returns contents of gamma_setcell as a double
temp=str2double(get(hObject,'String'));
if isnan(temp)||(temp<=0)||(temp>=180) waitfor(msgbox('Please enter a number between 0 and 180.','Figuretool2')); return; end

% --- Executes during object creation, after setting all properties.
function gamma_setcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in rbg_setcell.
function rbg_setcell_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in rbg_setcell 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb2_setcell')
   set(handles.a_setcell,'enable','on');
   set(handles.b_setcell,'enable','on');
   set(handles.c_setcell,'enable','on');
   set(handles.alpha_setcell,'enable','on');
   set(handles.beta_setcell,'enable','on');
   set(handles.gamma_setcell,'enable','on');
   set(handles.table_setcell,'enable','off');
   set(handles.moveup_setcell,'enable','off');
   set(handles.movedown_setcell,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb1_setcell')
   set(handles.a_setcell,'enable','off');
   set(handles.b_setcell,'enable','off');
   set(handles.c_setcell,'enable','off');
   set(handles.alpha_setcell,'enable','off');
   set(handles.beta_setcell,'enable','off');
   set(handles.gamma_setcell,'enable','off');
   set(handles.table_setcell,'enable','on');
   set(handles.moveup_setcell,'enable','on');
   set(handles.movedown_setcell,'enable','on');
end


% --- Executes when selected cell(s) is changed in table_setcell.
function table_setcell_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to table_setcell (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'Userdata',eventdata.Indices);


% --- Executes on button press in update_setcell.
function strout=update_setcell_Callback(hObject, eventdata, handles)
% hObject    handle to update_setcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global unitcell coordtype xyzlist;
oldcell=unitcell;
abbr=struct('aP','triclinic','mP','primitive monoclinic','mA','A-centered monoclinic (primitive)','mB','B-centered monoclinic (primitive)',...
   'mC','C-centered monoclinic (primitive)','oP','primitive orthorhombic','oA','A-centered orthorhombic (primitive)','oB',...
   'B-centered orthorhombic (primitive)','oC','C-centered orthorhombic (primitive)','oF','face-centered orthorhombic (primitive)',...
   'oI','body-centered orthorhombic (primitive)','tP','primitive tetragonal','tI','body-centered tetragonal (primitive)',...
   'hP','hexagonal','hR','rhombohedral','cP','primitive cubic','cF','face-centered cubic (primitive)','cI','body-centered cubic (primitive)');
strout='undefined';
if get(handles.rb1_setcell,'value')==1
   temp=get(handles.table_setcell,'data');
   if any(cellfun(@isempty,temp(:)))||any(cellfun(@isnan,temp(:)))
      waitfor(msgbox('Please make sure there is no empty or NaN cells in the table.','Figuretool2')); return;
   end
   temp=cell2mat(temp);
   if ~all(sum(abs(temp),2)>1E-6) waitfor(msgbox('One (or more) of the cell vectors is the zero vector.')); return; end
   set(handles.a_setcell,'string',sprintf('%.4f',norm(temp(1,:))));
   set(handles.b_setcell,'string',sprintf('%.4f',norm(temp(2,:))));
   set(handles.c_setcell,'string',sprintf('%.4f',norm(temp(3,:))));
   set(handles.alpha_setcell,'string',sprintf('%.2f',acosd(dot(temp(2,:),temp(3,:))/(norm(temp(2,:))*norm(temp(3,:))))));
   set(handles.beta_setcell,'string',sprintf('%.2f',acosd(dot(temp(1,:),temp(3,:))/(norm(temp(1,:))*norm(temp(3,:))))));
   set(handles.gamma_setcell,'string',sprintf('%.2f',acosd(dot(temp(1,:),temp(2,:))/(norm(temp(1,:))*norm(temp(2,:))))));
   set(handles.volume_setcell,'string',sprintf('Cell volume: %.5f',abs(det(temp))));
   if det(temp)<-1E-6 waitfor(msgbox('Detected a left-handed orientation of the cell vectors. Please swap any two vectors to make it right-handed.','Figuretool2')); return;
   elseif det(temp)<1E-6 waitfor(msgbox('Cell vectors cannot be coplanar!','Figuretool2')); return;
   end
   [temp,strout]=symsearch(temp);
   set(handles.bravais_setcell,'string',['Cell type: ',abbr.(strout)]);
   unitcell=temp;
elseif get(handles.rb2_setcell,'value')==1
   a=str2double(get(handles.a_setcell,'string'));
   b=str2double(get(handles.b_setcell,'string'));
   c=str2double(get(handles.c_setcell,'string'));
   alpha=str2double(get(handles.alpha_setcell,'string'));
   beta=str2double(get(handles.beta_setcell,'string'));
   gamma=str2double(get(handles.gamma_setcell,'string'));
   if any(isnan([a,b,c,alpha,beta,gamma])) waitfor(msgbox('Please fill in all cell parameters.','Figuretool2')); return; end
   if (alpha+beta+gamma>=360)||(alpha+beta<=gamma)||(alpha+gamma<=beta)||(beta+gamma<=alpha) waitfor(msgbox('Wrong cell parameters!','Figuretool2')); return; end
   tempa=[a,0,0]; tempb=[b*cosd(gamma),b*sind(gamma),0];
   tempcx=c*cosd(beta); tempcy=(c*cosd(alpha)-c*cosd(beta)*cosd(gamma))/sind(gamma);
   tempc=[tempcx,tempcy,sqrt(c^2-tempcx^2-tempcy^2)]; temp=[tempa;tempb;tempc];
   [temp,strout]=symsearch(temp);
   set(handles.table_setcell,'data',num2cell(temp));
   set(handles.volume_setcell,'string',sprintf('Cell volume: %.5f',abs(det(temp))));
   set(handles.bravais_setcell,'string',['Cell type: ',abbr.(strout)]);
   unitcell=temp;
end
if ~isempty(xyzlist)
   if strcmpi(coordtype,'direct') xyzlist=xyzlist*oldcell/unitcell; end
   celllistgen();
end