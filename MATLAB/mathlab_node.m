clc; clear all;
fs = 44100;
c = 261.63;

for n = 0:11
    f = c*(2)^(n/12)
%     fprintf('f = %d', f)
    nn = 0:fs-1;
    x = sin(2*pi*f*nn/fs);
    sound(x,fs)
    pause(1)
end


