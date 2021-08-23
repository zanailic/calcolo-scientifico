#include "mat_vet.h"
#include <iostream>
#include <math.h>
using namespace std;
typedef  double Real;

void matmat(Real *A, Real *B, Real *Ris, int ra, int ca, int cb)
// calcola prodotto di matrice A di dimensione ra*ca
// per matrice B di dimensione rb*cb con ca=rb
// A*B = Ris; Ris di dimenisone ra*cb
{
    for (int i=0; i<ra; i++){
        for (int j=0; j<cb; j++){
                Real sum=0.0;
                for (int k=0; k<ca; k++){
                        sum += (*(A+i*ca+k))*(*(B+j+k*cb));
                }
                *(Ris+i*cb+j)=sum;
        }
    }
}
