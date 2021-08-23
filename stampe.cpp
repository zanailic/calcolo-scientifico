#include <iostream>
#include <fstream>
#include "stampe.h"
using namespace std;
typedef  double Real;

void stampa(int d,Real t,Real *u,ofstream *prt)
{
    // stampa a video
    if (prt==0){
        cout << t<< "\t";
        for(int i=0;i<d;i++){
            cout << u[i]<<"\t";
        }
        cout <<endl;
    }
    // stampa in file
    else {
        *prt << t<< "\t";
        for(int i=0;i<d;i++){
            *prt << u[i]<<"\t";
        }
        *prt <<endl;
    }
}
