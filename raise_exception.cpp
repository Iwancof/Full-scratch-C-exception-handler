#include<stdio.h>

#include "raise_exception.h"

void unsafe_function() {
  try {
    printf("nothing to do...\n");
  } catch(FirstException& x) {
    printf("Caught exception in wrong catch block...\n");
  }

  try {
    throw SecondException();
  } catch(FirstException& x) {
    printf("Caught a FirstException\n");
  }
  printf("End of unsafe_function\n");
}

void handler() {
  try {
    unsafe_function();
  } catch(FirstException& x) {
    printf("Caught a First exception\n");
  } catch(SecondException& x) {
    printf("Caught a Second exception\n");
  }
  printf("End of handler\n");
}

void seppuku() {
  handler();
}

