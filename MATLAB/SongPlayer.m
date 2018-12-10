clc; clear all;
fs = 44100;

% test
% f = [6 6 6 1 3 3 1 10 10 8 8 6];
% t = [0.2 0.2 0.2 0.3 0.3 0.3 0.6 0.3 0.3 0.3 0.3 0.6];
% "All I want for Christmas is you" 
tempo = 60/75;

GF = [6 9 ; 6 9; 6 11; 1 11; 3 1; 3 1; 1 1; 10 1; 10 1; 8 1; 8 1; 6 1];
t = [1 1 1 2 2 2 3 2 2 2 2 4];
t = t*tempo;

N = length(GF);

 A = linspace(0,1,round(0.1*fs));
 D = linspace(1,0.6,round(0.4*fs));
 S = linspace(0.6,0.2,round(0.3*fs));
 R = linspace(0.2,0,round(0.2*fs));
 ADSR = [A D S R];
 plot(ADSR)

for k = 1:N
   f1 = 261.63*(2)^(GF(k)/12);
   n = 0:t(k)*fs-1;
   x = sin(2*pi*f1*n/fs);
   num = length(n);
   A = linspace(0,1,round(0.1*fs*t(k)));
   D = linspace(1,0.6,round(0.5*fs*t(k)));
   S = linspace(0.6,0.2,round(0.3*fs*t(k)));
   R = linspace(0.2,0, num - length(A) - length(D) - length(S));
   ADSR = [A D S R; A D S R];
   x = x.*ADSR;
   sound(x,fs);
   pause(t(k))
    
end