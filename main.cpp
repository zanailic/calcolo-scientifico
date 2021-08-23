#include <iostream>
#include <math.h>
#include <fstream>
#include "C:\Users\Korisnik\Desktop\progetto\progetto_c++\Runge_Kutta_matrici.h"
#include "C:\Users\Korisnik\Desktop\progetto\progetto_c++\problema.h"
#include "C:\Users\Korisnik\Desktop\progetto\progetto_c++\stampe.h"
#include "C:\Users\Korisnik\Desktop\progetto\progetto_c++\mat_vet.h"

using namespace std;
typedef double Real;

int main ()
{
    int l=0;
    cout << "Vuoi fare prima, seconda o terza parte di esercizio? (1,2,3): ";
    cin >> l ;

    char n_file[21]= "progetto.dat";
    ofstream prt(n_file);

    prt.precision(14);
    void(*effe)(Real*,Real,Real*);
    void(*dati)(Real *,Real *,Real *);
    unsigned long N;
    unsigned long n;

    const int d=2;
    effe=f_esame;
    dati=dati_esame;

    Real t,T,u[d];
    dati(&t,&T,u);

    // scelta del metodo esplicito EE, Heun, RK4, F5
    // scelta del metodo adattivo EEHEUN, RKF54
    char metodo[]="RK4";

    // numero degli stadi del metodo scelto
    // EE = 2; Heun = 2; RK4 = 4; F5 = 6
    // EEHEUN = 2; RKF54 = 6;
    const int s=4;

    // ordine p, serve solo per metodi adattivi
    // EEHEUN = 2; RKF54 = 5;
    const int p=5;

    // dimensiono array di Butcher
    Real b[s]={0};
    Real bc[s]={0};
    Real bnuovo[s]={0};
    Real c[s]={0};
    Real A[s][s]={{0}};

    Real K[s][d] = {{0}};
    Real V[d] = {0};
    Real Somma[d] = {0};
    Real Sommanuova[d] = {0};
    Real tau;
    Real tn;
    Real un[d] = {0};
    // valutazioni di effe
    Real m = 0;

    switch(l) {
        case 1:{
//**************************************//
//       PRIMA PARTE DI ESERCIZIO       //
//**************************************//
        // assegno valori array di Butcher;
        set_Runge_Kutta_esp(metodo,A[0],b,c);

        cout << "Numero di passi N: ";
        cin >> N;
        tau=(T-t)/Real(N);

        stampa(d,t,u,&prt);
        stampa(d,t,u);

        for(n=1; n<=N; n++)
        {
            // Calcola k_1
            effe(K[0],t,u);
            m = m+1;

            for (int i=1; i<s; i++)
            {
                // Calcola V = Sum(A*K)
                matmat(A[i], K[0], V, 1, i, d);

                // u=u_n+tau*V
                for(int j=0; j<d; j++)
                {
                    un[j] = u[j] + tau*V[j];
                }

                // t=t_n+tau*c
                tn = t + tau*c[i];

                // k_i=effe(K[i],tn,un)
                effe(K[i],tn,un);
                m = m+1;
            }
            // Somma=Sum(b*K)
            matmat(b, K[0], Somma, 1, s, d);

            for(int i=0; i<d; i++)
            {
                u[i] = u[i] + tau*Somma[i];
            }

            t+=tau;

            stampa(d,t,u,&prt);
            stampa(d,t,u);
        }
        //cout << "Valutazioni di f: " << m << "\n";
        }
        break;

        case 2:{
//**************************************//
//     SECONDA PARTE DI ESERCIZIO       //
//**************************************//
        // assegno valori array di Butcher;
        set_Runge_Kutta_esp(metodo,A[0],b,c);

        N = 512;
        tau = 1.0/10240.0;

        stampa(d,t,u,&prt);
        stampa(d,t,u);

        for(n=1; n<=N; n++)
        {
            // Calcola k_1
            effe(K[0],t,u);

            for (int i=1; i<s; i++)
            {
                // Calcola V = Sum(A*K)
                matmat(A[i], K[0], V, 1, i, d);

                // u=u_n+tau*V
                for(int j=0; j<d; j++)
                {
                    un[j] = u[j] + tau*V[j];
                }

                // t=t_n+tau*c
                tn = t + tau*c[i];

                // k_i=effe(K[i],tn,un)
                effe(K[i],tn,un);
            }
            // Somma=Sum(b*K)
            matmat(b, K[0], Somma, 1, s, d);

            for(int i=0; i<d; i++)
            {
                u[i] = u[i] + tau*Somma[i];
            }

            t+=tau;

            stampa(d,t,u,&prt);
            stampa(d,t,u);
        }

        t = 0.05;
        tau = 1.0/10.0;
        N = 30;

        for(n=1; n<=N; n++)
        {
            // Calcola k_1
            effe(K[0],t,u);

            for (int i=1; i<s; i++)
            {
                // Calcola V = Sum(A*K)
                matmat(A[i], K[0], V, 1, i, d);

                // u=u_n+tau*V
                for(int j=0; j<d; j++)
                {
                    un[j] = u[j] + tau*V[j];
                }

                // t=t_n+tau*c
                tn = t + tau*c[i];

                // k_i=effe(K[i],tn,un)
                effe(K[i],tn,un);
            }
            // Somma=Sum(b*K)
            matmat(b, K[0], Somma, 1, s, d);

            for(int i=0; i<d; i++)
            {
                u[i] = u[i] + tau*Somma[i];
            }

            t+=tau;

            stampa(d,t,u,&prt);
            stampa(d,t,u);
        }
        }
        break;

        case 3:{
//**************************************//
//       TERZA PARTE DI ESERCIZIO       //
//    per questa parte di esercizio     //
//  si deve cambiare il nome di metodo, //
//      numero di stadi e ordine        //
//        in righe 36, 41 e 45          //
//**************************************//
        // assegno valori array di Butcher;
        set_Runge_Kutta_ad(metodo,A[0],b,bc,c);

        Real toll;
        // tolleranza toll = 1e-3, 1e-6, 1e-9
        cout << "Inserisci tolleranza: ";
        cin >> toll ;

        // tentativo per il primo passo
        Real tau = 0.1;
        Real r = 0.5;
        Real err, taunuovo;
        n = 0;

        stampa(d,t,u,&prt);
        stampa(d,t,u);

        while(t < T)
        {
            effe(K[0],t,u);
            m = m+1;

            for (int i=1; i<s; i++)
            {
                // Calcola V = Sum(A*K)
                matmat(A[i], K[0], V, 1, i, d);

                // u=u_n+tau*V
                for(int j=0; j<d; j++)
                {
                    un[j] = u[j] + tau*V[j];
                }

                // t=t_n+tau*c
                tn = t + tau*c[i];

                // k_i=effe(K[i],tn,un)
                effe(K[i],tn,un);
                m = m+1;
            }
            // Somma=Sum(b*K)
            matmat(b, K[0], Somma, 1, s, d);

            // Sommanuova=Sum((b-bc)*K)
            for (int i=0; i<s; i++){
                bnuovo[i] = b[i] - bc[i];
            }
            matmat(bnuovo, K[0], Sommanuova, 1, s, d);

            // norma 2 di Sommanuova
            Real accumul = 0;
            for(int i=0; i<d; i++){
                accumul += Sommanuova[i]*Sommanuova[i];
            }

            err = tau * sqrt(accumul);
            taunuovo = pow((r*toll/err),1.0/p)*tau;

            if (err <= toll){
                for(int i=0; i<d; i++){
                    u[i] = u[i] + tau*Somma[i];
                }
                t += tau;
                tau = min(taunuovo,T-t);
                n = n+1;
                stampa(d,t,u,&prt);
                stampa(d,t,u);
            }
            else{
                tau = taunuovo;
            }
        }
        cout << "Numero di passi: " << n << "\n";
        cout << "Valutazioni di f: " << m << "\n";
        Real pf = m/s;
        cout << "Numero di passi con metodo a passo fisso: " << pf << "\n";
        }
        break;
    }

//*********************************************//
//   SE VOGLIAMO CALCOLARE ERRORE FINALE       //
//           IN NORMA DUE                      //
//*********************************************//
    // soluzione esatta
    Real sol[2];
    sol[0] = 2.0*exp(-0.1*t) + exp(-1000.0*t);
    sol[1] = exp(-0.1*t) - exp(-1000.0*t);

    // errore finale in norma due
    Real accum = 0;
    for(int i=0;i<d;i++){
        accum += (sol[i]-u[i])*(sol[i]-u[i]);
    }
    Real norm = sqrt(accum);
    cout << "Errore finale in norma 2: " << norm << "\n";

    return 0;
}
