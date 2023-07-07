clear;
clc;
close;

bits = [0,1,1,0,1,0,1,0,0,0,1,1];

bitrate = 1;
voltage = 5;

for i = 1:length(bits)
    if(bits(i)==1)
        amplitude(i) = -voltage;
    else
        amplitude(i) = voltage;
    end
end


Time=length(bits)/bitrate;
sampling_frequency = 1000;
sampling_period = 1/sampling_frequency;

time = 0:sampling_period:Time;

x = 1;

for i = 1:length(time)
    y_value(i)= amplitude(x);
    if time(i)*bitrate>=x
        x= x+1;
    end
end


plot(time,y_value);
axis([0 Time -voltage-2 voltage+2]);
grid on;

% demodulation

x = 1;
for i = 1:length(time)
    if time(i)*bitrate>=x
        ans_bits(x) = 0;
        if(y_value(i)<0)
            ans_bits(x) = 1;
        end
        x = x + 1;
    end
end

disp('Demodulation : ')
disp(ans_bits)
