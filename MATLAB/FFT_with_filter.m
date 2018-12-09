clc; clear all;
[x,fs] = audioread('joewang.wav');
x = x';
xx = x;
k = 0;
% sound(x,fs);
h = fir1(200,[.2/8 2/8]);
y = filter(h,1,x);
x = y;
% pause(11);
% sound(x,fs)
N = length(x);
for OM = 0:0.01:pi
    
    tmp = 0;
    for n = 0:N-1
       tmp = tmp + exp(-j*OM*n)*x(n+1); 
    end
    k = k + 1;
    X(k) = tmp;
    OM_val(k) = OM;
end
f = OM_val*fs/(2*pi);
plot(f,abs(X))
