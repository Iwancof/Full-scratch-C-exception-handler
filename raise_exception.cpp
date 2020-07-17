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

void sub() {
  try { // 関数に一つ以上のtry文！
    printf("...\n");
  } catch(Exception) {
    red_println("NG");
  } catch(FakeException) {
    red_println("NG");
  }

  try {
    printf("throw\n");
    throw Exception();
  } catch(FakeException) { // ここではキャッチできない！
    red_println("NG");
  }
  red_println("NG");
}

void handler2() {
  try {
    sub();
  } catch (FakeException) {
    red_println("NG"); // こいつは型が違う
  } catch (Exception) {
    red_println("OK"); // ここでキャッチしてほしい！！！！
  }
}
struct MyException{};
struct YourException{};
struct HerException{};
struct HisException{};

void seppuku() {
    try {
    throw MyException();
  } catch(YourException) {
    printf("Caught YourException\n");
  } catch(HerException) {
    printf("Caught HerException\n");
  } catch(HisException) {
    printf("Caught HisException\n");
  } catch(MyException) {
    printf("Caught MyException\n");
  } catch(...) {
    printf("Caught Exception\n");
  }
  //handler2();
}

