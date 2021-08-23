#include <math.h>
#include <iostream>
#include "problema.h"
using namespace std;
typedef double Real;
// definisco funzione F(t,Y) del sistema
void f_esame(Real F[],Real t,Real U[])
{
    // coefficienti della matrice A
    Real a11 = - 333.4;
    Real a12 = 666.6;
    Real a21 = 333.3;
    Real a22 = - 666.7;
    F[0]=a11*U[0]+a12*U[1];
    F[1]=a21*U[0]+a22*U[1];
}
// dati iniziali
void dati_esame(Real *t0,Real *T,Real v[])
{
    *t0=0;
    *T=3.0;
    v[0]=3;
    v[1]=0;
}
