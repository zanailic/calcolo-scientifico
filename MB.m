% Secondo Progetto Calcolo Scientifico
% Primo esercizio
% Funzione per il metodo B

function u=MB(t0,y0,T,h,lambda)
n=ceil((T-t0)/h);

u(1)=y0; % u_0
u(2)=exp(lambda*h); % u_1

fcn=@(t,u)lambda*u;

options=optimset('Display','off');
t=t0+h;

% applico il metodo B dato 
% con fsolve risolvo la funzione non lineare ad ogni passo
for i=2:n  
    y=fsolve(@(y) y-4/3*u(i)+1/3*u(i-1)-h*2/3*fcn(t+h,y), u(i), options);
    u(i+1)=y;
end