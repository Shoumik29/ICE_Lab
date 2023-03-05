clc;
clear all;
close all;


bits = [1,0,0,0,0,0,0,0,0,1]; %10

bit_rate = 1;
voltage = 5;
sign = -1;

voltage = sign*voltage;
tmp = voltage;
cn=0;

% " 000VB0VB"
%   12345678.

for i = 1:length(bits)

    if bits(i) == 0
        cn = cn + 1;
    else
        cn=0;
    end

    if cn>7
        y_level(i-4) = voltage;
        y_level(i-3) = -voltage;
        y_level(i-1) = -voltage;
        y_level(i) = voltage;
        cn = 0;
    elseif bits(i)==0
        y_level(i) = 0;
    else
        y_level(i) = -voltage;
        voltage = y_level(i);
    end
end

voltage = tmp;
Time = length(bits)/bit_rate;
sampling_frequency = 1000;
sampling_period = 1/sampling_frequency;
time = 0:sampling_period:Time;
x = 1;

for i = 1:length(time)
    y_value(i)= y_level(x);
    if time(i)*bit_rate >= x
        x = x + 1;
    end
end

plot(time,y_value,'linewidth',1);
%axis([0 Time -voltage-5 voltage+5]);
grid on;


% demodulation

in = 1;
tmp = -sign;
in1 = -1;

for j=1:length(time)
  dm = y_value(j)/voltage;
  if time(j)*bit_rate>=in
      if dm==0
        ans_bits(in)=0;
      else
        if in ~= in1+1
            ans_bits(in)=1;
        end
        if tmp == dm;
            in1 = in;
            ans_bits(in) = 0;
            ans_bits(in+1) = 0;
        end
      end

      if dm~=0
        tmp = dm;
      end
      in = in+1;
  end
end


disp('Demodulation : ')
disp(ans_bits)

