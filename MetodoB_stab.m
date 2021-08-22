% Secondo Progetto Calcolo Scientifico
% Primo esercizio
% Metodo B-la regione di assoluta stabilità 

clear all, close all

x=linspace(-5,5);
y=linspace(-5,5);
lambda=x+1i*y;

red=[0.9 0.1 0.2];
green=[0.4471 0.9020 0.1451];

r1=[-5 5 5 -5];
r2=[-5 -5 5 5];
patch(r1,r2,green), hold on

theta=linspace(0,2*pi);
z=exp(1i*theta); 
B=(3-4./z+1./z.^2)/2;
plot(real(B),imag(B),'-k'), hold on
fill(real(B),imag(B),red), hold on

plot([0 0], ylim, 'k--');  % asse x
plot(xlim, [0 0], 'k--');  % asse y
hold off 

axis([-5 5 -5 5]), axis square, grid on
title('Metodo B')
xlabel('$\lambda Re(z)$','interpreter','latex');
ylabel('$\lambda Im(z)$','interpreter','latex');