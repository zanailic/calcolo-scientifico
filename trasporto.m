% Calcolo Scientifico
% Terzo Progetto
% Secondo Esercizio
% Primo Punto
% Legge di Trasporto

clear all, close all

xmin=-2; xmax=2;
x=linspace(xmin,xmax,20);
a=1/2; % velocita' di propogazione del onda
gamma=0.7;
g=@(x)exp((x-a).^2).*exp((gamma/a).*x); % condizione iniziale

% grafico di condizione iniziale
figure(1), plot(x,g(x)), hold off

% grafico delle linee caratteristiche
figure(2), hold on

x0=x;
for i=x0
    t=(x-i)/a; 
    plot(x,t,'r');
end
xlabel('x');
ylabel('t');
axis([xmin xmax 0 1]) %, axis equal
hold off

% grafico della soluzione 3D
x=linspace(xmin,xmax,30);
t=linspace(0,1,30);

for it=1:numel(t)
    for ix=1:numel(x)
        x0=x(ix)-a*t(it); % piede della caratteristica per (x(ix),t(it))
        u(ix,it)=g(x0); % propagazione della condizione iniziale lungo la caratteristica
        c(ix,it)= u(ix,it)*exp(-(gamma/a).*x0);
    end
end

% grafico della soluzione in assi (x,t,u(x,t))
figure(3), [XX,TT]=meshgrid(x,t);
surf(XX,TT,u');
axis([xmin xmax 0 1 0 150]);
xlabel('x');
ylabel('t'); 
zlabel('u(x,t)');

% grafico della soluzione in assi (x,t,c(x,t))
figure(4), [XX,TT]=meshgrid(x,t);
surf(XX,TT,c');
axis([xmin xmax 0 1 0 150]);
xlabel('x');
ylabel('t');
zlabel('c(x,t)');

