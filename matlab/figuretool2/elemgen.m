function elemgen()
global atomlist elemlist elemname elemnolist unitcelllist unitcellset xyzlist coordtype unitcell;
elemlist=cell(size(atomlist)); elemnolist=zeros(size(atomlist));
for j=1:numel(elemlist)
   str=atomlist{j};
   temp=regexp(str,'[A-z][0-9]');
   if numel(temp)==0
      if all(isletter(str)) elemlist{j}=str;
      else elemlist{j}='Un';
      end
   elseif numel(temp)==1
      if all(isletter(str(1:temp)))&&all(ismember(str(temp+1:end),'0123456789'))
         elemlist{j}=str(1:temp);
      elseif all(isletter(str(1:temp)))&&all(ismember(str(temp+1:end-1),'0123456789'))&&~isempty(regexp(str(end),'[a-z]','once'))
         elemlist{j}=str(1:temp);
      else elemlist{j}='Un';
      end
   else elemlist{j}='Un';
   end
   temp=find(strcmpi(elemlist{j},elemname),1);
   if isempty(temp) elemnolist(j)=-100; else elemnolist(j)=temp-2; end
end
celllistgen();

