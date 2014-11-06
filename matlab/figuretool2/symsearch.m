function [dataout,strout]=symsearch(datain,n)
if nargin==1 n=0; end
a=norm(datain(1,:)); b=norm(datain(2,:)); c=norm(datain(3,:));
alpha=acosd(dot(datain(2,:),datain(3,:))/(b*c)); beta=acosd(dot(datain(1,:),datain(3,:))/(a*c)); gamma=acosd(dot(datain(1,:),datain(2,:))/(a*b)); 
if (abs(alpha-90)<2E-2)&&(abs(beta-90)<2E-2)&&(abs(gamma-90)<2E-2)
   if (abs(a-b)<2E-4)&&(abs(a-c)<2E-4)&&(abs(b-c)<2E-4)
      dataout=[a,0,0;0,a,0;0,0,a]; strout='cP'; return;
   elseif (abs(a-b)>2E-4)&&(abs(a-c)>2E-4)&&(abs(b-c)>2E-4)
      dataout=[a,0,0;0,b,0;0,0,c]; strout='oP'; return;
   else strout='tP';
      if abs(a-b)<2E-4 dataout=[a,0,0;0,a,0;0,0,c];
      elseif abs(a-c)<2E-4 dataout=[a,0,0;0,a,0;0,0,b];
      else dataout=[b,0,0;0,b,0;0,0,a];
      end
      return;
   end
elseif (abs(alpha-90)<2E-2)&&(abs(beta-90)<2E-2)&&(abs(gamma-120)<2E-2)&&(abs(a-b)<2E-4)
   strout='hP'; dataout=[a,0,0;-a/2,a*sqrt(3)/2,0;0,0,c]; return;
elseif (abs(alpha-90)<2E-2)&&(abs(beta-120)<2E-2)&&(abs(gamma-90)<2E-2)&&(abs(a-c)<2E-4)
   strout='hP'; dataout=[a,0,0;-a/2,a*sqrt(3)/2,0;0,0,b]; return;
elseif (abs(alpha-120)<2E-2)&&(abs(beta-90)<2E-2)&&(abs(gamma-90)<2E-2)&&(abs(b-c)<2E-4)
   strout='hP'; dataout=[b,0,0;-b/2,b*sqrt(3)/2,0;0,0,a]; return; 
elseif (abs(a-b)<2E-4)&&(abs(a-c)<2E-4)&&(abs(b-c)<2E-4)&&(abs(alpha-beta)<2E-2)&&(abs(beta-gamma)<2E-2)&&(abs(gamma-alpha)<2E-2)
   if abs(alpha-60)<2E-2 k=a/sqrt(2); dataout=[0,k,k;k,0,k;k,k,0]; strout='cF'; return;
   elseif abs(alpha-109.47)<2E-2 k=a/sqrt(3); dataout=[-k,k,k;k,-k,k;k,k,-k]; strout='cI'; return;
   else h=norm(sum(datain,1))/3;k=sqrt(a^2-h^2);
      dataout=[k*sqrt(3)/2,k/2,h;-k*sqrt(3)/2,k/2,h;0,-k,h]; strout='hR'; return;
   end
elseif (abs(alpha-90)<2E-2)&&(abs(beta-90)<2E-2)&&(abs(gamma-90)>2E-2)&&(abs(a-b)>2E-4)
   strout='mP'; dataout=[a,0,0;b*cosd(gamma),b*sind(gamma),0;0,0,c]; return;
elseif (abs(alpha-90)<2E-2)&&(abs(beta-90)>2E-2)&&(abs(gamma-90)<2E-2)&&(abs(a-c)>2E-4)
   strout='mP'; dataout=[a,0,0;0,b,0;c*cosd(beta),0,c*sind(beta)]; return;
elseif (abs(alpha-90)>2E-2)&&(abs(beta-90)<2E-2)&&(abs(gamma-90)<2E-2)&&(abs(b-c)>2E-4)
   strout='mP'; dataout=[a,0,0;0,b,0;0,c*cosd(alpha),c*sind(alpha)]; return;
else
   if n==1 strout='aP'; dataout=datain; return;
   else
      [dataout1,strout1]=symsearch([0,1,1;1,0,1;1,1,0]*datain,1);
      if strcmpi(strout1,'tP') strout='tI'; 
         a=dataout1(1,1)/2; c=dataout1(3,3)/2; dataout=[-a,a,c;a,-a,c;a,a,-c]; return;
      elseif strcmpi(strout1,'oP') strout='oI'; dataout=[-0.5,0.5,0.5;0.5,-0.5,0.5;0.5,0.5,-0.5]*dataout1; return;
      end
      [dataout1,strout1]=symsearch([-1,1,1;1,-1,1;1,1,-1]*datain,1);
      if strcmpi(strout1,'oP') strout='oF'; dataout=[0,0.5,0.5;0.5,0,0.5;0.5,0.5,0]*dataout1; return; end
      [dataout1,strout1]=symsearch([1,0,0;0,1,-1;0,1,1]*datain,1);
      if strcmpi(strout1,'oP') strout='oA'; dataout=[1,0,0;0,0.5,0.5;0,-0.5,0.5]*dataout1; return;
      elseif strcmpi(strout1,'mP') strout='mA'; dataout=[1,0,0;0,0.5,0.5;0,-0.5,0.5]*dataout1; return;
      end
      [dataout1,strout1]=symsearch([1,0,-1;0,1,0;1,0,1]*datain,1);
      if strcmpi(strout1,'oP') strout='oB'; dataout=[0.5,0,0.5;0,1,0;-0.5,0,0.5]*dataout1; return;
      elseif strcmpi(strout1,'mP') strout='mB'; dataout=[0.5,0,0.5;0,1,0;-0.5,0,0.5]*dataout1; return;
      end
      [dataout1,strout1]=symsearch([1,-1,0;1,1,0;0,0,1]*datain,1);
      if strcmpi(strout1,'oP') strout='oC'; dataout=[0.5,0.5,0;-0.5,0.5,0;0,0,1]*dataout1; return;
      elseif strcmpi(strout1,'mP') strout='mC'; dataout=[0.5,0.5,0;-0.5,0.5,0;0,0,1]*dataout1; return;
      end
      strout='aP'; dataout=datain; return;
   end
end