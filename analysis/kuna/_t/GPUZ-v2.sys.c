#include "GPUZ-v2.sys.h"

// Function: sub_140001000 @ 0x140001000
unsigned long long sub_140001000(struct_0 *a0,short *a1) // return-dupe
{
  short *v1; // rdi
  short v2; // ax
  unsigned long long v3; // rcx
  short *v4; // rdi | rdx
  
  if (!a1) {
    a0->field_0x0 = 0;
    a0->field_0x2 = 0;
    a0->field_0x8 = NULL;
    return 0;
  }
  v3 = 0xffffffffffffffff;
  v4 = a1;
  do {
    if (!v3) break;
    v3 -= 1;
    v1 = &v4[1];
    v2 = *v4;
    v4 = v1;
  } while (v2);
  if (~v3 - 1 <= 0x7ffe) {
    v2 = (short)(~v3 - 1) * 2;
    a0->field_0x8 = a1;
    a0->field_0x0 = v2;
    a0->field_0x2 = v2 + 2;
    return 0;
  }
  return 0xc0000106;
}

// Function: sub_14000105c @ 0x14000105c
void sub_14000105c(unsigned long long a0,void *a1,unsigned int *a2)
{
  long long v1; // rcx
  unsigned long long v2; // r10 | r9 | rcx
  
  v2 = a0;
  if (*(unsigned char *)a2 & 4)
    v2 = (int)a2[1] + a0 & (int)-a2[2];
  v1 = (unsigned long long)*(unsigned int *)(((long long *)a1)[2] + 8) + ((long long *)a1)[1];
  if (*(unsigned char *)(v1 + 3) & 0xf)
    a0 += (int)(*(unsigned char *)(v1 + 3) & 0xfffffff0);
  sub_140001540(a0 ^ *(unsigned long long *)((int)(*a2 & 0xfffffff8) + v2)); // tail-call
}

// Function: sub_1400010c0 @ 0x1400010c0
unsigned long long sub_1400010c0(unsigned long long a0,unsigned long long a1,unsigned long long a2,void *a3)
{
  sub_14000105c(a1,a3,((unsigned long long *)a3)[7]);
  return 1;
}

// Function: sub_1400010f0 @ 0x1400010f0
void sub_1400010f0(unsigned long long *a0,unsigned char a1,unsigned long long a2)
{
  unsigned int v1; // ecx
  unsigned long long *v2; // rcx
  unsigned long long v3; // rdx
  unsigned long long v4; // r8 | r9
  
  v3 = a1;
  v4 = a2;
  if (8 <= a2) {
    v3 *= 0x101010101010101;
    if (0x40 <= a2) {
      v1 = -(int)a0 & 7;
      if (v1) {
        v4 = a2 - v1;
        *a0 = v3;
      }
      a0 = (unsigned long long *)((unsigned long long)v1 + (long long)a0);
      a2 = v4 & 0x3f;
      v4 >>= 6;
      if (v4) {
        v2 = a0;
        if (0x1c00 <= v4) { // branch-flip
          do {
            *v2 = v3;
            v2[1] = v3;
            v2[2] = v3;
            a0 = &v2[8];
            v2[3] = v3;
            v2[4] = v3;
            v4 -= 1;
            v2[5] = v3;
            v2[6] = v3;
            v2[7] = v3;
            v2 = a0;
          } while (v4);
          LOCK();
          UNLOCK();
        }
        else {
          do {
            *v2 = v3;
            v2[1] = v3;
            v2[2] = v3;
            a0 = &v2[8];
            v2[3] = v3;
            v2[4] = v3;
            v4 -= 1;
            v2[5] = v3;
            v2[6] = v3;
            v2[7] = v3;
            v2 = a0;
          } while (v4);
        }
      }
    }
    v4 = a2 & 7;
    for (a2 = a2 >> 3; a2; a2 = a2 - 1) {
      *a0 = v3;
      a0 = &a0[1];
    }
  }
  for (; v4; v4 = v4 - 1) {
    *(char *)a0 = v3;
    a0 = (unsigned long long *)((long long)a0 + 1);
  }
}

// Function: sub_1400011f0 @ 0x1400011f0
unsigned long long * sub_1400011f0(unsigned long long *a0,unsigned long long *a1,unsigned long long a2)
{
  unsigned long long v1; // r10
  int v2; // eax
  unsigned long long *v3; // r11 | rcx
  unsigned long long *v4; // r11 | rcx
  unsigned long long v5; // rdx
  unsigned long long v6; // r9
  
  v5 = (long long)a1 - (long long)a0;
  if (a1 < a0) {
    v4 = (unsigned long long *)((long long)a0 + a2);
    v3 = v4;
    if (a2 < 8) goto label_140001404;
    if ((unsigned long long)v4 & 7) {
      if ((unsigned long long)v4 & 1) {
        v4 = (unsigned long long *)((long long)v4 + -1);
        a2 -= 1;
        *(char *)v4 = ((char *)v4)[v5];
      }
      if ((unsigned long long)v4 & 2) {
        v4 = (unsigned long long *)((long long)v4 + -2);
        a2 -= 2;
        *(unsigned short *)v4 = *(unsigned short *)(v5 + (long long)v4);
      }
      if ((unsigned long long)v4 & 4) {
        v4 = (unsigned long long *)((long long)v4 + -4);
        a2 -= 4;
        *(unsigned int *)v4 = *(unsigned int *)(v5 + (long long)v4);
      }
    }
    while (v6 = a2 >> 5, v3 = v4, v6) {
      if ((v6 <= 0x1fff) || (0xfffffffffffff001 <= v5)) goto label_140001440;
      do {
        v2 = 0x20;
        do {
          v3 = v4;
          v2 -= 1;
          v4 = &v3[-0x10];
        } while (v2);
        v2 = 0x40;
        v3 = &v3[0x1f0];
        do {
          v1 = *(unsigned long long *)((v5 - 0x10) + (long long)v3);
          v3[-1] = *(unsigned long long *)((v5 - 8) + (long long)v3);
          v3[-2] = v1;
          v1 = *(unsigned long long *)((v5 - 0x20) + (long long)v3);
          v3[-3] = *(unsigned long long *)((v5 - 0x18) + (long long)v3);
          v3[-4] = v1;
          v1 = *(unsigned long long *)((v5 - 0x30) + (long long)v3);
          v4 = &v3[-8];
          v3[-5] = *(unsigned long long *)((v5 - 0x28) + (long long)v3);
          v3[-6] = v1;
          v1 = *(unsigned long long *)(v5 + (long long)v4);
          v2 -= 1;
          v3[-7] = *(unsigned long long *)(v5 + 8 + (long long)v4);
          *v4 = v1;
          v3 = v4;
        } while (v2);
        a2 -= 0x1000;
      } while (0x1000 <= a2);
      LOCK();
      UNLOCK();
    }
    goto label_1400013e7;
  }
  v4 = a0;
  if (a2 < 8) goto label_140001264;
  v3 = a0;
  if ((unsigned long long)a0 & 7) {
    if ((unsigned long long)a0 & 1) {
      a2 -= 1;
      *(char *)a0 = ((char *)a0)[v5];
      v3 = (unsigned long long *)((long long)a0 + 1);
    }
    if ((unsigned long long)v3 & 2) {
      a2 -= 2;
      *(unsigned short *)v3 = *(unsigned short *)(v5 + (long long)v3);
      v3 = (unsigned long long *)((long long)v3 + 2);
    }
    if ((unsigned long long)v3 & 4) {
      a2 -= 4;
      *(unsigned int *)v3 = *(unsigned int *)(v5 + (long long)v3);
      v3 = (unsigned long long *)((long long)v3 + 4);
    }
  }
  while (v6 = a2 >> 5, v4 = v3, v6) {
    if ((v6 <= 0x1fff) || (v5 < 0x1000)) goto label_1400012a0;
    do {
      v2 = 0x20;
      do {
        v4 = v3;
        v2 -= 1;
        v3 = &v4[0x10];
      } while (v2);
      v2 = 0x40;
      v4 = &v4[-0x1f0];
      do {
        v1 = *(unsigned long long *)(v5 + 8 + (long long)v4);
        *v4 = *(unsigned long long *)(v5 + (long long)v4);
        v4[1] = v1;
        v1 = *(unsigned long long *)(v5 + 0x18 + (long long)v4);
        v4[2] = *(unsigned long long *)(v5 + 0x10 + (long long)v4);
        v4[3] = v1;
        v1 = *(unsigned long long *)(v5 + 0x28 + (long long)v4);
        v3 = &v4[8];
        v4[4] = *(unsigned long long *)(v5 + 0x20 + (long long)v4);
        v4[5] = v1;
        v1 = *(unsigned long long *)((v5 - 8) + (long long)v3);
        v2 -= 1;
        v4[6] = *(unsigned long long *)((v5 - 0x10) + (long long)v3);
        v4[7] = v1;
        v4 = v3;
      } while (v2);
      a2 -= 0x1000;
    } while (0x1000 <= a2);
    LOCK();
    UNLOCK();
  }
  goto label_140001247;
label_140001440:
  do {
    v1 = *(unsigned long long *)((v5 - 0x10) + (long long)v4);
    v3 = &v4[-4];
    v4[-1] = *(unsigned long long *)((v5 - 8) + (long long)v4);
    v4[-2] = v1;
    v1 = *(unsigned long long *)(v5 + (long long)v3);
    v6 -= 1;
    v4[-3] = *(unsigned long long *)(v5 + 8 + (long long)v3);
    *v3 = v1;
    v4 = v3;
  } while (v6);
  a2 &= 0x1f;
label_1400013e7:
  v6 = a2 >> 3;
  if (v6) {
    do {
      v3 = &v3[-1];
      v6 -= 1;
      *v3 = *(unsigned long long *)(v5 + (long long)v3);
    } while (v6);
    a2 &= 7;
  }
label_140001404:
  if (!a2)
    return a0;
  do {
    v3 = (unsigned long long *)((long long)v3 + -1);
    a2 -= 1;
    *(char *)v3 = ((char *)v3)[v5];
  } while (a2);
  return a0;
label_1400012a0:
  do {
    v1 = *(unsigned long long *)(v5 + 8 + (long long)v3);
    v4 = &v3[4];
    *v3 = *(unsigned long long *)(v5 + (long long)v3);
    v3[1] = v1;
    v1 = *(unsigned long long *)((v5 - 8) + (long long)v4);
    v6 -= 1;
    v3[2] = *(unsigned long long *)((v5 - 0x10) + (long long)v4);
    v3[3] = v1;
    v3 = v4;
  } while (v6);
  a2 &= 0x1f;
label_140001247:
  v6 = a2 >> 3;
  if (v6) {
    do {
      *v4 = *(unsigned long long *)(v5 + (long long)v4);
      v4 = &v4[1];
      v6 -= 1;
    } while (v6);
    a2 &= 7;
  }
label_140001264:
  if (!a2)
    return a0;
  do {
    *(char *)v4 = ((char *)v4)[v5];
    v4 = (unsigned long long *)((long long)v4 + 1);
    a2 -= 1;
  } while (a2);
  return a0;
}

// Function: sub_140001540 @ 0x140001540
void sub_140001540(long long a0)
{
  if ((a0 == dat_1400041d0) && (!(short)((unsigned long long)a0 >> 0x30)))
    return;
  sub_140001560(a0); // tail-call
}

// Function: sub_140001560 @ 0x140001560
void sub_140001560(unsigned long long a0)
{
  KeBugCheckEx(0xf7,a0,dat_1400041d0,dat_1400041d8,0); // no-return
}

// Function: sub_140001590 @ 0x140001590
unsigned long long sub_140001590(unsigned int a0,unsigned long long a1,unsigned long long a2,unsigned long long a3)
{
  unsigned int *v1; // rbx
  unsigned int v2; // eax
  unsigned long long v3; // rax
  unsigned long long v4; // rax
  char *v5; // rcx
  unsigned int v6; // edx | r8d
  unsigned long long v7; // r8 | stack + 0x18
  long long v8; // rdi
  unsigned long long v9; // cr8 | rax
  unsigned long long v10; // r9 | stack + 0x20
  
  if (a0 <= 4) {
    v6 = 0;
    while( true ) {
      v4 = 0;
      v1 = (unsigned int *)(v6 * 4ULL + 0x140004200);
      LOCK();
      v2 = *v1;
      if (!v2)
        *v1 = 1;
      else {
        v4 = v2;
      }
      UNLOCK();
      if (!v2) break;
      v6 += 1;
      if (8 <= v6)
        return v4;
    }
    v8 = v6 * 0x400ULL + 0x140004240;
    v7 = a2;
    v10 = a3;
    v2 = _vsnprintf(v8,0x3ff,a1,&v7);
    if ((((int)v2 < 0) || (0x400 <= v2)) || (v2 == 0x3ff))
      *(char *)(v6 * 0x400ULL + 0x14000463f) = 0;
    if (a0 != 1) { // branch-flip
      if (a0 != 2) { // branch-flip
        v5 = "%S (IRQL %2.2d): INFO %s\n";
        if (a0 != 4)
          v5 = "%S (IRQL %2.2d): %s\n";
      }
      else {
        v5 = "%S (IRQL %2.2d): WARNING %s\n";
      }
    }
    else {
      v5 = "%S (IRQL %2.2d): ERROR %s\n";
    }
    v3 = DbgPrint(v5,dat_140004228,v9 & 0xff,v8);
    LOCK();
    *v1 = 0;
    UNLOCK();
  }
  return v3;
}

// Function: sub_1400016a0 @ 0x1400016a0
int sub_1400016a0(unsigned short *a0,long long a1,unsigned long long a2,unsigned long long a3) // return-dupe
{
  unsigned long long v1; // rdi
  int v2; // eax | r9d
  unsigned long long v3; // r9 | stack + 0x20
  
  v2 = 0;
  if (0x7fffffff <= (unsigned long long)(a1 - 1U))
    v2 = -0x3ffffff3;
  if (v2 <= -1)
    return v2;
  v1 = a1 - 1;
  v3 = a3;
  v2 = _vsnwprintf(a0,v1,a2,&v3);
  if ((0 <= v2) && ((unsigned long long)v2 <= v1)) {
    if ((long long)v2 != v1)
      return 0;
    a0[v1] = 0;
    return 0;
  }
  a0[v1] = 0;
  return -0x7ffffffb;
}

// Function: sub_140001730 @ 0x140001730
int sub_140001730(void *a0,struct_1 *a1)
{
  unsigned long long v1; // rcx
  long long *v2; // rbx
  short v3; // ax | dx | ram 0x140004222 | ram 0x140004230
  short v4; // ax | dx | ram 0x140004232
  int v5; // eax | ebx
  short v6 [8]; // ax | ram 0x140004220 | stack - 0x428
  char v7 [512]; // stack - 0x408
  char v8 [8]; // stack - 0x438
  long long v9 [3]; // rax | rcx | stack + 0x10
  char v10 [512]; // stack - 0x208
  char v11 [8]; // stack - 0x418
  unsigned long long v12; // r8 | r9 | stack - 0x430
  unsigned long long v13; // r8 | stack - 0x410
  
  sub_140001590(4,"Driver compiled at %s on %s","09:14:17","Apr 11 2022");
  dat_140004220 = 0;
  dat_140004228 = 0;
  dat_140004230 = 0;
  dat_140004238 = 0;
  v1 = a1->field_0x8;
  RtlInitUnicodeString(v6,wcsrchr(v1,0x5c) + 2);
  dat_140004220 = v6[0];
  v3 = v6[0] + 2;
  dat_140004222 = v3;
  dat_140004220 = CONCAT22(v3,v6[0]);
  dat_140004228 = ExAllocatePoolWithTag(1,(unsigned short)v3,0x76697244);
  if (!dat_140004228) {
    sub_140001590(1,"DriverEntry: Failed to allocate memory for DriverName");
    return -0x3fffff66;
  }
  RtlCopyUnicodeString(0x140004220,v6);
  v3 = a1->field_0x0;
  dat_140004230 = v3;
  v4 = a1->field_0x0 + 2;
  dat_140004232 = v4;
  dat_140004230 = CONCAT22(v4,v3);
  dat_140004238 = ExAllocatePoolWithTag(1,(unsigned short)v4,0x76697244);
  if (!dat_140004238) {
    sub_140001590(1,"DriverEntry: Failed to allocate memory for RegistryPath");
    return -0x3fffff66;
  }
  RtlCopyUnicodeString(0x140004230,a1);
  *(void **)((long long)a0 + 0x70) = sub_140001aa0;
  *(void **)((long long)a0 + 0x80) = sub_140001ad0;
  *(void **)((long long)a0 + 0xe0) = sub_140001ef0;
  *(void **)((long long)a0 + 0x100) = sub_140001b00;
  *(void **)((long long)a0 + 0xf0) = sub_140001be0;
  *(void **)((long long)a0 + 0x68) = sub_140001b30;
  sub_1400016a0(v7,0xff,L"\\Device\\%ls",dat_140004228);
  RtlInitUnicodeString(v8,v7);
  v5 = sub_140008068(a0,0x2818,v8,0x22,0x100,0,0x1400032b0,0,v9);
  if (v5 <= -1) {
    ExFreePoolWithTag(dat_140004238,0);
    dat_140004238 = 0;
    sub_140001590(1,"DriverEntry--. STATUS %x",v5);
    return v5;
  }
  sub_140001590(4,"Created device: %S",v12);
  v2 = *(long long **)(v9[0] + 0x40);
  sub_1400010f0(v2,0,0x2818);
  *v2 = v9[0];
  *(unsigned int *)(v9[0] + 0x30) = *(unsigned int *)(v9[0] + 0x30) | 0x10;
  sub_1400016a0(v10,0xff,L"\\??\\%ls",dat_140004228);
  RtlInitUnicodeString(v11,v10);
  v5 = IoCreateSymbolicLink(v11,v8);
  if (v5 <= -1) {
    IoDeleteDevice(v9[0]);
    ExFreePoolWithTag(dat_140004238,0);
    dat_140004238 = 0;
    return v5;
  }
  sub_140001590(4,"Created link: %S -> %S",v13,v12);
  IoRegisterShutdownNotification(v9[0]);
  *(unsigned int *)(v9[0] + 0x30) = *(unsigned int *)(v9[0] + 0x30) & 0xffffff7f;
  return v5;
}

// Function: sub_140001aa0 @ 0x140001aa0
unsigned long long sub_140001aa0(void *a0,void *a1)
{
  int *v1; // tmp
  
  LOCK();
  v1 = (int *)(((long long *)a0)[8] + 8);
  *v1 = *v1 + 1;
  UNLOCK();
  ((unsigned long long *)a1)[7] = 0;
  ((unsigned int *)a1)[0xc] = 0;
  IofCompleteRequest(a1,0);
  return 0;
}

// Function: sub_140001ad0 @ 0x140001ad0
unsigned long long sub_140001ad0(void *a0,void *a1)
{
  int *v1; // tmp
  long long v2; // rbx
  
  v2 = ((long long *)a0)[8];
  ((unsigned long long *)a1)[7] = 0;
  ((unsigned int *)a1)[0xc] = 0;
  IofCompleteRequest(a1,0);
  LOCK();
  v1 = (int *)(v2 + 8);
  *v1 = *v1 + -1;
  UNLOCK();
  return 0;
}

// Function: sub_140001b00 @ 0x140001b00
unsigned long long sub_140001b00(unsigned long long a0,void *a1)
{
  ((unsigned long long *)a1)[7] = 0;
  ((unsigned int *)a1)[0xc] = 0;
  IofCompleteRequest(a1,0);
  return 0;
}

// Function: sub_140001b30 @ 0x140001b30
void sub_140001b30(void *a0)
{
  char v1 [512]; // stack - 0x208
  char v2 [16]; // stack - 0x218
  
  sub_1400016a0(v1,0xff,L"\\??\\%ls",dat_140004228);
  RtlInitUnicodeString(v2,v1);
  IoDeleteSymbolicLink(v2);
  sub_140001590(4,"Deleted link: %S",v1);
  IoUnregisterShutdownNotification(((unsigned long long *)a0)[1]);
  IoDeleteDevice(((unsigned long long *)a0)[1]);
  if (dat_140004238) {
    ExFreePoolWithTag(dat_140004238,0);
    dat_140004238 = 0;
  }
  if (dat_140004228) {
    ExFreePoolWithTag(dat_140004228,0);
    dat_140004228 = 0;
  }
}

// Function: sub_140001be0 @ 0x140001be0
unsigned long long sub_140001be0(unsigned long long a0,void *a1)
{
  ((unsigned int *)a1)[0xc] = 0xc0000002;
  ((unsigned long long *)a1)[7] = 0;
  IofCompleteRequest(a1,0);
  return 0xc0000002;
}

// Function: sub_140001c10 @ 0x140001c10
unsigned long long sub_140001c10(void *a0,void *a1)
{
  unsigned int v1; // ecx
  unsigned long long v2; // r9
  
  if (((int *)a0)[2]) { // branch-flip
    ((unsigned long long *)a1)[7] = 0;
    v2 = 0x48;
  }
  else {
    if (((int *)a0)[4] == 0xc) {
      v1 = *((int **)a1)[3];
      if ((3 <= v1 + 0x3fffff7fU) && (3 <= (unsigned int)(v1 - 0x174U))) {
        wrmsr(v1,*(unsigned long long *)&((int **)a1)[3][1]);
        return 0;
      }
      return 0xc000000d;
    }
    ((unsigned long long *)a1)[7] = 0xc;
    v2 = 0x4f;
  }
  sub_140001590(1,"%s %d: Invalid buffer size","ioctl.c",v2);
  return 0xc0000206;
}

// Function: sub_140001cb0 @ 0x140001cb0
unsigned long long sub_140001cb0(void *a0,void *a1)
{
  unsigned long long v1; // r9
  
  if (((int *)a0)[2] != 8) { // branch-flip
    ((unsigned long long *)a1)[7] = 8;
    v1 = 0x68;
  }
  else {
    if (((int *)a0)[4] == 4) {
      *((unsigned long long **)a1)[3] = rdmsr(*(unsigned int *)((unsigned long long **)a1)[3]);
      return 0;
    }
    ((unsigned long long *)a1)[7] = 4;
    v1 = 0x6f;
  }
  sub_140001590(1,"%s %d: Invalid buffer size","ioctl.c",v1);
  return 0xc0000206;
}

// Function: sub_140001d30 @ 0x140001d30
unsigned long long sub_140001d30(void *a0,void *a1,void *a2) // return-dupe x2
{
  unsigned long long *v1; // r15
  int v2; // eax
  long long v3; // r12 | rax
  long long v4; // r14 | rax
  unsigned long long v5; // rax | rdx
  int *v6; // rax
  long long v7; // rcx | rdi
  char *v8; // rdx
  unsigned long long v9; // rcx | rdi | rdx
  unsigned int v10; // eax | edi
  unsigned char v11; // r9b
  unsigned long long v12; // stack - 0x38
  
  if (((int *)a1)[2] - 4U & 0xfffffffbU) { // branch-flip
    ((unsigned long long *)a2)[7] = 4;
    v11 = 0x92;
  }
  else {
    if (((int *)a1)[4] == 0xc) {
      v1 = ((unsigned long long **)a2)[3];
      v3 = MmMapIoSpace(*v1,*(unsigned int *)&v1[1],0);
      if (v3) { // branch-flip
        v7 = 0;
        v12 = 0;
        v9 = *(unsigned int *)&v1[1];
        v4 = IoAllocateMdl(v3,v9,0,0,0);
        if (v4) { // branch-flip
          MmBuildMdlForNonPagedPool(v4);
          v5 = MmMapLockedPagesSpecifyCache(v4,(unsigned long long)v9 & 0xffffffffffffff00 | (unsigned long long)1 & 0xff,0,0,v12 & 0xffffffff00000000,0x10);
          v2 = ((int *)a1)[2];
          if (v2 == 4) {
            *((unsigned int **)a2)[3] = (int)v5;
            v2 = ((int *)a1)[2];
          }
          if (v2 == 8)
            *((unsigned long long **)a2)[3] = v5;
          v6 = &((int *)a0)[0xc];
          v9 = v7;
          do {
            v10 = v9;
            if (!*v6) {
              *(unsigned int *)((long long)a0 + (int)v10 * 0x28LL + 0x30) = *(unsigned int *)&v1[1];
              *(long long *)((long long)a0 + (int)v10 * 0x28LL + 0x18) = v3;
              *(unsigned long long *)((long long)a0 + (int)v10 * 0x28LL + 0x20) = v5;
              *(long long *)((long long)a0 + (int)v10 * 0x28LL + 0x28) = v4;
              *(unsigned long long *)((long long)a0 + (int)v10 * 0x28LL + 0x38) = PsGetCurrentProcessId();
              break;
            }
            v10 += 1;
            v9 = v10;
            v7 += 1;
            v6 = &v6[10];
          } while (v7 < 0x100);
          if (v10 != 0x100)
            return 0;
          v8 = "Maximum number of memory mappings reached";
        }
        else {
          v8 = "Call to IoAllocateMdl failed.";
        }
      }
      else {
        v8 = "Call to MmMapIoSpace failed.";
      }
      sub_140001590(1,v8);
      return 0xc0000001;
    }
    ((unsigned long long *)a2)[7] = 0xc;
    v11 = 0x99;
  }
  sub_140001590(1,"%s %d: Invalid buffer size","ioctl.c",v11);
  return 0xc0000206;
}

// Function: sub_140001ef0 @ 0x140001ef0
int sub_140001ef0(void *a0,void *a1)
{
  char v1; // al | r8b
  long long v2; // rbp
  unsigned short *v3; // rcx
  char v4; // al | cl
  unsigned short v5; // ax | cx | dx
  unsigned int v6; // eax | ecx
  unsigned int v7; // eax | ecx | r15d
  unsigned long long v8; // r14 | r15 | rax | rcx | rdi
  unsigned long long *v9; // r15 | r8 | rax
  unsigned long long *v10; // rax | rcx
  int v11; // eax | ecx | edi | r14d | r15d
  unsigned char v12; // bl | dl | r12b | r15b | stack - 0x40
  unsigned long long *v13; // rbx
  long long v14; // r13 | rbx
  unsigned int v15 [2]; // eax | stack - 0x30
  int v16; // eax | ecx | edi | r14d | r15d
  long long v17; // r14 | r15 | rax | rcx | rdi
  unsigned long long v18; // r9
  unsigned long long v19; // r10 | r12 | r8 | rax | rcx | stack - 0x38 | xmm0_qa
  int v20; // eax | ecx | edi | r14d | r15d
  unsigned long long v21; // r14 | r15 | rax | rcx | rdi
  
  v2 = ((long long *)a1)[0x17];
  v21 = 0;
  v14 = ((long long *)a0)[8];
  v16 = -0x3fffffff;
  v20 = 0;
  v11 = -0x3fffffff;
  switch(*(unsigned int *)(v2 + 0x18)) {
    case 0x80006430:
      if (*(int *)(v2 + 0x10) != 2) {
        ((unsigned long long *)a1)[7] = 2;
        v18 = 10;
        goto label_1400024a4;
      }
      v5 = *((unsigned short **)a1)[3];
      v1 = *(char *)(v2 + 8);
      if (v1 != '\x01') { // branch-flip
        if (v1 != '\x02') { // branch-flip
          if (v1 != '\x04') {
            v18 = 0x13;
            goto label_1400024a4;
          }
          v6 = in(v5);
          *((unsigned int **)a1)[3] = v6;
          v11 = 0;
        }
        else {
          v5 = in(v5);
          *((unsigned short **)a1)[3] = v5;
          v11 = 0;
        }
      }
      else {
        v4 = in(v5);
        *((char **)a1)[3] = v4;
        v11 = 0;
      }
      break;
    case 0x80006431:
    case 0x80006432:
    case 0x80006433:
    case 0x80006435:
    case 0x80006436:
    case 0x80006437:
    case 0x80006438:
    case 0x80006439:
    case 0x8000643a:
    case 0x8000643b:
    case 0x8000643c:
    case 0x8000643d:
    case 0x8000643e:
    case 0x8000643f:
    case 0x80006440:
    case 0x80006441:
    case 0x80006442:
    case 0x80006443:
    case 0x80006444:
    case 0x80006445:
    case 0x80006446:
    case 0x80006447:
    case 0x80006449:
    case 0x8000644a:
    case 0x8000644b:
    case 0x8000644d:
    case 0x8000644e:
    case 0x8000644f:
    case 0x80006450:
    case 0x80006451:
    case 0x80006452:
    case 0x80006453:
    case 0x80006454:
    case 0x80006455:
    case 0x80006456:
    case 0x80006457:
    case 0x80006458:
    case 0x80006459:
    case 0x8000645a:
    case 0x8000645b:
    case 0x8000645d:
    case 0x8000645e:
    case 0x8000645f:
    case 0x80006461:
    case 0x80006462:
    case 0x80006463:
    case 0x80006464:
    case 0x80006465:
    case 0x80006466:
    case 0x80006467:
    case 0x80006468:
    case 0x80006469:
    case 0x8000646a:
    case 0x8000646b:
    case 0x8000646c:
    case 0x8000646d:
    case 0x8000646e:
    case 0x8000646f:
    case 0x80006470:
    case 0x80006471:
    case 0x80006472:
    case 0x80006473:
    case 0x80006474:
    case 0x80006475:
    case 0x80006476:
    case 0x80006477:
    case 0x80006478:
    case 0x80006479:
    case 0x8000647a:
    case 0x8000647b:
    case 0x8000647c:
    case 0x8000647d:
    case 0x8000647e:
    case 0x8000647f:
    case 0x80006480:
    case 0x80006481:
    case 0x80006482:
    case 0x80006483:
    case 0x80006484:
    case 0x80006485:
    case 0x80006486:
    case 0x80006487:
    case 0x80006488:
    case 0x80006489:
    case 0x8000648a:
    case 0x8000648b:
    case 0x8000648c:
    case 0x8000648d:
    case 0x8000648e:
    case 0x8000648f:
    case 0x80006490:
    case 0x80006491:
    case 0x80006492:
    case 0x80006493:
    case 0x80006495:
    case 0x80006496:
    case 0x80006497:
    case 0x80006499:
    case 0x8000649a:
    case 0x8000649b:
    case 0x8000649d:
    case 0x8000649e:
    case 0x8000649f:
    case 0x800064a1:
    case 0x800064a2:
    case 0x800064a3:
      break;
    case 0x80006434:
      if (*(int *)(v2 + 8)) { // branch-flip
        ((unsigned long long *)a1)[7] = 0;
        v18 = 0x28;
      }
      else {
        v1 = *(char *)(v2 + 0x10);
        if ((!(v1 - 5U & 0xfcU)) && (v1 != '\a')) {
          v3 = ((unsigned short **)a1)[3];
          if (v1 != '\x05') { // branch-flip
            if (v1 == '\x06')
              out(*v3,v3[2]);
          }
          else {
            out(*v3,*(char *)&v3[2]);
          }
          if (v1 == '\b')
            out(*v3,*(unsigned int *)&v3[2]);
          v11 = 0;
          break;
        }
        v18 = 0x2f;
      }
      goto label_1400024a4;
    case 0x80006448:
      v11 = sub_140001cb0(v2,a1);
      break;
    case 0x8000644c:
      v11 = sub_140001c10(v2,a1);
      break;
    case 0x8000645c:
      v11 = sub_140001d30(v14,v2,a1);
      break;
    case 0x80006460:
      if (*(int *)(v2 + 8)) {
        v18 = 0xee;
        goto label_1400024a4;
      }
      if (*(int *)(v2 + 0x10) != 4) { // branch-flip
        if (*(int *)(v2 + 0x10) != 8) {
          v18 = 0xf4;
          goto label_1400024a4;
        }
        v19 = *((unsigned long long **)a1)[3];
      }
      else {
        v19 = *((unsigned int **)a1)[3];
      }
      v13 = (unsigned long long *)(v14 + 0x20);
      v17 = v21;
      v8 = v21;
      do {
        v7 = v8;
        if (((*(int *)&v13[2]) && (*v13 == v19)) && (v8 = PsGetCurrentProcessId(), v13[3] == v8)) break;
        v7 += 1;
        v8 = v7;
        v17 += 1;
        v13 = &v13[5];
      } while (v17 < 0x100);
      if (v7 != 0x100) { // branch-flip
        v14 = (int)v7 * 0x28LL + v14;
        MmUnmapLockedPages(*(unsigned long long *)(v14 + 0x20),*(unsigned long long *)(v14 + 0x28));
        MmUnmapIoSpace(*(unsigned long long *)(v14 + 0x18),*(unsigned int *)(v14 + 0x30));
        IoFreeMdl(*(unsigned long long *)(v14 + 0x28));
        *(unsigned int *)(v14 + 0x30) = 0;
        v11 = 0;
      }
      else {
        v11 = -0x3ffffff3;
      }
      break;
    case 0x80006494:
      if (*(int *)(v2 + 0x10)) {
        ((unsigned long long *)a1)[7] = 0;
        v18 = 0x120;
        goto label_1400024a4;
      }
      if (*(int *)(v2 + 8) != 4) { // branch-flip
        ((unsigned long long *)a1)[7] = 4;
        sub_140001590(1,"%s %d: Invalid buffer size","ioctl.c",0x127);
        v11 = -0x3ffffff3;
      }
      else {
        *((unsigned int **)a1)[3] = *(unsigned int *)(v14 + 8);
        v11 = 0;
      }
      break;
    case 0x80006498:
      if (*(int *)(v2 + 0x10) != 8) { // branch-flip
        ((unsigned long long *)a1)[7] = 8;
        v18 = 0x135;
      }
      else {
        v12 = *(unsigned char *)(v2 + 8);
        if ((v12 <= 8) && (0x116U >> (v12 & 0x1f) & 1)) {
          v9 = (unsigned long long *)MmMapIoSpace(*((unsigned long long **)a1)[3],v12,0);
          if (v9) { // branch-flip
            if (v12 != 1) { // branch-flip
              if (v12 != 2) { // branch-flip
                if (v12 != 4) { // branch-flip
                  if (v12 == 8)
                    *((unsigned long long **)a1)[3] = *v9;
                  MmUnmapIoSpace(v9,v12);
                  v11 = 0;
                }
                else {
                  *((unsigned int **)a1)[3] = *(unsigned int *)v9;
                  MmUnmapIoSpace(v9,4);
                  v11 = 0;
                }
              }
              else {
                *((unsigned short **)a1)[3] = *(unsigned short *)v9;
                MmUnmapIoSpace(v9,2);
                v11 = 0;
              }
            }
            else {
              *((char **)a1)[3] = *(char *)v9;
              MmUnmapIoSpace(v9,1);
              v11 = 0;
            }
          }
          else {
            v18 = 0x145;
label_1400022ce:
            sub_140001590(1,"%s %d: MmMapIoSpace failed","ioctl.c",v18);
          }
          break;
        }
        v18 = 0x13e;
      }
      goto label_1400024a4;
    case 0x8000649c:
      if (*(int *)(v2 + 8)) { // branch-flip
        ((unsigned long long *)a1)[7] = 0;
        v18 = 0x15f;
      }
      else {
        v12 = *(char *)(v2 + 0x10) - 8;
        if ((v12 <= 8) && (0x116U >> (v12 & 0x1f) & 1)) {
          v9 = ((unsigned long long **)a1)[3];
          v10 = (unsigned long long *)MmMapIoSpace(*v9,v12,0);
          if (!v10) {
            v18 = 0x172;
            goto label_1400022ce;
          }
          if (v12 != 1) { // branch-flip
            if (v12 != 2) { // branch-flip
              if (v12 != 4) { // branch-flip
                if (v12 == 8)
                  *v10 = v9[1];
                MmUnmapIoSpace(v10,v12);
                v11 = 0;
              }
              else {
                *(unsigned int *)v10 = *(unsigned int *)&v9[1];
                MmUnmapIoSpace(v10,4);
                v11 = 0;
              }
            }
            else {
              *(unsigned short *)v10 = *(unsigned short *)&v9[1];
              MmUnmapIoSpace(v10,2);
              v11 = 0;
            }
          }
          else {
            *(char *)v10 = *(char *)&v9[1];
            MmUnmapIoSpace(v10,1);
            v11 = 0;
          }
          break;
        }
        v18 = 0x166;
      }
      goto label_1400024a4;
    case 0x800064a0:
      if (*(int *)(v2 + 0x10) != 8) { // branch-flip
        ((unsigned long long *)a1)[7] = 8;
        v18 = 0x18c;
      }
      else {
        v12 = *(unsigned char *)(v2 + 8);
        if (v12) {
          v19 = *((unsigned long long **)a1)[3];
          v7 = HalGetBusDataByOffset(4,v19 & 0xff,((unsigned int)(v19 >> 0x10) & 7) << 5 | (unsigned int)(v19 >> 8) & 0x1f,((unsigned long long **)a1)[3],(int)(v19 >> 0x20),v12);
          if (v7) { // branch-flip
            if ((v12 != 2) && (v7 == 2))
              v11 = -0x3fffff40;
            else {
              if (v12 != v7)
                v20 = -0x3fffffff;
              v11 = v20;
            }
          }
          else {
            v11 = -0x3ffffddb;
          }
          break;
        }
        v18 = 0x193;
      }
      goto label_1400024a4;
    case 0x800064a4:
      if (*(int *)(v2 + 8)) { // branch-flip
        ((unsigned long long *)a1)[7] = 0;
        v18 = 0x1b2;
      }
      else {
        v12 = *(char *)(v2 + 0x10) - 8;
        if ((!(*(char *)(v2 + 0x10) - 9U & 0xfcU)) && (v12 != 3)) {
          v19 = *((unsigned long long **)a1)[3];
          v15[0] = *(unsigned int *)&((unsigned long long **)a1)[3][1];
          v11 = 0;
          if (HalSetBusDataByOffset(4,v19 & 0xff,((unsigned int)(v19 >> 0x10) & 7) << 5 | (unsigned int)(v19 >> 8) & 0x1f,v15,(int)(v19 >> 0x20),v12) != (unsigned int)v12)
            v11 = -0x3fffffff;
          break;
        }
        v18 = 0x1b9;
      }
label_1400024a4:
      sub_140001590(1,"%s %d: Invalid buffer size","ioctl.c",v18);
      v11 = -0x3ffffdfa;
      break;
    default:
      goto label_1400024d0;
    
  }
  v16 = v11;
label_1400024d0:
  ((int *)a1)[0xc] = v16;
  if (!v16)
    v21 = *(unsigned int *)(v2 + 8);
  ((unsigned long long *)a1)[7] = v21;
  IofCompleteRequest(a1,0);
  return v16;
}

// Function: __C_specific_handler @ 0x1400025a5
void __C_specific_handler(void)
{
  __C_specific_handler();
}

// Function: _snwprintf @ 0x1400025ab
void _snwprintf(void)
{
  _snwprintf();
}

// Function: wcschr @ 0x1400025b1
void wcschr(void)
{
  wcschr();
}

// Function: _wcsnicmp @ 0x1400025b7
void _wcsnicmp(void)
{
  _wcsnicmp();
}

// Function: sub_140008000 @ 0x140008000
void sub_140008000(void)
{
  char v1 [24]; // stack - 0x18
  
  RtlInitUnicodeString(v1,L"IoCreateDeviceSecure");
  dat_1400041e8 = (void *)MmGetSystemRoutineAddress(v1);
  if (!dat_1400041e8)
    dat_1400041e8 = sub_14000819c;
  RtlInitUnicodeString(v1,L"IoValidateDeviceIoControlAccess");
  dat_1400041f0 = MmGetSystemRoutineAddress(v1);
  dat_1400041e0 = 1;
}

// Function: sub_140008068 @ 0x140008068
void sub_140008068(unsigned long long a0,unsigned int a1,unsigned long long a2,unsigned int a3,unsigned int a4,char a5,unsigned long long a6,unsigned long long a7,unsigned long long a8)
{
  if (!dat_1400041e0)
    sub_140008000();
  (*dat_1400041e8)(a0,a1,a2,a3,a4,a5,a6,a7,a8);
}

// Function: sub_1400080f8 @ 0x1400080f8
unsigned long long sub_1400080f8(unsigned long long a0,struct_2 *a1) // early-return
{
  unsigned int v1; // eax | ebx
  unsigned long long v2; // rax
  unsigned int v3 [2]; // stack + 0x18
  char v4 [8]; // stack + 0x10
  unsigned int v5 [2]; // stack + 0x20
  unsigned long long v6 [2]; // rcx | stack - 0x18
  
  if (!(a1->field_0x0 & 2))
    return 0;
  v2 = sub_1400092a4(a1->field_0x8,v4,v3);
  if (0 <= (int)v2) {
    sub_14000927c(v3[0],v5);
    v2 = ObOpenObjectByPointer(a0,0x200,0,v5[0],*dat_140003100,0,v6);
    if (0 <= (int)v2) {
      v1 = ZwSetSecurityObject(v6[0],v3[0],a1->field_0x8);
      ZwClose(v6[0]);
      return v1;
    }
    return v2;
  }
  return v2;
}

// Function: sub_14000819c @ 0x14000819c
unsigned long long sub_14000819c(unsigned long long a0,unsigned int a1,long long a2,unsigned int a3,unsigned int a4,char a5,unsigned long long a6,long long a7,unsigned long long *a8) // early-return
{
  unsigned int v1; // ebp | stack + 0x28 | stack - 0x48 | stack - 0x78
  unsigned long long *v2; // rsi | stack + 0x48
  unsigned int v3; // eax | ebx
  unsigned long long v4; // rax | rbx
  char v5; // al | cl | stack + 0x30 | stack - 0x44 | stack - 0x70
  unsigned int v6; // eax | stack - 0x58
  unsigned long long v7 [2]; // rcx | stack + 0x18
  char v8 [24]; // stack - 0x40
  unsigned int v9; // r14d | stack - 0x54
  unsigned int v10; // ebp | stack - 0x48
  char v11; // al | cl | stack - 0x44
  
  v2 = a8;
  v1 = a4;
  a8 = NULL;
  *v2 = 0;
  if ((!a2) && ('\0' <= (char)a4))
    return 0xc000000d;
  if (a7) { // branch-flip
    v4 = sub_1400086e4(a7,a0,&v6);
    if ((int)v4 <= -1)
      return v4;
  }
  else {
    sub_14000850c(&v6);
  }
  if (!(v6 & 2)) {
    v3 = sub_1400091b8(a6,1,v7);
    v4 = v3;
    if ((int)v3 <= -1) {
      sub_140008358(&v6); // return-dupe
      return v4;
    }
    sub_14000834c(v7[0],&v6);
    if (a7) {
      sub_14000850c(v8);
      sub_14000834c(v7[0],v8);
      v3 = sub_14000880c(a7,v8);
      v4 = v3;
      if ((int)v3 < 0) {
        sub_140008358(&v6);
        return v4;
      }
    }
  }
  if (v6 & 1)
    a3 = v9;
  if (v6 & 4)
    v1 = v10;
  v5 = a5;
  if (v6 & 8)
    v5 = v11;
  v3 = IoCreateDevice(a0,a1,a2,a3,v1,v5,&a8);
  v4 = v3;
  if (0 <= (int)v3) {
    v3 = sub_1400080f8(a8,&v6);
    v4 = v3;
    if (0 <= (int)v3) // branch-flip
      *v2 = (unsigned long long)a8;
    else {
      IoDeleteDevice(a8);
    }
  }
  sub_140008358(&v6);
  return v4;
}

// Function: sub_14000834c @ 0x14000834c
void sub_14000834c(unsigned long long a0,struct_3 *a1)
{
  a1->field_0x0 = 2;
  a1->field_0x8 = a0;
}

// Function: sub_140008358 @ 0x140008358
void sub_140008358(struct_2 *a0)
{
  if (a0->field_0x0 & 2)
    ExFreePoolWithTag(a0->field_0x8,0);
}

// Function: sub_140008374 @ 0x140008374
void sub_140008374(struct_4 *a0,unsigned int a1,int a2,unsigned int *a3,unsigned long long *a4)
{
  unsigned long long *v1; // r12 | stack + 0x28
  int v2; // eax | ebx
  char v3 [32]; // stack - 0x128
  unsigned long long v4; // rcx | stack - 0xb0
  char v5 [76]; // stack - 0x98
  unsigned long long v6 [2]; // rax | stack - 0xa8
  unsigned long long v7; // stack - 0x108
  unsigned int v8; // stack - 0x104
  unsigned long long v9; // stack - 0x100
  unsigned int v10; // stack - 0xfc
  unsigned long long v11; // stack - 0xf8
  unsigned int v12; // stack - 0xf4
  unsigned int v13; // eax | stack - 0xb8
  unsigned short v14; // stack - 0x4c
  unsigned long long v15; // rax | rcx | stack - 0x48
  
  v1 = a4;
  v8 = (unsigned int)((unsigned long long)v7 >> 0x20);
  v10 = (unsigned int)((unsigned long long)v9 >> 0x20);
  v12 = (unsigned int)((unsigned long long)v11 >> 0x20);
  v15 = dat_1400041d0 ^ (unsigned long long)v3;
  *a4 = 0;
  if (a3)
    *a3 = 0;
  if (0 <= (int)sub_1400097b4(0,L"\\Registry\\Machine\\System\\CurrentControlSet\\Control\\Class",0x20019,&v4)) {
    _snwprintf(v5,0x27,L"{%08X-%04X-%04X-%02X%02X-%02X%02X%02X%02X%02X%02X}",a0->field_0x0,CONCAT44(v8,(unsigned int)a0->field_0x4),CONCAT44(v10,(unsigned int)a0->field_0x6),CONCAT44(v12,(unsigned int)a0->field_0x8),(unsigned char)a0->field_0x9,(unsigned char)a0->field_0xa,(unsigned char)a0->field_0xb,(unsigned char)a0->field_0xc,(unsigned char)a0->field_0xd,(unsigned char)a0->field_0xe,(unsigned char)a0->field_0xf);
    v14 = 0;
    if (a2) // branch-flip
      v2 = sub_140009744();
    else {
      v2 = sub_1400097b4(v4,v5,a1,v6);
      v13 = 2;
    }
    ZwClose(v4);
    if ((v2 <= -1) || (*v1 = v6[0], !a3)) {
      sub_140001540(v15 ^ (unsigned long long)v3); // return-dupe
      return;
    }
    *a3 = v13;
  }
  sub_140001540(v15 ^ (unsigned long long)v3);
  return;
}

// Function: sub_14000850c @ 0x14000850c
void sub_14000850c(struct_5 *a0)
{
  a0->field_0x0 = 0;
  a0->field_0x8 = 0;
  a0->field_0x4 = 0;
  a0->field_0x10 = 0;
  a0->field_0x14 = 0;
}

// Function: sub_140008520 @ 0x140008520
int sub_140008520(unsigned long long a0,struct_6 *a1)
{
  int v1; // eax | ebx
  long long v2 [2]; // rax | rcx | stack - 0x48
  long long v3; // rax | rcx | stack + 0x20
  char v4 [8]; // stack + 0x18
  char v5 [8]; // stack + 0x10
  unsigned long long v6; // r9
  
  a1->field_0x0 = 0;
  a1->field_0x8 = 0;
  a1->field_0x4 = 0;
  a1->field_0x10 = 0;
  a1->field_0x14 = 0;
  v6 = 0;
  v2[0] = 0;
  v1 = sub_140009934(a0,L"Security",3,0,v2);
  if (0 <= v1) // branch-flip
    v1 = SeCaptureSecurityDescriptor((unsigned long long)*(unsigned int *)(v2[0] + 8) + v2[0],0,1,(unsigned long long)v6 & 0xffffffffffffff00 | (unsigned long long)1 & 0xff,&v3);
  else if (v1 == -0x3fffffcc) {
    v3 = 0;
    v1 = 0;
  }
  if (v2[0])
    ExFreePoolWithTag(v2[0],0);
  if (0 <= v1) {
    if (v3) {
      v1 = sub_1400092a4(v3,v5,v4);
      if (v1 < 0) goto label_1400086a6;
      if (v5[0]) // branch-flip
        ExFreePoolWithTag(v3,0);
      else {
        a1->field_0x0 = a1->field_0x0 | 2;
        a1->field_0x8 = v3;
      }
    }
    v1 = sub_1400096f8(a0,L"DeviceType",0,&a1->field_0x4);
    if (0 <= v1) // branch-flip
      a1->field_0x0 = a1->field_0x0 | 1;
    else if (v1 != -0x3fffffcc) goto label_1400086a6;
    v1 = sub_1400096f8(a0,L"DeviceCharacteristics",0,&a1->field_0x10);
    if (0 <= v1) // branch-flip
      a1->field_0x0 = a1->field_0x0 | 4;
    else if (v1 != -0x3fffffcc) goto label_1400086a6;
    v1 = sub_1400096f8(a0,L"Exclusive",0,&a1->field_0x14);
    if (0 <= v1) {
      a1->field_0x0 = a1->field_0x0 | 8;
      return v1;
    }
    if (v1 == -0x3fffffcc)
      return 0;
  }
label_1400086a6:
  if (a1->field_0x8)
    ExFreePoolWithTag(a1->field_0x8,0);
  a1->field_0x0 = 0;
  a1->field_0x8 = 0;
  a1->field_0x4 = 0;
  a1->field_0x10 = 0;
  a1->field_0x14 = 0;
  return v1;
}

// Function: sub_1400086e4 @ 0x1400086e4
unsigned long long sub_1400086e4(unsigned long long a0,void *a1,struct_5 *a2)
{
  unsigned int v1; // eax | ebx
  unsigned long long v2; // rax | rbx
  unsigned long long v3; // rcx | rdi | stack + 0x20 | stack - 0x18
  unsigned long long v4; // rcx | rdi | stack + 0x20
  int v5 [2]; // stack + 0x18
  unsigned long long v6 [2]; // rcx | stack - 0x18
  long long v7; // r8
  
  a2->field_0x0 = 0;
  a2->field_0x8 = 0;
  a2->field_0x4 = 0;
  a2->field_0x10 = 0;
  a2->field_0x14 = 0;
  v4 = 0;
  v6[0] = 0;
  v2 = sub_140008374(a0,0xf003f,1,v5,&v4);
  if ((int)v2 < 0)
    return v2;
  v3 = v4;
  if (v5[0] != 2) { // branch-flip
    v7 = ((long long *)a1)[6] + 0x18;
    if (v7) { // branch-flip
      v1 = sub_140009664(v4,L"Class",v7);
      v2 = v1;
      if (0 <= (int)v1) {
        v5[0] = 0x31;
        v1 = sub_140009614(v3,L"NoDisplayClass",v5);
        v2 = v1;
        if (0 <= (int)v1)
          v2 = (unsigned int)sub_140009614(v3,L"NoUseClass",v5);
      }
    }
    else {
      v2 = 0xc000009a;
    }
  }
  else {
    v1 = sub_1400097b4(v4,L"Properties",0x20019,v6);
    ZwClose(v4);
    if ((int)v1 <= -1) {
      if (v1 == 0xc0000034)
        return 0;
      return v1;
    }
    v1 = sub_140008520(v6[0],a2);
    v2 = v1;
    v3 = v6[0];
  }
  ZwClose(v3);
  return v2;
}

// Function: sub_14000880c @ 0x14000880c
unsigned long long sub_14000880c(unsigned long long a0,void *a1)
{
  unsigned int v1; // eax | ebx | ram 0x1400041f8 | stack - 0x38
  unsigned long long v2; // rax | rbx
  unsigned long long v3; // rcx | stack + 0x20
  unsigned long long v4; // rbp | rbx | rcx | stack + 0x18 | stack - 0x38
  unsigned long long v5 [2]; // rcx | stack - 0x18
  unsigned long long v6; // r9 | rbp | rbx | stack + 0x18 | stack - 0x38
  unsigned int v7; // stack - 0x34
  
  v6 = 0;
  v2 = sub_140008374(a0,0xf003f,0,0,&v3);
  if (0 <= (int)v1) {
    v1 = dat_1400041f8;
    if (!dat_1400041f8) {
      v1 = SeCaptureSecurityDescriptor(0x140004000,0,1,(unsigned long long)v6 & 0xffffffffffffff00 | (unsigned long long)1 & 0xff,&v4);
      if (0 <= (int)v1) { // branch-flip
        dat_1400041f8 = 1;
        ExFreePoolWithTag(v4,0);
        v1 = dat_1400041f8;
      }
      else {
        v1 = 2;
        dat_1400041f8 = 2;
      }
    }
    v4 = 0x140004000;
    if (v1 != 1)
      v4 = 0;
    v6 = v4;
    v1 = sub_140009744(v3,L"Properties",0xf003f,0,v4,0,v5);
    v7 = (unsigned int)((unsigned long long)v6 >> 0x20);
    ZwClose(v3);
    if (0 <= (int)v1) {
      v1 = RtlLengthSecurityDescriptor(((unsigned long long *)a1)[1]);
      v1 = sub_1400096a0(v5[0],L"Security",3,((unsigned long long *)a1)[1],CONCAT44(v7,v1));
      ZwClose(v5[0]);
    }
    v2 = v1;
  }
  return v2;
}

// Function: sub_140008930 @ 0x140008930
unsigned long long sub_140008930(unsigned short *a0,unsigned long long *a1,unsigned int *a2) // return-dupe
{
  unsigned short v1; // ax | cx
  unsigned int v2; // eax | r8d
  int v3; // ecx
  int v4; // edx
  unsigned int v5; // eax | r8d
  unsigned short *v6; // r10 | r9 | rcx
  
  *a2 = 0;
  *a1 = (unsigned long long)a0;
  v1 = *a0;
  if (v1 != 0x30) { // branch-flip
label_140008975:
    v6 = a0;
    if ((0x30 <= v1) && (v4 = 10, *a0 <= 0x39)) goto label_140008987;
  }
  else {
    if ((a0[1] != 0x78) && (a0[1] != 0x58)) {
      v1 = *a0;
      goto label_140008975;
    }
    a0 = &a0[2];
    v6 = a0;
  }
  v4 = 0x10;
label_140008987:
  v5 = 0;
  while (v1 = *a0, v1) {
    if ((0x30 <= v1) && (v1 <= 0x39))
      v3 = (unsigned int)v1 - 0x30;
    else {
      if (v4 != 0x10) break;
      if ((0x41 <= v1) && (v1 <= 0x46))
        v3 = (unsigned int)v1 - 0x37;
      else {
        if ((v1 < 0x61) || (0x67 <= v1)) break;
        v3 = (unsigned int)v1 - 0x57;
      }
    }
    v2 = v5 * v4 + v3;
    if (v2 < v5)
      return 0;
    a0 = &a0[1];
    v5 = v2;
  }
  if (a0 == v6)
    return 0;
  *a1 = (unsigned long long)a0;
  *a2 = v5;
  return 1;
}

// Function: sub_140008a0c @ 0x140008a0c
unsigned long long sub_140008a0c(long long *a0,unsigned int *a1,unsigned long long a2,unsigned long long a3,unsigned int a4,int a5,unsigned long long a6)
{
  unsigned int v1; // r12d
  long long v2; // rdi
  int v3; // eax | ebx | r15d
  long long v4; // r13 | rax | rdi
  unsigned int v5; // ebp
  
  v2 = *a0;
  v1 = *a1;
  v3 = RtlLengthSid(a6);
  v5 = v3 + 8 + v1;
  v4 = v2;
  if (*(unsigned short *)(v2 + 2) < v5) {
    v3 = (v3 + 8) * a5 + v1;
    v4 = ExAllocatePoolWithTag(1,v3,0x6c416553);
    if (!v4)
      return 0xc000009a;
    sub_1400010f0(v4,0,v3);
    sub_1400011f0(v4,*a0,v1);
    *(short *)(v4 + 2) = v3;
    ExFreePoolWithTag(v2,0);
    *a0 = v4;
  }
  *a1 = v5;
  return RtlAddAccessAllowedAce(v4,2,a4,a6);
}

// Function: sub_140008aec @ 0x140008aec
unsigned long long sub_140008aec(long long a0,unsigned int *a1,long long *a2)
{
  unsigned int v1; // r8d
  unsigned long long v2; // rdx
  unsigned int v3; // ebx | edx
  unsigned long long *v4; // rdi
  
  v3 = 0;
  v4 = &dat_140004150;
  do {
    v1 = *(unsigned int *)&v4[1];
    v2 = *v4;
    if (!_wcsnicmp(a0,v2,v1)) {
      *a1 = *(unsigned int *)(v3 * 0x10ULL + 0x14000415c);
      *a2 = a0 + *(unsigned int *)(v3 * 0x10ULL + 0x140004158) * 2ULL;
      return 1;
    }
    v3 += 1;
    v4 = &v4[2];
  } while (v3 < 8);
  *a1 = 0;
  *a2 = a0;
  return 0;
}

// Function: sub_140008b80 @ 0x140008b80
unsigned long long sub_140008b80(long long a0,unsigned long long *a1,long long *a2) // return-dupe
{
  unsigned int v1; // r8d
  unsigned long long v2; // rbp | rcx
  unsigned int *v3; // rsi
  unsigned int v4; // edi
  
  v4 = 0;
  v3 = &dat_140004044;
  while (v1 = *v3, v2 = a0, _wcsnicmp(a0,v4 * 0x18ULL + 0x14000403c,v1)) {
    v4 += 1;
    v3 = &v3[6];
    if (0xc <= v4) {
      *a1 = 0;
      return 0xc0000073;
    }
  }
  a0 += *(unsigned int *)(v4 * 0x18ULL + 0x140004044) * 2ULL;
  *a2 = a0;
  if ((*(int *)(v4 * 0x18ULL + 0x140004038) == 1) && (!IoIsWdmVersionAvailable((unsigned long long)v2 & 0xffffffffffffff00 | (unsigned long long)1 & 0xff,(unsigned long long)a0 & 0xffffffffffffff00 | (unsigned long long)0x20 & 0xff))) {
    *a1 = 0;
    return 0;
  }
  *a1 = *(unsigned long long *)(*(long long *)(v4 * 0x18ULL + 0x140004030) + *dat_140003140);
  return 0;
}

// Function: sub_140008c40 @ 0x140008c40
unsigned long long sub_140008c40(short *a0,long long *a1,long long *a2) // early-return, return-dupe
{
  short *v1; // rdi
  short v2; // tmp
  unsigned int v3; // eax | esi
  short *v4; // rax | rbx | rcx | rdi | stack - 0x58
  unsigned long long *v5; // rax
  long long v6; // rax
  unsigned long long v7; // r12 | r15 | rbp | rcx | rdi | rsi
  short *v8; // rax | rbx | stack + 0x20
  unsigned int v9 [2]; // stack + 0x18
  unsigned int v10 [2]; // ebp | stack + 0x8
  short *v11; // rbx | stack - 0x58
  long long v12 [2]; // rcx | stack - 0x50 | stack - 0x68
  unsigned int v13 [2]; // edi | stack + 0x10
  unsigned int v14; // eax | ebp | esi | r12d | r15d | stack + 0x8 | stack - 0x78
  unsigned long long v15; // r12 | r15 | rbp | rdi | rsi
  unsigned int v16; // edi | stack + 0x10
  unsigned long long v17; // r12 | r15 | rbp | rdi | rsi
  unsigned int v18; // eax | r14d
  int v19; // ebp | edi | esi | r12d | r15d
  unsigned long long v20; // r12 | r15 | rbp | rdi | rsi
  
  v20 = 0;
  *a1 = 0;
  v19 = 0;
  v12[0] = 0;
  v4 = (short *)wcschr(a0,0x3a);
  *a2 = (long long)v4;
  if (v4 == a0)
    return 0xc000000d;
  if (v4) // branch-flip
    v4 = &v4[-1];
  else {
    v7 = 0xffffffffffffffff;
    v4 = a0;
    do {
      if (!v7) break;
      v7 -= 1;
      v1 = &v4[1];
      v2 = *v4;
      v4 = v1;
    } while (v2);
    v4 = &a0[~v7 - 1];
  }
  *a2 = (long long)v4;
  v7 = v20;
  if (a0 < (short *)*a2) {
    v4 = a0;
    v17 = v20;
    do {
      if (*v4 != 0x3b) { // branch-flip
        if (*v4 != 0x20)
          v17 = 1;
      }
      else {
        v7 = (int)v7 + 1U;
      }
      v19 = v17;
      v4 = &v4[1];
    } while (v4 < (short *)*a2);
  }
  v18 = v7 / 5;
  if (((int)v7 != v18 * 5) || ((!(int)v7 && (v19))))
    return 0xc000000d;
  if (v18) { // branch-flip
    v14 = v18 * 0x30 + 8;
    if (0x10000 <= v14)
      v14 = 0xffff;
    v6 = ExAllocatePoolWithTag(1,v14,0x6c416553);
    *a1 = v6;
    if (v6) {
      v13[0] = 8;
      sub_1400010f0(v6,0,v14);
      *(char *)*a1 = 2;
      *(char *)(*a1 + 1) = 0;
      *(short *)(*a1 + 2) = v14;
      *(unsigned short *)(*a1 + 4) = 0;
      *(unsigned short *)(*a1 + 6) = 0;
      v7 = v20;
      v17 = v20;
      v16 = 8;
      if (v18) {
        do {
          v10[0] = 0;
          for (; *a0 == 0x20; a0 = &a0[1]) {
          }
          if (*a0 != 0x28) goto label_140008e00;
          do {
            a0 = &a0[1];
label_140008e00:
            ;
          } while (*a0 == 0x20);
          if (_wcsnicmp(a0,"A",1)) {
            v7 = 0xc000000d;
            break;
          }
          for (a0 = &a0[2]; *a0 == 0x20; a0 = &a0[1]) {
          }
          if (*a0 != 0x3b) {
            v7 = 0xc000000d;
            goto label_140008fbe;
          }
          do {
            a0 = &a0[1];
          } while (*a0 == 0x20);
          v2 = *a0;
          v15 = v20;
          v14 = 0;
          while (v2 != 0x3b) {
            for (; *a0 == 0x20; a0 = &a0[1]) {
            }
            if (sub_140008aec(a0,v9,&v8)) { // branch-flip
              v10[0] = (unsigned int)v15 | v9[0];
              v14 = v10[0];
            }
            else {
              sub_140008930(a0,&v8,v10);
              v14 = v10[0];
              if (v8 == a0) {
                v7 = 0xc000000d;
                goto label_140008e52;
              }
            }
            v15 = v14;
            v2 = *v8;
            a0 = v8;
          }
          a0 = &a0[1];
label_140008e52:
          if ((int)v7) goto label_140008fbe;
          v6 = 2;
          do {
            for (; *a0 == 0x20; a0 = &a0[1]) {
            }
            if (*a0 != 0x3b)
              v7 = 0xc000000d;
            a0 = &a0[1];
            v6 -= 1;
          } while (v6);
          if ((int)v7) goto label_140008fbe;
          for (; *a0 == 0x20; a0 = &a0[1]) {
          }
          v3 = sub_140008b80(a0,v12,&v11);
          v7 = v3;
          if (v3) goto label_140008fbe;
          if (!v11) {
label_140008fac:
            v7 = 0xc0000077;
            goto label_140008fbe;
          }
          v4 = v11;
          if (*v11 == 0x20) {
            do {
              v11 = &v11[1];
            } while (*v11 == 0x20);
            v4 = v11;
          }
          if (*v4 != 0x29) goto label_140008fac;
          a0 = &v4[1];
          if (v12[0]) {
            v14 = sub_140008a0c(a1,v13,0,0,v14,v18 - (int)v17,v12[0]);
            v7 = v14;
            if (v14) goto label_140008fbe;
          }
          if (*a0 == 0x28)
            a0 = &v4[2];
          v14 = (int)v17 + 1;
          v17 = v14;
        } while (v14 < v18);
        if ((int)v7) {
label_140008fbe:
          ExFreePoolWithTag(*a1,0);
          *a1 = 0;
          return v7;
        }
        v16 = v13[0];
      }
      *(short *)(*a1 + 2) = v16;
      return v7;
    }
  }
  else {
    v5 = (unsigned long long *)ExAllocatePoolWithTag(1,8,0x6c416553);
    *a1 = (long long)v5;
    if (v5) {
      *v5 = 0;
      *(char *)*a1 = 2;
      *(char *)(*a1 + 1) = 0;
      *(unsigned short *)(*a1 + 2) = 8;
      *(unsigned short *)(*a1 + 4) = 0;
      *(unsigned short *)(*a1 + 6) = 0;
      return 0;
    }
  }
  return 0xc000009a;
}

// Function: sub_140008ffc @ 0x140008ffc
int sub_140008ffc(short *a0,int a1,unsigned int *a2,long long *a3) // early-return
{
  short *v1; // rcx
  int v2; // eax | ebx
  short *v3; // rax | stack + 0x18
  long long v4; // rax | rcx | stack + 0x8
  unsigned int v5; // edi
  
  *a3 = 0;
  *a2 = 0;
  for (; *a0 == 0x20; a0 = &a0[1]) {
  }
  if ((*a0 != 0x44) || (a0[1] != 0x3a))
    return -0x3ffffff3;
  v1 = &a0[2];
  v5 = -(unsigned int)(a1 != 0) & 8;
  if (*v1 == 0x50) {
    v1 = &a0[3];
    v5 |= 0x1000;
  }
  v2 = sub_140008c40(v1,&v4,&v3);
  if (!v2) {
    for (; *v3 == 0x20; v3 = &v3[1]) {
    }
    if (!*v3) {
      *a3 = v4;
      *a2 = v5;
      return 0;
    }
    v2 = -0x3ffffff3;
  }
  if (v4)
    ExFreePoolWithTag(v4,0);
  return v2;
}

// Function: sub_1400090bc @ 0x1400090bc
int sub_1400090bc(unsigned long long a0,unsigned long long a1,long long *a2)
{
  int v1; // eax | ebx
  long long v2; // rax | rdi
  unsigned long long v3; // rdx
  unsigned short v4 [4]; // r11w | stack + 0x20
  long long v5; // r8 | rcx | stack - 0x38
  char v6 [2]; // stack - 0x30
  unsigned int v7 [2]; // stack + 0x18
  unsigned short v8; // stack - 0x2e
  
  v5 = 0;
  v2 = 0;
  *a2 = 0;
  v1 = sub_140008ffc(a0,a1,v4,&v5);
  if (0 <= v1) {
    v3 = 0;
    RtlCreateSecurityDescriptor(v6,1);
    RtlSetDaclSecurityDescriptor(v6,(unsigned long long)v3 & 0xffffffffffffff00 | (unsigned long long)1 & 0xff,v5,0);
    v7[0] = 0;
    v8 |= v4[0];
    RtlAbsoluteToSelfRelativeSD(v6,0,v7);
    v2 = ExAllocatePoolWithTag(1,v7[0],0x64536553);
    if (v2) { // branch-flip
      v1 = RtlAbsoluteToSelfRelativeSD(v6,v2,v7);
      if (0 <= v1) {
        ExFreePoolWithTag(v5,0);
        *a2 = v2;
        return v1;
      }
    }
    else {
      v1 = -0x3fffff66;
    }
  }
  if (v5)
    ExFreePoolWithTag(v5,0);
  if (v2)
    ExFreePoolWithTag(v2,0);
  return v1;
}

// Function: sub_1400091b8 @ 0x1400091b8
unsigned long long sub_1400091b8(struct_7 *a0,unsigned int a1,unsigned long long *a2) // early-return
{
  unsigned long long v1; // rax | rbx | rdx
  long long v2; // rax | rsi
  
  v1 = (unsigned long long)a0->field_0x0 + 2;
  if ((a0->field_0x2 != v1) || (*(short *)(a0->field_0x8 + (unsigned long long)(a0->field_0x0 >> 1) * 2))) {
    v2 = ExAllocatePoolWithTag(1,v1,0x73546553);
    if (!v2) {
      *a2 = 0;
      return 0xc000009a;
    }
    sub_1400011f0(v2,a0->field_0x8,a0->field_0x0);
    *(unsigned short *)(v2 + (unsigned long long)(a0->field_0x0 >> 1) * 2) = 0;
    v1 = (unsigned int)sub_1400090bc(v2,a1,a2);
    ExFreePoolWithTag(v2,0);
  }
  else {
    v1 = sub_1400090bc(a0->field_0x8,a1,a2);
  }
  return v1;
}

// Function: sub_14000927c @ 0x14000927c
void sub_14000927c(unsigned char a0,unsigned int *a1)
{
  *a1 = 0;
  if ((a0 & 1) || (a0 & 2))
    *a1 = 0x80000;
  if (a0 & 4)
    *a1 = *a1 | 0x40000;
  if (a0 & 8)
    *a1 = *a1 | 0x1000000;
}

// Function: sub_1400092a4 @ 0x1400092a4
unsigned long long sub_1400092a4(unsigned long long a0,char *a1,unsigned int *a2) // early-return
{
  unsigned long long v1; // rax
  unsigned int v2; // ebx
  char v3 [16]; // al | stack + 0x10
  long long v4; // stack - 0x28
  char v5 [8]; // stack - 0x20
  char v6 [8]; // stack + 0x20
  
  *a1 = 0;
  *a2 = 0;
  v1 = RtlGetOwnerSecurityDescriptor(a0,&v4,v3);
  if (0 <= (int)v1) {
    v2 = v4 != 0;
    v1 = RtlGetGroupSecurityDescriptor(a0,&v4,v3);
    if (0 <= (int)v1) {
      if (v4)
        v2 |= 2;
      v1 = RtlGetSaclSecurityDescriptor(a0,v6,v5,v3);
      if (0 <= (int)v1) {
        if (v6[0])
          v2 |= 8;
        v1 = RtlGetDaclSecurityDescriptor(a0,v6,v5,v3);
        if (0 <= (int)v1) {
          if (v6[0])
            v2 |= 4;
          *a1 = v3[0];
          *a2 = v2;
          return 0;
        }
      }
    }
  }
  return v1;
}

// Function: sub_14000936c @ 0x14000936c
unsigned int sub_14000936c(struct_8 *a0,unsigned short a1)
{
  long long v1; // rax
  
  a0->field_0x0 = 0;
  a0->field_0x2 = a1 + 2;
  v1 = ExAllocatePoolWithTag(1,a1 + 2ULL,0x63557050);
  a0->field_0x8 = v1;
  return ~-(unsigned int)(v1 != 0) & 0xc000009a;
}

// Function: sub_1400093b4 @ 0x1400093b4
int sub_1400093b4(unsigned long long a0,unsigned long long a1,struct_7 *a2)
{
  unsigned short v1; // dx | r9w
  int v2; // eax | ebx
  unsigned short v3 [4]; // ax | r11w | r8w | stack - 0x18
  long long v4; // rax | rcx | stack - 0x10 | stack - 0x28
  
  v1 = a2->field_0x0;
  if (2 <= (unsigned int)a2->field_0x2 - (unsigned int)v1) { // branch-flip
    *(unsigned short *)(a2->field_0x8 + (unsigned long long)(v1 >> 1) * 2) = 0;
    v2 = ZwSetValueKey(a0,a1,0,1,a2->field_0x8,a2->field_0x0 + 2);
  }
  else {
    v2 = sub_14000936c(v3,v1);
    if (v2 < 0)
      return v2;
    v3[0] = a2->field_0x0;
    sub_1400011f0(v4,a2->field_0x8);
    *(unsigned short *)(v4 + (unsigned long long)(v3[0] >> 1) * 2) = 0;
    v2 = ZwSetValueKey(a0,a1,0,1,v4,v3[0] + 2);
    RtlFreeUnicodeString(v3);
  }
  return v2;
}

// Function: sub_1400094b0 @ 0x1400094b0
void sub_1400094b0(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned int *a3)
{
  char v1 [32]; // stack - 0x58
  char v2 [8]; // stack - 0x28
  char v3 [4]; // stack - 0x20
  int v4; // stack - 0x1c
  unsigned int v5; // ebx | stack - 0x14
  unsigned long long v6; // rax | rcx | stack - 0x10
  
  v6 = dat_1400041d0 ^ (unsigned long long)v1;
  if ((0 <= (int)ZwQueryValueKey(a0,a1,2,v3,0x10,v2)) && (v4 == 4))
    a2 = v5;
  *a3 = a2;
  sub_140001540(v6 ^ (unsigned long long)v1);
}

// Function: sub_140009524 @ 0x140009524
int sub_140009524(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned int a3,unsigned long long a4,unsigned int *a5,unsigned long long *a6)
{
  int v1; // eax | r11d
  unsigned int v2 [2]; // stack - 0x38
  unsigned long long v3 [4]; // rdx | stack + 0x8
  unsigned long long v4; // rcx | stack - 0x30
  unsigned long long v5; // rdx | stack - 0x28
  unsigned int v6; // stack - 0x20
  unsigned long long v7; // rax | stack + 0x28 | stack - 0x18
  unsigned long long v8; // stack - 0x10
  
  v7 = a4;
  v2[0] = 0x30;
  v6 = 0x240;
  v8 = 0;
  v4 = a0;
  v5 = a1;
  v1 = ZwCreateKey(v3,a2,v2,0,0,a3,&a4);
  if (v1 <= -1) {
    v3[0] = 0;
    *(unsigned int *)&a4 = 0;
  }
  *a6 = v3[0];
  if (a5)
    *a5 = (unsigned int)a4;
  return v1;
}

// Function: sub_1400095bc @ 0x1400095bc
void sub_1400095bc(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned long long *a3)
{
  unsigned long long v1 [4]; // rcx | stack + 0x8
  unsigned int v2 [2]; // stack - 0x38
  unsigned long long v3; // rcx | stack - 0x30
  unsigned long long v4; // rdx | stack - 0x28
  unsigned int v5; // stack - 0x20
  unsigned long long v6; // stack - 0x18
  unsigned long long v7; // stack - 0x10
  
  *a3 = 0;
  v2[0] = 0x30;
  v5 = 0x240;
  v6 = 0;
  v7 = 0;
  v3 = a0;
  v4 = a1;
  if (0 <= (int)ZwOpenKey(v1,a2,v2))
    *a3 = v1[0];
}

// Function: sub_140009614 @ 0x140009614
void sub_140009614(unsigned long long a0,unsigned long long a1,unsigned long long a2)
{
  char v1 [16]; // stack - 0x28
  char v2 [16]; // stack - 0x18
  
  if (0 <= (int)sub_140001000(v1,a2)) {
    if (0 <= (int)sub_140001000(v2,a1))
      sub_1400093b4(a0,v2,v1);
  }
}

// Function: sub_140009664 @ 0x140009664
void sub_140009664(unsigned long long a0,unsigned long long a1,unsigned long long a2)
{
  char v1 [16]; // stack - 0x18
  
  if (0 <= (int)sub_140001000(v1))
    sub_1400093b4(a0,v1,a2);
}

// Function: sub_1400096a0 @ 0x1400096a0
void sub_1400096a0(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned long long a3,unsigned int a4)
{
  char v1 [16]; // stack - 0x18
  
  if (0 <= (int)sub_140001000(v1))
    ZwSetValueKey(a0,v1,0,a2,a3,a4);
}

// Function: sub_1400096f8 @ 0x1400096f8
void sub_1400096f8(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned long long a3)
{
  char v1 [16]; // stack - 0x18
  
  if (0 <= (int)sub_140001000(v1))
    sub_1400094b0(a0,v1,a2,a3);
}

// Function: sub_140009744 @ 0x140009744
void sub_140009744(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned int a3,unsigned long long a4,unsigned long long a5,unsigned long long a6)
{
  char v1 [16]; // stack - 0x18
  
  if (0 <= (int)sub_140001000(v1))
    sub_140009524(a0,v1,a2,a3,a4,a5,a6);
}

// Function: sub_1400097b4 @ 0x1400097b4
void sub_1400097b4(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned long long a3)
{
  char v1 [16]; // stack - 0x18
  
  if (0 <= (int)sub_140001000(v1))
    sub_1400095bc(a0,v1,a2,a3);
}

// Function: sub_140009800 @ 0x140009800
unsigned long long sub_140009800(unsigned long long a0,unsigned short *a1,int a2,int a3,long long *a4)
{
  long long *v1; // rbp | stack + 0x28
  unsigned int v2; // eax
  int v3; // eax | edi
  long long v4; // rax | rbx | rcx
  unsigned long long v5; // rax
  unsigned int v6 [2]; // eax | stack + 0x20 | stack - 0x28
  unsigned int v7; // edi | stack - 0x28
  unsigned long long v8; // rax | rdi
  
  v1 = a4;
  *a4 = 0;
  v2 = *a1 + 0x1f & 0xfffffff8;
  v7 = v2 + a3;
  if (v7 < v2)
    return 0xc0000095;
  v4 = ExAllocatePoolWithTag(0,v7,0x62527050);
  if (!v4)
    return 0xc000009a;
  v5 = ZwQueryValueKey(a0,a1,1,v4,v7,v6);
  v3 = v5;
  if (v3 <= -1) {
    ExFreePoolWithTag(v4,0);
    if ((v3 != -0x7ffffffb) && (v3 != -0x3fffffdd))
      return v5 & 0xffffffff;
    v4 = ExAllocatePoolWithTag(0,v6[0],0x62527050);
    if (!v4)
      return 0xc000009a;
    v5 = ZwQueryValueKey(a0,a1,1,v4,v6[0],v6);
    v8 = v5 & 0xffffffff;
    if ((int)v5 <= -1) {
      ExFreePoolWithTag(v4,0); // return-dupe
      return v8;
    }
  }
  if ((!a2) || (*(int *)(v4 + 4) == a2)) {
    *v1 = v4;
    return 0;
  }
  v8 = 0xc0000024;
  ExFreePoolWithTag(v4,0);
  return v8;
}

// Function: sub_140009934 @ 0x140009934
void sub_140009934(unsigned long long a0,unsigned long long a1,unsigned int a2,unsigned int a3,unsigned long long a4)
{
  char v1 [16]; // stack - 0x18
  
  if (0 <= (int)sub_140001000(v1))
    sub_140009800(a0,v1,a2,a3,a4);
}

