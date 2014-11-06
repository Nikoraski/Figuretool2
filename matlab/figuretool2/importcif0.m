function importcif0(filename,range)
global atomlist xyzlist unitcell coordtype;
inID=fopen(filename);
if inID<0 return; end
try
   cifdat=getcifdata(inID);
catch
   waitfor(msgbox('Error reading in cif file data.','Figuretool2')); return;
end
symxyz=cifdat(find(strcmpi('symmetry_equiv_pos_as_xyz',{cifdat.name}),1)).val;
if isempty(symxyz) waitfor(msgbox('The cif file does not contain symmetry_equiv_pos_as_xyz data.','Figuretool2')); return; end
a=cifdat(find(strcmpi('cell_length_a',{cifdat.name}),1)).val;
b=cifdat(find(strcmpi('cell_length_b',{cifdat.name}),1)).val;
c=cifdat(find(strcmpi('cell_length_c',{cifdat.name}),1)).val;
alpha=cifdat(find(strcmpi('cell_angle_alpha',{cifdat.name}),1)).val;
beta=cifdat(find(strcmpi('cell_angle_beta',{cifdat.name}),1)).val;
gamma=cifdat(find(strcmpi('cell_angle_gamma',{cifdat.name}),1)).val;
if isempty(a)||isempty(b)||isempty(c)||isempty(alpha)||isempty(beta)||isempty(gamma)
   waitfor(msgbox('The cif file does not contain the cell parameters.','Figuretool2')); return;
end
tempa=[a,0,0]; tempb=[b*cosd(gamma),b*sind(gamma),0];
tempcx=c*cosd(beta); tempcy=(c*cosd(alpha)-c*cosd(beta)*cosd(gamma))/sind(gamma);
tempc=[tempcx,tempcy,sqrt(c^2-tempcx^2-tempcy^2)];
[unitcelluse,~]=symsearch([tempa;tempb;tempc]);
atomlabel=cifdat(find(strcmpi('atom_site_label',{cifdat.name}),1)).val;
if isempty(atomlabel) waitfor(msgbox('The cif file does not contain _atom_site_label.','Figuretool2')); return; end
xfrac=cifdat(find(strcmpi('atom_site_fract_x',{cifdat.name}),1)).val;
yfrac=cifdat(find(strcmpi('atom_site_fract_y',{cifdat.name}),1)).val;
zfrac=cifdat(find(strcmpi('atom_site_fract_z',{cifdat.name}),1)).val;
if isempty(xfrac)||isempty(yfrac)||isempty(zfrac)
   xcart=cifdat(find(strcmpi('atom_site_Cartn_x',{cifdat.name}),1)).val;
   ycart=cifdat(find(strcmpi('atom_site_Cartn_y',{cifdat.name}),1)).val;
   zcart=cifdat(find(strcmpi('atom_site_Cartn_z',{cifdat.name}),1)).val;
   if isempty(xfrac)||isempty(yfrac)||isempty(zfrac)
      waitfor(msgbox('The cif file does not contain _atom_site_fract_{xyz} or _atom_site_Cartn_{xyz}.','Figuretool2')); return;
   end
   temp=[xcart,ycart,zcart]/unitcelluse;
   xfrac=temp(:,1); yfrac=temp(:,2); zfrac=temp(:,3);
end
atomlistuse={}; xyzlistuse=[];
%try
for j=1:numel(atomlabel)
   symop=getsymop(symxyz,xfrac(j),yfrac(j),zfrac(j));
   symop=rmdup(symop,range);
   atomlistuse=[atomlistuse;repmat(atomlabel(j),size(symop,1),1)];
   xyzlistuse=[xyzlistuse;symop];
end
%catch
%   waitfor(msgbox('Error performing symmetry operations on atomic sites.','Figuretool2')); return;
%end
if ~isempty(xyzlist)
   button=questdlg('A template coordinate list already exists. Do you wish to overwrite current coordinate data?','Figuretool2','Yes','No','No');
   if ~strcmpi(button,'Yes') return; end
end
unitcell=unitcelluse; atomlist=atomlistuse; xyzlist=xyzlistuse; coordtype='direct';
elemgen();

function symopout=getsymop(symxyzin,x,y,z) %#ok<INUSD>
symopout=zeros(numel(symxyzin),3);
for kindex=1:size(symopout,1)
   symopout(kindex,:)=eval(['[',symxyzin{kindex},']']);
end

function matout=rmdup(matin,range)
for j=size(matin,1):-1:1
   for k=1:j-1
      diff=matin(j,:)-matin(k,:);
      if norm(diff-round(diff))<0.0001
         matin(j,:)=[];
         break;
      end
   end
end
matin=matin-floor(matin);
matout=[];
for j=1:size(matin,1)
   xtemp=matin(j,1)+(floor(range(1)):ceil(range(2)));
   xtemp=xtemp((xtemp>=range(1))&(xtemp<=range(2)));
   ytemp=matin(j,2)+(floor(range(3)):ceil(range(4)));
   ytemp=ytemp((ytemp>=range(3))&(ytemp<=range(4)));
   ztemp=matin(j,3)+(floor(range(5)):ceil(range(6)));
   ztemp=ztemp((ztemp>=range(5))&(ztemp<=range(6)));
   [xall,yall,zall]=meshgrid(xtemp,ytemp,ztemp);
   matout=[matout;xall(:),yall(:),zall(:)];
end





