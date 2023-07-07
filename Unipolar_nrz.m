clc;
close;
clear;

bits = [0,1,1,0,1,0,1,0,1,1,1,1]; %12

bitrate = 1;
voltage = 5;


for i = 1:length(bits)
  if(bits(i)==1)
    amplitude(i) = voltage;
  else
    amplitude(i) = 0;
  end
end


Time = length(bits)/bitrate;
sampling_frequency = 200;
sampling_time = 1/sampling_frequency;

time = 0:sampling_time:Time;

x = 1;

for i = 1:length(time)
  y_value(i) = amplitude(x);
  if(time(i)*bitrate >= x)
    x = x + 1;
  end
end


plot(time, y_value);
axis([0 Time -voltage-2 voltage+2]);  %range of x and range of y on the grid
grid on;


%demodulation
x = 1;

for i = 1:length(time)
  if(time(i)*bitrate >= x)
    ans_bits(x) = y_value(i)/voltage;
    x = x + 1;
  end
end

disp(ans_bits)



