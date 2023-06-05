clc;
clear all;
close all;

x=[2,0.5,0,0,0,0,0,0.5];
N=8;
Hk=fft(x,N);

Hmag=abs(Hk);
Hphase=phase(Hk);

alpha =(N-1)/2;
num=[Hmag(1)];
denom=[1,-1];
Hr=tf(num,denom,0.01,'Variable','z^-1');
%H(0)
disp('H(0)');
Hr
num=[Hmag(N/2)];
denom=[1,1];
Hr=Hr+tf(num,denom,0.01,'Variable','z^-1');
%H(N/2)
disp('H(N/2)');
Hr

for i=1:(N/2)-1
    if(Hmag(i+1)~=0)
        num=[cos(Hphase(i+1)),-cos(Hphase(i+1)-(2*pi*i)/N)];
        den=[1,-2*cos(2*pi*i/N),1];
        Hkz=tf(num,den,0.01,'Variable','z^-1');
        Hr=Hr+2*Hmag(i+1)*Hkz;
    end
end

%Comb Filter
num=[1,zeros(1,N-1),-1];
den=N;
Hc=tf(num,den,0.01,'Variable','z^-1');
disp('Comb Filter');
Hc

%Final transfer function
Hz=Hc*Hr;
disp('Final Transfer function');
Hz
%Plot
w=0:0.001*pi:pi;
[num,dem]=tfdata(Hz,'v');
Hw=freqz(num,dem,w);
domega=w/pi;
plot(domega,abs(Hw));
title('Frequency Sampling Technique');
xlabel('Digital Frequency');
ylabel('Magnitude');
grid;