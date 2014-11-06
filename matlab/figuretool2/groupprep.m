function [errmsg,status]=groupprep()
global grouplist grouparray atomlist elemlist;
errmsg=''; status=0;
groupref=cell(size(grouplist,1),1);
grouparray=cell(size(grouplist,1),1);
dmatrix=zeros(size(grouplist,1));
if any(cellfun(@isempty,grouplist(:,2))) errmsg='Please make sure that all group expressions are non-empty.'; status=1; return; end
if any(ismember(upper(grouplist(:,1)),upper(atomlist)))||any(ismember(upper(grouplist(:,1)),upper(elemlist)))
   errmsg='Site or element names cannot be used as group names.'; status=1; return;
end
for j=1:size(grouplist,1)
   [~,reflistout,~]=siterefparser(grouplist{j,2}); groupref{j}=reflistout;
   templist=regexp(grouplist{j,2},'[,()|&~<>]','split');
   dmatrix(:,j)=ismember(upper(grouplist(:,1)),upper(templist));
end
try
   dorder=graphtopoorder(sparse(dmatrix));
catch err 
   if strcmpi(err.identifier,'bioinfo:graphalgsmex:TopoSortAlgorithmError')
      errmsg='Cyclic interdependency is detected in the specified groups.'; status=1; return;
   end
end
for j=1:numel(dorder)
   [grouparray{dorder(j)},errstrout]=sitetrans(groupref{dorder(j)});
   if ~isempty(errstrout) errmsg=['Error analyzing group ',grouplist{dorder(j),1},':\n',errstrout]; status=1; return; end
end

