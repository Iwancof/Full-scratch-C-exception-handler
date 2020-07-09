
.PHONY: all clean
all: main
	echo "main"

clean: 
	powershell "rm *.o"
	powershell "rm *.exe"

exception_handler:
	g++ exception_handler.cpp -o exception_handler.o -c

raise_exception:
	g++ raise_exception.cpp -o raise_exception.o -c

main: exception_handler raise_exception
	gcc main.c raise_exception.o exception_handler.o -o a.exe
