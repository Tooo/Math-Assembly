
all:	x

x:	main.o sqrt.o
	gcc -o x sqrt.o main.o

main.o:	main.s
	gcc -c main.s

sqrt.o:	sqrt.s
	gcc -g -c sqrt.s

main.s:	main.c
	gcc -fno-builtin -O2 -S main.c

clean:	
	rm -f x bonux *.o main.s
