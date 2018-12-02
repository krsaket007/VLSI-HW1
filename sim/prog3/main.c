#include <stdio.h>

int abs(int value) {
	if (value >= 0 ) return value;
	else return (0-value);
}

int positive(int a, int b) {
	if ((a > 0 && b > 0) || (a < 0 && b < 0)) return 1;
	else return 0;
}

int main(void){
    extern int div1;
    extern int div2;
    extern int _test_start;
    int i,quotient,remain;
    long long temp3 = 0x00000000;
    long long temp1 = abs(div1);
    long long temp2 = abs(div2);

    temp2 = temp2 << 32;

    for(i=0;i<32;i++)
    {
        temp2 = temp2 >> 1;
        temp3 = temp3 << 1;
        if(temp1 >= temp2)
        {
            temp1 = temp1 - temp2;
            temp3 = temp3 + 1;
        }
    }

    if(positive(div1,div2)==0)
        quotient = 0 - temp3;
    else 
        quotient = temp3;

    if(div1 < 0)
        remain = 0 - temp1;
    else
        remain = temp1;

    (&_test_start)[0]=quotient;
    (&_test_start)[1]=remain;

    return 0;
        
}