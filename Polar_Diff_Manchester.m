clear;

bits = [0,1,0,0,1,1,0,1];

bit_rate = 1;
voltage = 5;
sign = 1;

tmp = voltage;
x = 1;

m = -1;
n = 1;

voltage = sign*voltage;

for i = 1:length(bits)
    if(bits(i)==0)
        y_level(x) = m*voltage;
        y_level(x + 1) = n*voltage;
    else
        temp = m;
        m = n;
        n = temp;
        y_level(x) = m*voltage;
        y_level(x + 1) = n*voltage;
        %voltage = -voltage;
    end
    x = x + 2;
end

voltage=tmp;

bit_rate = bit_rate;
Time=length(bits)/bit_rate;

frequency = 1000;
dt = 1/frequency;
time = 0:dt:Time;

x = 1;

for i = 1:length(time)
    y_value(i)= y_level(x);
    if time(i)*bit_rate*2>=x
        x= x+1;
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


