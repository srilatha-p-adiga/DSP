
function [output]= linearconv(a,b) 
l1=length(a); 
l2=length(b); 
lo=l1+l2-1; 
output=zeros(1,lo); %initialise output vector to m+n-1 zeros
for n=1:lo 
 sum=0; 
 for k=1:l1 
 if(n-k+1>0 && n-k+1<=l2) 
 sum=sum+a(k)*b(n-k+1); 
 end
 end
 output(n)=sum; 
end
