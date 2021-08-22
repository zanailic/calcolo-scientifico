% Primo Progetto Calcolo Scientifico
% Primo Esercizio

clear all, close all

f=@(x)sin(x);
df=@(x)cos(x); % derivata esatta di f

h=logspace(0,-16,16);
x0=1;

for i=1:numel(h)
    derf=(3*(f(x0))-4*(f(x0-h(i)))+f(x0-2*h(i)))/(2*h(i)); 
    err(i)=abs(derf-df(x0));
end

loglog(h,err,'b');
xlabel('h');
ylabel('errore');
hold on
grid