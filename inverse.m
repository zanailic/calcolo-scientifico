% Calcolo Scientifico
% Quarto Progetto
% Primo Esercizio
% Problema Inverso

clear all, close all

nn=[8 16 32 64]; % il numero di intervalli
for n=nn
    m=100; % per s
    K=@(s,t)s.*(t-1)*(s<t)+t.*(s-1)*(s>=t); % kernel K(s,t)

    % metodo del punto medio (punti medi tra 0 e 1)
    ds=1/m;
    s=ds/2:ds:1-ds/2;
    dth=1/n;
    t=dth/2:dth:1-dth/2;
    for i=1:m
        for j=1:n
            KK(i,j)=K(s(i),t(j));
        end
    end
    A=1/n*KK; % la matrice A
end

%% decomposizione in valori singolari (SVD) per n=64

n=64;
cond(A);
rank(A);
[U,S,V]=svd(A);

for j=1:n
    mu(j)=1/(pi*j)^2; % valori singolari esatti
    err(j)=abs(S(j,j)-mu(j)); % errore
end

% il grafico dell'errore tra valori singolari esatti e
% valori singolari ottenuti
figure(1), plot(err,'r-o')
xlabel('i');
ylabel('errore');
figure(2), plot(err,'r-o')
xlabel('i');
ylabel('errore');
xlim([30 60]);

%% le funzioni g,f esatte; il rumore gaussiano

% la funzione g data:
g=@(s)((4*s^3-3*s)/24)*(s<1/2)+((-4*s^3+12*s^2-9*s+1)/24)*(s>=1/2);
% la funzione f=g'' esatta:
f_ex=@(t)t*(t<0.5)+(1-t)*(t>=0.5);

for i=1:m
    for j=1:n  
        gg(i)=g(s(i));
        ff_ex(j)=f_ex(t(j));
    end
end
f=A\gg'; % f ottenuta

% il grafico di f esatto vs. f ottenuto
figure(3), plot(t,ff_ex,'k','LineWidth',2), hold on
plot(t,f,'c','LineWidth',2), hold on
legend('f(t) esatto','f(t) ottenuto'), 
xlabel('t'), ylabel('f(t)'), hold off

% perturbazione di dati gg_i con un rumore gaussiano->g_p
var=(5e-5)^2;
gp=gg+sqrt(var)*randn(size(gg));

% il grafico di g esatto vs. g con rumore gaussiano
figure(4), plot(s,gg,'k'), hold on
plot(s,gp,'y'), hold on
legend('g(s) esatto','g(s) con rumore gaussiano'), 
xlabel('s'), ylabel('g(s)'), hold off

%% la soluzione "naive"

fp=A\gp'; 
% il grafico di f esatto vs. f naive
figure(5), plot(t,ff_ex,'m','LineWidth',2), hold on
plot(t,fp,'c','LineWidth',2), hold on
legend('f(t) esatto','f_N(t) naive')
xlabel('t'), ylabel('f(t)'), hold off


%% regolarizzazione di Tikhonov

Id=eye(size(A'*A));
lambda_grande=1e-3;
lambda_piccolo=1e-7;
flambda_grande=(A'*A+lambda_grande*Id)\(A'*gp');
flambda_piccolo=(A'*A+lambda_piccolo*Id)\(A'*gp');
% il grafico
figure(6), plot(t,ff_ex,'m','LineWidth',2), hold on
plot(t,flambda_grande,'b','LineWidth',2), hold on
plot(t,flambda_piccolo,'c','LineWidth',2), hold on
legend('f(t) esatto','f_{\lambda}(t) con \lambda grande','f_{\lambda}(t) con \lambda piccolo')
xlabel('t'), ylabel('f(t)'), hold off

% L-curve
lambda=logspace(-10,-1,1000);
Id=eye(size(A'*A));
for i=1:numel(lambda)
    flambda=(A'*A+lambda(i)*Id)\(A'*gp');
    norma(i)=norm(flambda,2);
    res(i)=norm(A*flambda-gp',2);
end
figure(7), loglog(res,norma,'b','LineWidth',2)
xlabel('norma residuo ||A*f_{\lambda}-g||')
ylabel('norma soluzione ||f_{\lambda}||')

%% regolarizzazione TSVD

% il grafico dei valori singolari
figure(8), plot(diag(S),'m-o');
xlabel('i')
ylabel('\sigma_i')

% TSVD
soglia=0.001;
for i=1:n
    if( S(i,i)<soglia )
        S(i,i)=0;
    end
end
Ak=U*S*V';
fk=Ak\gp';
figure(9), plot(t,ff_ex,'m','LineWidth',2), hold on
plot(t,fk,'c','LineWidth',2), hold on
legend('f(t) esatto','f_k(t) con TSVD')
xlabel('t'), ylabel('f(t)'), hold off
