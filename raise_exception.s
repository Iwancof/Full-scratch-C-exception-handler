	.file	"raise_exception.cpp"
	.intel_syntax noprefix
	.text
.Ltext0:
	.section	.rodata
.LC0:
	.string	"nothing to do..."
	.align 8
.LC1:
	.string	"Caught exception in wrong catch block..."
.LC2:
	.string	"Caught a FirstException"
.LC3:
	.string	"End of unsafe_function"
	.text
	.globl	_Z15unsafe_functionv
	.type	_Z15unsafe_functionv, @function
_Z15unsafe_functionv:
.LFB11:
	.file 1 "raise_exception.cpp"
	.loc 1 6 24
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	.cfi_lsda 0x3,.LLSDA11
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 24
	.cfi_offset 3, -24
	.loc 1 8 11
	mov	edi, OFFSET FLAT:.LC0
.LEHB0:
	call	puts
.LEHE0:
.L4:
	.loc 1 14 27
	mov	edi, 1
	call	__cxa_allocate_exception
	mov	edx, 0
	mov	esi, OFFSET FLAT:_ZTI15SecondException
	mov	rdi, rax
.LEHB1:
	call	__cxa_throw
.LEHE1:
.L9:
	cmp	rdx, 1
	je	.L3
	mov	rdi, rax
.LEHB2:
	call	_Unwind_Resume
.LEHE2:
.L3:
.LBB2:
	.loc 1 9 27
	mov	rdi, rax
	call	__cxa_begin_catch
	mov	QWORD PTR [rbp-32], rax
	.loc 1 10 11
	mov	edi, OFFSET FLAT:.LC1
.LEHB3:
	call	puts
.LEHE3:
	.loc 1 9 27
	call	__cxa_end_catch
	jmp	.L4
.L10:
	mov	rbx, rax
	call	__cxa_end_catch
	mov	rax, rbx
	mov	rdi, rax
.LEHB4:
	call	_Unwind_Resume
.L11:
	cmp	rdx, 1
	je	.L7
	mov	rdi, rax
	call	_Unwind_Resume
.LEHE4:
.L7:
.LBE2:
.LBB3:
	.loc 1 15 27
	mov	rdi, rax
	call	__cxa_begin_catch
	mov	QWORD PTR [rbp-24], rax
	.loc 1 16 11
	mov	edi, OFFSET FLAT:.LC2
.LEHB5:
	call	puts
.LEHE5:
	.loc 1 15 27
	call	__cxa_end_catch
.LBE3:
	.loc 1 18 9
	mov	edi, OFFSET FLAT:.LC3
.LEHB6:
	call	puts
	.loc 1 19 1
	jmp	.L13
.L12:
	mov	rbx, rax
.LBB4:
	.loc 1 15 27
	call	__cxa_end_catch
	mov	rax, rbx
	mov	rdi, rax
	call	_Unwind_Resume
.LEHE6:
.L13:
.LBE4:
	.loc 1 19 1
	add	rsp, 24
	pop	rbx
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.globl	__gxx_personality_v0
	.section	.gcc_except_table,"a",@progbits
	.align 4
.LLSDA11:
	.byte	0xff
	.byte	0x3
	.uleb128 .LLSDATT11-.LLSDATTD11
.LLSDATTD11:
	.byte	0x1
	.uleb128 .LLSDACSE11-.LLSDACSB11
.LLSDACSB11:
	.uleb128 .LEHB0-.LFB11
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L9-.LFB11
	.uleb128 0x1
	.uleb128 .LEHB1-.LFB11
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L11-.LFB11
	.uleb128 0x1
	.uleb128 .LEHB2-.LFB11
	.uleb128 .LEHE2-.LEHB2
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB3-.LFB11
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L10-.LFB11
	.uleb128 0
	.uleb128 .LEHB4-.LFB11
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB5-.LFB11
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L12-.LFB11
	.uleb128 0
	.uleb128 .LEHB6-.LFB11
	.uleb128 .LEHE6-.LEHB6
	.uleb128 0
	.uleb128 0
.LLSDACSE11:
	.byte	0x1
	.byte	0
	.align 4
	.long	_ZTI14FirstException
.LLSDATT11:
	.text
	.size	_Z15unsafe_functionv, .-_Z15unsafe_functionv
	.section	.rodata
.LC4:
	.string	"End of handler"
.LC5:
	.string	"Caught a First exception"
.LC6:
	.string	"Caught a Second exception"
	.text
	.globl	_Z7handlerv
	.type	_Z7handlerv, @function
_Z7handlerv:
.LFB12:
	.loc 1 21 16
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
	.cfi_lsda 0x3,.LLSDA12
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 24
	.cfi_offset 3, -24
.LEHB7:
	.loc 1 23 20
	call	_Z15unsafe_functionv
.LEHE7:
.L18:
	.loc 1 29 9
	mov	edi, OFFSET FLAT:.LC4
.LEHB8:
	call	puts
	.loc 1 30 1
	jmp	.L24
.L21:
	cmp	rdx, 1
	je	.L16
	cmp	rdx, 2
	je	.L17
	mov	rdi, rax
	call	_Unwind_Resume
.LEHE8:
.L16:
.LBB5:
	.loc 1 24 27
	mov	rdi, rax
	call	__cxa_begin_catch
	mov	QWORD PTR [rbp-24], rax
	.loc 1 25 11
	mov	edi, OFFSET FLAT:.LC5
.LEHB9:
	call	puts
.LEHE9:
	.loc 1 24 27
	call	__cxa_end_catch
	jmp	.L18
.L17:
.LBE5:
.LBB6:
	.loc 1 26 28
	mov	rdi, rax
	call	__cxa_begin_catch
	mov	QWORD PTR [rbp-32], rax
	.loc 1 27 11
	mov	edi, OFFSET FLAT:.LC6
.LEHB10:
	call	puts
.LEHE10:
	.loc 1 26 28
	call	__cxa_end_catch
	jmp	.L18
.L22:
	mov	rbx, rax
.LBE6:
.LBB7:
	.loc 1 24 27
	call	__cxa_end_catch
	mov	rax, rbx
	mov	rdi, rax
.LEHB11:
	call	_Unwind_Resume
.L23:
	mov	rbx, rax
.LBE7:
.LBB8:
	.loc 1 26 28
	call	__cxa_end_catch
	mov	rax, rbx
	mov	rdi, rax
	call	_Unwind_Resume
.LEHE11:
.L24:
.LBE8:
	.loc 1 30 1
	add	rsp, 24
	pop	rbx
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.section	.gcc_except_table
	.align 4
.LLSDA12:
	.byte	0xff
	.byte	0x3
	.uleb128 .LLSDATT12-.LLSDATTD12
.LLSDATTD12:
	.byte	0x1
	.uleb128 .LLSDACSE12-.LLSDACSB12
.LLSDACSB12:
	.uleb128 .LEHB7-.LFB12
	.uleb128 .LEHE7-.LEHB7
	.uleb128 .L21-.LFB12
	.uleb128 0x3
	.uleb128 .LEHB8-.LFB12
	.uleb128 .LEHE8-.LEHB8
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB9-.LFB12
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L22-.LFB12
	.uleb128 0
	.uleb128 .LEHB10-.LFB12
	.uleb128 .LEHE10-.LEHB10
	.uleb128 .L23-.LFB12
	.uleb128 0
	.uleb128 .LEHB11-.LFB12
	.uleb128 .LEHE11-.LEHB11
	.uleb128 0
	.uleb128 0
.LLSDACSE12:
	.byte	0x2
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	_ZTI15SecondException
	.long	_ZTI14FirstException
.LLSDATT12:
	.text
	.size	_Z7handlerv, .-_Z7handlerv
	.globl	seppuku
	.type	seppuku, @function
seppuku:
.LFB13:
	.loc 1 32 16
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	.loc 1 33 10
	call	_Z7handlerv
	.loc 1 34 1
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	seppuku, .-seppuku
	.weak	_ZTI15SecondException
	.section	.rodata._ZTI15SecondException,"aG",@progbits,_ZTI15SecondException,comdat
	.align 8
	.type	_ZTI15SecondException, @object
	.size	_ZTI15SecondException, 16
_ZTI15SecondException:
	.quad	_ZTVN10__cxxabiv117__class_type_infoE+16
	.quad	_ZTS15SecondException
	.weak	_ZTS15SecondException
	.section	.rodata._ZTS15SecondException,"aG",@progbits,_ZTS15SecondException,comdat
	.align 16
	.type	_ZTS15SecondException, @object
	.size	_ZTS15SecondException, 18
_ZTS15SecondException:
	.string	"15SecondException"
	.weak	_ZTI14FirstException
	.section	.rodata._ZTI14FirstException,"aG",@progbits,_ZTI14FirstException,comdat
	.align 8
	.type	_ZTI14FirstException, @object
	.size	_ZTI14FirstException, 16
_ZTI14FirstException:
	.quad	_ZTVN10__cxxabiv117__class_type_infoE+16
	.quad	_ZTS14FirstException
	.weak	_ZTS14FirstException
	.section	.rodata._ZTS14FirstException,"aG",@progbits,_ZTS14FirstException,comdat
	.align 16
	.type	_ZTS14FirstException, @object
	.size	_ZTS14FirstException, 17
_ZTS14FirstException:
	.string	"14FirstException"
	.text
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h"
	.file 3 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 4 "/usr/include/libio.h"
	.file 5 "/usr/include/stdio.h"
	.file 6 "/usr/include/x86_64-linux-gnu/bits/sys_errlist.h"
	.file 7 "/usr/include/c++/9/cstdlib"
	.file 8 "/usr/include/c++/9/bits/std_abs.h"
	.file 9 "/usr/include/x86_64-linux-gnu/c++/9/bits/c++config.h"
	.file 10 "/usr/include/stdlib.h"
	.file 11 "/usr/include/c++/9/stdlib.h"
	.file 12 "raise_exception.h"
	.file 13 "<built-in>"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xbb5
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF109
	.byte	0x4
	.long	.LASF110
	.long	.LASF111
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF7
	.byte	0x2
	.byte	0xd1
	.byte	0x17
	.long	0x39
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF0
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF1
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF2
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x2
	.long	.LASF8
	.byte	0x3
	.byte	0x83
	.byte	0x19
	.long	0x6a
	.uleb128 0x2
	.long	.LASF9
	.byte	0x3
	.byte	0x84
	.byte	0x1b
	.long	0x6a
	.uleb128 0x5
	.byte	0x8
	.uleb128 0x6
	.byte	0x8
	.long	0x91
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF10
	.uleb128 0x7
	.long	0x91
	.uleb128 0x8
	.long	.LASF40
	.byte	0xd8
	.byte	0x4
	.byte	0xf1
	.byte	0x8
	.long	0x238
	.uleb128 0x9
	.long	.LASF11
	.byte	0x4
	.byte	0xf2
	.byte	0x7
	.long	0x63
	.byte	0
	.uleb128 0x9
	.long	.LASF12
	.byte	0x4
	.byte	0xf7
	.byte	0x9
	.long	0x8b
	.byte	0x8
	.uleb128 0x9
	.long	.LASF13
	.byte	0x4
	.byte	0xf8
	.byte	0x9
	.long	0x8b
	.byte	0x10
	.uleb128 0x9
	.long	.LASF14
	.byte	0x4
	.byte	0xf9
	.byte	0x9
	.long	0x8b
	.byte	0x18
	.uleb128 0x9
	.long	.LASF15
	.byte	0x4
	.byte	0xfa
	.byte	0x9
	.long	0x8b
	.byte	0x20
	.uleb128 0x9
	.long	.LASF16
	.byte	0x4
	.byte	0xfb
	.byte	0x9
	.long	0x8b
	.byte	0x28
	.uleb128 0x9
	.long	.LASF17
	.byte	0x4
	.byte	0xfc
	.byte	0x9
	.long	0x8b
	.byte	0x30
	.uleb128 0x9
	.long	.LASF18
	.byte	0x4
	.byte	0xfd
	.byte	0x9
	.long	0x8b
	.byte	0x38
	.uleb128 0x9
	.long	.LASF19
	.byte	0x4
	.byte	0xfe
	.byte	0x9
	.long	0x8b
	.byte	0x40
	.uleb128 0xa
	.long	.LASF20
	.byte	0x4
	.value	0x100
	.byte	0x9
	.long	0x8b
	.byte	0x48
	.uleb128 0xa
	.long	.LASF21
	.byte	0x4
	.value	0x101
	.byte	0x9
	.long	0x8b
	.byte	0x50
	.uleb128 0xa
	.long	.LASF22
	.byte	0x4
	.value	0x102
	.byte	0x9
	.long	0x8b
	.byte	0x58
	.uleb128 0xa
	.long	.LASF23
	.byte	0x4
	.value	0x104
	.byte	0x16
	.long	0x275
	.byte	0x60
	.uleb128 0xa
	.long	.LASF24
	.byte	0x4
	.value	0x106
	.byte	0x14
	.long	0x27b
	.byte	0x68
	.uleb128 0xa
	.long	.LASF25
	.byte	0x4
	.value	0x108
	.byte	0x7
	.long	0x63
	.byte	0x70
	.uleb128 0xa
	.long	.LASF26
	.byte	0x4
	.value	0x10c
	.byte	0x7
	.long	0x63
	.byte	0x74
	.uleb128 0xa
	.long	.LASF27
	.byte	0x4
	.value	0x10e
	.byte	0xd
	.long	0x71
	.byte	0x78
	.uleb128 0xa
	.long	.LASF28
	.byte	0x4
	.value	0x112
	.byte	0x12
	.long	0x47
	.byte	0x80
	.uleb128 0xa
	.long	.LASF29
	.byte	0x4
	.value	0x113
	.byte	0xf
	.long	0x55
	.byte	0x82
	.uleb128 0xa
	.long	.LASF30
	.byte	0x4
	.value	0x114
	.byte	0x8
	.long	0x281
	.byte	0x83
	.uleb128 0xa
	.long	.LASF31
	.byte	0x4
	.value	0x118
	.byte	0xf
	.long	0x291
	.byte	0x88
	.uleb128 0xa
	.long	.LASF32
	.byte	0x4
	.value	0x121
	.byte	0xf
	.long	0x7d
	.byte	0x90
	.uleb128 0xa
	.long	.LASF33
	.byte	0x4
	.value	0x129
	.byte	0x9
	.long	0x89
	.byte	0x98
	.uleb128 0xa
	.long	.LASF34
	.byte	0x4
	.value	0x12a
	.byte	0x9
	.long	0x89
	.byte	0xa0
	.uleb128 0xa
	.long	.LASF35
	.byte	0x4
	.value	0x12b
	.byte	0x9
	.long	0x89
	.byte	0xa8
	.uleb128 0xa
	.long	.LASF36
	.byte	0x4
	.value	0x12c
	.byte	0x9
	.long	0x89
	.byte	0xb0
	.uleb128 0xa
	.long	.LASF37
	.byte	0x4
	.value	0x12e
	.byte	0xa
	.long	0x2d
	.byte	0xb8
	.uleb128 0xa
	.long	.LASF38
	.byte	0x4
	.value	0x12f
	.byte	0x7
	.long	0x63
	.byte	0xc0
	.uleb128 0xa
	.long	.LASF39
	.byte	0x4
	.value	0x131
	.byte	0x8
	.long	0x297
	.byte	0xc4
	.byte	0
	.uleb128 0xb
	.long	.LASF112
	.byte	0x4
	.byte	0x96
	.byte	0xe
	.uleb128 0x8
	.long	.LASF41
	.byte	0x18
	.byte	0x4
	.byte	0x9c
	.byte	0x8
	.long	0x275
	.uleb128 0x9
	.long	.LASF42
	.byte	0x4
	.byte	0x9d
	.byte	0x16
	.long	0x275
	.byte	0
	.uleb128 0x9
	.long	.LASF43
	.byte	0x4
	.byte	0x9e
	.byte	0x14
	.long	0x27b
	.byte	0x8
	.uleb128 0x9
	.long	.LASF44
	.byte	0x4
	.byte	0xa2
	.byte	0x7
	.long	0x63
	.byte	0x10
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x240
	.uleb128 0x6
	.byte	0x8
	.long	0x9d
	.uleb128 0xc
	.long	0x91
	.long	0x291
	.uleb128 0xd
	.long	0x39
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x238
	.uleb128 0xc
	.long	0x91
	.long	0x2a7
	.uleb128 0xd
	.long	0x39
	.byte	0x13
	.byte	0
	.uleb128 0xe
	.long	.LASF113
	.uleb128 0xf
	.long	.LASF45
	.byte	0x4
	.value	0x13b
	.byte	0x1d
	.long	0x2a7
	.uleb128 0xf
	.long	.LASF46
	.byte	0x4
	.value	0x13c
	.byte	0x1d
	.long	0x2a7
	.uleb128 0xf
	.long	.LASF47
	.byte	0x4
	.value	0x13d
	.byte	0x1d
	.long	0x2a7
	.uleb128 0x6
	.byte	0x8
	.long	0x98
	.uleb128 0x7
	.long	0x2d3
	.uleb128 0x10
	.long	.LASF48
	.byte	0x5
	.byte	0xa8
	.byte	0x19
	.long	0x27b
	.uleb128 0x10
	.long	.LASF49
	.byte	0x5
	.byte	0xa9
	.byte	0x19
	.long	0x27b
	.uleb128 0x10
	.long	.LASF50
	.byte	0x5
	.byte	0xaa
	.byte	0x19
	.long	0x27b
	.uleb128 0x10
	.long	.LASF51
	.byte	0x6
	.byte	0x1a
	.byte	0xc
	.long	0x63
	.uleb128 0xc
	.long	0x2d9
	.long	0x319
	.uleb128 0x11
	.byte	0
	.uleb128 0x10
	.long	.LASF52
	.byte	0x6
	.byte	0x1b
	.byte	0x1a
	.long	0x30e
	.uleb128 0x10
	.long	.LASF53
	.byte	0x6
	.byte	0x1e
	.byte	0xc
	.long	0x63
	.uleb128 0x10
	.long	.LASF54
	.byte	0x6
	.byte	0x1f
	.byte	0x1a
	.long	0x30e
	.uleb128 0x12
	.string	"std"
	.byte	0xd
	.byte	0
	.long	0x52c
	.uleb128 0x13
	.long	.LASF62
	.byte	0x9
	.value	0x114
	.byte	0x41
	.uleb128 0x14
	.byte	0x9
	.value	0x114
	.byte	0x41
	.long	0x348
	.uleb128 0x15
	.byte	0x7
	.byte	0x7f
	.byte	0xb
	.long	0x5c7
	.uleb128 0x15
	.byte	0x7
	.byte	0x80
	.byte	0xb
	.long	0x5fb
	.uleb128 0x15
	.byte	0x7
	.byte	0x86
	.byte	0xb
	.long	0x677
	.uleb128 0x15
	.byte	0x7
	.byte	0x89
	.byte	0xb
	.long	0x695
	.uleb128 0x15
	.byte	0x7
	.byte	0x8c
	.byte	0xb
	.long	0x6b0
	.uleb128 0x15
	.byte	0x7
	.byte	0x8d
	.byte	0xb
	.long	0x6cd
	.uleb128 0x15
	.byte	0x7
	.byte	0x8e
	.byte	0xb
	.long	0x6e3
	.uleb128 0x15
	.byte	0x7
	.byte	0x8f
	.byte	0xb
	.long	0x6f9
	.uleb128 0x15
	.byte	0x7
	.byte	0x91
	.byte	0xb
	.long	0x724
	.uleb128 0x15
	.byte	0x7
	.byte	0x94
	.byte	0xb
	.long	0x740
	.uleb128 0x15
	.byte	0x7
	.byte	0x96
	.byte	0xb
	.long	0x757
	.uleb128 0x15
	.byte	0x7
	.byte	0x99
	.byte	0xb
	.long	0x773
	.uleb128 0x15
	.byte	0x7
	.byte	0x9a
	.byte	0xb
	.long	0x78f
	.uleb128 0x15
	.byte	0x7
	.byte	0x9b
	.byte	0xb
	.long	0x7c2
	.uleb128 0x15
	.byte	0x7
	.byte	0x9d
	.byte	0xb
	.long	0x7e3
	.uleb128 0x15
	.byte	0x7
	.byte	0xa0
	.byte	0xb
	.long	0x805
	.uleb128 0x15
	.byte	0x7
	.byte	0xa3
	.byte	0xb
	.long	0x818
	.uleb128 0x15
	.byte	0x7
	.byte	0xa5
	.byte	0xb
	.long	0x825
	.uleb128 0x15
	.byte	0x7
	.byte	0xa6
	.byte	0xb
	.long	0x838
	.uleb128 0x15
	.byte	0x7
	.byte	0xa7
	.byte	0xb
	.long	0x859
	.uleb128 0x15
	.byte	0x7
	.byte	0xa8
	.byte	0xb
	.long	0x879
	.uleb128 0x15
	.byte	0x7
	.byte	0xa9
	.byte	0xb
	.long	0x899
	.uleb128 0x15
	.byte	0x7
	.byte	0xab
	.byte	0xb
	.long	0x8b0
	.uleb128 0x15
	.byte	0x7
	.byte	0xac
	.byte	0xb
	.long	0x8d7
	.uleb128 0x15
	.byte	0x7
	.byte	0xf0
	.byte	0x16
	.long	0x636
	.uleb128 0x15
	.byte	0x7
	.byte	0xf5
	.byte	0x16
	.long	0x583
	.uleb128 0x15
	.byte	0x7
	.byte	0xf6
	.byte	0x16
	.long	0x8f3
	.uleb128 0x15
	.byte	0x7
	.byte	0xf8
	.byte	0x16
	.long	0x90f
	.uleb128 0x15
	.byte	0x7
	.byte	0xf9
	.byte	0x16
	.long	0x965
	.uleb128 0x15
	.byte	0x7
	.byte	0xfa
	.byte	0x16
	.long	0x925
	.uleb128 0x15
	.byte	0x7
	.byte	0xfb
	.byte	0x16
	.long	0x945
	.uleb128 0x15
	.byte	0x7
	.byte	0xfc
	.byte	0x16
	.long	0x987
	.uleb128 0x16
	.string	"abs"
	.byte	0x8
	.byte	0x67
	.byte	0x3
	.long	.LASF55
	.long	0x9d1
	.long	0x474
	.uleb128 0x17
	.long	0x9d1
	.byte	0
	.uleb128 0x16
	.string	"abs"
	.byte	0x8
	.byte	0x55
	.byte	0x3
	.long	.LASF56
	.long	0x9e0
	.long	0x48e
	.uleb128 0x17
	.long	0x9e0
	.byte	0
	.uleb128 0x16
	.string	"abs"
	.byte	0x8
	.byte	0x4f
	.byte	0x3
	.long	.LASF57
	.long	0x9a2
	.long	0x4a8
	.uleb128 0x17
	.long	0x9a2
	.byte	0
	.uleb128 0x16
	.string	"abs"
	.byte	0x8
	.byte	0x4b
	.byte	0x3
	.long	.LASF58
	.long	0x980
	.long	0x4c2
	.uleb128 0x17
	.long	0x980
	.byte	0
	.uleb128 0x16
	.string	"abs"
	.byte	0x8
	.byte	0x47
	.byte	0x3
	.long	.LASF59
	.long	0x6c6
	.long	0x4dc
	.uleb128 0x17
	.long	0x6c6
	.byte	0
	.uleb128 0x16
	.string	"abs"
	.byte	0x8
	.byte	0x3d
	.byte	0x3
	.long	.LASF60
	.long	0x62f
	.long	0x4f6
	.uleb128 0x17
	.long	0x62f
	.byte	0
	.uleb128 0x16
	.string	"abs"
	.byte	0x8
	.byte	0x38
	.byte	0x3
	.long	.LASF61
	.long	0x6a
	.long	0x510
	.uleb128 0x17
	.long	0x6a
	.byte	0
	.uleb128 0x18
	.string	"div"
	.byte	0x7
	.byte	0xb1
	.byte	0x3
	.long	.LASF63
	.long	0x5fb
	.uleb128 0x17
	.long	0x6a
	.uleb128 0x17
	.long	0x6a
	.byte	0
	.byte	0
	.uleb128 0x19
	.long	.LASF114
	.byte	0x9
	.value	0x116
	.byte	0xb
	.long	0x59f
	.uleb128 0x13
	.long	.LASF62
	.byte	0x9
	.value	0x118
	.byte	0x41
	.uleb128 0x14
	.byte	0x9
	.value	0x118
	.byte	0x41
	.long	0x539
	.uleb128 0x15
	.byte	0x7
	.byte	0xc8
	.byte	0xb
	.long	0x636
	.uleb128 0x15
	.byte	0x7
	.byte	0xd8
	.byte	0xb
	.long	0x8f3
	.uleb128 0x15
	.byte	0x7
	.byte	0xe3
	.byte	0xb
	.long	0x90f
	.uleb128 0x15
	.byte	0x7
	.byte	0xe4
	.byte	0xb
	.long	0x925
	.uleb128 0x15
	.byte	0x7
	.byte	0xe5
	.byte	0xb
	.long	0x945
	.uleb128 0x15
	.byte	0x7
	.byte	0xe7
	.byte	0xb
	.long	0x965
	.uleb128 0x15
	.byte	0x7
	.byte	0xe8
	.byte	0xb
	.long	0x987
	.uleb128 0x18
	.string	"div"
	.byte	0x7
	.byte	0xd5
	.byte	0x3
	.long	.LASF64
	.long	0x636
	.uleb128 0x17
	.long	0x62f
	.uleb128 0x17
	.long	0x62f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.byte	0x8
	.byte	0xa
	.byte	0x62
	.byte	0x3
	.long	.LASF67
	.long	0x5c7
	.uleb128 0x9
	.long	.LASF65
	.byte	0xa
	.byte	0x63
	.byte	0x9
	.long	0x63
	.byte	0
	.uleb128 0x1b
	.string	"rem"
	.byte	0xa
	.byte	0x64
	.byte	0x9
	.long	0x63
	.byte	0x4
	.byte	0
	.uleb128 0x2
	.long	.LASF66
	.byte	0xa
	.byte	0x65
	.byte	0x5
	.long	0x59f
	.uleb128 0x1a
	.byte	0x10
	.byte	0xa
	.byte	0x6a
	.byte	0x3
	.long	.LASF68
	.long	0x5fb
	.uleb128 0x9
	.long	.LASF65
	.byte	0xa
	.byte	0x6b
	.byte	0xe
	.long	0x6a
	.byte	0
	.uleb128 0x1b
	.string	"rem"
	.byte	0xa
	.byte	0x6c
	.byte	0xe
	.long	0x6a
	.byte	0x8
	.byte	0
	.uleb128 0x2
	.long	.LASF69
	.byte	0xa
	.byte	0x6d
	.byte	0x5
	.long	0x5d3
	.uleb128 0x1a
	.byte	0x10
	.byte	0xa
	.byte	0x76
	.byte	0x3
	.long	.LASF70
	.long	0x62f
	.uleb128 0x9
	.long	.LASF65
	.byte	0xa
	.byte	0x77
	.byte	0x13
	.long	0x62f
	.byte	0
	.uleb128 0x1b
	.string	"rem"
	.byte	0xa
	.byte	0x78
	.byte	0x13
	.long	0x62f
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF71
	.uleb128 0x2
	.long	.LASF72
	.byte	0xa
	.byte	0x79
	.byte	0x5
	.long	0x607
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF73
	.uleb128 0x1c
	.long	.LASF74
	.byte	0xa
	.value	0x2e5
	.byte	0xf
	.long	0x656
	.uleb128 0x6
	.byte	0x8
	.long	0x65c
	.uleb128 0x1d
	.long	0x63
	.long	0x670
	.uleb128 0x17
	.long	0x670
	.uleb128 0x17
	.long	0x670
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x676
	.uleb128 0x1e
	.uleb128 0x1f
	.long	.LASF75
	.byte	0xa
	.value	0x207
	.byte	0xc
	.long	0x63
	.long	0x68e
	.uleb128 0x17
	.long	0x68e
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x694
	.uleb128 0x20
	.uleb128 0x21
	.long	.LASF76
	.byte	0xa
	.value	0x20c
	.byte	0x12
	.long	.LASF76
	.long	0x63
	.long	0x6b0
	.uleb128 0x17
	.long	0x68e
	.byte	0
	.uleb128 0x22
	.long	.LASF77
	.byte	0xa
	.byte	0x90
	.byte	0xf
	.long	0x6c6
	.long	0x6c6
	.uleb128 0x17
	.long	0x2d3
	.byte	0
	.uleb128 0x3
	.byte	0x8
	.byte	0x4
	.long	.LASF78
	.uleb128 0x22
	.long	.LASF79
	.byte	0xa
	.byte	0x93
	.byte	0xc
	.long	0x63
	.long	0x6e3
	.uleb128 0x17
	.long	0x2d3
	.byte	0
	.uleb128 0x22
	.long	.LASF80
	.byte	0xa
	.byte	0x96
	.byte	0x11
	.long	0x6a
	.long	0x6f9
	.uleb128 0x17
	.long	0x2d3
	.byte	0
	.uleb128 0x1f
	.long	.LASF81
	.byte	0xa
	.value	0x2f2
	.byte	0xe
	.long	0x89
	.long	0x724
	.uleb128 0x17
	.long	0x670
	.uleb128 0x17
	.long	0x670
	.uleb128 0x17
	.long	0x2d
	.uleb128 0x17
	.long	0x2d
	.uleb128 0x17
	.long	0x649
	.byte	0
	.uleb128 0x23
	.string	"div"
	.byte	0xa
	.value	0x314
	.byte	0xe
	.long	0x5c7
	.long	0x740
	.uleb128 0x17
	.long	0x63
	.uleb128 0x17
	.long	0x63
	.byte	0
	.uleb128 0x1f
	.long	.LASF82
	.byte	0xa
	.value	0x234
	.byte	0xe
	.long	0x8b
	.long	0x757
	.uleb128 0x17
	.long	0x2d3
	.byte	0
	.uleb128 0x1f
	.long	.LASF83
	.byte	0xa
	.value	0x316
	.byte	0xf
	.long	0x5fb
	.long	0x773
	.uleb128 0x17
	.long	0x6a
	.uleb128 0x17
	.long	0x6a
	.byte	0
	.uleb128 0x1f
	.long	.LASF84
	.byte	0xa
	.value	0x35e
	.byte	0xc
	.long	0x63
	.long	0x78f
	.uleb128 0x17
	.long	0x2d3
	.uleb128 0x17
	.long	0x2d
	.byte	0
	.uleb128 0x1f
	.long	.LASF85
	.byte	0xa
	.value	0x369
	.byte	0xf
	.long	0x2d
	.long	0x7b0
	.uleb128 0x17
	.long	0x7b0
	.uleb128 0x17
	.long	0x2d3
	.uleb128 0x17
	.long	0x2d
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x7b6
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.long	.LASF86
	.uleb128 0x7
	.long	0x7b6
	.uleb128 0x1f
	.long	.LASF87
	.byte	0xa
	.value	0x361
	.byte	0xc
	.long	0x63
	.long	0x7e3
	.uleb128 0x17
	.long	0x7b0
	.uleb128 0x17
	.long	0x2d3
	.uleb128 0x17
	.long	0x2d
	.byte	0
	.uleb128 0x24
	.long	.LASF89
	.byte	0xa
	.value	0x2fc
	.byte	0xd
	.long	0x805
	.uleb128 0x17
	.long	0x89
	.uleb128 0x17
	.long	0x2d
	.uleb128 0x17
	.long	0x2d
	.uleb128 0x17
	.long	0x649
	.byte	0
	.uleb128 0x25
	.long	.LASF88
	.byte	0xa
	.value	0x225
	.byte	0xd
	.long	0x818
	.uleb128 0x17
	.long	0x63
	.byte	0
	.uleb128 0x26
	.long	.LASF115
	.byte	0xa
	.value	0x176
	.byte	0xc
	.long	0x63
	.uleb128 0x24
	.long	.LASF90
	.byte	0xa
	.value	0x178
	.byte	0xd
	.long	0x838
	.uleb128 0x17
	.long	0x4e
	.byte	0
	.uleb128 0x22
	.long	.LASF91
	.byte	0xa
	.byte	0xa4
	.byte	0xf
	.long	0x6c6
	.long	0x853
	.uleb128 0x17
	.long	0x2d3
	.uleb128 0x17
	.long	0x853
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x8b
	.uleb128 0x22
	.long	.LASF92
	.byte	0xa
	.byte	0xb7
	.byte	0x11
	.long	0x6a
	.long	0x879
	.uleb128 0x17
	.long	0x2d3
	.uleb128 0x17
	.long	0x853
	.uleb128 0x17
	.long	0x63
	.byte	0
	.uleb128 0x22
	.long	.LASF93
	.byte	0xa
	.byte	0xbb
	.byte	0x1a
	.long	0x39
	.long	0x899
	.uleb128 0x17
	.long	0x2d3
	.uleb128 0x17
	.long	0x853
	.uleb128 0x17
	.long	0x63
	.byte	0
	.uleb128 0x1f
	.long	.LASF94
	.byte	0xa
	.value	0x2cc
	.byte	0xc
	.long	0x63
	.long	0x8b0
	.uleb128 0x17
	.long	0x2d3
	.byte	0
	.uleb128 0x1f
	.long	.LASF95
	.byte	0xa
	.value	0x36c
	.byte	0xf
	.long	0x2d
	.long	0x8d1
	.uleb128 0x17
	.long	0x8b
	.uleb128 0x17
	.long	0x8d1
	.uleb128 0x17
	.long	0x2d
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x7bd
	.uleb128 0x1f
	.long	.LASF96
	.byte	0xa
	.value	0x365
	.byte	0xc
	.long	0x63
	.long	0x8f3
	.uleb128 0x17
	.long	0x8b
	.uleb128 0x17
	.long	0x7b6
	.byte	0
	.uleb128 0x1f
	.long	.LASF97
	.byte	0xa
	.value	0x31c
	.byte	0x1e
	.long	0x636
	.long	0x90f
	.uleb128 0x17
	.long	0x62f
	.uleb128 0x17
	.long	0x62f
	.byte	0
	.uleb128 0x22
	.long	.LASF98
	.byte	0xa
	.byte	0x9d
	.byte	0x24
	.long	0x62f
	.long	0x925
	.uleb128 0x17
	.long	0x2d3
	.byte	0
	.uleb128 0x22
	.long	.LASF99
	.byte	0xa
	.byte	0xd1
	.byte	0x16
	.long	0x62f
	.long	0x945
	.uleb128 0x17
	.long	0x2d3
	.uleb128 0x17
	.long	0x853
	.uleb128 0x17
	.long	0x63
	.byte	0
	.uleb128 0x22
	.long	.LASF100
	.byte	0xa
	.byte	0xd6
	.byte	0x1f
	.long	0x642
	.long	0x965
	.uleb128 0x17
	.long	0x2d3
	.uleb128 0x17
	.long	0x853
	.uleb128 0x17
	.long	0x63
	.byte	0
	.uleb128 0x22
	.long	.LASF101
	.byte	0xa
	.byte	0xac
	.byte	0xe
	.long	0x980
	.long	0x980
	.uleb128 0x17
	.long	0x2d3
	.uleb128 0x17
	.long	0x853
	.byte	0
	.uleb128 0x3
	.byte	0x4
	.byte	0x4
	.long	.LASF102
	.uleb128 0x22
	.long	.LASF103
	.byte	0xa
	.byte	0xaf
	.byte	0x14
	.long	0x9a2
	.long	0x9a2
	.uleb128 0x17
	.long	0x2d3
	.uleb128 0x17
	.long	0x853
	.byte	0
	.uleb128 0x3
	.byte	0x10
	.byte	0x4
	.long	.LASF104
	.uleb128 0x15
	.byte	0xb
	.byte	0x27
	.byte	0xc
	.long	0x677
	.uleb128 0x15
	.byte	0xb
	.byte	0x2b
	.byte	0xe
	.long	0x695
	.uleb128 0x15
	.byte	0xb
	.byte	0x2e
	.byte	0xe
	.long	0x805
	.uleb128 0x15
	.byte	0xb
	.byte	0x33
	.byte	0xc
	.long	0x5c7
	.uleb128 0x15
	.byte	0xb
	.byte	0x34
	.byte	0xc
	.long	0x5fb
	.uleb128 0x3
	.byte	0x10
	.byte	0x4
	.long	.LASF105
	.uleb128 0x15
	.byte	0xb
	.byte	0x36
	.byte	0xc
	.long	0x45a
	.uleb128 0x3
	.byte	0x10
	.byte	0x5
	.long	.LASF106
	.uleb128 0x15
	.byte	0xb
	.byte	0x36
	.byte	0xc
	.long	0x474
	.uleb128 0x15
	.byte	0xb
	.byte	0x36
	.byte	0xc
	.long	0x48e
	.uleb128 0x15
	.byte	0xb
	.byte	0x36
	.byte	0xc
	.long	0x4a8
	.uleb128 0x15
	.byte	0xb
	.byte	0x36
	.byte	0xc
	.long	0x4c2
	.uleb128 0x15
	.byte	0xb
	.byte	0x36
	.byte	0xc
	.long	0x4dc
	.uleb128 0x15
	.byte	0xb
	.byte	0x36
	.byte	0xc
	.long	0x4f6
	.uleb128 0x23
	.string	"abs"
	.byte	0xa
	.value	0x306
	.byte	0xc
	.long	0x63
	.long	0xa2e
	.uleb128 0x17
	.long	0x63
	.byte	0
	.uleb128 0x15
	.byte	0xb
	.byte	0x36
	.byte	0xc
	.long	0xa17
	.uleb128 0x15
	.byte	0xb
	.byte	0x37
	.byte	0xc
	.long	0x6b0
	.uleb128 0x15
	.byte	0xb
	.byte	0x38
	.byte	0xc
	.long	0x6cd
	.uleb128 0x15
	.byte	0xb
	.byte	0x39
	.byte	0xc
	.long	0x6e3
	.uleb128 0x15
	.byte	0xb
	.byte	0x3a
	.byte	0xc
	.long	0x6f9
	.uleb128 0x15
	.byte	0xb
	.byte	0x3c
	.byte	0xc
	.long	0x583
	.uleb128 0x15
	.byte	0xb
	.byte	0x3c
	.byte	0xc
	.long	0x510
	.uleb128 0x15
	.byte	0xb
	.byte	0x3c
	.byte	0xc
	.long	0x724
	.uleb128 0x15
	.byte	0xb
	.byte	0x3e
	.byte	0xc
	.long	0x740
	.uleb128 0x15
	.byte	0xb
	.byte	0x40
	.byte	0xc
	.long	0x757
	.uleb128 0x15
	.byte	0xb
	.byte	0x43
	.byte	0xc
	.long	0x773
	.uleb128 0x15
	.byte	0xb
	.byte	0x44
	.byte	0xc
	.long	0x78f
	.uleb128 0x15
	.byte	0xb
	.byte	0x45
	.byte	0xc
	.long	0x7c2
	.uleb128 0x15
	.byte	0xb
	.byte	0x47
	.byte	0xc
	.long	0x7e3
	.uleb128 0x15
	.byte	0xb
	.byte	0x48
	.byte	0xc
	.long	0x818
	.uleb128 0x15
	.byte	0xb
	.byte	0x4a
	.byte	0xc
	.long	0x825
	.uleb128 0x15
	.byte	0xb
	.byte	0x4b
	.byte	0xc
	.long	0x838
	.uleb128 0x15
	.byte	0xb
	.byte	0x4c
	.byte	0xc
	.long	0x859
	.uleb128 0x15
	.byte	0xb
	.byte	0x4d
	.byte	0xc
	.long	0x879
	.uleb128 0x15
	.byte	0xb
	.byte	0x4e
	.byte	0xc
	.long	0x899
	.uleb128 0x15
	.byte	0xb
	.byte	0x50
	.byte	0xc
	.long	0x8b0
	.uleb128 0x15
	.byte	0xb
	.byte	0x51
	.byte	0xc
	.long	0x8d7
	.uleb128 0x27
	.long	.LASF107
	.byte	0x1
	.byte	0xc
	.byte	0x1
	.byte	0x8
	.uleb128 0x27
	.long	.LASF108
	.byte	0x1
	.byte	0xc
	.byte	0x2
	.byte	0x8
	.uleb128 0x28
	.long	.LASF116
	.byte	0x1
	.byte	0x20
	.byte	0x6
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x29
	.long	.LASF117
	.byte	0x1
	.byte	0x15
	.byte	0x6
	.long	.LASF118
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xb57
	.uleb128 0x2a
	.long	.Ldebug_ranges0+0x30
	.long	0xb43
	.uleb128 0x2b
	.string	"x"
	.byte	0x1
	.byte	0x18
	.byte	0x1b
	.long	0xb57
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.uleb128 0x2c
	.long	.Ldebug_ranges0+0x60
	.uleb128 0x2b
	.string	"x"
	.byte	0x1
	.byte	0x1a
	.byte	0x1c
	.long	0xb5d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.byte	0
	.byte	0
	.uleb128 0x2d
	.byte	0x8
	.long	0xade
	.uleb128 0x2d
	.byte	0x8
	.long	0xae7
	.uleb128 0x2e
	.long	.LASF119
	.byte	0x1
	.byte	0x6
	.byte	0x6
	.long	.LASF120
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x2f
	.quad	.LBB2
	.quad	.LBE2-.LBB2
	.long	0xba4
	.uleb128 0x2b
	.string	"x"
	.byte	0x1
	.byte	0x9
	.byte	0x1b
	.long	0xb57
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.byte	0
	.uleb128 0x2c
	.long	.Ldebug_ranges0+0
	.uleb128 0x2b
	.string	"x"
	.byte	0x1
	.byte	0xf
	.byte	0x1b
	.long	0xb57
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x39
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x39
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x89
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x3a
	.byte	0
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x18
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x8
	.byte	0
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x18
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x39
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x15
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x87
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2d
	.uleb128 0x10
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.quad	.LBB3-.Ltext0
	.quad	.LBE3-.Ltext0
	.quad	.LBB4-.Ltext0
	.quad	.LBE4-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB5-.Ltext0
	.quad	.LBE5-.Ltext0
	.quad	.LBB7-.Ltext0
	.quad	.LBE7-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB6-.Ltext0
	.quad	.LBE6-.Ltext0
	.quad	.LBB8-.Ltext0
	.quad	.LBE8-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF8:
	.string	"__off_t"
.LASF12:
	.string	"_IO_read_ptr"
.LASF24:
	.string	"_chain"
.LASF65:
	.string	"quot"
.LASF7:
	.string	"size_t"
.LASF62:
	.string	"__cxx11"
.LASF97:
	.string	"lldiv"
.LASF30:
	.string	"_shortbuf"
.LASF60:
	.string	"_ZSt3absx"
.LASF63:
	.string	"_ZSt3divll"
.LASF47:
	.string	"_IO_2_1_stderr_"
.LASF18:
	.string	"_IO_buf_base"
.LASF95:
	.string	"wcstombs"
.LASF70:
	.string	"7lldiv_t"
.LASF73:
	.string	"long long unsigned int"
.LASF75:
	.string	"atexit"
.LASF66:
	.string	"div_t"
.LASF71:
	.string	"long long int"
.LASF4:
	.string	"signed char"
.LASF84:
	.string	"mblen"
.LASF25:
	.string	"_fileno"
.LASF13:
	.string	"_IO_read_end"
.LASF91:
	.string	"strtod"
.LASF101:
	.string	"strtof"
.LASF6:
	.string	"long int"
.LASF92:
	.string	"strtol"
.LASF11:
	.string	"_flags"
.LASF19:
	.string	"_IO_buf_end"
.LASF28:
	.string	"_cur_column"
.LASF105:
	.string	"__float128"
.LASF69:
	.string	"ldiv_t"
.LASF54:
	.string	"_sys_errlist"
.LASF27:
	.string	"_old_offset"
.LASF32:
	.string	"_offset"
.LASF87:
	.string	"mbtowc"
.LASF89:
	.string	"qsort"
.LASF111:
	.string	"/mnt/c/Users/Rock0x3FA/WorkSpace/MyException/exception_project"
.LASF48:
	.string	"stdin"
.LASF3:
	.string	"unsigned int"
.LASF116:
	.string	"seppuku"
.LASF106:
	.string	"__int128"
.LASF107:
	.string	"FirstException"
.LASF0:
	.string	"long unsigned int"
.LASF90:
	.string	"srand"
.LASF113:
	.string	"_IO_FILE_plus"
.LASF115:
	.string	"rand"
.LASF16:
	.string	"_IO_write_ptr"
.LASF51:
	.string	"sys_nerr"
.LASF43:
	.string	"_sbuf"
.LASF67:
	.string	"5div_t"
.LASF2:
	.string	"short unsigned int"
.LASF81:
	.string	"bsearch"
.LASF20:
	.string	"_IO_save_base"
.LASF86:
	.string	"wchar_t"
.LASF31:
	.string	"_lock"
.LASF26:
	.string	"_flags2"
.LASF38:
	.string	"_mode"
.LASF49:
	.string	"stdout"
.LASF117:
	.string	"handler"
.LASF45:
	.string	"_IO_2_1_stdin_"
.LASF82:
	.string	"getenv"
.LASF120:
	.string	"_Z15unsafe_functionv"
.LASF104:
	.string	"long double"
.LASF17:
	.string	"_IO_write_end"
.LASF76:
	.string	"at_quick_exit"
.LASF83:
	.string	"ldiv"
.LASF112:
	.string	"_IO_lock_t"
.LASF40:
	.string	"_IO_FILE"
.LASF110:
	.string	"raise_exception.cpp"
.LASF109:
	.string	"GNU C++14 9.3.0 -masm=intel -mtune=generic -march=x86-64 -g -fasynchronous-unwind-tables -fstack-protector-strong"
.LASF102:
	.string	"float"
.LASF41:
	.string	"_IO_marker"
.LASF44:
	.string	"_pos"
.LASF52:
	.string	"sys_errlist"
.LASF23:
	.string	"_markers"
.LASF85:
	.string	"mbstowcs"
.LASF77:
	.string	"atof"
.LASF79:
	.string	"atoi"
.LASF80:
	.string	"atol"
.LASF1:
	.string	"unsigned char"
.LASF68:
	.string	"6ldiv_t"
.LASF72:
	.string	"lldiv_t"
.LASF5:
	.string	"short int"
.LASF103:
	.string	"strtold"
.LASF53:
	.string	"_sys_nerr"
.LASF99:
	.string	"strtoll"
.LASF29:
	.string	"_vtable_offset"
.LASF46:
	.string	"_IO_2_1_stdout_"
.LASF96:
	.string	"wctomb"
.LASF59:
	.string	"_ZSt3absd"
.LASF57:
	.string	"_ZSt3abse"
.LASF58:
	.string	"_ZSt3absf"
.LASF55:
	.string	"_ZSt3absg"
.LASF98:
	.string	"atoll"
.LASF64:
	.string	"_ZN9__gnu_cxx3divExx"
.LASF61:
	.string	"_ZSt3absl"
.LASF56:
	.string	"_ZSt3absn"
.LASF88:
	.string	"quick_exit"
.LASF108:
	.string	"SecondException"
.LASF10:
	.string	"char"
.LASF100:
	.string	"strtoull"
.LASF119:
	.string	"unsafe_function"
.LASF42:
	.string	"_next"
.LASF9:
	.string	"__off64_t"
.LASF14:
	.string	"_IO_read_base"
.LASF22:
	.string	"_IO_save_end"
.LASF33:
	.string	"__pad1"
.LASF34:
	.string	"__pad2"
.LASF35:
	.string	"__pad3"
.LASF36:
	.string	"__pad4"
.LASF37:
	.string	"__pad5"
.LASF39:
	.string	"_unused2"
.LASF50:
	.string	"stderr"
.LASF93:
	.string	"strtoul"
.LASF118:
	.string	"_Z7handlerv"
.LASF21:
	.string	"_IO_backup_base"
.LASF94:
	.string	"system"
.LASF74:
	.string	"__compar_fn_t"
.LASF15:
	.string	"_IO_write_base"
.LASF78:
	.string	"double"
.LASF114:
	.string	"__gnu_cxx"
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2~16.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
