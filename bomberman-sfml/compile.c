#include <stdlib.h>
#include <stdio.h>
int main()
{
	system("g++ -c main.cpp");
	system("g++ main.o -o game -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio");
	system("./game");
}
