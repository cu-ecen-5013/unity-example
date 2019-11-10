#include "file1.h"
#include "file2.h"
#include <stdio.h>

int main(int argc, char**argv)
{
	printf("Hello World!\n");
	file1_hello();
	file2_hello();
	return 0;
}
