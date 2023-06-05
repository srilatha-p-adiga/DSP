% FIR High Pass Filter Design Using Hamming Window
% Specification: Pass Band Edge Frequency & Stop Band Edge Frequency
% Assume that the design is using Hamming Window;

loop=1;
while (loop==1)
clc;
disp('FIR High Pass Filter Design Using Hamming Window')
disp(' ')
disp('Specification: Pass Band Edge Frequency & Stop Band Edge Frequency')
disp(' ')
fp=input('Enter the Passband Edge Frequency in Hz = ');
fs=input('Enter the Stop Band Edge Frequency in Hz = ');
Fs=input('Enter the Sampling Frequency in Hz = ');

wp=2*pi*fp/Fs;
ws=2*pi*fs/Fs;

wt=abs(ws-wp);

N=ceil(6.64*pi/wt+1)

if mod(N,2)==0
    N=N+1
end

alpha=(N-1)/2;

wc=wp;
% wc=(wp+ws)/2;
%p=[];

hd=[];
for n=0:(N-3)/2;
    hd=[hd,-sin(wc*(n-alpha))/(pi*(n-alpha))];
end
for n=(N-1)/2;
    hd=[hd,1-wc/pi];
end
for n=(N+1)/2:N-1
        hd=[hd,-sin(wc*(n-alpha))/(pi*(n-alpha))];
end
disp('hd = ');
disp(hd);
wd=[];
for n=0:N-1;
    wd=[wd,0.54-0.46*cos(2*pi*n/(N-1))];
end
disp('wd = ');
disp(wd);

n=0:N-1;
stem(n,wd)
title('Window Function')
xlabel('Time Index n')
ylabel('Window Sample Value w(n)')
disp('')
disp('Press a Key to Continue...')
pause

fc=wc*Fs/(2*pi)

hn=hd.*wd
[Resp,omega]=freqz(hn,1);
mag=20*log10(abs(Resp));
freq=omega*Fs/(2*pi);
plot(freq,mag)
title('Magnitude Frequency Response')
xlabel('Frequency in Hz')
ylabel('Magnitude in dB')
grid

   disp(' ');
   disp('Press a key to Continue....')
   pause
   disp('  ');
   choice=input('DO YOU WANT TO CONTINUE WITH THE DESIGN...?(Y)= ','s');
   switch upper(choice)
   case 'Y',
      loop=1;
   otherwise
      loop=0;
   end
end