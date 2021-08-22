% Secondo Progetto Calcolo Scientifico
% Primo esercizio
% Metodo A-la regione di assoluta stabilità 

clear all, close all

x=linspace(-5,5);
y=linspace(-5,5);
lambda=x+1i*y;

red=[0.9 0.1 0.2];
green=[0.4471 0.9020 0.1451];

% l'area complementare
r1=[-5 5 5 -5];
r2=[-5 -5 5 5];
patch(r1,r2,red), hold on

% l'area del grafico che garantisce assoluta stabilità
theta=linspace(0,2*pi);
z=exp(1i*theta); 
r=z-1;
s=(23-16./z+5./z.^2)/12;
A=r./s;
plot(real(A),imag(A),'-k'), hold on
fill(real(A),imag(A),green), hold on


plot([0 0], ylim, 'k--');  % asse x
plot(xlim, [0 0], 'k--');  % asse y 
hold off

axis([-1 1 -1 1]), axis square, grid on
title('Metodo A')
xlabel('$\lambda Re(z)$','interpreter','latex');
ylabel('$\lambda Im(z)$','interpreter','latex');