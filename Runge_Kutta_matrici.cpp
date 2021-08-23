using namespace std;
typedef double Real;
#include <string.h>
#include <math.h>
#include "Runge_Kutta_matrici.h"
// s-stadi
// Metodi di Runge Kutta espliciti
void set_Runge_Kutta_esp(char *metodo,Real*A,Real b[],Real c[]){
    int s;
    int m=0;
    if(strcmp(metodo,"EE")==0){m=1;s=1;} // Eulero Esplicito
    if(strcmp(metodo,"Heun")==0){m=2;s=2;} // Heun
    if(strcmp(metodo,"RK4")==0){m=3;s=4;} // Runge-Kutta
    if(strcmp(metodo,"F5")==0){m=4;s=6;} // Fehlberg 5

// assegno valori matrice e vettori
        switch(m) {
        case 1:{
//          Eulero Esplicito
            b[0]=1.0;
        }
        break;
        case 2:{
//          Heun
            b[0]=b[1]=0.5;
            *(A+2)=1.0;
            }
        break;
        case 3:{
//          Runge-Kutta 4
            b[0]=b[3]=1.0/6.0;
            b[1]=b[2]=1.0/3.0;
            *(A+4)=*(A+9)=0.5;
            *(A+14)=1.0;
            }
        break;
        case 4:{
//          Fehlberg 5
            b[0]=16.0/135.0;
            b[1]=0.0;
            b[2]=6656.0/12825.0;
            b[3]=28561.0/56430.0;
            b[4]=-9.0/50.0;
            b[5]=2.0/55.0;
            //riga 2
            *(A+6)=0.25;
            //riga 3
            *(A+12)=3.0/32.0;
            *(A+13)=9.0/32.0;
            //riga 4
            *(A+18)=1932.0/2197.0;
            *(A+19)=-7200.0/2197.0;
            *(A+20)=7296.0/2197.0;
            //riga 5
            *(A+24)=439.0/216.0;
            *(A+25)=-8.0;
            *(A+26)=3680.0/513.0;
            *(A+27)=-845.0/4104.0;
            //riga 6
            *(A+30)=-8.0/27.0;
            *(A+31)=2.0;
            *(A+32)=-3544.0/2565.0;
            *(A+33)=1859.0/4104.0;
            *(A+34)=-11.0/40.0;
        }
        break;
        }
// calcolo C
        for(int k=0;k<s;k++){
                        Real sum=*(A+k*s);
            for (int j=1;j<s;j++){
            sum+=*(A+s*k+j);
            }
        c[k]=sum;
        }
}

// Metodi di Runge Kutta immersi, con passo addativo
void set_Runge_Kutta_ad(char *metodo,Real*A,Real b[],Real bc[],Real c[]){
    int ns;
    int m=0;
    if(strcmp(metodo,"RKF54")==0){m=1;ns=6;} // Runge–Kutta–Fehlberg 5(4)
    if(strcmp(metodo,"EEHEUN")==0){m=2;ns=2;} // Eulero Esplicito/Heun

// assegno valori matrice e vettori
    switch(m) {
    case 1:{
//      RKF54
        b[0]=16.0/135.0;
        b[1]=0.0;
        b[2]=6656.0/12825.0;
        b[3]=28561.0/56430.0;
        b[4]=-9.0/50.0;
        b[5]=2.0/55.0;
        bc[0]=25.0/216.0;
        bc[1]=0.0;
        bc[2]=1408.0/2565.0;
        bc[3]=2197.0/4104.0;
        bc[4]=-1.0/5.0;
        bc[5]=0.0;
        //riga 2
        *(A+6)=0.25;
        //riga 3
        *(A+12)=3.0/32.0;
        *(A+13)=9.0/32.0;
        //riga 4
        *(A+18)=1932.0/2197.0;
        *(A+19)=-7200.0/2197.0;
        *(A+20)=7296.0/2197.0;
        //riga 5
        *(A+24)=439.0/216.0;
        *(A+25)=-8.0;
        *(A+26)=3680.0/513.0;
        *(A+27)=-845.0/4104.0;
        //riga 6
        *(A+30)=-8.0/27.0;
        *(A+31)=2.0;
        *(A+32)=-3544.0/2565.0;
        *(A+33)=1859.0/4104.0;
        *(A+34)=-11.0/40.0;
        }
    break;

    case 2:{
//       EEHEUN
        b[0]=0.5;
        b[1]=0.5;
        bc[0]=1.0;
        bc[1]=0.0;
        //riga 2
        *(A+2)=1.0;
        }
    break;
    }
// calcolo C
          for(int k=0;k<ns;k++){
            Real sum=*(A+k*ns);
            for (int j=1;j<ns;j++){
            sum+=*(A+ns*k+j);
            }
        c[k]=sum;
         }
}
