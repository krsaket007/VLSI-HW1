#include <stdio.h>

int main(void){
    extern int array_size;
    extern int array_addr;
    extern int _test_start;
    int i,j,temp;
    int data[array_size];

    for(i=0;i<array_size;i++)
        data[i]=(&array_addr)[i];


    for(i=0;i<array_size;i++)
    {
        for(j=0;j<array_size-1;j++)
        {
            if(data[j]>data[j+1])
            {
                temp=data[j];
                data[j]=data[j+1];
                data[j+1]=temp;
            }
        }
    }
    for(i=0;i<array_size;i++)
        (&_test_start)[i]=data[i];

    return 0;
        
}