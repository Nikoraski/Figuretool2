function figuretool0(functionlist)
global camparam imgbound cellbound usedlist bondlist;
imgbound=[Inf,Inf,Inf,-Inf,-Inf,-Inf];
cellbound=[Inf,Inf,Inf,-Inf,-Inf,-Inf];
usedlist=[]; bondlist=[];
fcnnames=cellfun(@(x)x.function,functionlist,'UniformOutput',0);
if ~ismember('drawraMO',fcnnames)
   for j=1:numel(fcnnames)
      fcnhdl=str2func(fcnnames{j});
      fcnhdl(functionlist{j});
   end
   axis off; axis equal; set(gca,'CameraViewAngleMode','manual'); set(gcf,'color',[1 1 1]);
   setcamera(camparam);
else
   st0=functionlist{strcmpi('drawraMO',fcnnames)};
   for j=1:st0.nramo
      subplot(st0.sp(1),st0.sp(2),j);
      for k=1:numel(fcnnames)
         fcnhdl=str2func(fcnnames{k});
         if strcmpi(fcnnames{k},'drawraMO') fcnhdl(functionlist{k},j);
         else fcnhdl(functionlist{k});
         end
      end
      axis off; axis equal; set(gca,'CameraViewAngleMode','manual'); set(gcf,'color',[1 1 1]);
      if j==1
         setcamera(camparam);
         camparamuse=struct('cp',campos,'ct',camtarget,'cu',camup,'cva',camva,'cr','default','cv',campos-camtarget,...
            'pt',camparam.pt,'cz',1.0,'lc',camparam.lc,'ld',camparam.ld,'lt',camparam.lt);
      else
         setcamera(camparamuse);
      end
   end
end

function setcamera(camparamin)
global viewcoord lighthdl;
camproj(camparamin.pt);
t1=isnumeric(camparamin.cp);t2=isnumeric(camparamin.ct);
if (~t1)&&(~t2) view(camparamin.cv);
elseif (~t1)&&(t2) view(camparamin.cv); campos(campos-camtarget+camparamin.ct);camtarget(camparamin.ct);
elseif (t1)&&(~t2) view(camparamin.cv); camtarget(camtarget-campos+camparamin.cp);campos(camparamin.cp);
else camtarget(camparamin.ct);campos(camparamin.cp);
end
camup(camparamin.cu); if isnumeric(camparamin.cr) camroll(camparamin.cr); end
if isnumeric(camparamin.cva) camva(camparamin.cva); end
camzoom(camparamin.cz);
if strcmpi(camparamin.lc,'relative') lightpos=camparamin.ld*[viewcoord(2,:);viewcoord(3,:);viewcoord(1,:)];
else lightpos=camparamin.ld;
end
lighthdl0=light('position',lightpos);
if strcmpi(camparamin.lt,'parallel') set(lighthdl0,'style','infinite');
elseif strcmpi(camparamin.lt,'divergent') set(lighthdl0,'style','local');
end
lighthdl=[lighthdl,lighthdl0];

function infostring=atominfo(i)
global atomlist xyzcart;
infostring=['atom ',num2str(i),': ',atomlist{i},' (',num2str(xyzcart(i,1)),',',num2str(xyzcart(i,2)),',',num2str(xyzcart(i,3)),')'];

function atomupdate(sitelist)
global xyzcart usedlist;
usedlist=unique([usedlist,sitelist]);
boundupdatex(xyzcart(sitelist,:));

function boundupdatex(points)
global viewcoord imgbound cellbound unitcell;
if isempty(points) return; end
if isequal(size(unitcell),[3,3])&&(det(unitcell)>1E-6)
pointsu=points/unitcell;
cellbound(1:3)=min([cellbound(1:3);pointsu],[],1);
cellbound(4:6)=max([cellbound(4:6);pointsu],[],1);
end
pointsc=points/viewcoord;
imgbound(1:3)=min([imgbound(1:3);pointsc],[],1);
imgbound(4:6)=max([imgbound(4:6);pointsc],[],1);

function angout=dihedral(i,j,k,l)
global xyzcart;
norm1=cross(xyzcart(j,:)-xyzcart(i,:),xyzcart(k,:)-xyzcart(j,:));
norm2=cross(xyzcart(i,:)-xyzcart(j,:),xyzcart(l,:)-xyzcart(i,:));
angout=acos(dot(norm1,norm2)/(norm(norm1)*norm(norm2)));

function lpout=getlightparam(lpin,defaultparam)
global globallp;
if ~strcmpi(globallp,'default')&&strcmpi(lpin,'default') lpin=globallp; end
if ~ischar(lpin) lpout=lpin;
else
   switch lpin
      case 'chalk', lpout=[0.25,0.75,0,1];
      case 'china', lpout=[0.25,0.75,1,30];
      case 'glass', lpout=[0.5,0,1,20];
      case 'metal', lpout=[0.5,0.1,0.9,1];
      case 'plastic', lpout=[0.75,0.75,1,9];
      case 'rubber', lpout=[0.75,0.75,0,1];
      case 'wax', lpout=[0.2,1,0.5,10];
      case 'default', lpout=defaultparam;
   end
end

function outcolor=atomcolorlookup(instring,ir)
global defaultcolor CPKcolor elemlist elemnolist atomlist;
if isnumeric(instring) outcolor=repmat(instring,numel(ir),1); return;
elseif strcmpi(instring,'cpk') outcolor=cell2mat(CPKcolor(elemnolist(ir)+2)')/255; return;
else
   outcolor=zeros(numel(ir),3);
   for j=1:numel(ir)
      if isfield(defaultcolor,atomlist{ir(j)})&&~ischar(defaultcolor.(atomlist{ir(j)})) outcolor(j,:)=defaultcolor.(atomlist{ir(j)});
      elseif isfield(defaultcolor,elemlist{ir(j)})&&~ischar(defaultcolor.(elemlist{ir(j)})) outcolor(j,:)=defaultcolor.(elemlist{ir(j)});
      else outcolor(j,:)=CPKcolor{elemnolist(ir(j))+2};
      end
   end
   outcolor=outcolor/255;
   if strcmpi(instring,'light') outcolor=0.5+0.5*outcolor;
   elseif strcmpi(instring,'verylight') outcolor=0.75+0.25*outcolor;
   elseif strcmpi(instring,'dark') outcolor=0.5*outcolor;
   elseif strcmpi(instring,'verydark') outcolor=0.25*outcolor;
   elseif strcmpi(instring,'inverse') outcolor=1-outcolor;
   end
end   


function outcolor=bondcolorlookup(instring,i,j)
if ~ischar(instring)
   outcolor=instring;
else
   if ismember(instring,{'default','light','dark','verylight','verydark','inverse'}) outcolor=[atomcolorlookup(instring,i),atomcolorlookup(instring,j)];
   end
end

function radout=atomradiuslookup(instring,i)
global elemname elemlist metalrad atomrad vdwrad;
radout=zeros(1,numel(i));
if ~ischar(instring) radout=radout+instring;
else
   strarray=regexp(instring,' ','split');
   if size(strarray,2)==2 nscale=str2double(strarray{2}); else nscale=1; end
   for k=1:numel(i)
      [~,loc]=ismember(elemlist(i(k)),elemname);
      if loc==0 radout(k)=0.5;
      elseif strcmpi(strarray{1},'metallic') radout(k)=nscale*metalrad(loc);
      elseif strcmpi(strarray{1},'atomic') radout(k)=nscale*atomrad(loc);
      elseif strcmpi(strarray{1},'vdw') radout(k)=nscale*vdwrad(loc);
      end
   end
end

function coordset=coord(atomset,rangeref,instring)
global atomdist;
if nargin<3 instring='all'; end
if nargin<2 rangeref='default'; end
[~,reflist,~]=siterefparser(instring);
[sitelist,~]=sitetrans(reflist);
rangematrix=getrange(sitelist,atomset,rangeref);
coordset=sitelist(all(atomdist(sitelist,atomset)>rangematrix(:,:,1),2)&any(atomdist(sitelist,atomset)<rangematrix(:,:,2),2));

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

function drawatom(st)
global xyzcart viewcoord objlist res;
[~,reflist,~]=siterefparser(st.site);
[sitelist,~]=sitetrans(reflist);
atomupdate(sitelist);
if ~iscell(st.ac) atomcoloruse=atomcolorlookup(st.ac,sitelist); end
OLcoloruse=atomcolorlookup(st.oc,sitelist);
radiususe=atomradiuslookup(st.r,sitelist);
if isnumeric(st.res) resuse=st.res; else resuse=res; end
lp=getlightparam(st.lp,[0.6,0.6,0.9,10]);
for j=1:numel(sitelist)
   jr=sitelist(j);
   res0=4*round(4+(0.5+radiususe(j))*resuse);
   [Xnew,Ynew,Znew]=sphere(res0);
   if iscell(st.ac) temp=[Xnew(:),Ynew(:),Znew(:)]*[-viewcoord(1,:);-viewcoord(3,:);viewcoord(2,:)]*radiususe(j);
   else temp=[Xnew(:),Ynew(:),Znew(:)]*radiususe(j);
   end
   Xnew=reshape(temp(:,1),res0+1,res0+1)+xyzcart(jr,1);Ynew=reshape(temp(:,2),res0+1,res0+1)+xyzcart(jr,2);Znew=reshape(temp(:,3),res0+1,res0+1)+xyzcart(jr,3);
   if iscell(st.ac)
      cmHr=ones(size(Xnew,1),size(Xnew,2));cmHg=ones(size(Xnew,1),size(Xnew,2));cmHb=ones(size(Xnew,1),size(Xnew,2));rcount=0;
      for k=1:size(st.ac,1)
         tempcolor=atomcolorlookup('default',st.ac{k,1});tempsum=floor(sum(cell2mat(st.ac(1:k,2)))*(res0+1));
         cmHr(:,rcount+1:tempsum)=tempcolor(1);cmHg(:,rcount+1:tempsum)=tempcolor(2);cmHb(:,rcount+1:tempsum)=tempcolor(3);rcount=tempsum;
      end
      hdltemp=surf(Xnew,Ynew,Znew,'AmbientStrength',lp(1),'DiffuseStrength',lp(2),'SpecularStrength',lp(3),'SpecularExponent',lp(4),...
         'FaceAlpha',st.aa,'EdgeColor','none','CData',cat(3,cmHr,cmHg,cmHb),'FaceLighting',st.fl,'Clipping','off','DisplayName',atominfo(jr));
   else
      hdltemp=surf(Xnew,Ynew,Znew,'AmbientStrength',lp(1),'DiffuseStrength',lp(2),'SpecularStrength',lp(3),'SpecularExponent',lp(4),...
         'FaceAlpha',st.aa,'EdgeColor','none','FaceColor',atomcoloruse(j,:),'FaceLighting',st.fl,'Clipping','off','DisplayName',atominfo(jr));
   end
   objlist(end+1,1:3)={hdltemp,'atom',jr};
   if ~strcmpi(st.o,'off')
      theta=0:2*pi/(32+4*resuse):2*pi;
      seg=max(round(st.ow/(2*pi/(32+4*resuse)*radiususe(j))),1);
      peri0=bsxfun(@plus,xyzcart(jr,:)',(viewcoord(1,:)'*cos(theta)+viewcoord(3,:)'*sin(theta))*(radiususe(j)*0.99));
      peri1=[peri0(:,2:size(theta,2)),peri0(:,2)];
      peri3=bsxfun(@plus,xyzcart(jr,:)',(viewcoord(1,:)'*cos(theta)+viewcoord(3,:)'*sin(theta))*(radiususe(j)+st.ow));
      peri2=[peri3(:,2:size(theta,2)),peri3(:,2)];
      cylX=[peri0(1,:);peri1(1,:);peri2(1,:);peri3(1,:)];
      cylY=[peri0(2,:);peri1(2,:);peri2(2,:);peri3(2,:)];
      cylZ=[peri0(3,:);peri1(3,:);peri2(3,:);peri3(3,:)];
      if ~strcmpi(st.o,'dashed')
         patch(cylX,cylY,cylZ,OLcoloruse(j,:),'Facelighting','none','LineStyle','none');
      else
         alH=rem(floor((1:size(peri0,2))/seg),sum(st.dl))>=st.dl(2);
         patch(cylX(:,alH),cylY(:,alH),cylZ(:,alH),OLcoloruse(j,:),'Facelighting','none','LineStyle','none');
      end
   end
end

function drawbond(st)
global atomdist xyzcart viewcoord res bondlist objlist;
lp=getlightparam(st.lp,[0.4,0.6,0.9,10]);
if isnumeric(st.res) resuse=st.res; else resuse=res; end
[~,reflist1,~]=siterefparser(st.site1);
[sitelist1,~]=sitetrans(reflist1);
if isempty(st.site2) sitelist2=sitelist1;
else
   [~,reflist2,~]=siterefparser(st.site2);
   [sitelist2,~]=sitetrans(reflist2);
end
rangematrix=getrange(sitelist1,sitelist2,st.rn);
bfmatrix=(atomdist(sitelist1,sitelist2)>=rangematrix(:,:,1))&(atomdist(sitelist1,sitelist2)<=rangematrix(:,:,2));
atomset=union(sitelist1(any(bfmatrix,2)),sitelist2(any(bfmatrix,1)));
for i=1:numel(sitelist1)
   ir=sitelist1(i);
   for j=1:numel(sitelist2)
      jr=sitelist2(j);
      if ~bfmatrix(i,j)||ir==jr||(ismember(ir,sitelist2)&&ismember(jr,sitelist1)&&(ir>jr)) continue; end
      if strcmpi(st.bt,'dashed')&&ischar(st.bc) bondcoloruse=[0,0,0,1,1,1];
      else bondcoloruse=bondcolorlookup(st.bc,ir,jr);
      end
      bondlength=atomdist(ir,jr);
      bondnorm=(xyzcart(jr,:)-xyzcart(ir,:))/bondlength;
      viewingangle=acosd(dot(bondnorm,viewcoord(2,:))); cwedge=(1-abs(viewingangle-90)/90)^2;
      if strcmpi(st.bt,'dashed')
         bondlength=atomdist(ir,jr);
         if strcmpi(st.w,'on')
            if viewingangle>=90
               [cylX,cylY,cylZ]=cylinder(st.bw/2*linspace(1,cwedge,round(bondlength/st.bw)+1),round(16+(1+8*st.bw)*resuse));
            else
               [cylX,cylY,cylZ]=cylinder(st.bw/2*linspace(cwedge,1,round(bondlength/st.bw)+1),round(16+(1+8*st.bw)*resuse));
            end
         else
            [cylX,cylY,cylZ]=cylinder(st.bw/2*ones(1,round(bondlength/st.bw)+1),round(16+(1+8*st.bw)*resuse));
         end
      elseif numel(bondcoloruse)==6
         if strcmpi(st.w,'on')
            if viewingangle>=90 bwfactor=[1,(1+cwedge)/2,cwedge];
            else bwfactor=[cwedge,(1+cwedge)/2,1];
            end
         else bwfactor=[1,1,1];
         end
         [cylX,cylY,cylZ]=cylinder(st.bw/2*bwfactor,round(16+(1+8*st.bw)*resuse));
      else
         if strcmpi(st.w,'on')
            if viewingangle>=90 bwfactor=[1,cwedge];
            else bwfactor=[cwedge,1];
            end
         else bwfactor=[1,1];
         end
         [cylX,cylY,cylZ]=cylinder(st.bw/2*bwfactor,round(16+(1+8*st.bw)*resuse));
      end
      cylZ=cylZ*atomdist(ir,jr);
      rotateangle=atan2(norm(cross([0,0,1],bondnorm)),dot([0,0,1],bondnorm));
      rotateaxis=cross([0,0,1],bondnorm);
      if norm(rotateaxis)==0 rotateaxis=[1,0,0]; end
      [cylX,cylY,cylZ]=rotatedata(cylX,cylY,cylZ,rotateaxis,rotateangle,xyzcart(ir,:));
      cvec=cross(viewcoord(2,:),xyzcart(jr,:)-xyzcart(ir,:)); if norm(cvec)==0 cvec=viewcoord(1,:); end
      cvec=cvec/norm(cvec)*(st.bw+st.bs)/2;
      if strcmpi(st.bt,'regular')||strcmpi(st.bt,'dashed')||strcmpi(st.bt,'wedge') nbonds=1; bondshift=[0,0,0];
      elseif strcmpi(st.bt,'double') nbonds=2; bondshift=[cvec;-cvec];
      elseif strcmpi(st.bt,'triple') nbonds=3; bondshift=[2*cvec;0,0,0;-2*cvec]; 
      end
      if strcmpi(st.bt,'dashed')
         if numel(bondcoloruse)==3 bondcoloruse=[bondcoloruse,1,1,1]; end
         cmH=zeros(size(cylZ,1),size(cylZ,2),3);
         for k=1:size(cmH,1)
            if rem(k,sum(st.dl))<st.dl(2) cmH(k,:,:)=repmat(bondcoloruse(4:6),size(cylZ,2),1);
            else cmH(k,:,:)=repmat(bondcoloruse(1:3),size(cylZ,2),1);
            end
         end
         hdltemp=surf(cylX,cylY,cylZ,'EdgeColor','none','FaceAlpha',st.ba,'AmbientStrength',lp(1),'DiffuseStrength',lp(2),...
            'SpecularStrength',lp(3),'SpecularExponent',lp(4),'CData',cmH,...
            'FaceLighting',st.fl,'DisplayName',['bond between ',atominfo(ir),' and ',atominfo(jr),', d=',num2str(bondlength)]);
         objlist(end+1,1:3)={hdltemp,'bondd',[ir,jr]};
      elseif size(bondcoloruse,2)==6
         cmH0=zeros(2,1,3);
         cmH0(1,1,:)=bondcoloruse(1:3);
         cmH0(2,1,:)=bondcoloruse(4:6);
         cmH=repmat(cmH0,[1 size(cylX,2) 1]);
         for k=1:nbonds
            hdltemp=surf(cylX+bondshift(k,1),cylY+bondshift(k,2),cylZ+bondshift(k,3),'EdgeColor','none','FaceAlpha',st.ba,'AmbientStrength',...
               lp(1),'DiffuseStrength',lp(2),'SpecularStrength',lp(3),'SpecularExponent',lp(4),...
               'CData',cmH,'DisplayName',['bond between ',atominfo(ir),' and ',atominfo(jr),', d=',num2str(bondlength)]);
            objlist(end+1,1:3)={hdltemp,'bondb',[ir,jr]};
         end
      else
         for k=1:nbonds
            hdltemp=surf(cylX+bondshift(k,1),cylY+bondshift(k,2),cylZ+bondshift(k,3),'EdgeColor','none','FaceAlpha',st.ba,'AmbientStrength',...
               lp(1),'DiffuseStrength',lp(2),'SpecularStrength',lp(3),'SpecularExponent',lp(4),'FaceColor',bondcoloruse,...
               'DisplayName',['bond between ',atominfo(ir),' and ',atominfo(jr),', d=',num2str(bondlength)]);
            objlist(end+1,1:3)={hdltemp,'bondu',[ir,jr]};
         end
      end
      if strcmpi(st.o,'on')
         lview=cross(viewcoord(2,:),xyzcart(jr,:)-xyzcart(ir,:));
         if strcmpi(st.w,'on')
            vect3=lview/norm(lview)*(0.5*st.bw*cwedge+st.ow);
            vect4=lview/norm(lview)*0.5*st.bw*cwedge;
         end
         vect1=lview/norm(lview)*(0.5*st.bw+st.ow);
         vect2=lview/norm(lview)*0.5*st.bw;
         if strcmpi(st.w,'on')
            if viewingangle>=90
               wlrect1=xyzcart([ir,ir,jr,jr],:)+[vect1;vect2;vect4;vect3];
               wlrect2=xyzcart([ir,ir,jr,jr],:)-[vect1;vect2;vect4;vect3];
            else
               wlrect1=xyzcart([ir,ir,jr,jr],:)+[vect3;vect4;vect2;vect1];
               wlrect2=xyzcart([ir,ir,jr,jr],:)-[vect3;vect4;vect2;vect1];
            end
         else
            wlrect1=xyzcart([ir,ir,jr,jr],:)+[vect1;vect2;vect2;vect1];
            wlrect2=xyzcart([ir,ir,jr,jr],:)-[vect1;vect2;vect2;vect1];
         end
         for k=1:nbonds
            fill3(wlrect1(:,1)+bondshift(k,1),wlrect1(:,2)+bondshift(k,2),wlrect1(:,3)+bondshift(k,3),st.oc,'FaceLighting','none',...
               'EdgeColor','none','FaceAlpha',st.ba);
            fill3(wlrect2(:,1)+bondshift(k,1),wlrect2(:,2)+bondshift(k,2),wlrect2(:,3)+bondshift(k,3),st.oc,'FaceLighting','none',...
               'EdgeColor','none','FaceAlpha',st.ba);
         end
      end
   end
end
atomupdate(atomset);
bondlist=unique([bondlist,atomset]);

function drawbondx(point1,point2,bondtype,dashlength,bondcolor,bondwidth,bondalpha,OLflag,OLwidth,OLcolor,facelighting,lp,resuse)
global viewcoord;
xp=point2(1)-point1(1);
yp=point2(2)-point1(2);
zp=point2(3)-point1(3);
length=norm(point2-point1);
xylength=norm([xp yp]);
if xylength>0
   sinphi=yp/xylength;
   cosphi=xp/xylength;
else
   sinphi=0;
   cosphi=1;
end
sintheta=xylength/length;
costheta=zp/length;
phirot=[cosphi -sinphi 0;sinphi cosphi 0;0 0 1];
thetarot=[costheta 0 sintheta;0 1 0;-sintheta 0 costheta];
if strcmpi(bondtype,'dash')
   [cylX,cylY,cylZ]=cylinder(bondwidth/2*ones(1,round(length/bondwidth)+1),round(16+(1+8*bondwidth)*resuse));
else
   [cylX,cylY,cylZ]=cylinder(bondwidth/2*[1,1],round(16+(1+8*bondwidth)*resuse));
end
cylZ=cylZ*length;
[m,n]=size(cylZ);
newcylpoint=bsxfun(@plus,[cylX(:),cylY(:),cylZ(:)]*thetarot'*phirot',point1);
cylX=reshape(newcylpoint(:,1),m,n);
cylY=reshape(newcylpoint(:,2),m,n);
cylZ=reshape(newcylpoint(:,3),m,n);
if strcmpi(bondtype,'dash')
   cmH=ones(size(cylZ,1),size(cylZ,2),3);
   if numel(bondcolor)==3 bondcolor=[bondcolor,1,1,1]; end
   for k=1:size(cmH,1)
      if rem(k,sum(dashlength))<dashlength(2) cmH(k,:,:)=repmat(bondcolor(4:6),size(cylZ,2),1);
      else cmH(k,:,:)=repmat(bondcolor(1:3),size(cylZ,2),1);
      end
   end
   surf(cylX,cylY,cylZ,'EdgeColor','none','FaceAlpha',bondalpha,'AmbientStrength',lp(1),'DiffuseStrength',lp(2),...
      'SpecularStrength',lp(3),'SpecularExponent',lp(4),'CData',cmH,'FaceLighting',facelighting,'DisplayName','cell edge');
else
   surf(cylX,cylY,cylZ,'EdgeColor','none','FaceAlpha',bondalpha,'AmbientStrength',lp(1),'DiffuseStrength',lp(2),...
      'SpecularStrength',lp(3),'SpecularExponent',lp(4),'FaceColor',bondcolor,'FaceLighting',facelighting,'DisplayName','cell edge');
end
if strcmpi(OLflag,'on')
   lview=cross(viewcoord(2,:),[xp,yp,zp]);
   vect1=lview/norm(lview)*(0.5*bondwidth+OLwidth);
   vect2=lview/norm(lview)*0.5*bondwidth;
   wlrect1=[point1(1),point1(2),point1(3);point1(1),point1(2),point1(3);point2(1),point2(2),point2(3);point2(1),point2(2),point2(3)]+[vect1;vect2;vect2;vect1];
   wlrect2=[point1(1),point1(2),point1(3);point1(1),point1(2),point1(3);point2(1),point2(2),point2(3);point2(1),point2(2),point2(3)]-[vect1;vect2;vect2;vect1];
   fill3(wlrect1(:,1),wlrect1(:,2),wlrect1(:,3),OLcolor,'FaceLighting','none','EdgeColor','none','AmbientStrength',.4,'FaceAlpha',1);
   fill3(wlrect2(:,1),wlrect2(:,2),wlrect2(:,3),OLcolor,'FaceLighting','none','EdgeColor','none','AmbientStrength',.4,'FaceAlpha',1);
end

function drawbondl(todrawlist,rangeref,bondcolor,bondwidth,bondalpha,lightparam,facelighting,resuse)
global atomdist xyzcart;
lp=getlightparam(lightparam,[0.4,0.6,0.9,10]);
if isempty(todrawlist) return; end
isdrawn=false(size(todrawlist,1),1);
for j=1:size(todrawlist,1)
   range=getrange(todrawlist(j,1),todrawlist(j,2),rangeref);
   temp=atomdist(todrawlist(j,1),todrawlist(j,2));
   if temp>=range(1)&&temp<=range(2) isdrawn(j)=true; end
end
todrawlist=todrawlist(isdrawn,:);
for j=1:size(todrawlist,1)
   point1=xyzcart(todrawlist(j,1),:); point2=xyzcart(todrawlist(j,2),:);
   xp=point2(1)-point1(1);
   yp=point2(2)-point1(2);
   zp=point2(3)-point1(3);
   length=norm(point2-point1);
   xylength=norm([xp yp]);
   if xylength>0 sinphi=yp/xylength; cosphi=xp/xylength;
   else sinphi=0; cosphi=1;
   end
   sintheta=xylength/length;
   costheta=zp/length;
   phirot=[cosphi,-sinphi,0;sinphi,cosphi,0;0,0,1];
   thetarot=[costheta,0,sintheta;0,1,0;-sintheta,0,costheta];
   [cylX,cylY,cylZ]=cylinder(bondwidth/2*[1,1],round(16+(1+8*bondwidth)*resuse));
   cylZ=cylZ*length;
   [m,n]=size(cylZ);
   newcylpoint=bsxfun(@plus,[cylX(:),cylY(:),cylZ(:)]*thetarot'*phirot',point1);
   cylX=reshape(newcylpoint(:,1),m,n);
   cylY=reshape(newcylpoint(:,2),m,n);
   cylZ=reshape(newcylpoint(:,3),m,n);
   surf(cylX,cylY,cylZ,'EdgeColor','none','FaceAlpha',bondalpha,'AmbientStrength',lp(1),'DiffuseStrength',lp(2),...
      'SpecularStrength',lp(3),'SpecularExponent',lp(4),'FaceColor',bondcolor,'facelighting',facelighting,'DisplayName',...
      ['bond between ',atominfo(todrawlist(j,1)),' and ',atominfo(todrawlist(j,2)),', d=',num2str(length)]);
end

function drawcell(st)
global unitcell cellbound res;
lp=getlightparam(st.lp,[0.4,0.6,0.9,10]);
if isnumeric(st.res) resuse=st.res; else resuse=res; end
if strcmpi(st.ct,'direct') origin=st.or*unitcell; else origin=st.or; end
if ischar(st.rn)
   if strcmpi(st.rn,'automatic')
      if isequal(cellbound,[Inf,Inf,Inf,-Inf,-Inf,-Inf]) [xr,yr,zr]=meshgrid([0,1],[0,1],[0,1]); frac=[xr(:),yr(:),zr(:)];
      else
         [xr,yr,zr]=meshgrid([cellbound(1),cellbound(4)],[cellbound(2),cellbound(5)],[cellbound(3),cellbound(6)]);
         frac=[xr(:),yr(:),zr(:)];
      end
      boundvec=[min(frac,[],1);max(frac,[],1)];
      xmin=round(boundvec(1,1));ymin=round(boundvec(1,2));zmin=round(boundvec(1,3));
      xmax=round(boundvec(2,1));ymax=round(boundvec(2,2));zmax=round(boundvec(2,3));
      if xmin==xmax
         xmin=xmin-(abs(xmin+0.001-boundvec(1,1))>abs(xmax-0.002-boundvec(2,1)));
         xmax=xmax+(abs(xmin+0.001-boundvec(1,1))<abs(xmax-0.002-boundvec(2,1)));
      end
      if ymin==ymax
         ymin=ymin-(abs(ymin+0.001-boundvec(1,2))>abs(ymax-0.002-boundvec(2,2)));
         ymax=ymax+(abs(ymin+0.001-boundvec(1,2))<abs(ymax-0.002-boundvec(2,2)));
      end
      if zmin==zmax
         zmin=zmin-(abs(zmin+0.001-boundvec(1,3))>abs(zmax-0.002-boundvec(2,3)));
         zmax=zmax+(abs(zmin+0.001-boundvec(1,3))<abs(zmax-0.002-boundvec(2,3)));
      end
   elseif strcmpi(st.rn,'unitcell')
      xmin=0;xmax=1;ymin=0;ymax=1;zmin=0;zmax=1;
   end
elseif isnumeric(range)&&numel(range)==6
   xmin=range(1); xmax=range(2); ymin=range(3); ymax=range(4); zmin=range(5); zmax=range(6);
end
for i=xmin:xmax
   for j=ymin:ymax
      for k=zmin:zmax
         if i~=xmax
            drawbondx([i,j,k]*unitcell+origin,[i+1,j,k]*unitcell+origin,st.bt,st.dl,st.bc,st.bw,st.ba,st.o,st.ow,st.oc,st.fl,lp,resuse);
         end
         if j~=ymax
            drawbondx([i,j,k]*unitcell+origin,[i,j+1,k]*unitcell+origin,st.bt,st.dl,st.bc,st.bw,st.ba,st.o,st.ow,st.oc,st.fl,lp,resuse);
         end
         if k~=zmax
            drawbondx([i,j,k]*unitcell+origin,[i,j,k+1]*unitcell+origin,st.bt,st.dl,st.bc,st.bw,st.ba,st.o,st.ow,st.oc,st.fl,lp,resuse);
         end
      end
   end
end
[x0,y0,z0]=meshgrid([xmin,xmax],[ymin,ymax],[zmin,zmax]); cornerx=[x0(:),y0(:),z0(:)]*unitcell+repmat(origin,8,1);
boundupdatex(cornerx);

function drawpoly(st,centralatom)
global xyzcart viewcoord objlist res;
if isnumeric(st.res) resuse=st.res; else resuse=res; end
if isnumeric(st.site) sitelist=st.site;
else
   [~,reflist,~]=siterefparser(st.site);
   [sitelist,~]=sitetrans(reflist);
end
lp=getlightparam(st.lp,[1,0.6,0.1,10]);
if numel(sitelist)<3 return;
elseif numel(sitelist)==3
   vertices=xyzcart(sitelist,:);
   poly=[1,2,3];
   vx=xyzcart(sitelist,1)';
   vy=xyzcart(sitelist,2)';
   vz=xyzcart(sitelist,3)';
   coordlist=[1,2,3];
   hulllist=sitelist;
else
   vertices=xyzcart(sitelist,:);
   poly=convhulln(vertices);
   vx=reshape(vertices(poly,1),size(poly));
   vy=reshape(vertices(poly,2),size(poly));
   vz=reshape(vertices(poly,3),size(poly));
   coordlist=unique([poly(:,1)',poly(:,2)',poly(:,3)']);
   hulllist=sitelist(coordlist);
end
atomupdate(hulllist);
defcolor=sum(atomcolorlookup('default',sitelist(coordlist)));
if ischar(st.bc)&&strcmpi(st.bc,'default') bondcolor=defcolor/numel(coordlist);
elseif ischar(st.bc)&&strcmpi(st.bc,'bicolored') bondcolor='default';
else bondcolor=st.bc;
end
if ischar(st.fc)&&strcmpi(st.fc,'default') facecolor=defcolor/numel(coordlist)*0.5+[0.5 0.5 0.5];
elseif ischar(st.fc)&&strcmpi(st.fc,'central') facecolor=atomcolorlookup('light',centralatom);
else facecolor=st.fc;
end
hdltemp=fill3(vx',vy',vz',facecolor,'FaceLighting',st.fl,'FaceAlpha',st.fa,'LineStyle','none','AmbientStrength',lp(1),...
   'DiffuseStrength',lp(2),'SpecularStrength',lp(3),'SpecularExponent',lp(4));
%{
if ~ischar(facecdata)||~strcmpi(facecdata,'default')
   for k=1:size(poly,1)
      if iscell(facecdata)
         temp0=sort(getelem(sitelist(poly(k,:))))';
         for l=1:size(facecdata,1)
            temp=sort(facecdata(l,1:3));
            if all(strcmpi(temp,temp0)) set(hdltemp(k),'facecolor',facecdata{l,4}); break; end
         end
      elseif ischar(facecdata)&&strcmpi(facecdata,'mix')
         temp=[0,0,0];
         for l=1:3
            temp=temp+atomcolorlookup('light',getelem(sitelist(poly(k,l))))/3;
         end
         set(hdltemp(k),'facecolor',temp);
      end
   end
end
%}
objlist(end+1,1:3)={hdltemp,'poly',hulllist};
if strcmpi(st.b,'on')&&numel(poly)~=3
   flag=zeros(size(xyzcart,1));
   todrawlist=[];
   for i=1:size(poly,1)
      xi=sitelist(poly(i,1));
      yi=sitelist(poly(i,2));
      zi=sitelist(poly(i,3));
      if flag(xi,yi)==0 flag(yi,xi)=zi;
      else
         if (dihedral(xi,yi,zi,flag(xi,yi))>pi/180*st.dt) todrawlist=[todrawlist;xi,yi]; end
      end
      if flag(yi,zi)==0 flag(zi,yi)=xi;
      else
         if (dihedral(yi,zi,xi,flag(yi,zi))>pi/180*st.dt) todrawlist=[todrawlist;yi,zi]; end
      end
      if flag(zi,xi)==0 flag(xi,zi)=yi;
      else
         if (dihedral(zi,xi,yi,flag(zi,xi))>pi/180*st.dt) todrawlist=[todrawlist;zi,xi]; end
      end
   end
   drawbondl(todrawlist,st.rn,bondcolor,st.bw,st.ba,st.lp,st.fl,resuse);
elseif strcmpi(st.b,'on')&&numel(poly)==3
   todrawlist=sitelist([1,2;2,3;3,1]);
   drawbondl(todrawlist,st.rn,bondcolor,st.bw,st.ba,st.lp,st.fl,resuse);
end
if strcmpi(st.o,'on')
   if strcmpi(st.b,'on') OLwidth=0.5*st.bw+st.ow; else OLwidth=st.ow; end
   verticesc=vertices/viewcoord;
   hull2d=convhull(verticesc(:,[3,1]));
   peri0=xyzcart(sitelist(hull2d))';
   lview=peri0(:,2:size(hull2d,1))-peri0(:,1:size(hull2d,1)-1);
   for i=1:size(lview,2)
      lview(:,i)=cross(lview(:,i),viewcoord(2,:));
      lview(:,i)=lview(:,i)/norm(lview(:,i))*OLwidth;
   end
   lview=[lview lview(:,1)];
   peri1=peri0(:,[2:size(hull2d,1),2]);
   peri2=peri1+lview;
   peri3=peri0+lview;
   cylX=[peri0(1,:);peri1(1,:);peri2(1,:);peri3(1,:)];
   cylY=[peri0(2,:);peri1(2,:);peri2(2,:);peri3(2,:)];
   cylZ=[peri0(3,:);peri1(3,:);peri2(3,:);peri3(3,:)];
   fill3(cylX,cylY,cylZ,st.oc,'FaceLighting','none','LineStyle','none','FaceAlpha',st.ba);
end

function drawcoord(st)
[~,reflist,~]=siterefparser(st.site);
[sitelist,~]=sitetrans(reflist);
for j=1:numel(sitelist)
   st0=rmfield(st,{'cr','cs'}); st0.site=coord(sitelist(j),st.cr,st.cs);
   drawpoly(st0,sitelist(j));
end

function drawCP(st)
global xyzcart CPdata CMdata res;
[~,reflist,~]=siterefparser(st.site);
[sitelist,~]=sitetrans(reflist);
lp=getlightparam(st.lp,[0.8,0.6,0.9,10]);
if isnumeric(st.res) resuse=st.res; else resuse=res; end
if strcmpi(st.m,'CP')
   coeff=CPdata.CPcoeff;
   if ischar(st.lm) lmax=CPdata.CPlmax;
   else lmax=min(st.lm,CPdata.CPlmax);
   end
   coeff=coeff(1:(lmax+1)^2,:)*st.scale;
   for j=sitelist
      for k=1:size(CPdata.CPxyzlist,1)
         temp=(CPdata.CPxyzlist(k,:)-xyzcart(j,:))/CPdata.CPunitcell;
         if norm(temp-round(temp))<0.001
            draworb(j,lmax,st.scale,coeff(:,k),st.lc,st.la,st.o,st.oc,st.ow,'complex',lp,st.fl,resuse,'CP');
            atomupdate(j);
            break;
         end
      end
   end
elseif strcmpi(st.m,'CM')
   coeff=CMdata.CMcoeff;
   if ischar(st.lm) lmax=CMdata.CMlmax;
   else lmax=min(st.lm,CMdata.CMlmax);
   end
   coeff=coeff(1:(lmax+1)^2,:)*st.scale;
   for j=sitelist
      for k=1:size(CMdata.CMxyzlist,1)
         temp=(CMdata.CMxyzlist(k,:)-xyzcart(j,:))/CMdata.CMunitcell;
         if norm(temp-round(temp))<0.001
            draworb(j,lmax,st.scale,coeff(:,k),st.lc,st.la,st.o,st.oc,st.ow,'complex',lp,st.fl,resuse,'CM');
            atomupdate(j);
            break;
         end
      end
   end
end

function hdltemp=draworb(ir,lmax,scale,coeff,colorref,lobealpha,OLflag,OLcolor,OLwidth,RCflag,lightparam,facelighting,resuse,orbtype)
global xyzcart viewcoord objlist;
if ischar(colorref)
   if strcmpi(colorref,'colored')
      poscolor=atomcolorlookup('verylight',ir);
      negcolor=atomcolorlookup('verydark',ir);
   elseif strcmpi(colorref,'default')
      if strcmpi(orbtype,'raMO')
         poscolor=[0.35,1,0.35];
         negcolor=[0.4,0.75,1];
      else
         poscolor=[0.8,0.8,0.8];
         negcolor=[0,0,0];
      end
   end
else
   poscolor=colorref(1:3);
   negcolor=colorref(4:6);
end
[Xj,Yj,Zj]=sphere(32+8*resuse);
size0=size(Xj);
temp=[Xj(:),Yj(:),Zj(:)]*[-viewcoord(1,:);-viewcoord(3,:);viewcoord(2,:)];
Xj=reshape(temp(:,1),size0);Yj=reshape(temp(:,2),size0);Zj=reshape(temp(:,3),size0);
[phi,theta,~]=cart2sph(Xj,Yj,Zj);
if strcmpi(RCflag,'complex')
   thetaj=pi/2*ones(size(phi))-theta;
   thetaj=abs(thetaj);
   rnew=(1/(4*pi))^0.5*coeff(1)*ones(size(phi));
   counter=1;
   for l=1:lmax
      m=0;
      Plm_0=2^0.5*legendre(l,cos(thetaj),'norm');
      Plm(:,:)=(-1)^m*Plm_0(m+1,:,:);
      counter=counter+1;
      rnew=rnew+coeff(counter)*Plm/((4*pi)^0.5);
      for m=1:l
         counter=counter+2;
         Plm(:,:)=(-1)^m*Plm_0(m+1,:,:);
         rnew=rnew+Plm*2^0.5.*(coeff(counter-1)*cos(m*phi)+coeff(counter)*sin(m*phi))/((4*pi)^0.5);
      end
   end
elseif strcmpi(RCflag,'real')      % coeff=[s,px,py,pz,dx2-y2,dz2,dxy,dxz,dyz]
   rnew=coeff(1)*(1/(4*pi))^0.5*ones(size(phi));
   rnew=rnew+coeff(2)*0.5*(3/pi)^0.5*cos(theta).*cos(phi);
   rnew=rnew+coeff(3)*0.5*(3/pi)^0.5*cos(theta).*sin(phi);
   rnew=rnew+coeff(4)*0.5*(3/pi)^0.5*sin(theta);
   rnew=rnew+coeff(5)*(15/(16*pi))^0.5*cos(theta).^2.*cos(2*phi);
   rnew=rnew+coeff(6)*0.25*(5/(pi))^0.5*(3*sin(theta).^2-ones(size(theta)));
   rnew=rnew+coeff(7)*(15/(16*pi))^0.5*cos(theta).^2.*sin(2*phi);
   rnew=rnew+coeff(8)*0.5*(15/(pi))^0.5*(sin(theta).*cos(theta).*cos(phi));
   rnew=rnew+coeff(9)*0.5*(15/(pi))^0.5*(sin(theta).*cos(theta).*sin(phi));
end
if scale==-1 hdltemp={rnew,coeff(1)}; return; end
[Xnew,Ynew,Znew]=sph2cart(phi,theta,abs(rnew));
Xnew=Xnew+xyzcart(ir,1);
Ynew=Ynew+xyzcart(ir,2);
Znew=Znew+xyzcart(ir,3);
cmH=zeros(numel(rnew),3); temp=rnew<0; stemp=sum(sum(temp));
cmH(temp,:)= repmat(negcolor,stemp,1); cmH(~temp,:)= repmat(poscolor,numel(rnew)-stemp,1); cmH=reshape(cmH,[size(rnew,1),size(rnew,2),3]);
if strcmpi(orbtype,'CP') strarray=[atominfo(ir),' CP= ',num2str(coeff(1)*104280/scale),' GPa'];
elseif strcmpi(orbtype,'CM') strarray=[atominfo(ir),' CM= ',num2str(coeff(1)*104280/scale),' GPa'];
elseif strcmpi(orbtype,'raMO') strarray=[atominfo(ir),' P_atom= ',num2str((norm(coeff)/scale)^2)];
end
hdltemp=surf(Xnew,Ynew,Znew,'FaceLighting',facelighting,'AmbientStrength',lightparam(1),'DiffuseStrength',lightparam(2),'SpecularStrength',lightparam(3),...
   'SpecularExponent',lightparam(4),'EdgeColor','none','FaceAlpha',lobealpha,'AlphaDataMapping','none','CData',cmH,'DisplayName',strarray);
objlist(end+1,1:3)={hdltemp,'lobe',ir};
if strcmpi(OLflag,'on')
   res0=32+8*resuse;
   [rmax0,ind0]=max(bsxfun(@times,abs(rnew),cos(-pi/2:pi/res0:pi/2)'));
   theta=0:2*pi/res0:2*pi;
   peri0=bsxfun(@plus,xyzcart(ir,:)',bsxfun(@times,viewcoord(1,:)'*cos(theta)+viewcoord(3,:)'*sin(theta),rmax0));
   for ir=1:size(peri0,2)
      peri0(:,ir)=peri0(:,ir)-dot(peri0(:,ir)-[Xnew(ind0(ir),ir),Ynew(ind0(ir),ir),Znew(ind0(ir),ir)]',viewcoord(2,:)')*viewcoord(2,:)';
   end
   peri3=[peri0(:,2:size(peri0,2)),peri0(:,2)];
   temp=zeros(size(peri0));
   for j=1:size(temp,2)
      temp(:,j)=cross(peri3(:,j)-peri0(:,j),viewcoord(2,:));
      temp(:,j)=temp(:,j)/norm(temp(:,j))*OLwidth;
   end
   peri1=peri0-temp;
   peri2=[peri1(:,2:size(peri1,2)),peri1(:,1)];
   cylX=[peri0(1,:);peri1(1,:);peri2(1,:);peri3(1,:)];
   cylY=[peri0(2,:);peri1(2,:);peri2(2,:);peri3(2,:)];
   cylZ=[peri0(3,:);peri1(3,:);peri2(3,:);peri3(3,:)];
   surf(cylX,cylY,cylZ,'FaceColor',OLcolor,'FaceLighting','none','LineStyle','none');
end


function drawraMO(st,jramo)

















