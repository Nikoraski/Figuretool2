function makeramo
centralatoms=[1:128];                                              %atoms to look at in -geo file
remainderatoms=[11,13];						%range of leftove orbitals to analyze
atomhueckel=384;                                                 %number of atoms used in Hueckel input file
filename='CoTe2.bind';                                          %name of YAeHMOP output file
basis='CoTe2.bind_Te-geo';                                      %name of basis file for remainder analysis
template='CoTe2.bind_0-geo';                               %name of template file
maporbital={'Co',[1,1,1,1,1,1,1,1,1];'Te',[1,1,1,1,0,0,0,0,0]};  %atomic orbitals to map ([s,px,py,pz,dx2-y2,dz2,dxy,dxz,dyz])
printmode=600;                                                  %print figures (negative = png no image, 0 = image no png, positive = png and image)
picturename='CoTe2_remainder';			%Basis for picture names
lobescale=3;					%Scale of raMO lobes
nprintorb=8;					%Number of raMO orbitals to be drawn
displaytext='on';				%Display raMO orbital and energy information in the figure
recombine=1;					 %recombine leftover states (1=yes)
numleftover=190;                                  %Number of leftover states
tolerance=0.0000;                                                %fermi tolerance

if isunix
    [~,orbnumstr]=system(['grep "Num_Orbitals" ',filename,'.out']);
    temp=textscan(orbnumstr,'%s %f');
    orbnum=temp{2};
    disp(['Number of orbitals: ',num2str(orbnum)]);
    [~,fermistr]=system(['grep "#Fermi_Energy:" ',filename,'.out']);
    temp=regexpi(fermistr,'[: ]','split');
    temp=temp(~cellfun(@isempty,temp));
    fermi=str2double(temp{end});
    disp(['Fermi energy: ',num2str(fermi)]);
    [~,temp]=system('ls | grep inmatrix');
    if isempty(temp)
        system(['grep -A10000000 Hamiltonian ',filename,'.out > inmatrix']);
        disp('File inmatrix not found: new inmatrix file created.');
    else
        disp('File inmatrix found: using old inmatrix file for calculation.');
        disp('(If this is not what you want, delete inmatrix and try again.)');
    end
    H_total=zeros(orbnum);
    inID=fopen('inmatrix');
    for i=1:floor((orbnum-1)/3)
        temp2=textscan(inID,'%s %s %s %f %f %f',orbnum,'headerlines',2);
        H_total(:,3*i-2:3*i)=[temp2{4:6}];
    end
elseif ispc
    [~,orbnumstr]=system(['findstr "Num_Orbitals" ',filename,'.out']);
    temp=regexp(orbnumstr,'[ \n]','split');
    temp=temp(cellfun(@(x) ~isempty(x),temp));
    orbnum=str2double(temp{end});
    disp(['Number of orbitals: ',num2str(orbnum)]);
    [~,orbnumstr]=system(['findstr "#Fermi_Energy:" ',filename,'.out']);
    temp=regexp(orbnumstr,'[ \n]','split');
    temp=temp(cellfun(@(x) ~isempty(x),temp));
    fermi=str2double(temp{end});
    disp(['Fermi energy: ',num2str(fermi)]);
    [~,orbnumstr]=system(['findstr /n "Hamiltonian" ',filename,'.out']);
    temp=regexp(orbnumstr,'[ :]','split');
    linenumber=str2double(temp{1});
    inID=fopen([filename,'.out']);
    H_total=zeros(orbnum);
    temp2=textscan(inID,'%s %s %s %f %f %f',orbnum,'headerlines',linenumber+1);
    H_total(:,1:3)=[temp2{4:6}];
    for i=2:floor((orbnum-1)/3)
        temp2=textscan(inID,'%s %s %s %f %f %f',orbnum,'headerlines',2);
        H_total(:,3*i-2:3*i)=[temp2{4:6}];
    end
end
res=mod(orbnum-1,3)+1;
spec=strcat('%s %s %s',repmat(' %f',1,res));
temp2=textscan(inID,spec,orbnum,'headerlines',2);
H_total(:,end-res+1:end)=[temp2{4:4+res-1}];
fclose(inID);
inID=fopen(filename);
temp3=textscan(inID,'%f %s %f %f %f',atomhueckel,'headerlines',5);
hueckellist=temp3{2};
xcart=[temp3{3} temp3{4} temp3{5}];
temp3=textscan(inID,'%f %s %f %f %f',4,'headerlines',1);
supercell=[temp3{3}(2:4) temp3{4}(2:4) temp3{5}(2:4)]-repmat([temp3{3}(1) temp3{4}(1) temp3{5}(1)],3,1);
fclose(inID);
H_total=H_total(:,1:orbnum);
H_total=H_total+H_total'-diag(diag(H_total));
disp('Read in Hamiltonian.');
[atomname,x0,y0,z0]=textread(template,'%s %f %f %f');
elemname=cellfun(@(x) regexprep(x,'[0-9]',''),atomname,'UniformOutput',false);
elemname=elemname(~strcmp('&',elemname));
x0=x0(~strcmp('&',elemname));
y0=y0(~strcmp('&',elemname));
z0=z0(~strcmp('&',elemname));
xpos=zeros(size(x0));
for i=1:size(x0)
    for j=1:atomhueckel
        temp=(xcart(j,:)-[x0(i) y0(i) z0(i)])/supercell;
        if norm(temp-round(temp))<0.01
            xpos(i)=j;
            break;
        end
    end
    if xpos(i)==0
        error(['Cannot find atom ',num2str(i),' in YAeHMOP file!']);
    end
end
[atomname1,x1,y1,z1]=textread(basis,'%s %f %f %f');
elemname1=cellfun(@(x) regexprep(x,'[0-9]',''),atomname1,'UniformOutput',false);
elemname1=elemname1(~strcmp('&',elemname1));
x1=x1(~strcmp('&',elemname1));
y1=y1(~strcmp('&',elemname1));
z1=z1(~strcmp('&',elemname1));
xpos1=zeros(size(x1));
for i=1:size(x1)
    for j=1:atomhueckel
        temp=(xcart(j,:)-[x1(i) y1(i) z1(i)])/supercell;
        if norm(temp-round(temp))<0.01
            xpos1(i)=j;
            break;
        end
    end
    if xpos1(i)==0
        error(['Cannot find atom ',num2str(i),' in YAeHMOP file!']);
    end
end
[psi,E_MO]=sort_eig(H_total);
occupiedstates=sum(E_MO<fermi+tolerance/2);
occupancy_CO=zeros(1,occupiedstates);
first=0;
second=0;
for i=1:occupiedstates
  if E_MO(i)<fermi-tolerance/2
    occupancy_CO(i)=2;
  elseif first==0
    lowerlimit=i;
    first=1;
  elseif E_MO(i)>fermi && second==0
    second=1;
    upperlimit=i;
  end
end
for i=1:occupiedstates
  if occupancy_CO(i)==0
    occupancy_CO(i) = (upperlimit-lowerlimit)*2/(occupiedstates-lowerlimit+1);
  end
end

psi=psi(:,1:occupiedstates);
disp('Made psi.');
TME={'SC','TI','V','CR','MN','FE','CO','NI','CU','Y','ZR','NB','MO','TC','RU','RH','PD','AG','LU','HF','TA','W','RE','OS','IR','PT','AU','GD'};
hueckelarray0=ismember(upper(hueckellist),TME)*5-strcmpi('H',hueckellist)*3+4;
orbarray=cellfun(@(x) sum(maporbital{strcmpi(x,maporbital(:,1)),2}),elemname);
orbarray1=cellfun(@(x) sum(maporbital{strcmpi(x,maporbital(:,1)),2}),elemname1);
phi_combined=zeros(orbnum,sum(orbarray(centralatoms)));
E_combined=zeros(1,sum(orbarray(centralatoms)));
rangetotal=zeros(1,sum(orbarray(centralatoms)));
count=0;
for k=centralatoms
    m=xpos(k);
    range=sum(hueckelarray0(1:m-1))+1:sum(hueckelarray0(1:m));
    range=range(logical(maporbital{strcmpi(elemname(k),maporbital(:,1)),2}));
    H_frag=zeros(orbnum);
    H_frag(range,range)=H_total(range,range);
    [phi,E_frag]=sort_eig(H_frag);
    phi_frag=phi(:,abs(E_frag)>0.00001);
    phi=zeros(size(phi_frag));
    phi(range,:)=phi_frag(range,:);
    E_frag=E_frag(abs(E_frag)>0.00001);
    phi_combined(:,count+1:count+orbarray(k))=phi;
    E_combined(count+1:count+orbarray(k))=E_frag;
    rangetotal(count+1:count+orbarray(k))=range;
    count=count+orbarray(k);
end
disp(['Orbitals mapped: ',num2str(rangetotal)]);
l=size(rangetotal);
l=l(2);
H_new=phi_combined'*H_total*phi_combined;
[phi_combined2,E_combined2]=sort_eig(H_new);
phi_combined=phi_combined*phi_combined2;
H_isolobal=phi_combined*diag(E_combined2)*phi_combined';
H_translation=psi'*H_isolobal*psi;
[psi_translation,~]=sort_eig(H_translation);
psi_final=psi*psi_translation;
disp('Made psi_final.');


overlap2=psi_final(:,occupiedstates-l+1:occupiedstates)'*phi_combined(:,1:l);
for i=1:l
overlap2(i,:)=overlap2(i,:)/sqrt(overlap2(i,:)*overlap2(i,:)');
end
psi_new=zeros(orbnum,l);
for i=1:l
for j=1:l
psi_new(:,i)=psi_new(:,i)+overlap2(j,i)*psi_final(:,occupiedstates-l+j);
end
end
psi_final(:,occupiedstates-l+1:occupiedstates)=psi_new;


orbvect=hueckelarray0(xpos);

size(psi_final)
psi_pic=zeros(sum(orbvect),occupiedstates);

count=0;
psi_remainder=psi_final;
for i=xpos';
    psi_pic(count+1:count+hueckelarray0(i),:)=psi_final(sum(hueckelarray0(1:i-1))+1:sum(hueckelarray0(1:i)),:);
    count=count+hueckelarray0(i);
end
size(psi_final)
if recombine==1
  psi_recombine=psi_final(:,1:numleftover);
  [psi_temp,~]=sort_eig(psi_recombine'*psi_recombine);
  psi_final=psi_recombine*psi_temp;
  for i=1:numleftover
    psi_final(:,i)=psi_final(:,i)/(sqrt(psi_final(:,i)'*psi_final(:,i)));
  end
  psi_recombine=psi_final;
  phi_combined=zeros(orbnum,orbnum);
  count=0;
for k=remainderatoms
  m=xpos1(k);
  range=sum(hueckelarray0(1:m-1))+1:sum(hueckelarray0(1:m));
  range=range(logical(maporbital{strcmpi(elemname1(k),maporbital(:,1)),2}));
  rangetotal(count+1:count+orbarray1(k))=range;
  count=count+orbarray1(k);
end
  H_new=zeros(orbnum,orbnum);
  H_new(rangetotal,rangetotal)=H_total(rangetotal,rangetotal);
  [phi_combined,~]=sort_eig(H_new);
  phi_combined=phi_combined(:,1:size(rangetotal));
  H_translation=psi_recombine'*H_new*psi_recombine;
  [psi_translation,E_translation]=sort_eig(H_translation);
  psi_final=psi_recombine*psi_translation;
for i=1:numleftover
    psi_final(:,i)=psi_final(:,i)/(sqrt(psi_final(:,i)'*psi_final(:,i)));
end

orbvect=hueckelarray0(xpos1);
psi_pic=zeros(sum(orbvect),numleftover);
count=0;
for i=xpos1'
size(psi_pic)
size(psi_final)
    psi_pic(count+1:count+hueckelarray0(i),:)=psi_final(sum(hueckelarray0(1:i-1))+1:sum(hueckelarray0(1:i)),:);
    count=count+hueckelarray0(i);
end
numleftover
  occupiedstates=numleftover;
end

for i=occupiedstates-nprintorb+1:occupiedstates;
ptarget(i,:)=psi_final(:,i)'*phi_combined;
end
ptarget=ptarget*ptarget';
ptarget(occupiedstates-nprintorb+1:occupiedstates,occupiedstates-nprintorb+1:occupiedstates);
pfrag=psi_pic(:,occupiedstates-nprintorb+1:occupiedstates)'*psi_pic(:,occupiedstates-nprintorb+1:occupiedstates);

j=occupiedstates-nprintorb+1;
if strcmpi(displaytext,'on') strarray=['MO',int2str(j),': E= ',num2str(psi_final(:,j)'*H_total*psi_final(:,j)),' eV  ',' Ptarget= ', num2str(ptarget(j,j)), ' Pfrag= ', num2str(pfrag(j-occupiedstates+nprintorb,j-occupiedstates+nprintorb))]; else strarray=' '; end
currfig=figuretool({'setdefault','template',basis,'figurename',[picturename,'-raMO',int2str(j)],'printmode',printmode},...
   {'drawraMO',basis,supercell,lobescale,orbvect,psi_pic(:,j),'O','on','OC',[1,1,1],'OW',0.03,'LC',[100/255 200/255 255/255 100/255 190/255 72/255],'LP','default','LA',0.9},{'bottomtext',strarray}); %0.2 1 0.2 0.2 0.6 1
set(currfig,'Name',strarray,'NumberTitle','off');
campos0=campos(); camtarget0=camtarget(); camup0=camup(); camva0=camva();

for j=occupiedstates-nprintorb+2:occupiedstates;
    if strcmpi(displaytext,'on') strarray=['MO',int2str(j),': E= ',num2str(psi_final(:,j)'*H_total*psi_final(:,j)),' eV',' Ptarget= ', num2str(ptarget(j,j)),' Pfrag= ', num2str(pfrag(j-occupiedstates+nprintorb,j-occupiedstates+nprintorb))]; else strarray=' '; end
    currfig=figuretool({'setdefault','camparam',{'CP',campos0,'CT',camtarget0,'CU',camup0,'CVA',camva0},'template',basis,'figurename',[picturename,'-raMO',int2str(j)],...
       'printmode',printmode},{'drawraMO',basis,supercell,lobescale,orbvect,psi_pic(:,j),'O','on','OC',[1,1,1],'OW',0.03,'LC',[100/255 200/255 255/255 100/255 190/255 72/255],'LP','default','LA',0.9},{'bottomtext',strarray});
    set(currfig,'Name',strarray,'NumberTitle','off');     
end


function [vect0,eig0]=sort_eig(matrix0)
[vect0,eig0]=eig(matrix0);
[eig0,ind0]=sort(diag(eig0));
vect0=vect0(:,ind0);

function psi_pic=lcramo(orbnumlist,coeffmatrix,psi_pic)
for i=1:size(coeffmatrix,1)
    coeffmatrix(i,:)=coeffmatrix(i,:)/norm(coeffmatrix(i,:));
end
psi_pic(:,orbnumlist)=psi_pic(:,orbnumlist)*coeffmatrix';

function [psi1,psi2]=psi_mix(psi0a,psi0b,a,b)
psi1=1/sqrt(a^2+b^2)*(a*psi0a+b*psi0b);
psi2=1/sqrt(a^2+b^2)*(b*psi0a-a*psi0b);


