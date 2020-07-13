#include<stdio.h>
#include<stdlib.h>

#include "raise_exception.h"
/*
void unsafe_function() {
  try {
    printf("[unsafe_function] nothing to do...\n");
  } catch(FirstException& x) {
    printf("[unsafe_function] Caught exception in wrong catch block...\n");
  }

  try {
    throw SecondException();
  } catch(FirstException& x) {
    printf("[unsafe_function] Caught a FirstException\n");
  }
  printf("[unsafe_function] End\n");
}

void handler() {
  try {
    unsafe_function();
  } catch(FirstException& x) {
    printf("[handler] Caught a First exception\n");
  } catch(SecondException& x) {
    printf("[handler] Caught a Second exception\n");
  }
  printf("[handler] End of handler\n");
}
*/
void red_println(char* str) {
  printf("\x1b[41m %s \x1b[40m\n", str);
}

void handler2() {
  try {
    printf("throw!!\n");
    throw SecondException();
  } catch(FirstException) {
    red_println("NG");
  } catch(SecondException) {
    red_println("OK");
  }
}

void seppuku() {
  handler2();
}

