% funzione per secondo esercizio-metodo di shooting
function F=shoot(s)

global a b xa xb

[t,x]=ode45(@odefunz,[a,b],[xa,s]);

F=x(end,1)-xb;

return