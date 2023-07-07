clear;

bits = [0,1,1,0,1,0,1,0,1,1,1,1];

bit_rate = 1;
voltage = 5;
sign = 1;

tmp = voltage;
voltage = voltage*sign;
x = 1;

for i = 1:length(bits)
    if(bits(i)==0)
        y_level(x) = voltage;
        y_level(x + 1) = -voltage;
    else
        y_level(x) = -voltage;
        y_level(x + 1) = voltage;
    end
    x = x + 2;
end

voltage = tmp;

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


plot(time,y_value);
axis([0 Time -voltage-2 voltage+2]);
grid on;


% demodulation

x = 1;
st = 1;
tmp = sign;

for i = 1:length(time)
  dm = y_value(i)/voltage;
  if time(i)*bit_rate*2 >= x
      if mod(x,2)==1
          if dm == tmp
            ans_bits(st)=0;
          else
            ans_bits(st)=1;
          end
          st = st + 1;
      end
      x = x + 1;
  end
 end

 disp('Demodulation : ')
 disp(ans_bits)


