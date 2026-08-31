#include <stdio.h>

int main(){
    int a = 0, b = 1, sig = 0;

    //imprime los primeros diez numeros de la seire
    for(int i = 0; i < 10; i++){
        printf("%d\t", a);
        
        sig = a + b; //se calcula el siguiente valor
        //se actualizan los siguentes valoress
        a = b;
        b = sig;
    }
    
}