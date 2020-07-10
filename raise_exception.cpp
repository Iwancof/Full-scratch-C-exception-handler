#include<stdio.h>

#include "raise_exception.h"

void unsafe_function() {
  try {
    //printf("test\n");
    throw SecondException();
  } catch(FirstException x) {
    printf("Unreachable(Catch incorrect exception)\n");
  }
  printf("Unreachable(Exception must be catched)\n");
}

void handler() {
  try {
    unsafe_function();
  } catch(FirstException x) {
    printf("Catch first exception\n");
  } catch(SecondException x) {
    printf("Catch second exception\n");
  }
}



void seppuku() {
  handler();
}
