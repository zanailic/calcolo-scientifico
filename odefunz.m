% funzione per secondo esercizio-metodo di shooting
function f=odefunz(t,y)

t=y(1);
z=y(2);

f=zeros(2,1);
f(1)=z;                %u'=z;
f(2)=sqrt(1+f(1).^2);  %u''=z'=sqrt(1+u'^2)=sqrt(1+z^2)

return 