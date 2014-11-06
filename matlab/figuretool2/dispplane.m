function dispstr=dispplane(valstr)
if (numel(valstr)<6)||(~strcmp(valstr([2,5,6]),''''',')) dispstr=['best fit plane through atom group ''',valstr(2:end-1),''''];
elseif strcmp(valstr(3),'3')
   dispabbr=struct('a','atoms','r','Cartesian coordinates','c','direct coordinates');
   temp=regexp(valstr,'[{}\[\],]','split');
   if strcmp(valstr(4),'a')
      c2str=temp{3}; c3str=temp{4}; c4str=temp{5};
   else
      c2str=['[',temp{4},',',temp{5},',',temp{6},']'];
      c3str=['[',temp{9},',',temp{10},',',temp{11},']'];
      c4str=['[',temp{14},',',temp{15},',',temp{16},']'];
   end
   dispstr=['plane through ',dispabbr.(valstr(4)),' ',c2str,',',c3str,' and ',c4str];
elseif strcmp(valstr(3),'e')
   dispabbr=struct('a','atoms','r','Cartesian coordinates','c','direct coordinates');
   temp=regexp(valstr,'[\[\],]','split');
   xr=str2double(temp{3});
   yr=str2double(temp{4});
   zr=str2double(temp{5});
   cr=str2double(temp{6});
   if xr==0 xstr='';
   elseif xr==1 xstr='+x';
   elseif xr==-1 xstr='-x';
   elseif xr>0 xstr=['+',num2str(xr),'x'];
   elseif xr<0 xstr=[num2str(xr),'x'];
   end
   if yr==0 ystr='';
   elseif yr==1 ystr='+y';
   elseif yr==-1 ystr='-y';
   elseif yr>0 ystr=['+',num2str(yr),'y'];
   elseif yr<0 ystr=[num2str(yr),'y'];
   end
   if zr==0 zstr='';
   elseif zr==1 zstr='+z';
   elseif zr==-1 zstr='-z';
   elseif zr>0 zstr=['+',num2str(zr),'z'];
   elseif zr<0 zstr=[num2str(zr),'z'];
   end
   if cr==0 cstr='';
   elseif cr>0 cstr=['+',num2str(cr)];
   elseif cr<0 cstr=num2str(cr);
   end
   eqstr=[xstr,ystr,zstr,cstr,'=0']; if strcmpi(eqstr(1),'+') eqstr=eqstr(2:end); end
   dispstr=['plane ',eqstr,' in ',dispabbr.(valstr(4))];
elseif strcmp(valstr(4),'m')
   dispabbr=struct('a','atom','r','Cartesian coordinates','c','direct coordinates');
   temp=regexp(valstr,'[\[\],]','split');
   if strcmp(valstr(3),'a')
      c2str=temp{2};
      c3str=['(',temp{4},',',temp{5},',',temp{6},')'];
   else
      c2str=['[',temp{3},',',temp{4},',',temp{5},']'];
      c3str=['(',temp{8},',',temp{9},',',temp{10},')'];
   end
   dispstr=['Miller plane ',c3str,' through ',dispabbr.(valstr(3)),' ',c2str];
else
   dispabbr=struct('a','atom','r','Cartesian coordinates','c','direct coordinates');
   temp=regexp(valstr,'[\[\],]','split');
   if strcmp(valstr(3),'a')
      c2str=temp{2};
      c3str=['[',temp{4},',',temp{5},',',temp{6},']'];
   else
      c2str=['[',temp{3},',',temp{4},',',temp{5},']'];
      c3str=['[',temp{8},',',temp{9},',',temp{10},']'];
   end
   dispstr=['plane through ',dispabbr.(valstr(3)),' ',c2str,' and normal to ',dispabbr.(valstr(4)),' ',c3str];
end
