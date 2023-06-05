% Write a Matlab program to Design an ideal linear phase bandpass FIR filter 
% with cutoff frequencies p/6 rads and p/3 rads,
% using frequency sampling technique. Assume 25 tap coefficients
clc;

wc1=pi/6;
wc2=pi/3;
N=25;

%linear phase factor
alpha=(N-1)/2;

%dft samples indexed with k
hk=[zeros(1,N)];
k=0:1:N-1;

for i=1:N
    w=2*pi*k(i)/N;
    if(w>=wc1 && w<=wc2)
        hk(i)=exp(-1i*w*alpha);
    end
end    

%magnitude and phase of DFT samples
Hmag=abs(hk);
Hphase=phase(hk);

%comb filter
num=[1,zeros(1,N-1),-1];
den=N;
Hc=tf(num,den,0.01,'Variable','z^-1'); %assuming sampling time for input as 0.01s
disp("Comb filter transfer function:");
Hc

%Resonator
%Since N=25 there is no N/2 term
% H(0)
num=[Hmag(1)];
den=[1,-1];
Hr=tf(num,den,0.01,'Variable','z^-1');

% find Hk(z) for values of k=1 to N-1/2 and add to Hr
for i=1:(N-1)/2
    if(Hmag(i+1)~=0)
        num=[cos(Hphase(i+1)),cos(Hphase(i+1)-2*pi*i/N)];
        den=[1,-2*cos(2*pi*i/N),1];
        Hkz=tf(num,den,0.01,'Variable','z^-1');
        Hr=Hr+2*Hmag(i+1)*Hkz;
    end
end    
disp("Resonator Tranfer function");
Hr

%Multiply tranfer function of comb filter and resonator
Hz=Hc*Hr;
disp("Final transfer function:");
Hz

[num,den]=tfdata(Hz,'v');

w=0:.001*pi:pi;
Hw=freqz(num,den,w);
Domega=w/pi;
plot(Domega,abs(Hw));
title('Frequency Response of the Filter')
xlabel('Digital Frequency (w/pi)')
ylabel('Magnitude of the Frequency Response')
grid on