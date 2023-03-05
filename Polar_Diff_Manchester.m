clc;
clear all;
close all;


bits = [1,0,1,1,0,0,1];


bit_rate = 1;
voltage = 5;
sign = 1;


x = 1;
prev = voltage;

for i = 1:length(bits)
  if(bits(i)==0)
    y_level(x) = -prev;
    y_level(x + 1) = -y_level(x);
  else
    y_level(x) = prev;
    y_level(x + 1) = -y_level(x);
  end
  prev = y_level(x + 1);
  x = x + 2;
end



bit_rate = bit_rate;
Time = length(bits)/bit_rate;
sample_frequency = 200;
sampling_period = 1/sample_frequency;
time = 0:sampling_period:Time;


x = 1;

for i = 1:length(time)
    y_value(i) = y_level(x);
    if time(i)*bit_rate*2>=x
        x = x + 1;
    end
end


plot(time, y_value, 'linewidth', 1);
axis([0 Time -voltage-2 voltage+2]);
grid on;




% demodulation

x = 1;
st = 1;
tmp = sign;

for i = 1:length(time)
  dm = y_value(i)/voltage;
  if time(i)*bit_rate*2 >= x
      if mod(x,2) == 1
          if dm ~= tmp
            ans_bits(st)=0;
          else
            ans_bits(st)=1;
            tmp = -tmp; %middle a trasition ghotlo
          end
          st = st + 1;
      end
      x = x + 1;
  end
 end

 disp('Demodulation : ')
 disp(ans_bits)
