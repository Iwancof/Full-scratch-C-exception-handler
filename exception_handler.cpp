#include<stdio.h>

namespace __cxxabiv1 {
    struct __class_type_info {
        virtual void foo() {}
    } ti;
}

extern "C" {
  void* __cxa_allocate_exception(size_t);
  void __cxa_throw(void*, struct type_info *, void (*dest)(void*));
}

void* __cxa_allocate_exception(size_t thrown_size) {
}

void __cxa_throw(
          void* thrown_exception,
          struct type_info *tinfo,
          void (*dest)(void*)) {

  printf("Hello\n");
}