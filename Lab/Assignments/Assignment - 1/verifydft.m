%find convolution using dft function
clc; 
N=8; 
% a and b are two vectors whose convolution is to be computed
a=[1,2,3,4,5]; 
b=[1,2,3,4]; 
%convolution using user defined function
c=linearconv(a,b); 
Ak=dft(a,N); 
Bk=dft(b,N); 
Ck=Ak.*Bk; 
%convolution by idft of pointwise multiplied DFT sequences
conSeq=(1/N).*(conj(dft(conj(Ck),N))); 
disp('Convolution using linearconv function:'); 
disp(c); 
disp('Convolution using dft function:'); 
disp(conSeq); 