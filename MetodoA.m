% Secondo Progetto Calcolo Scientifico
% Primo esercizio
% Metodo A-un metodo esplicito a tre passi
% Al variare di h

clear all, close all

t0=0; T=1;
lambda=-1;
y0=1;
hh=[0.1 0.05 0.025 0.0125];

cont=0;
for l=1:numel(hh)
    cont=cont+1;
    h=hh(l);
    n=ceil((T-t0)/h);
    t=[t0:h:T];
    
    u_ex=exp(lambda*t); % soluzione esatta del pb.
    u=MA(t0,y0,T,h,lambda); % soluzione con il metodo A
    
    subplot(2,2,cont);
    figure(1), plot(t, u, 'r-*'), hold on, plot(t, u_ex, 'b');
    xlabel('t')
    ylabel('u(t)')
    legend('soluzione numerica','soluzione esatta');
    
    err(cont)=abs(u-u_ex);
end

err