
all:	x

x:	main.o dot_prod.o 
	gcc -o x main.o dot_prod.o

main.o:	main.s
	gcc -c main.s

main.s:	main.c
	gcc -O2 -S main.c

dot_prod.o:	dot_prod.s
	gcc -g -c dot_prod.s

clean:	
	rm -f x *.o main.s
