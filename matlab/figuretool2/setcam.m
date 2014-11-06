function varargout = setcam(varargin)
% SETCAM MATLAB code for setcam.fig
%      SETCAM, by itself, creates a new SETCAM or raises the existing
%      singleton*.
%
%      H = SETCAM returns the handle to a new SETCAM or the handle to
%      the existing singleton*.
%
%      SETCAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETCAM.M with the given input arguments.
%
%      SETCAM('Property','Value',...) creates a new SETCAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before setcam_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to setcam_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setcam

% Last Modified by GUIDE v2.5 10-Jul-2014 15:21:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
   'gui_Singleton',  gui_Singleton, ...
   'gui_OpeningFcn', @setcam_OpeningFcn, ...
   'gui_OutputFcn',  @setcam_OutputFcn, ...
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


% --- Executes just before setcam is made visible.
function setcam_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to setcam (see VARARGIN)

% Choose default command line output for setcam
global camparam;
handles.output = hObject;
if strcmpi(camparam.adv,'off')
   temp=get(hObject,'position'); temp(3)=66.0;
   set(hObject,'position',temp);
else
   set(hObject,'name','Camera & light settings - advanced');
   set(handles.adv_setcam,'string','Advanced <<');
end
set(hObject,'Userdata',camparam);
% Update handles structure
guidata(hObject, handles);
if numel(camparam.cv)==3
   set(handles.rb1_cv_setcam,'value',1);
   set(handles.x_cv_setcam,'enable','on','string',num2str(camparam.cv(1)));
   set(handles.y_cv_setcam,'enable','on','string',num2str(camparam.cv(2)));
   set(handles.z_cv_setcam,'enable','on','string',num2str(camparam.cv(3)));
   set(handles.az_cv_setcam,'enable','off');
   set(handles.el_cv_setcam,'enable','off');
elseif numel(camparam.cv)==2
   set(handles.rb2_cv_setcam,'value',1);
   set(handles.x_cv_setcam,'enable','off');
   set(handles.y_cv_setcam,'enable','off');
   set(handles.z_cv_setcam,'enable','off');
   set(handles.az_cv_setcam,'enable','on','string',num2str(camparam.cv(1)));
   set(handles.el_cv_setcam,'enable','on','string',num2str(camparam.cv(2)));
end
if numel(camparam.cu)==3
   set(handles.rb1_cu_setcam,'value',1);
   set(handles.x_cu_setcam,'enable','on','string',num2str(camparam.cu(1)));
   set(handles.y_cu_setcam,'enable','on','string',num2str(camparam.cu(2)));
   set(handles.z_cu_setcam,'enable','on','string',num2str(camparam.cu(3)));
   set(handles.az_cu_setcam,'enable','off');
   set(handles.el_cu_setcam,'enable','off');
elseif numel(camparam.cu)==2
   set(handles.rb2_cu_setcam,'value',1);
   set(handles.x_cu_setcam,'enable','off');
   set(handles.y_cu_setcam,'enable','off');
   set(handles.z_cu_setcam,'enable','off');
   set(handles.az_cu_setcam,'enable','on','string',num2str(camparam.cu(1)));
   set(handles.el_cu_setcam,'enable','on','string',num2str(camparam.cu(2)));
end
if numel(camparam.ld)==3
   set(handles.rb1_ld_setcam,'value',1);
   set(handles.x_ld_setcam,'enable','on','string',num2str(camparam.ld(1)));
   set(handles.y_ld_setcam,'enable','on','string',num2str(camparam.ld(2)));
   set(handles.z_ld_setcam,'enable','on','string',num2str(camparam.ld(3)));
   set(handles.az_ld_setcam,'enable','off');
   set(handles.el_ld_setcam,'enable','off');
elseif numel(camparam.ld)==2
   set(handles.rb2_ld_setcam,'value',1);
   set(handles.x_ld_setcam,'enable','off');
   set(handles.y_ld_setcam,'enable','off');
   set(handles.z_ld_setcam,'enable','off');
   set(handles.az_ld_setcam,'enable','on','string',num2str(camparam.ld(1)));
   set(handles.el_ld_setcam,'enable','on','string',num2str(camparam.ld(2)));
end
set(handles.cz_setcam,'string',num2str(camparam.cz));
if ischar(camparam.cp)&&strcmpi(camparam.cp,'default')
   set(handles.rb1_cp_setcam,'value',1);
   set(handles.x_cp_setcam,'enable','off');
   set(handles.y_cp_setcam,'enable','off');
   set(handles.z_cp_setcam,'enable','off');
elseif isnumeric(camparam.cp)
   set(handles.rb2_cp_setcam,'value',1);
   set(handles.x_cp_setcam,'enable','on','string',num2str(camparam.cp(1)));
   set(handles.y_cp_setcam,'enable','on','string',num2str(camparam.cp(2)));
   set(handles.z_cp_setcam,'enable','on','string',num2str(camparam.cp(3)));
end
if ischar(camparam.ct)&&strcmpi(camparam.ct,'default')
   set(handles.rb1_ct_setcam,'value',1);
   set(handles.x_ct_setcam,'enable','off');
   set(handles.y_ct_setcam,'enable','off');
   set(handles.z_ct_setcam,'enable','off');
elseif isnumeric(camparam.ct)
   set(handles.rb2_ct_setcam,'value',1);
   set(handles.x_ct_setcam,'enable','on','string',num2str(camparam.ct(1)));
   set(handles.y_ct_setcam,'enable','on','string',num2str(camparam.ct(2)));
   set(handles.z_ct_setcam,'enable','on','string',num2str(camparam.ct(3)));
end
if ischar(camparam.cr)&&strcmpi(camparam.cr,'default')
   set(handles.check_cr_setcam,'value',0);
   set(handles.edit_cr_setcam,'enable','off');
elseif isnumeric(camparam.cr)
   set(handles.check_cr_setcam,'value',1);
   set(handles.edit_cr_setcam,'enable','on','string',num2str(camparam.cr));
end
if ischar(camparam.cva)&&strcmpi(camparam.cva,'default')
   set(handles.check_cva_setcam,'value',0);
   set(handles.edit_cva_setcam,'enable','off');
elseif isnumeric(camparam.cva)
   set(handles.check_cva_setcam,'value',1);
   set(handles.edit_cva_setcam,'enable','on','string',num2str(camparam.cva));
end
if strcmpi(camparam.pt,'orthographic') set(handles.rb1_pt_setcam,'value',1);
elseif strcmpi(camparam.pt,'perspective') set(handles.rb2_pt_setcam,'value',1);
end
if strcmpi(camparam.lt,'parallel') set(handles.rb1_lt_setcam,'value',1);
elseif strcmpi(camparam.lt,'divergent') set(handles.rb2_lt_setcam,'value',1);
end
if strcmpi(camparam.lc,'relative') set(handles.rb1_lc_setcam,'value',1);
elseif strcmpi(camparam.lc,'absolute') set(handles.rb2_lc_setcam,'value',1);
end
[xr,yr,zr]=sphere(50);
hold(handles.prev_setcam,'on');
surf(handles.prev_setcam,xr,yr,zr,'facecolor',[0,0.35,1],'linestyle','none','facelighting','gouraud');
line([-1,-1],[-1,-1],[-1,1],'color',[1,0.65,0.3]);
line([-1,-1],[-1,1],[-1,-1],'color',[1,0.65,0.3]);
line([-1,1],[-1,-1],[-1,-1],'color',[1,0.65,0.3]);
line([-1,-1],[-1,1],[1,1],'color',[1,0.65,0.3]);
line([-1,1],[-1,-1],[1,1],'color',[1,0.65,0.3]);
line([-1,-1],[1,1],[-1,1],'color',[1,0.65,0.3]);
line([-1,1],[1,1],[-1,-1],'color',[1,0.65,0.3]);
line([1,1],[-1,-1],[-1,1],'color',[1,0.65,0.3]);
line([1,1],[-1,1],[-1,-1],'color',[1,0.65,0.3]);
line([1,1],[1,1],[-1,1],'color',[1,0.65,0.3]);
line([1,1],[-1,1],[1,1],'color',[1,0.65,0.3]);
line([-1,1],[1,1],[1,1],'color',[1,0.65,0.3]);
arrow3d([0,0,0],[2,0,0],pi/12,'cylinder',[0.25,0.15],[30,30]);
arrow3d([0,0,0],[0,2,0],pi/12,'cylinder',[0.25,0.15],[30,30]);
arrow3d([0,0,0],[0,0,2],pi/12,'cylinder',[0.25,0.15],[30,30]);
text(2.2,0,0,'a','HorizontalAlignment','center','tag','a_setcam');
text(0,2.2,0,'b','HorizontalAlignment','center','tag','b_setcam');
text(0,0,2.2,'c','HorizontalAlignment','center','tag','c_setcam');
axis(handles.prev_setcam,'off');
axis(handles.prev_setcam,'equal');
camtarget(handles.prev_setcam,[0,0,0]);
light('tag','light_prev_setcam');
camzoom(handles.prev_setcam,0.9);
prevupdate();


%  Functions arrow3d and rotatedata are obtained from MathWorks file exchange. Original comments have been removed.
%  http://www.mathworks.com/matlabcentral/fileexchange/8396-draw-3d-arrows/ (author: Changshun Deng)

function arrow3d(start,stop,ang,ltype,p,n)
dvec=stop-start;
dis=sqrt(sum(dvec.^2,2));
hv=min(dis)*p(1);
init_stop=[zeros(size(dis)) zeros(size(dis)) (dis-hv).*ones(size(dis))];
cosrang=acos(dvec(:,3)./dis);
nvec=[-dvec(:,2) dvec(:,1) zeros(size(dis))];
if strcmpi(ltype,'line')
   for i=1:length(dis)
      [rx,ry,rz]=rotatedata(init_stop(i,1),init_stop(i,2),init_stop(i,3),nvec(i,:),cosrang(i),[0,0,0]);
      line([start(i,1);start(i,1)+rx],[start(i,2);start(i,2)+ry],[start(i,3);start(i,3)+rz]);
   end
else
   for i=1:length(dis)
      r=hv*tan(ang).*p(2);
      [xi,yi,zi]=cylinder(r.*[1,1],n(2));
      zi=zi.*(dis(i)-hv);
      if all(nvec(i,:)==0)
         nvec(i,:)=[0,1,0];
      end
      [rx,ry,rz]=rotatedata(xi,yi,zi,nvec(i,:),cosrang(i),[0,0,0]);
      cx=start(i,1)+rx;cy=start(i,2)+ry;cz=start(i,3)+rz;
      surf(cx,cy,cz,'edgecolor','none','facecolor',[0 0 0],'facelighting','none');
      patch(cx(1,:),cy(1,:),cz(1,:),[0 0 0]);
   end
end
pv=dis-hv;
for i=1:length(dis)
   [xi,yi,zi]=cylinder([tan(ang),0],n(1));
   xi=xi*hv;yi=yi*hv;zi=zi*hv+pv(i);
   [rx,ry,rz]=rotatedata(xi,yi,zi,nvec(i,:),cosrang(i),[0,0,0]);
   cx=start(i,1)+rx;cy=start(i,2)+ry;cz=start(i,3)+rz;
   surf(cx,cy,cz,'edgecolor','none','facecolor',[0 0 0],'facelighting','none');
   patch(cx(1,:),cy(1,:),cz(1,:),[0 0 0]);
end

function [newx,newy,newz]=rotatedata(xdata,ydata,zdata,azel,alpha,origin)
if numel(azel)==2
   theta=azel(1);
   phi=azel(2);
   u=[cos(phi)*cos(theta);cos(phi)*sin(theta);sin(phi)];
elseif numel(azel)==3
   u=azel(:)/norm(azel);
end
alph=alpha;
cosa=cos(alph);
sina=sin(alph);
vera=1-cosa;
x0=u(1);
y0=u(2);
z0=u(3);
rot=[cosa+x0^2*vera x0*y0*vera-z0*sina x0*z0*vera+y0*sina; ...
   x0*y0*vera+z0*sina cosa+y0^2*vera y0*z0*vera-x0*sina; ...
   x0*z0*vera-y0*sina y0*z0*vera+x0*sina cosa+z0^2*vera]';
[m,n]=size(xdata);
newxyz=[xdata(:),ydata(:),zdata(:)];
newxyz=newxyz*rot;
newx=origin(1)+reshape(newxyz(:,1),m,n);
newy=origin(2)+reshape(newxyz(:,2),m,n);
newz=origin(3)+reshape(newxyz(:,3),m,n);

% --- Outputs from this function are returned to the command line.
function varargout = setcam_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function x_cv_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to x_cv_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_cv_setcam as text
%        str2double(get(hObject,'String')) returns contents of x_cv_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.cv(1)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function x_cv_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_cv_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function y_cv_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to y_cv_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_cv_setcam as text
%        str2double(get(hObject,'String')) returns contents of y_cv_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.cv(2)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function y_cv_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_cv_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function z_cv_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to z_cv_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_cv_setcam as text
%        str2double(get(hObject,'String')) returns contents of z_cv_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.cv(3)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function z_cv_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_cv_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function az_cv_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to az_cv_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of az_cv_setcam as text
%        str2double(get(hObject,'String')) returns contents of az_cv_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.cv(1)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function az_cv_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to az_cv_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function el_cv_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to el_cv_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of el_cv_setcam as text
%        str2double(get(hObject,'String')) returns contents of el_cv_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)||(temp>90)||(temp<-90)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number between -90 and 90.','Figuretool2'));
else camparam.cv(2)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function el_cv_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to el_cv_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function x_cu_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to x_cu_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_cu_setcam as text
%        str2double(get(hObject,'String')) returns contents of x_cu_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.cu(1)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function x_cu_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_cu_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function y_cu_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to y_cu_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_cu_setcam as text
%        str2double(get(hObject,'String')) returns contents of y_cu_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.cu(2)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function y_cu_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_cu_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function z_cu_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to z_cu_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_cu_setcam as text
%        str2double(get(hObject,'String')) returns contents of z_cu_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.cu(3)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function z_cu_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_cu_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function az_cu_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to az_cu_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of az_cu_setcam as text
%        str2double(get(hObject,'String')) returns contents of az_cu_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.cu(1)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function az_cu_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to az_cu_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function el_cu_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to el_cu_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of el_cu_setcam as text
%        str2double(get(hObject,'String')) returns contents of el_cu_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)||(temp>90)||(temp<-90)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number between -90 and 90.','Figuretool2'));
else camparam.cu(2)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function el_cu_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to el_cu_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


function cz_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to cz_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cz_setcam as text
%        str2double(get(hObject,'String')) returns contents of cz_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)||(temp<=0)
   set(hObject,'string','1.00'); waitfor(msgbox('Please enter a positive real number.','Figuretool2'));
else camparam.cz=temp;
end

% --- Executes during object creation, after setting all properties.
function cz_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cz_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK_setcam.
function OK_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to OK_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camparam;
camparamnew=camparam;
if get(handles.rb1_cv_setcam,'value')==1
   temp=[str2double(get(handles.x_cv_setcam,'string')),str2double(get(handles.y_cv_setcam,'string')),str2double(get(handles.z_cv_setcam,'string'))];
   if norm(temp)==0 waitfor(msgbox('Viewing direction cannot be the zero vector!','Figuretool2')); return;
   else camparamnew.cv=temp;
   end
elseif get(handles.rb2_cv_setcam,'value')==1
   camparamnew.cv=[str2double(get(handles.az_cv_setcam,'string')),str2double(get(handles.el_cv_setcam,'string'))];
end
if get(handles.rb1_cu_setcam,'value')==1
   temp=[str2double(get(handles.x_cu_setcam,'string')),str2double(get(handles.y_cu_setcam,'string')),str2double(get(handles.z_cu_setcam,'string'))];
   if norm(temp)==0 waitfor(msgbox('Up direction cannot be the zero vector!','Figuretool2')); return;
   else camparamnew.cu=temp;
   end
elseif get(handles.rb2_cu_setcam,'value')==1
   camparamnew.cu=[str2double(get(handles.az_cu_setcam,'string')),str2double(get(handles.el_cu_setcam,'string'))];
end
if numel(camparamnew.cv)==2 [xx,yy,zz]=sph2cart(camparamnew.cv(1)/180*pi,camparamnew.cv(2)/180*pi,1); tempcv=[xx,yy,zz]; else tempcv=camparamnew.cv; end
if numel(camparamnew.cu)==2 [xx,yy,zz]=sph2cart(camparamnew.cu(1)/180*pi,camparamnew.cu(2)/180*pi,1); tempcu=[xx,yy,zz]; else tempcu=camparamnew.cu; end
if abs(cross(tempcv,tempcu))<1E-6 waitfor(msgbox('Viewing direction and up direction cannot be collinear!','Figuretool2')); return; end
if get(handles.rb1_ld_setcam,'value')==1
   temp=[str2double(get(handles.x_ld_setcam,'string')),str2double(get(handles.y_ld_setcam,'string')),str2double(get(handles.z_ld_setcam,'string'))];
   if norm(temp)==0 waitfor(msgbox('Lighting direction cannot be the zero vector!','Figuretool2')); return;
   else camparamnew.ld=temp;
   end
elseif get(handles.rb2_ld_setcam,'value')==1
   camparamnew.ld=[str2double(get(handles.az_ld_setcam,'string')),str2double(get(handles.el_ld_setcam,'string'))];
end
camparamnew.cz=str2double(get(handles.cz_setcam,'string'));
if (get(handles.rb2_cp_setcam,'value')==1)&&(get(handles.rb2_ct_setcam,'value')==1)
   temp1=[str2double(get(handles.x_cp_setcam,'string')),str2double(get(handles.y_cp_setcam,'string')),str2double(get(handles.z_cp_setcam,'string'))];
   temp2=[str2double(get(handles.x_ct_setcam,'string')),str2double(get(handles.y_ct_setcam,'string')),str2double(get(handles.z_ct_setcam,'string'))];
   if isequal(temp1,temp2) waitfor(msgbox('Camera position and camera target cannot be identical!','Figuretool2')); return;
   else camparamnew.cv=temp1-temp2;
   end
end
if get(handles.rb1_cp_setcam,'value')==1
   camparamnew.cp='default';
elseif get(handles.rb2_cp_setcam,'value')==1
   camparamnew.cp=[str2double(get(handles.x_cp_setcam,'string')),str2double(get(handles.y_cp_setcam,'string')),str2double(get(handles.z_cp_setcam,'string'))];
end
if get(handles.rb1_ct_setcam,'value')==1
   camparamnew.ct='default';
elseif get(handles.rb2_ct_setcam,'value')==1
   camparamnew.ct=[str2double(get(handles.x_ct_setcam,'string')),str2double(get(handles.y_ct_setcam,'string')),str2double(get(handles.z_ct_setcam,'string'))];
end
if get(handles.check_cr_setcam,'value')==1
   camparamnew.cr=str2double(get(handles.edit_cr_setcam,'string'));
elseif get(handles.check_cr_setcam,'value')==0
   camparamnew.cr='default';
end
if get(handles.check_cva_setcam,'value')==1
   camparamnew.cva=str2double(get(handles.edit_cva_setcam,'string'));
elseif get(handles.check_cr_setcam,'value')==0
   camparamnew.cva='default';
end
if get(handles.rb1_pt_setcam,'value')==1
   camparamnew.pt='orthographic';
elseif get(handles.rb2_pt_setcam,'value')==1
   camparamnew.pt='perspective';
end
if get(handles.rb1_lt_setcam,'value')==1
   camparamnew.lt='parallel';
elseif get(handles.rb2_lt_setcam,'value')==1
   camparamnew.lt='divergent';
end
if get(handles.rb1_lc_setcam,'value')==1
   camparamnew.lc='relative';
elseif get(handles.rb2_lc_setcam,'value')==1
   camparamnew.lc='absolute';
end
camparam=camparamnew;
uiresume;

% --- Executes on button press in cancel_setcam.
function cancel_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camparam;
camparam=get(get(hObject,'parent'),'userdata');
uiresume;

% --- Executes on button press in adv_setcam.
function adv_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to adv_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camparam;
if strcmpi(get(hObject,'string'),'Advanced >>')
   temp=get(get(hObject,'parent'),'position');temp(3)=128.6;
   set(get(hObject,'parent'),'position',temp);
   set(get(hObject,'parent'),'name','Camera & light settings - advanced');
   set(hObject,'string','Advanced <<');
   camparam.adv='on';
elseif strcmpi(get(hObject,'string'),'Advanced <<')
   temp=get(get(hObject,'parent'),'position');temp(3)=66.0;
   set(get(hObject,'parent'),'position',temp);
   set(get(hObject,'parent'),'name','Camera & light settings');
   set(hObject,'string','Advanced >>');
   camparam.adv='off';
end

function el_ld_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to el_ld_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of el_ld_setcam as text
%        str2double(get(hObject,'String')) returns contents of el_ld_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)||(temp>90)||(temp<-90)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number between -90 and 90.','Figuretool2'));
else camparam.ld(2)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function el_ld_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to el_ld_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function az_ld_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to az_ld_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of az_ld_setcam as text
%        str2double(get(hObject,'String')) returns contents of az_ld_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.ld(1)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function az_ld_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to az_ld_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function z_ld_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to z_ld_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_ld_setcam as text
%        str2double(get(hObject,'String')) returns contents of z_ld_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.ld(3)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function z_ld_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_ld_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function y_ld_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to y_ld_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_ld_setcam as text
%        str2double(get(hObject,'String')) returns contents of y_ld_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.ld(2)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function y_ld_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_ld_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end

function x_ld_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to x_ld_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_ld_setcam as text
%        str2double(get(hObject,'String')) returns contents of x_ld_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.ld(1)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function x_ld_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_ld_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function prev_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prev_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis(hObject,'off');
% Hint: place code in OpeningFcn to populate prev_setcam


% --- Executes on button press in check_cr_setcam.
function check_cr_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to check_cr_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_cr_setcam
global camparam;
if get(hObject,'Value')==1
   set(handles.edit_cr_setcam,'enable','on');
   camparam.cr=str2double(get(handles.edit_cr_setcam,'string'));
elseif get(hObject,'Value')==0
   set(handles.edit_cr_setcam,'enable','off');
   camparam.cr='default';
end
prevupdate();

% --- Executes on button press in check_cva_setcam.
function check_cva_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to check_cva_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_cva_setcam
if get(hObject,'Value')==1
   set(handles.edit_cva_setcam,'enable','on');
   camparam.cva=str2double(get(handles.edit_cva_setcam,'string'));
elseif get(hObject,'Value')==0
   set(handles.edit_cva_setcam,'enable','off');
   camparam.cva='default';
end


function edit_cr_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cr_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cr_setcam as text
%        str2double(get(hObject,'String')) returns contents of edit_cr_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.cr=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function edit_cr_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cr_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function edit_cva_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cva_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cva_setcam as text
%        str2double(get(hObject,'String')) returns contents of edit_cva_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)||(temp<=0)
   set(hObject,'string','1.0'); waitfor(msgbox('Please enter a positive real number.','Figuretool2'));
else camparam.cva=temp;
end

% --- Executes during object creation, after setting all properties.
function edit_cva_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cva_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function z_ct_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to z_ct_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_ct_setcam as text
%        str2double(get(hObject,'String')) returns contents of z_ct_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.ct(3)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function z_ct_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_ct_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function y_ct_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to y_ct_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_ct_setcam as text
%        str2double(get(hObject,'String')) returns contents of y_ct_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.ct(2)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function y_ct_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_ct_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function x_ct_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to x_ct_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_ct_setcam as text
%        str2double(get(hObject,'String')) returns contents of x_ct_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.ct(1)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function x_ct_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_ct_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function x_cp_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to x_cp_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_cp_setcam as text
%        str2double(get(hObject,'String')) returns contents of x_cp_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.cp(1)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function x_cp_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_cp_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end



function y_cp_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to y_cp_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_cp_setcam as text
%        str2double(get(hObject,'String')) returns contents of y_cp_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.cp(2)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function y_cp_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_cp_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end

function z_cp_setcam_Callback(hObject, eventdata, handles)
% hObject    handle to z_cp_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_cp_setcam as text
%        str2double(get(hObject,'String')) returns contents of z_cp_setcam as a double
global camparam;
temp=str2double(get(hObject,'string'));
if isnan(temp)
   set(hObject,'string','0'); waitfor(msgbox('Please enter a real number.','Figuretool2'));
else camparam.cp(3)=temp;
end
prevupdate();

% --- Executes during object creation, after setting all properties.
function z_cp_setcam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_cp_setcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end

function prevupdate()
global camparam;
axes(findobj('tag','prev_setcam'));
lightobj=findobj('tag','light_prev_setcam');
if numel(camparam.cv)==2 [xx,yy,zz]=sph2cart(camparam.cv(1)/180*pi,camparam.cv(2)/180*pi,1); tempcv=[xx,yy,zz]; else tempcv=camparam.cv; end
if isnumeric(camparam.cp)&&isnumeric(camparam.ct)
   if isequal(camparam.cp,camparam.ct) waitfor(msgbox('Camera position and camera target cannot be identical!','Figuretool2')); return;
   else tempcv=camparam.cp-camparam.ct;
   end
end
if numel(camparam.cu)==2 [xx,yy,zz]=sph2cart(camparam.cu(1)/180*pi,camparam.cu(2)/180*pi,1); tempcu=[xx,yy,zz]; else tempcu=camparam.cu; end
if abs(cross(tempcv,tempcu))<1E-6 waitfor(msgbox('Viewing direction and up direction cannot be collinear!','Figuretool2')); return; end
camproj(camparam.pt);
if strcmpi(camparam.lt,'parallel') set(lightobj,'style','infinite');
else set(lightobj,'style','local');
end
view(tempcv);camup(tempcu);
if isnumeric(camparam.cr) camroll(camparam.cr); end
if numel(camparam.ld)==2 [xx,yy,zz]=sph2cart(camparam.ld(1)/180*pi,camparam.ld(2)/180*pi,1); templd=[xx,yy,zz]; else templd=camparam.ld; end
if strcmpi(camparam.lc,'absolute') set(lightobj,'position',templd);
else
   bnorm=tempcv/norm(tempcv); aup=tempcu-dot(tempcu,bnorm)*bnorm; aup=aup/norm(aup); cline=cross(aup,bnorm);
   set(lightobj,'position',templd*[bnorm;cline;aup]);
end


% --- Executes when selected object is changed in cv_setcam.
function cv_setcam_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in cv_setcam
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global camparam;
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_cv_setcam')
   set(handles.x_cv_setcam,'enable','on');
   set(handles.y_cv_setcam,'enable','on');
   set(handles.z_cv_setcam,'enable','on');
   set(handles.az_cv_setcam,'enable','off');
   set(handles.el_cv_setcam,'enable','off');
   camparam.cv=[str2double(get(handles.x_cv_setcam,'string')),str2double(get(handles.y_cv_setcam,'string')),str2double(get(handles.z_cv_setcam,'string'))];
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_cv_setcam')
   set(handles.x_cv_setcam,'enable','off');
   set(handles.y_cv_setcam,'enable','off');
   set(handles.z_cv_setcam,'enable','off');
   set(handles.az_cv_setcam,'enable','on');
   set(handles.el_cv_setcam,'enable','on');
   camparam.cv=[str2double(get(handles.az_cv_setcam,'string')),str2double(get(handles.el_cv_setcam,'string'))];
end
prevupdate();

% --- Executes when selected object is changed in cu_setcam.
function cu_setcam_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in cu_setcam
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global camparam;
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_cu_setcam')
   set(handles.x_cu_setcam,'enable','on');
   set(handles.y_cu_setcam,'enable','on');
   set(handles.z_cu_setcam,'enable','on');
   set(handles.az_cu_setcam,'enable','off');
   set(handles.el_cu_setcam,'enable','off');
   camparam.cu=[str2double(get(handles.x_cu_setcam,'string')),str2double(get(handles.y_cu_setcam,'string')),str2double(get(handles.z_cu_setcam,'string'))];
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_cu_setcam')
   set(handles.x_cu_setcam,'enable','off');
   set(handles.y_cu_setcam,'enable','off');
   set(handles.z_cu_setcam,'enable','off');
   set(handles.az_cu_setcam,'enable','on');
   set(handles.el_cu_setcam,'enable','on');
   camparam.cu=[str2double(get(handles.az_cu_setcam,'string')),str2double(get(handles.el_cu_setcam,'string'))];
end
prevupdate();

% --- Executes when selected object is changed in ld_setcam.
function ld_setcam_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in ld_setcam
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global camparam;
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_ld_setcam')
   set(handles.x_ld_setcam,'enable','on');
   set(handles.y_ld_setcam,'enable','on');
   set(handles.z_ld_setcam,'enable','on');
   set(handles.az_ld_setcam,'enable','off');
   set(handles.el_ld_setcam,'enable','off');
   camparam.ld=[str2double(get(handles.x_ld_setcam,'string')),str2double(get(handles.y_ld_setcam,'string')),str2double(get(handles.z_ld_setcam,'string'))];
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_ld_setcam')
   set(handles.x_ld_setcam,'enable','off');
   set(handles.y_ld_setcam,'enable','off');
   set(handles.z_ld_setcam,'enable','off');
   set(handles.az_ld_setcam,'enable','on');
   set(handles.el_ld_setcam,'enable','on');
   camparam.ld=[str2double(get(handles.az_ld_setcam,'string')),str2double(get(handles.el_ld_setcam,'string'))];
end
prevupdate();

% --- Executes when selected object is changed in cp_setcam.
function cp_setcam_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in cp_setcam
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global camparam;
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_cp_setcam')
   set(handles.x_cp_setcam,'enable','off');
   set(handles.y_cp_setcam,'enable','off');
   set(handles.z_cp_setcam,'enable','off');
   camparam.cp='default';
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_cp_setcam')
   set(handles.x_cp_setcam,'enable','on');
   set(handles.y_cp_setcam,'enable','on');
   set(handles.z_cp_setcam,'enable','on');
   camparam.cp=[str2double(get(handles.x_cp_setcam,'string')),str2double(get(handles.y_cp_setcam,'string')),str2double(get(handles.z_cp_setcam,'string'))];
end


% --- Executes when selected object is changed in ct_setcam.
function ct_setcam_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in ct_setcam
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global camparam;
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_ct_setcam')
   set(handles.x_ct_setcam,'enable','off');
   set(handles.y_ct_setcam,'enable','off');
   set(handles.z_ct_setcam,'enable','off');
   camparam.ct='default';
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_ct_setcam')
   set(handles.x_ct_setcam,'enable','on');
   set(handles.y_ct_setcam,'enable','on');
   set(handles.z_ct_setcam,'enable','on');
   camparam.ct=[str2double(get(handles.x_ct_setcam,'string')),str2double(get(handles.y_ct_setcam,'string')),str2double(get(handles.z_ct_setcam,'string'))];
end


% --- Executes when selected object is changed in pt_setcam.
function pt_setcam_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in pt_setcam
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global camparam;
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_pt_setcam')
   camparam.pt='orthographic';
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_pt_setcam')
   camparam.ct='perspective';
end
prevupdate();


% --- Executes when selected object is changed in lt_setcam.
function lt_setcam_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in lt_setcam
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global camparam;
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_lt_setcam')
   camparam.lt='parallel';
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_lt_setcam')
   camparam.lt='divergent';
end
prevupdate();


% --- Executes when selected object is changed in lc_setcam.
function lc_setcam_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in lc_setcam
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global camparam;
if strcmpi(get(eventdata.NewValue,'tag'),'rb1_lc_setcam')
   camparam.lc='relative';
elseif strcmpi(get(eventdata.NewValue,'tag'),'rb2_lc_setcam')
   camparam.lc='absolute';
end
prevupdate();
