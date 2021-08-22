% Calcolo Scientifico
% Terzo esercizio
% Metodo del punto medio composito

clear all, close all

a=0; b=pi/2;

uex=@(x)(x-(pi/2)*sin(x)); % u esatto
alphaex=@(x)(sin(x)-x.*cos(x));   % alpha=integrale da 0 a x esatto
betaex=@(x)(-sin(x)-cos(x)+(pi/2));  % beta=integrale da x a pi/2 esatto
%alpha=@(y)sin(y);
%beta=@(y)cos(y);
f=@(x)sin(x);
g=@(x)cos(x);
%u=@(x)(-cos(x).*alphaex(x)-sin(x).*betaex(x));
x(1)=0;
u(1)=0;
alpha(1)=0;
beta(1)=0;

z=linspace(0,pi/2);
nn=[20 40 80 160 320];
for k=1:numel(nn)
    n=nn(k);
    h=(b-a)/n;
    hh(k)=h;
    for i=1:n
        x(i+1)=x(i)+h;
        x12=x(i)+h/2;
        %diff(alpha(x12))
        %alpha(i+1)=alpha(i)-h*diff(alpha(x12));
        %beta(i+1)=beta(i)-h*diff(beta(x12));
        %alpha(i+1)=alpha(i)-(x(i)*f(x(i))+2*x12*f(x12)+x(i+1)*f(x(i+1)));
        %beta(i+1)=beta(i)-(x(i)*g(x(i))+2*x12*g(x12)+x(i+1)*g(x(i+1)));
        alpha(i+1)=alpha(i)-(f(x(i+1))-f(x(i)));
        beta(i+1)=beta(i)-(f(x(i+1))-f(x(i)));
        u(i+1)=-g(x(i+1))*alpha(i+1)-f(x(i+1))*beta(i+1);
    end
    figure(1)
    plot(z,uex(z),'r',x,u,'g-.')
    legend('Soluzione esatta','Soluzione numerica')
    err(k)=norm(uex(x)-u,inf);
end
%close all
figure(2)
loglog(hh,err,'-*')
xlabel('h')
ylabel('errore')