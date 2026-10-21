; kuna decompile-project — GPUZ-v2.sys
; arch: x86:LE:64:default:windows

; --- code section 0x140001000..0x1400025bd ---

sub_140001000:  ; 0x140001000
; arg:   param_1 (struct_0 *)
; arg:   param_2 (short *)
; stack: stack_8 @ [stack+0x8] (undefined32)
  140001000: 48 89 7c 24 08            MOV        qword ptr [RSP + 0x8],RDI
  140001005: 33 c0                     XOR        EAX,EAX
  140001007: 4c 8b c1                  MOV        R8,RCX
  14000100a: 48 3b d0                  CMP        RDX,RAX
  14000100d: 74 37                     JZ         0x140001046
  14000100f: 48 83 c9 ff               OR         RCX,-0x1
  140001013: 48 8b fa                  MOV        RDI,RDX
  140001016: 66 f2 af                  SCASW.REPNE RDI
  140001019: 48 f7 d1                  NOT        RCX
  14000101c: 48 ff c9                  DEC        RCX
  14000101f: 48 81 f9 fe 7f 00 00      CMP        RCX,0x7ffe
  140001026: 76 07                     JBE        0x14000102f
  140001028: b8 06 01 00 c0            MOV        EAX,0xc0000106
  14000102d: eb 24                     JMP        0x140001053
  14000102f: 48 8d 04 09               LEA        RAX,[RCX + RCX*0x1]
  140001033: 49 89 50 08               MOV        qword ptr [R8 + 0x8],RDX
  140001037: 66 41 89 00               MOV        word ptr [R8],AX
  14000103b: 66 83 c0 02               ADD        AX,0x2
  14000103f: 66 41 89 40 02            MOV        word ptr [R8 + 0x2],AX
  140001044: eb 0b                     JMP        0x140001051
  140001046: 66 89 01                  MOV        word ptr [RCX],AX
  140001049: 66 89 41 02               MOV        word ptr [RCX + 0x2],AX
  14000104d: 48 89 41 08               MOV        qword ptr [RCX + 0x8],RAX
  140001051: 33 c0                     XOR        EAX,EAX
  140001053: 48 8b 7c 24 08            MOV        RDI,qword ptr [RSP + 0x8]
  140001058: c3                        RET
  140001059: cc                        INT3
  14000105a: cc                        INT3
  14000105b: cc                        INT3

sub_14000105c:  ; 0x14000105c
; arg:   param_1 (unsigned long long)
; arg:   param_2 (void *)
; arg:   param_3 (unsigned int *)
; stack: local_8 @ [stack-0x8] (undefined8)
  14000105c: 40 53                     PUSH       RBX
  14000105e: 48 83 ec 20               SUB        RSP,0x20
  140001062: 45 8b 18                  MOV        R11D,dword ptr [R8]
  140001065: 48 8b da                  MOV        RBX,RDX
  140001068: 4c 8b c9                  MOV        R9,RCX
  14000106b: 41 83 e3 f8               AND        R11D,0xfffffff8
  14000106f: 41 f6 00 04               TEST       byte ptr [R8],0x4
  140001073: 4c 8b d1                  MOV        R10,RCX
  140001076: 74 13                     JZ         0x14000108b
  140001078: 41 8b 40 08               MOV        EAX,dword ptr [R8 + 0x8]
  14000107c: 4d 63 50 04               MOVSXD     R10,dword ptr [R8 + 0x4]
  140001080: f7 d8                     NEG        EAX
  140001082: 4c 03 d1                  ADD        R10,RCX
  140001085: 48 63 c8                  MOVSXD     RCX,EAX
  140001088: 4c 23 d1                  AND        R10,RCX
  14000108b: 49 63 c3                  MOVSXD     RAX,R11D
  14000108e: 4a 8b 14 10               MOV        RDX,qword ptr [RAX + R10*0x1]
  140001092: 48 8b 43 10               MOV        RAX,qword ptr [RBX + 0x10]
  140001096: 8b 48 08                  MOV        ECX,dword ptr [RAX + 0x8]
  140001099: 48 03 4b 08               ADD        RCX,qword ptr [RBX + 0x8]
  14000109d: f6 41 03 0f               TEST       byte ptr [RCX + 0x3],0xf
  1400010a1: 74 0c                     JZ         0x1400010af
  1400010a3: 0f b6 41 03               MOVZX      EAX,byte ptr [RCX + 0x3]
  1400010a7: 83 e0 f0                  AND        EAX,0xfffffff0
  1400010aa: 48 98                     CDQE
  1400010ac: 4c 03 c8                  ADD        R9,RAX
  1400010af: 4c 33 ca                  XOR        R9,RDX
  1400010b2: 49 8b c9                  MOV        RCX,R9
  1400010b5: 48 83 c4 20               ADD        RSP,0x20
  1400010b9: 5b                        POP        RBX
  1400010ba: e9 81 04 00 00            JMP        0x140001540
  1400010bf: cc                        INT3

sub_1400010c0:  ; 0x1400010c0
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned long long)
; arg:   param_3 (unsigned long long)
; arg:   param_4 (void *)
; stack: local_30 @ [stack-0x30] (undefined48)
  1400010c0: 48 83 ec 28               SUB        RSP,0x28
  1400010c4: 4d 8b 41 38               MOV        R8,qword ptr [R9 + 0x38]
  1400010c8: 48 8b ca                  MOV        RCX,RDX
  1400010cb: 49 8b d1                  MOV        RDX,R9
  1400010ce: e8 89 ff ff ff            CALL       0x14000105c
  1400010d3: b8 01 00 00 00            MOV        EAX,0x1
  1400010d8: 48 83 c4 28               ADD        RSP,0x28
  1400010dc: c3                        RET
  1400010dd: cc                        INT3
  1400010de: cc                        INT3
  1400010df: cc                        INT3
  1400010e0: cc                        INT3
  1400010e1: cc                        INT3
  1400010e2: cc                        INT3
  1400010e3: cc                        INT3
  1400010e4: cc                        INT3
  1400010e5: cc                        INT3
  1400010e6: 66 66 0f 1f 84 00 00 00 00 00  NOP        dword ptr [RAX + RAX*0x1]

sub_1400010f0:  ; 0x1400010f0
; arg:   param_1 (unsigned long long *)
; arg:   param_2 (unsigned char)
; arg:   param_3 (unsigned long long)
  1400010f0: 48 8b c1                  MOV        RAX,RCX
  1400010f3: 49 83 f8 08               CMP        R8,0x8
  1400010f7: 72 53                     JC         0x14000114c
  1400010f9: 0f b6 d2                  MOVZX      EDX,DL
  1400010fc: 49 b9 01 01 01 01 01 01 01 01  MOV        R9,0x101010101010101
  140001106: 49 0f af d1               IMUL       RDX,R9
  14000110a: 49 83 f8 40               CMP        R8,0x40
  14000110e: 72 1e                     JC         0x14000112e
  140001110: 48 f7 d9                  NEG        RCX
  140001113: 83 e1 07                  AND        ECX,0x7
  140001116: 74 06                     JZ         0x14000111e
  140001118: 4c 2b c1                  SUB        R8,RCX
  14000111b: 48 89 10                  MOV        qword ptr [RAX],RDX
  14000111e: 48 03 c8                  ADD        RCX,RAX
  140001121: 4d 8b c8                  MOV        R9,R8
  140001124: 49 83 e0 3f               AND        R8,0x3f
  140001128: 49 c1 e9 06               SHR        R9,0x6
  14000112c: 75 39                     JNZ        0x140001167
  14000112e: 4d 8b c8                  MOV        R9,R8
  140001131: 49 83 e0 07               AND        R8,0x7
  140001135: 49 c1 e9 03               SHR        R9,0x3
  140001139: 74 11                     JZ         0x14000114c
  14000113b: 66 66 66 90               NOP
  14000113f: 90                        NOP
  140001140: 48 89 11                  MOV        qword ptr [RCX],RDX
  140001143: 48 83 c1 08               ADD        RCX,0x8
  140001147: 49 ff c9                  DEC        R9
  14000114a: 75 f4                     JNZ        0x140001140
  14000114c: 4d 85 c0                  TEST       R8,R8
  14000114f: 74 0a                     JZ         0x14000115b
  140001151: 88 11                     MOV        byte ptr [RCX],DL
  140001153: 48 ff c1                  INC        RCX
  140001156: 49 ff c8                  DEC        R8
  140001159: 75 f6                     JNZ        0x140001151
  14000115b: c2 00 00                  RET        0x0
  14000115e: 66 90                     NOP
  140001160: 66 66 66 90               NOP
  140001164: 66 66 90                  NOP
  140001167: 49 81 f9 00 1c 00 00      CMP        R9,0x1c00
  14000116e: 73 30                     JNC        0x1400011a0
  140001170: 48 89 11                  MOV        qword ptr [RCX],RDX
  140001173: 48 89 51 08               MOV        qword ptr [RCX + 0x8],RDX
  140001177: 48 89 51 10               MOV        qword ptr [RCX + 0x10],RDX
  14000117b: 48 83 c1 40               ADD        RCX,0x40
  14000117f: 48 89 51 d8               MOV        qword ptr [RCX + -0x28],RDX
  140001183: 48 89 51 e0               MOV        qword ptr [RCX + -0x20],RDX
  140001187: 49 ff c9                  DEC        R9
  14000118a: 48 89 51 e8               MOV        qword ptr [RCX + -0x18],RDX
  14000118e: 48 89 51 f0               MOV        qword ptr [RCX + -0x10],RDX
  140001192: 48 89 51 f8               MOV        qword ptr [RCX + -0x8],RDX
  140001196: 75 d8                     JNZ        0x140001170
  140001198: eb 94                     JMP        0x14000112e
  14000119a: 66 0f 1f 44 00 00         NOP        word ptr [RAX + RAX*0x1]
  1400011a0: 48 0f c3 11               MOVNTI     [RCX],RDX
  1400011a4: 48 0f c3 51 08            MOVNTI     [RCX + 0x8],RDX
  1400011a9: 48 0f c3 51 10            MOVNTI     [RCX + 0x10],RDX
  1400011ae: 48 83 c1 40               ADD        RCX,0x40
  1400011b2: 48 0f c3 51 d8            MOVNTI     [RCX + -0x28],RDX
  1400011b7: 48 0f c3 51 e0            MOVNTI     [RCX + -0x20],RDX
  1400011bc: 49 ff c9                  DEC        R9
  1400011bf: 48 0f c3 51 e8            MOVNTI     [RCX + -0x18],RDX
  1400011c4: 48 0f c3 51 f0            MOVNTI     [RCX + -0x10],RDX
  1400011c9: 48 0f c3 51 f8            MOVNTI     [RCX + -0x8],RDX
  1400011ce: 75 d0                     JNZ        0x1400011a0
  1400011d0: f0 80 0c 24 00            OR.LOCK    byte ptr [RSP],0x0
  1400011d5: e9 54 ff ff ff            JMP        0x14000112e
  1400011da: cc                        INT3
  1400011db: cc                        INT3
  1400011dc: cc                        INT3
  1400011dd: cc                        INT3
  1400011de: cc                        INT3
  1400011df: cc                        INT3
  1400011e0: cc                        INT3
  1400011e1: cc                        INT3
  1400011e2: cc                        INT3
  1400011e3: cc                        INT3
  1400011e4: cc                        INT3
  1400011e5: cc                        INT3
  1400011e6: 66 66 0f 1f 84 00 00 00 00 00  NOP        dword ptr [RAX + RAX*0x1]

sub_1400011f0:  ; 0x1400011f0
; arg:   param_1 (unsigned long long *)
; arg:   param_2 (unsigned long long *)
; arg:   param_3 (unsigned long long)
  1400011f0: 4c 8b d9                  MOV        R11,RCX
  1400011f3: 48 2b d1                  SUB        RDX,RCX
  1400011f6: 0f 82 9e 01 00 00         JC         0x14000139a
  1400011fc: 49 83 f8 08               CMP        R8,0x8
  140001200: 72 62                     JC         0x140001264
  140001202: f6 c1 07                  TEST       CL,0x7
  140001205: 74 37                     JZ         0x14000123e
  140001207: f6 c1 01                  TEST       CL,0x1
  14000120a: 74 0c                     JZ         0x140001218
  14000120c: 8a 04 0a                  MOV        AL,byte ptr [RDX + RCX*0x1]
  14000120f: 49 ff c8                  DEC        R8
  140001212: 88 01                     MOV        byte ptr [RCX],AL
  140001214: 48 83 c1 01               ADD        RCX,0x1
  140001218: f6 c1 02                  TEST       CL,0x2
  14000121b: 74 0f                     JZ         0x14000122c
  14000121d: 66 8b 04 0a               MOV        AX,word ptr [RDX + RCX*0x1]
  140001221: 49 83 e8 02               SUB        R8,0x2
  140001225: 66 89 01                  MOV        word ptr [RCX],AX
  140001228: 48 83 c1 02               ADD        RCX,0x2
  14000122c: f6 c1 04                  TEST       CL,0x4
  14000122f: 74 0d                     JZ         0x14000123e
  140001231: 8b 04 0a                  MOV        EAX,dword ptr [RDX + RCX*0x1]
  140001234: 49 83 e8 04               SUB        R8,0x4
  140001238: 89 01                     MOV        dword ptr [RCX],EAX
  14000123a: 48 83 c1 04               ADD        RCX,0x4
  14000123e: 4d 8b c8                  MOV        R9,R8
  140001241: 49 c1 e9 05               SHR        R9,0x5
  140001245: 75 50                     JNZ        0x140001297
  140001247: 4d 8b c8                  MOV        R9,R8
  14000124a: 49 c1 e9 03               SHR        R9,0x3
  14000124e: 74 14                     JZ         0x140001264
  140001250: 48 8b 04 0a               MOV        RAX,qword ptr [RDX + RCX*0x1]
  140001254: 48 89 01                  MOV        qword ptr [RCX],RAX
  140001257: 48 83 c1 08               ADD        RCX,0x8
  14000125b: 49 ff c9                  DEC        R9
  14000125e: 75 f0                     JNZ        0x140001250
  140001260: 49 83 e0 07               AND        R8,0x7
  140001264: 4d 85 c0                  TEST       R8,R8
  140001267: 75 07                     JNZ        0x140001270
  140001269: 49 8b c3                  MOV        RAX,R11
  14000126c: c3                        RET
  14000126d: 0f 1f 00                  NOP        dword ptr [RAX]
  140001270: 8a 04 0a                  MOV        AL,byte ptr [RDX + RCX*0x1]
  140001273: 88 01                     MOV        byte ptr [RCX],AL
  140001275: 48 ff c1                  INC        RCX
  140001278: 49 ff c8                  DEC        R8
  14000127b: 75 f3                     JNZ        0x140001270
  14000127d: 49 8b c3                  MOV        RAX,R11
  140001280: c3                        RET
  140001281: 66 66 66 66 66 66 66 0f 1f 84 00 00 00 00 00  NOP        word ptr [RAX + RAX*0x1]
  140001290: 66 66 66 90               NOP
  140001294: 66 66 90                  NOP
  140001297: 49 81 f9 00 20 00 00      CMP        R9,0x2000
  14000129e: 73 42                     JNC        0x1400012e2
  1400012a0: 48 8b 04 0a               MOV        RAX,qword ptr [RDX + RCX*0x1]
  1400012a4: 4c 8b 54 0a 08            MOV        R10,qword ptr [RDX + RCX*0x1 + 0x8]
  1400012a9: 48 83 c1 20               ADD        RCX,0x20
  1400012ad: 48 89 41 e0               MOV        qword ptr [RCX + -0x20],RAX
  1400012b1: 4c 89 51 e8               MOV        qword ptr [RCX + -0x18],R10
  1400012b5: 48 8b 44 0a f0            MOV        RAX,qword ptr [RDX + RCX*0x1 + -0x10]
  1400012ba: 4c 8b 54 0a f8            MOV        R10,qword ptr [RDX + RCX*0x1 + -0x8]
  1400012bf: 49 ff c9                  DEC        R9
  1400012c2: 48 89 41 f0               MOV        qword ptr [RCX + -0x10],RAX
  1400012c6: 4c 89 51 f8               MOV        qword ptr [RCX + -0x8],R10
  1400012ca: 75 d4                     JNZ        0x1400012a0
  1400012cc: 49 83 e0 1f               AND        R8,0x1f
  1400012d0: e9 72 ff ff ff            JMP        0x140001247
  1400012d5: 66 66 66 0f 1f 84 00 00 00 00 00  NOP        word ptr [RAX + RAX*0x1]
  1400012e0: 66 90                     NOP
  1400012e2: 48 81 fa 00 10 00 00      CMP        RDX,0x1000
  1400012e9: 72 b5                     JC         0x1400012a0
  1400012eb: b8 20 00 00 00            MOV        EAX,0x20
  1400012f0: 0f 18 04 0a               NOP        dword ptr [RDX + RCX*0x1]
  1400012f4: 0f 18 44 0a 40            NOP        dword ptr [RDX + RCX*0x1 + 0x40]
  1400012f9: 48 81 c1 80 00 00 00      ADD        RCX,0x80
  140001300: ff c8                     DEC        EAX
  140001302: 75 ec                     JNZ        0x1400012f0
  140001304: 48 81 e9 00 10 00 00      SUB        RCX,0x1000
  14000130b: b8 40 00 00 00            MOV        EAX,0x40
  140001310: 4c 8b 0c 0a               MOV        R9,qword ptr [RDX + RCX*0x1]
  140001314: 4c 8b 54 0a 08            MOV        R10,qword ptr [RDX + RCX*0x1 + 0x8]
  140001319: 4c 0f c3 09               MOVNTI     [RCX],R9
  14000131d: 4c 0f c3 51 08            MOVNTI     [RCX + 0x8],R10
  140001322: 4c 8b 4c 0a 10            MOV        R9,qword ptr [RDX + RCX*0x1 + 0x10]
  140001327: 4c 8b 54 0a 18            MOV        R10,qword ptr [RDX + RCX*0x1 + 0x18]
  14000132c: 4c 0f c3 49 10            MOVNTI     [RCX + 0x10],R9
  140001331: 4c 0f c3 51 18            MOVNTI     [RCX + 0x18],R10
  140001336: 4c 8b 4c 0a 20            MOV        R9,qword ptr [RDX + RCX*0x1 + 0x20]
  14000133b: 4c 8b 54 0a 28            MOV        R10,qword ptr [RDX + RCX*0x1 + 0x28]
  140001340: 48 83 c1 40               ADD        RCX,0x40
  140001344: 4c 0f c3 49 e0            MOVNTI     [RCX + -0x20],R9
  140001349: 4c 0f c3 51 e8            MOVNTI     [RCX + -0x18],R10
  14000134e: 4c 8b 4c 0a f0            MOV        R9,qword ptr [RDX + RCX*0x1 + -0x10]
  140001353: 4c 8b 54 0a f8            MOV        R10,qword ptr [RDX + RCX*0x1 + -0x8]
  140001358: ff c8                     DEC        EAX
  14000135a: 4c 0f c3 49 f0            MOVNTI     [RCX + -0x10],R9
  14000135f: 4c 0f c3 51 f8            MOVNTI     [RCX + -0x8],R10
  140001364: 75 aa                     JNZ        0x140001310
  140001366: 49 81 e8 00 10 00 00      SUB        R8,0x1000
  14000136d: 49 81 f8 00 10 00 00      CMP        R8,0x1000
  140001374: 0f 83 71 ff ff ff         JNC        0x1400012eb
  14000137a: f0 80 0c 24 00            OR.LOCK    byte ptr [RSP],0x0
  14000137f: e9 ba fe ff ff            JMP        0x14000123e
  140001384: 66 66 66 66 0f 1f 84 00 00 00 00 00  NOP        dword ptr [RAX + RAX*0x1]
  140001390: 66 66 66 90               NOP
  140001394: 66 66 66 90               NOP
  140001398: 66 90                     NOP
  14000139a: 49 03 c8                  ADD        RCX,R8
  14000139d: 49 83 f8 08               CMP        R8,0x8
  1400013a1: 72 61                     JC         0x140001404
  1400013a3: f6 c1 07                  TEST       CL,0x7
  1400013a6: 74 36                     JZ         0x1400013de
  1400013a8: f6 c1 01                  TEST       CL,0x1
  1400013ab: 74 0b                     JZ         0x1400013b8
  1400013ad: 48 ff c9                  DEC        RCX
  1400013b0: 8a 04 0a                  MOV        AL,byte ptr [RDX + RCX*0x1]
  1400013b3: 49 ff c8                  DEC        R8
  1400013b6: 88 01                     MOV        byte ptr [RCX],AL
  1400013b8: f6 c1 02                  TEST       CL,0x2
  1400013bb: 74 0f                     JZ         0x1400013cc
  1400013bd: 48 83 e9 02               SUB        RCX,0x2
  1400013c1: 66 8b 04 0a               MOV        AX,word ptr [RDX + RCX*0x1]
  1400013c5: 49 83 e8 02               SUB        R8,0x2
  1400013c9: 66 89 01                  MOV        word ptr [RCX],AX
  1400013cc: f6 c1 04                  TEST       CL,0x4
  1400013cf: 74 0d                     JZ         0x1400013de
  1400013d1: 48 83 e9 04               SUB        RCX,0x4
  1400013d5: 8b 04 0a                  MOV        EAX,dword ptr [RDX + RCX*0x1]
  1400013d8: 49 83 e8 04               SUB        R8,0x4
  1400013dc: 89 01                     MOV        dword ptr [RCX],EAX
  1400013de: 4d 8b c8                  MOV        R9,R8
  1400013e1: 49 c1 e9 05               SHR        R9,0x5
  1400013e5: 75 50                     JNZ        0x140001437
  1400013e7: 4d 8b c8                  MOV        R9,R8
  1400013ea: 49 c1 e9 03               SHR        R9,0x3
  1400013ee: 74 14                     JZ         0x140001404
  1400013f0: 48 83 e9 08               SUB        RCX,0x8
  1400013f4: 48 8b 04 0a               MOV        RAX,qword ptr [RDX + RCX*0x1]
  1400013f8: 49 ff c9                  DEC        R9
  1400013fb: 48 89 01                  MOV        qword ptr [RCX],RAX
  1400013fe: 75 f0                     JNZ        0x1400013f0
  140001400: 49 83 e0 07               AND        R8,0x7
  140001404: 4d 85 c0                  TEST       R8,R8
  140001407: 75 07                     JNZ        0x140001410
  140001409: 49 8b c3                  MOV        RAX,R11
  14000140c: c3                        RET
  14000140d: 0f 1f 00                  NOP        dword ptr [RAX]
  140001410: 48 ff c9                  DEC        RCX
  140001413: 8a 04 0a                  MOV        AL,byte ptr [RDX + RCX*0x1]
  140001416: 49 ff c8                  DEC        R8
  140001419: 88 01                     MOV        byte ptr [RCX],AL
  14000141b: 75 f3                     JNZ        0x140001410
  14000141d: 49 8b c3                  MOV        RAX,R11
  140001420: c3                        RET
  140001421: 66 66 66 66 66 66 66 0f 1f 84 00 00 00 00 00  NOP        word ptr [RAX + RAX*0x1]
  140001430: 66 66 66 90               NOP
  140001434: 66 66 90                  NOP
  140001437: 49 81 f9 00 20 00 00      CMP        R9,0x2000
  14000143e: 73 42                     JNC        0x140001482
  140001440: 48 8b 44 0a f8            MOV        RAX,qword ptr [RDX + RCX*0x1 + -0x8]
  140001445: 4c 8b 54 0a f0            MOV        R10,qword ptr [RDX + RCX*0x1 + -0x10]
  14000144a: 48 83 e9 20               SUB        RCX,0x20
  14000144e: 48 89 41 18               MOV        qword ptr [RCX + 0x18],RAX
  140001452: 4c 89 51 10               MOV        qword ptr [RCX + 0x10],R10
  140001456: 48 8b 44 0a 08            MOV        RAX,qword ptr [RDX + RCX*0x1 + 0x8]
  14000145b: 4c 8b 14 0a               MOV        R10,qword ptr [RDX + RCX*0x1]
  14000145f: 49 ff c9                  DEC        R9
  140001462: 48 89 41 08               MOV        qword ptr [RCX + 0x8],RAX
  140001466: 4c 89 11                  MOV        qword ptr [RCX],R10
  140001469: 75 d5                     JNZ        0x140001440
  14000146b: 49 83 e0 1f               AND        R8,0x1f
  14000146f: e9 73 ff ff ff            JMP        0x1400013e7
  140001474: 66 66 66 66 0f 1f 84 00 00 00 00 00  NOP        dword ptr [RAX + RAX*0x1]
  140001480: 66 90                     NOP
  140001482: 48 81 fa 00 f0 ff ff      CMP        RDX,-0x1000
  140001489: 77 b5                     JA         0x140001440
  14000148b: b8 20 00 00 00            MOV        EAX,0x20
  140001490: 48 81 e9 80 00 00 00      SUB        RCX,0x80
  140001497: 0f 18 04 0a               NOP        dword ptr [RDX + RCX*0x1]
  14000149b: 0f 18 44 0a 40            NOP        dword ptr [RDX + RCX*0x1 + 0x40]
  1400014a0: ff c8                     DEC        EAX
  1400014a2: 75 ec                     JNZ        0x140001490
  1400014a4: 48 81 c1 00 10 00 00      ADD        RCX,0x1000
  1400014ab: b8 40 00 00 00            MOV        EAX,0x40
  1400014b0: 4c 8b 4c 0a f8            MOV        R9,qword ptr [RDX + RCX*0x1 + -0x8]
  1400014b5: 4c 8b 54 0a f0            MOV        R10,qword ptr [RDX + RCX*0x1 + -0x10]
  1400014ba: 4c 0f c3 49 f8            MOVNTI     [RCX + -0x8],R9
  1400014bf: 4c 0f c3 51 f0            MOVNTI     [RCX + -0x10],R10
  1400014c4: 4c 8b 4c 0a e8            MOV        R9,qword ptr [RDX + RCX*0x1 + -0x18]
  1400014c9: 4c 8b 54 0a e0            MOV        R10,qword ptr [RDX + RCX*0x1 + -0x20]
  1400014ce: 4c 0f c3 49 e8            MOVNTI     [RCX + -0x18],R9
  1400014d3: 4c 0f c3 51 e0            MOVNTI     [RCX + -0x20],R10
  1400014d8: 4c 8b 4c 0a d8            MOV        R9,qword ptr [RDX + RCX*0x1 + -0x28]
  1400014dd: 4c 8b 54 0a d0            MOV        R10,qword ptr [RDX + RCX*0x1 + -0x30]
  1400014e2: 48 83 e9 40               SUB        RCX,0x40
  1400014e6: 4c 0f c3 49 18            MOVNTI     [RCX + 0x18],R9
  1400014eb: 4c 0f c3 51 10            MOVNTI     [RCX + 0x10],R10
  1400014f0: 4c 8b 4c 0a 08            MOV        R9,qword ptr [RDX + RCX*0x1 + 0x8]
  1400014f5: 4c 8b 14 0a               MOV        R10,qword ptr [RDX + RCX*0x1]
  1400014f9: ff c8                     DEC        EAX
  1400014fb: 4c 0f c3 49 08            MOVNTI     [RCX + 0x8],R9
  140001500: 4c 0f c3 11               MOVNTI     [RCX],R10
  140001504: 75 aa                     JNZ        0x1400014b0
  140001506: 49 81 e8 00 10 00 00      SUB        R8,0x1000
  14000150d: 49 81 f8 00 10 00 00      CMP        R8,0x1000
  140001514: 0f 83 71 ff ff ff         JNC        0x14000148b
  14000151a: f0 80 0c 24 00            OR.LOCK    byte ptr [RSP],0x0
  14000151f: e9 ba fe ff ff            JMP        0x1400013de
  140001524: cc                        INT3
  140001525: cc                        INT3
  140001526: cc                        INT3
  140001527: cc                        INT3
  140001528: cc                        INT3
  140001529: cc                        INT3
  14000152a: cc                        INT3
  14000152b: cc                        INT3
  14000152c: cc                        INT3
  14000152d: cc                        INT3
  14000152e: cc                        INT3
  14000152f: cc                        INT3
  140001530: cc                        INT3
  140001531: cc                        INT3
  140001532: cc                        INT3
  140001533: cc                        INT3
  140001534: cc                        INT3
  140001535: cc                        INT3
  140001536: 66 66 0f 1f 84 00 00 00 00 00  NOP        dword ptr [RAX + RAX*0x1]

sub_140001540:  ; 0x140001540
; arg:   param_1 (long long)
  140001540: 48 3b 0d 89 2c 00 00      CMP        RCX,qword ptr [0x1400041d0]
  140001547: 75 12                     JNZ        0x14000155b
  140001549: 48 c1 c1 10               ROL        RCX,0x10
  14000154d: 66 f7 c1 ff ff            TEST       CX,0xffff
  140001552: 75 03                     JNZ        0x140001557
  140001554: c2 00 00                  RET        0x0
  140001557: 48 c1 c9 10               ROR        RCX,0x10
  14000155b: e9 00 00 00 00            JMP        0x140001560

sub_140001560:  ; 0x140001560
; arg:   param_1 (unsigned long long)
; stack: local_40 @ [stack-0x40] (undefined8)
; stack: local_38 @ [stack-0x38] (undefined32)
; stack: local_18 @ [stack-0x18] (undefined24)
  140001560: 48 83 ec 38               SUB        RSP,0x38
  140001564: 4c 8b 0d 6d 2c 00 00      MOV        R9,qword ptr [0x1400041d8]
  14000156b: 4c 8b 05 5e 2c 00 00      MOV        R8,qword ptr [0x1400041d0]
  140001572: 48 83 64 24 20 00         AND        qword ptr [RSP + 0x20],0x0
  140001578: 48 8b d1                  MOV        RDX,RCX
  14000157b: b9 f7 00 00 00            MOV        ECX,0xf7
  140001580: ff 15 22 1c 00 00         CALL       qword ptr [0x1400031a8]
  140001586: cc                        INT3
  140001587: cc                        INT3
  140001588: cc                        INT3
  140001589: cc                        INT3
  14000158a: cc                        INT3
  14000158b: cc                        INT3
  14000158c: cc                        INT3
  14000158d: cc                        INT3
  14000158e: cc                        INT3
  14000158f: cc                        INT3

sub_140001590:  ; 0x140001590
; arg:   param_1 (unsigned int)
; arg:   param_2 (unsigned long long)
; arg:   param_3 (unsigned long long)
; arg:   param_4 (unsigned long long)
; stack: v7 @ [stack+0x18] (unsigned long long)
; stack: v10 @ [stack+0x20] (unsigned long long)
; stack: local_60 @ [stack-0x60] (undefined40)
; stack: local_38 @ [stack-0x38] (undefined24)
; stack: local_20 @ [stack-0x20] (undefined8)
; stack: local_18 @ [stack-0x18] (undefined8)
; stack: local_10 @ [stack-0x10] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined8)
  140001590: 83 f9 04                  CMP        ECX,0x4
  140001593: 0f 87 04 01 00 00         JA         0x14000169d
  140001599: 4c 8b dc                  MOV        R11,RSP
  14000159c: 49 89 53 10               MOV        qword ptr [R11 + 0x10],RDX
  1400015a0: 4d 89 43 18               MOV        qword ptr [R11 + 0x18],R8
  1400015a4: 4d 89 4b 20               MOV        qword ptr [R11 + 0x20],R9
  1400015a8: 56                        PUSH       RSI
  1400015a9: 48 83 ec 50               SUB        RSP,0x50
  1400015ad: 49 89 5b f0               MOV        qword ptr [R11 + -0x10],RBX
  1400015b1: 49 8d 43 18               LEA        RAX,[R11 + 0x18]
  1400015b5: 49 89 6b e8               MOV        qword ptr [R11 + -0x18],RBP
  1400015b9: 8b f1                     MOV        ESI,ECX
  1400015bb: 33 ed                     XOR        EBP,EBP
  1400015bd: 49 89 43 c8               MOV        qword ptr [R11 + -0x38],RAX
  1400015c1: 8b d5                     MOV        EDX,EBP
  1400015c3: 48 8d 0d 36 ea ff ff      LEA        RCX,[0x140000000]
  1400015ca: 44 8d 4d 01               LEA        R9D,[RBP + 0x1]
  1400015ce: 66 90                     NOP
  1400015d0: 44 8b c2                  MOV        R8D,EDX
  1400015d3: 48 8d 99 00 42 00 00      LEA        RBX,[RCX + 0x4200]
  1400015da: 33 c0                     XOR        EAX,EAX
  1400015dc: 4a 8d 1c 83               LEA        RBX,[RBX + R8*0x4]
  1400015e0: f0 44 0f b1 0b            CMPXCHG.LOCK dword ptr [RBX],R9D
  1400015e5: 74 17                     JZ         0x1400015fe
  1400015e7: ff c2                     INC        EDX
  1400015e9: 83 fa 08                  CMP        EDX,0x8
  1400015ec: 72 e2                     JC         0x1400015d0
  1400015ee: 48 8b 5c 24 48            MOV        RBX,qword ptr [RSP + 0x48]
  1400015f3: 48 8b 6c 24 40            MOV        RBP,qword ptr [RSP + 0x40]
  1400015f8: 48 83 c4 50               ADD        RSP,0x50
  1400015fc: 5e                        POP        RSI
  1400015fd: c3                        RET
  1400015fe: 4c 8b 4c 24 20            MOV        R9,qword ptr [RSP + 0x20]
  140001603: ba ff 03 00 00            MOV        EDX,0x3ff
  140001608: 49 c1 e0 0a               SHL        R8,0xa
  14000160c: 48 89 7c 24 38            MOV        qword ptr [RSP + 0x38],RDI
  140001611: 48 8d b9 40 42 00 00      LEA        RDI,[RCX + 0x4240]
  140001618: 49 03 f8                  ADD        RDI,R8
  14000161b: 4c 8b 44 24 68            MOV        R8,qword ptr [RSP + 0x68]
  140001620: 48 8b cf                  MOV        RCX,RDI
  140001623: ff 15 a7 1a 00 00         CALL       qword ptr [0x1400030d0]
  140001629: 85 c0                     TEST       EAX,EAX
  14000162b: 78 0c                     JS         0x140001639
  14000162d: 48 98                     CDQE
  14000162f: 48 3d ff 03 00 00         CMP        RAX,0x3ff
  140001635: 77 02                     JA         0x140001639
  140001637: 75 07                     JNZ        0x140001640
  140001639: 40 88 af ff 03 00 00      MOV        byte ptr [RDI + 0x3ff],BPL
  140001640: 44 0f 20 c0               MOV        RAX, CR8
  140001644: 83 fe 01                  CMP        ESI,0x1
  140001647: 75 09                     JNZ        0x140001652
  140001649: 48 8d 0d e0 20 00 00      LEA        RCX,[0x140003730]
  140001650: eb 21                     JMP        0x140001673
  140001652: 83 fe 02                  CMP        ESI,0x2
  140001655: 75 09                     JNZ        0x140001660
  140001657: 48 8d 0d f2 20 00 00      LEA        RCX,[0x140003750]
  14000165e: eb 13                     JMP        0x140001673
  140001660: 48 8d 0d 09 21 00 00      LEA        RCX,[0x140003770]
  140001667: 83 fe 04                  CMP        ESI,0x4
  14000166a: 74 07                     JZ         0x140001673
  14000166c: 48 8d 0d 1d 21 00 00      LEA        RCX,[0x140003790]
  140001673: 48 8b 15 ae 2b 00 00      MOV        RDX,qword ptr [0x140004228]
  14000167a: 4c 8b cf                  MOV        R9,RDI
  14000167d: 44 0f b6 c0               MOVZX      R8D,AL
  140001681: ff 15 39 1a 00 00         CALL       qword ptr [0x1400030c0]
  140001687: 87 2b                     XCHG       dword ptr [RBX],EBP
  140001689: 48 8b 6c 24 40            MOV        RBP,qword ptr [RSP + 0x40]
  14000168e: 48 8b 7c 24 38            MOV        RDI,qword ptr [RSP + 0x38]
  140001693: 48 8b 5c 24 48            MOV        RBX,qword ptr [RSP + 0x48]
  140001698: 48 83 c4 50               ADD        RSP,0x50
  14000169c: 5e                        POP        RSI
  14000169d: c3                        RET
  14000169e: cc                        INT3
  14000169f: cc                        INT3

sub_1400016a0:  ; 0x1400016a0
; arg:   param_1 (unsigned short *)
; arg:   param_2 (long long)
; arg:   param_3 (unsigned long long)
; arg:   param_4 (unsigned long long)
; stack: v3 @ [stack+0x20] (unsigned long long)
; stack: local_40 @ [stack-0x40] (undefined40)
; stack: local_18 @ [stack-0x18] (undefined8)
; stack: local_10 @ [stack-0x10] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_18 @ [stack+0x18] (undefined8)
  1400016a0: 4c 89 44 24 18            MOV        qword ptr [RSP + 0x18],R8
  1400016a5: 4c 89 4c 24 20            MOV        qword ptr [RSP + 0x20],R9
  1400016aa: 53                        PUSH       RBX
  1400016ab: 56                        PUSH       RSI
  1400016ac: 48 83 ec 28               SUB        RSP,0x28
  1400016b0: 33 db                     XOR        EBX,EBX
  1400016b2: 48 8d 42 ff               LEA        RAX,[RDX + -0x1]
  1400016b6: 48 3d fe ff ff 7f         CMP        RAX,0x7ffffffe
  1400016bc: 48 8b f1                  MOV        RSI,RCX
  1400016bf: 44 8b cb                  MOV        R9D,EBX
  1400016c2: b9 0d 00 00 c0            MOV        ECX,0xc000000d
  1400016c7: 44 0f 47 c9               CMOVA      R9D,ECX
  1400016cb: 45 85 c9                  TEST       R9D,R9D
  1400016ce: 78 50                     JS         0x140001720
  1400016d0: 48 89 7c 24 20            MOV        qword ptr [RSP + 0x20],RDI
  1400016d5: 4c 8d 4c 24 58            LEA        R9,[RSP + 0x58]
  1400016da: 48 8d 7a ff               LEA        RDI,[RDX + -0x1]
  1400016de: 48 8b ce                  MOV        RCX,RSI
  1400016e1: 48 8b d7                  MOV        RDX,RDI
  1400016e4: ff 15 7e 19 00 00         CALL       qword ptr [0x140003068]
  1400016ea: 85 c0                     TEST       EAX,EAX
  1400016ec: 78 1b                     JS         0x140001709
  1400016ee: 48 98                     CDQE
  1400016f0: 48 3b c7                  CMP        RAX,RDI
  1400016f3: 77 14                     JA         0x140001709
  1400016f5: 75 1b                     JNZ        0x140001712
  1400016f7: 66 89 1c 7e               MOV        word ptr [RSI + RDI*0x2],BX
  1400016fb: 8b c3                     MOV        EAX,EBX
  1400016fd: 48 8b 7c 24 20            MOV        RDI,qword ptr [RSP + 0x20]
  140001702: 48 83 c4 28               ADD        RSP,0x28
  140001706: 5e                        POP        RSI
  140001707: 5b                        POP        RBX
  140001708: c3                        RET
  140001709: 66 89 1c 7e               MOV        word ptr [RSI + RDI*0x2],BX
  14000170d: bb 05 00 00 80            MOV        EBX,0x80000005
  140001712: 48 8b 7c 24 20            MOV        RDI,qword ptr [RSP + 0x20]
  140001717: 8b c3                     MOV        EAX,EBX
  140001719: 48 83 c4 28               ADD        RSP,0x28
  14000171d: 5e                        POP        RSI
  14000171e: 5b                        POP        RBX
  14000171f: c3                        RET
  140001720: 41 8b c1                  MOV        EAX,R9D
  140001723: 48 83 c4 28               ADD        RSP,0x28
  140001727: 5e                        POP        RSI
  140001728: 5b                        POP        RBX
  140001729: c3                        RET
  14000172a: cc                        INT3
  14000172b: cc                        INT3
  14000172c: cc                        INT3
  14000172d: cc                        INT3
  14000172e: cc                        INT3
  14000172f: cc                        INT3

sub_140001730:  ; 0x140001730
; arg:   param_1 (void *)
; arg:   param_2 (struct_1 *)
; stack: v9 @ [stack+0x10] (long long[3])
; stack: v8 @ [stack-0x438] (char[8])
; stack: v12 @ [stack-0x430] (unsigned long long)
; stack: v6 @ [stack-0x428] (short[8])
; stack: v11 @ [stack-0x418] (char[8])
; stack: v13 @ [stack-0x410] (unsigned long long)
; stack: v7 @ [stack-0x408] (char[512])
; stack: v10 @ [stack-0x208] (char[512])
; stack: local_490 @ [stack-0x490] (undefined40)
; stack: local_468 @ [stack-0x468] (undefined8)
; stack: local_460 @ [stack-0x460] (undefined8)
; stack: local_458 @ [stack-0x458] (undefined8)
; stack: local_450 @ [stack-0x450] (undefined8)
; stack: local_448 @ [stack-0x448] (undefined16)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
  140001730: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  140001735: 57                        PUSH       RDI
  140001736: 48 81 ec 80 04 00 00      SUB        RSP,0x480
  14000173d: 48 8b da                  MOV        RBX,RDX
  140001740: 4c 8d 0d 69 20 00 00      LEA        R9,[0x1400037b0]
  140001747: 48 8b f9                  MOV        RDI,RCX
  14000174a: 48 8d 15 7f 20 00 00      LEA        RDX,[0x1400037d0]
  140001751: b9 04 00 00 00            MOV        ECX,0x4
  140001756: 4c 8d 05 63 20 00 00      LEA        R8,[0x1400037c0]
  14000175d: e8 2e fe ff ff            CALL       0x140001590
  140001762: 33 c0                     XOR        EAX,EAX
  140001764: 48 89 05 b5 2a 00 00      MOV        qword ptr [0x140004220],RAX
  14000176b: 48 89 05 b6 2a 00 00      MOV        qword ptr [0x140004228],RAX
  140001772: 48 89 05 b7 2a 00 00      MOV        qword ptr [0x140004230],RAX
  140001779: 48 89 05 b8 2a 00 00      MOV        qword ptr [0x140004238],RAX
  140001780: 8d 50 5c                  LEA        EDX,[RAX + 0x5c]
  140001783: 48 8b 4b 08               MOV        RCX,qword ptr [RBX + 0x8]
  140001787: ff 15 3b 19 00 00         CALL       qword ptr [0x1400030c8]
  14000178d: 48 8d 4c 24 60            LEA        RCX,[RSP + 0x60]
  140001792: 48 8d 50 02               LEA        RDX,[RAX + 0x2]
  140001796: ff 15 7c 18 00 00         CALL       qword ptr [0x140003018]
  14000179c: 0f b7 44 24 60            MOVZX      EAX,word ptr [RSP + 0x60]
  1400017a1: b9 01 00 00 00            MOV        ECX,0x1
  1400017a6: 66 89 05 73 2a 00 00      MOV        word ptr [0x140004220],AX
  1400017ad: 41 b8 44 72 69 76         MOV        R8D,0x76697244
  1400017b3: 66 83 c0 02               ADD        AX,0x2
  1400017b7: 0f b7 d0                  MOVZX      EDX,AX
  1400017ba: 66 89 15 61 2a 00 00      MOV        word ptr [0x140004222],DX
  1400017c1: ff 15 79 18 00 00         CALL       qword ptr [0x140003040]
  1400017c7: 48 89 05 5a 2a 00 00      MOV        qword ptr [0x140004228],RAX
  1400017ce: 48 85 c0                  TEST       RAX,RAX
  1400017d1: 75 25                     JNZ        0x1400017f8
  1400017d3: 48 8d 15 16 20 00 00      LEA        RDX,[0x1400037f0]
  1400017da: 8d 48 01                  LEA        ECX,[RAX + 0x1]
  1400017dd: e8 ae fd ff ff            CALL       0x140001590
  1400017e2: b8 9a 00 00 c0            MOV        EAX,0xc000009a
  1400017e7: 48 8b 9c 24 90 04 00 00   MOV        RBX,qword ptr [RSP + 0x490]
  1400017ef: 48 81 c4 80 04 00 00      ADD        RSP,0x480
  1400017f6: 5f                        POP        RDI
  1400017f7: c3                        RET
  1400017f8: 48 8d 54 24 60            LEA        RDX,[RSP + 0x60]
  1400017fd: 48 8d 0d 1c 2a 00 00      LEA        RCX,[0x140004220]
  140001804: ff 15 1e 18 00 00         CALL       qword ptr [0x140003028]
  14000180a: 0f b7 03                  MOVZX      EAX,word ptr [RBX]
  14000180d: b9 01 00 00 00            MOV        ECX,0x1
  140001812: 66 89 05 17 2a 00 00      MOV        word ptr [0x140004230],AX
  140001819: 41 b8 44 72 69 76         MOV        R8D,0x76697244
  14000181f: 0f b7 03                  MOVZX      EAX,word ptr [RBX]
  140001822: 66 83 c0 02               ADD        AX,0x2
  140001826: 0f b7 d0                  MOVZX      EDX,AX
  140001829: 66 89 15 02 2a 00 00      MOV        word ptr [0x140004232],DX
  140001830: ff 15 0a 18 00 00         CALL       qword ptr [0x140003040]
  140001836: 48 89 05 fb 29 00 00      MOV        qword ptr [0x140004238],RAX
  14000183d: 48 85 c0                  TEST       RAX,RAX
  140001840: 75 25                     JNZ        0x140001867
  140001842: 48 8d 15 df 1f 00 00      LEA        RDX,[0x140003828]
  140001849: 8d 48 01                  LEA        ECX,[RAX + 0x1]
  14000184c: e8 3f fd ff ff            CALL       0x140001590
  140001851: b8 9a 00 00 c0            MOV        EAX,0xc000009a
  140001856: 48 8b 9c 24 90 04 00 00   MOV        RBX,qword ptr [RSP + 0x490]
  14000185e: 48 81 c4 80 04 00 00      ADD        RSP,0x480
  140001865: 5f                        POP        RDI
  140001866: c3                        RET
  140001867: 48 8b d3                  MOV        RDX,RBX
  14000186a: 48 8d 0d bf 29 00 00      LEA        RCX,[0x140004230]
  140001871: ff 15 b1 17 00 00         CALL       qword ptr [0x140003028]
  140001877: 48 8d 05 22 02 00 00      LEA        RAX,[0x140001aa0]
  14000187e: ba ff 00 00 00            MOV        EDX,0xff
  140001883: 48 89 47 70               MOV        qword ptr [RDI + 0x70],RAX
  140001887: 4c 8d 05 d2 1f 00 00      LEA        R8,[0x140003860]
  14000188e: 48 8d 05 3b 02 00 00      LEA        RAX,[0x140001ad0]
  140001895: 48 89 87 80 00 00 00      MOV        qword ptr [RDI + 0x80],RAX
  14000189c: 48 8d 8c 24 80 00 00 00   LEA        RCX,[RSP + 0x80]
  1400018a4: 48 8d 05 45 06 00 00      LEA        RAX,[0x140001ef0]
  1400018ab: 48 89 87 e0 00 00 00      MOV        qword ptr [RDI + 0xe0],RAX
  1400018b2: 48 8d 05 47 02 00 00      LEA        RAX,[0x140001b00]
  1400018b9: 48 89 87 00 01 00 00      MOV        qword ptr [RDI + 0x100],RAX
  1400018c0: 48 8d 05 19 03 00 00      LEA        RAX,[0x140001be0]
  1400018c7: 48 89 87 f0 00 00 00      MOV        qword ptr [RDI + 0xf0],RAX
  1400018ce: 48 8d 05 5b 02 00 00      LEA        RAX,[0x140001b30]
  1400018d5: 48 89 47 68               MOV        qword ptr [RDI + 0x68],RAX
  1400018d9: 4c 8b 0d 48 29 00 00      MOV        R9,qword ptr [0x140004228]
  1400018e0: e8 bb fd ff ff            CALL       0x1400016a0
  1400018e5: 48 8d 94 24 80 00 00 00   LEA        RDX,[RSP + 0x80]
  1400018ed: 48 8d 4c 24 50            LEA        RCX,[RSP + 0x50]
  1400018f2: ff 15 20 17 00 00         CALL       qword ptr [0x140003018]
  1400018f8: 48 8d 84 24 98 04 00 00   LEA        RAX,[RSP + 0x498]
  140001900: 41 b9 22 00 00 00         MOV        R9D,0x22
  140001906: 48 89 44 24 40            MOV        qword ptr [RSP + 0x40],RAX
  14000190b: 4c 8d 44 24 50            LEA        R8,[RSP + 0x50]
  140001910: 48 c7 44 24 38 00 00 00 00  MOV        qword ptr [RSP + 0x38],0x0
  140001919: 48 8d 05 90 19 00 00      LEA        RAX,[0x1400032b0]
  140001920: 48 89 44 24 30            MOV        qword ptr [RSP + 0x30],RAX
  140001925: ba 18 28 00 00            MOV        EDX,0x2818
  14000192a: c6 44 24 28 00            MOV        byte ptr [RSP + 0x28],0x0
  14000192f: 48 8b cf                  MOV        RCX,RDI
  140001932: c7 44 24 20 00 01 00 00   MOV        dword ptr [RSP + 0x20],0x100
  14000193a: e8 29 67 00 00            CALL       0x140008068
  14000193f: 8b d8                     MOV        EBX,EAX
  140001941: 85 c0                     TEST       EAX,EAX
  140001943: 79 41                     JNS        0x140001986
  140001945: 48 8b 0d ec 28 00 00      MOV        RCX,qword ptr [0x140004238]
  14000194c: 33 d2                     XOR        EDX,EDX
  14000194e: ff 15 fc 16 00 00         CALL       qword ptr [0x140003050]
  140001954: 44 8b c3                  MOV        R8D,EBX
  140001957: 48 c7 05 d6 28 00 00 00 00 00 00  MOV        qword ptr [0x140004238],0x0
  140001962: 48 8d 15 0f 1f 00 00      LEA        RDX,[0x140003878]
  140001969: b9 01 00 00 00            MOV        ECX,0x1
  14000196e: e8 1d fc ff ff            CALL       0x140001590
  140001973: 8b c3                     MOV        EAX,EBX
  140001975: 48 8b 9c 24 90 04 00 00   MOV        RBX,qword ptr [RSP + 0x490]
  14000197d: 48 81 c4 80 04 00 00      ADD        RSP,0x480
  140001984: 5f                        POP        RDI
  140001985: c3                        RET
  140001986: 4c 8b 44 24 58            MOV        R8,qword ptr [RSP + 0x58]
  14000198b: 48 8d 15 06 1f 00 00      LEA        RDX,[0x140003898]
  140001992: b9 04 00 00 00            MOV        ECX,0x4
  140001997: e8 f4 fb ff ff            CALL       0x140001590
  14000199c: 48 8b 84 24 98 04 00 00   MOV        RAX,qword ptr [RSP + 0x498]
  1400019a4: 33 d2                     XOR        EDX,EDX
  1400019a6: 41 b8 18 28 00 00         MOV        R8D,0x2818
  1400019ac: 48 8b 58 40               MOV        RBX,qword ptr [RAX + 0x40]
  1400019b0: 48 8b cb                  MOV        RCX,RBX
  1400019b3: e8 38 f7 ff ff            CALL       0x1400010f0
  1400019b8: 48 8b 84 24 98 04 00 00   MOV        RAX,qword ptr [RSP + 0x498]
  1400019c0: 4c 8d 05 e9 1e 00 00      LEA        R8,[0x1400038b0]
  1400019c7: 48 89 03                  MOV        qword ptr [RBX],RAX
  1400019ca: 48 8d 8c 24 80 02 00 00   LEA        RCX,[RSP + 0x280]
  1400019d2: 48 8b 84 24 98 04 00 00   MOV        RAX,qword ptr [RSP + 0x498]
  1400019da: ba ff 00 00 00            MOV        EDX,0xff
  1400019df: 83 48 30 10               OR         dword ptr [RAX + 0x30],0x10
  1400019e3: 4c 8b 0d 3e 28 00 00      MOV        R9,qword ptr [0x140004228]
  1400019ea: e8 b1 fc ff ff            CALL       0x1400016a0
  1400019ef: 48 8d 94 24 80 02 00 00   LEA        RDX,[RSP + 0x280]
  1400019f7: 48 8d 4c 24 70            LEA        RCX,[RSP + 0x70]
  1400019fc: ff 15 16 16 00 00         CALL       qword ptr [0x140003018]
  140001a02: 48 8d 54 24 50            LEA        RDX,[RSP + 0x50]
  140001a07: 48 8d 4c 24 70            LEA        RCX,[RSP + 0x70]
  140001a0c: ff 15 4e 16 00 00         CALL       qword ptr [0x140003060]
  140001a12: 8b d8                     MOV        EBX,EAX
  140001a14: 85 c0                     TEST       EAX,EAX
  140001a16: 79 3b                     JNS        0x140001a53
  140001a18: 48 8b 8c 24 98 04 00 00   MOV        RCX,qword ptr [RSP + 0x498]
  140001a20: ff 15 fa 15 00 00         CALL       qword ptr [0x140003020]
  140001a26: 48 8b 0d 0b 28 00 00      MOV        RCX,qword ptr [0x140004238]
  140001a2d: 33 d2                     XOR        EDX,EDX
  140001a2f: ff 15 1b 16 00 00         CALL       qword ptr [0x140003050]
  140001a35: 8b c3                     MOV        EAX,EBX
  140001a37: 48 c7 05 f6 27 00 00 00 00 00 00  MOV        qword ptr [0x140004238],0x0
  140001a42: 48 8b 9c 24 90 04 00 00   MOV        RBX,qword ptr [RSP + 0x490]
  140001a4a: 48 81 c4 80 04 00 00      ADD        RSP,0x480
  140001a51: 5f                        POP        RDI
  140001a52: c3                        RET
  140001a53: 4c 8b 4c 24 58            MOV        R9,qword ptr [RSP + 0x58]
  140001a58: 48 8d 15 61 1e 00 00      LEA        RDX,[0x1400038c0]
  140001a5f: 4c 8b 44 24 78            MOV        R8,qword ptr [RSP + 0x78]
  140001a64: b9 04 00 00 00            MOV        ECX,0x4
  140001a69: e8 22 fb ff ff            CALL       0x140001590
  140001a6e: 48 8b 8c 24 98 04 00 00   MOV        RCX,qword ptr [RSP + 0x498]
  140001a76: ff 15 bc 15 00 00         CALL       qword ptr [0x140003038]
  140001a7c: 48 8b 84 24 98 04 00 00   MOV        RAX,qword ptr [RSP + 0x498]
  140001a84: 81 60 30 7f ff ff ff      AND        dword ptr [RAX + 0x30],0xffffff7f
  140001a8b: 8b c3                     MOV        EAX,EBX
  140001a8d: 48 8b 9c 24 90 04 00 00   MOV        RBX,qword ptr [RSP + 0x490]
  140001a95: 48 81 c4 80 04 00 00      ADD        RSP,0x480
  140001a9c: 5f                        POP        RDI
  140001a9d: c3                        RET
  140001a9e: cc                        INT3
  140001a9f: cc                        INT3

sub_140001aa0:  ; 0x140001aa0
; arg:   param_1 (void *)
; arg:   param_2 (void *)
; stack: local_30 @ [stack-0x30] (undefined48)
  140001aa0: 48 83 ec 28               SUB        RSP,0x28
  140001aa4: 48 8b 41 40               MOV        RAX,qword ptr [RCX + 0x40]
  140001aa8: 4c 8b c2                  MOV        R8,RDX
  140001aab: f0 ff 40 08               INC.LOCK   dword ptr [RAX + 0x8]
  140001aaf: 33 c0                     XOR        EAX,EAX
  140001ab1: 49 8b c8                  MOV        RCX,R8
  140001ab4: 48 89 42 38               MOV        qword ptr [RDX + 0x38],RAX
  140001ab8: 89 42 30                  MOV        dword ptr [RDX + 0x30],EAX
  140001abb: 33 d2                     XOR        EDX,EDX
  140001abd: ff 15 95 15 00 00         CALL       qword ptr [0x140003058]
  140001ac3: 33 c0                     XOR        EAX,EAX
  140001ac5: 48 83 c4 28               ADD        RSP,0x28
  140001ac9: c3                        RET
  140001aca: cc                        INT3
  140001acb: cc                        INT3
  140001acc: cc                        INT3
  140001acd: cc                        INT3
  140001ace: cc                        INT3
  140001acf: cc                        INT3

sub_140001ad0:  ; 0x140001ad0
; arg:   param_1 (void *)
; arg:   param_2 (void *)
; stack: local_30 @ [stack-0x30] (undefined40)
; stack: local_8 @ [stack-0x8] (undefined8)
  140001ad0: 40 53                     PUSH       RBX
  140001ad2: 48 83 ec 20               SUB        RSP,0x20
  140001ad6: 48 8b 59 40               MOV        RBX,qword ptr [RCX + 0x40]
  140001ada: 48 8b c2                  MOV        RAX,RDX
  140001add: 33 c9                     XOR        ECX,ECX
  140001adf: 48 89 4a 38               MOV        qword ptr [RDX + 0x38],RCX
  140001ae3: 89 4a 30                  MOV        dword ptr [RDX + 0x30],ECX
  140001ae6: 33 d2                     XOR        EDX,EDX
  140001ae8: 48 8b c8                  MOV        RCX,RAX
  140001aeb: ff 15 67 15 00 00         CALL       qword ptr [0x140003058]
  140001af1: f0 ff 4b 08               DEC.LOCK   dword ptr [RBX + 0x8]
  140001af5: 33 c0                     XOR        EAX,EAX
  140001af7: 48 83 c4 20               ADD        RSP,0x20
  140001afb: 5b                        POP        RBX
  140001afc: c3                        RET
  140001afd: cc                        INT3
  140001afe: cc                        INT3
  140001aff: cc                        INT3

sub_140001b00:  ; 0x140001b00
; arg:   param_1 (unsigned long long)
; arg:   param_2 (void *)
; stack: local_30 @ [stack-0x30] (undefined48)
  140001b00: 48 83 ec 28               SUB        RSP,0x28
  140001b04: 33 c9                     XOR        ECX,ECX
  140001b06: 48 8b c2                  MOV        RAX,RDX
  140001b09: 48 89 4a 38               MOV        qword ptr [RDX + 0x38],RCX
  140001b0d: 89 4a 30                  MOV        dword ptr [RDX + 0x30],ECX
  140001b10: 33 d2                     XOR        EDX,EDX
  140001b12: 48 8b c8                  MOV        RCX,RAX
  140001b15: ff 15 3d 15 00 00         CALL       qword ptr [0x140003058]
  140001b1b: 33 c0                     XOR        EAX,EAX
  140001b1d: 48 83 c4 28               ADD        RSP,0x28
  140001b21: c3                        RET
  140001b22: cc                        INT3
  140001b23: cc                        INT3
  140001b24: cc                        INT3
  140001b25: cc                        INT3
  140001b26: cc                        INT3
  140001b27: cc                        INT3
  140001b28: cc                        INT3
  140001b29: cc                        INT3
  140001b2a: cc                        INT3
  140001b2b: cc                        INT3
  140001b2c: cc                        INT3
  140001b2d: cc                        INT3
  140001b2e: cc                        INT3
  140001b2f: cc                        INT3

sub_140001b30:  ; 0x140001b30
; arg:   param_1 (void *)
; stack: v2 @ [stack-0x218] (char[16])
; stack: v1 @ [stack-0x208] (char[512])
; stack: local_240 @ [stack-0x240] (undefined8)
; stack: local_238 @ [stack-0x238] (undefined32)
; stack: local_8 @ [stack-0x8] (undefined8)
  140001b30: 40 53                     PUSH       RBX
  140001b32: 48 81 ec 30 02 00 00      SUB        RSP,0x230
  140001b39: 4c 8b 0d e8 26 00 00      MOV        R9,qword ptr [0x140004228]
  140001b40: 4c 8d 05 69 1d 00 00      LEA        R8,[0x1400038b0]
  140001b47: 48 8b d9                  MOV        RBX,RCX
  140001b4a: ba ff 00 00 00            MOV        EDX,0xff
  140001b4f: 48 8d 4c 24 30            LEA        RCX,[RSP + 0x30]
  140001b54: e8 47 fb ff ff            CALL       0x1400016a0
  140001b59: 48 8d 54 24 30            LEA        RDX,[RSP + 0x30]
  140001b5e: 48 8d 4c 24 20            LEA        RCX,[RSP + 0x20]
  140001b63: ff 15 af 14 00 00         CALL       qword ptr [0x140003018]
  140001b69: 48 8d 4c 24 20            LEA        RCX,[RSP + 0x20]
  140001b6e: ff 15 bc 14 00 00         CALL       qword ptr [0x140003030]
  140001b74: 4c 8d 44 24 30            LEA        R8,[RSP + 0x30]
  140001b79: b9 04 00 00 00            MOV        ECX,0x4
  140001b7e: 48 8d 15 53 1d 00 00      LEA        RDX,[0x1400038d8]
  140001b85: e8 06 fa ff ff            CALL       0x140001590
  140001b8a: 48 8b 4b 08               MOV        RCX,qword ptr [RBX + 0x8]
  140001b8e: ff 15 b4 14 00 00         CALL       qword ptr [0x140003048]
  140001b94: 48 8b 4b 08               MOV        RCX,qword ptr [RBX + 0x8]
  140001b98: ff 15 82 14 00 00         CALL       qword ptr [0x140003020]
  140001b9e: 48 8b 0d 93 26 00 00      MOV        RCX,qword ptr [0x140004238]
  140001ba5: 33 db                     XOR        EBX,EBX
  140001ba7: 48 85 c9                  TEST       RCX,RCX
  140001baa: 74 0f                     JZ         0x140001bbb
  140001bac: 33 d2                     XOR        EDX,EDX
  140001bae: ff 15 9c 14 00 00         CALL       qword ptr [0x140003050]
  140001bb4: 48 89 1d 7d 26 00 00      MOV        qword ptr [0x140004238],RBX
  140001bbb: 48 8b 0d 66 26 00 00      MOV        RCX,qword ptr [0x140004228]
  140001bc2: 48 85 c9                  TEST       RCX,RCX
  140001bc5: 74 0f                     JZ         0x140001bd6
  140001bc7: 33 d2                     XOR        EDX,EDX
  140001bc9: ff 15 81 14 00 00         CALL       qword ptr [0x140003050]
  140001bcf: 48 89 1d 52 26 00 00      MOV        qword ptr [0x140004228],RBX
  140001bd6: 48 81 c4 30 02 00 00      ADD        RSP,0x230
  140001bdd: 5b                        POP        RBX
  140001bde: c3                        RET
  140001bdf: cc                        INT3

sub_140001be0:  ; 0x140001be0
; arg:   param_1 (unsigned long long)
; arg:   param_2 (void *)
; stack: local_30 @ [stack-0x30] (undefined48)
  140001be0: 48 83 ec 28               SUB        RSP,0x28
  140001be4: 48 8b ca                  MOV        RCX,RDX
  140001be7: c7 42 30 02 00 00 c0      MOV        dword ptr [RDX + 0x30],0xc0000002
  140001bee: 48 c7 42 38 00 00 00 00   MOV        qword ptr [RDX + 0x38],0x0
  140001bf6: 33 d2                     XOR        EDX,EDX
  140001bf8: ff 15 5a 14 00 00         CALL       qword ptr [0x140003058]
  140001bfe: b8 02 00 00 c0            MOV        EAX,0xc0000002
  140001c03: 48 83 c4 28               ADD        RSP,0x28
  140001c07: c3                        RET
  140001c08: cc                        INT3
  140001c09: cc                        INT3
  140001c0a: cc                        INT3
  140001c0b: cc                        INT3
  140001c0c: cc                        INT3
  140001c0d: cc                        INT3
  140001c0e: cc                        INT3
  140001c0f: cc                        INT3

sub_140001c10:  ; 0x140001c10
; arg:   param_1 (void *)
; arg:   param_2 (void *)
; stack: local_30 @ [stack-0x30] (undefined48)
  140001c10: 48 83 ec 28               SUB        RSP,0x28
  140001c14: 83 79 08 00               CMP        dword ptr [RCX + 0x8],0x0
  140001c18: 74 30                     JZ         0x140001c4a
  140001c1a: 48 c7 42 38 00 00 00 00   MOV        qword ptr [RDX + 0x38],0x0
  140001c22: 41 b9 48 00 00 00         MOV        R9D,0x48
  140001c28: 4c 8d 05 c1 1c 00 00      LEA        R8,[0x1400038f0]
  140001c2f: 48 8d 15 c2 1c 00 00      LEA        RDX,[0x1400038f8]
  140001c36: b9 01 00 00 00            MOV        ECX,0x1
  140001c3b: e8 50 f9 ff ff            CALL       0x140001590
  140001c40: b8 06 02 00 c0            MOV        EAX,0xc0000206
  140001c45: 48 83 c4 28               ADD        RSP,0x28
  140001c49: c3                        RET
  140001c4a: 83 79 10 0c               CMP        dword ptr [RCX + 0x10],0xc
  140001c4e: 74 10                     JZ         0x140001c60
  140001c50: 48 c7 42 38 0c 00 00 00   MOV        qword ptr [RDX + 0x38],0xc
  140001c58: 41 b9 4f 00 00 00         MOV        R9D,0x4f
  140001c5e: eb c8                     JMP        0x140001c28
  140001c60: 48 8b 52 18               MOV        RDX,qword ptr [RDX + 0x18]
  140001c64: 8b 0a                     MOV        ECX,dword ptr [RDX]
  140001c66: 8d 81 7f ff ff 3f         LEA        EAX,[RCX + 0x3fffff7f]
  140001c6c: 83 f8 02                  CMP        EAX,0x2
  140001c6f: 76 26                     JBE        0x140001c97
  140001c71: 8d 81 8c fe ff ff         LEA        EAX,[RCX + -0x174]
  140001c77: 83 f8 02                  CMP        EAX,0x2
  140001c7a: 76 1b                     JBE        0x140001c97
  140001c7c: 48 8b 52 04               MOV        RDX,qword ptr [RDX + 0x4]
  140001c80: 48 8b c2                  MOV        RAX,RDX
  140001c83: 48 c1 ea 20               SHR        RDX,0x20
  140001c87: 0f 30                     WRMSR
  140001c89: 33 c0                     XOR        EAX,EAX
  140001c8b: 48 83 c4 28               ADD        RSP,0x28
  140001c8f: c3                        RET
  140001c90: b8 01 00 00 c0            MOV        EAX,0xc0000001
  140001c95: eb 05                     JMP        0x140001c9c
  140001c97: b8 0d 00 00 c0            MOV        EAX,0xc000000d
  140001c9c: 48 83 c4 28               ADD        RSP,0x28
  140001ca0: c3                        RET
  140001ca1: cc                        INT3
  140001ca2: cc                        INT3
  140001ca3: cc                        INT3
  140001ca4: cc                        INT3
  140001ca5: cc                        INT3
  140001ca6: cc                        INT3
  140001ca7: cc                        INT3
  140001ca8: cc                        INT3
  140001ca9: cc                        INT3
  140001caa: cc                        INT3
  140001cab: cc                        INT3
  140001cac: cc                        INT3
  140001cad: cc                        INT3
  140001cae: cc                        INT3
  140001caf: cc                        INT3

sub_140001cb0:  ; 0x140001cb0
; arg:   param_1 (void *)
; arg:   param_2 (void *)
; stack: local_30 @ [stack-0x30] (undefined48)
  140001cb0: 48 83 ec 28               SUB        RSP,0x28
  140001cb4: 83 79 08 08               CMP        dword ptr [RCX + 0x8],0x8
  140001cb8: 74 30                     JZ         0x140001cea
  140001cba: 48 c7 42 38 08 00 00 00   MOV        qword ptr [RDX + 0x38],0x8
  140001cc2: 41 b9 68 00 00 00         MOV        R9D,0x68
  140001cc8: 4c 8d 05 21 1c 00 00      LEA        R8,[0x1400038f0]
  140001ccf: 48 8d 15 22 1c 00 00      LEA        RDX,[0x1400038f8]
  140001cd6: b9 01 00 00 00            MOV        ECX,0x1
  140001cdb: e8 b0 f8 ff ff            CALL       0x140001590
  140001ce0: b8 06 02 00 c0            MOV        EAX,0xc0000206
  140001ce5: 48 83 c4 28               ADD        RSP,0x28
  140001ce9: c3                        RET
  140001cea: 83 79 10 04               CMP        dword ptr [RCX + 0x10],0x4
  140001cee: 74 10                     JZ         0x140001d00
  140001cf0: 48 c7 42 38 04 00 00 00   MOV        qword ptr [RDX + 0x38],0x4
  140001cf8: 41 b9 6f 00 00 00         MOV        R9D,0x6f
  140001cfe: eb c8                     JMP        0x140001cc8
  140001d00: 4c 8b 42 18               MOV        R8,qword ptr [RDX + 0x18]
  140001d04: 41 8b 08                  MOV        ECX,dword ptr [R8]
  140001d07: 0f 32                     RDMSR
  140001d09: 48 c1 e2 20               SHL        RDX,0x20
  140001d0d: 48 0b c2                  OR         RAX,RDX
  140001d10: 49 89 00                  MOV        qword ptr [R8],RAX
  140001d13: 33 c0                     XOR        EAX,EAX
  140001d15: 48 83 c4 28               ADD        RSP,0x28
  140001d19: c3                        RET
  140001d1a: b8 01 00 00 c0            MOV        EAX,0xc0000001
  140001d1f: 48 83 c4 28               ADD        RSP,0x28
  140001d23: c3                        RET
  140001d24: cc                        INT3
  140001d25: cc                        INT3
  140001d26: cc                        INT3
  140001d27: cc                        INT3
  140001d28: cc                        INT3
  140001d29: cc                        INT3
  140001d2a: cc                        INT3
  140001d2b: cc                        INT3
  140001d2c: cc                        INT3
  140001d2d: cc                        INT3
  140001d2e: cc                        INT3
  140001d2f: cc                        INT3

sub_140001d30:  ; 0x140001d30
; arg:   param_1 (void *)
; arg:   param_2 (void *)
; arg:   param_3 (void *)
; stack: local_60 @ [stack-0x60] (undefined8)
; stack: local_58 @ [stack-0x58] (undefined32)
; stack: local_38 @ [stack-0x38] (unsigned long long)
; stack: local_30 @ [stack-0x30] (undefined8)
; stack: local_28 @ [stack-0x28] (undefined8)
; stack: local_20 @ [stack-0x20] (undefined8)
; stack: local_18 @ [stack-0x18] (undefined8)
; stack: local_10 @ [stack-0x10] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined8)
; stack: stack_18 @ [stack+0x18] (undefined16)
  140001d30: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  140001d35: 48 89 74 24 18            MOV        qword ptr [RSP + 0x18],RSI
  140001d3a: 57                        PUSH       RDI
  140001d3b: 41 54                     PUSH       R12
  140001d3d: 41 55                     PUSH       R13
  140001d3f: 41 56                     PUSH       R14
  140001d41: 41 57                     PUSH       R15
  140001d43: 48 83 ec 30               SUB        RSP,0x30
  140001d47: 49 8b d8                  MOV        RBX,R8
  140001d4a: 48 8b f2                  MOV        RSI,RDX
  140001d4d: 4c 8b e9                  MOV        R13,RCX
  140001d50: 8b 42 08                  MOV        EAX,dword ptr [RDX + 0x8]
  140001d53: 83 e8 04                  SUB        EAX,0x4
  140001d56: a9 fb ff ff ff            TEST       EAX,0xfffffffb
  140001d5b: 74 30                     JZ         0x140001d8d
  140001d5d: 49 c7 40 38 04 00 00 00   MOV        qword ptr [R8 + 0x38],0x4
  140001d65: 41 b9 92 00 00 00         MOV        R9D,0x92
  140001d6b: 4c 8d 05 7e 1b 00 00      LEA        R8,[0x1400038f0]
  140001d72: 48 8d 15 7f 1b 00 00      LEA        RDX,[0x1400038f8]
  140001d79: b9 01 00 00 00            MOV        ECX,0x1
  140001d7e: e8 0d f8 ff ff            CALL       0x140001590
  140001d83: b8 06 02 00 c0            MOV        EAX,0xc0000206
  140001d88: e9 4a 01 00 00            JMP        0x140001ed7
  140001d8d: 83 7a 10 0c               CMP        dword ptr [RDX + 0x10],0xc
  140001d91: 74 10                     JZ         0x140001da3
  140001d93: 49 c7 40 38 0c 00 00 00   MOV        qword ptr [R8 + 0x38],0xc
  140001d9b: 41 b9 99 00 00 00         MOV        R9D,0x99
  140001da1: eb c8                     JMP        0x140001d6b
  140001da3: 4d 8b 78 18               MOV        R15,qword ptr [R8 + 0x18]
  140001da7: 41 8b 57 08               MOV        EDX,dword ptr [R15 + 0x8]
  140001dab: 45 33 c0                  XOR        R8D,R8D
  140001dae: 49 8b 0f                  MOV        RCX,qword ptr [R15]
  140001db1: ff 15 d1 12 00 00         CALL       qword ptr [0x140003088]
  140001db7: 4c 8b e0                  MOV        R12,RAX
  140001dba: 48 85 c0                  TEST       RAX,RAX
  140001dbd: 75 0c                     JNZ        0x140001dcb
  140001dbf: 48 8d 15 52 1b 00 00      LEA        RDX,[0x140003918]
  140001dc6: e9 fd 00 00 00            JMP        0x140001ec8
  140001dcb: 33 ff                     XOR        EDI,EDI
  140001dcd: 48 89 7c 24 20            MOV        qword ptr [RSP + 0x20],RDI
  140001dd2: 45 33 c9                  XOR        R9D,R9D
  140001dd5: 45 33 c0                  XOR        R8D,R8D
  140001dd8: 41 8b 57 08               MOV        EDX,dword ptr [R15 + 0x8]
  140001ddc: 49 8b cc                  MOV        RCX,R12
  140001ddf: ff 15 9b 12 00 00         CALL       qword ptr [0x140003080]
  140001de5: 4c 8b f0                  MOV        R14,RAX
  140001de8: 48 85 c0                  TEST       RAX,RAX
  140001deb: 75 0c                     JNZ        0x140001df9
  140001ded: 48 8d 15 44 1b 00 00      LEA        RDX,[0x140003938]
  140001df4: e9 cf 00 00 00            JMP        0x140001ec8
  140001df9: 49 8b ce                  MOV        RCX,R14
  140001dfc: ff 15 76 12 00 00         CALL       qword ptr [0x140003078]
  140001e02: 90                        NOP
  140001e03: c7 44 24 28 10 00 00 00   MOV        dword ptr [RSP + 0x28],0x10
  140001e0b: 89 7c 24 20               MOV        dword ptr [RSP + 0x20],EDI
  140001e0f: 45 33 c9                  XOR        R9D,R9D
  140001e12: 45 33 c0                  XOR        R8D,R8D
  140001e15: b2 01                     MOV        DL,0x1
  140001e17: 49 8b ce                  MOV        RCX,R14
  140001e1a: ff 15 90 12 00 00         CALL       qword ptr [0x1400030b0]
  140001e20: 48 8b d0                  MOV        RDX,RAX
  140001e23: 48 89 44 24 68            MOV        qword ptr [RSP + 0x68],RAX
  140001e28: 8b 46 08                  MOV        EAX,dword ptr [RSI + 0x8]
  140001e2b: 83 f8 04                  CMP        EAX,0x4
  140001e2e: 75 09                     JNZ        0x140001e39
  140001e30: 48 8b 43 18               MOV        RAX,qword ptr [RBX + 0x18]
  140001e34: 89 10                     MOV        dword ptr [RAX],EDX
  140001e36: 8b 46 08                  MOV        EAX,dword ptr [RSI + 0x8]
  140001e39: 83 f8 08                  CMP        EAX,0x8
  140001e3c: 75 07                     JNZ        0x140001e45
  140001e3e: 48 8b 43 18               MOV        RAX,qword ptr [RBX + 0x18]
  140001e42: 48 89 10                  MOV        qword ptr [RAX],RDX
  140001e45: 48 8b cf                  MOV        RCX,RDI
  140001e48: 49 8d 45 30               LEA        RAX,[R13 + 0x30]
  140001e4c: 0f 1f 40 00               NOP        dword ptr [RAX]
  140001e50: 83 38 00                  CMP        dword ptr [RAX],0x0
  140001e53: 74 14                     JZ         0x140001e69
  140001e55: ff c7                     INC        EDI
  140001e57: 48 ff c1                  INC        RCX
  140001e5a: 48 83 c0 28               ADD        RAX,0x28
  140001e5e: 48 81 f9 00 01 00 00      CMP        RCX,0x100
  140001e65: 7c e9                     JL         0x140001e50
  140001e67: eb 2f                     JMP        0x140001e98
  140001e69: 48 63 c7                  MOVSXD     RAX,EDI
  140001e6c: 48 8d 0c 80               LEA        RCX,[RAX + RAX*0x4]
  140001e70: 48 8d 1c cd 00 00 00 00   LEA        RBX,[RCX*0x8]
  140001e78: 49 03 dd                  ADD        RBX,R13
  140001e7b: 41 8b 47 08               MOV        EAX,dword ptr [R15 + 0x8]
  140001e7f: 89 43 30                  MOV        dword ptr [RBX + 0x30],EAX
  140001e82: 4c 89 63 18               MOV        qword ptr [RBX + 0x18],R12
  140001e86: 48 89 53 20               MOV        qword ptr [RBX + 0x20],RDX
  140001e8a: 4c 89 73 28               MOV        qword ptr [RBX + 0x28],R14
  140001e8e: ff 15 04 12 00 00         CALL       qword ptr [0x140003098]
  140001e94: 48 89 43 38               MOV        qword ptr [RBX + 0x38],RAX
  140001e98: 81 ff 00 01 00 00         CMP        EDI,0x100
  140001e9e: 75 09                     JNZ        0x140001ea9
  140001ea0: 48 8d 15 e9 1a 00 00      LEA        RDX,[0x140003990]
  140001ea7: eb 1f                     JMP        0x140001ec8
  140001ea9: 33 c0                     XOR        EAX,EAX
  140001eab: eb 2a                     JMP        0x140001ed7
  140001ead: 44 8b c0                  MOV        R8D,EAX
  140001eb0: 48 8d 15 a1 1a 00 00      LEA        RDX,[0x140003958]
  140001eb7: b9 01 00 00 00            MOV        ECX,0x1
  140001ebc: e8 cf f6 ff ff            CALL       0x140001590
  140001ec1: b8 01 00 00 c0            MOV        EAX,0xc0000001
  140001ec6: eb 0f                     JMP        0x140001ed7
  140001ec8: b9 01 00 00 00            MOV        ECX,0x1
  140001ecd: e8 be f6 ff ff            CALL       0x140001590
  140001ed2: b8 01 00 00 c0            MOV        EAX,0xc0000001
  140001ed7: 48 8b 5c 24 60            MOV        RBX,qword ptr [RSP + 0x60]
  140001edc: 48 8b 74 24 70            MOV        RSI,qword ptr [RSP + 0x70]
  140001ee1: 48 83 c4 30               ADD        RSP,0x30
  140001ee5: 41 5f                     POP        R15
  140001ee7: 41 5e                     POP        R14
  140001ee9: 41 5d                     POP        R13
  140001eeb: 41 5c                     POP        R12
  140001eed: 5f                        POP        RDI
  140001eee: c3                        RET
  140001eef: cc                        INT3

sub_140001ef0:  ; 0x140001ef0
; arg:   param_1 (void *)
; arg:   param_2 (void *)
; stack: v15 @ [stack-0x30] (unsigned int[2])
; stack: local_70 @ [stack-0x70] (undefined8)
; stack: local_68 @ [stack-0x68] (undefined32)
; stack: local_48 @ [stack-0x48] (undefined8)
; stack: local_40 @ [stack-0x40] (undefined8)
; stack: local_38 @ [stack-0x38] (unsigned long long)
; stack: local_28 @ [stack-0x28] (undefined8)
; stack: local_20 @ [stack-0x20] (undefined8)
; stack: local_18 @ [stack-0x18] (undefined8)
; stack: local_10 @ [stack-0x10] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined8)
; stack: stack_18 @ [stack+0x18] (undefined16)
  140001ef0: 4c 8b dc                  MOV        R11,RSP
  140001ef3: 55                        PUSH       RBP
  140001ef4: 56                        PUSH       RSI
  140001ef5: 57                        PUSH       RDI
  140001ef6: 41 56                     PUSH       R14
  140001ef8: 48 83 ec 48               SUB        RSP,0x48
  140001efc: 48 8b aa b8 00 00 00      MOV        RBP,qword ptr [RDX + 0xb8]
  140001f03: 45 33 f6                  XOR        R14D,R14D
  140001f06: 4d 89 6b 18               MOV        qword ptr [R11 + 0x18],R13
  140001f0a: 48 8b f2                  MOV        RSI,RDX
  140001f0d: 4c 8b 69 40               MOV        R13,qword ptr [RCX + 0x40]
  140001f11: bf 01 00 00 c0            MOV        EDI,0xc0000001
  140001f16: 8b 45 18                  MOV        EAX,dword ptr [RBP + 0x18]
  140001f19: 05 d0 9b ff 7f            ADD        EAX,0x7fff9bd0
  140001f1e: 83 f8 74                  CMP        EAX,0x74
  140001f21: 0f 87 a9 05 00 00         JA         0x1400024d0
  140001f27: 49 89 5b 08               MOV        qword ptr [R11 + 0x8],RBX
  140001f2b: 48 8d 15 ce e0 ff ff      LEA        RDX,[0x140000000]
  140001f32: 4d 89 63 10               MOV        qword ptr [R11 + 0x10],R12
  140001f36: 4d 89 7b d8               MOV        qword ptr [R11 + -0x28],R15
  140001f3a: 0f b6 84 02 30 25 00 00   MOVZX      EAX,byte ptr [RDX + RAX*0x1 + 0x2530]
  140001f42: 8b 8c 82 00 25 00 00      MOV        ECX,dword ptr [RDX + RAX*0x4 + 0x2500]
  140001f49: 48 03 ca                  ADD        RCX,RDX
  140001f4c: ff e1                     JMP        RCX
  140001f4e: 83 7d 10 02               CMP        dword ptr [RBP + 0x10],0x2
  140001f52: 74 13                     JZ         0x140001f67
  140001f54: 48 c7 46 38 02 00 00 00   MOV        qword ptr [RSI + 0x38],0x2
  140001f5c: 41 b9 0a 00 00 00         MOV        R9D,0xa
  140001f62: e9 3d 05 00 00            JMP        0x1400024a4
  140001f67: 48 8b 46 18               MOV        RAX,qword ptr [RSI + 0x18]
  140001f6b: 0f b7 10                  MOVZX      EDX,word ptr [RAX]
  140001f6e: 0f b6 45 08               MOVZX      EAX,byte ptr [RBP + 0x8]
  140001f72: 3c 01                     CMP        AL,0x1
  140001f74: 74 38                     JZ         0x140001fae
  140001f76: 3c 02                     CMP        AL,0x2
  140001f78: 74 20                     JZ         0x140001f9a
  140001f7a: 3c 04                     CMP        AL,0x4
  140001f7c: 74 0b                     JZ         0x140001f89
  140001f7e: 41 b9 13 00 00 00         MOV        R9D,0x13
  140001f84: e9 1b 05 00 00            JMP        0x1400024a4
  140001f89: ed                        IN         EAX, DX
  140001f8a: 8b c8                     MOV        ECX,EAX
  140001f8c: 41 8b fe                  MOV        EDI,R14D
  140001f8f: 48 8b 46 18               MOV        RAX,qword ptr [RSI + 0x18]
  140001f93: 89 08                     MOV        dword ptr [RAX],ECX
  140001f95: e9 27 05 00 00            JMP        0x1400024c1
  140001f9a: 66 ed                     IN         AX, DX
  140001f9c: 0f b7 c8                  MOVZX      ECX,AX
  140001f9f: 41 8b fe                  MOV        EDI,R14D
  140001fa2: 48 8b 46 18               MOV        RAX,qword ptr [RSI + 0x18]
  140001fa6: 66 89 08                  MOV        word ptr [RAX],CX
  140001fa9: e9 13 05 00 00            JMP        0x1400024c1
  140001fae: ec                        IN         AL, DX
  140001faf: 0f b6 c8                  MOVZX      ECX,AL
  140001fb2: 41 8b fe                  MOV        EDI,R14D
  140001fb5: 48 8b 46 18               MOV        RAX,qword ptr [RSI + 0x18]
  140001fb9: 88 08                     MOV        byte ptr [RAX],CL
  140001fbb: e9 01 05 00 00            JMP        0x1400024c1
  140001fc0: 44 39 75 08               CMP        dword ptr [RBP + 0x8],R14D
  140001fc4: 74 0f                     JZ         0x140001fd5
  140001fc6: 4c 89 76 38               MOV        qword ptr [RSI + 0x38],R14
  140001fca: 41 b9 28 00 00 00         MOV        R9D,0x28
  140001fd0: e9 cf 04 00 00            JMP        0x1400024a4
  140001fd5: 44 0f b6 45 10            MOVZX      R8D,byte ptr [RBP + 0x10]
  140001fda: 41 8d 40 fb               LEA        EAX,[R8 + -0x5]
  140001fde: a8 fc                     TEST       AL,0xfc
  140001fe0: 75 3e                     JNZ        0x140002020
  140001fe2: 41 80 f8 07               CMP        R8B,0x7
  140001fe6: 74 38                     JZ         0x140002020
  140001fe8: 48 8b 4e 18               MOV        RCX,qword ptr [RSI + 0x18]
  140001fec: 41 80 f8 05               CMP        R8B,0x5
  140001ff0: 75 0a                     JNZ        0x140001ffc
  140001ff2: 0f b7 11                  MOVZX      EDX,word ptr [RCX]
  140001ff5: 0f b6 41 04               MOVZX      EAX,byte ptr [RCX + 0x4]
  140001ff9: ee                        OUT        DX,AL
  140001ffa: eb 0f                     JMP        0x14000200b
  140001ffc: 41 80 f8 06               CMP        R8B,0x6
  140002000: 75 09                     JNZ        0x14000200b
  140002002: 0f b7 11                  MOVZX      EDX,word ptr [RCX]
  140002005: 0f b7 41 04               MOVZX      EAX,word ptr [RCX + 0x4]
  140002009: 66 ef                     OUT        DX,AX
  14000200b: 41 80 f8 08               CMP        R8B,0x8
  14000200f: 75 07                     JNZ        0x140002018
  140002011: 0f b7 11                  MOVZX      EDX,word ptr [RCX]
  140002014: 8b 41 04                  MOV        EAX,dword ptr [RCX + 0x4]
  140002017: ef                        OUT        DX,EAX
  140002018: 41 8b fe                  MOV        EDI,R14D
  14000201b: e9 a1 04 00 00            JMP        0x1400024c1
  140002020: 41 b9 2f 00 00 00         MOV        R9D,0x2f
  140002026: e9 79 04 00 00            JMP        0x1400024a4
  14000202b: 48 8b d6                  MOV        RDX,RSI
  14000202e: 48 8b cd                  MOV        RCX,RBP
  140002031: e8 7a fc ff ff            CALL       0x140001cb0
  140002036: 8b f8                     MOV        EDI,EAX
  140002038: e9 84 04 00 00            JMP        0x1400024c1
  14000203d: 48 8b d6                  MOV        RDX,RSI
  140002040: 48 8b cd                  MOV        RCX,RBP
  140002043: e8 c8 fb ff ff            CALL       0x140001c10
  140002048: 8b f8                     MOV        EDI,EAX
  14000204a: e9 72 04 00 00            JMP        0x1400024c1
  14000204f: 4c 8b c6                  MOV        R8,RSI
  140002052: 48 8b d5                  MOV        RDX,RBP
  140002055: 49 8b cd                  MOV        RCX,R13
  140002058: e8 d3 fc ff ff            CALL       0x140001d30
  14000205d: 8b f8                     MOV        EDI,EAX
  14000205f: e9 5d 04 00 00            JMP        0x1400024c1
  140002064: 44 39 75 08               CMP        dword ptr [RBP + 0x8],R14D
  140002068: 74 0b                     JZ         0x140002075
  14000206a: 41 b9 ee 00 00 00         MOV        R9D,0xee
  140002070: e9 2f 04 00 00            JMP        0x1400024a4
  140002075: 8b 45 10                  MOV        EAX,dword ptr [RBP + 0x10]
  140002078: 83 f8 04                  CMP        EAX,0x4
  14000207b: 74 19                     JZ         0x140002096
  14000207d: 83 f8 08                  CMP        EAX,0x8
  140002080: 74 0b                     JZ         0x14000208d
  140002082: 41 b9 f4 00 00 00         MOV        R9D,0xf4
  140002088: e9 17 04 00 00            JMP        0x1400024a4
  14000208d: 48 8b 46 18               MOV        RAX,qword ptr [RSI + 0x18]
  140002091: 4c 8b 20                  MOV        R12,qword ptr [RAX]
  140002094: eb 07                     JMP        0x14000209d
  140002096: 48 8b 46 18               MOV        RAX,qword ptr [RSI + 0x18]
  14000209a: 44 8b 20                  MOV        R12D,dword ptr [RAX]
  14000209d: 45 8b fe                  MOV        R15D,R14D
  1400020a0: 49 8d 5d 20               LEA        RBX,[R13 + 0x20]
  1400020a4: 49 8b fe                  MOV        RDI,R14
  1400020a7: 44 39 73 10               CMP        dword ptr [RBX + 0x10],R14D
  1400020ab: 74 11                     JZ         0x1400020be
  1400020ad: 4c 39 23                  CMP        qword ptr [RBX],R12
  1400020b0: 75 0c                     JNZ        0x1400020be
  1400020b2: ff 15 e0 0f 00 00         CALL       qword ptr [0x140003098]
  1400020b8: 48 39 43 18               CMP        qword ptr [RBX + 0x18],RAX
  1400020bc: 74 13                     JZ         0x1400020d1
  1400020be: 41 ff c7                  INC        R15D
  1400020c1: 48 ff c7                  INC        RDI
  1400020c4: 48 83 c3 28               ADD        RBX,0x28
  1400020c8: 48 81 ff 00 01 00 00      CMP        RDI,0x100
  1400020cf: 7c d6                     JL         0x1400020a7
  1400020d1: 41 81 ff 00 01 00 00      CMP        R15D,0x100
  1400020d8: 75 0a                     JNZ        0x1400020e4
  1400020da: bf 0d 00 00 c0            MOV        EDI,0xc000000d
  1400020df: e9 dd 03 00 00            JMP        0x1400024c1
  1400020e4: 49 63 c7                  MOVSXD     RAX,R15D
  1400020e7: 48 8d 0c 80               LEA        RCX,[RAX + RAX*0x4]
  1400020eb: 48 8d 1c cd 00 00 00 00   LEA        RBX,[RCX*0x8]
  1400020f3: 49 03 dd                  ADD        RBX,R13
  1400020f6: 48 8b 53 28               MOV        RDX,qword ptr [RBX + 0x28]
  1400020fa: 48 8b 4b 20               MOV        RCX,qword ptr [RBX + 0x20]
  1400020fe: ff 15 a4 0f 00 00         CALL       qword ptr [0x1400030a8]
  140002104: 8b 53 30                  MOV        EDX,dword ptr [RBX + 0x30]
  140002107: 48 8b 4b 18               MOV        RCX,qword ptr [RBX + 0x18]
  14000210b: ff 15 7f 0f 00 00         CALL       qword ptr [0x140003090]
  140002111: 48 8b 4b 28               MOV        RCX,qword ptr [RBX + 0x28]
  140002115: ff 15 85 0f 00 00         CALL       qword ptr [0x1400030a0]
  14000211b: 44 89 73 30               MOV        dword ptr [RBX + 0x30],R14D
  14000211f: 41 8b fe                  MOV        EDI,R14D
  140002122: e9 9a 03 00 00            JMP        0x1400024c1
  140002127: 44 39 75 10               CMP        dword ptr [RBP + 0x10],R14D
  14000212b: 74 0f                     JZ         0x14000213c
  14000212d: 4c 89 76 38               MOV        qword ptr [RSI + 0x38],R14
  140002131: 41 b9 20 01 00 00         MOV        R9D,0x120
  140002137: e9 68 03 00 00            JMP        0x1400024a4
  14000213c: 83 7d 08 04               CMP        dword ptr [RBP + 0x8],0x4
  140002140: 74 30                     JZ         0x140002172
  140002142: 41 b9 27 01 00 00         MOV        R9D,0x127
  140002148: 48 c7 46 38 04 00 00 00   MOV        qword ptr [RSI + 0x38],0x4
  140002150: 4c 8d 05 99 17 00 00      LEA        R8,[0x1400038f0]
  140002157: b9 01 00 00 00            MOV        ECX,0x1
  14000215c: 48 8d 15 95 17 00 00      LEA        RDX,[0x1400038f8]
  140002163: e8 28 f4 ff ff            CALL       0x140001590
  140002168: bf 0d 00 00 c0            MOV        EDI,0xc000000d
  14000216d: e9 4f 03 00 00            JMP        0x1400024c1
  140002172: 48 8b 4e 18               MOV        RCX,qword ptr [RSI + 0x18]
  140002176: 41 8b fe                  MOV        EDI,R14D
  140002179: 41 8b 45 08               MOV        EAX,dword ptr [R13 + 0x8]
  14000217d: 89 01                     MOV        dword ptr [RCX],EAX
  14000217f: e9 3d 03 00 00            JMP        0x1400024c1
  140002184: 83 7d 10 08               CMP        dword ptr [RBP + 0x10],0x8
  140002188: 74 13                     JZ         0x14000219d
  14000218a: 48 c7 46 38 08 00 00 00   MOV        qword ptr [RSI + 0x38],0x8
  140002192: 41 b9 35 01 00 00         MOV        R9D,0x135
  140002198: e9 07 03 00 00            JMP        0x1400024a4
  14000219d: 0f b6 5d 08               MOVZX      EBX,byte ptr [RBP + 0x8]
  1400021a1: 48 8b 4e 18               MOV        RCX,qword ptr [RSI + 0x18]
  1400021a5: 80 fb 08                  CMP        BL,0x8
  1400021a8: 0f 87 bd 00 00 00         JA         0x14000226b
  1400021ae: ba 16 01 00 00            MOV        EDX,0x116
  1400021b3: 0f a3 da                  BT         EDX,EBX
  1400021b6: 0f 83 af 00 00 00         JNC        0x14000226b
  1400021bc: 48 8b 09                  MOV        RCX,qword ptr [RCX]
  1400021bf: 45 33 c0                  XOR        R8D,R8D
  1400021c2: 44 0f b6 fb               MOVZX      R15D,BL
  1400021c6: 41 8b d7                  MOV        EDX,R15D
  1400021c9: ff 15 b9 0e 00 00         CALL       qword ptr [0x140003088]
  1400021cf: 4c 8b c0                  MOV        R8,RAX
  1400021d2: 48 85 c0                  TEST       RAX,RAX
  1400021d5: 75 0b                     JNZ        0x1400021e2
  1400021d7: 41 b9 45 01 00 00         MOV        R9D,0x145
  1400021dd: e9 ec 00 00 00            JMP        0x1400022ce
  1400021e2: 80 fb 01                  CMP        BL,0x1
  1400021e5: 75 1d                     JNZ        0x140002204
  1400021e7: 48 8b 4e 18               MOV        RCX,qword ptr [RSI + 0x18]
  1400021eb: 49 8b d7                  MOV        RDX,R15
  1400021ee: 0f b6 00                  MOVZX      EAX,byte ptr [RAX]
  1400021f1: 88 01                     MOV        byte ptr [RCX],AL
  1400021f3: 49 8b c8                  MOV        RCX,R8
  1400021f6: ff 15 94 0e 00 00         CALL       qword ptr [0x140003090]
  1400021fc: 41 8b fe                  MOV        EDI,R14D
  1400021ff: e9 bd 02 00 00            JMP        0x1400024c1
  140002204: 80 fb 02                  CMP        BL,0x2
  140002207: 75 1e                     JNZ        0x140002227
  140002209: 48 8b 4e 18               MOV        RCX,qword ptr [RSI + 0x18]
  14000220d: 49 8b d7                  MOV        RDX,R15
  140002210: 0f b7 00                  MOVZX      EAX,word ptr [RAX]
  140002213: 66 89 01                  MOV        word ptr [RCX],AX
  140002216: 49 8b c8                  MOV        RCX,R8
  140002219: ff 15 71 0e 00 00         CALL       qword ptr [0x140003090]
  14000221f: 41 8b fe                  MOV        EDI,R14D
  140002222: e9 9a 02 00 00            JMP        0x1400024c1
  140002227: 80 fb 04                  CMP        BL,0x4
  14000222a: 75 1c                     JNZ        0x140002248
  14000222c: 48 8b 4e 18               MOV        RCX,qword ptr [RSI + 0x18]
  140002230: 49 8b d7                  MOV        RDX,R15
  140002233: 8b 00                     MOV        EAX,dword ptr [RAX]
  140002235: 89 01                     MOV        dword ptr [RCX],EAX
  140002237: 49 8b c8                  MOV        RCX,R8
  14000223a: ff 15 50 0e 00 00         CALL       qword ptr [0x140003090]
  140002240: 41 8b fe                  MOV        EDI,R14D
  140002243: e9 79 02 00 00            JMP        0x1400024c1
  140002248: 80 fb 08                  CMP        BL,0x8
  14000224b: 75 0a                     JNZ        0x140002257
  14000224d: 48 8b 4e 18               MOV        RCX,qword ptr [RSI + 0x18]
  140002251: 48 8b 00                  MOV        RAX,qword ptr [RAX]
  140002254: 48 89 01                  MOV        qword ptr [RCX],RAX
  140002257: 49 8b d7                  MOV        RDX,R15
  14000225a: 49 8b c8                  MOV        RCX,R8
  14000225d: ff 15 2d 0e 00 00         CALL       qword ptr [0x140003090]
  140002263: 41 8b fe                  MOV        EDI,R14D
  140002266: e9 56 02 00 00            JMP        0x1400024c1
  14000226b: 41 b9 3e 01 00 00         MOV        R9D,0x13e
  140002271: e9 2e 02 00 00            JMP        0x1400024a4
  140002276: 44 39 75 08               CMP        dword ptr [RBP + 0x8],R14D
  14000227a: 74 0f                     JZ         0x14000228b
  14000227c: 4c 89 76 38               MOV        qword ptr [RSI + 0x38],R14
  140002280: 41 b9 5f 01 00 00         MOV        R9D,0x15f
  140002286: e9 19 02 00 00            JMP        0x1400024a4
  14000228b: 0f b6 5d 10               MOVZX      EBX,byte ptr [RBP + 0x10]
  14000228f: 80 eb 08                  SUB        BL,0x8
  140002292: 80 fb 08                  CMP        BL,0x8
  140002295: 0f 87 c4 00 00 00         JA         0x14000235f
  14000229b: ba 16 01 00 00            MOV        EDX,0x116
  1400022a0: 0f a3 da                  BT         EDX,EBX
  1400022a3: 0f 83 b6 00 00 00         JNC        0x14000235f
  1400022a9: 4c 8b 7e 18               MOV        R15,qword ptr [RSI + 0x18]
  1400022ad: 45 33 c0                  XOR        R8D,R8D
  1400022b0: 44 0f b6 e3               MOVZX      R12D,BL
  1400022b4: 41 8b d4                  MOV        EDX,R12D
  1400022b7: 49 8b 0f                  MOV        RCX,qword ptr [R15]
  1400022ba: ff 15 c8 0d 00 00         CALL       qword ptr [0x140003088]
  1400022c0: 48 8b c8                  MOV        RCX,RAX
  1400022c3: 48 85 c0                  TEST       RAX,RAX
  1400022c6: 75 23                     JNZ        0x1400022eb
  1400022c8: 41 b9 72 01 00 00         MOV        R9D,0x172
  1400022ce: 4c 8d 05 1b 16 00 00      LEA        R8,[0x1400038f0]
  1400022d5: b9 01 00 00 00            MOV        ECX,0x1
  1400022da: 48 8d 15 df 16 00 00      LEA        RDX,[0x1400039c0]
  1400022e1: e8 aa f2 ff ff            CALL       0x140001590
  1400022e6: e9 d6 01 00 00            JMP        0x1400024c1
  1400022eb: 80 fb 01                  CMP        BL,0x1
  1400022ee: 75 18                     JNZ        0x140002308
  1400022f0: 41 0f b6 47 08            MOVZX      EAX,byte ptr [R15 + 0x8]
  1400022f5: 49 8b d4                  MOV        RDX,R12
  1400022f8: 88 01                     MOV        byte ptr [RCX],AL
  1400022fa: ff 15 90 0d 00 00         CALL       qword ptr [0x140003090]
  140002300: 41 8b fe                  MOV        EDI,R14D
  140002303: e9 b9 01 00 00            JMP        0x1400024c1
  140002308: 80 fb 02                  CMP        BL,0x2
  14000230b: 75 19                     JNZ        0x140002326
  14000230d: 41 0f b7 47 08            MOVZX      EAX,word ptr [R15 + 0x8]
  140002312: 49 8b d4                  MOV        RDX,R12
  140002315: 66 89 01                  MOV        word ptr [RCX],AX
  140002318: ff 15 72 0d 00 00         CALL       qword ptr [0x140003090]
  14000231e: 41 8b fe                  MOV        EDI,R14D
  140002321: e9 9b 01 00 00            JMP        0x1400024c1
  140002326: 80 fb 04                  CMP        BL,0x4
  140002329: 75 17                     JNZ        0x140002342
  14000232b: 41 8b 47 08               MOV        EAX,dword ptr [R15 + 0x8]
  14000232f: 49 8b d4                  MOV        RDX,R12
  140002332: 89 01                     MOV        dword ptr [RCX],EAX
  140002334: ff 15 56 0d 00 00         CALL       qword ptr [0x140003090]
  14000233a: 41 8b fe                  MOV        EDI,R14D
  14000233d: e9 7f 01 00 00            JMP        0x1400024c1
  140002342: 80 fb 08                  CMP        BL,0x8
  140002345: 75 07                     JNZ        0x14000234e
  140002347: 49 8b 47 08               MOV        RAX,qword ptr [R15 + 0x8]
  14000234b: 48 89 01                  MOV        qword ptr [RCX],RAX
  14000234e: 49 8b d4                  MOV        RDX,R12
  140002351: ff 15 39 0d 00 00         CALL       qword ptr [0x140003090]
  140002357: 41 8b fe                  MOV        EDI,R14D
  14000235a: e9 62 01 00 00            JMP        0x1400024c1
  14000235f: 41 b9 66 01 00 00         MOV        R9D,0x166
  140002365: e9 3a 01 00 00            JMP        0x1400024a4
  14000236a: 83 7d 10 08               CMP        dword ptr [RBP + 0x10],0x8
  14000236e: 74 13                     JZ         0x140002383
  140002370: 48 c7 46 38 08 00 00 00   MOV        qword ptr [RSI + 0x38],0x8
  140002378: 41 b9 8c 01 00 00         MOV        R9D,0x18c
  14000237e: e9 21 01 00 00            JMP        0x1400024a4
  140002383: 0f b6 5d 08               MOVZX      EBX,byte ptr [RBP + 0x8]
  140002387: 84 db                     TEST       BL,BL
  140002389: 75 0b                     JNZ        0x140002396
  14000238b: 41 b9 93 01 00 00         MOV        R9D,0x193
  140002391: e9 0e 01 00 00            JMP        0x1400024a4
  140002396: 4c 8b 4e 18               MOV        R9,qword ptr [RSI + 0x18]
  14000239a: 44 0f b6 fb               MOVZX      R15D,BL
  14000239e: 44 89 7c 24 28            MOV        dword ptr [RSP + 0x28],R15D
  1400023a3: 49 8b 09                  MOV        RCX,qword ptr [R9]
  1400023a6: 4c 8b c1                  MOV        R8,RCX
  1400023a9: 0f b6 d1                  MOVZX      EDX,CL
  1400023ac: 49 c1 e8 10               SHR        R8,0x10
  1400023b0: 48 8b c1                  MOV        RAX,RCX
  1400023b3: 41 83 e0 07               AND        R8D,0x7
  1400023b7: 48 c1 e8 08               SHR        RAX,0x8
  1400023bb: 4c 8b d1                  MOV        R10,RCX
  1400023be: 41 c1 e0 05               SHL        R8D,0x5
  1400023c2: 83 e0 1f                  AND        EAX,0x1f
  1400023c5: 49 c1 ea 20               SHR        R10,0x20
  1400023c9: 44 0b c0                  OR         R8D,EAX
  1400023cc: 44 89 54 24 20            MOV        dword ptr [RSP + 0x20],R10D
  1400023d1: b9 04 00 00 00            MOV        ECX,0x4
  1400023d6: ff 15 2c 0c 00 00         CALL       qword ptr [0x140003008]
  1400023dc: 8b c8                     MOV        ECX,EAX
  1400023de: 85 c0                     TEST       EAX,EAX
  1400023e0: 75 0a                     JNZ        0x1400023ec
  1400023e2: bf 25 02 00 c0            MOV        EDI,0xc0000225
  1400023e7: e9 d5 00 00 00            JMP        0x1400024c1
  1400023ec: 80 fb 02                  CMP        BL,0x2
  1400023ef: 74 0f                     JZ         0x140002400
  1400023f1: 83 f9 02                  CMP        ECX,0x2
  1400023f4: 75 0a                     JNZ        0x140002400
  1400023f6: bf c0 00 00 c0            MOV        EDI,0xc00000c0
  1400023fb: e9 c1 00 00 00            JMP        0x1400024c1
  140002400: 44 3b f9                  CMP        R15D,ECX
  140002403: 41 8b c6                  MOV        EAX,R14D
  140002406: 0f 45 c7                  CMOVNZ     EAX,EDI
  140002409: 8b f8                     MOV        EDI,EAX
  14000240b: e9 b1 00 00 00            JMP        0x1400024c1
  140002410: 44 39 75 08               CMP        dword ptr [RBP + 0x8],R14D
  140002414: 74 0f                     JZ         0x140002425
  140002416: 4c 89 76 38               MOV        qword ptr [RSI + 0x38],R14
  14000241a: 41 b9 b2 01 00 00         MOV        R9D,0x1b2
  140002420: e9 7f 00 00 00            JMP        0x1400024a4
  140002425: 0f b6 55 10               MOVZX      EDX,byte ptr [RBP + 0x10]
  140002429: 80 ea 08                  SUB        DL,0x8
  14000242c: 8d 42 ff                  LEA        EAX,[RDX + -0x1]
  14000242f: a8 fc                     TEST       AL,0xfc
  140002431: 75 6b                     JNZ        0x14000249e
  140002433: 80 fa 03                  CMP        DL,0x3
  140002436: 74 66                     JZ         0x14000249e
  140002438: 48 8b 46 18               MOV        RAX,qword ptr [RSI + 0x18]
  14000243c: 4c 8d 4c 24 38            LEA        R9,[RSP + 0x38]
  140002441: 0f b6 da                  MOVZX      EBX,DL
  140002444: 89 5c 24 28               MOV        dword ptr [RSP + 0x28],EBX
  140002448: f2 0f 10 00               MOVSD      XMM0, qword ptr [RAX]
  14000244c: f2 0f 11 44 24 30         MOVSD      qword ptr [RSP + 0x30], XMM0
  140002452: 8b 40 08                  MOV        EAX,dword ptr [RAX + 0x8]
  140002455: 48 8b 4c 24 30            MOV        RCX,qword ptr [RSP + 0x30]
  14000245a: 0f b6 54 24 30            MOVZX      EDX,byte ptr [RSP + 0x30]
  14000245f: 4c 8b c1                  MOV        R8,RCX
  140002462: 89 44 24 38               MOV        dword ptr [RSP + 0x38],EAX
  140002466: 48 8b c1                  MOV        RAX,RCX
  140002469: 49 c1 e8 10               SHR        R8,0x10
  14000246d: 41 83 e0 07               AND        R8D,0x7
  140002471: 48 c1 e9 20               SHR        RCX,0x20
  140002475: 48 c1 e8 08               SHR        RAX,0x8
  140002479: 41 c1 e0 05               SHL        R8D,0x5
  14000247d: 83 e0 1f                  AND        EAX,0x1f
  140002480: 89 4c 24 20               MOV        dword ptr [RSP + 0x20],ECX
  140002484: 44 0b c0                  OR         R8D,EAX
  140002487: b9 04 00 00 00            MOV        ECX,0x4
  14000248c: ff 15 6e 0b 00 00         CALL       qword ptr [0x140003000]
  140002492: 3b c3                     CMP        EAX,EBX
  140002494: 41 8b ce                  MOV        ECX,R14D
  140002497: 0f 45 cf                  CMOVNZ     ECX,EDI
  14000249a: 8b f9                     MOV        EDI,ECX
  14000249c: eb 23                     JMP        0x1400024c1
  14000249e: 41 b9 b9 01 00 00         MOV        R9D,0x1b9
  1400024a4: 4c 8d 05 45 14 00 00      LEA        R8,[0x1400038f0]
  1400024ab: b9 01 00 00 00            MOV        ECX,0x1
  1400024b0: 48 8d 15 41 14 00 00      LEA        RDX,[0x1400038f8]
  1400024b7: e8 d4 f0 ff ff            CALL       0x140001590
  1400024bc: bf 06 02 00 c0            MOV        EDI,0xc0000206
  1400024c1: 4c 8b 64 24 78            MOV        R12,qword ptr [RSP + 0x78]
  1400024c6: 48 8b 5c 24 70            MOV        RBX,qword ptr [RSP + 0x70]
  1400024cb: 4c 8b 7c 24 40            MOV        R15,qword ptr [RSP + 0x40]
  1400024d0: 4c 8b ac 24 80 00 00 00   MOV        R13,qword ptr [RSP + 0x80]
  1400024d8: 89 7e 30                  MOV        dword ptr [RSI + 0x30],EDI
  1400024db: 85 ff                     TEST       EDI,EDI
  1400024dd: 75 04                     JNZ        0x1400024e3
  1400024df: 44 8b 75 08               MOV        R14D,dword ptr [RBP + 0x8]
  1400024e3: 33 d2                     XOR        EDX,EDX
  1400024e5: 4c 89 76 38               MOV        qword ptr [RSI + 0x38],R14
  1400024e9: 48 8b ce                  MOV        RCX,RSI
  1400024ec: ff 15 66 0b 00 00         CALL       qword ptr [0x140003058]
  1400024f2: 8b c7                     MOV        EAX,EDI
  1400024f4: 48 83 c4 48               ADD        RSP,0x48
  1400024f8: 41 5e                     POP        R14
  1400024fa: 5f                        POP        RDI
  1400024fb: 5e                        POP        RSI
  1400024fc: 5d                        POP        RBP
  1400024fd: c3                        RET
  1400024fe: 66 90                     NOP
  140002500: db 0x4e, 0x1f
  140002502: 00 00                     ADD        byte ptr [RAX],AL
  140002504: c0 1f 00                  RCR        byte ptr [RDI],0x0
  140002507: 00 2b                     ADD        byte ptr [RBX],CH
  140002509: 20 00                     AND        byte ptr [RAX],AL
  14000250b: 00 3d 20 00 00 4f         ADD        byte ptr [0x18f002531],BH
  140002511: 20 00                     AND        byte ptr [RAX],AL
  140002513: 00 64 20 00               ADD        byte ptr [RAX + 0x0],AH
  140002517: 00 27                     ADD        byte ptr [RDI],AH
  140002519: 21 00                     AND        dword ptr [RAX],EAX
  14000251b: 00 84 21 00 00 76 22      ADD        byte ptr [RCX + 0x22760000],AL
  140002522: 00 00                     ADD        byte ptr [RAX],AL
  140002524: 6a 23                     PUSH       0x23
  140002526: 00 00                     ADD        byte ptr [RAX],AL
  140002528: 10 24 00                  ADC        byte ptr [RAX + RAX*0x1],AH
  14000252b: 00 c1                     ADD        CL,AL
  14000252d: 24 00                     AND        AL,0x0
  14000252f: 00 00                     ADD        byte ptr [RAX],AL
  140002531: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002533: 0b 01                     OR         EAX,dword ptr [RCX]
  140002535: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002537: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002539: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000253b: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000253d: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000253f: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002541: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002543: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002545: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002547: 0b 02                     OR         EAX,dword ptr [RDX]
  140002549: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000254b: 0b 03                     OR         EAX,dword ptr [RBX]
  14000254d: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000254f: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002551: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002553: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002555: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002557: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002559: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000255b: 0b 04 0b                  OR         EAX,dword ptr [RBX + RCX*0x1]
  14000255e: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002560: 05 0b 0b 0b 0b            ADD        EAX,0xb0b0b0b
  140002565: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002567: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002569: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000256b: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000256d: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000256f: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002571: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002573: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002575: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002577: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002579: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000257b: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000257d: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000257f: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002581: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002583: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002585: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002587: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002589: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000258b: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000258d: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000258f: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002591: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002593: 0b 06                     OR         EAX,dword ptr [RSI]
  140002595: 0b 0b                     OR         ECX,dword ptr [RBX]
  140002597: 0b 07                     OR         EAX,dword ptr [RDI]
  140002599: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000259b: 0b 08                     OR         ECX,dword ptr [RAX]
  14000259d: 0b 0b                     OR         ECX,dword ptr [RBX]
  14000259f: 0b 09                     OR         ECX,dword ptr [RCX]
  1400025a1: 0b 0b                     OR         ECX,dword ptr [RBX]
  1400025a3: 0b 0a                     OR         ECX,dword ptr [RDX]

__C_specific_handler:  ; 0x1400025a5
  1400025a5: ff 25 c5 0a 00 00         JMP        qword ptr [0x140003070]

_snwprintf:  ; 0x1400025ab
  1400025ab: ff 25 57 0b 00 00         JMP        qword ptr [0x140003108]

wcschr:  ; 0x1400025b1
  1400025b1: ff 25 91 0b 00 00         JMP        qword ptr [0x140003148]

_wcsnicmp:  ; 0x1400025b7
  1400025b7: ff 25 93 0b 00 00         JMP        qword ptr [0x140003150]

; --- code section 0x140008000..0x140009987 ---

sub_140008000:  ; 0x140008000
; stack: v1 @ [stack-0x18] (char[24])
; stack: local_40 @ [stack-0x40] (undefined40)
  140008000: 48 83 ec 38               SUB        RSP,0x38
  140008004: 48 8d 15 b5 b1 ff ff      LEA        RDX,[0x1400031c0]
  14000800b: 48 8d 4c 24 20            LEA        RCX,[RSP + 0x20]
  140008010: ff 15 02 b0 ff ff         CALL       qword ptr [0x140003018]
  140008016: 48 8d 4c 24 20            LEA        RCX,[RSP + 0x20]
  14000801b: ff 15 b7 b0 ff ff         CALL       qword ptr [0x1400030d8]
  140008021: 48 8d 0d 74 01 00 00      LEA        RCX,[0x14000819c]
  140008028: 48 8d 15 c1 b1 ff ff      LEA        RDX,[0x1400031f0]
  14000802f: 48 85 c0                  TEST       RAX,RAX
  140008032: 48 0f 44 c1               CMOVZ      RAX,RCX
  140008036: 48 8d 4c 24 20            LEA        RCX,[RSP + 0x20]
  14000803b: 48 89 05 a6 c1 ff ff      MOV        qword ptr [0x1400041e8],RAX
  140008042: ff 15 d0 af ff ff         CALL       qword ptr [0x140003018]
  140008048: 48 8d 4c 24 20            LEA        RCX,[RSP + 0x20]
  14000804d: ff 15 85 b0 ff ff         CALL       qword ptr [0x1400030d8]
  140008053: c6 05 86 c1 ff ff 01      MOV        byte ptr [0x1400041e0],0x1
  14000805a: 48 89 05 8f c1 ff ff      MOV        qword ptr [0x1400041f0],RAX
  140008061: 48 83 c4 38               ADD        RSP,0x38
  140008065: c3                        RET
  140008066: cc                        INT3
  140008067: cc                        INT3

sub_140008068:  ; 0x140008068
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned int)
; arg:   param_3 (unsigned long long)
; arg:   param_4 (unsigned int)
; arg:   param_5 (unsigned int)
; arg:   param_6 (undefined1)
; arg:   param_7 (unsigned long long)
; arg:   param_8 (unsigned long long)
; arg:   param_9 (unsigned long long)
; stack: local_60 @ [stack-0x60] (undefined8)
; stack: local_58 @ [stack-0x58] (undefined80)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined8)
; stack: stack_18 @ [stack+0x18] (undefined16)
  140008068: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  14000806d: 48 89 6c 24 10            MOV        qword ptr [RSP + 0x10],RBP
  140008072: 48 89 74 24 18            MOV        qword ptr [RSP + 0x18],RSI
  140008077: 57                        PUSH       RDI
  140008078: 48 83 ec 50               SUB        RSP,0x50
  14000807c: 80 3d 5d c1 ff ff 00      CMP        byte ptr [0x1400041e0],0x0
  140008083: 41 8b d9                  MOV        EBX,R9D
  140008086: 49 8b f8                  MOV        RDI,R8
  140008089: 8b f2                     MOV        ESI,EDX
  14000808b: 48 8b e9                  MOV        RBP,RCX
  14000808e: 75 05                     JNZ        0x140008095
  140008090: e8 6b ff ff ff            CALL       0x140008000
  140008095: 48 8b 84 24 a0 00 00 00   MOV        RAX,qword ptr [RSP + 0xa0]
  14000809d: 44 8b cb                  MOV        R9D,EBX
  1400080a0: 4c 8b c7                  MOV        R8,RDI
  1400080a3: 48 89 44 24 40            MOV        qword ptr [RSP + 0x40],RAX
  1400080a8: 48 8b 84 24 98 00 00 00   MOV        RAX,qword ptr [RSP + 0x98]
  1400080b0: 8b d6                     MOV        EDX,ESI
  1400080b2: 48 89 44 24 38            MOV        qword ptr [RSP + 0x38],RAX
  1400080b7: 48 8b 84 24 90 00 00 00   MOV        RAX,qword ptr [RSP + 0x90]
  1400080bf: 48 8b cd                  MOV        RCX,RBP
  1400080c2: 48 89 44 24 30            MOV        qword ptr [RSP + 0x30],RAX
  1400080c7: 8a 84 24 88 00 00 00      MOV        AL,byte ptr [RSP + 0x88]
  1400080ce: 88 44 24 28               MOV        byte ptr [RSP + 0x28],AL
  1400080d2: 8b 84 24 80 00 00 00      MOV        EAX,dword ptr [RSP + 0x80]
  1400080d9: 89 44 24 20               MOV        dword ptr [RSP + 0x20],EAX
  1400080dd: ff 15 05 c1 ff ff         CALL       qword ptr [0x1400041e8]
  1400080e3: 48 8b 5c 24 60            MOV        RBX,qword ptr [RSP + 0x60]
  1400080e8: 48 8b 6c 24 68            MOV        RBP,qword ptr [RSP + 0x68]
  1400080ed: 48 8b 74 24 70            MOV        RSI,qword ptr [RSP + 0x70]
  1400080f2: 48 83 c4 50               ADD        RSP,0x50
  1400080f6: 5f                        POP        RDI
  1400080f7: c3                        RET

sub_1400080f8:  ; 0x1400080f8
; arg:   param_1 (unsigned long long)
; arg:   param_2 (struct_2 *)
; stack: v4 @ [stack+0x10] (char[8])
; stack: v3 @ [stack+0x18] (unsigned int[2])
; stack: v5 @ [stack+0x20] (unsigned int[2])
; stack: v6 @ [stack-0x18] (unsigned long long[2])
; stack: local_60 @ [stack-0x60] (undefined40)
; stack: local_38 @ [stack-0x38] (undefined8)
; stack: local_30 @ [stack-0x30] (undefined8)
; stack: local_28 @ [stack-0x28] (undefined16)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
  1400080f8: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  1400080fd: 57                        PUSH       RDI
  1400080fe: 48 83 ec 50               SUB        RSP,0x50
  140008102: f6 02 02                  TEST       byte ptr [RDX],0x2
  140008105: 48 8b da                  MOV        RBX,RDX
  140008108: 48 8b f9                  MOV        RDI,RCX
  14000810b: 75 04                     JNZ        0x140008111
  14000810d: 33 c0                     XOR        EAX,EAX
  14000810f: eb 7f                     JMP        0x140008190
  140008111: 48 8b 4b 08               MOV        RCX,qword ptr [RBX + 0x8]
  140008115: 4c 8d 44 24 70            LEA        R8,[RSP + 0x70]
  14000811a: 48 8d 54 24 68            LEA        RDX,[RSP + 0x68]
  14000811f: e8 80 11 00 00            CALL       0x1400092a4
  140008124: 85 c0                     TEST       EAX,EAX
  140008126: 78 68                     JS         0x140008190
  140008128: 8b 4c 24 70               MOV        ECX,dword ptr [RSP + 0x70]
  14000812c: 48 8d 54 24 78            LEA        RDX,[RSP + 0x78]
  140008131: e8 46 11 00 00            CALL       0x14000927c
  140008136: 48 8b 05 c3 af ff ff      MOV        RAX,qword ptr [0x140003100]
  14000813d: 44 8b 4c 24 78            MOV        R9D,dword ptr [RSP + 0x78]
  140008142: 48 8b 08                  MOV        RCX,qword ptr [RAX]
  140008145: 4c 8d 5c 24 40            LEA        R11,[RSP + 0x40]
  14000814a: 45 33 c0                  XOR        R8D,R8D
  14000814d: 4c 89 5c 24 30            MOV        qword ptr [RSP + 0x30],R11
  140008152: c6 44 24 28 00            MOV        byte ptr [RSP + 0x28],0x0
  140008157: 48 89 4c 24 20            MOV        qword ptr [RSP + 0x20],RCX
  14000815c: 48 8b cf                  MOV        RCX,RDI
  14000815f: ba 00 02 00 00            MOV        EDX,0x200
  140008164: ff 15 86 af ff ff         CALL       qword ptr [0x1400030f0]
  14000816a: 85 c0                     TEST       EAX,EAX
  14000816c: 78 22                     JS         0x140008190
  14000816e: 4c 8b 43 08               MOV        R8,qword ptr [RBX + 0x8]
  140008172: 8b 54 24 70               MOV        EDX,dword ptr [RSP + 0x70]
  140008176: 48 8b 4c 24 40            MOV        RCX,qword ptr [RSP + 0x40]
  14000817b: ff 15 77 af ff ff         CALL       qword ptr [0x1400030f8]
  140008181: 48 8b 4c 24 40            MOV        RCX,qword ptr [RSP + 0x40]
  140008186: 8b d8                     MOV        EBX,EAX
  140008188: ff 15 5a af ff ff         CALL       qword ptr [0x1400030e8]
  14000818e: 8b c3                     MOV        EAX,EBX
  140008190: 48 8b 5c 24 60            MOV        RBX,qword ptr [RSP + 0x60]
  140008195: 48 83 c4 50               ADD        RSP,0x50
  140008199: 5f                        POP        RDI
  14000819a: c3                        RET
  14000819b: cc                        INT3

sub_14000819c:  ; 0x14000819c
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned int)
; arg:   param_3 (long long)
; arg:   param_4 (unsigned int)
; arg:   param_5 (unsigned int)
; arg:   param_6 (undefined1)
; arg:   param_7 (unsigned long long)
; arg:   param_8 (long long)
; arg:   param_9 (unsigned long long *)
; stack: v7 @ [stack+0x18] (unsigned long long[2])
; stack: v6 @ [stack-0x58] (unsigned int)
; stack: v9 @ [stack-0x54] (unsigned int)
; stack: v10 @ [stack-0x48] (unsigned int)
; stack: v11 @ [stack-0x44] (undefined1)
; stack: v8 @ [stack-0x40] (char[24])
; stack: local_a0 @ [stack-0xa0] (undefined8)
; stack: local_98 @ [stack-0x98] (undefined32)
; stack: local_78 @ [stack-0x78] (unsigned int)
; stack: local_74 @ [stack-0x74] (undefined4)
; stack: local_70 @ [stack-0x70] (undefined1)
; stack: local_6f @ [stack-0x6f] (undefined23)
; stack: local_28 @ [stack-0x28] (undefined8)
; stack: local_20 @ [stack-0x20] (undefined8)
; stack: local_18 @ [stack-0x18] (undefined8)
; stack: local_10 @ [stack-0x10] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined24)
  14000819c: 48 8b c4                  MOV        RAX,RSP
  14000819f: 48 89 58 08               MOV        qword ptr [RAX + 0x8],RBX
  1400081a3: 48 89 68 10               MOV        qword ptr [RAX + 0x10],RBP
  1400081a7: 56                        PUSH       RSI
  1400081a8: 41 54                     PUSH       R12
  1400081aa: 41 55                     PUSH       R13
  1400081ac: 41 56                     PUSH       R14
  1400081ae: 41 57                     PUSH       R15
  1400081b0: 48 83 ec 70               SUB        RSP,0x70
  1400081b4: 48 8b b4 24 e0 00 00 00   MOV        RSI,qword ptr [RSP + 0xe0]
  1400081bc: 48 83 60 48 00            AND        qword ptr [RAX + 0x48],0x0
  1400081c1: 8b ac 24 c0 00 00 00      MOV        EBP,dword ptr [RSP + 0xc0]
  1400081c8: 48 83 26 00               AND        qword ptr [RSI],0x0
  1400081cc: 45 8b f1                  MOV        R14D,R9D
  1400081cf: 4d 8b e0                  MOV        R12,R8
  1400081d2: 44 8b fa                  MOV        R15D,EDX
  1400081d5: 4c 8b e9                  MOV        R13,RCX
  1400081d8: 4d 85 c0                  TEST       R8,R8
  1400081db: 75 0f                     JNZ        0x1400081ec
  1400081dd: 40 84 ed                  TEST       BPL,BPL
  1400081e0: 78 0a                     JS         0x1400081ec
  1400081e2: b8 0d 00 00 c0            MOV        EAX,0xc000000d
  1400081e7: e9 45 01 00 00            JMP        0x140008331
  1400081ec: 48 83 bc 24 d8 00 00 00 00  CMP        qword ptr [RSP + 0xd8],0x0
  1400081f5: 74 1e                     JZ         0x140008215
  1400081f7: 48 8b d1                  MOV        RDX,RCX
  1400081fa: 48 8b 8c 24 d8 00 00 00   MOV        RCX,qword ptr [RSP + 0xd8]
  140008202: 4c 8d 44 24 40            LEA        R8,[RSP + 0x40]
  140008207: e8 d8 04 00 00            CALL       0x1400086e4
  14000820c: 85 c0                     TEST       EAX,EAX
  14000820e: 79 0f                     JNS        0x14000821f
  140008210: e9 1c 01 00 00            JMP        0x140008331
  140008215: 48 8d 4c 24 40            LEA        RCX,[RSP + 0x40]
  14000821a: e8 ed 02 00 00            CALL       0x14000850c
  14000821f: 8b 44 24 40               MOV        EAX,dword ptr [RSP + 0x40]
  140008223: a8 02                     TEST       AL,0x2
  140008225: 75 7d                     JNZ        0x1400082a4
  140008227: 48 8b 8c 24 d0 00 00 00   MOV        RCX,qword ptr [RSP + 0xd0]
  14000822f: 4c 8d 84 24 b0 00 00 00   LEA        R8,[RSP + 0xb0]
  140008237: ba 01 00 00 00            MOV        EDX,0x1
  14000823c: e8 77 0f 00 00            CALL       0x1400091b8
  140008241: 8b d8                     MOV        EBX,EAX
  140008243: 85 c0                     TEST       EAX,EAX
  140008245: 0f 88 da 00 00 00         JS         0x140008325
  14000824b: 48 8b 8c 24 b0 00 00 00   MOV        RCX,qword ptr [RSP + 0xb0]
  140008253: 48 8d 54 24 40            LEA        RDX,[RSP + 0x40]
  140008258: e8 ef 00 00 00            CALL       0x14000834c
  14000825d: 48 83 bc 24 d8 00 00 00 00  CMP        qword ptr [RSP + 0xd8],0x0
  140008266: 74 38                     JZ         0x1400082a0
  140008268: 48 8d 4c 24 58            LEA        RCX,[RSP + 0x58]
  14000826d: e8 9a 02 00 00            CALL       0x14000850c
  140008272: 48 8b 8c 24 b0 00 00 00   MOV        RCX,qword ptr [RSP + 0xb0]
  14000827a: 48 8d 54 24 58            LEA        RDX,[RSP + 0x58]
  14000827f: e8 c8 00 00 00            CALL       0x14000834c
  140008284: 48 8b 8c 24 d8 00 00 00   MOV        RCX,qword ptr [RSP + 0xd8]
  14000828c: 48 8d 54 24 58            LEA        RDX,[RSP + 0x58]
  140008291: e8 76 05 00 00            CALL       0x14000880c
  140008296: 8b d8                     MOV        EBX,EAX
  140008298: 85 c0                     TEST       EAX,EAX
  14000829a: 0f 88 85 00 00 00         JS         0x140008325
  1400082a0: 8b 44 24 40               MOV        EAX,dword ptr [RSP + 0x40]
  1400082a4: 0f b6 8c 24 c8 00 00 00   MOVZX      ECX,byte ptr [RSP + 0xc8]
  1400082ac: a8 01                     TEST       AL,0x1
  1400082ae: 4d 8b c4                  MOV        R8,R12
  1400082b1: 44 0f 45 74 24 44         CMOVNZ     R14D,dword ptr [RSP + 0x44]
  1400082b7: a8 04                     TEST       AL,0x4
  1400082b9: 41 8b d7                  MOV        EDX,R15D
  1400082bc: 0f 45 6c 24 50            CMOVNZ     EBP,dword ptr [RSP + 0x50]
  1400082c1: a8 08                     TEST       AL,0x8
  1400082c3: 0f b6 44 24 54            MOVZX      EAX,byte ptr [RSP + 0x54]
  1400082c8: 0f 45 c8                  CMOVNZ     ECX,EAX
  1400082cb: 48 8d 84 24 e0 00 00 00   LEA        RAX,[RSP + 0xe0]
  1400082d3: 45 8b ce                  MOV        R9D,R14D
  1400082d6: 48 89 44 24 30            MOV        qword ptr [RSP + 0x30],RAX
  1400082db: 88 4c 24 28               MOV        byte ptr [RSP + 0x28],CL
  1400082df: 49 8b cd                  MOV        RCX,R13
  1400082e2: 89 6c 24 20               MOV        dword ptr [RSP + 0x20],EBP
  1400082e6: ff 15 f4 ad ff ff         CALL       qword ptr [0x1400030e0]
  1400082ec: 8b d8                     MOV        EBX,EAX
  1400082ee: 85 c0                     TEST       EAX,EAX
  1400082f0: 78 33                     JS         0x140008325
  1400082f2: 48 8b 8c 24 e0 00 00 00   MOV        RCX,qword ptr [RSP + 0xe0]
  1400082fa: 48 8d 54 24 40            LEA        RDX,[RSP + 0x40]
  1400082ff: e8 f4 fd ff ff            CALL       0x1400080f8
  140008304: 8b d8                     MOV        EBX,EAX
  140008306: 85 c0                     TEST       EAX,EAX
  140008308: 79 10                     JNS        0x14000831a
  14000830a: 48 8b 8c 24 e0 00 00 00   MOV        RCX,qword ptr [RSP + 0xe0]
  140008312: ff 15 08 ad ff ff         CALL       qword ptr [0x140003020]
  140008318: eb 0b                     JMP        0x140008325
  14000831a: 48 8b 84 24 e0 00 00 00   MOV        RAX,qword ptr [RSP + 0xe0]
  140008322: 48 89 06                  MOV        qword ptr [RSI],RAX
  140008325: 48 8d 4c 24 40            LEA        RCX,[RSP + 0x40]
  14000832a: e8 29 00 00 00            CALL       0x140008358
  14000832f: 8b c3                     MOV        EAX,EBX
  140008331: 4c 8d 5c 24 70            LEA        R11,[RSP + 0x70]
  140008336: 49 8b 5b 30               MOV        RBX,qword ptr [R11 + 0x30]
  14000833a: 49 8b 6b 38               MOV        RBP,qword ptr [R11 + 0x38]
  14000833e: 49 8b e3                  MOV        RSP,R11
  140008341: 41 5f                     POP        R15
  140008343: 41 5e                     POP        R14
  140008345: 41 5d                     POP        R13
  140008347: 41 5c                     POP        R12
  140008349: 5e                        POP        RSI
  14000834a: c3                        RET
  14000834b: cc                        INT3

sub_14000834c:  ; 0x14000834c
; arg:   param_1 (unsigned long long)
; arg:   param_2 (struct_3 *)
  14000834c: c7 02 02 00 00 00         MOV        dword ptr [RDX],0x2
  140008352: 48 89 4a 08               MOV        qword ptr [RDX + 0x8],RCX
  140008356: c3                        RET
  140008357: cc                        INT3

sub_140008358:  ; 0x140008358
; arg:   param_1 (struct_2 *)
; stack: local_30 @ [stack-0x30] (undefined48)
  140008358: 48 83 ec 28               SUB        RSP,0x28
  14000835c: f6 01 02                  TEST       byte ptr [RCX],0x2
  14000835f: 74 0c                     JZ         0x14000836d
  140008361: 48 8b 49 08               MOV        RCX,qword ptr [RCX + 0x8]
  140008365: 33 d2                     XOR        EDX,EDX
  140008367: ff 15 e3 ac ff ff         CALL       qword ptr [0x140003050]
  14000836d: 48 83 c4 28               ADD        RSP,0x28
  140008371: c3                        RET
  140008372: cc                        INT3
  140008373: cc                        INT3

sub_140008374:  ; 0x140008374
; arg:   param_1 (struct_4 *)
; arg:   param_2 (unsigned int)
; arg:   param_3 (int)
; arg:   param_4 (unsigned int *)
; arg:   param_5 (unsigned long long *)
; stack: v3 @ [stack-0x128] (char[32])
; stack: v13 @ [stack-0xb8] (unsigned int)
; stack: v4 @ [stack-0xb0] (unsigned long long)
; stack: v6 @ [stack-0xa8] (unsigned long long[2])
; stack: v5 @ [stack-0x98] (char[76])
; stack: v14 @ [stack-0x4c] (unsigned short)
; stack: v15 @ [stack-0x48] (unsigned long long)
; stack: local_130 @ [stack-0x130] (undefined8)
; stack: local_108 @ [stack-0x108] (unsigned long long)
; stack: local_100 @ [stack-0x100] (unsigned long long)
; stack: local_f8 @ [stack-0xf8] (unsigned long long)
; stack: local_f0 @ [stack-0xf0] (undefined8)
; stack: local_e8 @ [stack-0xe8] (undefined8)
; stack: local_e0 @ [stack-0xe0] (undefined8)
; stack: local_d8 @ [stack-0xd8] (undefined8)
; stack: local_d0 @ [stack-0xd0] (undefined8)
; stack: local_c8 @ [stack-0xc8] (undefined8)
; stack: local_c0 @ [stack-0xc0] (undefined8)
; stack: local_38 @ [stack-0x38] (undefined8)
; stack: local_30 @ [stack-0x30] (undefined8)
; stack: local_28 @ [stack-0x28] (undefined8)
; stack: local_20 @ [stack-0x20] (undefined8)
; stack: local_18 @ [stack-0x18] (undefined8)
; stack: local_10 @ [stack-0x10] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_18 @ [stack+0x18] (undefined16)
  140008374: 48 89 5c 24 18            MOV        qword ptr [RSP + 0x18],RBX
  140008379: 55                        PUSH       RBP
  14000837a: 56                        PUSH       RSI
  14000837b: 57                        PUSH       RDI
  14000837c: 41 54                     PUSH       R12
  14000837e: 41 55                     PUSH       R13
  140008380: 41 56                     PUSH       R14
  140008382: 41 57                     PUSH       R15
  140008384: 48 81 ec f0 00 00 00      SUB        RSP,0xf0
  14000838b: 48 8b 05 3e be ff ff      MOV        RAX,qword ptr [0x1400041d0]
  140008392: 48 33 c4                  XOR        RAX,RSP
  140008395: 48 89 84 24 e0 00 00 00   MOV        qword ptr [RSP + 0xe0],RAX
  14000839d: 4c 8b a4 24 50 01 00 00   MOV        R12,qword ptr [RSP + 0x150]
  1400083a5: 33 db                     XOR        EBX,EBX
  1400083a7: 49 8b e9                  MOV        RBP,R9
  1400083aa: 45 8b f8                  MOV        R15D,R8D
  1400083ad: 44 8b ea                  MOV        R13D,EDX
  1400083b0: 4c 8b f1                  MOV        R14,RCX
  1400083b3: 49 89 1c 24               MOV        qword ptr [R12],RBX
  1400083b7: 4c 3b cb                  CMP        R9,RBX
  1400083ba: 74 03                     JZ         0x1400083bf
  1400083bc: 41 89 19                  MOV        dword ptr [R9],EBX
  1400083bf: 4c 8d 4c 24 78            LEA        R9,[RSP + 0x78]
  1400083c4: 48 8d 15 35 b2 ff ff      LEA        RDX,[0x140003600]
  1400083cb: 41 b8 19 00 02 00         MOV        R8D,0x20019
  1400083d1: 33 c9                     XOR        ECX,ECX
  1400083d3: e8 dc 13 00 00            CALL       0x1400097b4
  1400083d8: 3b c3                     CMP        EAX,EBX
  1400083da: 0f 8c ff 00 00 00         JL         0x1400084df
  1400083e0: 41 0f b6 4e 0e            MOVZX      ECX,byte ptr [R14 + 0xe]
  1400083e5: 41 0f b6 56 0d            MOVZX      EDX,byte ptr [R14 + 0xd]
  1400083ea: 45 0f b6 46 0c            MOVZX      R8D,byte ptr [R14 + 0xc]
  1400083ef: 45 0f b6 4e 09            MOVZX      R9D,byte ptr [R14 + 0x9]
  1400083f4: 41 0f b6 46 0f            MOVZX      EAX,byte ptr [R14 + 0xf]
  1400083f9: 45 0f b6 56 0b            MOVZX      R10D,byte ptr [R14 + 0xb]
  1400083fe: 45 0f b6 5e 0a            MOVZX      R11D,byte ptr [R14 + 0xa]
  140008403: 41 0f b6 5e 08            MOVZX      EBX,byte ptr [R14 + 0x8]
  140008408: 41 0f b7 7e 06            MOVZX      EDI,word ptr [R14 + 0x6]
  14000840d: 41 0f b7 76 04            MOVZX      ESI,word ptr [R14 + 0x4]
  140008412: 89 44 24 68               MOV        dword ptr [RSP + 0x68],EAX
  140008416: 89 4c 24 60               MOV        dword ptr [RSP + 0x60],ECX
  14000841a: 89 54 24 58               MOV        dword ptr [RSP + 0x58],EDX
  14000841e: 44 89 44 24 50            MOV        dword ptr [RSP + 0x50],R8D
  140008423: 44 89 54 24 48            MOV        dword ptr [RSP + 0x48],R10D
  140008428: 44 89 5c 24 40            MOV        dword ptr [RSP + 0x40],R11D
  14000842d: 44 89 4c 24 38            MOV        dword ptr [RSP + 0x38],R9D
  140008432: 45 8b 0e                  MOV        R9D,dword ptr [R14]
  140008435: 89 5c 24 30               MOV        dword ptr [RSP + 0x30],EBX
  140008439: 4c 8d 05 40 b2 ff ff      LEA        R8,[0x140003680]
  140008440: 48 8d 8c 24 90 00 00 00   LEA        RCX,[RSP + 0x90]
  140008448: ba 27 00 00 00            MOV        EDX,0x27
  14000844d: 89 7c 24 28               MOV        dword ptr [RSP + 0x28],EDI
  140008451: 89 74 24 20               MOV        dword ptr [RSP + 0x20],ESI
  140008455: e8 51 a1 ff ff            CALL       0x1400025ab
  14000845a: 48 8b 4c 24 78            MOV        RCX,qword ptr [RSP + 0x78]
  14000845f: 33 ff                     XOR        EDI,EDI
  140008461: 66 89 bc 24 dc 00 00 00   MOV        word ptr [RSP + 0xdc],DI
  140008469: 45 8b c5                  MOV        R8D,R13D
  14000846c: 48 8d 94 24 90 00 00 00   LEA        RDX,[RSP + 0x90]
  140008474: 44 3b ff                  CMP        R15D,EDI
  140008477: 74 26                     JZ         0x14000849f
  140008479: 48 8d 84 24 80 00 00 00   LEA        RAX,[RSP + 0x80]
  140008481: 45 33 c9                  XOR        R9D,R9D
  140008484: 48 89 44 24 30            MOV        qword ptr [RSP + 0x30],RAX
  140008489: 48 8d 44 24 70            LEA        RAX,[RSP + 0x70]
  14000848e: 48 89 44 24 28            MOV        qword ptr [RSP + 0x28],RAX
  140008493: 48 89 7c 24 20            MOV        qword ptr [RSP + 0x20],RDI
  140008498: e8 a7 12 00 00            CALL       0x140009744
  14000849d: eb 15                     JMP        0x1400084b4
  14000849f: 4c 8d 8c 24 80 00 00 00   LEA        R9,[RSP + 0x80]
  1400084a7: e8 08 13 00 00            CALL       0x1400097b4
  1400084ac: c7 44 24 70 02 00 00 00   MOV        dword ptr [RSP + 0x70],0x2
  1400084b4: 48 8b 4c 24 78            MOV        RCX,qword ptr [RSP + 0x78]
  1400084b9: 8b d8                     MOV        EBX,EAX
  1400084bb: ff 15 27 ac ff ff         CALL       qword ptr [0x1400030e8]
  1400084c1: 3b df                     CMP        EBX,EDI
  1400084c3: 7c 18                     JL         0x1400084dd
  1400084c5: 48 8b 84 24 80 00 00 00   MOV        RAX,qword ptr [RSP + 0x80]
  1400084cd: 49 89 04 24               MOV        qword ptr [R12],RAX
  1400084d1: 48 3b ef                  CMP        RBP,RDI
  1400084d4: 74 07                     JZ         0x1400084dd
  1400084d6: 8b 44 24 70               MOV        EAX,dword ptr [RSP + 0x70]
  1400084da: 89 45 00                  MOV        dword ptr [RBP],EAX
  1400084dd: 8b c3                     MOV        EAX,EBX
  1400084df: 48 8b 8c 24 e0 00 00 00   MOV        RCX,qword ptr [RSP + 0xe0]
  1400084e7: 48 33 cc                  XOR        RCX,RSP
  1400084ea: e8 51 90 ff ff            CALL       0x140001540
  1400084ef: 48 8b 9c 24 40 01 00 00   MOV        RBX,qword ptr [RSP + 0x140]
  1400084f7: 48 81 c4 f0 00 00 00      ADD        RSP,0xf0
  1400084fe: 41 5f                     POP        R15
  140008500: 41 5e                     POP        R14
  140008502: 41 5d                     POP        R13
  140008504: 41 5c                     POP        R12
  140008506: 5f                        POP        RDI
  140008507: 5e                        POP        RSI
  140008508: 5d                        POP        RBP
  140008509: c3                        RET
  14000850a: cc                        INT3
  14000850b: cc                        INT3

sub_14000850c:  ; 0x14000850c
; arg:   param_1 (struct_5 *)
  14000850c: 33 c0                     XOR        EAX,EAX
  14000850e: 89 01                     MOV        dword ptr [RCX],EAX
  140008510: 48 89 41 08               MOV        qword ptr [RCX + 0x8],RAX
  140008514: 89 41 04                  MOV        dword ptr [RCX + 0x4],EAX
  140008517: 89 41 10                  MOV        dword ptr [RCX + 0x10],EAX
  14000851a: 89 41 14                  MOV        dword ptr [RCX + 0x14],EAX
  14000851d: c3                        RET
  14000851e: cc                        INT3
  14000851f: cc                        INT3

sub_140008520:  ; 0x140008520
; arg:   param_1 (unsigned long long)
; arg:   param_2 (struct_6 *)
; stack: v5 @ [stack+0x10] (char[8])
; stack: v4 @ [stack+0x18] (char[8])
; stack: v3 @ [stack+0x20] (long long)
; stack: v2 @ [stack-0x48] (long long[2])
; stack: local_80 @ [stack-0x80] (undefined8)
; stack: local_78 @ [stack-0x78] (undefined32)
; stack: local_58 @ [stack-0x58] (undefined16)
; stack: local_38 @ [stack-0x38] (undefined8)
; stack: local_30 @ [stack-0x30] (undefined8)
; stack: local_28 @ [stack-0x28] (undefined8)
; stack: local_20 @ [stack-0x20] (undefined8)
; stack: local_18 @ [stack-0x18] (undefined8)
; stack: local_10 @ [stack-0x10] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined24)
  140008520: 4c 8b dc                  MOV        R11,RSP
  140008523: 49 89 5b 08               MOV        qword ptr [R11 + 0x8],RBX
  140008527: 55                        PUSH       RBP
  140008528: 56                        PUSH       RSI
  140008529: 57                        PUSH       RDI
  14000852a: 41 54                     PUSH       R12
  14000852c: 41 55                     PUSH       R13
  14000852e: 41 56                     PUSH       R14
  140008530: 41 57                     PUSH       R15
  140008532: 48 83 ec 40               SUB        RSP,0x40
  140008536: 45 33 f6                  XOR        R14D,R14D
  140008539: 48 8b fa                  MOV        RDI,RDX
  14000853c: 49 8d 43 b8               LEA        RAX,[R11 + -0x48]
  140008540: 44 89 32                  MOV        dword ptr [RDX],R14D
  140008543: 4c 89 72 08               MOV        qword ptr [RDX + 0x8],R14
  140008547: 44 89 72 04               MOV        dword ptr [RDX + 0x4],R14D
  14000854b: 44 89 72 10               MOV        dword ptr [RDX + 0x10],R14D
  14000854f: 44 89 72 14               MOV        dword ptr [RDX + 0x14],R14D
  140008553: 45 8d 46 03               LEA        R8D,[R14 + 0x3]
  140008557: 48 8d 15 22 b0 ff ff      LEA        RDX,[0x140003580]
  14000855e: 45 33 c9                  XOR        R9D,R9D
  140008561: 48 8b f1                  MOV        RSI,RCX
  140008564: 4d 89 73 b8               MOV        qword ptr [R11 + -0x48],R14
  140008568: 49 89 43 a8               MOV        qword ptr [R11 + -0x58],RAX
  14000856c: e8 c3 13 00 00            CALL       0x140009934
  140008571: 41 3b c6                  CMP        EAX,R14D
  140008574: 8b d8                     MOV        EBX,EAX
  140008576: 41 bf 34 00 00 c0         MOV        R15D,0xc0000034
  14000857c: 7c 2b                     JL         0x1400085a9
  14000857e: 48 8b 44 24 30            MOV        RAX,qword ptr [RSP + 0x30]
  140008583: 45 8d 46 01               LEA        R8D,[R14 + 0x1]
  140008587: 41 b1 01                  MOV        R9B,0x1
  14000858a: 8b 48 08                  MOV        ECX,dword ptr [RAX + 0x8]
  14000858d: 33 d2                     XOR        EDX,EDX
  14000858f: 48 03 c8                  ADD        RCX,RAX
  140008592: 48 8d 84 24 98 00 00 00   LEA        RAX,[RSP + 0x98]
  14000859a: 48 89 44 24 20            MOV        qword ptr [RSP + 0x20],RAX
  14000859f: ff 15 73 ab ff ff         CALL       qword ptr [0x140003118]
  1400085a5: 8b d8                     MOV        EBX,EAX
  1400085a7: eb 10                     JMP        0x1400085b9
  1400085a9: 41 3b c7                  CMP        EAX,R15D
  1400085ac: 75 0b                     JNZ        0x1400085b9
  1400085ae: 4c 89 b4 24 98 00 00 00   MOV        qword ptr [RSP + 0x98],R14
  1400085b6: 41 8b de                  MOV        EBX,R14D
  1400085b9: 48 8b 4c 24 30            MOV        RCX,qword ptr [RSP + 0x30]
  1400085be: 49 3b ce                  CMP        RCX,R14
  1400085c1: 74 08                     JZ         0x1400085cb
  1400085c3: 33 d2                     XOR        EDX,EDX
  1400085c5: ff 15 85 aa ff ff         CALL       qword ptr [0x140003050]
  1400085cb: 41 3b de                  CMP        EBX,R14D
  1400085ce: 0f 8c d2 00 00 00         JL         0x1400086a6
  1400085d4: 48 8b 8c 24 98 00 00 00   MOV        RCX,qword ptr [RSP + 0x98]
  1400085dc: 49 3b ce                  CMP        RCX,R14
  1400085df: 74 4b                     JZ         0x14000862c
  1400085e1: 4c 8d 84 24 90 00 00 00   LEA        R8,[RSP + 0x90]
  1400085e9: 48 8d 94 24 88 00 00 00   LEA        RDX,[RSP + 0x88]
  1400085f1: e8 ae 0c 00 00            CALL       0x1400092a4
  1400085f6: 41 3b c6                  CMP        EAX,R14D
  1400085f9: 8b d8                     MOV        EBX,EAX
  1400085fb: 0f 8c a5 00 00 00         JL         0x1400086a6
  140008601: 44 38 b4 24 88 00 00 00   CMP        byte ptr [RSP + 0x88],R14B
  140008609: 74 12                     JZ         0x14000861d
  14000860b: 48 8b 8c 24 98 00 00 00   MOV        RCX,qword ptr [RSP + 0x98]
  140008613: 33 d2                     XOR        EDX,EDX
  140008615: ff 15 35 aa ff ff         CALL       qword ptr [0x140003050]
  14000861b: eb 0f                     JMP        0x14000862c
  14000861d: 48 8b 84 24 98 00 00 00   MOV        RAX,qword ptr [RSP + 0x98]
  140008625: 83 0f 02                  OR         dword ptr [RDI],0x2
  140008628: 48 89 47 08               MOV        qword ptr [RDI + 0x8],RAX
  14000862c: 4c 8d 4f 04               LEA        R9,[RDI + 0x4]
  140008630: 48 8d 15 61 af ff ff      LEA        RDX,[0x140003598]
  140008637: 45 33 c0                  XOR        R8D,R8D
  14000863a: 48 8b ce                  MOV        RCX,RSI
  14000863d: e8 b6 10 00 00            CALL       0x1400096f8
  140008642: 41 3b c6                  CMP        EAX,R14D
  140008645: 8b d8                     MOV        EBX,EAX
  140008647: 7c 05                     JL         0x14000864e
  140008649: 83 0f 01                  OR         dword ptr [RDI],0x1
  14000864c: eb 05                     JMP        0x140008653
  14000864e: 41 3b c7                  CMP        EAX,R15D
  140008651: 75 53                     JNZ        0x1400086a6
  140008653: 4c 8d 4f 10               LEA        R9,[RDI + 0x10]
  140008657: 48 8d 15 52 af ff ff      LEA        RDX,[0x1400035b0]
  14000865e: 45 33 c0                  XOR        R8D,R8D
  140008661: 48 8b ce                  MOV        RCX,RSI
  140008664: e8 8f 10 00 00            CALL       0x1400096f8
  140008669: 41 3b c6                  CMP        EAX,R14D
  14000866c: 8b d8                     MOV        EBX,EAX
  14000866e: 7c 05                     JL         0x140008675
  140008670: 83 0f 04                  OR         dword ptr [RDI],0x4
  140008673: eb 05                     JMP        0x14000867a
  140008675: 41 3b c7                  CMP        EAX,R15D
  140008678: 75 2c                     JNZ        0x1400086a6
  14000867a: 4c 8d 4f 14               LEA        R9,[RDI + 0x14]
  14000867e: 48 8d 15 5b af ff ff      LEA        RDX,[0x1400035e0]
  140008685: 45 33 c0                  XOR        R8D,R8D
  140008688: 48 8b ce                  MOV        RCX,RSI
  14000868b: e8 68 10 00 00            CALL       0x1400096f8
  140008690: 41 3b c6                  CMP        EAX,R14D
  140008693: 8b d8                     MOV        EBX,EAX
  140008695: 7c 05                     JL         0x14000869c
  140008697: 83 0f 08                  OR         dword ptr [RDI],0x8
  14000869a: eb 2e                     JMP        0x1400086ca
  14000869c: 41 3b c7                  CMP        EAX,R15D
  14000869f: 75 05                     JNZ        0x1400086a6
  1400086a1: 41 8b de                  MOV        EBX,R14D
  1400086a4: eb 24                     JMP        0x1400086ca
  1400086a6: 48 8b 4f 08               MOV        RCX,qword ptr [RDI + 0x8]
  1400086aa: 49 3b ce                  CMP        RCX,R14
  1400086ad: 74 08                     JZ         0x1400086b7
  1400086af: 33 d2                     XOR        EDX,EDX
  1400086b1: ff 15 99 a9 ff ff         CALL       qword ptr [0x140003050]
  1400086b7: 44 89 37                  MOV        dword ptr [RDI],R14D
  1400086ba: 4c 89 77 08               MOV        qword ptr [RDI + 0x8],R14
  1400086be: 44 89 77 04               MOV        dword ptr [RDI + 0x4],R14D
  1400086c2: 44 89 77 10               MOV        dword ptr [RDI + 0x10],R14D
  1400086c6: 44 89 77 14               MOV        dword ptr [RDI + 0x14],R14D
  1400086ca: 8b c3                     MOV        EAX,EBX
  1400086cc: 48 8b 9c 24 80 00 00 00   MOV        RBX,qword ptr [RSP + 0x80]
  1400086d4: 48 83 c4 40               ADD        RSP,0x40
  1400086d8: 41 5f                     POP        R15
  1400086da: 41 5e                     POP        R14
  1400086dc: 41 5d                     POP        R13
  1400086de: 41 5c                     POP        R12
  1400086e0: 5f                        POP        RDI
  1400086e1: 5e                        POP        RSI
  1400086e2: 5d                        POP        RBP
  1400086e3: c3                        RET

sub_1400086e4:  ; 0x1400086e4
; arg:   param_1 (unsigned long long)
; arg:   param_2 (void *)
; arg:   param_3 (struct_5 *)
; stack: v5 @ [stack+0x18] (int[2])
; stack: v4 @ [stack+0x20] (unsigned long long)
; stack: v6 @ [stack-0x18] (unsigned long long[2])
; stack: local_50 @ [stack-0x50] (undefined8)
; stack: local_48 @ [stack-0x48] (undefined32)
; stack: local_28 @ [stack-0x28] (undefined16)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined16)
  1400086e4: 4c 8b dc                  MOV        R11,RSP
  1400086e7: 49 89 5b 08               MOV        qword ptr [R11 + 0x8],RBX
  1400086eb: 57                        PUSH       RDI
  1400086ec: 48 83 ec 40               SUB        RSP,0x40
  1400086f0: 41 83 20 00               AND        dword ptr [R8],0x0
  1400086f4: 49 83 60 08 00            AND        qword ptr [R8 + 0x8],0x0
  1400086f9: 41 83 60 04 00            AND        dword ptr [R8 + 0x4],0x0
  1400086fe: 41 83 60 10 00            AND        dword ptr [R8 + 0x10],0x0
  140008703: 41 83 60 14 00            AND        dword ptr [R8 + 0x14],0x0
  140008708: 49 83 63 20 00            AND        qword ptr [R11 + 0x20],0x0
  14000870d: 49 83 63 e8 00            AND        qword ptr [R11 + -0x18],0x0
  140008712: 49 8d 43 20               LEA        RAX,[R11 + 0x20]
  140008716: 49 8b f8                  MOV        RDI,R8
  140008719: 48 8b da                  MOV        RBX,RDX
  14000871c: 4d 8d 4b 18               LEA        R9,[R11 + 0x18]
  140008720: 41 b8 01 00 00 00         MOV        R8D,0x1
  140008726: ba 3f 00 0f 00            MOV        EDX,0xf003f
  14000872b: 49 89 43 d8               MOV        qword ptr [R11 + -0x28],RAX
  14000872f: e8 40 fc ff ff            CALL       0x140008374
  140008734: 85 c0                     TEST       EAX,EAX
  140008736: 0f 88 c4 00 00 00         JS         0x140008800
  14000873c: 83 7c 24 60 02            CMP        dword ptr [RSP + 0x60],0x2
  140008741: 75 4f                     JNZ        0x140008792
  140008743: 48 8b 4c 24 68            MOV        RCX,qword ptr [RSP + 0x68]
  140008748: 4c 8d 4c 24 30            LEA        R9,[RSP + 0x30]
  14000874d: 48 8d 15 cc ad ff ff      LEA        RDX,[0x140003520]
  140008754: 41 b8 19 00 02 00         MOV        R8D,0x20019
  14000875a: e8 55 10 00 00            CALL       0x1400097b4
  14000875f: 48 8b 4c 24 68            MOV        RCX,qword ptr [RSP + 0x68]
  140008764: 8b d8                     MOV        EBX,EAX
  140008766: ff 15 7c a9 ff ff         CALL       qword ptr [0x1400030e8]
  14000876c: 85 db                     TEST       EBX,EBX
  14000876e: 78 16                     JS         0x140008786
  140008770: 48 8b 4c 24 30            MOV        RCX,qword ptr [RSP + 0x30]
  140008775: 48 8b d7                  MOV        RDX,RDI
  140008778: e8 a3 fd ff ff            CALL       0x140008520
  14000877d: 48 8b 4c 24 30            MOV        RCX,qword ptr [RSP + 0x30]
  140008782: 8b d8                     MOV        EBX,EAX
  140008784: eb 72                     JMP        0x1400087f8
  140008786: 81 fb 34 00 00 c0         CMP        EBX,0xc0000034
  14000878c: 75 70                     JNZ        0x1400087fe
  14000878e: 33 db                     XOR        EBX,EBX
  140008790: eb 6c                     JMP        0x1400087fe
  140008792: 4c 8b 43 30               MOV        R8,qword ptr [RBX + 0x30]
  140008796: 48 8b 7c 24 68            MOV        RDI,qword ptr [RSP + 0x68]
  14000879b: 49 83 c0 18               ADD        R8,0x18
  14000879f: 75 07                     JNZ        0x1400087a8
  1400087a1: bb 9a 00 00 c0            MOV        EBX,0xc000009a
  1400087a6: eb 4d                     JMP        0x1400087f5
  1400087a8: 48 8d 15 89 ad ff ff      LEA        RDX,[0x140003538]
  1400087af: 48 8b cf                  MOV        RCX,RDI
  1400087b2: e8 ad 0e 00 00            CALL       0x140009664
  1400087b7: 8b d8                     MOV        EBX,EAX
  1400087b9: 85 c0                     TEST       EAX,EAX
  1400087bb: 78 38                     JS         0x1400087f5
  1400087bd: 4c 8d 44 24 60            LEA        R8,[RSP + 0x60]
  1400087c2: 48 8d 15 7f ad ff ff      LEA        RDX,[0x140003548]
  1400087c9: 48 8b cf                  MOV        RCX,RDI
  1400087cc: c7 44 24 60 31 00 00 00   MOV        dword ptr [RSP + 0x60],0x31
  1400087d4: e8 3b 0e 00 00            CALL       0x140009614
  1400087d9: 8b d8                     MOV        EBX,EAX
  1400087db: 85 c0                     TEST       EAX,EAX
  1400087dd: 78 16                     JS         0x1400087f5
  1400087df: 4c 8d 44 24 60            LEA        R8,[RSP + 0x60]
  1400087e4: 48 8d 15 7d ad ff ff      LEA        RDX,[0x140003568]
  1400087eb: 48 8b cf                  MOV        RCX,RDI
  1400087ee: e8 21 0e 00 00            CALL       0x140009614
  1400087f3: 8b d8                     MOV        EBX,EAX
  1400087f5: 48 8b cf                  MOV        RCX,RDI
  1400087f8: ff 15 ea a8 ff ff         CALL       qword ptr [0x1400030e8]
  1400087fe: 8b c3                     MOV        EAX,EBX
  140008800: 48 8b 5c 24 50            MOV        RBX,qword ptr [RSP + 0x50]
  140008805: 48 83 c4 40               ADD        RSP,0x40
  140008809: 5f                        POP        RDI
  14000880a: c3                        RET
  14000880b: cc                        INT3

sub_14000880c:  ; 0x14000880c
; arg:   param_1 (unsigned long long)
; arg:   param_2 (void *)
; stack: v4 @ [stack+0x18] (unsigned long long)
; stack: v3 @ [stack+0x20] (unsigned long long)
; stack: v5 @ [stack-0x18] (unsigned long long[2])
; stack: local_60 @ [stack-0x60] (undefined8)
; stack: local_58 @ [stack-0x58] (undefined32)
; stack: local_38 @ [stack-0x38] (undefined48)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined8)
  14000880c: 4c 8b dc                  MOV        R11,RSP
  14000880f: 49 89 5b 08               MOV        qword ptr [R11 + 0x8],RBX
  140008813: 49 89 6b 10               MOV        qword ptr [R11 + 0x10],RBP
  140008817: 57                        PUSH       RDI
  140008818: 48 83 ec 50               SUB        RSP,0x50
  14000881c: 49 8d 43 20               LEA        RAX,[R11 + 0x20]
  140008820: 48 8b fa                  MOV        RDI,RDX
  140008823: 45 33 c9                  XOR        R9D,R9D
  140008826: 45 33 c0                  XOR        R8D,R8D
  140008829: ba 3f 00 0f 00            MOV        EDX,0xf003f
  14000882e: 49 89 43 c8               MOV        qword ptr [R11 + -0x38],RAX
  140008832: e8 3d fb ff ff            CALL       0x140008374
  140008837: 33 ed                     XOR        EBP,EBP
  140008839: 3b c5                     CMP        EAX,EBP
  14000883b: 0f 8c de 00 00 00         JL         0x14000891f
  140008841: 8b 05 b1 b9 ff ff         MOV        EAX,dword ptr [0x1400041f8]
  140008847: 48 8d 1d b2 b7 ff ff      LEA        RBX,[0x140004000]
  14000884e: 3b c5                     CMP        EAX,EBP
  140008850: 75 4a                     JNZ        0x14000889c
  140008852: 48 8d 44 24 70            LEA        RAX,[RSP + 0x70]
  140008857: 44 8d 45 01               LEA        R8D,[RBP + 0x1]
  14000885b: 41 b1 01                  MOV        R9B,0x1
  14000885e: 33 d2                     XOR        EDX,EDX
  140008860: 48 8b cb                  MOV        RCX,RBX
  140008863: 48 89 44 24 20            MOV        qword ptr [RSP + 0x20],RAX
  140008868: ff 15 aa a8 ff ff         CALL       qword ptr [0x140003118]
  14000886e: 3b c5                     CMP        EAX,EBP
  140008870: 7c 1f                     JL         0x140008891
  140008872: 48 8b 4c 24 70            MOV        RCX,qword ptr [RSP + 0x70]
  140008877: 33 d2                     XOR        EDX,EDX
  140008879: c7 05 75 b9 ff ff 01 00 00 00  MOV        dword ptr [0x1400041f8],0x1
  140008883: ff 15 c7 a7 ff ff         CALL       qword ptr [0x140003050]
  140008889: 8b 05 69 b9 ff ff         MOV        EAX,dword ptr [0x1400041f8]
  14000888f: eb 0b                     JMP        0x14000889c
  140008891: b8 02 00 00 00            MOV        EAX,0x2
  140008896: 89 05 5c b9 ff ff         MOV        dword ptr [0x1400041f8],EAX
  14000889c: 48 8b 4c 24 78            MOV        RCX,qword ptr [RSP + 0x78]
  1400088a1: 83 f8 01                  CMP        EAX,0x1
  1400088a4: 48 8d 44 24 40            LEA        RAX,[RSP + 0x40]
  1400088a9: 48 0f 45 dd               CMOVNZ     RBX,RBP
  1400088ad: 48 89 44 24 30            MOV        qword ptr [RSP + 0x30],RAX
  1400088b2: 48 8d 15 67 ac ff ff      LEA        RDX,[0x140003520]
  1400088b9: 45 33 c9                  XOR        R9D,R9D
  1400088bc: 41 b8 3f 00 0f 00         MOV        R8D,0xf003f
  1400088c2: 48 89 6c 24 28            MOV        qword ptr [RSP + 0x28],RBP
  1400088c7: 48 89 5c 24 20            MOV        qword ptr [RSP + 0x20],RBX
  1400088cc: 48 89 5c 24 70            MOV        qword ptr [RSP + 0x70],RBX
  1400088d1: e8 6e 0e 00 00            CALL       0x140009744
  1400088d6: 48 8b 4c 24 78            MOV        RCX,qword ptr [RSP + 0x78]
  1400088db: 8b d8                     MOV        EBX,EAX
  1400088dd: ff 15 05 a8 ff ff         CALL       qword ptr [0x1400030e8]
  1400088e3: 3b dd                     CMP        EBX,EBP
  1400088e5: 7c 36                     JL         0x14000891d
  1400088e7: 48 8b 4f 08               MOV        RCX,qword ptr [RDI + 0x8]
  1400088eb: ff 15 1f a8 ff ff         CALL       qword ptr [0x140003110]
  1400088f1: 4c 8b 4f 08               MOV        R9,qword ptr [RDI + 0x8]
  1400088f5: 48 8b 4c 24 40            MOV        RCX,qword ptr [RSP + 0x40]
  1400088fa: 48 8d 15 7f ac ff ff      LEA        RDX,[0x140003580]
  140008901: 41 b8 03 00 00 00         MOV        R8D,0x3
  140008907: 89 44 24 20               MOV        dword ptr [RSP + 0x20],EAX
  14000890b: e8 90 0d 00 00            CALL       0x1400096a0
  140008910: 48 8b 4c 24 40            MOV        RCX,qword ptr [RSP + 0x40]
  140008915: 8b d8                     MOV        EBX,EAX
  140008917: ff 15 cb a7 ff ff         CALL       qword ptr [0x1400030e8]
  14000891d: 8b c3                     MOV        EAX,EBX
  14000891f: 48 8b 5c 24 60            MOV        RBX,qword ptr [RSP + 0x60]
  140008924: 48 8b 6c 24 68            MOV        RBP,qword ptr [RSP + 0x68]
  140008929: 48 83 c4 50               ADD        RSP,0x50
  14000892d: 5f                        POP        RDI
  14000892e: c3                        RET
  14000892f: cc                        INT3

sub_140008930:  ; 0x140008930
; arg:   param_1 (unsigned short *)
; arg:   param_2 (unsigned long long *)
; arg:   param_3 (unsigned int *)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined8)
; stack: stack_18 @ [stack+0x18] (undefined16)
  140008930: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  140008935: 48 89 6c 24 10            MOV        qword ptr [RSP + 0x10],RBP
  14000893a: 48 89 74 24 18            MOV        qword ptr [RSP + 0x18],RSI
  14000893f: 33 ed                     XOR        EBP,EBP
  140008941: 4d 8b d8                  MOV        R11,R8
  140008944: 48 8b da                  MOV        RBX,RDX
  140008947: 41 89 28                  MOV        dword ptr [R8],EBP
  14000894a: 8d 75 30                  LEA        ESI,[RBP + 0x30]
  14000894d: 48 89 0a                  MOV        qword ptr [RDX],RCX
  140008950: 4c 8b d1                  MOV        R10,RCX
  140008953: 4c 8b c9                  MOV        R9,RCX
  140008956: 66 39 31                  CMP        word ptr [RCX],SI
  140008959: 75 1a                     JNZ        0x140008975
  14000895b: 66 83 79 02 78            CMP        word ptr [RCX + 0x2],0x78
  140008960: 74 07                     JZ         0x140008969
  140008962: 66 83 79 02 58            CMP        word ptr [RCX + 0x2],0x58
  140008967: 75 09                     JNZ        0x140008972
  140008969: 49 83 c2 04               ADD        R10,0x4
  14000896d: 4d 8b ca                  MOV        R9,R10
  140008970: eb 10                     JMP        0x140008982
  140008972: 66 39 31                  CMP        word ptr [RCX],SI
  140008975: 72 0b                     JC         0x140008982
  140008977: 66 83 39 39               CMP        word ptr [RCX],0x39
  14000897b: ba 0a 00 00 00            MOV        EDX,0xa
  140008980: 76 05                     JBE        0x140008987
  140008982: ba 10 00 00 00            MOV        EDX,0x10
  140008987: 44 8b c5                  MOV        R8D,EBP
  14000898a: eb 51                     JMP        0x1400089dd
  14000898c: 66 3b c6                  CMP        AX,SI
  14000898f: 72 0d                     JC         0x14000899e
  140008991: 66 83 f8 39               CMP        AX,0x39
  140008995: 77 07                     JA         0x14000899e
  140008997: 0f b7 c8                  MOVZX      ECX,AX
  14000899a: 2b ce                     SUB        ECX,ESI
  14000899c: eb 2b                     JMP        0x1400089c9
  14000899e: 83 fa 10                  CMP        EDX,0x10
  1400089a1: 75 43                     JNZ        0x1400089e6
  1400089a3: 66 83 f8 41               CMP        AX,0x41
  1400089a7: 72 0e                     JC         0x1400089b7
  1400089a9: 66 83 f8 46               CMP        AX,0x46
  1400089ad: 77 08                     JA         0x1400089b7
  1400089af: 0f b7 c8                  MOVZX      ECX,AX
  1400089b2: 83 e9 37                  SUB        ECX,0x37
  1400089b5: eb 12                     JMP        0x1400089c9
  1400089b7: 66 83 f8 61               CMP        AX,0x61
  1400089bb: 72 29                     JC         0x1400089e6
  1400089bd: 66 83 f8 66               CMP        AX,0x66
  1400089c1: 77 23                     JA         0x1400089e6
  1400089c3: 0f b7 c8                  MOVZX      ECX,AX
  1400089c6: 83 e9 57                  SUB        ECX,0x57
  1400089c9: 41 8b c0                  MOV        EAX,R8D
  1400089cc: 0f af c2                  IMUL       EAX,EDX
  1400089cf: 03 c1                     ADD        EAX,ECX
  1400089d1: 41 3b c0                  CMP        EAX,R8D
  1400089d4: 72 30                     JC         0x140008a06
  1400089d6: 44 8b c0                  MOV        R8D,EAX
  1400089d9: 49 83 c1 02               ADD        R9,0x2
  1400089dd: 41 0f b7 01               MOVZX      EAX,word ptr [R9]
  1400089e1: 66 3b c5                  CMP        AX,BP
  1400089e4: 75 a6                     JNZ        0x14000898c
  1400089e6: 4d 3b ca                  CMP        R9,R10
  1400089e9: 74 1b                     JZ         0x140008a06
  1400089eb: 4c 89 0b                  MOV        qword ptr [RBX],R9
  1400089ee: b8 01 00 00 00            MOV        EAX,0x1
  1400089f3: 45 89 03                  MOV        dword ptr [R11],R8D
  1400089f6: 48 8b 5c 24 08            MOV        RBX,qword ptr [RSP + 0x8]
  1400089fb: 48 8b 6c 24 10            MOV        RBP,qword ptr [RSP + 0x10]
  140008a00: 48 8b 74 24 18            MOV        RSI,qword ptr [RSP + 0x18]
  140008a05: c3                        RET
  140008a06: 33 c0                     XOR        EAX,EAX
  140008a08: eb ec                     JMP        0x1400089f6
  140008a0a: cc                        INT3
  140008a0b: cc                        INT3

sub_140008a0c:  ; 0x140008a0c
; arg:   param_1 (long long *)
; arg:   param_2 (unsigned int *)
; arg:   param_3 (unsigned long long)
; arg:   param_4 (unsigned long long)
; arg:   param_5 (unsigned int)
; arg:   param_6 (int)
; arg:   param_7 (unsigned long long)
; stack: local_50 @ [stack-0x50] (undefined8)
; stack: local_48 @ [stack-0x48] (undefined32)
; stack: local_28 @ [stack-0x28] (undefined8)
; stack: local_20 @ [stack-0x20] (undefined8)
; stack: local_18 @ [stack-0x18] (undefined8)
; stack: local_10 @ [stack-0x10] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined8)
; stack: stack_18 @ [stack+0x18] (undefined16)
  140008a0c: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  140008a11: 48 89 6c 24 10            MOV        qword ptr [RSP + 0x10],RBP
  140008a16: 48 89 74 24 18            MOV        qword ptr [RSP + 0x18],RSI
  140008a1b: 57                        PUSH       RDI
  140008a1c: 41 54                     PUSH       R12
  140008a1e: 41 55                     PUSH       R13
  140008a20: 41 56                     PUSH       R14
  140008a22: 41 57                     PUSH       R15
  140008a24: 48 83 ec 20               SUB        RSP,0x20
  140008a28: 48 8b 39                  MOV        RDI,qword ptr [RCX]
  140008a2b: 44 8b 22                  MOV        R12D,dword ptr [RDX]
  140008a2e: 4c 8b f1                  MOV        R14,RCX
  140008a31: 48 8b 8c 24 80 00 00 00   MOV        RCX,qword ptr [RSP + 0x80]
  140008a39: 48 8b f2                  MOV        RSI,RDX
  140008a3c: ff 15 16 a7 ff ff         CALL       qword ptr [0x140003158]
  140008a42: 44 0f b7 47 02            MOVZX      R8D,word ptr [RDI + 0x2]
  140008a47: 8d 58 08                  LEA        EBX,[RAX + 0x8]
  140008a4a: 42 8d 2c 23               LEA        EBP,[RBX + R12*0x1]
  140008a4e: 41 3b e8                  CMP        EBP,R8D
  140008a51: 76 5e                     JBE        0x140008ab1
  140008a53: 0f af 5c 24 78            IMUL       EBX,dword ptr [RSP + 0x78]
  140008a58: 41 b8 53 65 41 6c         MOV        R8D,0x6c416553
  140008a5e: b9 01 00 00 00            MOV        ECX,0x1
  140008a63: 41 03 dc                  ADD        EBX,R12D
  140008a66: 8b d3                     MOV        EDX,EBX
  140008a68: 44 8b fb                  MOV        R15D,EBX
  140008a6b: ff 15 cf a5 ff ff         CALL       qword ptr [0x140003040]
  140008a71: 4c 8b e8                  MOV        R13,RAX
  140008a74: 48 85 c0                  TEST       RAX,RAX
  140008a77: 75 07                     JNZ        0x140008a80
  140008a79: b8 9a 00 00 c0            MOV        EAX,0xc000009a
  140008a7e: eb 4e                     JMP        0x140008ace
  140008a80: 4d 8b c7                  MOV        R8,R15
  140008a83: 33 d2                     XOR        EDX,EDX
  140008a85: 48 8b c8                  MOV        RCX,RAX
  140008a88: e8 63 86 ff ff            CALL       0x1400010f0
  140008a8d: 49 8b 16                  MOV        RDX,qword ptr [R14]
  140008a90: 4d 8b c4                  MOV        R8,R12
  140008a93: 49 8b cd                  MOV        RCX,R13
  140008a96: e8 55 87 ff ff            CALL       0x1400011f0
  140008a9b: 33 d2                     XOR        EDX,EDX
  140008a9d: 48 8b cf                  MOV        RCX,RDI
  140008aa0: 66 41 89 5d 02            MOV        word ptr [R13 + 0x2],BX
  140008aa5: ff 15 a5 a5 ff ff         CALL       qword ptr [0x140003050]
  140008aab: 4d 89 2e                  MOV        qword ptr [R14],R13
  140008aae: 49 8b fd                  MOV        RDI,R13
  140008ab1: 4c 8b 8c 24 80 00 00 00   MOV        R9,qword ptr [RSP + 0x80]
  140008ab9: 44 8b 44 24 70            MOV        R8D,dword ptr [RSP + 0x70]
  140008abe: ba 02 00 00 00            MOV        EDX,0x2
  140008ac3: 48 8b cf                  MOV        RCX,RDI
  140008ac6: 89 2e                     MOV        dword ptr [RSI],EBP
  140008ac8: ff 15 92 a6 ff ff         CALL       qword ptr [0x140003160]
  140008ace: 48 8b 5c 24 50            MOV        RBX,qword ptr [RSP + 0x50]
  140008ad3: 48 8b 6c 24 58            MOV        RBP,qword ptr [RSP + 0x58]
  140008ad8: 48 8b 74 24 60            MOV        RSI,qword ptr [RSP + 0x60]
  140008add: 48 83 c4 20               ADD        RSP,0x20
  140008ae1: 41 5f                     POP        R15
  140008ae3: 41 5e                     POP        R14
  140008ae5: 41 5d                     POP        R13
  140008ae7: 41 5c                     POP        R12
  140008ae9: 5f                        POP        RDI
  140008aea: c3                        RET
  140008aeb: cc                        INT3

sub_140008aec:  ; 0x140008aec
; arg:   param_1 (long long)
; arg:   param_2 (unsigned int *)
; arg:   param_3 (long long *)
; stack: local_40 @ [stack-0x40] (undefined8)
; stack: local_38 @ [stack-0x38] (undefined32)
; stack: local_18 @ [stack-0x18] (undefined8)
; stack: local_10 @ [stack-0x10] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined8)
; stack: stack_18 @ [stack+0x18] (undefined16)
  140008aec: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  140008af1: 48 89 6c 24 10            MOV        qword ptr [RSP + 0x10],RBP
  140008af6: 48 89 74 24 18            MOV        qword ptr [RSP + 0x18],RSI
  140008afb: 57                        PUSH       RDI
  140008afc: 41 54                     PUSH       R12
  140008afe: 41 55                     PUSH       R13
  140008b00: 48 83 ec 20               SUB        RSP,0x20
  140008b04: 4c 8d 2d 45 b6 ff ff      LEA        R13,[0x140004150]
  140008b0b: 49 8b e8                  MOV        RBP,R8
  140008b0e: 4c 8b e2                  MOV        R12,RDX
  140008b11: 48 8b f1                  MOV        RSI,RCX
  140008b14: 33 db                     XOR        EBX,EBX
  140008b16: 49 8b fd                  MOV        RDI,R13
  140008b19: 44 8b 47 08               MOV        R8D,dword ptr [RDI + 0x8]
  140008b1d: 48 8b 17                  MOV        RDX,qword ptr [RDI]
  140008b20: 48 8b ce                  MOV        RCX,RSI
  140008b23: e8 8f 9a ff ff            CALL       0x1400025b7
  140008b28: 85 c0                     TEST       EAX,EAX
  140008b2a: 74 18                     JZ         0x140008b44
  140008b2c: ff c3                     INC        EBX
  140008b2e: 48 83 c7 10               ADD        RDI,0x10
  140008b32: 83 fb 08                  CMP        EBX,0x8
  140008b35: 72 e2                     JC         0x140008b19
  140008b37: 41 83 24 24 00            AND        dword ptr [R12],0x0
  140008b3c: 48 89 75 00               MOV        qword ptr [RBP],RSI
  140008b40: 33 c0                     XOR        EAX,EAX
  140008b42: eb 20                     JMP        0x140008b64
  140008b44: 8b d3                     MOV        EDX,EBX
  140008b46: b8 01 00 00 00            MOV        EAX,0x1
  140008b4b: 48 03 d2                  ADD        RDX,RDX
  140008b4e: 41 8b 4c d5 0c            MOV        ECX,dword ptr [R13 + RDX*0x8 + 0xc]
  140008b53: 41 89 0c 24               MOV        dword ptr [R12],ECX
  140008b57: 41 8b 4c d5 08            MOV        ECX,dword ptr [R13 + RDX*0x8 + 0x8]
  140008b5c: 48 8d 14 4e               LEA        RDX,[RSI + RCX*0x2]
  140008b60: 48 89 55 00               MOV        qword ptr [RBP],RDX
  140008b64: 48 8b 5c 24 40            MOV        RBX,qword ptr [RSP + 0x40]
  140008b69: 48 8b 6c 24 48            MOV        RBP,qword ptr [RSP + 0x48]
  140008b6e: 48 8b 74 24 50            MOV        RSI,qword ptr [RSP + 0x50]
  140008b73: 48 83 c4 20               ADD        RSP,0x20
  140008b77: 41 5d                     POP        R13
  140008b79: 41 5c                     POP        R12
  140008b7b: 5f                        POP        RDI
  140008b7c: c3                        RET
  140008b7d: cc                        INT3
  140008b7e: cc                        INT3
  140008b7f: cc                        INT3

sub_140008b80:  ; 0x140008b80
; arg:   param_1 (long long)
; arg:   param_2 (unsigned long long *)
; arg:   param_3 (long long *)
; stack: local_40 @ [stack-0x40] (undefined8)
; stack: local_38 @ [stack-0x38] (undefined32)
; stack: local_18 @ [stack-0x18] (undefined8)
; stack: local_10 @ [stack-0x10] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined8)
; stack: stack_18 @ [stack+0x18] (undefined16)
  140008b80: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  140008b85: 48 89 6c 24 10            MOV        qword ptr [RSP + 0x10],RBP
  140008b8a: 48 89 74 24 18            MOV        qword ptr [RSP + 0x18],RSI
  140008b8f: 57                        PUSH       RDI
  140008b90: 41 54                     PUSH       R12
  140008b92: 41 55                     PUSH       R13
  140008b94: 48 83 ec 20               SUB        RSP,0x20
  140008b98: 4d 8b e0                  MOV        R12,R8
  140008b9b: 48 8b da                  MOV        RBX,RDX
  140008b9e: 48 8b e9                  MOV        RBP,RCX
  140008ba1: 33 ff                     XOR        EDI,EDI
  140008ba3: 48 8d 35 9a b4 ff ff      LEA        RSI,[0x140004044]
  140008baa: 4c 8d 2d 7f b4 ff ff      LEA        R13,[0x140004030]
  140008bb1: 44 8b 06                  MOV        R8D,dword ptr [RSI]
  140008bb4: 4c 8d 0c 7f               LEA        R9,[RDI + RDI*0x2]
  140008bb8: 48 8b cd                  MOV        RCX,RBP
  140008bbb: 4b 8d 54 cd 0c            LEA        RDX,[R13 + R9*0x8 + 0xc]
  140008bc0: e8 f2 99 ff ff            CALL       0x1400025b7
  140008bc5: 85 c0                     TEST       EAX,EAX
  140008bc7: 74 16                     JZ         0x140008bdf
  140008bc9: ff c7                     INC        EDI
  140008bcb: 48 83 c6 18               ADD        RSI,0x18
  140008bcf: 83 ff 0c                  CMP        EDI,0xc
  140008bd2: 72 dd                     JC         0x140008bb1
  140008bd4: 48 83 23 00               AND        qword ptr [RBX],0x0
  140008bd8: b8 73 00 00 c0            MOV        EAX,0xc0000073
  140008bdd: eb 46                     JMP        0x140008c25
  140008bdf: 48 8d 3c 7f               LEA        RDI,[RDI + RDI*0x2]
  140008be3: 41 8b 44 fd 14            MOV        EAX,dword ptr [R13 + RDI*0x8 + 0x14]
  140008be8: 48 8d 54 45 00            LEA        RDX,[RBP + RAX*0x2]
  140008bed: 49 89 14 24               MOV        qword ptr [R12],RDX
  140008bf1: 41 83 7c fd 08 01         CMP        dword ptr [R13 + RDI*0x8 + 0x8],0x1
  140008bf7: 75 14                     JNZ        0x140008c0d
  140008bf9: b2 20                     MOV        DL,0x20
  140008bfb: b1 01                     MOV        CL,0x1
  140008bfd: ff 15 35 a5 ff ff         CALL       qword ptr [0x140003138]
  140008c03: 84 c0                     TEST       AL,AL
  140008c05: 75 06                     JNZ        0x140008c0d
  140008c07: 48 83 23 00               AND        qword ptr [RBX],0x0
  140008c0b: eb 16                     JMP        0x140008c23
  140008c0d: 48 8b 05 2c a5 ff ff      MOV        RAX,qword ptr [0x140003140]
  140008c14: 49 8b 54 fd 00            MOV        RDX,qword ptr [R13 + RDI*0x8]
  140008c19: 48 8b 08                  MOV        RCX,qword ptr [RAX]
  140008c1c: 48 8b 04 0a               MOV        RAX,qword ptr [RDX + RCX*0x1]
  140008c20: 48 89 03                  MOV        qword ptr [RBX],RAX
  140008c23: 33 c0                     XOR        EAX,EAX
  140008c25: 48 8b 5c 24 40            MOV        RBX,qword ptr [RSP + 0x40]
  140008c2a: 48 8b 6c 24 48            MOV        RBP,qword ptr [RSP + 0x48]
  140008c2f: 48 8b 74 24 50            MOV        RSI,qword ptr [RSP + 0x50]
  140008c34: 48 83 c4 20               ADD        RSP,0x20
  140008c38: 41 5d                     POP        R13
  140008c3a: 41 5c                     POP        R12
  140008c3c: 5f                        POP        RDI
  140008c3d: c3                        RET
  140008c3e: cc                        INT3
  140008c3f: cc                        INT3

sub_140008c40:  ; 0x140008c40
; arg:   param_1 (short *)
; arg:   param_2 (long long *)
; arg:   param_3 (long long *)
; stack: v10 @ [stack+0x8] (unsigned int[2])
; stack: v13 @ [stack+0x10] (unsigned int[2])
; stack: v9 @ [stack+0x18] (unsigned int[2])
; stack: v8 @ [stack+0x20] (short *)
; stack: v11 @ [stack-0x58] (short *)
; stack: v12 @ [stack-0x50] (long long[2])
; stack: local_a0 @ [stack-0xa0] (undefined8)
; stack: local_98 @ [stack-0x98] (undefined32)
; stack: local_78 @ [stack-0x78] (unsigned int)
; stack: local_74 @ [stack-0x74] (undefined28)
; stack: local_40 @ [stack-0x40] (undefined8)
; stack: local_38 @ [stack-0x38] (undefined8)
; stack: local_30 @ [stack-0x30] (undefined8)
; stack: local_28 @ [stack-0x28] (undefined8)
; stack: local_20 @ [stack-0x20] (undefined8)
; stack: local_18 @ [stack-0x18] (undefined8)
; stack: local_10 @ [stack-0x10] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
  140008c40: 40 53                     PUSH       RBX
  140008c42: 55                        PUSH       RBP
  140008c43: 56                        PUSH       RSI
  140008c44: 57                        PUSH       RDI
  140008c45: 41 54                     PUSH       R12
  140008c47: 41 55                     PUSH       R13
  140008c49: 41 56                     PUSH       R14
  140008c4b: 41 57                     PUSH       R15
  140008c4d: 48 83 ec 58               SUB        RSP,0x58
  140008c51: 45 33 ff                  XOR        R15D,R15D
  140008c54: 4c 8b ea                  MOV        R13,RDX
  140008c57: 49 8b e8                  MOV        RBP,R8
  140008c5a: 4c 89 3a                  MOV        qword ptr [RDX],R15
  140008c5d: 41 8d 57 3a               LEA        EDX,[R15 + 0x3a]
  140008c61: 48 8b d9                  MOV        RBX,RCX
  140008c64: 41 8b f7                  MOV        ESI,R15D
  140008c67: 45 8b e7                  MOV        R12D,R15D
  140008c6a: 4c 89 7c 24 48            MOV        qword ptr [RSP + 0x48],R15
  140008c6f: e8 3d 99 ff ff            CALL       0x1400025b1
  140008c74: 48 89 45 00               MOV        qword ptr [RBP],RAX
  140008c78: 48 3b c3                  CMP        RAX,RBX
  140008c7b: 75 0a                     JNZ        0x140008c87
  140008c7d: b8 0d 00 00 c0            MOV        EAX,0xc000000d
  140008c82: e9 61 03 00 00            JMP        0x140008fe8
  140008c87: 41 b9 01 00 00 00         MOV        R9D,0x1
  140008c8d: 49 3b c7                  CMP        RAX,R15
  140008c90: 75 18                     JNZ        0x140008caa
  140008c92: 33 c0                     XOR        EAX,EAX
  140008c94: 48 83 c9 ff               OR         RCX,-0x1
  140008c98: 48 8b fb                  MOV        RDI,RBX
  140008c9b: 66 f2 af                  SCASW.REPNE RDI
  140008c9e: 48 f7 d1                  NOT        RCX
  140008ca1: 49 2b c9                  SUB        RCX,R9
  140008ca4: 48 8d 04 4b               LEA        RAX,[RBX + RCX*0x2]
  140008ca8: eb 04                     JMP        0x140008cae
  140008caa: 48 83 c0 fe               ADD        RAX,-0x2
  140008cae: 48 89 45 00               MOV        qword ptr [RBP],RAX
  140008cb2: 41 8b ff                  MOV        EDI,R15D
  140008cb5: 48 8b c3                  MOV        RAX,RBX
  140008cb8: 48 3b 5d 00               CMP        RBX,qword ptr [RBP]
  140008cbc: 73 20                     JNC        0x140008cde
  140008cbe: 48 8b 4d 00               MOV        RCX,qword ptr [RBP]
  140008cc2: 66 83 38 3b               CMP        word ptr [RAX],0x3b
  140008cc6: 75 05                     JNZ        0x140008ccd
  140008cc8: 45 03 e1                  ADD        R12D,R9D
  140008ccb: eb 08                     JMP        0x140008cd5
  140008ccd: 66 83 38 20               CMP        word ptr [RAX],0x20
  140008cd1: 41 0f 45 f9               CMOVNZ     EDI,R9D
  140008cd5: 48 83 c0 02               ADD        RAX,0x2
  140008cd9: 48 3b c1                  CMP        RAX,RCX
  140008cdc: 72 e4                     JC         0x140008cc2
  140008cde: b8 cd cc cc cc            MOV        EAX,0xcccccccd
  140008ce3: 41 f7 e4                  MUL        R12D
  140008ce6: 44 8b f2                  MOV        R14D,EDX
  140008ce9: 41 c1 ee 02               SHR        R14D,0x2
  140008ced: 43 8d 0c b6               LEA        ECX,[R14 + R14*0x4]
  140008cf1: 44 3b e1                  CMP        R12D,ECX
  140008cf4: 0f 85 e7 02 00 00         JNZ        0x140008fe1
  140008cfa: 45 3b e7                  CMP        R12D,R15D
  140008cfd: 75 09                     JNZ        0x140008d08
  140008cff: 41 3b ff                  CMP        EDI,R15D
  140008d02: 0f 85 d9 02 00 00         JNZ        0x140008fe1
  140008d08: bf 08 00 00 00            MOV        EDI,0x8
  140008d0d: 41 b8 53 65 41 6c         MOV        R8D,0x6c416553
  140008d13: 41 8b c9                  MOV        ECX,R9D
  140008d16: 45 3b f7                  CMP        R14D,R15D
  140008d19: 75 45                     JNZ        0x140008d60
  140008d1b: 48 8b d7                  MOV        RDX,RDI
  140008d1e: ff 15 1c a3 ff ff         CALL       qword ptr [0x140003040]
  140008d24: 49 89 45 00               MOV        qword ptr [R13],RAX
  140008d28: 49 3b c7                  CMP        RAX,R15
  140008d2b: 74 5a                     JZ         0x140008d87
  140008d2d: 33 c9                     XOR        ECX,ECX
  140008d2f: 48 89 08                  MOV        qword ptr [RAX],RCX
  140008d32: 49 8b 4d 00               MOV        RCX,qword ptr [R13]
  140008d36: c6 01 02                  MOV        byte ptr [RCX],0x2
  140008d39: 49 8b 4d 00               MOV        RCX,qword ptr [R13]
  140008d3d: 44 88 79 01               MOV        byte ptr [RCX + 0x1],R15B
  140008d41: 49 8b 4d 00               MOV        RCX,qword ptr [R13]
  140008d45: 66 89 79 02               MOV        word ptr [RCX + 0x2],DI
  140008d49: 49 8b 4d 00               MOV        RCX,qword ptr [R13]
  140008d4d: 66 44 89 79 04            MOV        word ptr [RCX + 0x4],R15W
  140008d52: 49 8b 4d 00               MOV        RCX,qword ptr [R13]
  140008d56: 66 44 89 79 06            MOV        word ptr [RCX + 0x6],R15W
  140008d5b: e9 86 02 00 00            JMP        0x140008fe6
  140008d60: b8 ff ff 00 00            MOV        EAX,0xffff
  140008d65: 43 8d 2c 76               LEA        EBP,[R14 + R14*0x2]
  140008d69: c1 e5 04                  SHL        EBP,0x4
  140008d6c: 03 ef                     ADD        EBP,EDI
  140008d6e: 3b e8                     CMP        EBP,EAX
  140008d70: 0f 47 e8                  CMOVA      EBP,EAX
  140008d73: 8b d5                     MOV        EDX,EBP
  140008d75: 44 8b e5                  MOV        R12D,EBP
  140008d78: ff 15 c2 a2 ff ff         CALL       qword ptr [0x140003040]
  140008d7e: 49 89 45 00               MOV        qword ptr [R13],RAX
  140008d82: 49 3b c7                  CMP        RAX,R15
  140008d85: 75 0a                     JNZ        0x140008d91
  140008d87: be 9a 00 00 c0            MOV        ESI,0xc000009a
  140008d8c: e9 55 02 00 00            JMP        0x140008fe6
  140008d91: 4d 8b c4                  MOV        R8,R12
  140008d94: 33 d2                     XOR        EDX,EDX
  140008d96: 48 8b c8                  MOV        RCX,RAX
  140008d99: 89 bc 24 a8 00 00 00      MOV        dword ptr [RSP + 0xa8],EDI
  140008da0: e8 4b 83 ff ff            CALL       0x1400010f0
  140008da5: 49 8b 55 00               MOV        RDX,qword ptr [R13]
  140008da9: c6 02 02                  MOV        byte ptr [RDX],0x2
  140008dac: 49 8b 45 00               MOV        RAX,qword ptr [R13]
  140008db0: 45 8b e7                  MOV        R12D,R15D
  140008db3: 44 88 78 01               MOV        byte ptr [RAX + 0x1],R15B
  140008db7: 49 8b 45 00               MOV        RAX,qword ptr [R13]
  140008dbb: 66 89 68 02               MOV        word ptr [RAX + 0x2],BP
  140008dbf: 49 8b 45 00               MOV        RAX,qword ptr [R13]
  140008dc3: 66 44 89 78 04            MOV        word ptr [RAX + 0x4],R15W
  140008dc8: 49 8b 45 00               MOV        RAX,qword ptr [R13]
  140008dcc: 66 44 89 78 06            MOV        word ptr [RAX + 0x6],R15W
  140008dd1: 45 3b f7                  CMP        R14D,R15D
  140008dd4: 0f 86 fd 01 00 00         JBE        0x140008fd7
  140008dda: bf 0d 00 00 c0            MOV        EDI,0xc000000d
  140008ddf: 41 8b ef                  MOV        EBP,R15D
  140008de2: 44 89 bc 24 a0 00 00 00   MOV        dword ptr [RSP + 0xa0],R15D
  140008dea: eb 04                     JMP        0x140008df0
  140008dec: 48 83 c3 02               ADD        RBX,0x2
  140008df0: 66 83 3b 20               CMP        word ptr [RBX],0x20
  140008df4: 74 f6                     JZ         0x140008dec
  140008df6: 66 83 3b 28               CMP        word ptr [RBX],0x28
  140008dfa: 75 04                     JNZ        0x140008e00
  140008dfc: 48 83 c3 02               ADD        RBX,0x2
  140008e00: 66 83 3b 20               CMP        word ptr [RBX],0x20
  140008e04: 74 f6                     JZ         0x140008dfc
  140008e06: 48 8d 15 1b a9 ff ff      LEA        RDX,[0x140003728]
  140008e0d: 41 b8 01 00 00 00         MOV        R8D,0x1
  140008e13: 48 8b cb                  MOV        RCX,RBX
  140008e16: e8 9c 97 ff ff            CALL       0x1400025b7
  140008e1b: 41 3b c7                  CMP        EAX,R15D
  140008e1e: 0f 85 93 01 00 00         JNZ        0x140008fb7
  140008e24: 48 83 c3 04               ADD        RBX,0x4
  140008e28: eb 04                     JMP        0x140008e2e
  140008e2a: 48 83 c3 02               ADD        RBX,0x2
  140008e2e: 66 83 3b 20               CMP        word ptr [RBX],0x20
  140008e32: 74 f6                     JZ         0x140008e2a
  140008e34: 66 83 3b 3b               CMP        word ptr [RBX],0x3b
  140008e38: 0f 85 75 01 00 00         JNZ        0x140008fb3
  140008e3e: 48 83 c3 02               ADD        RBX,0x2
  140008e42: 66 83 3b 20               CMP        word ptr [RBX],0x20
  140008e46: 74 f6                     JZ         0x140008e3e
  140008e48: 66 83 3b 3b               CMP        word ptr [RBX],0x3b
  140008e4c: 75 1b                     JNZ        0x140008e69
  140008e4e: 48 83 c3 02               ADD        RBX,0x2
  140008e52: 41 3b f7                  CMP        ESI,R15D
  140008e55: 0f 85 63 01 00 00         JNZ        0x140008fbe
  140008e5b: b8 02 00 00 00            MOV        EAX,0x2
  140008e60: e9 84 00 00 00            JMP        0x140008ee9
  140008e65: 48 83 c3 02               ADD        RBX,0x2
  140008e69: 66 83 3b 20               CMP        word ptr [RBX],0x20
  140008e6d: 74 f6                     JZ         0x140008e65
  140008e6f: 4c 8d 84 24 b8 00 00 00   LEA        R8,[RSP + 0xb8]
  140008e77: 48 8d 94 24 b0 00 00 00   LEA        RDX,[RSP + 0xb0]
  140008e7f: 48 8b cb                  MOV        RCX,RBX
  140008e82: e8 65 fc ff ff            CALL       0x140008aec
  140008e87: 41 3b c7                  CMP        EAX,R15D
  140008e8a: 74 18                     JZ         0x140008ea4
  140008e8c: 0b ac 24 b0 00 00 00      OR         EBP,dword ptr [RSP + 0xb0]
  140008e93: 48 8b 84 24 b8 00 00 00   MOV        RAX,qword ptr [RSP + 0xb8]
  140008e9b: 89 ac 24 a0 00 00 00      MOV        dword ptr [RSP + 0xa0],EBP
  140008ea2: eb 2c                     JMP        0x140008ed0
  140008ea4: 4c 8d 84 24 a0 00 00 00   LEA        R8,[RSP + 0xa0]
  140008eac: 48 8d 94 24 b8 00 00 00   LEA        RDX,[RSP + 0xb8]
  140008eb4: 48 8b cb                  MOV        RCX,RBX
  140008eb7: e8 74 fa ff ff            CALL       0x140008930
  140008ebc: 48 8b 84 24 b8 00 00 00   MOV        RAX,qword ptr [RSP + 0xb8]
  140008ec4: 8b ac 24 a0 00 00 00      MOV        EBP,dword ptr [RSP + 0xa0]
  140008ecb: 48 3b c3                  CMP        RAX,RBX
  140008ece: 74 0e                     JZ         0x140008ede
  140008ed0: 66 83 38 3b               CMP        word ptr [RAX],0x3b
  140008ed4: 48 8b d8                  MOV        RBX,RAX
  140008ed7: 75 90                     JNZ        0x140008e69
  140008ed9: e9 70 ff ff ff            JMP        0x140008e4e
  140008ede: 8b f7                     MOV        ESI,EDI
  140008ee0: e9 6d ff ff ff            JMP        0x140008e52
  140008ee5: 48 83 c3 02               ADD        RBX,0x2
  140008ee9: 66 83 3b 20               CMP        word ptr [RBX],0x20
  140008eed: 74 f6                     JZ         0x140008ee5
  140008eef: 66 83 3b 3b               CMP        word ptr [RBX],0x3b
  140008ef3: 0f 45 f7                  CMOVNZ     ESI,EDI
  140008ef6: 48 83 c3 02               ADD        RBX,0x2
  140008efa: 48 83 e8 01               SUB        RAX,0x1
  140008efe: 75 e9                     JNZ        0x140008ee9
  140008f00: 41 3b f7                  CMP        ESI,R15D
  140008f03: 0f 85 b5 00 00 00         JNZ        0x140008fbe
  140008f09: eb 04                     JMP        0x140008f0f
  140008f0b: 48 83 c3 02               ADD        RBX,0x2
  140008f0f: 66 83 3b 20               CMP        word ptr [RBX],0x20
  140008f13: 74 f6                     JZ         0x140008f0b
  140008f15: 4c 8d 44 24 40            LEA        R8,[RSP + 0x40]
  140008f1a: 48 8d 54 24 48            LEA        RDX,[RSP + 0x48]
  140008f1f: 48 8b cb                  MOV        RCX,RBX
  140008f22: e8 59 fc ff ff            CALL       0x140008b80
  140008f27: 8b f0                     MOV        ESI,EAX
  140008f29: 41 3b c7                  CMP        EAX,R15D
  140008f2c: 0f 85 8c 00 00 00         JNZ        0x140008fbe
  140008f32: 48 8b 5c 24 40            MOV        RBX,qword ptr [RSP + 0x40]
  140008f37: 49 3b df                  CMP        RBX,R15
  140008f3a: 74 70                     JZ         0x140008fac
  140008f3c: 66 83 3b 20               CMP        word ptr [RBX],0x20
  140008f40: 75 0f                     JNZ        0x140008f51
  140008f42: 48 83 c3 02               ADD        RBX,0x2
  140008f46: 66 83 3b 20               CMP        word ptr [RBX],0x20
  140008f4a: 74 f6                     JZ         0x140008f42
  140008f4c: 48 89 5c 24 40            MOV        qword ptr [RSP + 0x40],RBX
  140008f51: 66 83 3b 29               CMP        word ptr [RBX],0x29
  140008f55: 75 55                     JNZ        0x140008fac
  140008f57: 48 8b 4c 24 48            MOV        RCX,qword ptr [RSP + 0x48]
  140008f5c: 48 83 c3 02               ADD        RBX,0x2
  140008f60: 49 3b cf                  CMP        RCX,R15
  140008f63: 74 30                     JZ         0x140008f95
  140008f65: 48 89 4c 24 30            MOV        qword ptr [RSP + 0x30],RCX
  140008f6a: 41 8b c6                  MOV        EAX,R14D
  140008f6d: 48 8d 94 24 a8 00 00 00   LEA        RDX,[RSP + 0xa8]
  140008f75: 41 2b c4                  SUB        EAX,R12D
  140008f78: 45 33 c9                  XOR        R9D,R9D
  140008f7b: 45 33 c0                  XOR        R8D,R8D
  140008f7e: 89 44 24 28               MOV        dword ptr [RSP + 0x28],EAX
  140008f82: 49 8b cd                  MOV        RCX,R13
  140008f85: 89 6c 24 20               MOV        dword ptr [RSP + 0x20],EBP
  140008f89: e8 7e fa ff ff            CALL       0x140008a0c
  140008f8e: 8b f0                     MOV        ESI,EAX
  140008f90: 41 3b c7                  CMP        EAX,R15D
  140008f93: 75 29                     JNZ        0x140008fbe
  140008f95: 66 83 3b 28               CMP        word ptr [RBX],0x28
  140008f99: 75 04                     JNZ        0x140008f9f
  140008f9b: 48 83 c3 02               ADD        RBX,0x2
  140008f9f: 41 ff c4                  INC        R12D
  140008fa2: 45 3b e6                  CMP        R12D,R14D
  140008fa5: 73 12                     JNC        0x140008fb9
  140008fa7: e9 33 fe ff ff            JMP        0x140008ddf
  140008fac: be 77 00 00 c0            MOV        ESI,0xc0000077
  140008fb1: eb 0b                     JMP        0x140008fbe
  140008fb3: 8b f7                     MOV        ESI,EDI
  140008fb5: eb 07                     JMP        0x140008fbe
  140008fb7: 8b f7                     MOV        ESI,EDI
  140008fb9: 41 3b f7                  CMP        ESI,R15D
  140008fbc: 74 12                     JZ         0x140008fd0
  140008fbe: 49 8b 4d 00               MOV        RCX,qword ptr [R13]
  140008fc2: 33 d2                     XOR        EDX,EDX
  140008fc4: ff 15 86 a0 ff ff         CALL       qword ptr [0x140003050]
  140008fca: 4d 89 7d 00               MOV        qword ptr [R13],R15
  140008fce: eb 16                     JMP        0x140008fe6
  140008fd0: 8b bc 24 a8 00 00 00      MOV        EDI,dword ptr [RSP + 0xa8]
  140008fd7: 49 8b 45 00               MOV        RAX,qword ptr [R13]
  140008fdb: 66 89 78 02               MOV        word ptr [RAX + 0x2],DI
  140008fdf: eb 05                     JMP        0x140008fe6
  140008fe1: be 0d 00 00 c0            MOV        ESI,0xc000000d
  140008fe6: 8b c6                     MOV        EAX,ESI
  140008fe8: 48 83 c4 58               ADD        RSP,0x58
  140008fec: 41 5f                     POP        R15
  140008fee: 41 5e                     POP        R14
  140008ff0: 41 5d                     POP        R13
  140008ff2: 41 5c                     POP        R12
  140008ff4: 5f                        POP        RDI
  140008ff5: 5e                        POP        RSI
  140008ff6: 5d                        POP        RBP
  140008ff7: 5b                        POP        RBX
  140008ff8: c3                        RET
  140008ff9: cc                        INT3
  140008ffa: cc                        INT3
  140008ffb: cc                        INT3

sub_140008ffc:  ; 0x140008ffc
; arg:   param_1 (short *)
; arg:   param_2 (int)
; arg:   param_3 (unsigned int *)
; arg:   param_4 (long long *)
; stack: v4 @ [stack+0x8] (long long)
; stack: v3 @ [stack+0x18] (short *)
; stack: local_40 @ [stack-0x40] (undefined40)
; stack: local_18 @ [stack-0x18] (undefined8)
; stack: local_10 @ [stack-0x10] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined8)
; stack: stack_20 @ [stack+0x20] (undefined8)
  140008ffc: 48 89 5c 24 10            MOV        qword ptr [RSP + 0x10],RBX
  140009001: 48 89 6c 24 20            MOV        qword ptr [RSP + 0x20],RBP
  140009006: 56                        PUSH       RSI
  140009007: 57                        PUSH       RDI
  140009008: 41 54                     PUSH       R12
  14000900a: 48 83 ec 20               SUB        RSP,0x20
  14000900e: 45 33 e4                  XOR        R12D,R12D
  140009011: 49 8b f1                  MOV        RSI,R9
  140009014: 49 8b e8                  MOV        RBP,R8
  140009017: 4d 89 21                  MOV        qword ptr [R9],R12
  14000901a: 45 89 20                  MOV        dword ptr [R8],R12D
  14000901d: eb 04                     JMP        0x140009023
  14000901f: 48 83 c1 02               ADD        RCX,0x2
  140009023: 66 83 39 20               CMP        word ptr [RCX],0x20
  140009027: 74 f6                     JZ         0x14000901f
  140009029: 66 83 39 44               CMP        word ptr [RCX],0x44
  14000902d: 74 07                     JZ         0x140009036
  14000902f: b8 0d 00 00 c0            MOV        EAX,0xc000000d
  140009034: eb 66                     JMP        0x14000909c
  140009036: 66 83 79 02 3a            CMP        word ptr [RCX + 0x2],0x3a
  14000903b: 75 f2                     JNZ        0x14000902f
  14000903d: 48 83 c1 04               ADD        RCX,0x4
  140009041: f7 da                     NEG        EDX
  140009043: 1b ff                     SBB        EDI,EDI
  140009045: 83 e7 08                  AND        EDI,0x8
  140009048: 66 83 39 50               CMP        word ptr [RCX],0x50
  14000904c: 75 08                     JNZ        0x140009056
  14000904e: 48 83 c1 02               ADD        RCX,0x2
  140009052: 0f ba ef 0c               BTS        EDI,0xc
  140009056: 4c 8d 44 24 50            LEA        R8,[RSP + 0x50]
  14000905b: 48 8d 54 24 40            LEA        RDX,[RSP + 0x40]
  140009060: e8 db fb ff ff            CALL       0x140008c40
  140009065: 8b d8                     MOV        EBX,EAX
  140009067: 41 3b c4                  CMP        EAX,R12D
  14000906a: 75 1c                     JNZ        0x140009088
  14000906c: 48 8b 44 24 50            MOV        RAX,qword ptr [RSP + 0x50]
  140009071: eb 04                     JMP        0x140009077
  140009073: 48 83 c0 02               ADD        RAX,0x2
  140009077: 66 83 38 20               CMP        word ptr [RAX],0x20
  14000907b: 74 f6                     JZ         0x140009073
  14000907d: 66 44 39 20               CMP        word ptr [RAX],R12W
  140009081: 74 2c                     JZ         0x1400090af
  140009083: bb 0d 00 00 c0            MOV        EBX,0xc000000d
  140009088: 48 8b 4c 24 40            MOV        RCX,qword ptr [RSP + 0x40]
  14000908d: 49 3b cc                  CMP        RCX,R12
  140009090: 74 08                     JZ         0x14000909a
  140009092: 33 d2                     XOR        EDX,EDX
  140009094: ff 15 b6 9f ff ff         CALL       qword ptr [0x140003050]
  14000909a: 8b c3                     MOV        EAX,EBX
  14000909c: 48 8b 5c 24 48            MOV        RBX,qword ptr [RSP + 0x48]
  1400090a1: 48 8b 6c 24 58            MOV        RBP,qword ptr [RSP + 0x58]
  1400090a6: 48 83 c4 20               ADD        RSP,0x20
  1400090aa: 41 5c                     POP        R12
  1400090ac: 5f                        POP        RDI
  1400090ad: 5e                        POP        RSI
  1400090ae: c3                        RET
  1400090af: 48 8b 44 24 40            MOV        RAX,qword ptr [RSP + 0x40]
  1400090b4: 48 89 06                  MOV        qword ptr [RSI],RAX
  1400090b7: 89 7d 00                  MOV        dword ptr [RBP],EDI
  1400090ba: eb de                     JMP        0x14000909a

sub_1400090bc:  ; 0x1400090bc
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned long long)
; arg:   param_3 (long long *)
; stack: v7 @ [stack+0x18] (unsigned int[2])
; stack: v4 @ [stack+0x20] (unsigned short[4])
; stack: v5 @ [stack-0x38] (long long)
; stack: v6 @ [stack-0x30] (char[2])
; stack: v8 @ [stack-0x2e] (unsigned short)
; stack: local_60 @ [stack-0x60] (undefined8)
; stack: local_58 @ [stack-0x58] (undefined32)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined8)
  1400090bc: 48 8b c4                  MOV        RAX,RSP
  1400090bf: 48 89 58 08               MOV        qword ptr [RAX + 0x8],RBX
  1400090c3: 48 89 68 10               MOV        qword ptr [RAX + 0x10],RBP
  1400090c7: 57                        PUSH       RDI
  1400090c8: 48 83 ec 50               SUB        RSP,0x50
  1400090cc: 48 83 60 c8 00            AND        qword ptr [RAX + -0x38],0x0
  1400090d1: 49 8b e8                  MOV        RBP,R8
  1400090d4: 33 ff                     XOR        EDI,EDI
  1400090d6: 49 21 38                  AND        qword ptr [R8],RDI
  1400090d9: 4c 8d 40 20               LEA        R8,[RAX + 0x20]
  1400090dd: 4c 8d 48 c8               LEA        R9,[RAX + -0x38]
  1400090e1: e8 16 ff ff ff            CALL       0x140008ffc
  1400090e6: 8b d8                     MOV        EBX,EAX
  1400090e8: 85 c0                     TEST       EAX,EAX
  1400090ea: 78 66                     JS         0x140009152
  1400090ec: 8d 5f 01                  LEA        EBX,[RDI + 0x1]
  1400090ef: 48 8d 4c 24 28            LEA        RCX,[RSP + 0x28]
  1400090f4: 8b d3                     MOV        EDX,EBX
  1400090f6: ff 15 24 a0 ff ff         CALL       qword ptr [0x140003120]
  1400090fc: 4c 8b 44 24 20            MOV        R8,qword ptr [RSP + 0x20]
  140009101: 48 8d 4c 24 28            LEA        RCX,[RSP + 0x28]
  140009106: 45 33 c9                  XOR        R9D,R9D
  140009109: 8a d3                     MOV        DL,BL
  14000910b: ff 15 17 a0 ff ff         CALL       qword ptr [0x140003128]
  140009111: 44 0f b7 5c 24 78         MOVZX      R11D,word ptr [RSP + 0x78]
  140009117: 21 7c 24 70               AND        dword ptr [RSP + 0x70],EDI
  14000911b: 66 44 09 5c 24 2a         OR         word ptr [RSP + 0x2a],R11W
  140009121: 4c 8d 44 24 70            LEA        R8,[RSP + 0x70]
  140009126: 48 8d 4c 24 28            LEA        RCX,[RSP + 0x28]
  14000912b: 33 d2                     XOR        EDX,EDX
  14000912d: ff 15 fd 9f ff ff         CALL       qword ptr [0x140003130]
  140009133: 8b 54 24 70               MOV        EDX,dword ptr [RSP + 0x70]
  140009137: 41 b8 53 65 53 64         MOV        R8D,0x64536553
  14000913d: 8b cb                     MOV        ECX,EBX
  14000913f: ff 15 fb 9e ff ff         CALL       qword ptr [0x140003040]
  140009145: 48 8b f8                  MOV        RDI,RAX
  140009148: 48 85 c0                  TEST       RAX,RAX
  14000914b: 75 3c                     JNZ        0x140009189
  14000914d: bb 9a 00 00 c0            MOV        EBX,0xc000009a
  140009152: 48 83 7c 24 20 00         CMP        qword ptr [RSP + 0x20],0x0
  140009158: 74 0d                     JZ         0x140009167
  14000915a: 48 8b 4c 24 20            MOV        RCX,qword ptr [RSP + 0x20]
  14000915f: 33 d2                     XOR        EDX,EDX
  140009161: ff 15 e9 9e ff ff         CALL       qword ptr [0x140003050]
  140009167: 48 85 ff                  TEST       RDI,RDI
  14000916a: 74 0b                     JZ         0x140009177
  14000916c: 33 d2                     XOR        EDX,EDX
  14000916e: 48 8b cf                  MOV        RCX,RDI
  140009171: ff 15 d9 9e ff ff         CALL       qword ptr [0x140003050]
  140009177: 48 8b 6c 24 68            MOV        RBP,qword ptr [RSP + 0x68]
  14000917c: 8b c3                     MOV        EAX,EBX
  14000917e: 48 8b 5c 24 60            MOV        RBX,qword ptr [RSP + 0x60]
  140009183: 48 83 c4 50               ADD        RSP,0x50
  140009187: 5f                        POP        RDI
  140009188: c3                        RET
  140009189: 4c 8d 44 24 70            LEA        R8,[RSP + 0x70]
  14000918e: 48 8d 4c 24 28            LEA        RCX,[RSP + 0x28]
  140009193: 48 8b d0                  MOV        RDX,RAX
  140009196: ff 15 94 9f ff ff         CALL       qword ptr [0x140003130]
  14000919c: 8b d8                     MOV        EBX,EAX
  14000919e: 85 c0                     TEST       EAX,EAX
  1400091a0: 78 b0                     JS         0x140009152
  1400091a2: 48 8b 4c 24 20            MOV        RCX,qword ptr [RSP + 0x20]
  1400091a7: 33 d2                     XOR        EDX,EDX
  1400091a9: ff 15 a1 9e ff ff         CALL       qword ptr [0x140003050]
  1400091af: 48 89 7d 00               MOV        qword ptr [RBP],RDI
  1400091b3: eb c2                     JMP        0x140009177
  1400091b5: cc                        INT3
  1400091b6: cc                        INT3
  1400091b7: cc                        INT3

sub_1400091b8:  ; 0x1400091b8
; arg:   param_1 (struct_7 *)
; arg:   param_2 (unsigned int)
; arg:   param_3 (unsigned long long *)
; stack: local_30 @ [stack-0x30] (undefined40)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined8)
; stack: stack_18 @ [stack+0x18] (undefined8)
; stack: stack_20 @ [stack+0x20] (undefined8)
  1400091b8: 48 8b c4                  MOV        RAX,RSP
  1400091bb: 48 89 58 08               MOV        qword ptr [RAX + 0x8],RBX
  1400091bf: 48 89 68 10               MOV        qword ptr [RAX + 0x10],RBP
  1400091c3: 48 89 70 18               MOV        qword ptr [RAX + 0x18],RSI
  1400091c7: 48 89 78 20               MOV        qword ptr [RAX + 0x20],RDI
  1400091cb: 41 54                     PUSH       R12
  1400091cd: 48 83 ec 20               SUB        RSP,0x20
  1400091d1: 44 0f b7 09               MOVZX      R9D,word ptr [RCX]
  1400091d5: 0f b7 41 02               MOVZX      EAX,word ptr [RCX + 0x2]
  1400091d9: 8b ea                     MOV        EBP,EDX
  1400091db: 49 8d 51 02               LEA        RDX,[R9 + 0x2]
  1400091df: 45 33 e4                  XOR        R12D,R12D
  1400091e2: 49 8b f8                  MOV        RDI,R8
  1400091e5: 48 8b d9                  MOV        RBX,RCX
  1400091e8: 48 3b c2                  CMP        RAX,RDX
  1400091eb: 75 17                     JNZ        0x140009204
  1400091ed: 48 8b 49 08               MOV        RCX,qword ptr [RCX + 0x8]
  1400091f1: 49 d1 e9                  SHR        R9,0x1
  1400091f4: 66 46 39 24 49            CMP        word ptr [RCX + R9*0x2],R12W
  1400091f9: 75 09                     JNZ        0x140009204
  1400091fb: 8b d5                     MOV        EDX,EBP
  1400091fd: e8 ba fe ff ff            CALL       0x1400090bc
  140009202: eb 5b                     JMP        0x14000925f
  140009204: b9 01 00 00 00            MOV        ECX,0x1
  140009209: 41 b8 53 65 54 73         MOV        R8D,0x73546553
  14000920f: ff 15 2b 9e ff ff         CALL       qword ptr [0x140003040]
  140009215: 48 8b f0                  MOV        RSI,RAX
  140009218: 49 3b c4                  CMP        RAX,R12
  14000921b: 75 0a                     JNZ        0x140009227
  14000921d: 4c 89 27                  MOV        qword ptr [RDI],R12
  140009220: b8 9a 00 00 c0            MOV        EAX,0xc000009a
  140009225: eb 38                     JMP        0x14000925f
  140009227: 44 0f b7 03               MOVZX      R8D,word ptr [RBX]
  14000922b: 48 8b 53 08               MOV        RDX,qword ptr [RBX + 0x8]
  14000922f: 48 8b c8                  MOV        RCX,RAX
  140009232: e8 b9 7f ff ff            CALL       0x1400011f0
  140009237: 44 0f b7 1b               MOVZX      R11D,word ptr [RBX]
  14000923b: 4c 8b c7                  MOV        R8,RDI
  14000923e: 49 d1 eb                  SHR        R11,0x1
  140009241: 8b d5                     MOV        EDX,EBP
  140009243: 48 8b ce                  MOV        RCX,RSI
  140009246: 66 46 89 24 5e            MOV        word ptr [RSI + R11*0x2],R12W
  14000924b: e8 6c fe ff ff            CALL       0x1400090bc
  140009250: 33 d2                     XOR        EDX,EDX
  140009252: 48 8b ce                  MOV        RCX,RSI
  140009255: 8b d8                     MOV        EBX,EAX
  140009257: ff 15 f3 9d ff ff         CALL       qword ptr [0x140003050]
  14000925d: 8b c3                     MOV        EAX,EBX
  14000925f: 48 8b 5c 24 30            MOV        RBX,qword ptr [RSP + 0x30]
  140009264: 48 8b 6c 24 38            MOV        RBP,qword ptr [RSP + 0x38]
  140009269: 48 8b 74 24 40            MOV        RSI,qword ptr [RSP + 0x40]
  14000926e: 48 8b 7c 24 48            MOV        RDI,qword ptr [RSP + 0x48]
  140009273: 48 83 c4 20               ADD        RSP,0x20
  140009277: 41 5c                     POP        R12
  140009279: c3                        RET
  14000927a: cc                        INT3
  14000927b: cc                        INT3

sub_14000927c:  ; 0x14000927c
; arg:   param_1 (unsigned char)
; arg:   param_2 (unsigned int *)
  14000927c: 83 22 00                  AND        dword ptr [RDX],0x0
  14000927f: f6 c1 01                  TEST       CL,0x1
  140009282: 75 05                     JNZ        0x140009289
  140009284: f6 c1 02                  TEST       CL,0x2
  140009287: 74 06                     JZ         0x14000928f
  140009289: c7 02 00 00 08 00         MOV        dword ptr [RDX],0x80000
  14000928f: f6 c1 04                  TEST       CL,0x4
  140009292: 74 04                     JZ         0x140009298
  140009294: 0f ba 2a 12               BTS        dword ptr [RDX],0x12
  140009298: f6 c1 08                  TEST       CL,0x8
  14000929b: 74 04                     JZ         0x1400092a1
  14000929d: 0f ba 2a 18               BTS        dword ptr [RDX],0x18
  1400092a1: c3                        RET
  1400092a2: cc                        INT3
  1400092a3: cc                        INT3

sub_1400092a4:  ; 0x1400092a4
; arg:   param_1 (unsigned long long)
; arg:   param_2 (char *)
; arg:   param_3 (unsigned int *)
; stack: v3 @ [stack+0x10] (char[16])
; stack: v6 @ [stack+0x20] (char[8])
; stack: v4 @ [stack-0x28] (long long)
; stack: v5 @ [stack-0x20] (char[8])
; stack: local_50 @ [stack-0x50] (undefined40)
; stack: local_18 @ [stack-0x18] (undefined8)
; stack: local_10 @ [stack-0x10] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
  1400092a4: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  1400092a9: 55                        PUSH       RBP
  1400092aa: 56                        PUSH       RSI
  1400092ab: 57                        PUSH       RDI
  1400092ac: 48 83 ec 30               SUB        RSP,0x30
  1400092b0: c6 02 00                  MOV        byte ptr [RDX],0x0
  1400092b3: 33 c0                     XOR        EAX,EAX
  1400092b5: 49 8b f0                  MOV        RSI,R8
  1400092b8: 48 8b ea                  MOV        RBP,RDX
  1400092bb: 41 89 00                  MOV        dword ptr [R8],EAX
  1400092be: 4c 8d 44 24 58            LEA        R8,[RSP + 0x58]
  1400092c3: 48 8d 54 24 20            LEA        RDX,[RSP + 0x20]
  1400092c8: 48 8b f9                  MOV        RDI,RCX
  1400092cb: ff 15 af 9e ff ff         CALL       qword ptr [0x140003180]
  1400092d1: 85 c0                     TEST       EAX,EAX
  1400092d3: 0f 88 86 00 00 00         JS         0x14000935f
  1400092d9: 33 db                     XOR        EBX,EBX
  1400092db: 4c 8d 44 24 58            LEA        R8,[RSP + 0x58]
  1400092e0: 48 8d 54 24 20            LEA        RDX,[RSP + 0x20]
  1400092e5: 48 39 5c 24 20            CMP        qword ptr [RSP + 0x20],RBX
  1400092ea: 8d 43 01                  LEA        EAX,[RBX + 0x1]
  1400092ed: 48 8b cf                  MOV        RCX,RDI
  1400092f0: 0f 45 d8                  CMOVNZ     EBX,EAX
  1400092f3: ff 15 7f 9e ff ff         CALL       qword ptr [0x140003178]
  1400092f9: 85 c0                     TEST       EAX,EAX
  1400092fb: 78 62                     JS         0x14000935f
  1400092fd: 48 83 7c 24 20 00         CMP        qword ptr [RSP + 0x20],0x0
  140009303: 74 03                     JZ         0x140009308
  140009305: 83 cb 02                  OR         EBX,0x2
  140009308: 4c 8d 4c 24 58            LEA        R9,[RSP + 0x58]
  14000930d: 4c 8d 44 24 28            LEA        R8,[RSP + 0x28]
  140009312: 48 8d 54 24 68            LEA        RDX,[RSP + 0x68]
  140009317: 48 8b cf                  MOV        RCX,RDI
  14000931a: ff 15 48 9e ff ff         CALL       qword ptr [0x140003168]
  140009320: 85 c0                     TEST       EAX,EAX
  140009322: 78 3b                     JS         0x14000935f
  140009324: 80 7c 24 68 00            CMP        byte ptr [RSP + 0x68],0x0
  140009329: 74 03                     JZ         0x14000932e
  14000932b: 83 cb 08                  OR         EBX,0x8
  14000932e: 4c 8d 4c 24 58            LEA        R9,[RSP + 0x58]
  140009333: 4c 8d 44 24 28            LEA        R8,[RSP + 0x28]
  140009338: 48 8d 54 24 68            LEA        RDX,[RSP + 0x68]
  14000933d: 48 8b cf                  MOV        RCX,RDI
  140009340: ff 15 2a 9e ff ff         CALL       qword ptr [0x140003170]
  140009346: 85 c0                     TEST       EAX,EAX
  140009348: 78 15                     JS         0x14000935f
  14000934a: 80 7c 24 68 00            CMP        byte ptr [RSP + 0x68],0x0
  14000934f: 74 03                     JZ         0x140009354
  140009351: 83 cb 04                  OR         EBX,0x4
  140009354: 8a 44 24 58               MOV        AL,byte ptr [RSP + 0x58]
  140009358: 88 45 00                  MOV        byte ptr [RBP],AL
  14000935b: 89 1e                     MOV        dword ptr [RSI],EBX
  14000935d: 33 c0                     XOR        EAX,EAX
  14000935f: 48 8b 5c 24 50            MOV        RBX,qword ptr [RSP + 0x50]
  140009364: 48 83 c4 30               ADD        RSP,0x30
  140009368: 5f                        POP        RDI
  140009369: 5e                        POP        RSI
  14000936a: 5d                        POP        RBP
  14000936b: c3                        RET

sub_14000936c:  ; 0x14000936c
; arg:   param_1 (struct_8 *)
; arg:   param_2 (unsigned short)
; stack: local_30 @ [stack-0x30] (undefined40)
; stack: local_8 @ [stack-0x8] (undefined8)
  14000936c: 40 53                     PUSH       RBX
  14000936e: 48 83 ec 20               SUB        RSP,0x20
  140009372: 33 c0                     XOR        EAX,EAX
  140009374: 48 8b d9                  MOV        RBX,RCX
  140009377: 41 b8 50 70 55 63         MOV        R8D,0x63557050
  14000937d: 66 89 01                  MOV        word ptr [RCX],AX
  140009380: 8d 48 02                  LEA        ECX,[RAX + 0x2]
  140009383: 8d 04 11                  LEA        EAX,[RCX + RDX*0x1]
  140009386: 0f b7 d2                  MOVZX      EDX,DX
  140009389: 48 03 d1                  ADD        RDX,RCX
  14000938c: b9 01 00 00 00            MOV        ECX,0x1
  140009391: 66 89 43 02               MOV        word ptr [RBX + 0x2],AX
  140009395: ff 15 a5 9c ff ff         CALL       qword ptr [0x140003040]
  14000939b: 48 89 43 08               MOV        qword ptr [RBX + 0x8],RAX
  14000939f: 48 f7 d8                  NEG        RAX
  1400093a2: 1b c0                     SBB        EAX,EAX
  1400093a4: f7 d0                     NOT        EAX
  1400093a6: 25 9a 00 00 c0            AND        EAX,0xc000009a
  1400093ab: 48 83 c4 20               ADD        RSP,0x20
  1400093af: 5b                        POP        RBX
  1400093b0: c3                        RET
  1400093b1: cc                        INT3
  1400093b2: cc                        INT3
  1400093b3: cc                        INT3

sub_1400093b4:  ; 0x1400093b4
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned long long)
; arg:   param_3 (struct_7 *)
; stack: v3 @ [stack-0x18] (unsigned short[4])
; stack: v4 @ [stack-0x10] (long long)
; stack: local_50 @ [stack-0x50] (undefined40)
; stack: local_28 @ [stack-0x28] (long long)
; stack: local_20 @ [stack-0x20] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined8)
; stack: stack_18 @ [stack+0x18] (undefined8)
; stack: stack_20 @ [stack+0x20] (undefined8)
  1400093b4: 4c 8b dc                  MOV        R11,RSP
  1400093b7: 49 89 5b 08               MOV        qword ptr [R11 + 0x8],RBX
  1400093bb: 49 89 6b 10               MOV        qword ptr [R11 + 0x10],RBP
  1400093bf: 49 89 73 18               MOV        qword ptr [R11 + 0x18],RSI
  1400093c3: 49 89 7b 20               MOV        qword ptr [R11 + 0x20],RDI
  1400093c7: 41 54                     PUSH       R12
  1400093c9: 48 83 ec 40               SUB        RSP,0x40
  1400093cd: 41 0f b7 40 02            MOVZX      EAX,word ptr [R8 + 0x2]
  1400093d2: 48 8b ea                  MOV        RBP,RDX
  1400093d5: 41 0f b7 10               MOVZX      EDX,word ptr [R8]
  1400093d9: 2b c2                     SUB        EAX,EDX
  1400093db: 49 8b f8                  MOV        RDI,R8
  1400093de: 4c 8b e1                  MOV        R12,RCX
  1400093e1: 83 f8 02                  CMP        EAX,0x2
  1400093e4: 72 38                     JC         0x14000941e
  1400093e6: 49 8b 40 08               MOV        RAX,qword ptr [R8 + 0x8]
  1400093ea: 4c 8b ca                  MOV        R9,RDX
  1400093ed: 33 f6                     XOR        ESI,ESI
  1400093ef: 49 d1 e9                  SHR        R9,0x1
  1400093f2: 48 8b d5                  MOV        RDX,RBP
  1400093f5: 66 42 89 34 48            MOV        word ptr [RAX + R9*0x2],SI
  1400093fa: 41 0f b7 00               MOVZX      EAX,word ptr [R8]
  1400093fe: 44 8d 4e 01               LEA        R9D,[RSI + 0x1]
  140009402: 83 c0 02                  ADD        EAX,0x2
  140009405: 89 44 24 28               MOV        dword ptr [RSP + 0x28],EAX
  140009409: 49 8b 40 08               MOV        RAX,qword ptr [R8 + 0x8]
  14000940d: 45 33 c0                  XOR        R8D,R8D
  140009410: 49 89 43 d8               MOV        qword ptr [R11 + -0x28],RAX
  140009414: ff 15 86 9d ff ff         CALL       qword ptr [0x1400031a0]
  14000941a: 8b d8                     MOV        EBX,EAX
  14000941c: eb 73                     JMP        0x140009491
  14000941e: 48 8d 4c 24 30            LEA        RCX,[RSP + 0x30]
  140009423: e8 44 ff ff ff            CALL       0x14000936c
  140009428: 33 f6                     XOR        ESI,ESI
  14000942a: 3b c6                     CMP        EAX,ESI
  14000942c: 8b d8                     MOV        EBX,EAX
  14000942e: 7c 61                     JL         0x140009491
  140009430: 44 0f b7 07               MOVZX      R8D,word ptr [RDI]
  140009434: 48 8b 57 08               MOV        RDX,qword ptr [RDI + 0x8]
  140009438: 48 8b 4c 24 38            MOV        RCX,qword ptr [RSP + 0x38]
  14000943d: 66 44 89 44 24 30         MOV        word ptr [RSP + 0x30],R8W
  140009443: e8 a8 7d ff ff            CALL       0x1400011f0
  140009448: 48 8b 44 24 38            MOV        RAX,qword ptr [RSP + 0x38]
  14000944d: 44 0f b7 5c 24 30         MOVZX      R11D,word ptr [RSP + 0x30]
  140009453: 44 8d 4e 01               LEA        R9D,[RSI + 0x1]
  140009457: 45 33 c0                  XOR        R8D,R8D
  14000945a: 49 d1 eb                  SHR        R11,0x1
  14000945d: 48 8b d5                  MOV        RDX,RBP
  140009460: 49 8b cc                  MOV        RCX,R12
  140009463: 66 42 89 34 58            MOV        word ptr [RAX + R11*0x2],SI
  140009468: 0f b7 44 24 30            MOVZX      EAX,word ptr [RSP + 0x30]
  14000946d: 83 c0 02                  ADD        EAX,0x2
  140009470: 89 44 24 28               MOV        dword ptr [RSP + 0x28],EAX
  140009474: 48 8b 44 24 38            MOV        RAX,qword ptr [RSP + 0x38]
  140009479: 48 89 44 24 20            MOV        qword ptr [RSP + 0x20],RAX
  14000947e: ff 15 1c 9d ff ff         CALL       qword ptr [0x1400031a0]
  140009484: 48 8d 4c 24 30            LEA        RCX,[RSP + 0x30]
  140009489: 8b d8                     MOV        EBX,EAX
  14000948b: ff 15 27 9c ff ff         CALL       qword ptr [0x1400030b8]
  140009491: 48 8b 6c 24 58            MOV        RBP,qword ptr [RSP + 0x58]
  140009496: 48 8b 74 24 60            MOV        RSI,qword ptr [RSP + 0x60]
  14000949b: 48 8b 7c 24 68            MOV        RDI,qword ptr [RSP + 0x68]
  1400094a0: 8b c3                     MOV        EAX,EBX
  1400094a2: 48 8b 5c 24 50            MOV        RBX,qword ptr [RSP + 0x50]
  1400094a7: 48 83 c4 40               ADD        RSP,0x40
  1400094ab: 41 5c                     POP        R12
  1400094ad: c3                        RET
  1400094ae: cc                        INT3
  1400094af: cc                        INT3

sub_1400094b0:  ; 0x1400094b0
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned long long)
; arg:   param_3 (unsigned int)
; arg:   param_4 (unsigned int *)
; stack: v1 @ [stack-0x58] (char[32])
; stack: v2 @ [stack-0x28] (char[8])
; stack: v3 @ [stack-0x20] (char[4])
; stack: v4 @ [stack-0x1c] (int)
; stack: v5 @ [stack-0x14] (unsigned int)
; stack: v6 @ [stack-0x10] (unsigned long long)
; stack: local_60 @ [stack-0x60] (undefined8)
; stack: local_38 @ [stack-0x38] (undefined8)
; stack: local_30 @ [stack-0x30] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_18 @ [stack+0x18] (undefined16)
  1400094b0: 4c 8b dc                  MOV        R11,RSP
  1400094b3: 49 89 5b 18               MOV        qword ptr [R11 + 0x18],RBX
  1400094b7: 57                        PUSH       RDI
  1400094b8: 48 83 ec 50               SUB        RSP,0x50
  1400094bc: 48 8b 05 0d ad ff ff      MOV        RAX,qword ptr [0x1400041d0]
  1400094c3: 48 33 c4                  XOR        RAX,RSP
  1400094c6: 48 89 44 24 48            MOV        qword ptr [RSP + 0x48],RAX
  1400094cb: 49 8d 43 d8               LEA        RAX,[R11 + -0x28]
  1400094cf: 49 8b f9                  MOV        RDI,R9
  1400094d2: 41 8b d8                  MOV        EBX,R8D
  1400094d5: 49 89 43 d0               MOV        qword ptr [R11 + -0x30],RAX
  1400094d9: 4d 8d 4b e0               LEA        R9,[R11 + -0x20]
  1400094dd: 41 b8 02 00 00 00         MOV        R8D,0x2
  1400094e3: c7 44 24 20 10 00 00 00   MOV        dword ptr [RSP + 0x20],0x10
  1400094eb: ff 15 a7 9c ff ff         CALL       qword ptr [0x140003198]
  1400094f1: 85 c0                     TEST       EAX,EAX
  1400094f3: 78 12                     JS         0x140009507
  1400094f5: 83 7c 24 3c 04            CMP        dword ptr [RSP + 0x3c],0x4
  1400094fa: 75 06                     JNZ        0x140009502
  1400094fc: 8b 5c 24 44               MOV        EBX,dword ptr [RSP + 0x44]
  140009500: eb 05                     JMP        0x140009507
  140009502: b8 24 00 00 c0            MOV        EAX,0xc0000024
  140009507: 89 1f                     MOV        dword ptr [RDI],EBX
  140009509: 48 8b 4c 24 48            MOV        RCX,qword ptr [RSP + 0x48]
  14000950e: 48 33 cc                  XOR        RCX,RSP
  140009511: e8 2a 80 ff ff            CALL       0x140001540
  140009516: 48 8b 5c 24 70            MOV        RBX,qword ptr [RSP + 0x70]
  14000951b: 48 83 c4 50               ADD        RSP,0x50
  14000951f: 5f                        POP        RDI
  140009520: c3                        RET
  140009521: cc                        INT3
  140009522: cc                        INT3
  140009523: cc                        INT3

sub_140009524:  ; 0x140009524
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned long long)
; arg:   param_3 (unsigned int)
; arg:   param_4 (unsigned int)
; arg:   param_5 (unsigned long long)
; arg:   param_6 (unsigned int *)
; arg:   param_7 (unsigned long long *)
; stack: v3 @ [stack+0x8] (unsigned long long[4])
; stack: v2 @ [stack-0x38] (unsigned int[2])
; stack: v4 @ [stack-0x30] (unsigned long long)
; stack: v5 @ [stack-0x28] (unsigned long long)
; stack: v6 @ [stack-0x20] (unsigned int)
; stack: v7 @ [stack-0x18] (unsigned long long)
; stack: v8 @ [stack-0x10] (unsigned long long)
; stack: local_80 @ [stack-0x80] (undefined40)
; stack: local_58 @ [stack-0x58] (undefined8)
; stack: local_50 @ [stack-0x50] (undefined8)
; stack: local_48 @ [stack-0x48] (undefined16)
  140009524: 4c 8b dc                  MOV        R11,RSP
  140009527: 48 83 ec 78               SUB        RSP,0x78
  14000952b: 48 8b 84 24 a0 00 00 00   MOV        RAX,qword ptr [RSP + 0xa0]
  140009533: c7 44 24 40 30 00 00 00   MOV        dword ptr [RSP + 0x40],0x30
  14000953b: 49 89 4b d0               MOV        qword ptr [R11 + -0x30],RCX
  14000953f: c7 44 24 58 40 02 00 00   MOV        dword ptr [RSP + 0x58],0x240
  140009547: 49 83 63 f0 00            AND        qword ptr [R11 + -0x10],0x0
  14000954c: 45 8b d0                  MOV        R10D,R8D
  14000954f: 49 89 43 e8               MOV        qword ptr [R11 + -0x18],RAX
  140009553: 49 8d 43 28               LEA        RAX,[R11 + 0x28]
  140009557: 49 89 53 d8               MOV        qword ptr [R11 + -0x28],RDX
  14000955b: 49 89 43 b8               MOV        qword ptr [R11 + -0x48],RAX
  14000955f: 45 89 4b b0               MOV        dword ptr [R11 + -0x50],R9D
  140009563: 49 83 63 a8 00            AND        qword ptr [R11 + -0x58],0x0
  140009568: 4d 8d 43 c8               LEA        R8,[R11 + -0x38]
  14000956c: 49 8d 4b 08               LEA        RCX,[R11 + 0x8]
  140009570: 45 33 c9                  XOR        R9D,R9D
  140009573: 41 8b d2                  MOV        EDX,R10D
  140009576: ff 15 14 9c ff ff         CALL       qword ptr [0x140003190]
  14000957c: 44 8b d8                  MOV        R11D,EAX
  14000957f: 85 c0                     TEST       EAX,EAX
  140009581: 79 06                     JNS        0x140009589
  140009583: 33 d2                     XOR        EDX,EDX
  140009585: 33 c9                     XOR        ECX,ECX
  140009587: eb 0f                     JMP        0x140009598
  140009589: 8b 8c 24 a0 00 00 00      MOV        ECX,dword ptr [RSP + 0xa0]
  140009590: 48 8b 94 24 80 00 00 00   MOV        RDX,qword ptr [RSP + 0x80]
  140009598: 48 8b 84 24 b0 00 00 00   MOV        RAX,qword ptr [RSP + 0xb0]
  1400095a0: 48 89 10                  MOV        qword ptr [RAX],RDX
  1400095a3: 48 8b 84 24 a8 00 00 00   MOV        RAX,qword ptr [RSP + 0xa8]
  1400095ab: 48 85 c0                  TEST       RAX,RAX
  1400095ae: 74 02                     JZ         0x1400095b2
  1400095b0: 89 08                     MOV        dword ptr [RAX],ECX
  1400095b2: 41 8b c3                  MOV        EAX,R11D
  1400095b5: 48 83 c4 78               ADD        RSP,0x78
  1400095b9: c3                        RET
  1400095ba: cc                        INT3
  1400095bb: cc                        INT3

sub_1400095bc:  ; 0x1400095bc
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned long long)
; arg:   param_3 (unsigned int)
; arg:   param_4 (unsigned long long *)
; stack: v1 @ [stack+0x8] (unsigned long long[4])
; stack: v2 @ [stack-0x38] (unsigned int[2])
; stack: v3 @ [stack-0x30] (unsigned long long)
; stack: v4 @ [stack-0x28] (unsigned long long)
; stack: v5 @ [stack-0x20] (unsigned int)
; stack: v6 @ [stack-0x18] (unsigned long long)
; stack: v7 @ [stack-0x10] (unsigned long long)
; stack: local_60 @ [stack-0x60] (undefined40)
; stack: local_8 @ [stack-0x8] (undefined8)
  1400095bc: 4c 8b dc                  MOV        R11,RSP
  1400095bf: 53                        PUSH       RBX
  1400095c0: 48 83 ec 50               SUB        RSP,0x50
  1400095c4: 49 83 21 00               AND        qword ptr [R9],0x0
  1400095c8: c7 44 24 20 30 00 00 00   MOV        dword ptr [RSP + 0x20],0x30
  1400095d0: 41 8b c0                  MOV        EAX,R8D
  1400095d3: 49 89 4b d0               MOV        qword ptr [R11 + -0x30],RCX
  1400095d7: c7 44 24 38 40 02 00 00   MOV        dword ptr [RSP + 0x38],0x240
  1400095df: 49 83 63 e8 00            AND        qword ptr [R11 + -0x18],0x0
  1400095e4: 49 83 63 f0 00            AND        qword ptr [R11 + -0x10],0x0
  1400095e9: 49 89 53 d8               MOV        qword ptr [R11 + -0x28],RDX
  1400095ed: 49 8d 4b 08               LEA        RCX,[R11 + 0x8]
  1400095f1: 4d 8d 43 c8               LEA        R8,[R11 + -0x38]
  1400095f5: 8b d0                     MOV        EDX,EAX
  1400095f7: 49 8b d9                  MOV        RBX,R9
  1400095fa: ff 15 88 9b ff ff         CALL       qword ptr [0x140003188]
  140009600: 85 c0                     TEST       EAX,EAX
  140009602: 78 08                     JS         0x14000960c
  140009604: 48 8b 4c 24 60            MOV        RCX,qword ptr [RSP + 0x60]
  140009609: 48 89 0b                  MOV        qword ptr [RBX],RCX
  14000960c: 48 83 c4 50               ADD        RSP,0x50
  140009610: 5b                        POP        RBX
  140009611: c3                        RET
  140009612: cc                        INT3
  140009613: cc                        INT3

sub_140009614:  ; 0x140009614
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned long long)
; arg:   param_3 (unsigned long long)
; stack: v1 @ [stack-0x28] (char[16])
; stack: v2 @ [stack-0x18] (char[16])
; stack: local_50 @ [stack-0x50] (undefined40)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined32)
  140009614: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  140009619: 57                        PUSH       RDI
  14000961a: 48 83 ec 40               SUB        RSP,0x40
  14000961e: 48 8b d9                  MOV        RBX,RCX
  140009621: 48 8b fa                  MOV        RDI,RDX
  140009624: 48 8d 4c 24 20            LEA        RCX,[RSP + 0x20]
  140009629: 49 8b d0                  MOV        RDX,R8
  14000962c: e8 cf 79 ff ff            CALL       0x140001000
  140009631: 85 c0                     TEST       EAX,EAX
  140009633: 78 23                     JS         0x140009658
  140009635: 48 8d 4c 24 30            LEA        RCX,[RSP + 0x30]
  14000963a: 48 8b d7                  MOV        RDX,RDI
  14000963d: e8 be 79 ff ff            CALL       0x140001000
  140009642: 85 c0                     TEST       EAX,EAX
  140009644: 78 12                     JS         0x140009658
  140009646: 4c 8d 44 24 20            LEA        R8,[RSP + 0x20]
  14000964b: 48 8d 54 24 30            LEA        RDX,[RSP + 0x30]
  140009650: 48 8b cb                  MOV        RCX,RBX
  140009653: e8 5c fd ff ff            CALL       0x1400093b4
  140009658: 48 8b 5c 24 50            MOV        RBX,qword ptr [RSP + 0x50]
  14000965d: 48 83 c4 40               ADD        RSP,0x40
  140009661: 5f                        POP        RDI
  140009662: c3                        RET
  140009663: cc                        INT3

sub_140009664:  ; 0x140009664
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned long long)
; arg:   param_3 (unsigned long long)
; stack: v1 @ [stack-0x18] (char[16])
; stack: local_40 @ [stack-0x40] (undefined40)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined32)
  140009664: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  140009669: 57                        PUSH       RDI
  14000966a: 48 83 ec 30               SUB        RSP,0x30
  14000966e: 48 8b f9                  MOV        RDI,RCX
  140009671: 48 8d 4c 24 20            LEA        RCX,[RSP + 0x20]
  140009676: 49 8b d8                  MOV        RBX,R8
  140009679: e8 82 79 ff ff            CALL       0x140001000
  14000967e: 85 c0                     TEST       EAX,EAX
  140009680: 78 10                     JS         0x140009692
  140009682: 48 8d 54 24 20            LEA        RDX,[RSP + 0x20]
  140009687: 4c 8b c3                  MOV        R8,RBX
  14000968a: 48 8b cf                  MOV        RCX,RDI
  14000968d: e8 22 fd ff ff            CALL       0x1400093b4
  140009692: 48 8b 5c 24 40            MOV        RBX,qword ptr [RSP + 0x40]
  140009697: 48 83 c4 30               ADD        RSP,0x30
  14000969b: 5f                        POP        RDI
  14000969c: c3                        RET
  14000969d: cc                        INT3
  14000969e: cc                        INT3
  14000969f: cc                        INT3

sub_1400096a0:  ; 0x1400096a0
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned long long)
; arg:   param_3 (unsigned int)
; arg:   param_4 (unsigned long long)
; arg:   param_5 (unsigned int)
; stack: v1 @ [stack-0x18] (char[16])
; stack: local_50 @ [stack-0x50] (undefined40)
; stack: local_28 @ [stack-0x28] (undefined8)
; stack: local_20 @ [stack-0x20] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined24)
  1400096a0: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  1400096a5: 48 89 74 24 10            MOV        qword ptr [RSP + 0x10],RSI
  1400096aa: 57                        PUSH       RDI
  1400096ab: 48 83 ec 40               SUB        RSP,0x40
  1400096af: 48 8b f1                  MOV        RSI,RCX
  1400096b2: 48 8d 4c 24 30            LEA        RCX,[RSP + 0x30]
  1400096b7: 49 8b d9                  MOV        RBX,R9
  1400096ba: 41 8b f8                  MOV        EDI,R8D
  1400096bd: e8 3e 79 ff ff            CALL       0x140001000
  1400096c2: 85 c0                     TEST       EAX,EAX
  1400096c4: 78 21                     JS         0x1400096e7
  1400096c6: 8b 44 24 70               MOV        EAX,dword ptr [RSP + 0x70]
  1400096ca: 48 8d 54 24 30            LEA        RDX,[RSP + 0x30]
  1400096cf: 44 8b cf                  MOV        R9D,EDI
  1400096d2: 89 44 24 28               MOV        dword ptr [RSP + 0x28],EAX
  1400096d6: 45 33 c0                  XOR        R8D,R8D
  1400096d9: 48 8b ce                  MOV        RCX,RSI
  1400096dc: 48 89 5c 24 20            MOV        qword ptr [RSP + 0x20],RBX
  1400096e1: ff 15 b9 9a ff ff         CALL       qword ptr [0x1400031a0]
  1400096e7: 48 8b 5c 24 50            MOV        RBX,qword ptr [RSP + 0x50]
  1400096ec: 48 8b 74 24 58            MOV        RSI,qword ptr [RSP + 0x58]
  1400096f1: 48 83 c4 40               ADD        RSP,0x40
  1400096f5: 5f                        POP        RDI
  1400096f6: c3                        RET
  1400096f7: cc                        INT3

sub_1400096f8:  ; 0x1400096f8
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned long long)
; arg:   param_3 (unsigned int)
; arg:   param_4 (unsigned long long)
; stack: v1 @ [stack-0x18] (char[16])
; stack: local_40 @ [stack-0x40] (undefined40)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined24)
  1400096f8: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  1400096fd: 48 89 74 24 10            MOV        qword ptr [RSP + 0x10],RSI
  140009702: 57                        PUSH       RDI
  140009703: 48 83 ec 30               SUB        RSP,0x30
  140009707: 48 8b f1                  MOV        RSI,RCX
  14000970a: 48 8d 4c 24 20            LEA        RCX,[RSP + 0x20]
  14000970f: 49 8b d9                  MOV        RBX,R9
  140009712: 41 8b f8                  MOV        EDI,R8D
  140009715: e8 e6 78 ff ff            CALL       0x140001000
  14000971a: 85 c0                     TEST       EAX,EAX
  14000971c: 78 13                     JS         0x140009731
  14000971e: 48 8d 54 24 20            LEA        RDX,[RSP + 0x20]
  140009723: 4c 8b cb                  MOV        R9,RBX
  140009726: 44 8b c7                  MOV        R8D,EDI
  140009729: 48 8b ce                  MOV        RCX,RSI
  14000972c: e8 7f fd ff ff            CALL       0x1400094b0
  140009731: 48 8b 5c 24 40            MOV        RBX,qword ptr [RSP + 0x40]
  140009736: 48 8b 74 24 48            MOV        RSI,qword ptr [RSP + 0x48]
  14000973b: 48 83 c4 30               ADD        RSP,0x30
  14000973f: 5f                        POP        RDI
  140009740: c3                        RET
  140009741: cc                        INT3
  140009742: cc                        INT3
  140009743: cc                        INT3

sub_140009744:  ; 0x140009744
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned long long)
; arg:   param_3 (unsigned int)
; arg:   param_4 (unsigned int)
; arg:   param_5 (unsigned long long)
; arg:   param_6 (unsigned long long)
; arg:   param_7 (unsigned long long)
; stack: v1 @ [stack-0x18] (char[16])
; stack: local_60 @ [stack-0x60] (undefined40)
; stack: local_38 @ [stack-0x38] (undefined8)
; stack: local_30 @ [stack-0x30] (undefined8)
; stack: local_28 @ [stack-0x28] (undefined16)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined24)
  140009744: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  140009749: 48 89 74 24 10            MOV        qword ptr [RSP + 0x10],RSI
  14000974e: 57                        PUSH       RDI
  14000974f: 48 83 ec 50               SUB        RSP,0x50
  140009753: 48 8b f1                  MOV        RSI,RCX
  140009756: 48 8d 4c 24 40            LEA        RCX,[RSP + 0x40]
  14000975b: 41 8b d9                  MOV        EBX,R9D
  14000975e: 41 8b f8                  MOV        EDI,R8D
  140009761: e8 9a 78 ff ff            CALL       0x140001000
  140009766: 85 c0                     TEST       EAX,EAX
  140009768: 78 3a                     JS         0x1400097a4
  14000976a: 48 8b 84 24 90 00 00 00   MOV        RAX,qword ptr [RSP + 0x90]
  140009772: 48 8d 54 24 40            LEA        RDX,[RSP + 0x40]
  140009777: 44 8b cb                  MOV        R9D,EBX
  14000977a: 48 89 44 24 30            MOV        qword ptr [RSP + 0x30],RAX
  14000977f: 48 8b 84 24 88 00 00 00   MOV        RAX,qword ptr [RSP + 0x88]
  140009787: 44 8b c7                  MOV        R8D,EDI
  14000978a: 48 89 44 24 28            MOV        qword ptr [RSP + 0x28],RAX
  14000978f: 48 8b 84 24 80 00 00 00   MOV        RAX,qword ptr [RSP + 0x80]
  140009797: 48 8b ce                  MOV        RCX,RSI
  14000979a: 48 89 44 24 20            MOV        qword ptr [RSP + 0x20],RAX
  14000979f: e8 80 fd ff ff            CALL       0x140009524
  1400097a4: 48 8b 5c 24 60            MOV        RBX,qword ptr [RSP + 0x60]
  1400097a9: 48 8b 74 24 68            MOV        RSI,qword ptr [RSP + 0x68]
  1400097ae: 48 83 c4 50               ADD        RSP,0x50
  1400097b2: 5f                        POP        RDI
  1400097b3: c3                        RET

sub_1400097b4:  ; 0x1400097b4
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned long long)
; arg:   param_3 (unsigned int)
; arg:   param_4 (unsigned long long)
; stack: v1 @ [stack-0x18] (char[16])
; stack: local_40 @ [stack-0x40] (undefined40)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined24)
  1400097b4: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  1400097b9: 48 89 74 24 10            MOV        qword ptr [RSP + 0x10],RSI
  1400097be: 57                        PUSH       RDI
  1400097bf: 48 83 ec 30               SUB        RSP,0x30
  1400097c3: 48 8b f1                  MOV        RSI,RCX
  1400097c6: 48 8d 4c 24 20            LEA        RCX,[RSP + 0x20]
  1400097cb: 49 8b d9                  MOV        RBX,R9
  1400097ce: 41 8b f8                  MOV        EDI,R8D
  1400097d1: e8 2a 78 ff ff            CALL       0x140001000
  1400097d6: 85 c0                     TEST       EAX,EAX
  1400097d8: 78 13                     JS         0x1400097ed
  1400097da: 48 8d 54 24 20            LEA        RDX,[RSP + 0x20]
  1400097df: 4c 8b cb                  MOV        R9,RBX
  1400097e2: 44 8b c7                  MOV        R8D,EDI
  1400097e5: 48 8b ce                  MOV        RCX,RSI
  1400097e8: e8 cf fd ff ff            CALL       0x1400095bc
  1400097ed: 48 8b 5c 24 40            MOV        RBX,qword ptr [RSP + 0x40]
  1400097f2: 48 8b 74 24 48            MOV        RSI,qword ptr [RSP + 0x48]
  1400097f7: 48 83 c4 30               ADD        RSP,0x30
  1400097fb: 5f                        POP        RDI
  1400097fc: c3                        RET
  1400097fd: cc                        INT3
  1400097fe: cc                        INT3
  1400097ff: cc                        INT3

sub_140009800:  ; 0x140009800
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned short *)
; arg:   param_3 (int)
; arg:   param_4 (int)
; arg:   param_5 (long long *)
; stack: v6 @ [stack+0x20] (unsigned int[2])
; stack: local_50 @ [stack-0x50] (undefined8)
; stack: local_48 @ [stack-0x48] (undefined32)
; stack: local_28 @ [stack-0x28] (undefined8)
; stack: local_20 @ [stack-0x20] (undefined8)
; stack: local_18 @ [stack-0x18] (undefined8)
; stack: local_10 @ [stack-0x10] (undefined8)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined8)
; stack: stack_18 @ [stack+0x18] (undefined8)
  140009800: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  140009805: 48 89 6c 24 10            MOV        qword ptr [RSP + 0x10],RBP
  14000980a: 48 89 74 24 18            MOV        qword ptr [RSP + 0x18],RSI
  14000980f: 57                        PUSH       RDI
  140009810: 41 54                     PUSH       R12
  140009812: 41 55                     PUSH       R13
  140009814: 48 83 ec 30               SUB        RSP,0x30
  140009818: 48 8b 6c 24 70            MOV        RBP,qword ptr [RSP + 0x70]
  14000981d: 41 8b f0                  MOV        ESI,R8D
  140009820: 4c 8b e2                  MOV        R12,RDX
  140009823: 48 83 65 00 00            AND        qword ptr [RBP],0x0
  140009828: 0f b7 02                  MOVZX      EAX,word ptr [RDX]
  14000982b: 4c 8b e9                  MOV        R13,RCX
  14000982e: 83 c0 1f                  ADD        EAX,0x1f
  140009831: 83 e0 f8                  AND        EAX,0xfffffff8
  140009834: 42 8d 3c 08               LEA        EDI,[RAX + R9*0x1]
  140009838: 3b f8                     CMP        EDI,EAX
  14000983a: 0f 82 d4 00 00 00         JC         0x140009914
  140009840: 8b d7                     MOV        EDX,EDI
  140009842: 33 c9                     XOR        ECX,ECX
  140009844: 41 b8 50 70 52 62         MOV        R8D,0x62527050
  14000984a: ff 15 f0 97 ff ff         CALL       qword ptr [0x140003040]
  140009850: 48 8b d8                  MOV        RBX,RAX
  140009853: 48 85 c0                  TEST       RAX,RAX
  140009856: 75 0a                     JNZ        0x140009862
  140009858: b8 9a 00 00 c0            MOV        EAX,0xc000009a
  14000985d: e9 b7 00 00 00            JMP        0x140009919
  140009862: 48 8d 44 24 68            LEA        RAX,[RSP + 0x68]
  140009867: 4c 8b cb                  MOV        R9,RBX
  14000986a: 41 b8 01 00 00 00         MOV        R8D,0x1
  140009870: 48 89 44 24 28            MOV        qword ptr [RSP + 0x28],RAX
  140009875: 49 8b d4                  MOV        RDX,R12
  140009878: 49 8b cd                  MOV        RCX,R13
  14000987b: 89 7c 24 20               MOV        dword ptr [RSP + 0x20],EDI
  14000987f: ff 15 13 99 ff ff         CALL       qword ptr [0x140003198]
  140009885: 8b f8                     MOV        EDI,EAX
  140009887: 85 c0                     TEST       EAX,EAX
  140009889: 79 66                     JNS        0x1400098f1
  14000988b: 33 d2                     XOR        EDX,EDX
  14000988d: 48 8b cb                  MOV        RCX,RBX
  140009890: ff 15 ba 97 ff ff         CALL       qword ptr [0x140003050]
  140009896: 81 ff 05 00 00 80         CMP        EDI,0x80000005
  14000989c: 74 0c                     JZ         0x1400098aa
  14000989e: 81 ff 23 00 00 c0         CMP        EDI,0xc0000023
  1400098a4: 74 04                     JZ         0x1400098aa
  1400098a6: 8b c7                     MOV        EAX,EDI
  1400098a8: eb 6f                     JMP        0x140009919
  1400098aa: 8b 54 24 68               MOV        EDX,dword ptr [RSP + 0x68]
  1400098ae: 33 c9                     XOR        ECX,ECX
  1400098b0: 41 b8 50 70 52 62         MOV        R8D,0x62527050
  1400098b6: ff 15 84 97 ff ff         CALL       qword ptr [0x140003040]
  1400098bc: 48 8b d8                  MOV        RBX,RAX
  1400098bf: 48 85 c0                  TEST       RAX,RAX
  1400098c2: 74 94                     JZ         0x140009858
  1400098c4: 48 8d 44 24 68            LEA        RAX,[RSP + 0x68]
  1400098c9: 4c 8b cb                  MOV        R9,RBX
  1400098cc: 41 b8 01 00 00 00         MOV        R8D,0x1
  1400098d2: 48 89 44 24 28            MOV        qword ptr [RSP + 0x28],RAX
  1400098d7: 8b 44 24 68               MOV        EAX,dword ptr [RSP + 0x68]
  1400098db: 49 8b d4                  MOV        RDX,R12
  1400098de: 49 8b cd                  MOV        RCX,R13
  1400098e1: 89 44 24 20               MOV        dword ptr [RSP + 0x20],EAX
  1400098e5: ff 15 ad 98 ff ff         CALL       qword ptr [0x140003198]
  1400098eb: 8b f8                     MOV        EDI,EAX
  1400098ed: 85 c0                     TEST       EAX,EAX
  1400098ef: 78 0e                     JS         0x1400098ff
  1400098f1: 85 f6                     TEST       ESI,ESI
  1400098f3: 74 17                     JZ         0x14000990c
  1400098f5: 39 73 04                  CMP        dword ptr [RBX + 0x4],ESI
  1400098f8: 74 12                     JZ         0x14000990c
  1400098fa: bf 24 00 00 c0            MOV        EDI,0xc0000024
  1400098ff: 33 d2                     XOR        EDX,EDX
  140009901: 48 8b cb                  MOV        RCX,RBX
  140009904: ff 15 46 97 ff ff         CALL       qword ptr [0x140003050]
  14000990a: eb 9a                     JMP        0x1400098a6
  14000990c: 48 89 5d 00               MOV        qword ptr [RBP],RBX
  140009910: 33 c0                     XOR        EAX,EAX
  140009912: eb 05                     JMP        0x140009919
  140009914: b8 95 00 00 c0            MOV        EAX,0xc0000095
  140009919: 48 8b 5c 24 50            MOV        RBX,qword ptr [RSP + 0x50]
  14000991e: 48 8b 6c 24 58            MOV        RBP,qword ptr [RSP + 0x58]
  140009923: 48 8b 74 24 60            MOV        RSI,qword ptr [RSP + 0x60]
  140009928: 48 83 c4 30               ADD        RSP,0x30
  14000992c: 41 5d                     POP        R13
  14000992e: 41 5c                     POP        R12
  140009930: 5f                        POP        RDI
  140009931: c3                        RET
  140009932: cc                        INT3
  140009933: cc                        INT3

sub_140009934:  ; 0x140009934
; arg:   param_1 (unsigned long long)
; arg:   param_2 (unsigned long long)
; arg:   param_3 (unsigned int)
; arg:   param_4 (unsigned int)
; arg:   param_5 (unsigned long long)
; stack: v1 @ [stack-0x18] (char[16])
; stack: local_50 @ [stack-0x50] (undefined40)
; stack: local_28 @ [stack-0x28] (undefined16)
; stack: local_8 @ [stack-0x8] (undefined8)
; stack: stack_8 @ [stack+0x8] (undefined8)
; stack: stack_10 @ [stack+0x10] (undefined24)
  140009934: 48 89 5c 24 08            MOV        qword ptr [RSP + 0x8],RBX
  140009939: 48 89 74 24 10            MOV        qword ptr [RSP + 0x10],RSI
  14000993e: 57                        PUSH       RDI
  14000993f: 48 83 ec 40               SUB        RSP,0x40
  140009943: 48 8b f1                  MOV        RSI,RCX
  140009946: 48 8d 4c 24 30            LEA        RCX,[RSP + 0x30]
  14000994b: 41 8b d9                  MOV        EBX,R9D
  14000994e: 41 8b f8                  MOV        EDI,R8D
  140009951: e8 aa 76 ff ff            CALL       0x140001000
  140009956: 85 c0                     TEST       EAX,EAX
  140009958: 78 1d                     JS         0x140009977
  14000995a: 48 8b 44 24 70            MOV        RAX,qword ptr [RSP + 0x70]
  14000995f: 48 8d 54 24 30            LEA        RDX,[RSP + 0x30]
  140009964: 44 8b cb                  MOV        R9D,EBX
  140009967: 44 8b c7                  MOV        R8D,EDI
  14000996a: 48 8b ce                  MOV        RCX,RSI
  14000996d: 48 89 44 24 20            MOV        qword ptr [RSP + 0x20],RAX
  140009972: e8 89 fe ff ff            CALL       0x140009800
  140009977: 48 8b 5c 24 50            MOV        RBX,qword ptr [RSP + 0x50]
  14000997c: 48 8b 74 24 58            MOV        RSI,qword ptr [RSP + 0x58]
  140009981: 48 83 c4 40               ADD        RSP,0x40
  140009985: 5f                        POP        RDI
  140009986: c3                        RET

; --- code section 0x14000a000..0x14000a696 ---
  14000a000: 58                        POP        RAX
  14000a001: a0 00 00 00 00 00 00 00 00  MOV        AL,[0x0]
  14000a00a: 00 00                     ADD        byte ptr [RAX],AL
  14000a00c: e4 a3                     IN         AL, 0xa3
  14000a00e: 00 00                     ADD        byte ptr [RAX],AL
  14000a010: 18 30                     SBB        byte ptr [RAX],DH
  14000a012: 00 00                     ADD        byte ptr [RAX],AL
  14000a014: 40 a0 00 00 00 00 00 00 00 00  MOV        AL,[0x0]
  14000a01e: 00 00                     ADD        byte ptr [RAX],AL
  14000a020: 22 a4 00 00 00 30 00      AND        AH,byte ptr [RAX + RAX*0x1 + 0x300000]
  14000a027: 00 00                     ADD        byte ptr [RAX],AL
  14000a029: 00 00                     ADD        byte ptr [RAX],AL
  14000a02b: 00 00                     ADD        byte ptr [RAX],AL
  14000a02d: 00 00                     ADD        byte ptr [RAX],AL
  14000a02f: 00 00                     ADD        byte ptr [RAX],AL
  14000a031: 00 00                     ADD        byte ptr [RAX],AL
  14000a033: 00 00                     ADD        byte ptr [RAX],AL
  14000a035: 00 00                     ADD        byte ptr [RAX],AL
  14000a037: 00 00                     ADD        byte ptr [RAX],AL
  14000a039: 00 00                     ADD        byte ptr [RAX],AL
  14000a03b: 00 00                     ADD        byte ptr [RAX],AL
  14000a03d: 00 00                     ADD        byte ptr [RAX],AL
  14000a03f: 00 f2                     ADD        DL,DH
  14000a041: a3 00 00 00 00 00 00 0a a4  MOV        [-0x5bf6000000000000],EAX
  14000a04a: 00 00                     ADD        byte ptr [RAX],AL
  14000a04c: 00 00                     ADD        byte ptr [RAX],AL
  14000a04e: 00 00                     ADD        byte ptr [RAX],AL
  14000a050: 00 00                     ADD        byte ptr [RAX],AL
  14000a052: 00 00                     ADD        byte ptr [RAX],AL
  14000a054: 00 00                     ADD        byte ptr [RAX],AL
  14000a056: 00 00                     ADD        byte ptr [RAX],AL
  14000a058: 20 a2 00 00 00 00         AND        byte ptr [RDX],AH
  14000a05e: 00 00                     ADD        byte ptr [RAX],AL
  14000a060: 38 a2 00 00 00 00         CMP        byte ptr [RDX],AH
  14000a066: 00 00                     ADD        byte ptr [RAX],AL
  14000a068: 4a a2 00 00 00 00 00 00 62 a2  MOV        [-0x5d9e000000000000],AL
  14000a072: 00 00                     ADD        byte ptr [RAX],AL
  14000a074: 00 00                     ADD        byte ptr [RAX],AL
  14000a076: 00 00                     ADD        byte ptr [RAX],AL
  14000a078: 7a a2                     JP         0x14000a01c
  14000a07a: 00 00                     ADD        byte ptr [RAX],AL
  14000a07c: 00 00                     ADD        byte ptr [RAX],AL
  14000a07e: 00 00                     ADD        byte ptr [RAX],AL
  14000a080: 9c                        PUSHFQ
  14000a081: a2 00 00 00 00 00 00 b4 a2  MOV        [-0x5d4c000000000000],AL
  14000a08a: 00 00                     ADD        byte ptr [RAX],AL
  14000a08c: 00 00                     ADD        byte ptr [RAX],AL
  14000a08e: 00 00                     ADD        byte ptr [RAX],AL
  14000a090: d8 a2 00 00 00 00         FSUB       float ptr [RDX]
  14000a096: 00 00                     ADD        byte ptr [RAX],AL
  14000a098: ec                        IN         AL, DX
  14000a099: a2 00 00 00 00 00 00 02 a3  MOV        [-0x5cfe000000000000],AL
  14000a0a2: 00 00                     ADD        byte ptr [RAX],AL
  14000a0a4: 00 00                     ADD        byte ptr [RAX],AL
  14000a0a6: 00 00                     ADD        byte ptr [RAX],AL
  14000a0a8: 12 a2 00 00 00 00         ADC        AH,byte ptr [RDX]
  14000a0ae: 00 00                     ADD        byte ptr [RAX],AL
  14000a0b0: 24 a3                     AND        AL,0xa3
  14000a0b2: 00 00                     ADD        byte ptr [RAX],AL
  14000a0b4: 00 00                     ADD        byte ptr [RAX],AL
  14000a0b6: 00 00                     ADD        byte ptr [RAX],AL
  14000a0b8: 3c a3                     CMP        AL,0xa3
  14000a0ba: 00 00                     ADD        byte ptr [RAX],AL
  14000a0bc: 00 00                     ADD        byte ptr [RAX],AL
  14000a0be: 00 00                     ADD        byte ptr [RAX],AL
  14000a0c0: 58                        POP        RAX
  14000a0c1: a3 00 00 00 00 00 00 68 a3  MOV        [-0x5c98000000000000],EAX
  14000a0ca: 00 00                     ADD        byte ptr [RAX],AL
  14000a0cc: 00 00                     ADD        byte ptr [RAX],AL
  14000a0ce: 00 00                     ADD        byte ptr [RAX],AL
  14000a0d0: 78 a3                     JS         0x14000a075
  14000a0d2: 00 00                     ADD        byte ptr [RAX],AL
  14000a0d4: 00 00                     ADD        byte ptr [RAX],AL
  14000a0d6: 00 00                     ADD        byte ptr [RAX],AL
  14000a0d8: 8a a3 00 00 00 00         MOV        AH,byte ptr [RBX]
  14000a0de: 00 00                     ADD        byte ptr [RAX],AL
  14000a0e0: a2 a3 00 00 00 00 00 00 ae  MOV        [-0x51ffffffffffff5d],AL
  14000a0e9: a3 00 00 00 00 00 00 c4 a3  MOV        [-0x5c3c000000000000],EAX
  14000a0f2: 00 00                     ADD        byte ptr [RAX],AL
  14000a0f4: 00 00                     ADD        byte ptr [RAX],AL
  14000a0f6: 00 00                     ADD        byte ptr [RAX],AL
  14000a0f8: 6e                        OUTSB      DX,RSI
  14000a0f9: a6                        CMPSB      RDI,RSI
  14000a0fa: 00 00                     ADD        byte ptr [RAX],AL
  14000a0fc: 00 00                     ADD        byte ptr [RAX],AL
  14000a0fe: 00 00                     ADD        byte ptr [RAX],AL
  14000a100: db 0x06
  14000a101: a2 00 00 00 00 00 00 1a a3  MOV        [-0x5ce6000000000000],AL
  14000a10a: 00 00                     ADD        byte ptr [RAX],AL
  14000a10c: 00 00                     ADD        byte ptr [RAX],AL
  14000a10e: 00 00                     ADD        byte ptr [RAX],AL
  14000a110: f8                        CLC
  14000a111: a1 00 00 00 00 00 00 2a a4  MOV        EAX,[-0x5bd6000000000000]
  14000a11a: 00 00                     ADD        byte ptr [RAX],AL
  14000a11c: 00 00                     ADD        byte ptr [RAX],AL
  14000a11e: 00 00                     ADD        byte ptr [RAX],AL
  14000a120: 46 a4                     MOVSB      RDI,RSI
  14000a122: 00 00                     ADD        byte ptr [RAX],AL
  14000a124: 00 00                     ADD        byte ptr [RAX],AL
  14000a126: 00 00                     ADD        byte ptr [RAX],AL
  14000a128: 58                        POP        RAX
  14000a129: a4                        MOVSB      RDI,RSI
  14000a12a: 00 00                     ADD        byte ptr [RAX],AL
  14000a12c: 00 00                     ADD        byte ptr [RAX],AL
  14000a12e: 00 00                     ADD        byte ptr [RAX],AL
  14000a130: db 0x62
  14000a131: a4                        MOVSB      RDI,RSI
  14000a132: 00 00                     ADD        byte ptr [RAX],AL
  14000a134: 00 00                     ADD        byte ptr [RAX],AL
  14000a136: 00 00                     ADD        byte ptr [RAX],AL
  14000a138: 7a a4                     JP         0x14000a0de
  14000a13a: 00 00                     ADD        byte ptr [RAX],AL
  14000a13c: 00 00                     ADD        byte ptr [RAX],AL
  14000a13e: 00 00                     ADD        byte ptr [RAX],AL
  14000a140: 90                        NOP
  14000a141: a4                        MOVSB      RDI,RSI
  14000a142: 00 00                     ADD        byte ptr [RAX],AL
  14000a144: 00 00                     ADD        byte ptr [RAX],AL
  14000a146: 00 00                     ADD        byte ptr [RAX],AL
  14000a148: a6                        CMPSB      RDI,RSI
  14000a149: a4                        MOVSB      RDI,RSI
  14000a14a: 00 00                     ADD        byte ptr [RAX],AL
  14000a14c: 00 00                     ADD        byte ptr [RAX],AL
  14000a14e: 00 00                     ADD        byte ptr [RAX],AL
  14000a150: b4 a4                     MOV        AH,0xa4
  14000a152: 00 00                     ADD        byte ptr [RAX],AL
  14000a154: 00 00                     ADD        byte ptr [RAX],AL
  14000a156: 00 00                     ADD        byte ptr [RAX],AL
  14000a158: d2 a4 00 00 00 00 00      SHL        byte ptr [RAX + RAX*0x1],CL
  14000a15f: 00 f0                     ADD        AL,DH
  14000a161: a4                        MOVSB      RDI,RSI
  14000a162: 00 00                     ADD        byte ptr [RAX],AL
  14000a164: 00 00                     ADD        byte ptr [RAX],AL
  14000a166: 00 00                     ADD        byte ptr [RAX],AL
  14000a168: db 0x0e
  14000a169: a5                        MOVSD      RDI,RSI
  14000a16a: 00 00                     ADD        byte ptr [RAX],AL
  14000a16c: 00 00                     ADD        byte ptr [RAX],AL
  14000a16e: 00 00                     ADD        byte ptr [RAX],AL
  14000a170: 2e a5                     MOVSD      RDI,RSI
  14000a172: 00 00                     ADD        byte ptr [RAX],AL
  14000a174: 00 00                     ADD        byte ptr [RAX],AL
  14000a176: 00 00                     ADD        byte ptr [RAX],AL
  14000a178: 4c a5                     MOVSQ      RDI,RSI
  14000a17a: 00 00                     ADD        byte ptr [RAX],AL
  14000a17c: 00 00                     ADD        byte ptr [RAX],AL
  14000a17e: 00 00                     ADD        byte ptr [RAX],AL
  14000a180: 66 a5                     MOVSW      RDI,RSI
  14000a182: 00 00                     ADD        byte ptr [RAX],AL
  14000a184: 00 00                     ADD        byte ptr [RAX],AL
  14000a186: 00 00                     ADD        byte ptr [RAX],AL
  14000a188: 72 a5                     JC         0x14000a12f
  14000a18a: 00 00                     ADD        byte ptr [RAX],AL
  14000a18c: 00 00                     ADD        byte ptr [RAX],AL
  14000a18e: 00 00                     ADD        byte ptr [RAX],AL
  14000a190: 7c a5                     JL         0x14000a137
  14000a192: 00 00                     ADD        byte ptr [RAX],AL
  14000a194: 00 00                     ADD        byte ptr [RAX],AL
  14000a196: 00 00                     ADD        byte ptr [RAX],AL
  14000a198: 88 a5 00 00 00 00         MOV        byte ptr [RBP],AH
  14000a19e: 00 00                     ADD        byte ptr [RAX],AL
  14000a1a0: 98                        CWDE
  14000a1a1: a5                        MOVSD      RDI,RSI
  14000a1a2: 00 00                     ADD        byte ptr [RAX],AL
  14000a1a4: 00 00                     ADD        byte ptr [RAX],AL
  14000a1a6: 00 00                     ADD        byte ptr [RAX],AL
  14000a1a8: b2 a5                     MOV        DL,0xa5
  14000a1aa: 00 00                     ADD        byte ptr [RAX],AL
  14000a1ac: 00 00                     ADD        byte ptr [RAX],AL
  14000a1ae: 00 00                     ADD        byte ptr [RAX],AL
  14000a1b0: d2 a5 00 00 00 00         SHL        byte ptr [RBP],CL
  14000a1b6: 00 00                     ADD        byte ptr [RAX],AL
  14000a1b8: f2 a5                     MOVSD.REP  RDI,RSI
  14000a1ba: 00 00                     ADD        byte ptr [RAX],AL
  14000a1bc: 00 00                     ADD        byte ptr [RAX],AL
  14000a1be: 00 00                     ADD        byte ptr [RAX],AL
  14000a1c0: 12 a6 00 00 00 00         ADC        AH,byte ptr [RSI]
  14000a1c6: 00 00                     ADD        byte ptr [RAX],AL
  14000a1c8: 32 a6 00 00 00 00         XOR        AH,byte ptr [RSI]
  14000a1ce: 00 00                     ADD        byte ptr [RAX],AL
  14000a1d0: 3e a6                     CMPSB      RDI,RSI
  14000a1d2: 00 00                     ADD        byte ptr [RAX],AL
  14000a1d4: 00 00                     ADD        byte ptr [RAX],AL
  14000a1d6: 00 00                     ADD        byte ptr [RAX],AL
  14000a1d8: 4c a6                     CMPSB      RDI,RSI
  14000a1da: 00 00                     ADD        byte ptr [RAX],AL
  14000a1dc: 00 00                     ADD        byte ptr [RAX],AL
  14000a1de: 00 00                     ADD        byte ptr [RAX],AL
  14000a1e0: 5e                        POP        RSI
  14000a1e1: a6                        CMPSB      RDI,RSI
  14000a1e2: 00 00                     ADD        byte ptr [RAX],AL
  14000a1e4: 00 00                     ADD        byte ptr [RAX],AL
  14000a1e6: 00 00                     ADD        byte ptr [RAX],AL
  14000a1e8: 86 a6 00 00 00 00         XCHG       byte ptr [RSI],AH
  14000a1ee: 00 00                     ADD        byte ptr [RAX],AL
  14000a1f0: 00 00                     ADD        byte ptr [RAX],AL
  14000a1f2: 00 00                     ADD        byte ptr [RAX],AL
  14000a1f4: 00 00                     ADD        byte ptr [RAX],AL
  14000a1f6: 00 00                     ADD        byte ptr [RAX],AL
  14000a1f8: a8 05                     TEST       AL,0x5
  14000a1fa: 5f                        POP        RDI
  14000a1fb: 76 73                     JBE        0x14000a270
  14000a1fd: 6e                        OUTSB      DX,RSI
  14000a1fe: 70 72                     JO         0x14000a272
  14000a200: 69 6e 74 66 00 00 31      IMUL       EBP,dword ptr [RSI + 0x74],0x31000066
  14000a207: 00 44 62 67               ADD        byte ptr [RDX + 0x67],AL
  14000a20b: 50                        PUSH       RAX
  14000a20c: 72 69                     JC         0x14000a277
  14000a20e: 6e                        OUTSB      DX,RSI
  14000a20f: 74 00                     JZ         0x14000a211
  14000a211: 00 a9 05 5f 76 73         ADD        byte ptr [RCX + 0x73765f05],CH
  14000a217: 6e                        OUTSB      DX,RSI
  14000a218: 77 70                     JA         0x14000a28a
  14000a21a: 72 69                     JC         0x14000a285
  14000a21c: 6e                        OUTSB      DX,RSI
  14000a21d: 74 66                     JZ         0x14000a285
  14000a21f: 00 3e                     ADD        byte ptr [RSI],BH
  14000a221: 04 52                     ADD        AL,0x52
  14000a223: 74 6c                     JZ         0x14000a291
  14000a225: 49 6e                     OUTSB      DX,RSI
  14000a227: 69 74 55 6e 69 63 6f 64   IMUL       ESI,dword ptr [RBP + RDX*0x2 + 0x6e],0x646f6369
  14000a22f: 65 53                     PUSH       RBX
  14000a231: 74 72                     JZ         0x14000a2a5
  14000a233: 69 6e 67 00 00 5f 01      IMUL       EBP,dword ptr [RSI + 0x67],0x15f0000
  14000a23a: 49 6f                     OUTSD      DX,RSI
  14000a23c: db 0x44
  14000a23d: 65 6c                     INSB       RDI,DX
  14000a23f: 65 74 65                  JZ         0x14000a2a7
  14000a242: db 0x44
  14000a243: 65 76 69                  JBE        0x14000a2af
  14000a246: 63 65 00                  MOVSXD     ESP,dword ptr [RBP]
  14000a249: 00 ee                     ADD        DH,CH
  14000a24b: 03 52 74                  ADD        EDX,dword ptr [RDX + 0x74]
  14000a24e: 6c                        INSB       RDI,DX
  14000a24f: 43 6f                     OUTSD      DX,RSI
  14000a251: 70 79                     JO         0x14000a2cc
  14000a253: 55                        PUSH       RBP
  14000a254: 6e                        OUTSB      DX,RSI
  14000a255: 69 63 6f 64 65 53 74      IMUL       ESP,dword ptr [RBX + 0x6f],0x74536564
  14000a25c: 72 69                     JC         0x14000a2c7
  14000a25e: 6e                        OUTSB      DX,RSI
  14000a25f: 67 00 00                  ADD        byte ptr [EAX],AL
  14000a262: db 0x61
  14000a263: 01 49 6f                  ADD        dword ptr [RCX + 0x6f],ECX
  14000a266: db 0x44
  14000a267: 65 6c                     INSB       RDI,DX
  14000a269: 65 74 65                  JZ         0x14000a2d1
  14000a26c: 53                        PUSH       RBX
  14000a26d: 79 6d                     JNS        0x14000a2dc
  14000a26f: db 0x62
  14000a270: 6f                        OUTSD      DX,RSI
  14000a271: 6c                        INSB       RDI,DX
  14000a272: 69 63 4c 69 6e 6b 00      IMUL       ESP,dword ptr [RBX + 0x4c],0x6b6e69
  14000a279: 00 b1 01 49 6f 52         ADD        byte ptr [RCX + 0x526f4901],DH
  14000a27f: 65 67 69 73 74 65 72 53 68  IMUL       ESI,dword ptr GS:[EBX + 0x74],0x68537265
  14000a288: 75 74                     JNZ        0x14000a2fe
  14000a28a: 64 6f                     OUTSD      DX,RSI
  14000a28c: 77 6e                     JA         0x14000a2fc
  14000a28e: 4e 6f                     OUTSD      DX,RSI
  14000a290: 74 69                     JZ         0x14000a2fb
  14000a292: 66 69 63 61 74 69         IMUL       SP,word ptr [RBX + 0x61],0x6974
  14000a298: 6f                        OUTSD      DX,RSI
  14000a299: 6e                        OUTSB      DX,RSI
  14000a29a: 00 00                     ADD        byte ptr [RAX],AL
  14000a29c: 46 00 45 78               ADD        byte ptr [RBP + 0x78],R8B
  14000a2a0: 41 6c                     INSB       RDI,DX
  14000a2a2: 6c                        INSB       RDI,DX
  14000a2a3: 6f                        OUTSD      DX,RSI
  14000a2a4: 63 61 74                  MOVSXD     ESP,dword ptr [RCX + 0x74]
  14000a2a7: 65 50                     PUSH       RAX
  14000a2a9: 6f                        OUTSD      DX,RSI
  14000a2aa: 6f                        OUTSD      DX,RSI
  14000a2ab: 6c                        INSB       RDI,DX
  14000a2ac: 57                        PUSH       RDI
  14000a2ad: 69 74 68 54 61 67 00 da   IMUL       ESI,dword ptr [RAX + RBP*0x2 + 0x54],-0x25ff989f
  14000a2b5: 01 49 6f                  ADD        dword ptr [RCX + 0x6f],ECX
  14000a2b8: 55                        PUSH       RBP
  14000a2b9: 6e                        OUTSB      DX,RSI
  14000a2ba: 72 65                     JC         0x14000a321
  14000a2bc: 67 69 73 74 65 72 53 68   IMUL       ESI,dword ptr [EBX + 0x74],0x68537265
  14000a2c4: 75 74                     JNZ        0x14000a33a
  14000a2c6: 64 6f                     OUTSD      DX,RSI
  14000a2c8: 77 6e                     JA         0x14000a338
  14000a2ca: 4e 6f                     OUTSD      DX,RSI
  14000a2cc: 74 69                     JZ         0x14000a337
  14000a2ce: 66 69 63 61 74 69         IMUL       SP,word ptr [RBX + 0x61],0x6974
  14000a2d4: 6f                        OUTSD      DX,RSI
  14000a2d5: 6e                        OUTSB      DX,RSI
  14000a2d6: 00 00                     ADD        byte ptr [RAX],AL
  14000a2d8: 58                        POP        RAX
  14000a2d9: 00 45 78                  ADD        byte ptr [RBP + 0x78],AL
  14000a2dc: 46 72 65                  JC         0x14000a344
  14000a2df: 65 50                     PUSH       RAX
  14000a2e1: 6f                        OUTSD      DX,RSI
  14000a2e2: 6f                        OUTSD      DX,RSI
  14000a2e3: 6c                        INSB       RDI,DX
  14000a2e4: 57                        PUSH       RDI
  14000a2e5: 69 74 68 54 61 67 00 f6   IMUL       ESI,dword ptr [RAX + RBP*0x2 + 0x54],-0x9ff989f
  14000a2ed: 01 49 6f                  ADD        dword ptr [RCX + 0x6f],ECX
  14000a2f0: 66 43 6f                  OUTSW      DX,RSI
  14000a2f3: 6d                        INSD       RDI,DX
  14000a2f4: 70 6c                     JO         0x14000a362
  14000a2f6: 65 74 65                  JZ         0x14000a35e
  14000a2f9: 52                        PUSH       RDX
  14000a2fa: 65 71 75                  JNO        0x14000a372
  14000a2fd: 65 73 74                  JNC        0x14000a374
  14000a300: 00 00                     ADD        byte ptr [RAX],AL
  14000a302: 55                        PUSH       RBP
  14000a303: 01 49 6f                  ADD        dword ptr [RCX + 0x6f],ECX
  14000a306: 43 72 65                  JC         0x14000a36e
  14000a309: db 0x61
  14000a30a: 74 65                     JZ         0x14000a371
  14000a30c: 53                        PUSH       RBX
  14000a30d: 79 6d                     JNS        0x14000a37c
  14000a30f: db 0x62
  14000a310: 6f                        OUTSD      DX,RSI
  14000a311: 6c                        INSB       RDI,DX
  14000a312: 69 63 4c 69 6e 6b 00      IMUL       ESP,dword ptr [RBX + 0x4c],0x6b6e69
  14000a319: 00 e0                     ADD        AL,AH
  14000a31b: 05 77 63 73 72            ADD        EAX,0x72736377
  14000a320: 63 68 72                  MOVSXD     EBP,dword ptr [RAX + 0x72]
  14000a323: 00 96 05 5f 5f 43         ADD        byte ptr [RSI + 0x435f5f05],DL
  14000a329: 5f                        POP        RDI
  14000a32a: 73 70                     JNC        0x14000a39c
  14000a32c: 65 63 69 66               MOVSXD     EBP,dword ptr GS:[RCX + 0x66]
  14000a330: 69 63 5f 68 61 6e 64      IMUL       ESP,dword ptr [RBX + 0x5f],0x646e6168
  14000a337: 6c                        INSB       RDI,DX
  14000a338: 65 72 00                  JC         0x14000a33b
  14000a33b: 00 b1 02 4d 6d 42         ADD        byte ptr [RCX + 0x426d4d02],DH
  14000a341: 75 69                     JNZ        0x14000a3ac
  14000a343: 6c                        INSB       RDI,DX
  14000a344: db 0x64, 0x4d
  14000a346: 64 6c                     INSB       RDI,DX
  14000a348: 46 6f                     OUTSD      DX,RSI
  14000a34a: 72 4e                     JC         0x14000a39a
  14000a34c: 6f                        OUTSD      DX,RSI
  14000a34d: 6e                        OUTSB      DX,RSI
  14000a34e: 50                        PUSH       RAX
  14000a34f: db 0x61
  14000a350: 67 65 64 50               PUSH       RAX
  14000a354: 6f                        OUTSD      DX,RSI
  14000a355: 6f                        OUTSD      DX,RSI
  14000a356: 6c                        INSB       RDI,DX
  14000a357: 00 33                     ADD        byte ptr [RBX],DH
  14000a359: 01 49 6f                  ADD        dword ptr [RCX + 0x6f],ECX
  14000a35c: 41 6c                     INSB       RDI,DX
  14000a35e: 6c                        INSB       RDI,DX
  14000a35f: 6f                        OUTSD      DX,RSI
  14000a360: 63 61 74                  MOVSXD     ESP,dword ptr [RCX + 0x74]
  14000a363: db 0x65, 0x4d
  14000a365: 64 6c                     INSB       RDI,DX
  14000a367: 00 d0                     ADD        AL,DL
  14000a369: 02 4d 6d                  ADD        CL,byte ptr [RBP + 0x6d]
  14000a36c: db 0x4d, 0x61
  14000a36e: 70 49                     JO         0x14000a3b9
  14000a370: 6f                        OUTSD      DX,RSI
  14000a371: 53                        PUSH       RBX
  14000a372: 70 61                     JO         0x14000a3d5
  14000a374: 63 65 00                  MOVSXD     ESP,dword ptr [RBP]
  14000a377: 00 ee                     ADD        DH,CH
  14000a379: 02 4d 6d                  ADD        CL,byte ptr [RBP + 0x6d]
  14000a37c: 55                        PUSH       RBP
  14000a37d: 6e                        OUTSB      DX,RSI
  14000a37e: 6d                        INSD       RDI,DX
  14000a37f: db 0x61
  14000a380: 70 49                     JO         0x14000a3cb
  14000a382: 6f                        OUTSD      DX,RSI
  14000a383: 53                        PUSH       RBX
  14000a384: 70 61                     JO         0x14000a3e7
  14000a386: 63 65 00                  MOVSXD     ESP,dword ptr [RBP]
  14000a389: 00 75 03                  ADD        byte ptr [RBP + 0x3],DH
  14000a38c: 50                        PUSH       RAX
  14000a38d: 73 47                     JNC        0x14000a3d6
  14000a38f: 65 74 43                  JZ         0x14000a3d5
  14000a392: 75 72                     JNZ        0x14000a406
  14000a394: 72 65                     JC         0x14000a3fb
  14000a396: 6e                        OUTSB      DX,RSI
  14000a397: 74 50                     JZ         0x14000a3e9
  14000a399: 72 6f                     JC         0x14000a40a
  14000a39b: 63 65 73                  MOVSXD     ESP,dword ptr [RBP + 0x73]
  14000a39e: 73 49                     JNC        0x14000a3e9
  14000a3a0: 64 00 72 01               ADD        byte ptr FS:[RDX + 0x1],DH
  14000a3a4: 49 6f                     OUTSD      DX,RSI
  14000a3a6: 46 72 65                  JC         0x14000a40e
  14000a3a9: db 0x65, 0x4d
  14000a3ab: 64 6c                     INSB       RDI,DX
  14000a3ad: 00 ef                     ADD        BH,CH
  14000a3af: 02 4d 6d                  ADD        CL,byte ptr [RBP + 0x6d]
  14000a3b2: 55                        PUSH       RBP
  14000a3b3: 6e                        OUTSB      DX,RSI
  14000a3b4: 6d                        INSD       RDI,DX
  14000a3b5: db 0x61
  14000a3b6: 70 4c                     JO         0x14000a404
  14000a3b8: 6f                        OUTSD      DX,RSI
  14000a3b9: 63 6b 65                  MOVSXD     EBP,dword ptr [RBX + 0x65]
  14000a3bc: 64 50                     PUSH       RAX
  14000a3be: db 0x61
  14000a3bf: 67 65 73 00               JNC        0x14000a3c3
  14000a3c3: 00 d2                     ADD        DL,DL
  14000a3c5: 02 4d 6d                  ADD        CL,byte ptr [RBP + 0x6d]
  14000a3c8: db 0x4d, 0x61
  14000a3ca: 70 4c                     JO         0x14000a418
  14000a3cc: 6f                        OUTSD      DX,RSI
  14000a3cd: 63 6b 65                  MOVSXD     EBP,dword ptr [RBX + 0x65]
  14000a3d0: 64 50                     PUSH       RAX
  14000a3d2: db 0x61
  14000a3d3: 67 65 73 53               JNC        0x14000a42a
  14000a3d7: 70 65                     JO         0x14000a43e
  14000a3d9: 63 69 66                  MOVSXD     EBP,dword ptr [RCX + 0x66]
  14000a3dc: 79 43                     JNS        0x14000a421
  14000a3de: db 0x61
  14000a3df: 63 68 65                  MOVSXD     EBP,dword ptr [RAX + 0x65]
  14000a3e2: 00 00                     ADD        byte ptr [RAX],AL
  14000a3e4: 6e                        OUTSB      DX,RSI
  14000a3e5: 74 6f                     JZ         0x14000a456
  14000a3e7: 73 6b                     JNC        0x14000a454
  14000a3e9: 72 6e                     JC         0x14000a459
  14000a3eb: 6c                        INSB       RDI,DX
  14000a3ec: 2e 65 78 65               JS         0x14000a455
  14000a3f0: 00 00                     ADD        byte ptr [RAX],AL
  14000a3f2: 25 00 48 61 6c            AND        EAX,0x6c614800
  14000a3f7: 53                        PUSH       RBX
  14000a3f8: 65 74 42                  JZ         0x14000a43d
  14000a3fb: 75 73                     JNZ        0x14000a470
  14000a3fd: db 0x44, 0x61
  14000a3ff: 74 61                     JZ         0x14000a462
  14000a401: 42 79 4f                  JNS        0x14000a453
  14000a404: 66 66 73 65               JNC        0x14000a46d
  14000a408: 74 00                     JZ         0x14000a40a
  14000a40a: 11 00                     ADC        dword ptr [RAX],EAX
  14000a40c: db 0x48, 0x61
  14000a40e: 6c                        INSB       RDI,DX
  14000a40f: db 0x47
  14000a410: 65 74 42                  JZ         0x14000a455
  14000a413: 75 73                     JNZ        0x14000a488
  14000a415: db 0x44, 0x61
  14000a417: 74 61                     JZ         0x14000a47a
  14000a419: 42 79 4f                  JNS        0x14000a46b
  14000a41c: 66 66 73 65               JNC        0x14000a485
  14000a420: 74 00                     JZ         0x14000a422
  14000a422: db 0x48, 0x41, 0x4c
  14000a425: 2e 64 6c                  INSB       RDI,DX
  14000a428: 6c                        INSB       RDI,DX
  14000a429: 00 bf 03 4d 6d 47         ADD        byte ptr [RDI + 0x476d4d03],BH
  14000a42f: 65 74 53                  JZ         0x14000a485
  14000a432: 79 73                     JNS        0x14000a4a7
  14000a434: 74 65                     JZ         0x14000a49b
  14000a436: 6d                        INSD       RDI,DX
  14000a437: 52                        PUSH       RDX
  14000a438: 6f                        OUTSD      DX,RSI
  14000a439: 75 74                     JNZ        0x14000a4af
  14000a43b: 69 6e 65 41 64 64 72      IMUL       EBP,dword ptr [RSI + 0x65],0x72646441
  14000a442: 65 73 73                  JNC        0x14000a4b8
  14000a445: 00 ce                     ADD        DH,CL
  14000a447: 01 49 6f                  ADD        dword ptr [RCX + 0x6f],ECX
  14000a44a: 43 72 65                  JC         0x14000a4b2
  14000a44d: db 0x61
  14000a44e: 74 65                     JZ         0x14000a4b5
  14000a450: db 0x44
  14000a451: 65 76 69                  JBE        0x14000a4bd
  14000a454: 63 65 00                  MOVSXD     ESP,dword ptr [RBP]
  14000a457: 00 12                     ADD        byte ptr [RDX],DL
  14000a459: db 0x07
  14000a45a: 5a                        POP        RDX
  14000a45b: 77 43                     JA         0x14000a4a0
  14000a45d: 6c                        INSB       RDI,DX
  14000a45e: 6f                        OUTSD      DX,RSI
  14000a45f: 73 65                     JNC        0x14000a4c6
  14000a461: 00 77 04                  ADD        byte ptr [RDI + 0x4],DH
  14000a464: db 0x4f, 0x62
  14000a466: 4f 70 65                  JO         0x14000a4ce
  14000a469: 6e                        OUTSB      DX,RSI
  14000a46a: db 0x4f, 0x62
  14000a46c: 6a 65                     PUSH       0x65
  14000a46e: 63 74 42 79               MOVSXD     ESI,dword ptr [RDX + RAX*0x2 + 0x79]
  14000a472: 50                        PUSH       RAX
  14000a473: 6f                        OUTSD      DX,RSI
  14000a474: 69 6e 74 65 72 00 a9      IMUL       EBP,dword ptr [RSI + 0x74],-0x56ff8d9b
  14000a47b: db 0x07
  14000a47c: 5a                        POP        RDX
  14000a47d: 77 53                     JA         0x14000a4d2
  14000a47f: 65 74 53                  JZ         0x14000a4d5
  14000a482: 65 63 75 72               MOVSXD     ESI,dword ptr GS:[RBP + 0x72]
  14000a486: 69 74 79 4f 62 6a 65 63   IMUL       ESI,dword ptr [RCX + RDI*0x2 + 0x4f],0x63656a62
  14000a48e: 74 00                     JZ         0x14000a490
  14000a490: e9 01 49 6f 44            JMP        0x1846fed96
  14000a495: 65 76 69                  JBE        0x14000a501
  14000a498: 63 65 4f                  MOVSXD     ESP,dword ptr [RBP + 0x4f]
  14000a49b: db 0x62
  14000a49c: 6a 65                     PUSH       0x65
  14000a49e: 63 74 54 79               MOVSXD     ESI,dword ptr [RSP + RDX*0x2 + 0x79]
  14000a4a2: 70 65                     JO         0x14000a509
  14000a4a4: 00 00                     ADD        byte ptr [RAX],AL
  14000a4a6: d0 07                     ROL        byte ptr [RDI],0x1
  14000a4a8: 5f                        POP        RDI
  14000a4a9: 73 6e                     JNC        0x14000a519
  14000a4ab: 77 70                     JA         0x14000a51d
  14000a4ad: 72 69                     JC         0x14000a518
  14000a4af: 6e                        OUTSB      DX,RSI
  14000a4b0: 74 66                     JZ         0x14000a518
  14000a4b2: 00 00                     ADD        byte ptr [RAX],AL
  14000a4b4: ea 05 52 74 6c 4c 65      JMPF       0x654c:0x6c745205
  14000a4bb: 6e                        OUTSB      DX,RSI
  14000a4bc: 67 74 68                  JZ         0x14000a527
  14000a4bf: 53                        PUSH       RBX
  14000a4c0: 65 63 75 72               MOVSXD     ESI,dword ptr GS:[RBP + 0x72]
  14000a4c4: 69 74 79 44 65 73 63 72   IMUL       ESI,dword ptr [RCX + RDI*0x2 + 0x44],0x72637365
  14000a4cc: 69 70 74 6f 72 00 83      IMUL       ESI,dword ptr [RAX + 0x74],-0x7cff8d91
  14000a4d3: db 0x06
  14000a4d4: 53                        PUSH       RBX
  14000a4d5: db 0x65, 0x43, 0x61
  14000a4d8: 70 74                     JO         0x14000a54e
  14000a4da: 75 72                     JNZ        0x14000a54e
  14000a4dc: 65 53                     PUSH       RBX
  14000a4de: 65 63 75 72               MOVSXD     ESI,dword ptr GS:[RBP + 0x72]
  14000a4e2: 69 74 79 44 65 73 63 72   IMUL       ESI,dword ptr [RCX + RDI*0x2 + 0x44],0x72637365
  14000a4ea: 69 70 74 6f 72 00 57      IMUL       ESI,dword ptr [RAX + 0x74],0x5700726f
  14000a4f1: 05 52 74 6c 43            ADD        EAX,0x436c7452
  14000a4f6: 72 65                     JC         0x14000a55d
  14000a4f8: db 0x61
  14000a4f9: 74 65                     JZ         0x14000a560
  14000a4fb: 53                        PUSH       RBX
  14000a4fc: 65 63 75 72               MOVSXD     ESI,dword ptr GS:[RBP + 0x72]
  14000a500: 69 74 79 44 65 73 63 72   IMUL       ESI,dword ptr [RCX + RDI*0x2 + 0x44],0x72637365
  14000a508: 69 70 74 6f 72 00 2b      IMUL       ESI,dword ptr [RAX + 0x74],0x2b00726f
  14000a50f: db 0x06
  14000a510: 52                        PUSH       RDX
  14000a511: 74 6c                     JZ         0x14000a57f
  14000a513: 53                        PUSH       RBX
  14000a514: 65 74 44                  JZ         0x14000a55b
  14000a517: db 0x61
  14000a518: 63 6c 53 65               MOVSXD     EBP,dword ptr [RBX + RDX*0x2 + 0x65]
  14000a51c: 63 75 72                  MOVSXD     ESI,dword ptr [RBP + 0x72]
  14000a51f: 69 74 79 44 65 73 63 72   IMUL       ESI,dword ptr [RCX + RDI*0x2 + 0x44],0x72637365
  14000a527: 69 70 74 6f 72 00 00      IMUL       ESI,dword ptr [RAX + 0x74],0x726f
  14000a52e: 22 05 52 74 6c 41         AND        AL,byte ptr [0x1816d1986]
  14000a534: db 0x62
  14000a535: 73 6f                     JNC        0x14000a5a6
  14000a537: 6c                        INSB       RDI,DX
  14000a538: 75 74                     JNZ        0x14000a5ae
  14000a53a: 65 54                     PUSH       RSP
  14000a53c: 6f                        OUTSD      DX,RSI
  14000a53d: 53                        PUSH       RBX
  14000a53e: 65 6c                     INSB       RDI,DX
  14000a540: 66 52                     PUSH       DX
  14000a542: 65 6c                     INSB       RDI,DX
  14000a544: db 0x61
  14000a545: 74 69                     JZ         0x14000a5b0
  14000a547: 76 65                     JBE        0x14000a5ae
  14000a549: 53                        PUSH       RBX
  14000a54a: 44 00 2c 02               ADD        byte ptr [RDX + RAX*0x1],R13B
  14000a54e: 49 6f                     OUTSD      DX,RSI
  14000a550: 49 73 57                  JNC        0x14000a5aa
  14000a553: 64 6d                     INSD       RDI,DX
  14000a555: 56                        PUSH       RSI
  14000a556: 65 72 73                  JC         0x14000a5cc
  14000a559: 69 6f 6e 41 76 61 69      IMUL       EBP,dword ptr [RDI + 0x6e],0x69617641
  14000a560: 6c                        INSB       RDI,DX
  14000a561: db 0x61, 0x62
  14000a563: 6c                        INSB       RDI,DX
  14000a564: 65 00 92 06 53 65 45      ADD        byte ptr GS:[RDX + 0x45655306],DL
  14000a56b: 78 70                     JS         0x14000a5dd
  14000a56d: 6f                        OUTSD      DX,RSI
  14000a56e: 72 74                     JC         0x14000a5e4
  14000a570: 73 00                     JNC        0x14000a572
  14000a572: 2d 08 77 63 73            SUB        EAX,0x73637708
  14000a577: 63 68 72                  MOVSXD     EBP,dword ptr [RAX + 0x72]
  14000a57a: 00 00                     ADD        byte ptr [RAX],AL
  14000a57c: ea 07 5f 77 63 73 6e      JMPF       0x6e73:0x63775f07
  14000a583: 69 63 6d 70 00 eb 05      IMUL       ESP,dword ptr [RBX + 0x6d],0x5eb0070
  14000a58a: 52                        PUSH       RDX
  14000a58b: 74 6c                     JZ         0x14000a5f9
  14000a58d: db 0x4c
  14000a58e: 65 6e                     OUTSB      DX,RSI
  14000a590: 67 74 68                  JZ         0x14000a5fb
  14000a593: 53                        PUSH       RBX
  14000a594: 69 64 00 00 23 05 52 74   IMUL       ESP,dword ptr [RAX + RAX*0x1],0x74520523
  14000a59c: 6c                        INSB       RDI,DX
  14000a59d: db 0x41
  14000a59e: 64 64 41 63 63 65         MOVSXD     ESP,dword ptr FS:[R11 + 0x65]
  14000a5a4: 73 73                     JNC        0x14000a619
  14000a5a6: 41 6c                     INSB       RDI,DX
  14000a5a8: 6c                        INSB       RDI,DX
  14000a5a9: 6f                        OUTSD      DX,RSI
  14000a5aa: 77 65                     JA         0x14000a611
  14000a5ac: 64 41 63 65 00            MOVSXD     ESP,dword ptr FS:[R13]
  14000a5b1: 00 ab 05 52 74 6c         ADD        byte ptr [RBX + 0x6c745205],CH
  14000a5b7: db 0x47
  14000a5b8: 65 74 53                  JZ         0x14000a60e
  14000a5bb: db 0x61
  14000a5bc: 63 6c 53 65               MOVSXD     EBP,dword ptr [RBX + RDX*0x2 + 0x65]
  14000a5c0: 63 75 72                  MOVSXD     ESI,dword ptr [RBP + 0x72]
  14000a5c3: 69 74 79 44 65 73 63 72   IMUL       ESI,dword ptr [RCX + RDI*0x2 + 0x44],0x72637365
  14000a5cb: 69 70 74 6f 72 00 00      IMUL       ESI,dword ptr [RAX + 0x74],0x726f
  14000a5d2: 9d                        POPFQ
  14000a5d3: 05 52 74 6c 47            ADD        EAX,0x476c7452
  14000a5d8: 65 74 44                  JZ         0x14000a61f
  14000a5db: db 0x61
  14000a5dc: 63 6c 53 65               MOVSXD     EBP,dword ptr [RBX + RDX*0x2 + 0x65]
  14000a5e0: 63 75 72                  MOVSXD     ESI,dword ptr [RBP + 0x72]
  14000a5e3: 69 74 79 44 65 73 63 72   IMUL       ESI,dword ptr [RCX + RDI*0x2 + 0x44],0x72637365
  14000a5eb: 69 70 74 6f 72 00 00      IMUL       ESI,dword ptr [RAX + 0x74],0x726f
  14000a5f2: a3 05 52 74 6c 47 65 74 47  MOV        [0x477465476c745205],EAX
  14000a5fb: 72 6f                     JC         0x14000a66c
  14000a5fd: 75 70                     JNZ        0x14000a66f
  14000a5ff: 53                        PUSH       RBX
  14000a600: 65 63 75 72               MOVSXD     ESI,dword ptr GS:[RBP + 0x72]
  14000a604: 69 74 79 44 65 73 63 72   IMUL       ESI,dword ptr [RCX + RDI*0x2 + 0x44],0x72637365
  14000a60c: 69 70 74 6f 72 00 a9      IMUL       ESI,dword ptr [RAX + 0x74],-0x56ff8d91
  14000a613: 05 52 74 6c 47            ADD        EAX,0x476c7452
  14000a618: 65 74 4f                  JZ         0x14000a66a
  14000a61b: 77 6e                     JA         0x14000a68b
  14000a61d: 65 72 53                  JC         0x14000a673
  14000a620: 65 63 75 72               MOVSXD     ESI,dword ptr GS:[RBP + 0x72]
  14000a624: 69 74 79 44 65 73 63 72   IMUL       ESI,dword ptr [RCX + RDI*0x2 + 0x44],0x72637365
  14000a62c: 69 70 74 6f 72 00 4e      IMUL       ESI,dword ptr [RAX + 0x74],0x4e00726f
  14000a633: db 0x07
  14000a634: 5a                        POP        RDX
  14000a635: 77 4f                     JA         0x14000a686
  14000a637: 70 65                     JO         0x14000a69e
  14000a639: 6e                        OUTSB      DX,RSI
  14000a63a: db 0x4b
  14000a63b: 65 79 00                  JNS        0x14000a63e
  14000a63e: db 0x1e, 0x07
  14000a640: 5a                        POP        RDX
  14000a641: 77 43                     JA         0x14000a686
  14000a643: 72 65                     JC         0x14000a6aa
  14000a645: db 0x61
  14000a646: 74 65                     JZ         0x14000a6ad
  14000a648: db 0x4b
  14000a649: 65 79 00                  JNS        0x14000a64c
  14000a64c: 83 07 5a                  ADD        dword ptr [RDI],0x5a
  14000a64f: 77 51                     JA         0x14000a6a2
  14000a651: 75 65                     JNZ        0x14000a6b8
  14000a653: 72 79                     JC         0x14000a6ce
  14000a655: 56                        PUSH       RSI
  14000a656: db 0x61
  14000a657: 6c                        INSB       RDI,DX
  14000a658: 75 65                     JNZ        0x14000a6bf
  14000a65a: db 0x4b
  14000a65b: 65 79 00                  JNS        0x14000a65e
  14000a65e: ae                        SCASB      RDI
  14000a65f: db 0x07
  14000a660: 5a                        POP        RDX
  14000a661: 77 53                     JA         0x14000a6b6
  14000a663: 65 74 56                  JZ         0x14000a6bc
  14000a666: db 0x61
  14000a667: 6c                        INSB       RDI,DX
  14000a668: 75 65                     JNZ        0x14000a6cf
  14000a66a: db 0x4b
  14000a66b: 65 79 00                  JNS        0x14000a66e
  14000a66e: 97                        XCHG       EAX,EDI
  14000a66f: 05 52 74 6c 46            ADD        EAX,0x466c7452
  14000a674: 72 65                     JC         0x14000a6db
  14000a676: 65 55                     PUSH       RBP
  14000a678: 6e                        OUTSB      DX,RSI
  14000a679: 69 63 6f 64 65 53 74      IMUL       ESP,dword ptr [RBX + 0x6f],0x74536564
  14000a680: 72 69                     JC         0x14000a6eb
  14000a682: 6e                        OUTSB      DX,RSI
  14000a683: 67 00 00                  ADD        byte ptr [EAX],AL
  14000a686: 13 02                     ADC        EAX,dword ptr [RDX]
  14000a688: db 0x4b
  14000a689: 65 42 75 67               JNZ        0x14000a6f4
  14000a68d: 43 68 65 63 6b 45         PUSH       0x456b6365
  14000a693: 78 00                     JS         0x14000a695
  14000a695: db 0x00

; --- data ---

dat_140003100:  ; 0x140003100
  140003100: 90 a4 00 00 00 00 00 00 a6 a4 00 00 00 00 00 00  |................|
  140003110: b4 a4 00 00 00 00 00 00 d2 a4 00 00 00 00 00 00  |................|

dat_140003140:  ; 0x140003140
  140003140: 66 a5 00 00 00 00 00 00 72 a5 00 00 00 00 00 00  |f.......r.......|
  140003150: 7c a5 00 00 00 00 00 00 88 a5 00 00 00 00 00 00  ||...............|

s_1400031c0:  ; 0x1400031c0
  1400031c0: 49 00 6f 00 43 00 72 00 65 00 61 00 74 00 65 00  |I.o.C.r.e.a.t.e.|
  1400031d0: 44 00 65 00 76 00 69 00 63 00 65 00 53 00 65 00  |D.e.v.i.c.e.S.e.|
  1400031e0: 63 00 75 00 72 00 65 00 00 00                    |c.u.r.e...|

s_1400031f0:  ; 0x1400031f0
  1400031f0: 49 00 6f 00 56 00 61 00 6c 00 69 00 64 00 61 00  |I.o.V.a.l.i.d.a.|
  140003200: 74 00 65 00 44 00 65 00 76 00 69 00 63 00 65 00  |t.e.D.e.v.i.c.e.|
  140003210: 49 00 6f 00 43 00 6f 00 6e 00 74 00 72 00 6f 00  |I.o.C.o.n.t.r.o.|
  140003220: 6c 00 41 00 63 00 63 00 65 00 73 00 73 00 00 00  |l.A.c.c.e.s.s...|

s_140003248:  ; 0x140003248
  140003248: 44 00 3a 00 50 00 28 00 41 00 3b 00 3b 00 47 00  |D.:.P.(.A.;.;.G.|
  140003258: 41 00 3b 00 3b 00 3b 00 53 00 59 00 29 00 00 00  |A.;.;.;.S.Y.)...|

s_140003278:  ; 0x140003278
  140003278: 44 00 3a 00 50 00 28 00 41 00 3b 00 3b 00 47 00  |D.:.P.(.A.;.;.G.|
  140003288: 41 00 3b 00 3b 00 3b 00 53 00 59 00 29 00 28 00  |A.;.;.;.S.Y.).(.|
  140003298: 41 00 3b 00 3b 00 47 00 41 00 3b 00 3b 00 3b 00  |A.;.;.G.A.;.;.;.|
  1400032a8: 42 00 41 00 29 00 00 00                          |B.A.)...|

s_1400032c0:  ; 0x1400032c0
  1400032c0: 44 00 3a 00 50 00 28 00 41 00 3b 00 3b 00 47 00  |D.:.P.(.A.;.;.G.|
  1400032d0: 41 00 3b 00 3b 00 3b 00 53 00 59 00 29 00 28 00  |A.;.;.;.S.Y.).(.|
  1400032e0: 41 00 3b 00 3b 00 47 00 52 00 47 00 58 00 3b 00  |A.;.;.G.R.G.X.;.|
  1400032f0: 3b 00 3b 00 42 00 41 00 29 00 00 00              |;.;.B.A.)...|

s_140003310:  ; 0x140003310
  140003310: 44 00 3a 00 50 00 28 00 41 00 3b 00 3b 00 47 00  |D.:.P.(.A.;.;.G.|
  140003320: 41 00 3b 00 3b 00 3b 00 53 00 59 00 29 00 28 00  |A.;.;.;.S.Y.).(.|
  140003330: 41 00 3b 00 3b 00 47 00 52 00 47 00 57 00 47 00  |A.;.;.G.R.G.W.G.|
  140003340: 58 00 3b 00 3b 00 3b 00 42 00 41 00 29 00 28 00  |X.;.;.;.B.A.).(.|
  140003350: 41 00 3b 00 3b 00 47 00 52 00 3b 00 3b 00 3b 00  |A.;.;.G.R.;.;.;.|
  140003360: 57 00 44 00 29 00 00 00                          |W.D.)...|

s_140003380:  ; 0x140003380
  140003380: 44 00 3a 00 50 00 28 00 41 00 3b 00 3b 00 47 00  |D.:.P.(.A.;.;.G.|
  140003390: 41 00 3b 00 3b 00 3b 00 53 00 59 00 29 00 28 00  |A.;.;.;.S.Y.).(.|
  1400033a0: 41 00 3b 00 3b 00 47 00 52 00 47 00 57 00 47 00  |A.;.;.G.R.G.W.G.|
  1400033b0: 58 00 3b 00 3b 00 3b 00 42 00 41 00 29 00 28 00  |X.;.;.;.B.A.).(.|
  1400033c0: 41 00 3b 00 3b 00 47 00 52 00 3b 00 3b 00 3b 00  |A.;.;.G.R.;.;.;.|
  1400033d0: 57 00 44 00 29 00 28 00 41 00 3b 00 3b 00 47 00  |W.D.).(.A.;.;.G.|
  1400033e0: 52 00 3b 00 3b 00 3b 00 52 00 43 00 29 00 00 00  |R.;.;.;.R.C.)...|

s_140003400:  ; 0x140003400
  140003400: 44 00 3a 00 50 00 28 00 41 00 3b 00 3b 00 47 00  |D.:.P.(.A.;.;.G.|
  140003410: 41 00 3b 00 3b 00 3b 00 53 00 59 00 29 00 28 00  |A.;.;.;.S.Y.).(.|
  140003420: 41 00 3b 00 3b 00 47 00 52 00 47 00 57 00 47 00  |A.;.;.G.R.G.W.G.|
  140003430: 58 00 3b 00 3b 00 3b 00 42 00 41 00 29 00 28 00  |X.;.;.;.B.A.).(.|
  140003440: 41 00 3b 00 3b 00 47 00 52 00 47 00 57 00 3b 00  |A.;.;.G.R.G.W.;.|
  140003450: 3b 00 3b 00 57 00 44 00 29 00 28 00 41 00 3b 00  |;.;.W.D.).(.A.;.|
  140003460: 3b 00 47 00 52 00 3b 00 3b 00 3b 00 52 00 43 00  |;.G.R.;.;.;.R.C.|
  140003470: 29 00 00 00                                      |)...|

s_140003490:  ; 0x140003490
  140003490: 44 00 3a 00 50 00 28 00 41 00 3b 00 3b 00 47 00  |D.:.P.(.A.;.;.G.|
  1400034a0: 41 00 3b 00 3b 00 3b 00 53 00 59 00 29 00 28 00  |A.;.;.;.S.Y.).(.|
  1400034b0: 41 00 3b 00 3b 00 47 00 52 00 47 00 57 00 47 00  |A.;.;.G.R.G.W.G.|
  1400034c0: 58 00 3b 00 3b 00 3b 00 42 00 41 00 29 00 28 00  |X.;.;.;.B.A.).(.|
  1400034d0: 41 00 3b 00 3b 00 47 00 52 00 47 00 57 00 47 00  |A.;.;.G.R.G.W.G.|
  1400034e0: 58 00 3b 00 3b 00 3b 00 57 00 44 00 29 00 28 00  |X.;.;.;.W.D.).(.|
  1400034f0: 41 00 3b 00 3b 00 47 00 52 00 47 00 57 00 47 00  |A.;.;.G.R.G.W.G.|
  140003500: 58 00 3b 00 3b 00 3b 00 52 00 43 00 29 00 00 00  |X.;.;.;.R.C.)...|

s_140003520:  ; 0x140003520
  140003520: 50 00 72 00 6f 00 70 00 65 00 72 00 74 00 69 00  |P.r.o.p.e.r.t.i.|
  140003530: 65 00 73 00 00 00                                |e.s...|

s_140003538:  ; 0x140003538
  140003538: 43 00 6c 00 61 00 73 00 73 00 00 00              |C.l.a.s.s...|

s_140003548:  ; 0x140003548
  140003548: 4e 00 6f 00 44 00 69 00 73 00 70 00 6c 00 61 00  |N.o.D.i.s.p.l.a.|
  140003558: 79 00 43 00 6c 00 61 00 73 00 73 00 00 00        |y.C.l.a.s.s...|

s_140003568:  ; 0x140003568
  140003568: 4e 00 6f 00 55 00 73 00 65 00 43 00 6c 00 61 00  |N.o.U.s.e.C.l.a.|
  140003578: 73 00 73 00 00 00                                |s.s...|

s_140003580:  ; 0x140003580
  140003580: 53 00 65 00 63 00 75 00 72 00 69 00 74 00 79 00  |S.e.c.u.r.i.t.y.|
  140003590: 00 00                                            |..|

s_140003598:  ; 0x140003598
  140003598: 44 00 65 00 76 00 69 00 63 00 65 00 54 00 79 00  |D.e.v.i.c.e.T.y.|
  1400035a8: 70 00 65 00 00 00                                |p.e...|

s_1400035b0:  ; 0x1400035b0
  1400035b0: 44 00 65 00 76 00 69 00 63 00 65 00 43 00 68 00  |D.e.v.i.c.e.C.h.|
  1400035c0: 61 00 72 00 61 00 63 00 74 00 65 00 72 00 69 00  |a.r.a.c.t.e.r.i.|
  1400035d0: 73 00 74 00 69 00 63 00 73 00 00 00              |s.t.i.c.s...|

s_1400035e0:  ; 0x1400035e0
  1400035e0: 45 00 78 00 63 00 6c 00 75 00 73 00 69 00 76 00  |E.x.c.l.u.s.i.v.|
  1400035f0: 65 00 00 00                                      |e...|

s_140003600:  ; 0x140003600
  140003600: 5c 00 52 00 65 00 67 00 69 00 73 00 74 00 72 00  |\.R.e.g.i.s.t.r.|
  140003610: 79 00 5c 00 4d 00 61 00 63 00 68 00 69 00 6e 00  |y.\.M.a.c.h.i.n.|
  140003620: 65 00 5c 00 53 00 79 00 73 00 74 00 65 00 6d 00  |e.\.S.y.s.t.e.m.|
  140003630: 5c 00 43 00 75 00 72 00 72 00 65 00 6e 00 74 00  |\.C.u.r.r.e.n.t.|
  140003640: 43 00 6f 00 6e 00 74 00 72 00 6f 00 6c 00 53 00  |C.o.n.t.r.o.l.S.|
  140003650: 65 00 74 00 5c 00 43 00 6f 00 6e 00 74 00 72 00  |e.t.\.C.o.n.t.r.|
  140003660: 6f 00 6c 00 5c 00 43 00 6c 00 61 00 73 00 73 00  |o.l.\.C.l.a.s.s.|
  140003670: 00 00                                            |..|

s_140003680:  ; 0x140003680
  140003680: 7b 00 25 00 30 00 38 00 58 00 2d 00 25 00 30 00  |{.%.0.8.X.-.%.0.|
  140003690: 34 00 58 00 2d 00 25 00 30 00 34 00 58 00 2d 00  |4.X.-.%.0.4.X.-.|
  1400036a0: 25 00 30 00 32 00 58 00 25 00 30 00 32 00 58 00  |%.0.2.X.%.0.2.X.|
  1400036b0: 2d 00 25 00 30 00 32 00 58 00 25 00 30 00 32 00  |-.%.0.2.X.%.0.2.|
  1400036c0: 58 00 25 00 30 00 32 00 58 00 25 00 30 00 32 00  |X.%.0.2.X.%.0.2.|
  1400036d0: 58 00 25 00 30 00 32 00 58 00 25 00 30 00 32 00  |X.%.0.2.X.%.0.2.|
  1400036e0: 58 00 7d 00 00 00                                |X.}...|

s_140003728:  ; 0x140003728
  140003728: 41 00                                            |A.|

s_140003730:  ; 0x140003730
  140003730: 25 53 20 28 49 52 51 4c 20 25 32 2e 32 64 29 3a  |%S (IRQL %2.2d):|
  140003740: 20 45 52 52 4f 52 20 25 73 0a 00                 | ERROR %s..|

s_140003750:  ; 0x140003750
  140003750: 25 53 20 28 49 52 51 4c 20 25 32 2e 32 64 29 3a  |%S (IRQL %2.2d):|
  140003760: 20 57 41 52 4e 49 4e 47 20 25 73 0a 00           | WARNING %s..|

s_140003770:  ; 0x140003770
  140003770: 25 53 20 28 49 52 51 4c 20 25 32 2e 32 64 29 3a  |%S (IRQL %2.2d):|
  140003780: 20 49 4e 46 4f 20 25 73 0a 00                    | INFO %s..|

s_140003790:  ; 0x140003790
  140003790: 25 53 20 28 49 52 51 4c 20 25 32 2e 32 64 29 3a  |%S (IRQL %2.2d):|
  1400037a0: 20 25 73 0a 00                                   | %s..|

s_1400037b0:  ; 0x1400037b0
  1400037b0: 41 70 72 20 31 31 20 32 30 32 32 00              |Apr 11 2022.|

s_1400037c0:  ; 0x1400037c0
  1400037c0: 30 39 3a 31 34 3a 31 37 00                       |09:14:17.|

s_1400037d0:  ; 0x1400037d0
  1400037d0: 44 72 69 76 65 72 20 63 6f 6d 70 69 6c 65 64 20  |Driver compiled |
  1400037e0: 61 74 20 25 73 20 6f 6e 20 25 73 00              |at %s on %s.|

s_1400037f0:  ; 0x1400037f0
  1400037f0: 44 72 69 76 65 72 45 6e 74 72 79 3a 20 46 61 69  |DriverEntry: Fai|
  140003800: 6c 65 64 20 74 6f 20 61 6c 6c 6f 63 61 74 65 20  |led to allocate |
  140003810: 6d 65 6d 6f 72 79 20 66 6f 72 20 44 72 69 76 65  |memory for Drive|
  140003820: 72 4e 61 6d 65 00                                |rName.|

s_140003828:  ; 0x140003828
  140003828: 44 72 69 76 65 72 45 6e 74 72 79 3a 20 46 61 69  |DriverEntry: Fai|
  140003838: 6c 65 64 20 74 6f 20 61 6c 6c 6f 63 61 74 65 20  |led to allocate |
  140003848: 6d 65 6d 6f 72 79 20 66 6f 72 20 52 65 67 69 73  |memory for Regis|
  140003858: 74 72 79 50 61 74 68 00                          |tryPath.|

s_14000385e:  ; 0x14000385e
  14000385e: 68 00 5c 00 44 00 65 00 76 00 69 00 63 00 65 00  |h.\.D.e.v.i.c.e.|
  14000386e: 5c 00 25 00 6c 00 73 00 00 00                    |\.%.l.s...|

s_140003878:  ; 0x140003878
  140003878: 44 72 69 76 65 72 45 6e 74 72 79 2d 2d 2e 20 53  |DriverEntry--. S|
  140003888: 54 41 54 55 53 20 25 78 00                       |TATUS %x.|

s_140003898:  ; 0x140003898
  140003898: 43 72 65 61 74 65 64 20 64 65 76 69 63 65 3a 20  |Created device: |
  1400038a8: 25 53 00                                         |%S.|

s_1400038b0:  ; 0x1400038b0
  1400038b0: 5c 00 3f 00 3f 00 5c 00 25 00 6c 00 73 00 00 00  |\.?.?.\.%.l.s...|

s_1400038c0:  ; 0x1400038c0
  1400038c0: 43 72 65 61 74 65 64 20 6c 69 6e 6b 3a 20 25 53  |Created link: %S|
  1400038d0: 20 2d 3e 20 25 53 00                             | -> %S.|

s_1400038d8:  ; 0x1400038d8
  1400038d8: 44 65 6c 65 74 65 64 20 6c 69 6e 6b 3a 20 25 53  |Deleted link: %S|
  1400038e8: 00                                               |.|

s_1400038f0:  ; 0x1400038f0
  1400038f0: 69 6f 63 74 6c 2e 63 00                          |ioctl.c.|

s_1400038f8:  ; 0x1400038f8
  1400038f8: 25 73 20 25 64 3a 20 49 6e 76 61 6c 69 64 20 62  |%s %d: Invalid b|
  140003908: 75 66 66 65 72 20 73 69 7a 65 00                 |uffer size.|

s_140003918:  ; 0x140003918
  140003918: 43 61 6c 6c 20 74 6f 20 4d 6d 4d 61 70 49 6f 53  |Call to MmMapIoS|
  140003928: 70 61 63 65 20 66 61 69 6c 65 64 2e 00           |pace failed..|

s_140003938:  ; 0x140003938
  140003938: 43 61 6c 6c 20 74 6f 20 49 6f 41 6c 6c 6f 63 61  |Call to IoAlloca|
  140003948: 74 65 4d 64 6c 20 66 61 69 6c 65 64 2e 00        |teMdl failed..|

s_140003958:  ; 0x140003958
  140003958: 43 61 6c 6c 20 74 6f 20 4d 6d 4d 61 70 4c 6f 63  |Call to MmMapLoc|
  140003968: 6b 65 64 20 66 61 69 6c 65 64 20 64 75 65 20 74  |ked failed due t|
  140003978: 6f 20 65 78 63 65 70 74 69 6f 6e 20 30 78 25 30  |o exception 0x%0|
  140003988: 78 0a 00                                         |x..|

s_140003990:  ; 0x140003990
  140003990: 4d 61 78 69 6d 75 6d 20 6e 75 6d 62 65 72 20 6f  |Maximum number o|
  1400039a0: 66 20 6d 65 6d 6f 72 79 20 6d 61 70 70 69 6e 67  |f memory mapping|
  1400039b0: 73 20 72 65 61 63 68 65 64 00                    |s reached.|

s_1400039c0:  ; 0x1400039c0
  1400039c0: 25 73 20 25 64 3a 20 4d 6d 4d 61 70 49 6f 53 70  |%s %d: MmMapIoSp|
  1400039d0: 61 63 65 20 66 61 69 6c 65 64 00                 |ace failed.|

s_140003a4c:  ; 0x140003a4c
  140003a4c: 44 72 69 76 65 72 2e 70 64 62 00                 |Driver.pdb.|

s_140003a6c:  ; 0x140003a6c
  140003a6c: 47 43 54 4c 00                                   |GCTL.|

s_140003a78:  ; 0x140003a78
  140003a78: 2e 74 65 78 74 00                                |.text.|

s_140003a88:  ; 0x140003a88
  140003a88: 2e 74 65 78 74 24 6d 6e 00                       |.text$mn.|

s_140003a9c:  ; 0x140003a9c
  140003a9c: 2e 69 64 61 74 61 24 35 00                       |.idata$5.|

s_140003ab0:  ; 0x140003ab0
  140003ab0: 2e 72 64 61 74 61 00                             |.rdata.|

s_140003ac0:  ; 0x140003ac0
  140003ac0: 2e 72 64 61 74 61 24 7a 7a 7a 64 62 67 00        |.rdata$zzzdbg.|

s_140003ad8:  ; 0x140003ad8
  140003ad8: 2e 78 64 61 74 61 00                             |.xdata.|

s_140003ae8:  ; 0x140003ae8
  140003ae8: 2e 64 61 74 61 00                                |.data.|

s_140003af8:  ; 0x140003af8
  140003af8: 2e 62 73 73 00                                   |.bss.|

s_140003b08:  ; 0x140003b08
  140003b08: 2e 70 64 61 74 61 00                             |.pdata.|

s_140003b18:  ; 0x140003b18
  140003b18: 50 41 47 45 00                                   |PAGE.|

s_140003b28:  ; 0x140003b28
  140003b28: 2e 69 64 61 74 61 24 32 00                       |.idata$2.|

s_140003b3c:  ; 0x140003b3c
  140003b3c: 2e 69 64 61 74 61 24 33 00                       |.idata$3.|

s_140003b50:  ; 0x140003b50
  140003b50: 2e 69 64 61 74 61 24 34 00                       |.idata$4.|

s_140003b64:  ; 0x140003b64
  140003b64: 2e 69 64 61 74 61 24 36 00                       |.idata$6.|

s_140003b78:  ; 0x140003b78
  140003b78: 2e 72 73 72 63 24 30 31 00                       |.rsrc$01.|

s_140003b8c:  ; 0x140003b8c
  140003b8c: 2e 72 73 72 63 24 30 32 00                       |.rsrc$02.|

dat_140004044:  ; 0x140004044
  140004044: 02 00 00 00 10 01 00 00 00 00 00 00 00 00 00 00  |................|
  140004054: 42 00 41 00 00 00 00 00 02 00 00 00 08 01 00 00  |B.A.............|

dat_140004150:  ; 0x140004150
  140004150: 20 37 00 40 01 00 00 00 02 00 00 00 00 00 02 00  | 7.@............|
  140004160: 18 37 00 40 01 00 00 00 02 00 00 00 00 00 04 00  |.7.@............|

dat_1400041d0:  ; 0x1400041d0
  1400041d0: 32 a2 df 2d 99 2b 00 00                          |2..-.+..|

dat_1400041d8:  ; 0x1400041d8
  1400041d8: cd 5d 20 d2 66 d4 ff ff                          |.] .f...|

dat_1400041e0:  ; 0x1400041e0
  1400041e0: 00 00 00 00 00 00 00 00                          |........|

dat_1400041e8:  ; 0x1400041e8
  1400041e8: 00 00 00 00 00 00 00 00                          |........|

dat_1400041f0:  ; 0x1400041f0
  1400041f0: 00 00 00 00 00 00 00 00                          |........|

dat_1400041f8:  ; 0x1400041f8
  1400041f8: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
  140004208: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|

dat_140004220:  ; 0x140004220
  140004220: 00 00                                            |..|

dat_140004222:  ; 0x140004222
  140004222: 00 00 00 00 00 00                                |......|

dat_140004228:  ; 0x140004228
  140004228: 00 00 00 00 00 00 00 00                          |........|

dat_140004230:  ; 0x140004230
  140004230: 00 00                                            |..|

dat_140004232:  ; 0x140004232
  140004232: 00 00 00 00 00 00                                |......|

dat_140004238:  ; 0x140004238
  140004238: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
  140004248: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|

s_1400087cd:  ; 0x1400087cd
  1400087cd: 44 24 60 31 00                                   |D$`1.|

s_140009534:  ; 0x140009534
  140009534: 44 24 40 30 00                                   |D$@0.|

s_1400095c9:  ; 0x1400095c9
  1400095c9: 44 24 20 30 00                                   |D$ 0.|

s_14000a1fa:  ; 0x14000a1fa
  14000a1fa: 5f 76 73 6e 70 72 69 6e 74 66 00                 |_vsnprintf.|

s_14000a208:  ; 0x14000a208
  14000a208: 44 62 67 50 72 69 6e 74 00                       |DbgPrint.|

s_14000a214:  ; 0x14000a214
  14000a214: 5f 76 73 6e 77 70 72 69 6e 74 66 00              |_vsnwprintf.|

s_14000a222:  ; 0x14000a222
  14000a222: 52 74 6c 49 6e 69 74 55 6e 69 63 6f 64 65 53 74  |RtlInitUnicodeSt|
  14000a232: 72 69 6e 67 00                                   |ring.|

s_14000a23a:  ; 0x14000a23a
  14000a23a: 49 6f 44 65 6c 65 74 65 44 65 76 69 63 65 00     |IoDeleteDevice.|

s_14000a24c:  ; 0x14000a24c
  14000a24c: 52 74 6c 43 6f 70 79 55 6e 69 63 6f 64 65 53 74  |RtlCopyUnicodeSt|
  14000a25c: 72 69 6e 67 00                                   |ring.|

s_14000a264:  ; 0x14000a264
  14000a264: 49 6f 44 65 6c 65 74 65 53 79 6d 62 6f 6c 69 63  |IoDeleteSymbolic|
  14000a274: 4c 69 6e 6b 00                                   |Link.|

s_14000a27c:  ; 0x14000a27c
  14000a27c: 49 6f 52 65 67 69 73 74 65 72 53 68 75 74 64 6f  |IoRegisterShutdo|
  14000a28c: 77 6e 4e 6f 74 69 66 69 63 61 74 69 6f 6e 00     |wnNotification.|

s_14000a29e:  ; 0x14000a29e
  14000a29e: 45 78 41 6c 6c 6f 63 61 74 65 50 6f 6f 6c 57 69  |ExAllocatePoolWi|
  14000a2ae: 74 68 54 61 67 00                                |thTag.|

s_14000a2b6:  ; 0x14000a2b6
  14000a2b6: 49 6f 55 6e 72 65 67 69 73 74 65 72 53 68 75 74  |IoUnregisterShut|
  14000a2c6: 64 6f 77 6e 4e 6f 74 69 66 69 63 61 74 69 6f 6e  |downNotification|
  14000a2d6: 00                                               |.|

s_14000a2da:  ; 0x14000a2da
  14000a2da: 45 78 46 72 65 65 50 6f 6f 6c 57 69 74 68 54 61  |ExFreePoolWithTa|
  14000a2ea: 67 00                                            |g.|

s_14000a2ee:  ; 0x14000a2ee
  14000a2ee: 49 6f 66 43 6f 6d 70 6c 65 74 65 52 65 71 75 65  |IofCompleteReque|
  14000a2fe: 73 74 00                                         |st.|

s_14000a304:  ; 0x14000a304
  14000a304: 49 6f 43 72 65 61 74 65 53 79 6d 62 6f 6c 69 63  |IoCreateSymbolic|
  14000a314: 4c 69 6e 6b 00                                   |Link.|

s_14000a31c:  ; 0x14000a31c
  14000a31c: 77 63 73 72 63 68 72 00                          |wcsrchr.|

s_14000a326:  ; 0x14000a326
  14000a326: 5f 5f 43 5f 73 70 65 63 69 66 69 63 5f 68 61 6e  |__C_specific_han|
  14000a336: 64 6c 65 72 00                                   |dler.|

s_14000a33e:  ; 0x14000a33e
  14000a33e: 4d 6d 42 75 69 6c 64 4d 64 6c 46 6f 72 4e 6f 6e  |MmBuildMdlForNon|
  14000a34e: 50 61 67 65 64 50 6f 6f 6c 00                    |PagedPool.|

s_14000a35a:  ; 0x14000a35a
  14000a35a: 49 6f 41 6c 6c 6f 63 61 74 65 4d 64 6c 00        |IoAllocateMdl.|

s_14000a36a:  ; 0x14000a36a
  14000a36a: 4d 6d 4d 61 70 49 6f 53 70 61 63 65 00           |MmMapIoSpace.|

s_14000a37a:  ; 0x14000a37a
  14000a37a: 4d 6d 55 6e 6d 61 70 49 6f 53 70 61 63 65 00     |MmUnmapIoSpace.|

s_14000a38c:  ; 0x14000a38c
  14000a38c: 50 73 47 65 74 43 75 72 72 65 6e 74 50 72 6f 63  |PsGetCurrentProc|
  14000a39c: 65 73 73 49 64 00                                |essId.|

s_14000a3a4:  ; 0x14000a3a4
  14000a3a4: 49 6f 46 72 65 65 4d 64 6c 00                    |IoFreeMdl.|

s_14000a3b0:  ; 0x14000a3b0
  14000a3b0: 4d 6d 55 6e 6d 61 70 4c 6f 63 6b 65 64 50 61 67  |MmUnmapLockedPag|
  14000a3c0: 65 73 00                                         |es.|

s_14000a3c6:  ; 0x14000a3c6
  14000a3c6: 4d 6d 4d 61 70 4c 6f 63 6b 65 64 50 61 67 65 73  |MmMapLockedPages|
  14000a3d6: 53 70 65 63 69 66 79 43 61 63 68 65 00           |SpecifyCache.|

s_14000a3e4:  ; 0x14000a3e4
  14000a3e4: 6e 74 6f 73 6b 72 6e 6c 2e 65 78 65 00           |ntoskrnl.exe.|

s_14000a3f4:  ; 0x14000a3f4
  14000a3f4: 48 61 6c 53 65 74 42 75 73 44 61 74 61 42 79 4f  |HalSetBusDataByO|
  14000a404: 66 66 73 65 74 00                                |ffset.|

s_14000a40c:  ; 0x14000a40c
  14000a40c: 48 61 6c 47 65 74 42 75 73 44 61 74 61 42 79 4f  |HalGetBusDataByO|
  14000a41c: 66 66 73 65 74 00                                |ffset.|

s_14000a422:  ; 0x14000a422
  14000a422: 48 41 4c 2e 64 6c 6c 00                          |HAL.dll.|

s_14000a42c:  ; 0x14000a42c
  14000a42c: 4d 6d 47 65 74 53 79 73 74 65 6d 52 6f 75 74 69  |MmGetSystemRouti|
  14000a43c: 6e 65 41 64 64 72 65 73 73 00                    |neAddress.|

s_14000a448:  ; 0x14000a448
  14000a448: 49 6f 43 72 65 61 74 65 44 65 76 69 63 65 00     |IoCreateDevice.|

s_14000a45a:  ; 0x14000a45a
  14000a45a: 5a 77 43 6c 6f 73 65 00                          |ZwClose.|

s_14000a464:  ; 0x14000a464
  14000a464: 4f 62 4f 70 65 6e 4f 62 6a 65 63 74 42 79 50 6f  |ObOpenObjectByPo|
  14000a474: 69 6e 74 65 72 00                                |inter.|

s_14000a47c:  ; 0x14000a47c
  14000a47c: 5a 77 53 65 74 53 65 63 75 72 69 74 79 4f 62 6a  |ZwSetSecurityObj|
  14000a48c: 65 63 74 00                                      |ect.|

s_14000a492:  ; 0x14000a492
  14000a492: 49 6f 44 65 76 69 63 65 4f 62 6a 65 63 74 54 79  |IoDeviceObjectTy|
  14000a4a2: 70 65 00                                         |pe.|

s_14000a4a8:  ; 0x14000a4a8
  14000a4a8: 5f 73 6e 77 70 72 69 6e 74 66 00                 |_snwprintf.|

s_14000a4b6:  ; 0x14000a4b6
  14000a4b6: 52 74 6c 4c 65 6e 67 74 68 53 65 63 75 72 69 74  |RtlLengthSecurit|
  14000a4c6: 79 44 65 73 63 72 69 70 74 6f 72 00              |yDescriptor.|

s_14000a4d4:  ; 0x14000a4d4
  14000a4d4: 53 65 43 61 70 74 75 72 65 53 65 63 75 72 69 74  |SeCaptureSecurit|
  14000a4e4: 79 44 65 73 63 72 69 70 74 6f 72 00              |yDescriptor.|

s_14000a4f2:  ; 0x14000a4f2
  14000a4f2: 52 74 6c 43 72 65 61 74 65 53 65 63 75 72 69 74  |RtlCreateSecurit|
  14000a502: 79 44 65 73 63 72 69 70 74 6f 72 00              |yDescriptor.|

s_14000a510:  ; 0x14000a510
  14000a510: 52 74 6c 53 65 74 44 61 63 6c 53 65 63 75 72 69  |RtlSetDaclSecuri|
  14000a520: 74 79 44 65 73 63 72 69 70 74 6f 72 00           |tyDescriptor.|

s_14000a530:  ; 0x14000a530
  14000a530: 52 74 6c 41 62 73 6f 6c 75 74 65 54 6f 53 65 6c  |RtlAbsoluteToSel|
  14000a540: 66 52 65 6c 61 74 69 76 65 53 44 00              |fRelativeSD.|

s_14000a54e:  ; 0x14000a54e
  14000a54e: 49 6f 49 73 57 64 6d 56 65 72 73 69 6f 6e 41 76  |IoIsWdmVersionAv|
  14000a55e: 61 69 6c 61 62 6c 65 00                          |ailable.|

s_14000a568:  ; 0x14000a568
  14000a568: 53 65 45 78 70 6f 72 74 73 00                    |SeExports.|

s_14000a574:  ; 0x14000a574
  14000a574: 77 63 73 63 68 72 00                             |wcschr.|

s_14000a57e:  ; 0x14000a57e
  14000a57e: 5f 77 63 73 6e 69 63 6d 70 00                    |_wcsnicmp.|

s_14000a58a:  ; 0x14000a58a
  14000a58a: 52 74 6c 4c 65 6e 67 74 68 53 69 64 00           |RtlLengthSid.|

s_14000a59a:  ; 0x14000a59a
  14000a59a: 52 74 6c 41 64 64 41 63 63 65 73 73 41 6c 6c 6f  |RtlAddAccessAllo|
  14000a5aa: 77 65 64 41 63 65 00                             |wedAce.|

s_14000a5b4:  ; 0x14000a5b4
  14000a5b4: 52 74 6c 47 65 74 53 61 63 6c 53 65 63 75 72 69  |RtlGetSaclSecuri|
  14000a5c4: 74 79 44 65 73 63 72 69 70 74 6f 72 00           |tyDescriptor.|

s_14000a5d4:  ; 0x14000a5d4
  14000a5d4: 52 74 6c 47 65 74 44 61 63 6c 53 65 63 75 72 69  |RtlGetDaclSecuri|
  14000a5e4: 74 79 44 65 73 63 72 69 70 74 6f 72 00           |tyDescriptor.|

s_14000a5f4:  ; 0x14000a5f4
  14000a5f4: 52 74 6c 47 65 74 47 72 6f 75 70 53 65 63 75 72  |RtlGetGroupSecur|
  14000a604: 69 74 79 44 65 73 63 72 69 70 74 6f 72 00        |ityDescriptor.|

s_14000a614:  ; 0x14000a614
  14000a614: 52 74 6c 47 65 74 4f 77 6e 65 72 53 65 63 75 72  |RtlGetOwnerSecur|
  14000a624: 69 74 79 44 65 73 63 72 69 70 74 6f 72 00        |ityDescriptor.|

s_14000a634:  ; 0x14000a634
  14000a634: 5a 77 4f 70 65 6e 4b 65 79 00                    |ZwOpenKey.|

s_14000a640:  ; 0x14000a640
  14000a640: 5a 77 43 72 65 61 74 65 4b 65 79 00              |ZwCreateKey.|

s_14000a64e:  ; 0x14000a64e
  14000a64e: 5a 77 51 75 65 72 79 56 61 6c 75 65 4b 65 79 00  |ZwQueryValueKey.|

s_14000a660:  ; 0x14000a660
  14000a660: 5a 77 53 65 74 56 61 6c 75 65 4b 65 79 00        |ZwSetValueKey.|

s_14000a670:  ; 0x14000a670
  14000a670: 52 74 6c 46 72 65 65 55 6e 69 63 6f 64 65 53 74  |RtlFreeUnicodeSt|
  14000a680: 72 69 6e 67 00                                   |ring.|

s_14000a688:  ; 0x14000a688
  14000a688: 4b 65 42 75 67 43 68 65 63 6b 45 78 00           |KeBugCheckEx.|

s_14000b066:  ; 0x14000b066
  14000b066: 56 00 53 00 5f 00 56 00 45 00 52 00 53 00 49 00  |V.S._.V.E.R.S.I.|
  14000b076: 4f 00 4e 00 5f 00 49 00 4e 00 46 00 4f 00 00 00  |O.N._.I.N.F.O...|

s_14000b0c2:  ; 0x14000b0c2
  14000b0c2: 53 00 74 00 72 00 69 00 6e 00 67 00 46 00 69 00  |S.t.r.i.n.g.F.i.|
  14000b0d2: 6c 00 65 00 49 00 6e 00 66 00 6f 00 00 00        |l.e.I.n.f.o...|

s_14000b0e6:  ; 0x14000b0e6
  14000b0e6: 30 00 34 00 30 00 39 00 30 00 34 00 62 00 30 00  |0.4.0.9.0.4.b.0.|
  14000b0f6: 00 00                                            |..|

s_14000b0fe:  ; 0x14000b0fe
  14000b0fe: 46 00 69 00 6c 00 65 00 44 00 65 00 73 00 63 00  |F.i.l.e.D.e.s.c.|
  14000b10e: 72 00 69 00 70 00 74 00 69 00 6f 00 6e 00 00 00  |r.i.p.t.i.o.n...|

s_14000b120:  ; 0x14000b120
  14000b120: 4c 00 6f 00 77 00 2d 00 4c 00 65 00 76 00 65 00  |L.o.w.-.L.e.v.e.|
  14000b130: 6c 00 20 00 44 00 72 00 69 00 76 00 65 00 72 00  |l. .D.r.i.v.e.r.|
  14000b140: 00 00                                            |..|

s_14000b14a:  ; 0x14000b14a
  14000b14a: 46 00 69 00 6c 00 65 00 56 00 65 00 72 00 73 00  |F.i.l.e.V.e.r.s.|
  14000b15a: 69 00 6f 00 6e 00 00 00                          |i.o.n...|

s_14000b164:  ; 0x14000b164
  14000b164: 34 00 2e 00 30 00 2e 00 30 00 2e 00 30 00 00 00  |4...0...0...0...|

s_14000b17a:  ; 0x14000b17a
  14000b17a: 4c 00 65 00 67 00 61 00 6c 00 43 00 6f 00 70 00  |L.e.g.a.l.C.o.p.|
  14000b18a: 79 00 72 00 69 00 67 00 68 00 74 00 00 00        |y.r.i.g.h.t...|

s_14000b198:  ; 0x14000b198
  14000b198: 43 00 6f 00 70 00 79 00 72 00 69 00 67 00 68 00  |C.o.p.y.r.i.g.h.|
  14000b1a8: 74 00 20 00 32 00 30 00 30 00 34 00 2d 00 32 00  |t. .2.0.0.4.-.2.|
  14000b1b8: 30 00 32 00 32 00 20 00 28 00 63 00 29 00 2e 00  |0.2.2. .(.c.)...|
  14000b1c8: 20 00 41 00 6c 00 6c 00 20 00 72 00 69 00 67 00  | .A.l.l. .r.i.g.|
  14000b1d8: 68 00 74 00 73 00 20 00 72 00 65 00 73 00 65 00  |h.t.s. .r.e.s.e.|
  14000b1e8: 72 00 76 00 65 00 64 00 2e 00 00 00              |r.v.e.d.....|

s_14000b1fa:  ; 0x14000b1fa
  14000b1fa: 50 00 72 00 6f 00 64 00 75 00 63 00 74 00 4e 00  |P.r.o.d.u.c.t.N.|
  14000b20a: 61 00 6d 00 65 00 00 00                          |a.m.e...|

s_14000b214:  ; 0x14000b214
  14000b214: 4c 00 6f 00 77 00 2d 00 4c 00 65 00 76 00 65 00  |L.o.w.-.L.e.v.e.|
  14000b224: 6c 00 20 00 44 00 72 00 69 00 76 00 65 00 72 00  |l. .D.r.i.v.e.r.|
  14000b234: 00 00                                            |..|

s_14000b23e:  ; 0x14000b23e
  14000b23e: 50 00 72 00 6f 00 64 00 75 00 63 00 74 00 56 00  |P.r.o.d.u.c.t.V.|
  14000b24e: 65 00 72 00 73 00 69 00 6f 00 6e 00 00 00        |e.r.s.i.o.n...|

s_14000b25c:  ; 0x14000b25c
  14000b25c: 34 00 2e 00 30 00 2e 00 30 00 2e 00 30 00 00 00  |4...0...0...0...|

s_14000b272:  ; 0x14000b272
  14000b272: 56 00 61 00 72 00 46 00 69 00 6c 00 65 00 49 00  |V.a.r.F.i.l.e.I.|
  14000b282: 6e 00 66 00 6f 00 00 00                          |n.f.o...|

s_14000b292:  ; 0x14000b292
  14000b292: 54 00 72 00 61 00 6e 00 73 00 6c 00 61 00 74 00  |T.r.a.n.s.l.a.t.|
  14000b2a2: 69 00 6f 00 6e 00 00 00                          |i.o.n...|
