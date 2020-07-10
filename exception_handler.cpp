#include<stdio.h>
#include<stdlib.h>
#include<unwind.h>
#include<stdint.h>

namespace __cxxabiv1 {
    struct __class_type_info {
        virtual void foo() {}
    } ti;
}

extern "C" {
  void* __cxa_allocate_exception(size_t);
  void __cxa_throw(void*, struct type_info *, void (*dest)(void*));
  void __cxa_begin_catch();
  void __cxa_end_catch();
  _Unwind_Reason_Code __gxx_personality_v0(int, _Unwind_Action, uint64_t, _Unwind_Exception*, _Unwind_Context*);
}

typedef void (*unexpected_handler)(void);
typedef void (*terminate_handler)(void);

struct __cxa_exception { 
	std::type_info *	exceptionType;
	void (*exceptionDestructor) (void *); 
	unexpected_handler	unexpectedHandler;
	terminate_handler	terminateHandler;
	__cxa_exception *	nextException;

	int			handlerCount;
	int			handlerSwitchValue;
	const char *		actionRecord;
	const char *		languageSpecificData;
	void *			catchTemp;
	void *			adjustedPtr;

	_Unwind_Exception	unwindHeader;
};

// 例外用のメモリを確保
void* __cxa_allocate_exception(size_t thrown_size) {
  printf("allocate exception. size is %ld\n", thrown_size);
  void* ret = malloc(thrown_size);
  if(ret == NULL) {
    printf("allocate failed\n");
    exit(0);
  }
  return ret;
}

// 開放
void __cxa_free_exception(void *exception_ptr) {
  free(exception_ptr);
}

// 例外がスロー
void __cxa_throw(
          void* thrown_exception,
          struct type_info *tinfo,
          void (*dest)(void*)) {
  printf("throw exception!!\n");

  __cxa_exception *header = ((__cxa_exception *)thrown_exception - 1); // -1はわからん
  _Unwind_RaiseException(&header->unwindHeader);

  exit(0);
}

void __cxa_begin_catch() {
  printf("__cxa_begin_catch called\n");
}

void __cxa_end_catch() {
  printf("__cxa_end_catch called\n");
}

_Unwind_Reason_Code __gxx_personality_v0(
    int version,
    _Unwind_Action action,
    uint64_t exceptionClass,
    _Unwind_Exception *unwind_exception,
    _Unwind_Context *context) {

  printf("Personality function called\n");

  if(action & _UA_SEARCH_PHASE) {
    printf("search phase\n");
    return _URC_HANDLER_FOUND;
  } else if(action & _UA_CLEANUP_PHASE) {
    printf("cleanup phace\n");
    return _URC_INSTALL_CONTEXT;
  } else {
    printf("unexpected action\n");
    return _URC_FATAL_PHASE1_ERROR;
  }
}

