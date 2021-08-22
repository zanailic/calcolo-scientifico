% Calcolo Scientifico
% Terzo Progetto
% Secondo Esercizio
% Terzo Punto
% Equazione di Burgers

clear all, close all

xmin=-1; xmax=3;
x=linspace(xmin,xmax,30);

% condizione iniziale c(x,0)=g(x)
g=@(x)0*(x<-1)+2*(x+1)*(x>=-1 && x<=-1/2)+1*(x>-1/2 && x<1/2)+2*(-x+1)*(x>=1/2 && x<=1)+0*(x>1);

% disegno le linee caratteristiche
figure, axis([xmin xmax 0 4]), hold on
x0=x;
for i=1:numel(x0)
    plot(x,(x-x0(i))/g(x0(i)),'r');
end
xlabel('x')
ylabel('t')
hold off
