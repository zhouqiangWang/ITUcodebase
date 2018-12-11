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
E6 = 2*pi*1318.51;

tempo = 60/240;

% start from Bar5
notation = [E5 0; Eb5 0; E5 0; Eb5 0; E5 0; B 0; D5 0; C5 0; A A2; A E3; 0 A3;C 0; E 0; A 0;B E2; B E3; 0 Ab3;E 0; Ab 0; B 0; C5 A2; C5 E3; 0 A3; E 0; E5 0; Eb5 0;
    E5 0; Eb5 0; E5 0; B 0; D5 0; C5 0; A A2; A E3; 0 A3; C 0; E 0; A 0; B E2; B E3; 0 Ab3; E 0; C5 0; B 0; A A2; A E3; 0 A3; 0 0; E5 0; Eb5 0;E5 0; Eb5 0; E5 0; B 0; D5 0; C5 0;
    A A2; A E3; 0 A3; C 0; E 0; A 0; B E2; B E3; 0 Ab3; E 0; Ab 0; B 0; C5 A2; C5 E3; 0 A3; E 0; E5 0; Eb5 0; E5 0; Eb5 0; E5 0; B 0; D5 0; C5 0; A A2; A E3; 0 A3;C 0; E 0; A 0;
    B E2; B E3; 0 Ab3; E 0; C5 0; B 0; A A2; A E3; 0 A3; B 0; C5 0; D5 0; E5 C3; E5 G3; 0 C; G 0; F5 0; E5 0; D5 G2; D5 G3; 0 B3; F 0; E5 0; D5 0; C A2; C E3; 0 A3; E 0; D5 0; C5 0;
    B E2; B E3; E 0; E 0; E5 0; E 0; E5 0; E5 0; E6 0; Eb5 0; E5 0; Eb5 0; E5 0; Eb5 0; E5 0; B 0; D5 0; C5 0; A A2; A E3; 0 A3; C 0; E 0; A 0; B E2; B E3; 0 Ab3; E 0; Ab 0; B 0;
    A A2; A E3; 0 A3; E 0; E5 0; Eb5 0; E5 0; Eb5 0; E5 0; B 0; D5 0; C5 0; A A2; A E3; 0 A3; C 0; E 0; A 0; B E2; B E3; 0 Ab3; E 0; C5 0; B 0; A A2; A E3; 0 A3];
t = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
t = t*tempo;

A = linspace(0,1,round(0.1*fs));
D = linspace(1,0.6,round(0.6*fs));
S = linspace(0.6,0.2,round(0.2*fs));
R = linspace(0.2,0, round(0.1*fs));
ADSR = [A D S R];
plot(ADSR);

N0 = length(notation);

for k = 1:N0
   n = 0:t(k)*fs;
   x = cos(notation(k)*n/fs);
   A = linspace(0,1,round(0.10*fs*t(k)));
   D = linspace(1,0.8,round(0.4*fs*t(k)));
   S = linspace(0.8,0.2,round(0.4*fs*t(k)));
   R = linspace(0.2,0, round(0.10*fs*t(k)));
   ADSR = [A D S R; A D S R];
   x = x.*ADSR;
   sound(x,fs);
   pause(t(k))
end
