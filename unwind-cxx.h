
#ifndef _UNWIND_CXX_H
#define _UNWIND_CXX_H 1

// Level 2: C++ ABI

#include <typeinfo>
#include <exception>
#include <cstddef>
#include <bits/atomic_word.h>

/* We only want to use stap probes starting with v3.  Earlier versions
   added too much startup cost.  */
#if defined (STAP_PROBE2) && _SDT_NOTE_TYPE >= 3
#define PROBE2(name, arg1, arg2) STAP_PROBE2 (libstdcxx, name, arg1, arg2)
#endif

#ifndef PROBE2
#define PROBE2(name, arg1, arg2)
#endif

#pragma GCC visibility push(default)

// A primary C++ exception object consists of a header, which is a wrapper
// around an unwind object header with additional C++ specific information,
// followed by the exception object itself.

  // Cache parsed handler data from the personality routine Phase 1
  // for Phase 2 and __cxa_call_unexpected.
struct __cxa_refcounted_exception
{
  // Manage this header.
  _Atomic_word referenceCount;
  // __cxa_exception must be last, and no padding can be after it.
  __cxa_exception exc;
};

// A dependent C++ exception object consists of a wrapper around an unwind
// object header with additional C++ specific information, containing a pointer
// to a primary exception object.

struct __cxa_dependent_exception
{
  // The primary exception this thing depends on.
  void *primaryException;

  // Unused member to get similar layout to __cxa_exception, otherwise the
  // alignment requirements of _Unwind_Exception would require padding bytes
  // before the unwindHeader member.
  void (_GLIBCXX_CDTOR_CALLABI *__padding)(void *);

  // The C++ standard has entertaining rules wrt calling set_terminate
  // and set_unexpected in the middle of the exception cleanup process.
  std::unexpected_handler unexpectedHandler;
  std::terminate_handler terminateHandler;

  // The caught exception stack threads through here.
  __cxa_exception *nextException;

  // How many nested handlers have caught this exception.  A negated
  // value is a signal that this object has been rethrown.
  int handlerCount;

  // Cache parsed handler data from the personality routine Phase 1
  // for Phase 2 and __cxa_call_unexpected.
  int handlerSwitchValue;
  const unsigned char *actionRecord;
  const unsigned char *languageSpecificData;
  _Unwind_Ptr catchTemp;
  void *adjustedPtr;
  
  // The generic exception header.  Must be last.
  _Unwind_Exception unwindHeader;
};

// Each thread in a C++ program has access to a __cxa_eh_globals object.
struct __cxa_eh_globals
{
  __cxa_exception *caughtExceptions;
  unsigned int uncaughtExceptions;
};

// @@@ These are not directly specified by the IA-64 C++ ABI.

// Handles re-checking the exception specification if unexpectedHandler
// throws, and if bad_exception needs to be thrown.  Called from the
// compiler.

// Handles cleanup from transactional memory restart.
extern "C" void __cxa_tm_cleanup (void *, void *, unsigned int) throw();


// Acquire the C++ exception header from the C++ object.
static inline __cxa_exception *
__get_exception_header_from_obj (void *ptr)
{
  return reinterpret_cast<__cxa_exception *>(ptr) - 1;
}

// Acquire the C++ exception header from the generic exception header.
static inline __cxa_exception *
__get_exception_header_from_ue (_Unwind_Exception *exc)
{
  return reinterpret_cast<__cxa_exception *>(exc + 1) - 1;
}

// Acquire the C++ refcounted exception header from the C++ object.
static inline __cxa_refcounted_exception *
__get_refcounted_exception_header_from_obj (void *ptr)
{
  return reinterpret_cast<__cxa_refcounted_exception *>(ptr) - 1;
}

// Acquire the C++ refcounted exception header from the generic exception
// header.
static inline __cxa_refcounted_exception *
__get_refcounted_exception_header_from_ue (_Unwind_Exception *exc)
{
  return reinterpret_cast<__cxa_refcounted_exception *>(exc + 1) - 1;
}

static inline __cxa_dependent_exception *
__get_dependent_exception_from_ue (_Unwind_Exception *exc)
{
  return reinterpret_cast<__cxa_dependent_exception *>(exc + 1) - 1;
}

// This is the primary exception class we report -- "GNUCC++\0".
const _Unwind_Exception_Class __gxx_primary_exception_class
= ((((((((_Unwind_Exception_Class) 'G' 
	 << 8 | (_Unwind_Exception_Class) 'N')
	<< 8 | (_Unwind_Exception_Class) 'U')
       << 8 | (_Unwind_Exception_Class) 'C')
      << 8 | (_Unwind_Exception_Class) 'C')
     << 8 | (_Unwind_Exception_Class) '+')
    << 8 | (_Unwind_Exception_Class) '+')
   << 8 | (_Unwind_Exception_Class) '\0');

// This is the dependent (from std::rethrow_exception) exception class we report
// "GNUCC++\x01"
const _Unwind_Exception_Class __gxx_dependent_exception_class
= ((((((((_Unwind_Exception_Class) 'G' 
	 << 8 | (_Unwind_Exception_Class) 'N')
	<< 8 | (_Unwind_Exception_Class) 'U')
       << 8 | (_Unwind_Exception_Class) 'C')
      << 8 | (_Unwind_Exception_Class) 'C')
     << 8 | (_Unwind_Exception_Class) '+')
    << 8 | (_Unwind_Exception_Class) '+')
   << 8 | (_Unwind_Exception_Class) '\x01');

static inline bool
__is_gxx_exception_class(_Unwind_Exception_Class c)
{
  return c == __gxx_primary_exception_class
      || c == __gxx_dependent_exception_class;
}

// Only checks for primary or dependent, but not that it is a C++ exception at
// all.
static inline bool
__is_dependent_exception(_Unwind_Exception_Class c)
{
  return (c & 1);
}

#define __GXX_INIT_PRIMARY_EXCEPTION_CLASS(c) c = __gxx_primary_exception_class
#define __GXX_INIT_DEPENDENT_EXCEPTION_CLASS(c) \
  c = __gxx_dependent_exception_class

// GNU C++ personality routine, Version 0.
extern "C" _Unwind_Reason_Code __gxx_personality_v0
     (int, _Unwind_Action, _Unwind_Exception_Class,
      struct _Unwind_Exception *, struct _Unwind_Context *);

// GNU C++ sjlj personality routine, Version 0.
extern "C" _Unwind_Reason_Code __gxx_personality_sj0
     (int, _Unwind_Action, _Unwind_Exception_Class,
      struct _Unwind_Exception *, struct _Unwind_Context *);

static inline void*
__gxx_caught_object(_Unwind_Exception* eo)
{
  // Bad as it looks, this actually works for dependent exceptions too.
  __cxa_exception* header = __get_exception_header_from_ue (eo);
  return header->adjustedPtr;
}

static inline void*
__get_object_from_ue(_Unwind_Exception* eo) throw()
{
  return __is_dependent_exception (eo->exception_class) ?
    __get_dependent_exception_from_ue (eo)->primaryException :
    eo + 1;
}

static inline void *
__get_object_from_ambiguous_exception(__cxa_exception *p_or_d) throw()
{
	return __get_object_from_ue (&p_or_d->unwindHeader);
}

#pragma GCC visibility pop

#endif // _UNWIND_CXX_H
