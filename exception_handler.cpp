#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<unwind.h>
#include<stdint.h>
#include<typeinfo>

namespace __cxxabiv1 {
    struct __class_type_info {
        virtual void foo() {}
    } ti;
}

extern "C" {
  void* __cxa_allocate_exception(size_t);
  void __cxa_throw(void*, std::type_info *, void (*dest)(void*));
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
unsigned int read_uleb(LSDA_ptr *lsda);

// 言語データのフォーマットに従ったCFI(call frame info)
struct LSDA_Header {
  LSDA_Header(LSDA_ptr *lsda) {
    LSDA_ptr read_ptr = *lsda;
    
    start_encoding = read_ptr[0];
    type_encoding = read_ptr[1];
    *lsda = read_ptr
      + sizeof(start_encoding)
      + sizeof(type_encoding);
    // lsdaをずらす。
    types_table_offset = read_uleb(lsda);

    /*
    printf(" -- LSDA_Header --\n");
    printf(" start_encoding: %x\n", start_encoding);
    printf(" type_encoding: %x\n", type_encoding);
    printf(" types_table_offset: %x\n", types_table_offset);
    printf(" -----------------\n");
    */
  }
  uint8_t start_encoding;
  uint8_t type_encoding;
  int types_table_offset;
};
struct LSDA_Call_Site_Header {
  LSDA_Call_Site_Header(LSDA_ptr *lsda) {
    LSDA_ptr read_ptr = *lsda;
    encoding = read_ptr[0];
    *lsda = read_ptr + sizeof(encoding);
    length = read_uleb(lsda);

    /*
    printf(" -- LSDA_Call_Site_Header --\n");
    printf(" encoding: %x\n", encoding);
    printf(" length: %x\n", length);
    printf(" ---------------------------\n");
    */
  }
  uint8_t encoding;
  int length;
};
struct LSDA_Call_Site {
  LSDA_Call_Site(LSDA_ptr *lsda) {
    //LSDA_ptr read_ptr = *lsda;
    start = read_uleb(lsda);
    len = read_uleb(lsda);
    lp = read_uleb(lsda);
    action = read_uleb(lsda);

    //*lsda = read_ptr + sizeof(LSDA_Call_Site);
  }
  unsigned int start; // 関数の開始から、それぞれの処理まで
  unsigned int len; // tryの長さ
  unsigned int lp; // 関数の開始から、最初のcatch文までの長さ
  unsigned int action; // 復帰するときにしないといけないこと。デストラクタとか。
};

int _main() {
  uint8_t array[] = {2, 127, 128, 1, 129, 1, 185, 100};

  LSDA_ptr ptr = array;
  int ret = read_uleb(&ptr);
  printf("value is %d\n", ret);
  ret = read_uleb(&ptr);
  printf("value is %d\n", ret);
  ret = read_uleb(&ptr);
  printf("value is %d\n", ret);
  ret = read_uleb(&ptr);
  printf("value is %d\n", ret);
  ret = read_uleb(&ptr);
  printf("value is %d\n", ret);

  return 0;
}

unsigned int read_uleb(LSDA_ptr *lsda) {
  int ret = 0;
  int depth = 0;
  while(1) {
    uint8_t value = **lsda;
    if((value & 0x80) == 0x80) { // continue
      value &= 0x7f;
      ret += (value << (depth * 7));
      depth++;
      (*lsda)++;
      continue;
    }
    value &= 0x7f;
    ret += value << (depth * 7);
    (*lsda)++;
    return ret;
  }
}
static const unsigned char *
read_sleb128 (const unsigned char *p, _sleb128_t *val)
{
  unsigned int shift = 0;
  unsigned char byte;
  _uleb128_t result;
  result = 0;
  do
    {
      byte = *p++;
      result |= ((_uleb128_t)byte & 0x7f) << shift;
      shift += 7;
    }
  while (byte & 0x80);
  /* Sign-extend a negative value.  */
  if (shift < 8 * sizeof(result) && (byte & 0x40) != 0)
    result |= -(((_uleb128_t)1L) << shift);
  *val = (_sleb128_t) result;
  return p;
}

// 例外用のメモリを確保
void* __cxa_allocate_exception(size_t thrown_size) {
  //printf("allocate exception. size is %ld\n", thrown_size);
  void* ret = malloc(3 * thrown_size * sizeof(__cxa_exception));
  if(ret == NULL) {
    printf("allocate failed\n");
    exit(0);
  }
  //printf("allocated pointer is %p\n", ret);
  return ret;
}

// 開放
void __cxa_free_exception(void *exception_ptr) {
  free(exception_ptr);
}

// 例外がスロー
void __cxa_throw(
          void* thrown_exception,
          std::type_info *tinfo,
          void (*dest)(void*)) {
  /*
  printf("thrown exception!!\n");
  printf("thrown exception pointer is %p\n", thrown_exception);
  printf("tinfo pointer is %p\n", tinfo);
  printf("destractor pointer is %p\n", dest);
  */

  __cxa_exception *header = ((__cxa_exception *)thrown_exception + 1); // -1はわからん
  header->exceptionType = tinfo;
  _Unwind_RaiseException(&header->unwindHeader);

  exit(0);
}

void __cxa_begin_catch() {
  //printf("__cxa_begin_catch called\n");
}

void __cxa_end_catch() {
  //printf("__cxa_end_catch called\n");
}

#include "unwind-cxx.h"

int saved_handler_number;
_Unwind_Ptr saved_landing_point;

void save_exception_info(
    _Unwind_Exception* exc,
    _Unwind_Context* context,
    int hand_num,
    _Unwind_Ptr lp
    ) {
  saved_handler_number = hand_num;
  saved_landing_point = lp;
  /*
  exc->barrier_cache.sp = _Unwind_GetGR(context, UNWIND_STACK_REG);
  exc->barrier_cache.bitpattern[1] = hand_num;
  exc->barrier_cache.bitpattern[3] = lp;
  */
}

void store_exception_info(
    _Unwind_Exception* exc,
    int* hand_num,
    _Unwind_Ptr* lp) {
  *hand_num = saved_handler_number;
  *lp = saved_landing_point;
}


_Unwind_Reason_Code __gxx_personality_v0(
    int version,
    _Unwind_Action action,
    uint64_t exceptionClass,
    _Unwind_Exception *unwind_exception,
    _Unwind_Context *context) {

  /*
  printf(" -- __gxx_personality_v0 args --\n");
  printf(" version: %d\n", version);
  printf(" action: %d\n", action);
  printf(" exceptClass: %ld\n", exceptionClass);
  printf(" unwind_exception at %p\n", unwind_exception );
  printf(" context at %p\n", context);
  printf(" -------------------------------\n");
  */

  //printf("Personality function called: ");

  if(action & _UA_CLEANUP_PHASE) {
    //printf("cleanup phace2\n");
    //printf("--- install context ---\n");
    int hand;
    _Unwind_Ptr lp;
    store_exception_info(unwind_exception, &hand, &lp);
    
    int r0 = __builtin_eh_return_data_regno(0);
    int r1 = __builtin_eh_return_data_regno(1);

    _Unwind_SetGR(context, r0, (uintptr_t)unwind_exception);
    _Unwind_SetGR(context, r1, (uintptr_t)hand);
    _Unwind_SetIP(context, lp);

    return _URC_INSTALL_CONTEXT;
  }

  if(action & _UA_SEARCH_PHASE) {
    //printf("search phace\n");

    //const uintptr_t throw_ip = _Unwind_GetIP(context) - 1;
    int ip_before_insn = 0;
    uintptr_t throw_ip = _Unwind_GetIPInfo(context, &ip_before_insn);
    if(ip_before_insn == 0){
      //printf("ip_before_insc is zero\n");
      throw_ip--;
    }
    //printf("thought in %lx\n", throw_ip + 1);

    LSDA_ptr lsda = (uint8_t*)_Unwind_GetLanguageSpecificData(context);
    
    LSDA_Header header(&lsda);
    const LSDA_ptr types_table_start = lsda + header.types_table_offset;
    // Headerの終わりから、その長さの先にはタイプ情報が入っている
    
    LSDA_Call_Site_Header cs_header(&lsda);
    const LSDA_ptr lsda_cs_table_end = lsda + cs_header.length;

    const LSDA_ptr action_table_start = lsda_cs_table_end;

    // - LSDA_Header(start_encoding, type_encoding, types_table_offset)
    //   - LSDA_Call_Site_Header(encoding, length) ---
    //     - LSDA_Call_Site(start, len, lp, action)  |
    //     - LSDA_Call_Site(start, len, lp, action)  |-cs_header_length
    //     - LSDA_Call_Site(start, len, lp, action)  |
    //     (length分ある) ---------------------------|
    //   - アクションテーブル(各型情報へのインデックス)
    //   - 型情報(std::type_infoがコードにはっついている)
    //   

    //printf("total call site length is %d\n", cs_header.length);

    /*
    for(LSDA_ptr c = lsda; c < lsda_cs_table_end;c++) {
      //printf("%x\n", *c);
      printf("%d %d\n", *c, *c & 0b10000000);
    }
    */

    while(lsda < lsda_cs_table_end) {
      LSDA_Call_Site cs(&lsda); 
      // lsdaを読んで、すすめる

      
      uintptr_t func_start = _Unwind_GetRegionStart(context);
      uintptr_t try_start = func_start + cs.start;
      uintptr_t try_end = func_start + cs.start + cs.len;

      // throw_ip が try_startとtry_endの間にあるか調べる。
    
      if(throw_ip < try_start || try_end < throw_ip) {
	continue;
      }
      //printf("found Call Site info\n");

      //printf(" -- Call_Site --\n");
      //printf(" start: %x\n", cs.start);
      //printf(" len: %x\n", cs.len);
      //printf(" lp: %x\n", cs.lp);
      //printf(" action: %x\n", cs.action);
      //printf(" ---------------\n");

      _Unwind_Ptr landing_ptr;
      unsigned char* action_record;

      if(cs.lp == 0) {
	//printf("Call site landing ptr is zero!!\n");
	landing_ptr = 0;
      } else {
	landing_ptr = func_start + cs.lp;
	//printf("landing ptr is %lx\n", landing_ptr);
      }
      if(cs.action == 0) {
	action_record = NULL;
      } else {
	action_record = (unsigned char*)action_table_start + cs.action - 1;
      }

      if( landing_ptr == 0 ) {
	// found nothing.
      }
      if( action_record == NULL) {
	// found cleanup(?)
      }
      //printf("landing_ptr: %ld, action_record at %p\n", landing_ptr, action_record);

      void* thrown_ptr = __get_object_from_ue(unwind_exception);
      const std::type_info* throw_type = __get_exception_header_from_obj(thrown_ptr)->exceptionType;

      const unsigned char* p = (unsigned char*)action_table_start + cs.action - 1;
      _sleb128_t ar_filter, ar_disp;
      while(1) {
	p = read_sleb128(p, &ar_filter); //:
	read_sleb128(p, &ar_disp);
	//??

	//printf("fil: %ld, dis: %ld\n", ar_filter, ar_disp);

	std::type_info* type_ptr = (std::type_info*)(uintptr_t)*(int*)((char*)types_table_start - ar_filter * 4);

	if(type_ptr == NULL) { 
          save_exception_info(unwind_exception, context, ar_filter, func_start + cs.lp);
	  return _URC_HANDLER_FOUND;
	}

	//printf("checking type is\t%s\n", type_ptr->name());
	//printf("thrown type is\t\t%s\n", throw_type->name());

	bool ret = strcmp(type_ptr->name(), throw_type->name()) == 0;
	if(ret) { // Found!!!!!
          save_exception_info(unwind_exception, context, ar_filter, func_start + cs.lp);
	  //printf("\t Type matched!!!!\n");
	  return _URC_HANDLER_FOUND;
	} else {
	  //printf("\tType didn't match\n");
	}

	if(ar_disp == 0) {
	  break;
	}
	p += ar_disp;
      }
    }
    //printf("not found\n");
    return _URC_CONTINUE_UNWIND;
  } else {
    //printf("unexpected action\n");
    return _URC_FATAL_PHASE1_ERROR;
  }
}

