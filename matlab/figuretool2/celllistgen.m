function celllistgen()
global coordtype unitcell xyzlist elemnolist unitcelllist unitcellset;
if isequal(size(unitcell),[3,3])&&(abs(det(unitcell)>1E-6))
   if strcmpi(coordtype,'Cartesian') xyzuse=xyzlist/unitcell; else xyzuse=xyzlist; end
   unitcelllist=(xyzuse(:,1)>-0.001)&(xyzuse(:,1)<0.999)&(xyzuse(:,2)>-0.001)&(xyzuse(:,2)<0.999)&(xyzuse(:,3)>-0.001)&(xyzuse(:,3)<0.999);
   temp=find(elemnolist>0);
   xyzuse=xyzuse(elemnolist>2,:);
   xyzuse=(xyzuse-floor(xyzuse))*unitcell;
   idist=sum(bsxfun(@minus,permute(xyzuse,[1,3,2]),permute(xyzuse,[3,1,2])).^2,3)<0.01;
   idist=triu(idist,1);
   unitcellset=temp(~any(idist));
end


