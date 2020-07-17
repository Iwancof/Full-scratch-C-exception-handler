#include<stdio.h>

struct MyException{};
int main() {
  try {
    printf("Throw!\n");
    throw MyException();
  } catch(MyException) {
    printf("Caught a MyException\n");
  }
}

