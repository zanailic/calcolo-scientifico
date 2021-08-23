clear all, close all

X=fopen('progetto.dat');
S=textscan(X, '%f%f%f', 'Delimiter', ' ');
fclose(X);
t=S{1}; %tempo
u1=S{2}; 
u2=S{3};
passi(t);

u1_esatta = 2*exp(-0.1*t) + exp(-1000*t); 
u2_esatta = exp(-0.1*t) - exp(-1000*t);

figure()
subplot(1,2,1)
plot(t,u1,'r','LineWidth',2), hold on
plot(t,u1_esatta,'o-')
xlim([0 3])
xlabel("t");
ylabel("u_1");
title('u_1')
legend('soluzione approssimata','soluzione esatta')

subplot(1,2,2)
plot(t,u2,'r','LineWidth',2), hold on
plot(t,u2_esatta,'o-')
xlim([0 3])
xlabel("t");
ylabel("u_2");
title('u_2')
legend('soluzione approssimata','soluzione esatta')

function passi(T)
% visualizzazione ampiezze passi
% T vettore dei tempi, contiene anche t iniziale
disp(['numero passi = ',num2str(length(T)-1)])
disp(['passo max = ',num2str(max(diff(T)))])
disp(['passo min = ',num2str(min(diff(T)))])
figure()
plot(T(2:end),diff(T),'o',T(2:end),diff(T),':')
title('ampiezza dei passi')
end
