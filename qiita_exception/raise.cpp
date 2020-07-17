#include<stdio.h>

struct MyException{};
struct YourException{};
struct HerException{};
struct HisException{};
struct SomeException{};

void sub() {
  try {
    throw MyException();
  } catch(YourException) {
    printf("Caught YourException\n");
  }
}

int main() {
  try {
    sub();
  } catch(MyException) {
    printf("Caguth MyException\n");
  }
}


/*
int main() {
  try {
    asm("nop");
    printf("1\n");
  } catch(MyException) {
    printf("caught\n");
  }

  try {
    asm("nop");
    asm("nop");
    printf("2\n");
  } catch(MyException) {
    printf("caught\n");
  }

  try {
    asm("nop");
    asm("nop");
    asm("nop");
    printf("3\n");
    throw MyException();
  } catch(MyException) {
    printf("caught\n");
  }

  try {
    asm("nop");
    asm("nop");
    asm("nop");
    asm("nop");
    printf("4\n");
  } catch(MyException) {
    printf("caught\n");
  }
}

*/
