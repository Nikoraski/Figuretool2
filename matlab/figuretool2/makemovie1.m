function makemovie()       %#ok<*SEPEX,*DEFNU>

global frame paramlist arglist camparam0 lighthdl;

%%%---Movie parameters---%%%

moviename='movie1';                         %Name of the movie. The frames will be named 'moviename_frame01.png', etc.
figuretoolname='figuretool';                %Name of the figuretool code to be used.
nframes=10;                                 %Number of frames in the movie.
startframe=1;                               %Number of the first frame.
res=300;                                    %Resolution of the png figures.
camredraw=true;                             %Specifies whether to redraw the figure if only the camera settings are changed. If set to 'false', the figure
                                            %from the previous frame will be modified accordingly, then saved as the new frame.
autoexit=false;                             %Exit MATLAB after rendering is complete.

%%%---End of movie parameters---%%%

paramlist0={'camparam',{},'lightsource',[0,0,0]};arglist0={};framename0='';fighdl=str2func(figuretoolname);fprintf('Initializing figure parameters...');
paramlist=fighdl({'setdefault','res',0,'makemovie',-1});fprintf('   Done.\n');
temp=getarg('defaultcolor');[~,ind0]=sort(temp(:,1));setarg('defaultcolor',temp(ind0,:));
camparam0={'PT',camproj,'CP',campos,'CT',camtarget,'CV',(campos-camtarget)/norm(campos-camtarget),'CU',getarg('updirection'),'CR',0,'CVA',camva,'CZ',1};   
[atomlist,x,y,z]=textread(getarg('template'),'%s %f %f %f'); temp=strcmp('&',atomlist);
if sum(temp)==3 unitcell=[x(temp),y(temp),z(temp)]; setarg('unitcell',unitcell);
elseif sum(temp)==4 unitcell=[x(temp),y(temp),z(temp)]; unitcell=unitcell(1:3,:)-repmat(unitcell(4,:),3,1); setarg('unitcell',unitcell); end
if numel(camredraw)==1 camredraw=repmat(camredraw,1,nframes); end
setarg('atomlist',atomlist);setarg('x',x);setarg('y',y);setarg('z',z);
numspc=numel(num2str(nframes+startframe-1));

for frame0=startframe:startframe+nframes-1
    frame=frame0-startframe+1;
    disp(['Rendering frame ',num2str(frame0),' of ',num2str(startframe+nframes-1),'...']);
    arglist={};
    
%%%---Movie functions---%%%
    

    
%Most movie functions start with two parameters: frame range and move style. Frame range ([start,end]) is the range span (in frames) of the movement.
%Move style can be either 'to' or 'by', which determines whether the third parameter is interpreted as the final state or the difference between
%initial and final.
%
%Available parameters:
%'AM'(accel. mode)[='linear']: specifies acceleration mode. Can be 'linear', 'smooth', 'accel' or 'decel'.
%'AF'(accel. frame)[=one half of frame range]: specifies duration (in frames) of acceleration and deceleration. Effective only under 'smooth' mode.
%'IS'(initial speed)[=0]: specifies initial speed of movement. Effective under 'smooth', 'accel' and 'decel' mode.
%'RA'(rotation axis)[=updirection], 'TP'(target point)[=camtarget]: specifies rotation axis for spinning.
%
%orbitcamera(frame range,'to'/'by',rotation angle (in degrees)/final direction,parampairs): spins the object around an axis.
%movecamera(frame range,'to'/'by',viewingposition,parampairs): moves the camera position while fixating camera target.
%movetarget(frame range,'to'/'by',viewingposition,parampairs): moves the camera target while fixating camera position.
%moveinspace(frame range,'to'/'by',viewingposition,parampairs): moves camera position and camera target simultaneously.
%zoomcamera(frame range,'to'/'by',zoomfactor,parampairs): changes the zoomfactor.
%rollcamera(frame range,'to'/'by',rotation angle (in degrees),parampairs): rolls the camera (changes updirection while fixating the viewing axis).
%moveatom(frame range,'to'/'by',template filename/atomic coordinates,parampairs): changes atomic coordinates.
%changecolor(frame range,'to'/'by',defaultcolor,parampairs): changes default colors of the elements.
%funcanimate(frame range,function name,parampairs): runs a figure drawing function with parameters changing over time (active only during the specified frame range.)
%To specify a changing parameter, add '*' or '#' after the parameter abbreviation.
%'*' means this parameter changes from an initial value to a final value, provided after the parameter name as {initial,final}.
%    Interpolation will be performed to determine its value during the frame range ('AM','AF' and 'IS' are supported).
%    Works only for numeric parameters (numbers, arrays and matrices), not for strings and cell arrays.
%'#' should be followed by a cell array containing the value of this paramter at different frames (of the form {value1,value2,...}). The number of values provided
%    should be equal to (or no less than) the number of frames in the frame range. Works for both numeric and other types of parameters.
%Example: funcanimate([1,5],'drawbond','Sc1 Sc2','Ir1','BA*',{0,1},'O#',{'on','on','on','off','off'},'AM','accel').

%%%---End of movie functions---%%%
    framename=[moviename,'_frame',repmat('0',1,numspc-numel(num2str(frame0))),num2str(frame0)];
    setcamarg('CV',(getcamarg('CP')-getcamarg('CT'))/norm(getcamarg('CP')-getcamarg('CT')));
    setarg('camparam',camparam0);
    if isequal(paramlist,paramlist0)&&isequal(arglist,arglist0)
        if ispc system(['copy ',framename0,'.png ',framename,'.png 1>NUL 2>NUL']);
        elseif isunix system(['cp ',framename0,'.png ',framename,'.png']);
        end
        disp('  No change in paramlist and arglist: copied figure from previous frame.');
    else
        [~,loc]=ismember('camparam',paramlist0(1:2:end));paramlist0{2*loc}=camparam0;
        [~,loc]=ismember('lightsource',paramlist0(1:2:end));paramlist0{2*loc}=getarg('lightsource');
        if (~camredraw(frame))&&isequal(paramlist,paramlist0)&&isequal(arglist,arglist0)
            disp('  camredraw turned off: change detected only in camera settings. Move camera without redraw.');
            campos(getcamarg('CP'));camtarget(getcamarg('CT'));camup(getcamarg('CU'));camva(getcamarg('CVA'));set(lighthdl,'Position',getarg('lightsource'));
            print(currfig,framename,'-dpng',['-r',num2str(res)]);
        else
            close;
            currfig=fighdl([{'setdefault','makemovie',1},paramlist],arglist{:});
            print(currfig,framename,'-dpng',['-r',num2str(res)]);
        end
    end
    framename0=framename;arglist0=arglist;paramlist0=paramlist;
end
close;
disp('Rendering complete.');
if (autoexit) exit; end

function setfuncdefault(cellin)
abbrlist={'AM','acmode';'AF','accframe';'IS','initspeed';'RA','rotationaxis';'TP','targetpoint'};
for k=1:2:numel(cellin)
    [~,loc]=ismember(cellin{k},abbrlist);
    if loc~=0 cellin{k}=abbrlist{rem(loc-1,size(abbrlist,1))+1,2}; assignin('caller',cellin{k},cellin{k+1}); end
end

function setarg(propertyname,propertyvalue)
global paramlist;
[~,loc]=ismember(propertyname,paramlist(1:2:end));
if loc~=0 paramlist{loc*2}=propertyvalue;
else paramlist(end+1:end+2)={propertyname,propertyvalue};
end

function propertyvalue=getarg(propertyname)
global paramlist;
[~,loc]=ismember(propertyname,paramlist(1:2:end));
if loc~=0 propertyvalue=paramlist{loc*2};
else error(['Attempt to get unassigned property value ''',propertyname,'''.']);
end

function setcamarg(propertyname,propertyvalue)
global camparam0;
[~,loc]=ismember(propertyname,camparam0(1:2:end));
if loc~=0 camparam0{loc*2}=propertyvalue;
else camparam0(end+1:end+2)={propertyname,propertyvalue};
end

function propertyvalue=getcamarg(propertyname)
global camparam0;
[~,loc]=ismember(propertyname,camparam0(1:2:end));
if loc~=0 propertyvalue=camparam0{loc*2};
else error(['Attempt to get unassigned property value ''',propertyname,'''.']);
end

function paramout=pinterp(frange,frame0,param,acmode,accframe,initspeed)
if strcmpi(acmode,'linear')
    accprofile=0:frange(2)-frange(1);
elseif strcmpi(acmode,'accel')
    accprofile=(0:frange(2)-frange(1)).^2+initspeed*(0:frange(2)-frange(1));
elseif strcmpi(acmode,'decel')
    accprofile=(frange(2)-frange(1))^2-(frange(2)-frange(1):-1:0).^2+initspeed*(0:frange(2)-frange(1));
elseif strcmpi(acmode,'smooth')
    if accframe*2>frange(2)-frange(1) error('Unacceptable acceleration frame range!'); end
    csframe=frange(2)-frange(1)-accframe*2;
    accprofile=[(0:accframe-1).^2,accframe^2:accframe*2:accframe^2+csframe*accframe*2,2*accframe^2+2*csframe*accframe-(accframe-1:-1:0).^2]+initspeed*(0:frange(2)-frange(1));
else error(['Unrecognized acceleration mode''',acmode,'''!']);
end
paramout=(param{2}*accprofile(frame0)+param{1}*(accprofile(end)-accprofile(frame0)))/accprofile(end);

function orbitcamera(varargin) 
global frame;
persistent stinit;
frange=varargin{1};spec=varargin{2};if numel(frange)==1 frange=[frange,frange]; end
if frame==frange(1)
    acmode='linear';accframe=floor((frange(2)-frange(1))/2);initspeed=0;rotationaxis=getcamarg('CU');targetpoint=getcamarg('CT');pstart=getcamarg('CP');lstart=getarg('lightsource');
    setfuncdefault(varargin(4:end));
    if ischar(rotationaxis)&&strcmpi(rotationaxis,'cross')&&strcmpi(spec,'to')
       rotationaxis=cross(getcamarg('CV'),varargin{3});
    end
    aup=rotationaxis/norm(rotationaxis);
    drot0=[pstart-targetpoint;lstart];
    drotp=(drot0*aup')*aup;
    droto=drot0-drotp;
    drotx=cross([aup;aup],droto);
    if strcmpi(spec,'by') rdegree=varargin{3}/180*pi;
    elseif strcmpi(spec,'to')
        dest=varargin{3}-targetpoint; desto=dest-(dest*aup')*aup;desto=desto/norm(desto);
        stavo=(pstart-targetpoint)-((pstart-targetpoint)*aup')*aup;stavo=stavo/norm(stavo);
        rdegree=atan2(norm(cross(stavo,desto)),dot(stavo,desto));
    end
    plist=zeros(frange(2)-frange(1)+1,3); llist=zeros(frange(2)-frange(1)+1,3);
    for i=1:frange(2)-frange(1)+1
        xdeg=pinterp(frange,i,{0,rdegree},acmode,accframe,initspeed);
        drot=drotp+droto*cos(xdeg)+drotx*sin(xdeg);
        plist(i,:)=drot(1,:)+targetpoint;llist(i,:)=drot(2,:);
    end
    stinit={plist,llist}; return;
end
if (frame<frange(1)+1)||(frame>frange(2)) return; end
setcamarg('CP',stinit{1}(frame-frange(1)+1,:));setarg('lightsource',stinit{2}(frame-frange(1)+1,:));

function movecamera(varargin)
global frame;
persistent stinit;
frange=varargin{1};spec=varargin{2};if numel(frange)==1 frange=[frange,frange]; end
if frame==frange(1)
    acmode='linear';accframe=floor((frange(2)-frange(1))/2);initspeed=0;setfuncdefault(varargin(4:end));
    CPstart=getcamarg('CP'); 
    if strcmpi(spec,'by') CPend=CPstart+varargin{3};
    elseif strcmpi(spec,'to') CPend=varargin{3};
    end
    stinit=zeros(frange(2)-frange(1)+1,3);
    for i=1:frange(2)-frange(1)+1
        stinit(i,:)=pinterp(frange,i,{CPstart,CPend},acmode,accframe,initspeed);
    end
    return;
end
if (frame<frange(1)+1)||(frame>frange(2)) return; end
setcamarg('CP',stinit(frame-frange(1)+1,:));

function movetarget(varargin)
global frame;
persistent stinit;
frange=varargin{1};spec=varargin{2};if numel(frange)==1 frange=[frange,frange]; end
if frame==frange(1)
    acmode='linear';accframe=floor((frange(2)-frange(1))/2);initspeed=0;setfuncdefault(varargin(4:end));
    CTstart=getcamarg('CT'); 
    if strcmpi(spec,'by') CTend=CTstart+varargin{3};
    elseif strcmpi(spec,'to') CTend=varargin{3};
    end
    stinit=zeros(frange(2)-frange(1)+1,3);
    for i=1:frange(2)-frange(1)+1
        stinit(i,:)=pinterp(frange,i,{CTstart,CTend},acmode,accframe,initspeed);
    end
    return;
end
if (frame<frange(1)+1)||(frame>frange(2)) return; end
setcamarg('CT',stinit(frame-frange(1)+1,:));

function moveinspace(varargin)
global frame;
persistent stinit;
frange=varargin{1};spec=varargin{2};if numel(frange)==1 frange=[frange,frange]; end
if frame==frange(1)
    acmode='linear';accframe=floor((frange(2)-frange(1))/2);initspeed=0;setfuncdefault(varargin(4:end));
    CTstart=getcamarg('CT'); CPstart=getcamarg('CP');
    if strcmpi(spec,'by') CTend=CTstart+varargin{3}; CPend=CPstart+varargin{3};
    elseif strcmpi(spec,'to') CTend=CTstart-CPstart+varargin{3}; CPend=varargin{3};
    end
    plist=zeros(frange(2)-frange(1)+1,3); tlist=zeros(frange(2)-frange(1)+1,3);
    for i=1:frange(2)-frange(1)+1
        plist(i,:)=pinterp(frange,i,{CPstart,CPend},acmode,accframe,initspeed);
        tlist(i,:)=pinterp(frange,i,{CTstart,CTend},acmode,accframe,initspeed);
    end
    stinit={plist,tlist}; return;
end
if (frame<frange(1)+1)||(frame>frange(2)) return; end
setcamarg('CP',stinit{1}(frame-frange(1)+1,:));setcamarg('CT',stinit{2}(frame-frange(1)+1,:));

function zoomcamera(varargin)
global frame;
persistent stinit;
frange=varargin{1};spec=varargin{2};if numel(frange)==1 frange=[frange,frange]; end
if frame==frange(1) 
    acmode='linear';accframe=floor((frange(2)-frange(1))/2);initspeed=0;setfuncdefault(varargin(4:end));
    CVAstart=getcamarg('CVA'); CZstart=1;
    if strcmpi(spec,'by') CZend=CZstart+varargin{3}; elseif strcmpi(spec,'to') CZend=varargin{3}; end
    stinit=zeros(frange(2)-frange(1)+1,1);
    for i=1:frange(2)-frange(1)+1
        zoomfactor=pinterp(frange,i,{CZstart,CZend},acmode,accframe,initspeed);
        stinit(i)=acotd(cotd(CVAstart/2)*zoomfactor)*2;
    end
    return;
end
if (frame<frange(1)+1)||(frame>frange(2)) return; end
setcamarg('CVA',stinit(frame-frange(1)+1));

function rollcamera(varargin)
global frame;
persistent stinit;
frange=varargin{1};spec=varargin{2};if numel(frange)==1 frange=[frange,frange]; end
if frame==frange(1) 
    acmode='linear';accframe=floor((frange(2)-frange(1))/2);initspeed=0;setfuncdefault(varargin(4:end));
    CUstart=getcamarg('CU'); CRstart=0; CV=getcamarg('CP')-getcamarg('CT'); CV=CV/norm(CV); CW=cross(CV,CUstart);
    if strcmpi(spec,'by') CRend=varargin{3}/180*pi; 
    elseif strcmpi(spec,'to')
        desto=varargin{3}-dot(varargin{3},CV)*CV; desto=desto/norm(desto); stavo=CUstart/norm(CUstart);
        CRend=atan2(norm(cross(stavo,desto)),dot(stavo,desto));
    end
    stinit=zeros(frange(2)-frange(1)+1,3);
    for i=1:frange(2)-frange(1)+1
        CRnew=pinterp(frange,i,{CRstart,CRend},acmode,accframe,initspeed);
        stinit(i,:)=CUstart*cos(CRnew)+CW*sin(CRnew);
    end
    return;
end
if (frame<frange(1)+1)||(frame>frange(2)) return; end
setcamarg('CU',stinit(frame-frange(1)+1,:));

function moveatom(varargin)
global frame;
persistent stinit;
frange=varargin{1};spec=varargin{2};if numel(frange)==1 frange=[frange,frange]; end
if frame==frange(1)
    acmode='linear';accframe=floor((frange(2)-frange(1))/2);initspeed=0;setfuncdefault(varargin(4:end));
    xyzstart=[getarg('x'),getarg('y'),getarg('z')]; ntotal=size(xyzstart,1);
    cellstart=xyzstart(strcmp('&',getarg('atomlist')),:);
    xyzstart=xyzstart(~strcmp('&',getarg('atomlist')),:);
    inmatrix=varargin{3}; 
    if ischar(inmatrix) [~,x0,y0,z0]=textread(inmatrix,'%s %f %f %f'); inmatrix=[x0,y0,z0]; inmatrix=inmatrix(~strcmp('&',getarg('atomlist')),:);
    elseif size(inmatrix,1)==1 inmatrix=repmat(inmatrix,size(xyzstart,1),1);
    end
    if strcmpi(spec,'by') xyzend=xyzstart+inmatrix; elseif strcmpi(spec,'to') xyzend=inmatrix; end
    xlist=zeros(ntotal,frange(2)-frange(1)+1); ylist=zeros(ntotal,frange(2)-frange(1)+1); zlist=zeros(ntotal,frange(2)-frange(1)+1);
    temp=zeros(ntotal,3);
    for i=1:frange(2)-frange(1)+1
        temp(strcmp('&',getarg('atomlist')),:)=cellstart;
        temp(~strcmp('&',getarg('atomlist')),:)=pinterp(frange,i,{xyzstart,xyzend},acmode,accframe,initspeed);
        xlist(:,i)=temp(:,1);
        ylist(:,i)=temp(:,2);
        zlist(:,i)=temp(:,3);
    end
    stinit={xlist,ylist,zlist};
end
if (frame<frange(1)+1)||(frame>frange(2)) return; end
setarg('x',stinit{1}(:,frame-frange(1)+1));setarg('y',stinit{2}(:,frame-frange(1)+1));setarg('z',stinit{3}(:,frame-frange(1)+1));

function changecolor(varargin)
global frame;
persistent stinit;
frange=varargin{1};spec=varargin{2};if numel(frange)==1 frange=[frange,frange]; end
if frame==frange(1)
    acmode='linear';accframe=floor((frange(2)-frange(1))/2);initspeed=0;setfuncdefault(varargin(4:end));
    DCstart=getarg('defaultcolor');
    temp=varargin{3};[~,ind0]=sort(temp(:,1));DCend=temp(ind0,:);
    if strcmpi(spec,'by') for i=1:size(DCend,1), DCend{i,2}=DCstart{i,2}+DCend{i,2}; end
    end
    stinit=cell(1,frange(2)-frange(1)+1);
    for j=1:frange(2)-frange(1)+1
        DCnew=DCend;
        for i=1:size(DCnew,1)
            DCnew{i,2}=pinterp(frange,j,{DCstart{i,2},DCend{i,2}},acmode,accframe,initspeed);
        end
        stinit{j}=DCnew;
    end
end
if (frame<frange(1)+1)||(frame>frange(2)) return; end
setarg('defaultcolor',stinit{frame-frange(1)+1});

function funcanimate(varargin)
global frame arglist;
frange=varargin{1};if numel(frange)==1 frange=[frange,frange]; end
if (frame<frange(1))||(frame>frange(2)) return; end
funcarg=varargin(2:end);acmode='linear';accframe=floor((frange(2)-frange(1))/2);initspeed=0;
setfuncdefault(funcarg(3+(mod(numel(funcarg)-1,2)==0):end));
kstart=3+(mod(numel(funcarg)-1,2)==0);
if (kstart==4)&&ischar(funcarg{2})&&ismember(funcarg{2}(end),{'*','#'}) kstart=2; end
for k=kstart:2:numel(funcarg)
    if ischar(funcarg{k})&&(funcarg{k}(end)=='*')
        funcarg{k}=funcarg{k}(1:end-1);
        funcarg{k+1}=pinterp(frange,frame-frange(1)+1,{funcarg{k+1}{1},funcarg{k+1}{2}},acmode,accframe,initspeed);
    elseif ischar(funcarg{k})&&(funcarg{k}(end)=='#')
        funcarg{k}=funcarg{k}(1:end-1);
        funcarg{k+1}=funcarg{k+1}{frame-frange(1)+1};
    end
end
funcarg(cellfun(@isempty,funcarg))=[];
arglist{end+1}=funcarg;

%%%---Auxiliary functions---%%%

function dist=atomdist(i,j)
x=getarg('x');y=getarg('y');z=getarg('z');
dist=norm([x(i)-x(j),y(i)-y(j),z(i)-z(j)]);

function dist=d2plane(ir,points)
x=getarg('x');y=getarg('y');z=getarg('z');
p0=[x(ir),y(ir),z(ir)];
p1=points(1,:);
p2=points(2,:);
p3=points(3,:);
dist=abs(det([p1-p0;p2-p0;p3-p0])/norm(cross(p3-p1,p2-p1)));

function elementname=getelem(instring)
atomlist=getarg('atomlist');
if ischar(instring)
    temp=[regexpi(instring,'[a-z][0-9]'),numel(instring)];
    elementname=instring(1:temp(1));
elseif iscell(instring)
    elementname=cell(1,numel(instring));
    for i=1:numel(instring)
        temp=[regexpi(instring{i},'[a-z][0-9]'),numel(instring)];
        elementname{i}=instring{i}(1:temp(1));
    end
elseif numel(instring)>1
    elementname=cell(1,numel(instring));
    for i=1:numel(instring)
        temp=[regexpi(atomlist{instring(i)},'[a-z][0-9]'),numel(atomlist{instring(i)})];
        elementname{i}=atomlist{instring(i)}(1:temp(1));
    end
else
    temp=[regexpi(atomlist{instring},'[a-z][0-9]'),numel(instring)];
    elementname=atomlist{instring}(1:temp(1));
end

function rngout=getrange(instring,i,j,num)
connmap=getarg('connmap');
if ~ischar(instring)
    if numel(instring)==2
        rngout=instring;
    else
        rngout=[0 instring];
    end
else
    if strcmpi(instring,'default')
        rngout=0;
        elem1=getelem(i);
        elem2=getelem(j);
        for k=1:size(connmap,1)
            if (strcmpi(connmap{k,1},elem1)&&strcmpi(connmap{k,2},elem2))||(strcmpi(connmap{k,1},elem2)&&strcmpi(connmap{k,2},elem1))
                rngout=[connmap{k,3} connmap{k,4}];
                break;
            end
        end
        if rngout==0 rngout=[2,4]; end
    end
end
if nargin==4
    rngout=rngout(num);
end

function sitelist=siteselect(instring)
atomlist=getarg('atomlist');
if ~ischar(instring)
    sitelist=instring;
else
    strarray0=regexp(instring,'&','split');
    if numel(strarray0)>1
        sitelist=1:numel(atomlist);
        for k=1:numel(strarray0)
            sitelist=intersect(sitelist,siteselect(strarray0{k}));
        end
        return;
    else
        strarray=regexp(instring,' ','split');
        sitematrix={[],[]};
        flagcount=[0,0];
        siteall=1:numel(atomlist);
        for jj=strarray
            if isempty(jj{1}) continue;
            elseif ~strcmpi(jj{1}(1),'-')
                j=jj{1};
                flag=1;
            else
                j=jj{1}(2:end);
                flag=2;
            end
            flagcount(flag)=flagcount(flag)+1;
            if strcmpi(j,'all') sitematrix{flag}=[sitematrix{flag},siteall(~ismember(getelem(siteall),{'&','Dummy'}))];
            elseif all(ismember(j,'0123456789:,[]')) sitematrix{flag}=[sitematrix{flag},str2num(j)];
            elseif strcmpi(j,getelem(j)) sitematrix{flag}=[sitematrix{flag},siteall(strcmpi(j,getelem(siteall)))];
            else sitematrix{flag}=[sitematrix{flag},siteall(strcmpi(j,atomlist))];
            end
        end
        if (flagcount(1)==0)&&(flagcount(2)~=0) sitematrix{1}=siteall(~ismember(getelem(siteall),{'&','Dummy'})); end
        sitelist=setdiff(sitematrix{1},sitematrix{2});
    end
end

function rnglist=rngselect(rngtype,rngref,siteref)
x=getarg('x');y=getarg('y');z=getarg('z');unitcell=getarg('unitcell');
if nargin<3 siteref='all'; end
sitelist=siteselect(siteref);
rnglist=[];
if strcmpi(rngtype,'sphere')
    if numel(rngref{1})==1 center=[x(rngref{1}),y(rngref{1}),z(rngref{1})];
    else center=rngref{1}; end
    if strcmpi(rngref{2},'direct')&&numel(rngref{1})==3 center=center*unitcell; end
    for i=sitelist
        if norm([x(i)-center(1),y(i)-center(2),z(i)-center(3)])<rngref{3}
            rnglist=[rnglist,i];
        end
    end
elseif strcmpi(rngtype,'box')
    if numel(rngref{1})==1 center=[x(rngref{1}),y(rngref{1}),z(rngref{1})];
    else center=rngref{1}; end
    if strcmpi(rngref{2},'direct')&&numel(rngref{1})==3 center=center*unitcell; end
    if numel(rngref{3})==3 rng=rngref{3};
    else rng=[rngref{3},rngref{3},rngref{3}];
    end
    for i=sitelist
        if (abs(x(i)-center(1))<rng(1))&&(abs(y(i)-center(2))<rng(2))&&(abs(z(i)-center(3))<rng(3))
            rnglist=[rnglist,i];
        end
    end
elseif strcmpi(rngtype,'slab')
    if numel(rngref{1})==3 points=[x(rngref{1}),y(rngref{1}),z(rngref{1})];
    else points=rngref{1}; end
    if strcmpi(rngref{2},'direct')&&numel(rngref{1})==9 points=points*unitcell; end
    for i=sitelist
        if d2plane(i,points)<rngref{3}
            rnglist=[rnglist,i];
        end
    end
end

function coordset=coord(atomsetref,rangeref,instring)
if nargin<3
    instring='all';
    if nargin<2
        rangeref='default';
    end
end
coordset=[];
sitelist=siteselect(instring);
atomset=siteselect(atomsetref);
for ir=sitelist
    if all(arrayfun(@(jr) atomdist(ir,jr)>getrange(rangeref,ir,jr,1),atomset))&&any(arrayfun(@(jr) atomdist(ir,jr)<getrange(rangeref,ir,jr,2),atomset))
        coordset=[coordset ir];
    end
end

function mol=getmol(startref,instring,rangeref)
if nargin<3 rangeref='default'; end
mol=siteselect(startref);
mol0=[];
while(~isequal(mol,mol0))
    mol0=mol;
    mol=unique([mol,coord(mol,rangeref,instring)]);
end













