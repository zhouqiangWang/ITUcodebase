clc; clear all;
fs = 44100;

% piano key
E2 = 2*pi*82.41;
G2 = 2*pi*98.0;
A2 = 2*pi*110.0;
B2 = 2*pi*123.47;
C3 = 2*pi*130.81;
Db3 = 2*pi*138.59;
D3 = 2*pi*146.83;
Eb3 = 2*pi*155.56;
E3 = 2*pi*164.81;
F3 = 2*pi*174.61;
Gb3 = 2*pi*185.0;
G3 = 2*pi*196.0;
Ab3 = 2*pi*207.65;
A3 = 2*pi*220.0;
Bb3 = 2*pi*233.08;
B3 = 2*pi*246.94;
C = 2*pi*261.63;
Db = 2*pi*277.18;
D = 2*pi*293.66;
Eb = 2*pi*311.13;
E = 2*pi*329.63;
F = 2*pi*349.23;
Gb = 2*pi*369.99;
G = 2*pi*392.00;
Ab = 2*pi*415.3;
A = 2*pi*440.00;
Bb = 2*pi*466.16;
B = 2*pi*493.88;
C5 = 2*pi*523.25;
Db5 = 2*pi*554.37;
D5 = 2*pi*587.33;
Eb5 = 2*pi*622.25;
E5 = 2*pi*659.26;
F5 = 2*pi*698.46;
Gb5 = 2*pi*739.99;
G5 = 2*pi*783.99;
Ab5 = 2*pi*830.61;
A5 = 2*pi*880.0;
Bb5 = 2*pi*932.32;
B5 = 2*pi*987.77;
E6 = 2*pi*1318.51;

% the original tempo is Adagio(70–80 bpm), choosen 75, and we based on 1/8
% beat, so the period = 60/75/2 = 0.4 s
tempo = 60/75/2;


notation = [D C E G B C5 B A G A G D5 C5 C5 B C5 B A G A G F A C5 D5 E5 D5 C5 A E5 G5 E5 D5 C5 D5 C5 Ab G C5 D5 B C5 A B Ab E5 D5 D5 C5 C5 B C5 Ab G A C5 G5 G5 F5 E5 D5 C5 E5 E5 D5 C5 C5 A Ab D5 E5 D5 C5 E5 E5 D5 C5 A C5 D C 0 C E G B C5 B A G D5 C5 C5 B C5 B A G G F A C5 D5 E5 D5 C A F Ab C5 D5 Eb5 D5 Bb5 Ab5 D5 C5 C5 B C5 B A G C E G B C5 B A B A G 0 E5 E5 E5 D E5 D5 C5 A F Ab C5 D5 E5 D5 B A C5 D5 B C5 A B Ab C5 D5 B C5 A B Ab G A C5 G5 F5 G5 F5 0 E5 D5 C5 A Ab D5 E5 D5 C5];
t = [2 1 1 1 1 0.5 0.5 0.5 0.5 1 1 1 1 1 1 0.5 0.5 0.5 0.5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 0.5 0.5 0.5 0.5 1 1 1 1 1 1 12 2 2 1 1 1 4 1 1 8 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 3 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 2 2 1 1 2 2 2 2 2 2 2 2 2 2 2 1 1 4 2 2 2 2 2 2 4 2 2 2 2 2 2 4 2 2 2 2 1 1 2 4 2 2 2 2 2 4 2 2 6];
t = t*tempo;

A = linspace(0,1,round(0.1*fs));
D = linspace(1,0.6,round(0.6*fs));
S = linspace(0.6,0.2,round(0.2*fs));
R = linspace(0.2,0, round(0.1*fs));
ADSR = [A D S R];
plot(ADSR);

N0 = length(notation);

for k = 1:N0
   n = 0:t(k)*fs - 1;
   x = cos(notation(k)*n/fs);
   A = linspace(0,1,round(0.10*fs*t(k)));
   D = linspace(1,0.8,round(0.4*fs*t(k)));
   S = linspace(0.8,0.2,round(0.4*fs*t(k)));
   R = linspace(0.2,0, length(n) - length(A) - length(D) - length(S));
   ADSR = [A D S R];
   x = x.*ADSR;
   sound(x,fs);
   pause(t(k))
end
