clc; clear all;
[x,fs] = audioread('mark.wav');
x = x';

N = length(x);
OM = 0:0.05:pi;
n = 0:N-1;
X = exp(-j*OM'*n)*x';
f = OM*fs/(2*pi);
plot(f,abs(X))








