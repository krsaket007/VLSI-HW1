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
    extern int mul1;
    extern int mul2;
    extern long long _test_start;
    int i;
    long long result=0;
    long long temp1 = abs(mul1);
    long long temp2 = abs(mul2);

    for(i=0;i<32;i++)
    {
        if((temp1 & 0x00000001) == 1)
            result = result + temp2;
        temp2 = temp2 << 1;
        temp1 = temp1 >> 1;
    }

    if(positive(mul1,mul2)==0)
        result = 0 - result;

    //printf("%lX\n",result);

    *(&_test_start)=result;

    return 0;
        
}