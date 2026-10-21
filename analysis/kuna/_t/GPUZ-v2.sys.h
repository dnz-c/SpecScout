#ifndef GPUZ_V2_SYS_H
#define GPUZ_V2_SYS_H

/* kuna recompile prelude (generated): core scalar typedefs */
#include <stdbool.h>
/* target pointers are 8 bytes: compile for that data model, or a
   `T *` member of a different width moves every field after it */

typedef double float8;
typedef float float4;
typedef int int4;
typedef int wchar4;
typedef long double float10; /* sizeof may differ */
typedef long double float16; /* sizeof may differ */
typedef long long int8;
typedef short int2;
typedef short wchar2;
typedef signed char int1;
typedef unsigned char code; /* pseudo (function body) type */
typedef unsigned char uint1;
typedef unsigned char xunknown1;
typedef unsigned int uint4;
typedef unsigned int xunknown4;
typedef unsigned long long uint8;
typedef unsigned long long xunknown8;
typedef unsigned short uint2;
typedef unsigned short xunknown2;

/* the Ghidra/kuna `undefined` family */
typedef unsigned char undefined;
typedef unsigned char undefined1;
typedef unsigned short undefined2;
typedef unsigned int undefined3; /* 3 bytes in the decompiler; sizeof differs */
typedef unsigned int undefined4;
typedef unsigned long long undefined5; /* 5 bytes in the decompiler; sizeof differs */
typedef unsigned long long undefined6; /* 6 bytes in the decompiler; sizeof differs */
typedef unsigned long long undefined7; /* 7 bytes in the decompiler; sizeof differs */
typedef unsigned long long undefined8;
typedef struct { unsigned char b[16]; } undefined16;
typedef struct { unsigned char b[32]; } undefined32;

/* user-defined types */
typedef struct struct_0 struct_0;
typedef struct struct_1 struct_1;
typedef struct struct_2 struct_2;
typedef struct struct_3 struct_3;
typedef struct struct_4 struct_4;
typedef struct struct_5 struct_5;
typedef struct struct_6 struct_6;
typedef struct struct_7 struct_7;
typedef struct struct_8 struct_8;

struct struct_0 {
    short field_0x0;
    short field_0x2;
    char field_0x4[4];
    short *field_0x8;
};

struct struct_1 {
    short field_0x0;
    char field_0x2[6];
    unsigned long long field_0x8;
};

struct struct_2 {
    unsigned char field_0x0;
    char field_0x1[7];
    unsigned long long field_0x8;
};

struct struct_3 {
    unsigned int field_0x0;
    char field_0x4[4];
    unsigned long long field_0x8;
};

struct struct_4 {
    unsigned int field_0x0;
    unsigned short field_0x4;
    unsigned short field_0x6;
    unsigned char field_0x8;
    char field_0x9;
    char field_0xa;
    char field_0xb;
    char field_0xc;
    char field_0xd;
    char field_0xe;
    char field_0xf;
};

struct struct_5 {
    unsigned int field_0x0;
    unsigned int field_0x4;
    unsigned long long field_0x8;
    unsigned int field_0x10;
    unsigned int field_0x14;
};

struct struct_6 {
    unsigned int field_0x0;
    unsigned int field_0x4;
    unsigned long long field_0x8;
    unsigned int field_0x10;
    unsigned int field_0x14;
};

struct struct_7 {
    unsigned short field_0x0;
    unsigned short field_0x2;
    char field_0x4[4];
    unsigned long long field_0x8;
};

struct struct_8 {
    unsigned short field_0x0;
    short field_0x2;
    char field_0x4[4];
    long long field_0x8;
};


/* globals the code names by address */
extern unsigned long long *dat_140003100;
extern long long *dat_140003140;
extern unsigned int dat_140004044;
extern unsigned long long dat_140004150;
/* dat_1400041d0 is read at two types, so it is not declared: long long dat_1400041d0, unsigned long long dat_1400041d0 */
extern unsigned long long dat_1400041d8;
extern char dat_1400041e0;
/* dat_1400041e8 is read at two types, so it is not declared: unsigned long long dat_1400041e8, void *dat_1400041e8, void (*dat_1400041e8)(unsigned long long,unsigned int,unsigned long long,unsigned int,unsigned int,char,unsigned long long,unsigned long long,unsigned long long) */
extern unsigned long long dat_1400041f0;
extern int dat_1400041f8;
/* dat_140004220 is read at two types, so it is not declared: short dat_140004220, unsigned int dat_140004220, unsigned long long dat_140004220 */
/* dat_140004222 is overlapped by dat_140004220, so it is not declared: short dat_140004222 */
/* dat_140004224 is overlapped by dat_140004220, so it is not declared: unsigned int dat_140004224 */
/* dat_140004228 is read at two types, so it is not declared: unsigned long long dat_140004228, long long dat_140004228 */
/* dat_140004230 is read at two types, so it is not declared: short dat_140004230, unsigned int dat_140004230, unsigned long long dat_140004230 */
/* dat_140004232 is overlapped by dat_140004230, so it is not declared: short dat_140004232 */
/* dat_140004234 is overlapped by dat_140004230, so it is not declared: unsigned int dat_140004234 */
/* dat_140004238 is read at two types, so it is not declared: unsigned long long dat_140004238, long long dat_140004238 */

/* function prototypes */
unsigned long long sub_140001000(struct_0 *a0,short *a1);
void sub_14000105c(unsigned long long a0,void *a1,unsigned int *a2);
unsigned long long sub_1400010c0(unsigned long long a0,unsigned long long a1,unsigned long long a2,void *a3);
void sub_1400010f0(unsigned long long *a0,unsigned char a1,unsigned long long a2);
unsigned long long * sub_1400011f0(unsigned long long *a0,unsigned long long *a1,unsigned long long a2);
void sub_140001540(long long a0);
void sub_140001560(unsigned long long a0);
unsigned long long sub_140001590(unsigned int a0,unsigned long long a1,unsigned long long a2,unsigned long long a3);
int sub_1400016a0(unsigned short *a0,long long a1,unsigned long long a2,unsigned long long a3);
int sub_140001730(void *a0,struct_1 *a1);
unsigned long long sub_140001aa0(void *a0,void *a1);
unsigned long long sub_140001ad0(void *a0,void *a1);
unsigned long long sub_140001b00(unsigned long long a0,void *a1);
void sub_140001b30(void *a0);
unsigned long long sub_140001be0(unsigned long long a0,void *a1);
unsigned long long sub_140001c10(void *a0,void *a1);
unsigned long long sub_140001cb0(void *a0,void *a1);
unsigned long long sub_140001d30(void *a0,void *a1,void *a2);
int sub_140001ef0(void *a0,void *a1);
void __C_specific_handler(void);
void _snwprintf(void);
void wcschr(void);
void _wcsnicmp(void);
void sub_140008000(void);
void sub_140008068(unsigned long long a0,unsigned int a1,unsigned long long a2,unsigned int a3,unsigned int a4,char a5,unsigned long long a6,unsigned long long a7,unsigned long long a8);
unsigned long long sub_1400080f8(unsigned long long a0,struct_2 *a1);
unsigned long long sub_14000819c(unsigned long long a0,unsigned int a1,long long a2,unsigned int a3,unsigned int a4,char a5,unsigned long long a6,long long a7,unsigned long long *a8);
void sub_14000834c(unsigned long long a0,struct_3 *a1);
void sub_140008358(struct_2 *a0);
void sub_140008374(struct_4 *a0,unsigned int a1,int a2,unsigned int *a3,unsigned long long *a4);
void sub_14000850c(struct_5 *a0);
int sub_140008520(unsigned long long a0,struct_6 *a1);
unsigned long long sub_1400086e4(unsigned long long a0,void *a1,struct_5 *a2);
unsigned long long sub_14000880c(unsigned long long a0,void *a1);
unsigned long long sub_140008930(unsigned short *a0,unsigned long long *a1,unsigned int *a2);
unsigned long long sub_140008a0c(long long *a0,unsigned int *a1,unsigned long long a2,unsigned long long a3,unsigned int a4,int a5,unsigned long long a6);
unsigned long long sub_140008aec(long long a0,unsigned int *a1,long long *a2);
unsigned long long sub_140008b80(long long a0,unsigned long long *a1,long long *a2);
unsigned long long sub_140008c40(short *a0,long long *a1,long long *a2);
int sub_140008ffc(short *a0,int a1,unsigned int *a2,long long *a3);
int sub_1400090bc(unsigned long long a0,unsigned long long a1,long long *a2);
unsigned long long sub_1400091b8(struct_7 *a0,unsigned int a1,unsigned long long *a2);
void sub_14000927c(unsigned char a0,unsigned int *a1);
unsigned long long sub_1400092a4(unsigned long long a0,char *a1,unsigned int *a2);
unsigned int sub_14000936c(struct_8 *a0,unsigned short a1);
int sub_1400093b4(unsigned long long a0,unsigned long long a1,struct_7 *a2);
void sub_1400094b0(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned int *a3);
int sub_140009524(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned int a3,unsigned long long a4,unsigned int *a5,unsigned long long *a6);
void sub_1400095bc(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned long long *a3);
void sub_140009614(unsigned long long a0,unsigned long long a1,unsigned long long a2);
void sub_140009664(unsigned long long a0,unsigned long long a1,unsigned long long a2);
void sub_1400096a0(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned long long a3,unsigned int a4);
void sub_1400096f8(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned long long a3);
void sub_140009744(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned int a3,unsigned long long a4,unsigned long long a5,unsigned long long a6);
void sub_1400097b4(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned long long a3);
unsigned long long sub_140009800(unsigned long long a0,unsigned short *a1,int a2,int a3,long long *a4);
void sub_140009934(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned int a3,unsigned long long a4);

#endif /* GPUZ_V2_SYS_H */
