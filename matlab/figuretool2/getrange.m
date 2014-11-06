function rngout=getrange(ir,jr,rangeref,num)
global spdmin spdmax;
rngout=zeros(numel(ir),numel(jr),2);
if ~ischar(rangeref)
   rngout(:,:,1)=rangeref(1);rngout(:,:,2)=rangeref(2);
else
   if strcmpi(rangeref,'default')
      rngout(:,:,1)=spdmin(ir,jr);
      rngout(:,:,2)=spdmax(ir,jr);
   end
end
if nargin==4
   rngout=rngout(:,:,num);
end
