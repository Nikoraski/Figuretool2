function [arrayout,errstr]=sitetrans(reflistin)
global atomlist unitcell unitcelllist usedlist bondlist grouparray grouplist;

opndstack={}; optstack={}; errstr=''; arrayout=[];
for j=1:size(reflistin,1)
   token=reflistin{j,1}; str=reflistin{j,2};
   switch token
      case 'list', opndstack{end+1}=str2num(str);
      case 'site', opndstack{end+1}=getsite(str);
      case 'group', opndstack{end+1}=grouparray{strcmpi(str,grouplist(:,1))};
      case 'all', opndstack{end+1}=setdiff(1:numel(atomlist),getsite('dummy'));
      case 'used', opndstack{end+1}=usedlist;
      case 'bonded', opndstack{end+1}=bondlist;
      case 'unitcell'
         if ~isequal(size(unitcell),[3,3]) errstr='Unit cell vectors are not correctly specified.'; return;
         else opndstack{end+1}=unitcelllist;
         end
      case 'getbox'
         [temp,errout]=getboxl(str);
         if isempty(errout) opndstack{end+1}=temp; else errstr=errout; return; end
      case 'getsphere'
         [temp,errout]=getspherel(str);
         if isempty(errout) opndstack{end+1}=temp; else errstr=errout; return; end
      case 'getslab'
         [temp,errout]=getslabl(str);
         if isempty(errout) opndstack{end+1}=temp; else errstr=errout; return; end
      case 'coord', optstack{end+1}=str;
      case 'getmol', optstack{end+1}=str;
      case 'convhull', optstack{end+1}=str;
      case 'lp', optstack{end+1}='(';
      case 'rp'
         while ismember(optstack{end},{'&','|','~'})
            if strcmpi(optstack{end},'~')
               opndstack{end}=setdiff(1:numel(atomlist),opndstack{end});
            elseif strcmpi(optstack{end},'&')
               opndstack=[opndstack(1:end-2),{intersect(opndstack{end-1},opndstack{end})}];
            elseif strcmpi(optstack{end},'|')
               opndstack=[opndstack(1:end-2),{union(opndstack{end-1},opndstack{end})}];
            end
            optstack(end)=[];
         end
         if strcmpi(optstack{end},'(') optstack(end)=[]; continue;
         elseif strcmpi(optstack{end}(1:4),'conv')
            opndstack{end}=convhulll(opndstack{end});
         elseif strcmpi(optstack{end}(1:4),'getm')
            temp=regexp(optstack{end},'[<>]','split');
            opndstack=[opndstack(1:end-2),getmoll(opndstack{end-1},opndstack{end},temp{2})];
         elseif strcmpi(optstack{end}(1:4),'coor')
            temp=regexp(optstack{end},'[<>]','split');
            opndstack=[opndstack(1:end-2),coordl(opndstack{end-1},opndstack{end},temp{2})];
         end
         optstack(end)=[];
      case 'and'
         if isempty(optstack) optstack{end+1}='&';
         elseif strcmpi(optstack{end},'~')
            optstack{end}='&';
            opndstack{end}=setdiff(1:numel(atomlist),opndstack{end});
         elseif strcmpi(optstack{end},'&')
            opndstack=[opndstack(1:end-2),{intersect(opndstack{end-1},opndstack{end})}];
         elseif strcmpi(optstack{end},'|')
            optstack{end}='&';
            opndstack=[opndstack(1:end-2),{union(opndstack{end-1},opndstack{end})}];
         else optstack{end+1}='&';
         end
      case 'or'
         if isempty(optstack) optstack{end+1}='|';
         elseif strcmpi(optstack{end},'~')
            optstack{end}='|';
            opndstack{end}=setdiff(1:numel(atomlist),opndstack{end});
         elseif strcmpi(optstack{end},'&')
            opndstack=[opndstack(1:end-2),{intersect(opndstack{end-1},opndstack{end})}];
            optstack{end}='|';
         elseif strcmpi(optstack{end},'|')
            opndstack=[opndstack(1:end-2),{union(opndstack{end-1},opndstack{end})}];
         else optstack{end+1}='|';
         end
      case 'not', optstack{end+1}='~';
      case 'comma'
         if numel(optstack{end})>3&&ismember(optstack{end}(1:3),{'coo','get'}) continue;
         elseif strcmpi(optstack{end},'~')
            optstack(end)=[];
            opndstack{end}=setdiff(1:numel(atomlist),opndstack{end});
         elseif strcmpi(optstack{end},'&')
            opndstack=[opndstack(1:end-2),{intersect(opndstack{end-1},opndstack{end})}];
            optstack(end)=[];
         elseif strcmpi(optstack{end},'|')
            opndstack=[opndstack(1:end-2),{union(opndstack{end-1},opndstack{end})}];
            optstack(end)=[];
         end
   end
end
while ~isempty(optstack)
   if strcmpi(optstack{end},'~')
      opndstack{end}=setdiff(1:numel(atomlist),opndstack{end});
   elseif strcmpi(optstack{end},'&')
      opndstack=[opndstack(1:end-2),{intersect(opndstack{end-1},opndstack{end})}];
   elseif strcmpi(optstack{end},'|')
      opndstack=[opndstack(1:end-2),{union(opndstack{end-1},opndstack{end})}];
   end
   optstack(end)=[];
end
arrayout=opndstack{1}; if size(arrayout,1)~=1 arrayout=arrayout'; end

function listout=getsite(str)
global atomlist elemlist;
temp=strcmpi(str,elemlist);
if any(temp) listout=find(temp); return;
else listout=find(strcmpi(str,atomlist));
end

function [listout,errstr]=getboxl(str)
global xyzcart unitcell;
listout=[]; errstr='';
temp=regexp(str,'[<,>\[\]]','split');
cnflag=temp{2}; rnflag=temp{3};
cn=str2double(temp(5:7));
rn=str2double(temp(10:12));
if (strcmpi(cnflag,'c')||strcmpi(rnflag,'c'))&&~isequal(size(unitcell),[3,3]) errstr='Unit cell vectors are not correctly specified.'; return; end
if strcmpi(cnflag,'c') cn=cn*unitcell; end
if strcmpi(rnflag,'r')
   listout=find((abs(xyzcart(:,1)-cn(1))<=rn(1))&(abs(xyzcart(:,2)-cn(2))<=rn(2))&(abs(xyzcart(:,3)-cn(3))<=rn(3)));
else
   cn=cn/unitcell;
   xyzfrac=xyzcart/unitcell;
   listout=find((abs(xyzfrac(:,1)-cn(1))<=rn(1))&(abs(xyzfrac(:,2)-cn(2))<=rn(2))&(abs(xyzfrac(:,3)-cn(3))<=rn(3)));
end

function [listout,errstr]=getslabl(str)
global xyzcart unitcell;
listout=[]; errstr='';
str=str(6:end-1);
commaidx=find(','==str,1,'last');
range=str2double(str(commaidx+1:end));
valstr=str(2:commaidx-2);
if (numel(valstr)>5)&&ismember(upper(valstr(1:5)),{'''AM'',','''CM'',','''RM'',','''AC'',','''CC'',','''RC'',','''AR'',','''CR'',','''RR'',',...
      '''3A'',','''3C'',','''3R'',','''EC'',','''ER'','})
   if any('C'==upper(valstr(2:3)))&&(~isequal(size(unitcell),[3,3])||abs(det(unitcell))<1E-6) errstr='Unit cell vectors are not correctly specified.'; return; end
   valstr0=valstr(6:end);
   switch upper(valstr(1:5))
      case {'''3A'',','''3C'',','''3R'','}
         temp=regexp(valstr0,'[\[\],]','split');
         if strcmpi(valstr(3),'a') pmat=xyzcart([str2double(temp{1}),str2double(temp{2}),str2double(temp{3})],:);
         elseif strcmpi(valstr(3),'c') pmat=[str2double(temp{2}),str2double(temp{3}),str2double(temp{4});...
               str2double(temp{7}),str2double(temp{8}),str2double(temp{9});str2double(temp{12}),str2double(temp{13}),str2double(temp{14})]*unitcell;
         elseif strcmpi(valstr(3),'r') pmat=[str2double(temp{2}),str2double(temp{3}),str2double(temp{4});...
               str2double(temp{7}),str2double(temp{8}),str2double(temp{9});str2double(temp{12}),str2double(temp{13}),str2double(temp{14})];
         end
         normal0=cross(pmat(2,:)-pmat(1,:),pmat(3,:)-pmat(1,:));
         if norm(normal0)<1E-3 errstr='The specified planes of slab specification are collinear.'; return; end
         normal0=normal0/norm(normal0);
         point0=pmat(1,:);
      case {'''EC'',','''ER'','}
         temp=regexp(valstr0,'[\[\],]','split');
         xr=str2double(temp{2}); yr=str2double(temp{3}); zr=str2double(temp{4}); cr=str2double(temp{5});
         if abs(xr)>1E-6 point0=[-cr/xr,0,0];
         elseif abs(yr)>1E-6 point0=[0,-cr/yr,0];
         else point0=[0,0,-cr/zr];
         end
         normal0=[xr,yr,zr];
         if strcmpi(valstr(3),'c')
            point0=point0*unitcell;
            cellrec=[cross(unitcell(2,:),unitcell(3,:));cross(unitcell(3,:),unitcell(1,:));cross(unitcell(1,:),unitcell(2,:))]/det(unitcell);
            normal0=normal0*cellrec;
         end
      case {'''AM'',','''CM'',','''RM'','}
         temp=regexp(valstr0,'[\[\],]','split');
         if strcmpi(valstr(2),'a') point0=xyzcart(str2double(temp{1}),:); nstart=3;
         elseif strcmpi(valstr(2),'r') point0=[str2double(temp{2}),str2double(temp{3}),str2double(temp{4})]; nstart=7;
         else point0=[str2double(temp{2}),str2double(temp{3}),str2double(temp{4})]*unitcell; nstart=7;
         end
         miller=[str2double(temp{nstart}),str2double(temp{nstart+1}),str2double(temp{nstart+2})];
         cellrec=[cross(unitcell(2,:),unitcell(3,:));cross(unitcell(3,:),unitcell(1,:));cross(unitcell(1,:),unitcell(2,:))]/det(unitcell);
         normal0=miller*cellrec;
         normal0=normal0/norm(normal0);
      case {'''AC'',','''CC'',','''RC'',','''AR'',','''CR'',','''RR'','}
         temp=regexp(valstr0,'[\[\],]','split');
         if strcmpi(valstr(2),'a') point0=xyzcart(str2double(temp{1}),:); nstart=3;
         elseif strcmpi(valstr(2),'r') point0=[str2double(temp{2}),str2double(temp{3}),str2double(temp{4})]; nstart=7;
         else point0=[str2double(temp{2}),str2double(temp{3}),str2double(temp{4})]*unitcell; nstart=7;
         end
         normal0=[str2double(temp{nstart}),str2double(temp{nstart+1}),str2double(temp{nstart+2})];
         if strcmpi(valstr(3),'c') normal0=normal0*unitcell; end
         normal0=normal0/norm(normal0);
   end
else
   [~,reflistout0,~]=siterefparser(valstr);
   sitelist0=sitetrans(reflistout0);
   temp=fitplane(xyzcart(sitelist0,:));
   point0=temp{1}; normal0=temp{2}; status0=temp{3};
   if status0==1 errstr='There is not enough atoms to define the slab reference plane.'; return; end
end
listout=find(abs(bsxfun(@minus,xyzcart,point0)*normal0')<=range);

function [listout,errstr]=getspherel(str)
global xyzcart unitcell;
listout=[]; errstr='';
temp=regexp(str,'[<,>\[\])]','split');
cnflag=temp{2};
cn=str2double(temp(4:6));
rn=str2double(temp{8});
if strcmpi(cnflag,'c')&&~isequal(size(unitcell),[3,3]) errstr='Unit cell vectors are not correctly specified.'; return; end
if strcmpi(cnflag,'c') cn=cn*unitcell; end
listout=find(sum(bsxfun(@minus,xyzcart,cn).^2,2)<=rn^2);

function listout=coordl(atomset,coordlist,rangeref)
global atomdist;
if ~strcmpi(rangeref,'default') rangeref=str2num('[',rangeref,']'); end
rangematrix=getrange(atomset,coordlist,rangeref);
listout=coordlist(all(atomdist(atomset,coordlist)>rangematrix(:,:,1),1)&any(atomdist(atomset,coordlist)<rangematrix(:,:,2),1));

function listout=getmoll(atomset,coordlist,rangeref)
listout=atomset; newlist=atomset;
while true
   newlist=setdiff(coordl(newlist,coordlist,rangeref),listout);
   if isempty(newlist) break;
   else listout=unique([listout,newlist]);
   end
end

function listout=convhulll(listin)
global xyzcart;
points=xyzcart(listin,:);
hull0=convhulln(points);
listout=listin(unique(hull0(:)));

function cellout=fitplane(xyzin)
point=mean(xyzin,1); normal=[]; status=0;
xyzin=bsxfun(@minus,xyzin,point);
[v,d]=eig(xyzin'*xyzin);
if sum(abs(diag(d))<1E-5)>1 status=1;
else normal=v(:,1);
end
cellout={point,normal,status};

function mol=getmol(startref,instring,rangeref)
if nargin<3 rangeref='default'; end
mol=siteselect(startref);
mol0=[];
while(~isequal(mol,mol0))
   mol0=mol;
   mol=unique([mol,coord(mol,rangeref,instring)]);
end



