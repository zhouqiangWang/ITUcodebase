clc; clear all;
f = 15000;
fs = 44100;
n = 0:5*fs-1;
A = 1;
x = A*cos(2*pi*f*n/fs);

sound(x,fs)