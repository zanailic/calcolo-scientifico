% Calcolo Scientifico
% Terzo Progetto
% Secondo Esercizio
% Secondo Punto
% Legge di Conservazione

clear all, close all

xmin=0; xmax=8;
x=linspace(xmin,xmax,20);
a=1/2; % velocita' di propogazione del onda
gamma=0.7;
g=@(x)x*0; % condizione iniziale c(x,0)

% grafico delle linee caratteristiche
figure(1), hold on

x0=x;
for i=x0
    t=(x-i)/a; 
    plot(x,t,'r');
end
xlabel('x');
ylabel('t');
axis([xmin xmax 0 8]) %, axis equal
hold off

% grafico della soluzione 3D
x=linspace(xmin,xmax,50);
t=linspace(0,8,50);

for it=1:numel(t)
    for ix=1:numel(x)
        x0=x(ix)-a*t(it); % piede della caratteristica per (x(ix),t(it))
        t0=(x(ix)-x0)/a;
        %c(ix,it)=2*exp(-gamma*t0)*(x0>a*t0)+0*(x0<a*t0);
        c(ix,it)=2*exp(-gamma*t0);
    end
end

% grafico della soluzione in assi (x,t,c(x,t))
figure(2), [XX,TT]=meshgrid(x,t);
surf(XX,TT,c');
xlabel('x');
ylabel('t');
zlabel('c(x,t)');

