# This is hello link program

CFLAGS += -std=c99 -g -Wall

APP := test
OBJS := test.o sort.o

all : hello libhello_dynamic_full.so

hello : hello.o hello_static_implicit.o libhello_static_explicit.a libhello_dynamic_partial.so
	gcc -o hello hello.o hello_static_implicit.o -Wl,-rpath=. -L. -lhello_static_explicit -lhello_dynamic_partial

hello.o : hello.c hello_static_implicit.h hello_static_explicit.h hello_dynamic_partial.h
	gcc -o hello.o -c hello.c

hello_static_implicit.o : hello_static_implicit.c hello_static_implicit.h
	gcc -o hello_static_implicit.o -c hello_static_implicit.c

hello_static_explicit.o : hello_static_explicit.c hello_static_explicit.h
	gcc -o hello_static_explicit.o -c hello_static_explicit.c

libhello_static_explicit.a : hello_static_explicit.o
	ar rv libhello_static_explicit.a hello_static_explicit.o

libhello_dynamic_partial.so : hello_dynamic_partial.c hello_dynamic_partial.h
	gcc -o libhello_dynamic_partial.so -shared hello_dynamic_partial.c

libhello_dynamic_full.so : hello_dynamic_full.c
	gcc -o libhello_dynamic_full.so -shared hello_dynamic_full.c



.PHONY :
clean:
	rm -f hello *.o *.a *.so

