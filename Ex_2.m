% Calcolo Scientifico Secondo Progetto
% Secondo Esercizio

clear all, close all

hh=[1/8 1/16 1/32 1/64]; % passo unifome di mesh

for l=1:numel(hh)
    h=hh(l);
    nx=ceil(1/h); ny=nx; 
    N=nx+1; % numero di nodi
    dim=N^2-(4*N-4); % numero di incognite
    xi=0; xf=1; yi=0; yf=1; % valori al bordo
    x=xi:h:xf;
    y=yi:h:yf;
    f=zeros(dim,1);
    % a=0.1; a=1; a=10; a=100;
    a=10;
        
    Pe=a*h; % numero di Peclet
    
    % bordo sud
    gS=@(x,y)0+1/(exp(-a)-1).*(exp(a*(x-1))-1)+0.*y; % u(x,0)
    % bordo nord
    gN=@(x,y)0+1/(exp(-a)-1).*(exp(a*(x-1))-1)+0.*y; % u(x,1)
    % bordo ovest
    gW=@(x,y)1+0.*x+0.*y; % u(0,y)
    % bordo est
    gE=@(x,y)0+0.*x+0.*y; % u(1,y)

    f(1:N-2)=f(1:N-2)-1/(2*(h^2))*2*(gS([1:N-2]*h,0))'; %bordo sud
    f(dim-(N-2)+1:dim)=f(dim-(N-2)+1:dim)-1/(2*(h^2))*2*(gN([1:N-2]*h,1))'; %bordo nord
    f(1:N-2:dim-(N-2)+1)=f(1:N-2:dim-(N-2)+1)-1/(2*(h^2))*(2+Pe)*(gW(0,[1:N-2]*h))'; %bordo ovest
    f(N-2:N-2:dim)=f(N-2:N-2:dim)-1/(2*(h^2))*(2-Pe)*(gE(1,[1:N-2]*h))'; %bordo est

    uex=@(x,y)1/(exp(-a)-1).*(exp(a*(x-1))-1); % soluzione esatta del problema

    % matrice A per i nodi interni, senza condizioni al bordo 
    I=speye(N-2); 
    e=ones(N-2,1);
    T=spdiags([(2+Pe)*e -8*e (2-Pe)*e],[-1 0 1],N-2,N-2);
    S=spdiags([e e],[-1 1],N-2,N-2); % struttura diamante
    P=2*speye(N-2); 
    A=1/(2*h^2)*(kron(I,T)+kron(S,P));

    % risolvo il sistema lineare nelle incognite (valori di u nei nodi interni)
    u=A\f;

    % dispongo la soluzione come nel piano fisico
    umat=reshape(u,N-2,N-2);
    umat=(fliplr(umat))';

    U=zeros(N);
    U(2:N-1,2:N-1)=umat;

    U(1,:)=gS(x,yi); %per j=1..N end=N+1

    U(end,:)=gN(x,yf); %per j=1..N

    U(:,1)=gW(xi,y); %per i=1..N

    U(:,end)=gE(xf,y); %per i=1..N

    [X,Y]=meshgrid(x,y);
    figure, surf(X,Y,U);
    figure, surf(X,Y,uex(X,Y));

    err(l)=max(max(abs(U-uex(X,Y))));
end