function [output]=dft(x,N) 
%initialise ouput vector to N zeros
output= zeros(1,N); 
%constant factor in dft equation pre-computed
b= -1i*2*pi/N; 
lx=length(x); 
for k=1:N 
 output(k)=0; 
 for n=0:lx-1 
 output(k)=output(k)+x(n+1)*exp(b*(k-1)*n); 
 end
end
