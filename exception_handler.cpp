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
typedef const uint8_t *LSDA_ptr;

// 言語データのフォーマットに従ったCFI(call frame info)
struct LSDA_Header {
  LSDA_Header(LSDA_ptr *lsda) {
    LSDA_ptr read_ptr = *lsda;
    
    start_encoding = read_ptr[0];
    type_encoding = read_ptr[1];
    ttype = read_ptr[2];

    *lsda = read_ptr + sizeof(LSDA_Header);
    // lsdaをずらす。
  }
  uint8_t start_encoding;
  uint8_t type_encoding;
  uint8_t ttype;
};
struct LSDA_Call_Site_Header {
  LSDA_Call_Site_Header(LSDA_ptr *lsda) {
    LSDA_ptr read_ptr = *lsda;
    encoding = read_ptr[0];
    length = read_ptr[1];
    *lsda = read_ptr + sizeof(LSDA_Call_Site_Header);
  }
  uint8_t encoding;
  uint8_t length;
};
struct LSDA_Call_Site {
  LSDA_Call_Site(LSDA_ptr *lsda) {
    LSDA_ptr read_ptr = *lsda;

    start = read_ptr[0];
    len = read_ptr[1];
    lp = read_ptr[2];
    action = read_ptr[3];

    *lsda = read_ptr + sizeof(LSDA_Call_Site);
  }
  uint8_t start; // 関数の開始から、try文まで
  uint8_t len; // tryの長さ
  uint8_t lp; // 関数の開始から、最初のcatch文までの長さ
  uint8_t action; // 復帰するときにしないといけないこと。デストラクタとか。
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

  printf("Personality function called: ");

  if(action & _UA_SEARCH_PHASE) {
    printf("search phase\n");
    return _URC_HANDLER_FOUND;
  } else if(action & _UA_CLEANUP_PHASE) {
    printf("cleanup phace\n");

    LSDA_ptr lsda = (uint8_t*)_Unwind_GetLanguageSpecificData(context);

    LSDA_Header header(&lsda);
    LSDA_Call_Site_Header cs_header(&lsda);
    const LSDA_ptr lsda_cs_table_end = lsda + cs_header.length;

    while(lsda < lsda_cs_table_end) {
      LSDA_Call_Site cs(&lsda);
      if(cs.lp != 0) {
	int r0 = __builtin_eh_return_data_regno(0);
	int r1 = __builtin_eh_return_data_regno(1);

	_Unwind_SetGR(context, r0, (uintptr_t)(unwind_exception));
	_Unwind_SetGR(context, r1, (uintptr_t)(1));

	uintptr_t func_start = _Unwind_GetRegionStart(context);
	_Unwind_SetIP(context, func_start + cs.lp);

	break;
      }
    }

    return _URC_INSTALL_CONTEXT;
  } else {
    printf("unexpected action\n");
    return _URC_FATAL_PHASE1_ERROR;
  }
}

