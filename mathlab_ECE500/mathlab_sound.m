clc; clear all;
f = 17000;
fs = 44100;
n = 0:15*fs-1;
A = 1;
x = A*cos(2*pi*f*n/fs);

sound(x,fs)