;; notes on changes made for OSX assembler
;;	SP			->		r1
;;	vrsave		->		256
;;	vN			->		vN
;;	$000N			->		0xN
;;	*+N		->		.+N
;;	*-N		->		.-N
;;	lwbrx		vN, r0, rN		->		lwbrx		vN, 0, rN
;;	cmpwi r0,-1			->		cmpwi r0,$ffff
;;	cr6_EQ			->		26

;	rlwinm  r12,r1,0,28,31    ; CWP6.3 converted "clrlwi ;r12,r1,28" into this line
;	no SET instructions appear in the CW6.3 disassembly

.data
.cstring
	.align 2
	.ascii	"AltiVec assembly by Dan Oetting\0"
	.ascii	"Converted to Mac OS X assembly dialect by Michael Feiri\0"

.text
	
	;; This is the AltiVec RC5 cruncher
	.align 5
	
	.globl _crunch_vec_7450
	
_crunch_vec_7450:
	
		mflr       r0
		stw        r0,8(r1)
		stmw       r13,-76(r1)
		stw        r3,24(r1)
		stw        r4,28(r1)
		mfspr      r0,256
		stw        r0,-80(r1)
		li         r0,-1
		mtspr      256,r0
		mr         r6,r1
		clrlwi     r12,r1,28
		subfic     r12,r12,-560
		stwux      r1,r1,r12
		li         r0,288
		stvx       v20,r1,r0
		li         r0,304
		stvx       v21,r1,r0
		li         r0,320
		stvx       v22,r1,r0
		li         r0,336
		stvx       v23,r1,r0
		li         r0,352
		stvx       v24,r1,r0
		li         r0,368
		stvx       v25,r1,r0
		li         r0,384
		stvx       v26,r1,r0
		li         r0,400
		stvx       v27,r1,r0
		li         r0,416
		stvx       v28,r1,r0
		li         r0,432
		stvx       v29,r1,r0
		li         r0,448
		stvx       v30,r1,r0
		li         r0,464
		stvx       v31,r1,r0
		lwz        r0,0(r3)
		stw        r0,84(r1)
		lwz        r0,4(r3)
		stw        r0,80(r1)
		lwz        r0,8(r3)
		stw        r0,92(r1)
		lwz        r0,12(r3)
		stw        r0,88(r1)
		li         r5,16
		lwbrx      r18,r5,r3
		li         r5,20
		lwbrx      r13,r5,r3
		vspltisw   v31,0x3
		li         r5,80
		lvx        v30,r5,r1
		addi       r6,r1,16
		addi       r7,r1,32
		addi       r8,r1,48
		li         r10,96
		li         r11,160
		li         r12,224
		clrlwi     r0,r18,30
		add        r4,r4,r0
		clrrwi     r18,r18,2
		stw        r13,48(r1)
		stw        r18,32(r1)
		subi       r19,r4,1
		ori        r19,r19,0x3
		not        r0,r18
		cmplw      r0,r19
		bge        .+8
		mr         r19,r0
		srwi       r19,r19,2
		addi       r19,r19,1
		mtctr      r19
		slwi       r19,r19,2
		subf       r4,r19,r4
		lis        r19,-18463
		lis        r17,-25033
		addi       r19,r19,20835
		addi       r17,r17,31161
		lwbrx      r13,0,r8
		rotlwi     r28,r19,3
		add        r13,r13,r28
		rotlw      r13,r13,r28
		add        r19,r19,r17
		add        r0,r19,r28
		add        r0,r0,r13
		rotlwi     r29,r0,3
		add        r14,r13,r29
		add        r19,r19,r17
		add        r15,r19,r29
		stw        r19,128(r1)
		stw        r17,132(r1)
		stw        r13,136(r1)
		stw        r29,140(r1)
		stw        r28,64(r1)
		stw        r29,68(r1)
		li         r5,64
		lvx        v29,r5,r1
		lwbrx      r24,0,r7
		stw        r24,112(r1)
		addis      r25,r24,256
		stw        r25,116(r1)
		addis      r26,r25,256
		stw        r26,120(r1)
		addis      r27,r26,256
		stw        r27,124(r1)
		lvx        v25,r10,r7
		vspltw     v28,v25,0
		vspltw     v0,v25,1
		vspltw     v26,v25,2
		vspltw     v1,v25,3
		lvx        v27,r10,r6
		vadduwm    v25,v1,v26
		vadduwm    v27,v27,v25
		vrlw       v27,v27,v25
		vadduwm    v2,v28,v1
		vadduwm    v2,v2,v27
		vrlw       v2,v2,v31
		vadduwm    v25,v2,v27
		vadduwm    v26,v26,v25
		vrlw       v26,v26,v25
		vadduwm    v28,v28,v0
		vadduwm    v3,v28,v2
		vadduwm    v3,v3,v26
		vrlw       v3,v3,v31
		vadduwm    v25,v3,v26
		vadduwm    v27,v27,v25
		vrlw       v27,v27,v25
		vadduwm    v28,v28,v0
		vadduwm    v4,v28,v3
		vadduwm    v4,v4,v27
		vrlw       v4,v4,v31
		vadduwm    v25,v4,v27
		vadduwm    v26,v26,v25
		vrlw       v26,v26,v25
		vadduwm    v28,v28,v0
		vadduwm    v5,v28,v4
		vadduwm    v5,v5,v26
		vrlw       v5,v5,v31
		vadduwm    v25,v5,v26
		vadduwm    v27,v27,v25
		vrlw       v27,v27,v25
		vadduwm    v28,v28,v0
		vadduwm    v6,v28,v5
		vadduwm    v6,v6,v27
		vrlw       v6,v6,v31
		vadduwm    v25,v6,v27
		vadduwm    v26,v26,v25
		vrlw       v26,v26,v25
		vadduwm    v28,v28,v0
		vadduwm    v7,v28,v6
		vadduwm    v7,v7,v26
		vrlw       v7,v7,v31
		vadduwm    v25,v7,v26
		vadduwm    v27,v27,v25
		vrlw       v27,v27,v25
		vadduwm    v28,v28,v0
		vadduwm    v8,v28,v7
		vadduwm    v8,v8,v27
		vrlw       v8,v8,v31
		vadduwm    v25,v8,v27
		vadduwm    v26,v26,v25
		vrlw       v26,v26,v25
		vadduwm    v28,v28,v0
		vadduwm    v9,v28,v8
		vadduwm    v9,v9,v26
		vrlw       v9,v9,v31
		vadduwm    v25,v9,v26
		vadduwm    v27,v27,v25
		vrlw       v27,v27,v25
		vadduwm    v28,v28,v0
		vadduwm    v10,v28,v9
		vadduwm    v10,v10,v27
		vrlw       v10,v10,v31
		vadduwm    v25,v10,v27
		vadduwm    v26,v26,v25
		vrlw       v26,v26,v25
		vadduwm    v28,v28,v0
		vadduwm    v11,v28,v10
		vadduwm    v11,v11,v26
		vrlw       v11,v11,v31
		vadduwm    v25,v11,v26
		vadduwm    v27,v27,v25
		vrlw       v27,v27,v25
		vadduwm    v28,v28,v0
		vadduwm    v12,v28,v11
		vadduwm    v12,v12,v27
		vrlw       v12,v12,v31
		vadduwm    v25,v12,v27
		vadduwm    v26,v26,v25
		vrlw       v26,v26,v25
		vadduwm    v28,v28,v0
		vadduwm    v13,v28,v12
		vadduwm    v13,v13,v26
		vrlw       v13,v13,v31
		vadduwm    v25,v13,v26
		vadduwm    v27,v27,v25
		vrlw       v27,v27,v25
		vadduwm    v28,v28,v0
		vadduwm    v14,v28,v13
		vadduwm    v14,v14,v27
		vrlw       v14,v14,v31
		vadduwm    v25,v14,v27
		vadduwm    v26,v26,v25
		vrlw       v26,v26,v25
		vadduwm    v28,v28,v0
		vadduwm    v15,v28,v14
		vadduwm    v15,v15,v26
		vrlw       v15,v15,v31
		vadduwm    v25,v15,v26
		vadduwm    v27,v27,v25
		vrlw       v27,v27,v25
		vadduwm    v28,v28,v0
		vadduwm    v16,v28,v15
		vadduwm    v16,v16,v27
		vrlw       v16,v16,v31
		vadduwm    v25,v16,v27
		vadduwm    v26,v26,v25
		vrlw       v26,v26,v25
		vadduwm    v28,v28,v0
		vadduwm    v17,v28,v16
		vadduwm    v17,v17,v26
		vrlw       v17,v17,v31
		vadduwm    v25,v17,v26
		vadduwm    v27,v27,v25
		vrlw       v27,v27,v25
		vadduwm    v28,v28,v0
		vadduwm    v18,v28,v17
		vadduwm    v18,v18,v27
		vrlw       v18,v18,v31
		vadduwm    v25,v18,v27
		vadduwm    v26,v26,v25
		vrlw       v26,v26,v25
		vadduwm    v28,v28,v0
		vadduwm    v19,v28,v18
		vadduwm    v19,v19,v26
		vrlw       v19,v19,v31
		vadduwm    v25,v19,v26
		vadduwm    v27,v27,v25
		vrlw       v27,v27,v25
		vadduwm    v28,v28,v0
		vadduwm    v20,v28,v19
		vadduwm    v20,v20,v27
		vrlw       v20,v20,v31
		stvx       v20,r11,r7
		vadduwm    v25,v20,v27
		vadduwm    v26,v26,v25
		vrlw       v26,v26,v25
		vadduwm    v28,v28,v0
		vadduwm    v21,v28,v20
		vadduwm    v21,v21,v26
		vrlw       v21,v21,v31
		stvx       v21,r11,r8
		vadduwm    v25,v21,v26
		vadduwm    v27,v27,v25
		vrlw       v27,v27,v25
		vadduwm    v28,v28,v0
		vadduwm    v22,v28,v21
		vadduwm    v22,v22,v27
		vrlw       v22,v22,v31
		stvx       v22,r12,r1
		vadduwm    v25,v22,v27
		vadduwm    v26,v26,v25
		vrlw       v26,v26,v25
		vadduwm    v28,v28,v0
		vadduwm    v23,v28,v22
		vadduwm    v23,v23,v26
		vrlw       v23,v23,v31
		stvx       v23,r12,r6
		vadduwm    v25,v23,v26
		vadduwm    v27,v27,v25
		vrlw       v27,v27,v25
		vadduwm    v28,v28,v0
		vadduwm    v24,v28,v23
		vadduwm    v24,v24,v27
		vrlw       v24,v24,v31
		stvx       v24,r12,r7
		vadduwm    v25,v24,v27
		vadduwm    v26,v26,v25
		vrlw       v20,v26,v25
		vadduwm    v28,v28,v0
		vadduwm    v28,v28,v24
		vadduwm    v28,v28,v20
		vrlw       v28,v28,v31
		vadduwm    v25,v28,v20
		vadduwm    v27,v27,v25
		vrlw       v21,v27,v25
		vspltw     v22,v29,0x0
		addi       r18,r18,4
		stw        r18,32(r1)
		lwbrx      r24,0,r7
		add        r16,r19,r17
		add        r24,r24,r14
		addis      r25,r24,256
		addis      r26,r24,512
		addis      r27,r24,768
		rotlw      r24,r24,r14
		rotlw      r25,r25,r14
		rotlw      r26,r26,r14
		rotlw      r27,r27,r14
		add        r28,r15,r24
		rotlwi     r28,r28,3
		add        r29,r15,r25
		add        r0,r28,r24
		add        r20,r13,r0
		rotlwi     r29,r29,3
		rotlw      r20,r20,r0
		add        r0,r29,r25
		add        r30,r15,r26
		add        r21,r13,r0
		rotlwi     r30,r30,3
		vspltw     v1,v29,0x1
		vadduwm    v0,v22,v28
		rotlw      r21,r21,r0
		add        r0,r30,r26
		vadduwm    v0,v0,v21
		add        r31,r15,r27
		add        r22,r13,r0
		vrlw       v0,v0,v31
		rotlwi     r31,r31,3
		rotlw      r22,r22,r0
		vadduwm    v25,v0,v21
		stw        r28,96(r1)
		add        r0,r31,r27
		vadduwm    v26,v25,v20
		stw        r29,100(r1)
		add        r23,r13,r0
		vrlw       v26,v26,v25
		stw        r30,104(r1)
		rotlw      r23,r23,r0
		vadduwm    v1,v1,v0
		stw        r31,108(r1)
		add        r28,r16,r28
		vadduwm    v1,v1,v26
		add        r29,r16,r29
		add        r28,r28,r20
		vrlw       v1,v1,v31
		add        r29,r29,r21
		rotlwi     r28,r28,3
		vadduwm    v25,v1,v26
		rotlwi     r29,r29,3
		add        r0,r28,r20
		vadduwm    v27,v25,v21
		add        r30,r16,r30
		add        r24,r24,r0
		vrlw       v27,v27,v25
		add        r30,r30,r22
		rotlw      r24,r24,r0
		vadduwm    v2,v2,v1
		add        r0,r29,r21
		rotlwi     r30,r30,3
		vadduwm    v2,v2,v27
		add        r25,r25,r0
		add        r31,r16,r31
		vrlw       v2,v2,v31
		rotlw      r25,r25,r0
		add        r0,r30,r22
		vadduwm    v25,v2,v27
		add        r31,r31,r23
		add        r26,r26,r0
		vadduwm    v26,v25,v26
		rotlwi     r31,r31,3
		rotlw      r26,r26,r0
		vrlw       v26,v26,v25
		stw        r28,112(r1)
		add        r0,r31,r23
		vadduwm    v3,v3,v2
		stw        r29,116(r1)
		add        r27,r27,r0
		vadduwm    v3,v3,v26
		stw        r30,120(r1)
		add        r19,r16,r17
		vrlw       v3,v3,v31
		stw        r31,124(r1)
		rotlw      r27,r27,r0
		vadduwm    v25,v3,v26
		add        r28,r19,r28
		add        r29,r19,r29
		vadduwm    v27,v25,v27
		add        r28,r28,r24
		add        r29,r29,r25
		vrlw       v27,v27,v25
		rotlwi     r28,r28,3
		rotlwi     r29,r29,3
		vadduwm    v4,v4,v3
		add        r0,r28,r24
		add        r30,r19,r30
		vadduwm    v4,v4,v27
		add        r20,r20,r0
		add        r30,r30,r26
		vrlw       v4,v4,v31
		rotlw      r20,r20,r0
		add        r0,r29,r25
		vadduwm    v25,v4,v27
		rotlwi     r30,r30,3
		add        r21,r21,r0
		vadduwm    v26,v25,v26
		add        r31,r19,r31
		rotlw      r21,r21,r0
		vrlw       v26,v26,v25
		add        r0,r30,r26
		add        r31,r31,r27
		vadduwm    v5,v5,v4
		add        r22,r22,r0
		rotlwi     r31,r31,3
		vadduwm    v5,v5,v26
		add        r19,r19,r17
		rotlw      r22,r22,r0
		vrlw       v5,v5,v31
		stw        r28,128(r1)
		add        r0,r31,r27
		vadduwm    v25,v5,v26
		stw        r29,132(r1)
		add        r23,r23,r0
		vadduwm    v27,v25,v27
		stw        r30,136(r1)
		rotlw      r23,r23,r0
		vrlw       v27,v27,v25
		stw        r31,140(r1)
		add        r28,r19,r28
		vadduwm    v6,v6,v5
		add        r29,r19,r29
		add        r28,r28,r20
		vadduwm    v6,v6,v27
		add        r29,r29,r21
		rotlwi     r28,r28,3
		vrlw       v6,v6,v31
		rotlwi     r29,r29,3
		add        r0,r28,r20
		vadduwm    v25,v6,v27
		add        r30,r19,r30
		add        r24,r24,r0
		vadduwm    v26,v25,v26
		add        r30,r30,r22
		rotlw      r24,r24,r0
		vrlw       v26,v26,v25
		add        r0,r29,r21
		rotlwi     r30,r30,3
		vadduwm    v7,v7,v6
		add        r25,r25,r0
		add        r31,r19,r31
		vadduwm    v7,v7,v26
		rotlw      r25,r25,r0
		add        r0,r30,r22
		vrlw       v7,v7,v31
		add        r31,r31,r23
		add        r26,r26,r0
		vadduwm    v25,v7,v26
		rotlwi     r31,r31,3
		rotlw      r26,r26,r0
		vadduwm    v27,v25,v27
		stw        r28,144(r1)
		add        r0,r31,r23
		vrlw       v27,v27,v25
		stw        r29,148(r1)
		add        r27,r27,r0
		vadduwm    v8,v8,v7
		stw        r30,152(r1)
		add        r19,r19,r17
		vadduwm    v8,v8,v27
		stw        r31,156(r1)
		rotlw      r27,r27,r0
		vrlw       v8,v8,v31
		add        r28,r19,r28
		add        r29,r19,r29
		vadduwm    v25,v8,v27
		add        r28,r28,r24
		add        r29,r29,r25
		vadduwm    v26,v25,v26
		rotlwi     r28,r28,3
		rotlwi     r29,r29,3
		vrlw       v26,v26,v25
		add        r0,r28,r24
		add        r30,r19,r30
		vadduwm    v9,v9,v8
		add        r20,r20,r0
		add        r30,r30,r26
		vadduwm    v9,v9,v26
		rotlw      r20,r20,r0
		add        r0,r29,r25
		vrlw       v9,v9,v31
		rotlwi     r30,r30,3
		add        r21,r21,r0
		vadduwm    v25,v9,v26
		add        r31,r19,r31
		rotlw      r21,r21,r0
		vadduwm    v27,v25,v27
		add        r0,r30,r26
		add        r31,r31,r27
		vrlw       v27,v27,v25
		add        r22,r22,r0
		rotlwi     r31,r31,3
		vadduwm    v10,v10,v9
		add        r19,r19,r17
		rotlw      r22,r22,r0
		vadduwm    v10,v10,v27
		stw        r28,160(r1)
		add        r0,r31,r27
		vrlw       v10,v10,v31
		stw        r29,164(r1)
		add        r23,r23,r0
		vadduwm    v25,v10,v27
		stw        r30,168(r1)
		rotlw      r23,r23,r0
		vadduwm    v26,v25,v26
		stw        r31,172(r1)
		add        r28,r19,r28
		vrlw       v26,v26,v25
		add        r29,r19,r29
		add        r28,r28,r20
		vadduwm    v11,v11,v10
		add        r29,r29,r21
		rotlwi     r28,r28,3
		vadduwm    v11,v11,v26
		rotlwi     r29,r29,3
		add        r0,r28,r20
		vrlw       v11,v11,v31
		add        r30,r19,r30
		add        r24,r24,r0
		vadduwm    v25,v11,v26
		add        r30,r30,r22
		rotlw      r24,r24,r0
		vadduwm    v27,v25,v27
		add        r0,r29,r21
		rotlwi     r30,r30,3
		vrlw       v27,v27,v25
		add        r25,r25,r0
		add        r31,r19,r31
		vadduwm    v12,v12,v11
		rotlw      r25,r25,r0
		add        r0,r30,r22
		vadduwm    v12,v12,v27
		add        r31,r31,r23
		add        r26,r26,r0
		vrlw       v12,v12,v31
		rotlwi     r31,r31,3
		rotlw      r26,r26,r0
		vadduwm    v25,v12,v27
		stw        r28,176(r1)
		add        r0,r31,r23
		vadduwm    v26,v25,v26
		stw        r29,180(r1)
		add        r27,r27,r0
		vrlw       v26,v26,v25
		stw        r30,184(r1)
		add        r19,r19,r17
		vadduwm    v13,v13,v12
		stw        r31,188(r1)
		rotlw      r27,r27,r0
		vadduwm    v13,v13,v26
		lvx        v20,r11,r7
		add        r28,r19,r28
		vrlw       v13,v13,v31
		add        r29,r19,r29
		add        r28,r28,r24
		vadduwm    v25,v13,v26
		add        r29,r29,r25
		rotlwi     r28,r28,3
		vadduwm    v27,v25,v27
		rotlwi     r29,r29,3
		add        r0,r28,r24
		vrlw       v27,v27,v25
		add        r30,r19,r30
		add        r20,r20,r0
		vadduwm    v14,v14,v13
		add        r30,r30,r26
		rotlw      r20,r20,r0
		vadduwm    v14,v14,v27
		add        r0,r29,r25
		rotlwi     r30,r30,3
		vrlw       v14,v14,v31
		add        r21,r21,r0
		add        r31,r19,r31
		vadduwm    v25,v14,v27
		rotlw      r21,r21,r0
		add        r0,r30,r26
		vadduwm    v26,v25,v26
		add        r31,r31,r27
		add        r22,r22,r0
		vrlw       v26,v26,v25
		rotlwi     r31,r31,3
		rotlw      r22,r22,r0
		vadduwm    v15,v15,v14
		stw        r28,192(r1)
		add        r0,r31,r27
		vadduwm    v15,v15,v26
		stw        r29,196(r1)
		add        r23,r23,r0
		vrlw       v15,v15,v31
		stw        r30,200(r1)
		add        r19,r19,r17
		vadduwm    v25,v15,v26
		stw        r31,204(r1)
		rotlw      r23,r23,r0
		vadduwm    v27,v25,v27
		lvx        v21,r11,r8
		add        r28,r19,r28
		vrlw       v27,v27,v25
		add        r29,r19,r29
		add        r28,r28,r20
		vadduwm    v16,v16,v15
		add        r29,r29,r21
		rotlwi     r28,r28,3
		vadduwm    v16,v16,v27
		rotlwi     r29,r29,3
		add        r0,r28,r20
		vrlw       v16,v16,v31
		add        r30,r19,r30
		add        r24,r24,r0
		vadduwm    v25,v16,v27
		add        r30,r30,r22
		rotlw      r24,r24,r0
		vadduwm    v26,v25,v26
		add        r0,r29,r21
		rotlwi     r30,r30,3
		vrlw       v26,v26,v25
		add        r25,r25,r0
		add        r31,r19,r31
		vadduwm    v17,v17,v16
		rotlw      r25,r25,r0
		add        r0,r30,r22
		vadduwm    v17,v17,v26
		add        r31,r31,r23
		add        r26,r26,r0
		vrlw       v17,v17,v31
		rotlwi     r31,r31,3
		rotlw      r26,r26,r0
		vadduwm    v25,v17,v26
		stw        r28,208(r1)
		add        r0,r31,r23
		vadduwm    v27,v25,v27
		stw        r29,212(r1)
		add        r27,r27,r0
		vrlw       v27,v27,v25
		stw        r30,216(r1)
		add        r19,r19,r17
		vadduwm    v18,v18,v17
		stw        r31,220(r1)
		rotlw      r27,r27,r0
		vadduwm    v18,v18,v27
		lvx        v22,r12,r1
		add        r28,r19,r28
		vrlw       v18,v18,v31
		add        r29,r19,r29
		add        r28,r28,r24
		vadduwm    v25,v18,v27
		add        r29,r29,r25
		rotlwi     r28,r28,3
		vadduwm    v26,v25,v26
		rotlwi     r29,r29,3
		add        r0,r28,r24
		vrlw       v26,v26,v25
		add        r30,r19,r30
		add        r20,r20,r0
		vadduwm    v19,v19,v18
		add        r30,r30,r26
		rotlw      r20,r20,r0
		vadduwm    v19,v19,v26
		add        r0,r29,r25
		rotlwi     r30,r30,3
		vrlw       v19,v19,v31
		add        r21,r21,r0
		add        r31,r19,r31
		vadduwm    v25,v19,v26
		rotlw      r21,r21,r0
		add        r0,r30,r26
		vadduwm    v27,v25,v27
		add        r31,r31,r27
		add        r22,r22,r0
		vrlw       v27,v27,v25
		rotlwi     r31,r31,3
		rotlw      r22,r22,r0
		vadduwm    v20,v20,v19
		stw        r28,224(r1)
		add        r0,r31,r27
		vadduwm    v20,v20,v27
		stw        r29,228(r1)
		add        r23,r23,r0
		vrlw       v20,v20,v31
		stw        r30,232(r1)
		add        r19,r19,r17
		vadduwm    v25,v20,v27
		stw        r31,236(r1)
		rotlw      r23,r23,r0
		vadduwm    v26,v25,v26
		lvx        v23,r12,r6
		add        r28,r19,r28
		vrlw       v26,v26,v25
		lvx        v24,r12,r7
		add        r29,r19,r29
		vadduwm    v21,v21,v20
		add        r28,r28,r20
		add        r29,r29,r21
		vadduwm    v21,v21,v26
		rotlwi     r28,r28,3
		rotlwi     r29,r29,3
		vrlw       v21,v21,v31
		add        r0,r28,r20
		add        r30,r19,r30
		vadduwm    v25,v21,v26
		add        r24,r24,r0
		add        r30,r30,r22
		vadduwm    v27,v25,v27
		rotlw      r24,r24,r0
		add        r0,r29,r21
		vrlw       v27,v27,v25
		rotlwi     r30,r30,3
		add        r25,r25,r0
		vadduwm    v22,v22,v21
		add        r31,r19,r31
		rotlw      r25,r25,r0
		vadduwm    v22,v22,v27
		add        r0,r30,r22
		add        r31,r31,r23
		vrlw       v22,v22,v31
		add        r26,r26,r0
		rotlwi     r31,r31,3
		vadduwm    v25,v22,v27
		add        r19,r19,r17
		rotlw      r26,r26,r0
		vadduwm    v26,v25,v26
		stw        r28,240(r1)
		add        r0,r31,r23
		vrlw       v26,v26,v25
		stw        r29,244(r1)
		add        r27,r27,r0
		vadduwm    v23,v23,v22
		stw        r30,248(r1)
		rotlw      r27,r27,r0
		vadduwm    v23,v23,v26
		stw        r31,252(r1)
		add        r28,r19,r28
		vrlw       v23,v23,v31
		add        r29,r19,r29
		add        r28,r28,r24
		vadduwm    v25,v23,v26
		add        r29,r29,r25
		rotlwi     r28,r28,3
		vadduwm    v27,v25,v27
		rotlwi     r29,r29,3
		add        r0,r28,r24
		vrlw       v27,v27,v25
		add        r30,r19,r30
		add        r20,r20,r0
		vadduwm    v24,v24,v23
		add        r30,r30,r26
		rotlw      r20,r20,r0
		vadduwm    v24,v24,v27
		add        r0,r29,r25
		rotlwi     r30,r30,3
		vrlw       v24,v24,v31
		add        r21,r21,r0
		add        r31,r19,r31
		vadduwm    v25,v24,v27
		rotlw      r21,r21,r0
		add        r0,r30,r26
		vadduwm    v26,v25,v26
		add        r31,r31,r27
		add        r22,r22,r0
		vrlw       v26,v26,v25
		rotlwi     r31,r31,3
		rotlw      r22,r22,r0
		vadduwm    v25,v28,v24
		stw        r28,256(r1)
		add        r0,r31,r27
		vadduwm    v25,v25,v26
		stw        r29,260(r1)
		add        r23,r23,r0
		vrlw       v25,v25,v31
		stw        r30,264(r1)
		add        r19,r19,r17
		vadduwm    v28,v25,v26
		stw        r31,268(r1)
		rotlw      r23,r23,r0
		vadduwm    v27,v28,v27
		add        r28,r19,r28
		add        r29,r19,r29
		vrlw       v27,v27,v28
		add        r28,r28,r20
		add        r29,r29,r21
		vadduwm    v0,v0,v25
		rotlwi     r28,r28,3
		rotlwi     r29,r29,3
		vadduwm    v0,v0,v27
		add        r0,r28,r20
		add        r30,r19,r30
		vrlw       v0,v0,v31
		add        r24,r24,r0
		add        r30,r30,r22
		vadduwm    v28,v0,v27
		rotlw      r24,r24,r0
		add        r0,r29,r21
		vadduwm    v26,v28,v26
		rotlwi     r30,r30,3
		add        r25,r25,r0
		vrlw       v26,v26,v28
		vspltw     v28,v30,0x0
		add        r31,r19,r31
		vadduwm    v1,v1,v0
		rotlw      r25,r25,r0
		add        r0,r30,r22
		vadduwm    v1,v1,v26
		add        r31,r31,r23
		add        r26,r26,r0
		vrlw       v1,v1,v31
		rotlwi     r31,r31,3
		add        r19,r19,r17
		vadduwm    v0,v28,v0
		stw        r28,272(r1)
		rotlw      r26,r26,r0
		vadduwm    v28,v1,v26
		stw        r29,276(r1)
		add        r0,r31,r23
		vadduwm    v27,v28,v27
		stw        r30,280(r1)
		add        r27,r27,r0
		vrlw       v27,v27,v28
		stw        r31,284(r1)
		rotlw      r27,r27,r0
		vadduwm    v2,v2,v1
		vspltw     v28,v30,0x1
		add        r28,r19,r28
		vadduwm    v2,v2,v27
		add        r29,r19,r29
		add        r28,r28,r24
		vrlw       v2,v2,v31
		add        r29,r29,r25
		rotlwi     r28,r28,3
		vadduwm    v1,v28,v1
		rotlwi     r29,r29,3
		add        r0,r28,r24
		vadduwm    v28,v2,v27
		add        r30,r19,r30
		add        r20,r20,r0
		vadduwm    v26,v28,v26
		add        r30,r30,r26
		rotlw      r20,r20,r0
		vrlw       v26,v26,v28
		add        r0,r29,r25
		rotlwi     r30,r30,3
		vxor       v0,v0,v1
		add        r21,r21,r0
		add        r31,r19,r31
		vrlw       v0,v0,v1
		rotlw      r21,r21,r0
		add        r0,r30,r26
		vadduwm    v0,v0,v2
		add        r31,r31,r27
		add        r22,r22,r0
		vadduwm    v3,v3,v2
		rotlwi     r31,r31,3
		add        r19,r19,r17
		vadduwm    v3,v3,v26
		lvx        v2,r10,r1
		rotlw      r22,r22,r0
		vrlw       v3,v3,v31
		stw        r28,96(r1)
		add        r0,r31,r27
		vadduwm    v28,v3,v26
		stw        r29,100(r1)
		add        r23,r23,r0
		vadduwm    v27,v28,v27
		stw        r30,104(r1)
		rotlw      r23,r23,r0
		vrlw       v27,v27,v28
		stw        r31,108(r1)
		add        r28,r19,r28
		vxor       v1,v1,v0
		add        r29,r19,r29
		add        r28,r28,r20
		vrlw       v1,v1,v0
		add        r29,r29,r21
		rotlwi     r28,r28,3
		vadduwm    v1,v1,v3
		rotlwi     r29,r29,3
		add        r0,r28,r20
		vadduwm    v4,v4,v3
		add        r30,r19,r30
		add        r24,r24,r0
		vadduwm    v4,v4,v27
		add        r30,r30,r22
		rotlw      r24,r24,r0
		vrlw       v4,v4,v31
		add        r0,r29,r21
		rotlwi     r30,r30,3
		vadduwm    v28,v4,v27
		add        r25,r25,r0
		add        r31,r19,r31
		vadduwm    v26,v28,v26
		rotlw      r25,r25,r0
		add        r0,r30,r22
		vrlw       v26,v26,v28
		add        r31,r31,r23
		add        r26,r26,r0
		vxor       v0,v0,v1
		lvx        v3,r10,r6
		rotlwi     r31,r31,3
		vrlw       v0,v0,v1
		stw        r28,112(r1)
		rotlw      r26,r26,r0
		vadduwm    v0,v0,v4
		stw        r29,116(r1)
		add        r0,r31,r23
		vadduwm    v5,v5,v4
		stw        r30,120(r1)
		add        r27,r27,r0
		vadduwm    v5,v5,v26
		stw        r31,124(r1)
		add        r19,r19,r17
		vrlw       v5,v5,v31
		lvx        v4,r10,r7
		rotlw      r27,r27,r0
		vadduwm    v28,v5,v26
		add        r28,r19,r28
		add        r29,r19,r29
		vadduwm    v27,v28,v27
		add        r28,r28,r24
		add        r29,r29,r25
		vrlw       v27,v27,v28
		rotlwi     r28,r28,3
		rotlwi     r29,r29,3
		vxor       v1,v1,v0
		add        r0,r28,r24
		add        r30,r19,r30
		vrlw       v1,v1,v0
		add        r20,r20,r0
		add        r30,r30,r26
		vadduwm    v1,v1,v5
		rotlw      r20,r20,r0
		add        r0,r29,r25
		vadduwm    v6,v6,v5
		rotlwi     r30,r30,3
		add        r21,r21,r0
		vadduwm    v6,v6,v27
		add        r31,r19,r31
		rotlw      r21,r21,r0
		vrlw       v6,v6,v31
		add        r0,r30,r26
		add        r31,r31,r27
		vadduwm    v28,v6,v27
		add        r22,r22,r0
		rotlwi     r31,r31,3
		vadduwm    v26,v28,v26
		lvx        v5,r10,r8
		add        r19,r19,r17
		vrlw       v26,v26,v28
		stw        r28,128(r1)
		rotlw      r22,r22,r0
		vxor       v0,v0,v1
		stw        r29,132(r1)
		add        r0,r31,r27
		vrlw       v0,v0,v1
		stw        r30,136(r1)
		add        r23,r23,r0
		vadduwm    v0,v0,v6
		stw        r31,140(r1)
		rotlw      r23,r23,r0
		vadduwm    v7,v7,v6
		lvx        v6,r11,r1
		add        r28,r19,r28
		vadduwm    v7,v7,v26
		add        r29,r19,r29
		add        r28,r28,r20
		vrlw       v7,v7,v31
		add        r29,r29,r21
		rotlwi     r28,r28,3
		vadduwm    v28,v7,v26
		rotlwi     r29,r29,3
		add        r0,r28,r20
		vadduwm    v27,v28,v27
		add        r30,r19,r30
		add        r24,r24,r0
		vrlw       v27,v27,v28
		add        r30,r30,r22
		rotlw      r24,r24,r0
		vxor       v1,v1,v0
		add        r0,r29,r21
		rotlwi     r30,r30,3
		vrlw       v1,v1,v0
		add        r25,r25,r0
		add        r31,r19,r31
		vadduwm    v1,v1,v7
		rotlw      r25,r25,r0
		add        r0,r30,r22
		vadduwm    v8,v8,v7
		add        r31,r31,r23
		add        r26,r26,r0
		vadduwm    v8,v8,v27
		lvx        v7,r11,r6
		rotlwi     r31,r31,3
		vrlw       v8,v8,v31
		stw        r28,144(r1)
		rotlw      r26,r26,r0
		vadduwm    v28,v8,v27
		stw        r29,148(r1)
		add        r0,r31,r23
		vadduwm    v26,v28,v26
		stw        r30,152(r1)
		add        r27,r27,r0
		vrlw       v26,v26,v28
		stw        r31,156(r1)
		add        r19,r19,r17
		vxor       v0,v0,v1
		rotlw      r27,r27,r0
		add        r28,r19,r28
		vrlw       v0,v0,v1
		add        r29,r19,r29
		add        r28,r28,r24
		vadduwm    v0,v0,v8
		add        r29,r29,r25
		rotlwi     r28,r28,3
		vadduwm    v9,v9,v8
		rotlwi     r29,r29,3
		add        r0,r28,r24
		vadduwm    v9,v9,v26
		add        r30,r19,r30
		add        r20,r20,r0
		vrlw       v9,v9,v31
		add        r30,r30,r26
		rotlw      r20,r20,r0
		vadduwm    v28,v9,v26
		add        r0,r29,r25
		rotlwi     r30,r30,3
		vadduwm    v27,v28,v27
		add        r21,r21,r0
		add        r31,r19,r31
		vrlw       v27,v27,v28
		rotlw      r21,r21,r0
		add        r0,r30,r26
		vxor       v1,v1,v0
		add        r31,r31,r27
		add        r22,r22,r0
		vrlw       v1,v1,v0
		lvx        v8,r11,r7
		rotlwi     r31,r31,3
		vadduwm    v1,v1,v9
		stw        r28,160(r1)
		rotlw      r22,r22,r0
		vadduwm    v10,v10,v9
		stw        r29,164(r1)
		add        r0,r31,r27
		vadduwm    v10,v10,v27
		stw        r30,168(r1)
		add        r23,r23,r0
		vrlw       v10,v10,v31
		stw        r31,172(r1)
		add        r19,r19,r17
		vadduwm    v28,v10,v27
		lvx        v9,r11,r8
		rotlw      r23,r23,r0
		vadduwm    v26,v28,v26
		add        r28,r19,r28
		add        r29,r19,r29
		vrlw       v26,v26,v28
		add        r28,r28,r20
		add        r29,r29,r21
		vxor       v0,v0,v1
		rotlwi     r28,r28,3
		rotlwi     r29,r29,3
		vrlw       v0,v0,v1
		add        r0,r28,r20
		add        r30,r19,r30
		vadduwm    v0,v0,v10
		add        r24,r24,r0
		add        r30,r30,r22
		vadduwm    v11,v11,v10
		rotlw      r24,r24,r0
		add        r0,r29,r21
		vadduwm    v11,v11,v26
		rotlwi     r30,r30,3
		add        r25,r25,r0
		vrlw       v11,v11,v31
		add        r31,r19,r31
		rotlw      r25,r25,r0
		vadduwm    v28,v11,v26
		add        r0,r30,r22
		add        r31,r31,r23
		vadduwm    v27,v28,v27
		add        r26,r26,r0
		rotlwi     r31,r31,3
		vrlw       v27,v27,v28
		lvx        v10,r12,r1
		add        r19,r19,r17
		vxor       v1,v1,v0
		stw        r28,176(r1)
		rotlw      r26,r26,r0
		vrlw       v1,v1,v0
		stw        r29,180(r1)
		add        r0,r31,r23
		vadduwm    v1,v1,v11
		stw        r30,184(r1)
		add        r27,r27,r0
		vadduwm    v12,v12,v11
		stw        r31,188(r1)
		rotlw      r27,r27,r0
		vadduwm    v12,v12,v27
		lvx        v11,r12,r6
		add        r28,r19,r28
		vrlw       v12,v12,v31
		add        r29,r19,r29
		add        r28,r28,r24
		vadduwm    v28,v12,v27
		add        r29,r29,r25
		rotlwi     r28,r28,3
		vadduwm    v26,v28,v26
		rotlwi     r29,r29,3
		add        r0,r28,r24
		vrlw       v26,v26,v28
		add        r30,r19,r30
		add        r20,r20,r0
		vxor       v0,v0,v1
		add        r30,r30,r26
		rotlw      r20,r20,r0
		vrlw       v0,v0,v1
		add        r0,r29,r25
		rotlwi     r30,r30,3
		vadduwm    v0,v0,v12
		add        r21,r21,r0
		add        r31,r19,r31
		vadduwm    v13,v13,v12
		rotlw      r21,r21,r0
		add        r0,r30,r26
		vadduwm    v13,v13,v26
		add        r31,r31,r27
		add        r22,r22,r0
		vrlw       v13,v13,v31
		lvx        v12,r12,r7
		rotlwi     r31,r31,3
		vadduwm    v28,v13,v26
		stw        r28,192(r1)
		rotlw      r22,r22,r0
		vadduwm    v27,v28,v27
		stw        r29,196(r1)
		add        r0,r31,r27
		vrlw       v27,v27,v28
		stw        r30,200(r1)
		add        r23,r23,r0
		vxor       v1,v1,v0
		stw        r31,204(r1)
		add        r19,r19,r17
		vrlw       v1,v1,v0
		rotlw      r23,r23,r0
		add        r28,r19,r28
		vadduwm    v1,v1,v13
		add        r29,r19,r29
		add        r28,r28,r20
		vadduwm    v14,v14,v13
		add        r29,r29,r21
		rotlwi     r28,r28,3
		vadduwm    v14,v14,v27
		rotlwi     r29,r29,3
		add        r0,r28,r20
		vrlw       v14,v14,v31
		add        r30,r19,r30
		add        r24,r24,r0
		vadduwm    v28,v14,v27
		add        r30,r30,r22
		rotlw      r24,r24,r0
		vadduwm    v26,v28,v26
		add        r0,r29,r21
		rotlwi     r30,r30,3
		vrlw       v26,v26,v28
		add        r25,r25,r0
		add        r31,r19,r31
		vxor       v0,v0,v1
		rotlw      r25,r25,r0
		add        r0,r30,r22
		vrlw       v0,v0,v1
		add        r31,r31,r23
		add        r26,r26,r0
		vadduwm    v0,v0,v14
		lvx        v13,r12,r8
		rotlwi     r31,r31,3
		vadduwm    v15,v15,v14
		lvx        v14,r10,r1
		rotlw      r26,r26,r0
		vadduwm    v15,v15,v26
		stw        r28,208(r1)
		add        r0,r31,r23
		vrlw       v15,v15,v31
		stw        r29,212(r1)
		add        r27,r27,r0
		vadduwm    v28,v15,v26
		stw        r30,216(r1)
		add        r19,r19,r17
		vadduwm    v27,v28,v27
		stw        r31,220(r1)
		rotlw      r27,r27,r0
		vrlw       v27,v27,v28
		add        r28,r19,r28
		add        r29,r19,r29
		vxor       v1,v1,v0
		add        r28,r28,r24
		add        r29,r29,r25
		vrlw       v1,v1,v0
		rotlwi     r28,r28,3
		rotlwi     r29,r29,3
		vadduwm    v1,v1,v15
		add        r0,r28,r24
		add        r30,r19,r30
		vadduwm    v16,v16,v15
		add        r20,r20,r0
		add        r30,r30,r26
		vadduwm    v16,v16,v27
		rotlw      r20,r20,r0
		add        r0,r29,r25
		vrlw       v16,v16,v31
		rotlwi     r30,r30,3
		add        r21,r21,r0
		vadduwm    v28,v16,v27
		add        r31,r19,r31
		rotlw      r21,r21,r0
		vadduwm    v26,v28,v26
		add        r0,r30,r26
		add        r31,r31,r27
		vrlw       v26,v26,v28
		add        r22,r22,r0
		rotlwi     r31,r31,3
		vxor       v0,v0,v1
		lvx        v15,r10,r6
		add        r19,r19,r17
		vrlw       v0,v0,v1
		stw        r28,224(r1)
		rotlw      r22,r22,r0
		vadduwm    v0,v0,v16
		stw        r29,228(r1)
		add        r0,r31,r27
		vadduwm    v17,v17,v16
		stw        r30,232(r1)
		add        r23,r23,r0
		vadduwm    v17,v17,v26
		stw        r31,236(r1)
		rotlw      r23,r23,r0
		vrlw       v17,v17,v31
		lvx        v16,r10,r7
		add        r28,r19,r28
		vadduwm    v28,v17,v26
		add        r29,r19,r29
		add        r28,r28,r20
		vadduwm    v27,v28,v27
		add        r29,r29,r21
		rotlwi     r28,r28,3
		vrlw       v27,v27,v28
		rotlwi     r29,r29,3
		add        r0,r28,r20
		vxor       v1,v1,v0
		add        r30,r19,r30
		add        r24,r24,r0
		vrlw       v1,v1,v0
		add        r30,r30,r22
		rotlw      r24,r24,r0
		vadduwm    v1,v1,v17
		add        r0,r29,r21
		rotlwi     r30,r30,3
		vadduwm    v18,v18,v17
		add        r25,r25,r0
		add        r31,r19,r31
		vadduwm    v18,v18,v27
		rotlw      r25,r25,r0
		add        r0,r30,r22
		vrlw       v18,v18,v31
		add        r31,r31,r23
		add        r26,r26,r0
		vadduwm    v28,v18,v27
		lvx        v17,r10,r8
		rotlwi     r31,r31,3
		vadduwm    v26,v28,v26
		stw        r28,240(r1)
		rotlw      r26,r26,r0
		vrlw       v26,v26,v28
		stw        r29,244(r1)
		add        r0,r31,r23
		vxor       v0,v0,v1
		stw        r30,248(r1)
		add        r27,r27,r0
		vrlw       v0,v0,v1
		stw        r31,252(r1)
		add        r19,r19,r17
		vadduwm    v0,v0,v18
		rotlw      r27,r27,r0
		add        r28,r19,r28
		vadduwm    v19,v19,v18
		addi       r18,r18,4
		add        r29,r19,r29
		vadduwm    v19,v19,v26
		add        r28,r28,r24
		add        r29,r29,r25
		vrlw       v19,v19,v31
		rotlwi     r28,r28,3
		rotlwi     r29,r29,3
		vadduwm    v28,v19,v26
		add        r0,r28,r24
		add        r30,r19,r30
		vadduwm    v27,v28,v27
		add        r20,r20,r0
		add        r30,r30,r26
		vrlw       v27,v27,v28
		rotlw      r20,r20,r0
		add        r0,r29,r25
		vxor       v1,v1,v0
		rotlwi     r30,r30,3
		add        r21,r21,r0
		vrlw       v1,v1,v0
		add        r31,r19,r31
		rotlw      r21,r21,r0
		vadduwm    v1,v1,v19
		lvx        v18,r11,r1
		add        r0,r30,r26
		vadduwm    v20,v20,v19
		lvx        v19,r11,r6
		add        r31,r31,r27
		vadduwm    v20,v20,v27
		stw        r18,32(r1)
		add        r22,r22,r0
		vrlw       v20,v20,v31
		stw        r28,256(r1)
		rotlwi     r31,r31,3
		vadduwm    v28,v20,v27
		stw        r29,260(r1)
		add        r19,r19,r17
		vadduwm    v26,v28,v26
		stw        r30,264(r1)
		rotlw      r22,r22,r0
		vrlw       v26,v26,v28
		stw        r31,268(r1)
		add        r0,r31,r27
		vxor       v0,v0,v1
		stw        r20,96(r1)
		add        r23,r23,r0
		vrlw       v0,v0,v1
		stw        r21,100(r1)
		rotlw      r23,r23,r0
		vadduwm    v0,v0,v20
		stw        r22,104(r1)
		add        r28,r19,r28
		vadduwm    v21,v21,v20
		stw        r23,108(r1)
		add        r29,r19,r29
		vadduwm    v21,v21,v26
		add        r28,r28,r20
		add        r29,r29,r21
		vrlw       v21,v21,v31
		rotlwi     r28,r28,3
		rotlwi     r29,r29,3
		vadduwm    v28,v21,v26
		add        r0,r28,r20
		add        r30,r19,r30
		vadduwm    v27,v28,v27
		add        r24,r24,r0
		add        r30,r30,r22
		vrlw       v27,v27,v28
		rotlw      r24,r24,r0
		add        r0,r29,r21
		vxor       v1,v1,v0
		rotlwi     r30,r30,3
		add        r25,r25,r0
		vrlw       v1,v1,v0
		add        r31,r19,r31
		rotlw      r25,r25,r0
		vadduwm    v1,v1,v21
		add        r0,r30,r22
		add        r31,r31,r23
		vadduwm    v22,v22,v21
		lvx        v20,r10,r1
		add        r26,r26,r0
		vadduwm    v22,v22,v27
		lwbrx      r20,0,r7
		rotlwi     r31,r31,3
		vrlw       v22,v22,v31
		stw        r28,272(r1)
		rotlw      r26,r26,r0
		vadduwm    v28,v22,v27
		stw        r29,276(r1)
		add        r0,r31,r23
		vadduwm    v26,v28,v26
		stw        r30,280(r1)
		add        r27,r27,r0
		vrlw       v26,v26,v28
		stw        r31,284(r1)
		rotlw      r27,r27,r0
		vxor       v0,v0,v1
		stw        r24,112(r1)
		add        r20,r20,r14
		vrlw       v0,v0,v1
		stw        r25,116(r1)
		addis      r21,r20,256
		vadduwm    v0,v0,v22
		stw        r26,120(r1)
		addis      r22,r20,512
		vadduwm    v23,v23,v22
		stw        r27,124(r1)
		addis      r23,r20,768
		vadduwm    v23,v23,v26
		rotlw      r24,r20,r14
		vspltw     v22,v29,0x0
		vrlw       v23,v23,v31
		add        r28,r15,r24
		rotlw      r25,r21,r14
		vadduwm    v28,v23,v26
		rotlwi     r28,r28,3
		rotlw      r26,r22,r14
		vadduwm    v27,v28,v27
		add        r0,r28,r24
		rotlw      r27,r23,r14
		vrlw       v27,v27,v28
		add        r20,r13,r0
		add        r29,r15,r25
		vxor       v1,v1,v0
		rotlw      r20,r20,r0
		rotlwi     r29,r29,3
		vrlw       v1,v1,v0
		add        r30,r15,r26
		add        r0,r29,r25
		vadduwm    v1,v1,v23
		add        r21,r13,r0
		vadduwm    v24,v24,v23
		lvx        v28,r12,r8
		vspltw     v23,v30,0x2
		vadduwm    v24,v24,v27
		lvx        v21,r10,r6
		rotlwi     r30,r30,3
		vrlw       v24,v24,v31
		vxor       v0,v0,v1
		vrlw       v0,v0,v1
		vadduwm    v0,v0,v24
		vcmpequw.  v23,v0,v23
		bdnzt      26,.-4460
		mfctr      r19
		beq        cr6,.+76
		vadduwm    v22,v24,v27
		vadduwm    v26,v22,v26
		vrlw       v26,v26,v22
		vadduwm    v25,v25,v24
		vadduwm    v25,v25,v26
		vrlw       v25,v25,v31
		vxor       v1,v1,v0
		vrlw       v1,v1,v0
		vadduwm    v1,v1,v25
		vspltw     v22,v30,0x3
		vcmpequw   v22,v1,v22
		vand       v23,v23,v22
		vspltisw   v22,-1
		vcmpequw.  v22,v22,v23
		bne        cr6,.+60
		vspltw     v22,v29,0x0
		cmplwi     r19,0x0
		bne        .-4540
		lwz        r13,48(r1)
		subi       r18,r18,5
		addic      r18,r18,1
		addze      r13,r13
		neg        r0,r4
		clrrwi.    r19,r0,2
		bne        .-5564
		subfc      r18,r0,r18
		addme      r13,r13
		li         r4,0
		b          .+44
		subi       r18,r18,4
		lwz        r13,48(r1)
		vspltisw   v1,0
		slwi       r19,r19,2
		add        r4,r4,r19
		subi       r18,r18,1
		addi       r4,r4,1
		vsldoi     v23,v1,v23,0xc
		vcmpequw.  v22,v23,v1
		bge        cr6,.-16
		vspltisw   v2,3
		vcmpequw   v2,v2,v31
		li         r5,64
		lvx        v3,r5,r1
		vcmpequw   v3,v3,v29
		li         r5,80
		lvx        v4,r5,r1
		vcmpequw   v4,v4,v30
		vand       v5,v2,v3
		vand       v5,v5,v4
		vspltisw   v2,-1
		vcmpequw.  v2,v2,v5
		li         r0,288
		lvx        v20,r1,r0
		li         r0,304
		lvx        v21,r1,r0
		li         r0,320
		lvx        v22,r1,r0
		li         r0,336
		lvx        v23,r1,r0
		li         r0,352
		lvx        v24,r1,r0
		li         r0,368
		lvx        v25,r1,r0
		li         r0,384
		lvx        v26,r1,r0
		li         r0,400
		lvx        v27,r1,r0
		li         r0,416
		lvx        v28,r1,r0
		li         r0,432
		lvx        v29,r1,r0
		li         r0,448
		lvx        v30,r1,r0
		li         r0,464
		lvx        v31,r1,r0
		lwz        r1,0(r1)
		lwz        r3,24(r1)
		li         r5,16
		stwbrx     r18,r5,r3
		li         r5,20
		stwbrx     r13,r5,r3
		lwz        r3,28(r1)
		subf       r3,r4,r3
		blt        cr6,.+8
		li         r3,-1
		mfspr      r0,256
		cmpwi      r0,-1	;cmpwi      r0,$ffff
		beq        .+8
		li         r3,-1
		lwz        r0,-80(r1)
		mtspr      256,r0
		lwz        r0,8(r1)
		mtlr       r0
		lmw        r13,-76(r1)
		blr