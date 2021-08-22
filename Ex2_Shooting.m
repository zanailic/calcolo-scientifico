% Primo Progetto Calcolo Scientifico
% Secondo Esercizio
% Metodo di Shooting con ode45 e fzero
% Sto usando i funzioni: odefunz.m e shoot.m

clear all, close all

global a b xa xb
xa=1; xb=1;
a=-1; b=1;
xex=@(t)(cosh(t)-cosh(1)+1); % soluzione esatta 

s0=-0.05; 
s=fzero(@shoot,s0);

[t,x]=ode45(@odefunz,[a,b],[xa,s]);

figure(1)
plot(t,x(:,1),'b*',t,xex(t),'r-')
title('Soluzioni metodo Shooting')
legend('Soluzione numerica','Soluzione esatta')
xlabel('x')
ylabel('u(x)')

err=norm((x(:,1)-xex(t)), inf);
figure(2)
loglog(t,err,'g-*');
title('Errore metodo shooting');
xlabel('h')
ylabel('errore')
grid on