% Calcolo Scientifico
% Terzo Progetto
% Primo Esercizio
% Soluzione del problema con il metodo delle differenze finite centrate in
% spazio ed Eulero Esplicito per il tempo

clear all, close all

h=0.05; % passo di mesh spaziale
L=1; % x finale
x=0:h:L; % disretizzo lo spazio
nX=numel(x); % numero di nodi di mesh spaziali
T=1; % tempo finale

S=1;
dtcr=1/2*h^2/S; % condizione di stabilita globale
dt=0.8*dtcr;

% condizione iniziale u(x,0)
u0=@(x)(1+sin(pi*x))';

[tE,uE]=EEtempo(@DFCspazio,[0 L],u0(x(2:end-1)),L,nX,dt,h,@bcfun);

u=zeros(nX,numel(tE));
u(2:nX-1,:)=uE;

% condizioni al bordo
% u(0,t)=u(1,t)=1
for i=1:numel(tE)
    u(1,i)=bcfun(tE(i),0,L);
    u(nX,i)=bcfun(tE(i),L,L);
end

figure, plot(x,u(:,10)), axis([0 L])
xlabel('x')
ylabel('u(x,t)')
