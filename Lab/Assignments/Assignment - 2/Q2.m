%Write a Matlab program to Design a digital Butterworth filter using 
%Impulse Invariance transformation to meet the following specification 
% Ap=-1 As=-60 
% Wp=20 rad/s Ws=200 rad/s 
%Assume a sampling period be = 0.01 sec.

clc; 
clear all; 
ap=-1; 
as=-60; 
wp=20; 
ws=200; 
T=0.01; 
Fs=1/T; 

%calculate N 
N=ceil(log10((10^(-ap/10)-1)/(10^(-as/10)-1))/(2*log10(wp/ws))); 
disp("N:"); 
disp(N); 
%calculate cutoff frequency
wc=wp/((10^(-ap/10)-1)^(1/(2*N))); 
disp("Cutoff Freq:"); 
disp(wc); 

% transfer function by finding poles
sk=[] 
hs=1; 
for k=0:N-1 
 sk(k+1)=wc*exp(-1i*(2*k+1+N)*pi/(2*N)); 
 tf(abs(sk(k+1)),[1,-sk(k+1)]) 
 hs=hs*tf(abs(sk(k+1)),[1,-sk(k+1)]); 
end 
disp("poles:"); 
disp(sk); 
hs 

%frequency response of analog filter 
[num,den]=tfdata(hs,'v'); 
fre1=0:1:300; 
[resps]=freqs(num,den,fre1); 
mags=20*log10(abs(resps)); 
plot(fre1,mags); 
title('Analog Butterworth Filter Frequency Response') 
xlabel('Frequency in rad/s'); 
ylabel('Magnitude in dB.'); 
grid; 
zoom; 

%frequency response of digital filter
figure; 
[BZ,AZ]=impinvar(num,den,Fs); 
fre2=0:0.01:3; 
[respz]=freqz(BZ,AZ,fre2); 
magz=20*log10(abs(respz)); 
f2=fre2*Fs; 
plot(f2,magz); 
title('Digital Butterworth Filter Frequency Response') 
xlabel('Frequency in rad/s '); 
ylabel('Magnitude in dB.'); 
grid on; 