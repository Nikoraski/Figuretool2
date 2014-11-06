function varargout = rotateatom(varargin)
% ROTATEATOM MATLAB code for rotateatom.fig
%      ROTATEATOM, by itself, creates a new ROTATEATOM or raises the existing
%      singleton*.
%
%      H = ROTATEATOM returns the handle to a new ROTATEATOM or the handle to
%      the existing singleton*.
%
%      ROTATEATOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROTATEATOM.M with the given input arguments.
%
%      ROTATEATOM('Property','Value',...) creates a new ROTATEATOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rotateatom_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rotateatom_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rotateatom

% Last Modified by GUIDE v2.5 27-Aug-2014 16:39:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rotateatom_OpeningFcn, ...
                   'gui_OutputFcn',  @rotateatom_OutputFcn, ...
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


% --- Executes just before rotateatom is made visible.
function rotateatom_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rotateatom (see VARARGIN)

% Choose default command line output for rotateatom
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rotateatom wait for user response (see UIRESUME)
% uiwait(handles.rotateatom);


% --- Outputs from this function are returned to the command line.
function varargout = rotateatom_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function site_edit_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to site_edit_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of site_edit_rotateatom as text
%        str2double(get(hObject,'String')) returns contents of site_edit_rotateatom as a double


% --- Executes during object creation, after setting all properties.
function site_edit_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to site_edit_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in site_gredit_rotateatom.
function site_gredit_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to site_gredit_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.site_edit_rotateatom,'string');
[stackin,reflistin,status]=siterefparser(temp);
if status==0 h0=groupeditor;
else h0=groupeditor('userdata',{temp,stackin,reflistin});
end
uiwait(h0);
if ~ishandle(h0) return; end
temp=get(h0,'userdata');
delete(h0);
if strcmpi(temp,'cancelled') return; end
set(handles.site_edit_rotateatom,'string',temp);


function degree_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to degree_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(hObject,'string');
if isnan(temp)||(temp<-180)||(temp>=360) set(hObject,'string','0'); waitfor(msgbox('Please enter the degree of rotation','Figuretool2')); end
% Hints: get(hObject,'String') returns contents of degree_rotateatom as text
%        str2double(get(hObject,'String')) returns contents of degree_rotateatom as a double


% --- Executes during object creation, after setting all properties.
function degree_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to degree_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup1_rotateatom.
function popup1_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to popup1_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=get(hObject,'value');
if temp==1 set(handles.y1_rotateatom,'enable','off'); set(handles.z1_rotateatom,'enable','off');
   temp2=str2double(get(handles.x1_rotateatom,'string'));
   if isnan(temp2)||(temp2<1)||(temp2>numel(atomlist))||(temp2~=round(temp2)) set(handles.x1_rotateatom,'string','1');
      waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist))],'Figuretool2'));
   end
else set(handles.y1_rotateatom,'enable','on'); set(handles.z1_rotateatom,'enable','on');
end
% Hints: contents = cellstr(get(hObject,'String')) returns popup1_rotateatom contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup1_rotateatom


% --- Executes during object creation, after setting all properties.
function popup1_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup1_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x1_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to x1_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=str2double(hObject,'string');
if get(handles.popup1,'value')==1
   if isnan(temp)||(temp<1)||(temp>numel(atomlist))||(temp~=round(temp)) set(hObject,'string','1');
      waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
   end
else
   if isnan(temp) set(hObject,'string','0');
      waitfor(msgbox('Please enter a real number.','Figuretool2'));
   end
end
% Hints: get(hObject,'String') returns contents of x1_rotateatom as text
%        str2double(get(hObject,'String')) returns contents of x1_rotateatom as a double


% --- Executes during object creation, after setting all properties.
function x1_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y1_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to y1_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(hObject,'string');
if isnan(temp) set(hObject,'string','0');
   waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of y1_rotateatom as text
%        str2double(get(hObject,'String')) returns contents of y1_rotateatom as a double


% --- Executes during object creation, after setting all properties.
function y1_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y1_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z1_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to z1_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(hObject,'string');
if isnan(temp) set(hObject,'string','0');
   waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of z1_rotateatom as text
%        str2double(get(hObject,'String')) returns contents of z1_rotateatom as a double


% --- Executes during object creation, after setting all properties.
function z1_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z1_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup2_rotateatom.
function popup2_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to popup2_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=get(hObject,'value');
if temp==1 set(handles.y2_rotateatom,'enable','off'); set(handles.z2_rotateatom,'enable','off');
   temp2=str2double(get(handles.x2_rotateatom,'string'));
   if isnan(temp2)||(temp2<1)||(temp2>numel(atomlist))||(temp2~=round(temp2)) set(handles.x2_rotateatom,'string','1');
      waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
   end
else set(handles.y2_rotateatom,'enable','on'); set(handles.z2_rotateatom,'enable','on');
end
% Hints: contents = cellstr(get(hObject,'String')) returns popup2_rotateatom contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup2_rotateatom


% --- Executes during object creation, after setting all properties.
function popup2_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup2_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x2_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to x2_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=str2double(hObject,'string');
if get(handles.popup2,'value')==1
   if isnan(temp)||(temp<1)||(temp>numel(atomlist))||(temp~=round(temp)) set(hObject,'string','1');
      waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
   end
else
   if isnan(temp) set(hObject,'string','0');
      waitfor(msgbox('Please enter a real number.','Figuretool2'));
   end
end
% Hints: get(hObject,'String') returns contents of x2_rotateatom as text
%        str2double(get(hObject,'String')) returns contents of x2_rotateatom as a double


% --- Executes during object creation, after setting all properties.
function x2_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x2_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y2_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to y2_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(hObject,'string');
if isnan(temp) set(hObject,'string','0');
   waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of y2_rotateatom as text
%        str2double(get(hObject,'String')) returns contents of y2_rotateatom as a double


% --- Executes during object creation, after setting all properties.
function y2_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y2_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z2_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to z2_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(hObject,'string');
if isnan(temp) set(hObject,'string','0');
   waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of z2_rotateatom as text
%        str2double(get(hObject,'String')) returns contents of z2_rotateatom as a double


% --- Executes during object creation, after setting all properties.
function z2_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z2_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup3_rotateatom.
function popup3_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to popup3_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=get(hObject,'value');
if temp==1 set(handles.y3_rotateatom,'enable','off'); set(handles.z3_rotateatom,'enable','off');
   temp2=str2double(get(handles.x1_rotateatom,'string'));
   if isnan(temp2)||(temp2<1)||(temp2>numel(atomlist))||(temp2~=round(temp2)) set(handles.x3_rotateatom,'string','1');
      waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
   end
else set(handles.y3_rotateatom,'enable','on'); set(handles.z3_rotateatom,'enable','on');
end
% Hints: contents = cellstr(get(hObject,'String')) returns popup3_rotateatom contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup3_rotateatom


% --- Executes during object creation, after setting all properties.
function popup3_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup3_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x3_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to x3_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global atomlist;
temp=str2double(hObject,'string');
if get(handles.popup3,'value')==1
   if isnan(temp)||(temp<1)||(temp>numel(atomlist))||(temp~=round(temp)) set(hObject,'string','1');
      waitfor(msgbox(['Please enter an integer between 1 and ',num2str(numel(atomlist)),'.'],'Figuretool2'));
   end
else
   if isnan(temp) set(hObject,'string','0');
      waitfor(msgbox('Please enter a real number.','Figuretool2'));
   end
end
% Hints: get(hObject,'String') returns contents of x3_rotateatom as text
%        str2double(get(hObject,'String')) returns contents of x3_rotateatom as a double


% --- Executes during object creation, after setting all properties.
function x3_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x3_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y3_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to y3_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(hObject,'string');
if isnan(temp) set(hObject,'string','0');
   waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of y3_rotateatom as text
%        str2double(get(hObject,'String')) returns contents of y3_rotateatom as a double


% --- Executes during object creation, after setting all properties.
function y3_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y3_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z3_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to z3_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(hObject,'string');
if isnan(temp) set(hObject,'string','0');
   waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of z3_rotateatom as text
%        str2double(get(hObject,'String')) returns contents of z3_rotateatom as a double


% --- Executes during object creation, after setting all properties.
function z3_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z3_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup4_rotateatom.
function popup4_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to popup4_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup4_rotateatom contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup4_rotateatom


% --- Executes during object creation, after setting all properties.
function popup4_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup4_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x4_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to x4_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(hObject,'string');
if isnan(temp) set(hObject,'string','0');
   waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of x4_rotateatom as text
%        str2double(get(hObject,'String')) returns contents of x4_rotateatom as a double


% --- Executes during object creation, after setting all properties.
function x4_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x4_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y4_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to y4_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(hObject,'string');
if isnan(temp) set(hObject,'string','0');
   waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of y4_rotateatom as text
%        str2double(get(hObject,'String')) returns contents of y4_rotateatom as a double


% --- Executes during object creation, after setting all properties.
function y4_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y4_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z4_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to z4_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2double(hObject,'string');
if isnan(temp) set(hObject,'string','0');
   waitfor(msgbox('Please enter a real number.','Figuretool2'));
end
% Hints: get(hObject,'String') returns contents of z4_rotateatom as text
%        str2double(get(hObject,'String')) returns contents of z4_rotateatom as a double


% --- Executes during object creation, after setting all properties.
function z4_rotateatom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z4_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_rotateatom.
function OK_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to OK_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cancel_rotateatom.
function cancel_rotateatom_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_rotateatom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(get(hObject,'parent'),'userdata','cancelled');
uiresume;


% --- Executes when selected object is changed in axistype_rotateatom.
function axistype_rotateatom_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in axistype_rotateatom 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_rotateatom')
   set(handles.popup1_rotateatom,'enable','on');
   set(handles.popup2_rotateatom,'enable','on');
   set(handles.x1_rotateatom,'enable','on');
   set(handles.x2_rotateatom,'enable','on');
   if get(handles.popup1_rotateatom,'value')~=1
      set(handles.y1_rotateatom,'enable','on');
      set(handles.z1_rotateatom,'enable','on');
   end
   if get(handles.popup2_rotateatom,'value')~=1
      set(handles.y2_rotateatom,'enable','on');
      set(handles.z2_rotateatom,'enable','on');
   end
   set(handles.popup3_rotateatom,'enable','off');
   set(handles.x3_rotateatom,'enable','off');
   set(handles.y3_rotateatom,'enable','off');
   set(handles.z3_rotateatom,'enable','off');
   set(handles.popup4_rotateatom,'enable','off');
   set(handles.x4_rotateatom,'enable','off');
   set(handles.y4_rotateatom,'enable','off');
   set(handles.z4_rotateatom,'enable','off');
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_rotateatom')
   set(handles.popup3_rotateatom,'enable','on');
   set(handles.popup4_rotateatom,'enable','on');
   set(handles.x3_rotateatom,'enable','on');
   set(handles.x4_rotateatom,'enable','on');
   set(handles.y4_rotateatom,'enable','on');
   set(handles.z4_rotateatom,'enable','on');
   if get(handles.popup3_rotateatom,'value')~=1
      set(handles.y3_rotateatom,'enable','on');
      set(handles.z3_rotateatom,'enable','on');
   end
   set(handles.popup1_rotateatom,'enable','off');
   set(handles.x1_rotateatom,'enable','off');
   set(handles.y1_rotateatom,'enable','off');
   set(handles.z1_rotateatom,'enable','off');
   set(handles.popup2_rotateatom,'enable','off');
   set(handles.x2_rotateatom,'enable','off');
   set(handles.y2_rotateatom,'enable','off');
   set(handles.z2_rotateatom,'enable','off');
end
