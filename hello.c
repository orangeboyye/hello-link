#include <stdio.h>
#include <dlfcn.h>

#include "hello_static_implicit.h"
#include "hello_static_explicit.h"
#include "hello_dynamic_partial.h"


void say_hello_direct()
{
	printf("say hello direct\n");
}

int main(int argc, char const *argv[])
{

	printf("----------------------------------\n");
	say_hello_direct();
	printf("----------------------------------\n");
	say_hello_static_implicit();
	printf("----------------------------------\n");
	say_hello_static_explicit();
	printf("----------------------------------\n");
	say_hello_dynamic_partial();
	printf("----------------------------------\n");
	void *handle = dlopen("./libhello_dynamic_full.so", RTLD_LAZY);
	void (*say_hello_dynamic_full)(void);
	say_hello_dynamic_full = (void (*)(void))dlsym(handle, "say_hello_dynamic_full");
	say_hello_dynamic_full();
	dlclose(handle);
	printf("----------------------------------\n");

	return 0;
}




