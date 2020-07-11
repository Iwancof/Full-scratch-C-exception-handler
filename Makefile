
.PHONY: all clean
all: main
	echo "main"

clean: 
	rm *.o *.exe *.out -f

exception_handler:
	g++ exception_handler.cpp -o exception_handler.o -c -g

raise_exception:
	g++ raise_exception.cpp -o raise_exception.o -c -g

main: exception_handler raise_exception
	gcc main.c raise_exception.o exception_handler.o -o a.out -g


