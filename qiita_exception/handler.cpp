#include<stdio.h>
#include<unwind.h>
#include<stdlib.h>
#include<stdint.h>
#include<string.h>
#include<typeinfo>

namespace __cxxabiv1 {
    struct __class_type_info {
        virtual void func() {}
    } ti;
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

extern "C" {
  void* __cxa_allocate_exception(size_t);
  void __cxa_throw(void*, std::type_info *, void (*dest)(void*));
  void __cxa_begin_catch();
  void __cxa_end_catch();
  _Unwind_Reason_Code __gxx_personality_v0(int, _Unwind_Action, uint64_t, _Unwind_Exception*, _Unwind_Context*);
}

std::type_info* thrown_type;

void __cxa_throw(
          void* ptr,
          std::type_info *tinfo,
          void (*dest)(void*)) {

  __cxa_exception *header = ((__cxa_exception *)ptr + 1); // -1はわからん
  header->exceptionType = tinfo;
  thrown_type = tinfo;
  _Unwind_RaiseException(&header->unwindHeader);
  //__cxa_exception* exc;
  //_Unwind_RaiseException(&exc->unwindHeader);

  exit(0);
}

void* __cxa_allocate_exception(size_t thrown_size) {
  void* ret = malloc(sizeof(__cxa_exception) * 3 * thrown_size);
  if(ret == NULL) {
    printf("Could not allocate memory\n");
    exit(0);
  }
  return ret;
}


void __cxa_begin_catch() {
  //printf("__cxa_begin_catch called\n");
}

void __cxa_end_catch() {
  //printf("__cxa_end_catch called\n");
}
unsigned char* read_uleb128 (unsigned char *p, unsigned long *val) {
  unsigned int shift = 0;
  unsigned char byte;
  unsigned long result;
  result = 0;
  do {
    byte = *p++;
    result |= ((_uleb128_t)byte & 0x7f) << shift;
    shift += 7;
  } while (byte & 0x80);
  *val = result;
  return p;
}
unsigned char* read_sleb128 (unsigned char *p, unsigned long *val) {
  unsigned int shift = 0;
  unsigned char byte;
  unsigned long result;
  result = 0;
  do {
    byte = *p++;
    result |= ((_uleb128_t)byte & 0x7f) << shift;
    shift += 7;
  } while (byte & 0x80);
  /* Sign-extend a negative value.  */
  if (shift < 8 * sizeof(result) && (byte & 0x40) != 0) {
    result |= -(((_uleb128_t)1L) << shift);
  }
  *val = (_sleb128_t) result;
  return p;
}

typedef struct {
  uint8_t start_encoding;
  uint8_t type_encoding;
  unsigned long type_table_offset;

  void show_header() {
    printf("--- LSDA_Header ---\n");
    printf(" start_encoding: %x\n", start_encoding);
    printf(" type_encodig: %x\n", type_encoding);
    printf(" type_table_offset: %lx\n", type_table_offset);
    printf("-------------------\n");
  }
} LSDA_Header ;

uint8_t* create_LSDA_Header(uint8_t* lsda, LSDA_Header* header) {
  header->start_encoding = *lsda++;
  header->type_encoding = *lsda++;
  lsda = read_uleb128(lsda, &header->type_table_offset);

  return lsda;
}

typedef struct {
  uint8_t encoding;
  unsigned long call_site_length;

  void show_header() {
    printf("--- LSDA Call Site Header ---\n");
    printf(" encoding: %x\n", encoding);
    printf(" call_site_length: %lx\n", call_site_length);
    printf("-----------------------------\n");
  }
} LSDA_Call_Site_Header;

uint8_t* create_LSDA_Call_Site_Header(uint8_t* lsda, LSDA_Call_Site_Header* header) {
  header->encoding = *lsda++;
  lsda = read_uleb128(lsda, &header->call_site_length);

  return lsda;
}

typedef struct {
  unsigned long start;
  unsigned long length;
  unsigned long landing_pad;
  unsigned long action_index;

  void show_call_site() {
    printf("--- Call Site ---\n");
    printf(" start: %lx\n", start);
    printf(" length: %lx\n", length);
    printf(" landing_pad: %lx\n", landing_pad);
    printf(" action_index: %lx\n", action_index);
    printf("-----------------\n");
  }
} LSDA_Call_Site;

uint8_t* create_LSDA_Call_Site(uint8_t* lsda, LSDA_Call_Site* header) {
  lsda = read_uleb128(lsda, &header->start);
  lsda = read_uleb128(lsda, &header->length);
  lsda = read_uleb128(lsda, &header->landing_pad);
  lsda = read_uleb128(lsda, &header->action_index);

  return lsda;
}

int handler_type_index;
_Unwind_Ptr handler_landing_pad;

_Unwind_Reason_Code __gxx_personality_v0(
    int version,
    _Unwind_Action action,
    uint64_t exceptionClass,
    _Unwind_Exception *unwind_exception,
    _Unwind_Context *context) {
  
  if(action & _UA_CLEANUP_PHASE) {
    printf("cleanup phase\n");

    printf("exception %p\n", unwind_exception);
    printf("hander %x\n", handler_type_index);
    printf("landing pad %lx\n", handler_landing_pad);

    _Unwind_SetGR(context, __builtin_eh_return_data_regno(0), (uintptr_t)unwind_exception);
    _Unwind_SetGR(context, __builtin_eh_return_data_regno(1), (uintptr_t)handler_type_index);
    _Unwind_SetIP(context, handler_landing_pad);

    printf("return\n");
    return _URC_INSTALL_CONTEXT;
  }

  if(action & _UA_SEARCH_PHASE) {
    uint8_t* reading_pointer = (uint8_t*)_Unwind_GetLanguageSpecificData(context);

    LSDA_Header lsda_header;
    // LSDAのヘッダー
    reading_pointer = create_LSDA_Header(reading_pointer, &lsda_header);
    //lsda_header.show_header();

    uint8_t* end_of_lsda = reading_pointer + lsda_header.type_table_offset;
    // LSDAの最後。ここから型情報が逆順に並んでいる。

    LSDA_Call_Site_Header lsda_cs_header;
    // Call Siteのヘッダー
    reading_pointer = create_LSDA_Call_Site_Header(reading_pointer, &lsda_cs_header);
    //lsda_cs_header.show_header();

    uint8_t* action_table_start = reading_pointer + lsda_cs_header.call_site_length;
    // Call Siteの最後。つまりAction tableのはじめ

    uintptr_t thrown_ip = _Unwind_GetIP(context) - 1; // 範囲内としてカウントするため
    uintptr_t func_start = _Unwind_GetRegionStart(context);

    const uint8_t* end_call_site = reading_pointer + lsda_cs_header.call_site_length;
    bool found_flag = false; // 合致するCall Siteが存在したか。
    LSDA_Call_Site now_call_site; // 合致したときのCall Site
    while(reading_pointer < end_call_site) {
      LSDA_Call_Site cs;
      reading_pointer = create_LSDA_Call_Site(reading_pointer, &cs);

      uintptr_t try_start = func_start + cs.start;
      uintptr_t try_end = try_start + cs.length;

      if(try_start < thrown_ip && thrown_ip < try_end) { // 該当するtry文なのか調べる
	//printf("Call site found\n");
	now_call_site = cs;
	found_flag = true;
	break;
      }
    }
    //now_call_site.show_call_site();

    if(!found_flag) {
      printf("Error occured. not found call site\n");
      exit(0);
    }

    uint8_t* action_pointer = action_table_start + now_call_site.action_index - 1; // 初期位置
    // action_index は実際のインデックス+1だから1引く

while(1) {
  uint8_t type_index = *action_pointer++; // 型のインデックス
  std::type_info* catch_type = 
    (std::type_info*)(uintptr_t)*((unsigned int*)end_of_lsda - type_index);
  if(catch_type == NULL) { // catch(...) なら保存して戻る
    handler_type_index = type_index;
    handler_landing_pad = func_start + now_call_site.landing_pad;

    return _URC_HANDLER_FOUND;
  } else {
    if(strcmp(catch_type->name(), thrown_type->name()) == 0) { // 型名前が一致したら
      handler_type_index = type_index;
      handler_landing_pad = func_start + now_call_site.landing_pad;

      return _URC_HANDLER_FOUND;
    }
  }
  unsigned long next_action_index; // 次のインデックス
  read_sleb128(action_pointer, &next_action_index);
  if(next_action_index == 0) { // 最後なら
    break;
  }

  action_pointer += next_action_index;
}
// 何も見つからなかったら
return _URC_CONTINUE_UNWIND; // スタックを更に巻き戻る
  }
  return _URC_FATAL_PHASE1_ERROR;

}
