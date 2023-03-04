clear;

bits = [0,1,0,0,1,1,1,0,1,0,1,1,0,1];

bit_rate=1;
voltage=5;
sign = 1;

tmp=voltage;
voltage = sign*voltage;

for i = 1:length(bits)
    if(bits(i)==0)
        amplitude(i) = voltage;
    else
        amplitude(i) = -voltage;
        voltage=amplitude(i);
    end
end

voltage = tmp;

Time = length(bits)/bit_rate;
sampling_frequency = 200;
sampling_period = 1/sampling_frequency;
time = 0:sampling_period:Time;

x = 1;

for i = 1:length(time)
    y_value(i)= amplitude(x);
    if time(i)*bit_rate>=x
        x= x+1;
    end
end

plot(time,y_value);
axis([0 Time -voltage-2 voltage+2]);
grid on;


% demodulation
x = 1;
tmp = sign;

for i=1:length(time)
  dm = y_value(i)/voltage;
  if time(i)*bit_rate>=x
      if dm==tmp
        ans_bits(x)=0;
      else
        ans_bits(x)=1;
      end
      tmp = dm;
      x = x + 1;
  end
end

disp('Demodulation : ')
disp(ans_bits)


