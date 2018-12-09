clc; clear all;
fs = 44100;
f = [4 4 4 1 2 2 ];
t = [1 1 1 1 1 1 ];

N = length(f);
A = linspace(0,0.8,round(0.2*fs));
D = linspace(0.8,0.6,round(0.2*fs));
S = linspace(0.6,0.6,round(0.4*fs));
R = linspace(0.6,0,round(0.2*fs));
ADSR = [A D S R];
plot(ADSR)

for k = 1:N
   f1 = 261.63*(2)^(f(k)/12);
   n = 0:t(k)*fs -1 ;
   x = cos(2*pi*f1*n/fs);
   x = x.*ADSR;
   sound(x,fs);
   pause(0.8)
    
end