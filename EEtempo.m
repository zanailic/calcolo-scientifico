% Calcolo Scientifico
% Terzo Progetto
% Primo Esercizio
% Funzione Eulero Esplicito per parte temporale

function [t,u]=EEtempo(odefun,tspan,u0,L,nX,dt,h,bcfun)

    Nh=ceil((tspan(2)-tspan(1))/dt); % numero di passi temporali
    tt=linspace(tspan(1),tspan(2),Nh+1);
    
    % condizione iniziale
    u(:,1)=u0;
    
    for t=tt(1:end-1)
        u=[u, u(:,end)+dt*odefun(t,u(:,end),L,nX,h,bcfun)];
    end
    
    t=tt;
    
return