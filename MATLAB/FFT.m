clc; clear all;

[x,fs] = audioread('joewang.wav');
x = x';
x = x(1:2*fs);
plot(x)

% sound(x,fs)

N = length(x);

for k = 0:N-1
    tmp = 0;
    for n = 0:N-1
        tmp = tmp + exp(-j*2*pi*n*k/N)*x(n+1); 
    end
    X(k+1) = tmp;
end

plot(abs(X))


