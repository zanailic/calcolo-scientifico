% Secondo Progetto Calcolo Scientifico
% Primo esercizio
% Funzione per il metodo A

function u=MA(t0,y0,T,h,lambda)
n=ceil((T-t0)/h);
t=[t0:h:T];

u(1)=y0; % u_0
u(2)=exp(lambda*h); % u_1
u(3)=exp(lambda*2*h); % u_2

% applico il metodo A dato 
for i=3:n
    f(i)=lambda*u(i);
    u(i+1)=u(i)+h/12*(23*f(i)-16*f(i-1)+5*f(i-2));
end