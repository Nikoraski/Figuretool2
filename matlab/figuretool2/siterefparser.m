function [stackout,reflistout,status]=siterefparser(siterefin)
global elemlist atomlist xyzlist grouplist;
status=1;
if isempty(siterefin)
   stackout='BS'; reflistout={}; return;
end
elemlist0=upper(unique(elemlist));
sitelist=upper(unique(atomlist));
if ~isempty(grouplist) grouplist0=upper(grouplist(:,1)); else grouplist0={}; end
lab=('<'==siterefin); rab=('>'==siterefin); lsb=('['==siterefin); rsb=(']'==siterefin); lcb=('{'==siterefin); rcb=('}'==siterefin);
isdelim=ismember(num2cell(siterefin),{')','&','|','~'});
lplist=find('('==siterefin);
islp=false(size(siterefin));
for j=lplist
   if isdelim(j-1)||strcmpi(siterefin(j-1),'(') islp(j)=true; end
end
commalist=find(','==siterefin);
iscomma=false(size(siterefin));
for j=commalist
   if (sum(lab(1:j-1))==sum(rab(1:j-1)))&&(sum(lsb(1:j-1))==sum(rsb(1:j-1))) iscomma(j)=true; end
end
delimtemp=find(isdelim|islp|iscomma);
delimlist=false(size(siterefin));
for j=delimtemp
   if (sum(lcb(1:j-1))==sum(rcb(1:j-1))) delimlist(j)=true; end
end
delimlist=[0,find(delimlist),numel(siterefin)+1];
reflistout={}; stackout='BS'; gotonext=0;
for j=1:numel(delimlist)-1
   if gotonext>0 gotonext=gotonext-1; continue; end
   if j~=1
      switch siterefin(delimlist(j))
         case '&'
            if ismember(stackout(end),{'B','C','P'})
               reflistout=[reflistout;{'and','&'}]; stackout=[stackout,'S'];
            else status=0; return;
            end
         case '|'
            if ismember(stackout(end),{'B','C','P'})
               reflistout=[reflistout;{'or','|'}]; stackout=[stackout,'S'];
            else status=0; return;
            end
         case '~'
            if strcmp(stackout(end),'S')
               reflistout=[reflistout;{'not','~'}];
            else status=0; return;
            end
         case ')'
            if strcmpi(stackout(end),'P')
               reflistout=[reflistout;{'rp',')'}]; stackout=stackout(1:end-1);
            else status=0; return;
            end
         case '('
            if strcmp(stackout(end),'S')
               reflistout=[reflistout;{'lp','('}]; stackout=[stackout(1:end-1),'PS'];
            else status=0; return;
            end
         case ','
            if strcmp(stackout(end),'C')
               reflistout=[reflistout;{'comma',','}]; stackout=stackout(1:end-1);
            else status=0; return;
            end
      end
   end
   currstr=siterefin(delimlist(j)+1:delimlist(j+1)-1);
   continued=1;
   while continued==1
      continued=0;
      if isempty(currstr) continue; end
      if ~isempty(str2num(currstr))
         if strcmp(stackout(end),'S')
            reflistout=[reflistout;{'list',currstr}]; stackout=stackout(1:end-1); continue;
         else status=0; return;
         end
      end
      if ~isempty(atomlist)
         if ismember(upper(currstr),elemlist0)||ismember(upper(currstr),sitelist)
            if strcmp(stackout(end),'S')
               reflistout=[reflistout;{'site',currstr}]; stackout=stackout(1:end-1); continue;
            else status=0; return;
            end
         end
      end
      if ismember(upper(currstr),grouplist0)
         if strcmp(stackout(end),'S')
            reflistout=[reflistout;{'group',currstr}]; stackout=stackout(1:end-1); continue;
         else status=0; return;
         end
      end
      if strcmpi(currstr,'all')
         if strcmp(stackout(end),'S')
            reflistout=[reflistout;{'all','all'}]; stackout=stackout(1:end-1); continue;
         else status=0; return;
         end
      end
      if strcmpi(currstr,'bonded')
         if strcmp(stackout(end),'S')
            reflistout=[reflistout;{'bonded','bonded'}]; stackout=stackout(1:end-1); continue;
         else status=0; return;
         end
      end
      if strcmpi(currstr,'used')
         if strcmp(stackout(end),'S')
            reflistout=[reflistout;{'used','used'}]; stackout=stackout(1:end-1); continue;
         else status=0; return;
         end
      end
      if strcmpi(currstr,'unitcell')
         if strcmp(stackout(end),'S')
            reflistout=[reflistout;{'unitcell','unitcell'}]; stackout=stackout(1:end-1); continue;
         else status=0; return;
         end
      end
      if strncmpi(currstr,'coord<',6)
         if ~strcmp(stackout(end),'S') status=0; return; end
         ltemp=findstr('>',currstr); if isempty(ltemp) status=0; return; end
         rng=currstr(7:ltemp(1)-1);
         if ~strcmpi(rng,'default')
            temp=regexp(rng,',','split');
            if (numel(temp)~=2)||isnan(str2double(temp{1}))||isnan(str2double(temp{2}))||(str2double(temp{1})<0)||...
                  (str2double(temp{1})>=str2double(temp{2})) status=0; return; end
         end
         if ~strcmp(currstr(ltemp+1),'(') status=0; return; end
         reflistout=[reflistout;{'coord',currstr(1:ltemp+1)}]; stackout=[stackout(1:end-1),'PSCS'];
         currstr=currstr(ltemp+2:end); continued=1; continue;
      end
      if strncmpi(currstr,'getmol<',7)
         if ~strcmp(stackout(end),'S') status=0; return; end
         ltemp=findstr('>',currstr); if isempty(ltemp) status=0; return; end
         rng=currstr(8:ltemp(1)-1);
         if ~strcmpi(rng,'default')
            temp=regexp(rng,',','split');
            if (numel(temp)~=2)||isnan(str2double(temp{1}))||isnan(str2double(temp{2}))||(str2double(temp{1})<0)||...
                  (str2double(temp{1})>=str2double(temp{2})) status=0; return; end
         end
         if ~strcmp(currstr(ltemp+1),'(') status=0; return; end
         reflistout=[reflistout;{'getmol',currstr(1:ltemp+1)}]; stackout=[stackout(1:end-1),'PSCS'];
         currstr=currstr(ltemp+2:end); continued=1; continue;
      end
      if strncmpi(currstr,'convhull(',9)
         if strcmp(stackout(end),'S')
            reflistout=[reflistout;{'convhull','convhull('}]; stackout=[stackout(1:end-1),'PS'];
            currstr=currstr(10:end); continued=1; continue;
         else status=0; return;
         end
      end
      if strncmpi(currstr,'box<',4)
         if ~strcmp(stackout(end),'S') status=0; return; end
         temp=findstr('>',currstr); if isempty(temp) status=0; return; end
         rng=currstr(5:temp(1)-1);
         if ~ismember(upper(rng),{'R,C','C,R','C,C','R,R'})||~strcmp(currstr(temp+1),'(') status=0; return; end
         set1=str2num(currstr(temp+2:end)); if numel(set1)~=3 status=0; return; end
         if (j>=numel(delimlist)-2)||~strcmp(siterefin(delimlist(j+1)),',')||~strcmp(siterefin(delimlist(j+2)),')') status=0; return; end
         set2=str2num(siterefin(delimlist(j+1)+1:delimlist(j+2)-1));
         if (numel(set2)~=3)||(set2(1)<=0)||(set2(2)<=0)||(set2(3)<=0) status=0; return; end
         reflistout=[reflistout;{'getbox',siterefin(delimlist(j)+1:delimlist(j+2))}]; stackout=stackout(1:end-1);
         gotonext=2; continue;
      end
      if strncmpi(currstr,'sphere<',7)
         if ~strcmp(stackout(end),'S') status=0; return; end
         temp=findstr('>',currstr); if isempty(temp) status=0; return; end
         rng=currstr(8:temp(1)-1);
         if ~ismember(upper(rng),{'R','C'})||~strcmp(currstr(temp+1),'(') status=0; return; end
         set1=str2num(currstr(temp+2:end)); if numel(set1)~=3 status=0; return; end
         if (j>=numel(delimlist)-2)||~strcmp(siterefin(delimlist(j+1)),',')||~strcmp(siterefin(delimlist(j+2)),')') status=0; return; end
         set2=str2num(siterefin(delimlist(j+1)+1:delimlist(j+2)-1));
         if (numel(set2)~=1)||(set2<=0) status=0; return; end
         reflistout=[reflistout;{'getsphere',siterefin(delimlist(j)+1:delimlist(j+2))}]; stackout=stackout(1:end-1);
         gotonext=2; continue;
      end
      if strncmpi(currstr,'slab({',6)
         if ~strcmp(stackout(end),'S') status=0; return; end
         if ~strcmp(currstr(end),'}') status=0; return; end
         if (j>=numel(delimlist)-2)||~strcmp(siterefin(delimlist(j+1)),',')||~strcmp(siterefin(delimlist(j+2)),')') status=0; return; end
         set2=str2num(siterefin(delimlist(j+1)+1:delimlist(j+2)-1));
         if (numel(set2)~=1)||(set2<=0) status=0; return; end
         valstr=currstr(7:end-1); if isempty(valstr) status=0; return; end
         if (numel(valstr)>5)&&ismember(upper(valstr(1:5)),{'''AM'',','''CM'',','''RM'',','''AC'',','''CC'',','''RC'',','''AR'',','''CR'',','''RR'',',...
               '''3A'',','''3C'',','''3R'',','''EC'',','''ER'','})
            valstr0=valstr(6:end);
            switch upper(valstr(1:5))
               case {'''AM'',','''AC'',','''AR'','}
                  temp=regexp(valstr0,',','split');
                  if any(cellfun(@isempty,temp)) status=0; return; end
                  if (numel(temp)~=4)||~strcmp(temp{2}(1),'[')||~strcmp(temp{4}(end),']') status=0; return; end
                  natom=str2double(temp{1}); x=str2double(temp{2}(2:end)); y=str2double(temp{3}); z=str2double(temp{4}(1:end-1));
                  if isnan(natom)||(natom~=round(natom))||(natom<1)||(natom>numel(atomlist)) status=0; return; end
                  if any(isnan([x,y,z]))||(norm([x,y,z])<1E-6) status=0; return; end
               case {'''CM'',','''CC'',','''CR'',','''RM'',','''RC'',','''RR'','}
                  temp=regexp(valstr0,',','split');
                  if any(cellfun(@isempty,temp)) status=0; return; end
                  if (numel(temp)~=6)||~strcmp(temp{1}(1),'[')||~strcmp(temp{3}(end),']')||~strcmp(temp{4}(1),'[')||~strcmp(temp{6}(end),']') status=0; return; end
                  x1=str2double(temp{1}(2:end)); y1=str2double(temp{2}); z1=str2double(temp{3}(1:end-1));
                  x2=str2double(temp{4}(2:end)); y2=str2double(temp{5}); z2=str2double(temp{6}(1:end-1));
                  if any(isnan([x1,y1,z1,x2,y2,z2]))||(norm([x2,y2,z2])<1E-6) status=0; return; end
               case '''3A'','
                  temp=regexp(valstr0,',','split'); if any(cellfun(@isempty,temp))||(numel(temp~=4)) status=0; return; end
                  natom=[str2double(temp{1}),str2double(temp{2}),str2double(temp{3})];
                  if any(isnan(natom))||~isequal(natom,round(natom))||any(natom<1)||any(natom>numel(atomlist)) status=0; return; end
                  if norm(cross(xyzlist(natom(2),:)-xyzlist(natom(1),:),xyzlist(natom(3),:)-xyzlist(natom(1),:)))<1E-3 status=0; return; end
               case {'''3C'',','''3R'','}
                  temp=regexp(valstr0,',','split'); if any(cellfun(@isempty,temp)) status=0; return; end
                  if (numel(temp)~=9)||~strcmp(temp{1}(1),'[')||~strcmp(temp{3}(end),']')||~strcmp(temp{4}(1),'[')...
                        ||~strcmp(temp{6}(end),']')||~strcmp(temp{7}(1),'[')||~strcmp(temp{9}(end),']') status=0; return; end
                                    x1=str2double(temp{1}(2:end)); y1=str2double(temp{2}); z1=str2double(temp{3}(1:end-1));
                  x2=str2double(temp{4}(2:end)); y2=str2double(temp{5}); z2=str2double(temp{6}(1:end-1));
                  x3=str2double(temp{7}(2:end)); y3=str2double(temp{8}); z3=str2double(temp{9}(1:end-1));
                  if any(isnan([x1,y1,z1,x2,y2,z2,x3,y3,z3])) status=0; return; end
                  if norm(cross([x2-x1,y2-y1,z2-z1],[x3-x1,y3-y1,z3-z1]))<1E-3 status=0; return; end
               case {'''EC'',','''ER'','}
                  temp=regexp(valstr0,',','split'); if any(cellfun(@isempty,temp)) status=0; return; end
                  if (numel(temp)~=4)||~strcmp(temp{1}(1),'[')||~strcmp(temp{4}(end),']') status=0; return; end
                  x1=str2double(temp{1}(2:end)); y1=str2double(temp{2}); z1=str2double(temp{3}); c1=str2double(temp{4}(1:end-1));
                  if any(isnan([x1,y1,z1,c1]))||(norm([x1,y1,z1])<1E-6) status=0; return; end
            end
         else
            [stackout1,~,status1]=siterefparser(valstr);
            if (status1==0)||~strcmpi(stackout1,'B') status=0; return; end
         end
         reflistout=[reflistout;{'getslab',siterefin(delimlist(j)+1:delimlist(j+2))}]; stackout=stackout(1:end-1);
         gotonext=2; continue;
      end
      status=0; return;
   end
end

