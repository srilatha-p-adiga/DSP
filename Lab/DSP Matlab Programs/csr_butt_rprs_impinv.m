% Low Pass BUTTERWORTH FILTER DESIGN using Impulse Invariance Technique
% Pass Band Gain, Stop Band Attenuation
% Pass Band Edge Frequency, Stop Band Edge Frequency

loop=1;
while (loop==1)
   clc;
   disp('  ');
   disp('DIGITAL BUTTERWORTH LOW PASS FILTER DESIGN using Impulse Invariance Technique');
   disp('Specifications are');
   disp('Passband Edge Freq. in Hz and Gain in dB');
   disp('Stopband Edge Freq. in Hz and Attenuation in dB');
   disp('  ');
%       fp=input('Passband Edge Frequency in Hz. = ');
%       rp=input('Passband Gain in dB (Positive Value Only) = ');
%       fs=input('Stopband Edge Frequency in Hz. = ');
%       rs=input('Stopband Attenuation in dB (Positive Value Only) = ');
%       fsamp=input('Sampling Frequency in Hz = ');
%       wp=2*pi*fp;
%       ws=2*pi*fs;
      
      rp=1;
      rs=40
      wp=100; % Rads/Sec
      ws=2000; % Rads/Sec
      fsamp=1000; % Hz
      
      N = ceil(log10(((10^(rp/10))-1)/((10^(rs/10))-1))/(2*log10(wp/ws)));
      wn = wp/(((10^(rp/10))-1)^(1/(2*N)));
      
      K=wn^N;
      %z=[zeros(N,1)];
      z=[];
      sk=[];
      for k=0:N-1;
          sk=[sk,wn*exp(j*(2*k+1+N)*pi/(2*N))];
      end
      disp('Order of the Filter....')
      disp(N);
      disp('Cut Off Frequency in Hz....')
      fn=wn/(2*pi)
      disp('Gain....')
      disp(K);
      disp('Poles are....')
      disp(sk);
      [num,den]=zp2tf(z,sk,K);
      disp('Analog Butterworth Low Pass Filter Numerator Coefficients....')
      disp(num)
      disp('Analog Butterworth Low Pass Filter Denominator Coefficients....')
      disp(den)
   
   disp('Press a Key to Continue.......')
   pause;
   fres=0:0.01:10*max(wn);
   resps = freqs(num,den,fres);
   mags=20*log10(abs(resps));
%   Fs=fres/(2*pi);
   figure(1);
   plot(fres,mags);
   title('Analog Butterworth Low Pass Filter Frequency Response');
   xlabel('Frequency in Hz.');
   ylabel('Magnitude in dB.');
   grid;
   zoom;
   disp(' ')
   disp('Press a key to Continue........')
   pause
   
%  Digital Filter Design
   disp(' ')
   disp('Impulse Invariance Transformation')
   [BZ,AZ]=impinvar(num,den,fsamp);
   disp(' ')
   disp('Digital Butterworth Low Pass Filter Numerator Coefficients....')
   disp(BZ)
   disp('Digital Butterworth Low Pass Filter Denominator Coefficients....')
   disp(AZ)

   [respz,frez]=freqz(BZ,AZ);
   
   magz=20*log10(abs(respz));
%   fz=frez*fsamp/(2*pi);
   fz=frez*fsamp;
   figure(2)
   plot(fz,magz);
   title('Digital Butterworth Low Pass Filter Frequency Response');
   xlabel('Frequency in Hz.');
   ylabel('Magnitude in dB.');
   grid;
   zoom;
   disp('Press a Key to Continue.......')
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

   