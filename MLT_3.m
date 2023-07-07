clear;

bits = [0,1,0,1,1,0,1,1,1,0,1,1,0];

bit_rate = 1;
voltage = 5;
tmp = voltage;
sign = 1;
prev = 0;
voltage = sign*voltage;
value = voltage;
prev_voltage = voltage;


for i = 1:length(bits)
    if(bits(i)==0)
        y_level(i) = prev;
    else
        y_level(i) = value;
        if(value ~= 0)
          value = 0;
        else
          value = -prev_voltage;
          prev_voltage = value;
        end
        prev = y_level(i);
    end
end

voltage=tmp;
Time=length(bits)/bit_rate;
frequency = 200;
period = 1/(frequency*bit_rate);
time = 0:period:Time;
x = 1;

for i = 1:length(time)
    y_value(i)= y_level(x);
    if time(i)*bit_rate>=x
        x= x+1;
    end
end


plot(time,y_value);
axis([0 Time -voltage-2 voltage+2]);
grid on;

% demodulation need to be done

in=1;
for j=1:length(time)
  tmp = y_value(j)/voltage;
  if time(j)*bit_rate>=in
      if tmp==0
        ans_bits(in)=0;
      else
        ans_bits(in)=1;
      end
      in=in+1;
  end
 end


disp('Demodulation : ')
disp(ans_bits)


