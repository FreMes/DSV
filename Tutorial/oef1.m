t = zeros(10000,1);

for i=1:10000
   t(i,1)= (1/10000)*i;
end

sin1 = sin(2*pi*10*t);
sin2 = sin(2*pi*500*t);
sin3 = sin(2*pi*510*t);

x = sin1 + sin2;
y = sin2 + sin3;

figure(1);
subplot(2,1,1);
plot(t,x);
title('10 en 500 Hz');
subplot(2,1,2);
plot(t,y);
title('500 en 510 Hz');


f = inline('sin(500*x).*exp(-7*x)',[0 1]);

figure(2);
plot(t,f(t));

save data x y;


%test