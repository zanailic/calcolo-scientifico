% Primo Progetto Calcolo Scientifico
% Secondo Esercizio  
% Metodo di Newton con errore in norma infinito

clear all, close all

rang=[20 40 80 160 320];
cont=0;

for n=rang+1
    cont=cont+1;
    x=linspace(-1,1,n)'; % a=-1 & b=1
    h=2/(n-1); % lunghezza dell'intervallo, h=b-a/(n-1)
    uex=@(x)(cosh(x)-cosh(1)+1); % soluzione esatta
    
    % Matrice A
    A=zeros(n); 
    d=-2*ones(n,1); 
    d1=ones(n-1,1);
    A=diag(d)+diag(d1,-1)+diag(d1,1);
    A(1,1)=1; A(1,2)=0; % cambio nodi sul bordo
    A(n,n)=1; A(n,n-1)=0;
    A=(1/(h^2))*A;

    % Matrice B
    B=zeros(n);
    db=ones(n-1,1);
    B=diag(-db,-1)+diag(db,1);
    B(n,n-1)=0; B(1,2)=0; % cambio nodi sul bordo
    B=(1/(2*h))*B;
    
    % Vettore b
    b=zeros(n,1);
    b(1)=b(1)+1/h^2-1;
    b(end)=b(end)+1/h^2-1;

    % Metodo di Newton
    F=@(u)A*u-sqrt(1+(B*u).^2)-b;
    
    % Jacobiano di F
    JF=@(u)A-diag((B*u)./sqrt(1+(B*u).^2))*B;

    u0=ones(n,1);
    %u0=linspace(-1,1,n)';
    u=u0;
    
    % Calcolo di errore 
    tol=h^2/n;
    delta=-JF(u)\F(u);
    while (norm(delta,inf)>tol)
        u=u+delta;
        delta=-JF(u)\F(u);
    end
    u=u+delta;
    err(cont)=norm(u-uex(x),inf);
    p(cont)=2/(n-1); % =h
end

figure(1)
plot(x,u,'b*',x,uex(x),'r-');
title('Soluzioni metodo Newton')
legend('Soluzione numerica','Soluzione esatta')
xlabel('x')
ylabel('u(x)')

figure(2)
loglog(p,err,'r-*');
%loglog(rang,err,'r-*');
title('Errore metodo Newton');
xlabel('h')
ylabel('errore')
grid on