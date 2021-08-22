% Calcolo Scientifico
% Terzo Progetto
% Primo esercizio
% Funzione per il metodo delle differenze finite centrate in spazio

function F=DFCspazio(t,u,L,nX,h,bcfun)
    
    nodi=nX-2; % numero di nodi interni
    F=zeros(nodi,1);
    
    x=0:h:L; % passo di mesh
    alpha=@(u)3-2/(1+u^2);
    for j=2:nodi-1
        F(j)=(1/h^2)*(alpha((u(j)+u(j+1))/2)*(u(j+1)-u(j))-alpha((u(j)+u(j-1))/2)*(u(j)-u(j-1)));
    end
    
    F(1)=(1/h^2)*(alpha((u(1)+u(2))/2)*(u(2)-u(1))-alpha((u(1)+bcfun(t,0,L))/2)*(u(1)-bcfun(t,0,L)));
    F(nodi)=(1/h^2)*(alpha((u(nodi)+bcfun(t,L,L))/2)*(bcfun(t,L,L)-u(nodi))-alpha((u(nodi)+u(nodi-1))/2)*(u(nodi)-u(nodi-1)));
    
return