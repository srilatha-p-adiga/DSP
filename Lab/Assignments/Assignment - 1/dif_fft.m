%dft using DIF-FFT
clc; 
x =[1,-1,-1,-1,1,1,1,-1]; 
N =8; 
Xk=fft(x); 
p=log2(N); 
Half=N/2; 
for stage=1:p %process input vector stage by stage and write back to it 
 for index=0:(N/(2^(stage-1))):(N-1) 
 for n=0:(Half-1) 
 pos=n+index+1; 
 pow=(2^(stage-1))*n; 
 w=exp((-1i)*(2*pi)*pow/N); %twiddle factors 
 a=x(pos)+x(pos+Half); %butterfly addition
 b=(x(pos)-x(pos+Half)).*w; %butterfly subtraction
 x(pos)=a; 
 x(pos+Half)=b; 
 end
 end
Half=Half/2; 
end
y=bitrevorder(x); %inbuilt function to bit reverse the indices
disp('FFT computed using inbuilt function'); 
disp(Xk); 
disp('FFT computed using program'); 
disp(y); 