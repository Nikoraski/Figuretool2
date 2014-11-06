function makeramo
centralatoms=[1,2];                                              %Atoms to be used as central atoms, as in the template file.
atomhueckel=135;                                                 %Number of atoms used in Hueckel input file.
filename='Ni2Al3_supercell';                                     %Name of YAeHMOP output file.
template='Ni2Al3.prn';                                           %Name of template file.
maporbital={'Ni',[1,1,1,1,1,1,1,1,1];'Al',[1,1,1,1,0,0,0,0,0];}; %Atomic orbitals to map ([s,px,py,pz,dx2-y2,dz2,dxy,dxz,dyz]).
lobescale=3;                                                     %Scale of raMO lobes.
nprintorb=8;                                                     %Number of raMO orbitals to be drawn.
displaytext='on';                                                %Display raMO orbital and energy information in the figure.
printmode=0;                                                     %Printing mode: 0=display in a window, positive integer = display and print as png with specified
                                                                 %resolution, negative integer = print as png without display.

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
    [~,linenumstr]=system(['grep -n -m 1 "Hamiltonian" ',filename,'.out']);
    temp=regexpi(linenumstr,':','split');
    linenumber=str2double(temp{1});
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
end
inID=fopen([filename,'.out']);
H_total=zeros(orbnum);
temp2=textscan(inID,'%s %s %s %f %f %f',orbnum,'headerlines',linenumber+1);
H_total(:,1:3)=[temp2{4:6}];
for i=2:floor((orbnum-1)/3)
   temp2=textscan(inID,'%s %s %s %f %f %f',orbnum,'headerlines',2);
   H_total(:,3*i-2:3*i)=[temp2{4:6}];
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
temp3=textscan(inID,'%f %f',3,'headerlines',8);
supercell=supercell(temp3{2}-temp3{1},:);
disp('supercell vectors in Hueckel input file:');
disp(supercell);
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
[psi,E_MO]=sort_eig(H_total);
occupiedstates=find(E_MO<fermi+0.001,1,'last');
psi=psi(:,1:occupiedstates);
disp('Made psi.');
TME={'SC','TI','V','CR','MN','FE','CO','NI','CU','Y','ZR','NB','MO','TC','RU','RH','PD','AG','LU','HF','TA','W','RE','OS','IR','PT','AU',...
    'LA','CE','PR','ND','PM','SM','EU','GD','TB','DY','HO','ER','TM','YB'};
hueckelarray0=ismember(upper(hueckellist),TME)*5-strcmpi('H',hueckellist)*3+4;
orbarray=cellfun(@(x) sum(maporbital{strcmpi(x,maporbital(:,1)),2}),elemname);
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
H_isolobal=phi_combined*diag(E_combined)*phi_combined';
H_translation=psi'*H_isolobal*psi;
[psi_translation,~]=sort_eig(H_translation);
psi_final=psi*psi_translation;
disp('Made psi_final.');
orbvect=hueckelarray0(xpos);
psi_pic=zeros(sum(orbvect),occupiedstates);
count=0;
for i=xpos'
    psi_pic(count+1:count+hueckelarray0(i),:)=psi_final(sum(hueckelarray0(1:i-1))+1:sum(hueckelarray0(1:i)),:);
    count=count+hueckelarray0(i);
end

%{
%For leftover states only (Need to recombine)
numleftover=10; %Number of leftover states
[psi_temp,E]=sort_eig(psi_final'*psi_final);
psi_leftover=psi_final(:,1:numleftover)*psi_temp(1:numleftover,1:numleftover);
for i=1:numleftover
    psi_leftover(:,i)=psi_leftover(:,i)/norm(psi_leftover(:,i));
end
psi_pic=psi_leftover;
%}

%psi_pic=lcramo([120,121],[1,1;1,-1],psi_pic);  %Linear combination of raMO; rows of the matrix correspond to coefficients for the new orbitals.

j=occupiedstates-nprintorb+1;
if strcmpi(displaytext,'on') strarray=['MO',int2str(j),': E= ',num2str(psi_final(:,j)'*H_total*psi_final(:,j)),' eV']; else strarray=' '; end
currfig=figuretool({'setdefault','template',template,'figurename',[template,'-MO',int2str(j)],'printmode',printmode},...
   {'drawraMO',template,supercell,lobescale,orbvect,psi_pic(:,j),'O','off','OC',[1,1,1],'OW',0.05,'LC',[0.35,1,0.35,0.39,0.74,1],'LP',[0.8,0.6,0.15,1.0],'LA',1},{'bottomtext',strarray});
set(currfig,'Name',strarray,'NumberTitle','off');
campos0=campos(); camtarget0=camtarget(); camup0=camup(); camva0=camva();

for j=occupiedstates-nprintorb+2:occupiedstates
    if strcmpi(displaytext,'on') strarray=['MO',int2str(j),': E= ',num2str(psi_final(:,j)'*H_total*psi_final(:,j)),' eV']; else strarray=' '; end
    currfig=figuretool({'setdefault','camparam',{'CP',campos0,'CT',camtarget0,'CU',camup0,'CVA',camva0},'template',template,'figurename',[template,'-MO',int2str(j)],...
       'printmode',printmode},{'drawraMO',template,supercell,lobescale,orbvect,psi_pic(:,j),'O','off','OC',[1,1,1],'OW',0.05,'LC',[0.35,1,0.35,0.39,0.74,1],'LP',[0.8,0.6,0.15,1.0],'LA',1},{'bottomtext',strarray});
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








