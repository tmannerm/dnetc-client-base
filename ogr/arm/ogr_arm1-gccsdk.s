; Copyright distributed.net 1997-2002 - All Rights Reserved
; For use in distributed.net projects only.
; Any other distribution or use of this source violates copyright.
;
; Author: Peter Teichmann <dnet@peter-teichmann.de>
; $Id: ogr_arm1-gccsdk.s,v 1.1.2.2 2004/06/02 19:26:12 teichp Exp $
;
; Stack:
; int *pnodes
; struct State *oState
; int depth
; struct Level *lev
; struct Level *lev2
; int nodes
; int nodeslimit
; int retval
; int limit
; u32 comp0
;
; Register:
; r0  oState
; r1  lev
; r2
; r3
; r4
; r5
; r6
; r7
; r8  lev->cnt2
; r9
; r10 limit
; r11 oState->maxdepthm1
; r12 nodes
; r14 depth

r0      RN      0
r1      RN      1
r2      RN      2
r3      RN      3
r4      RN      4
r5      RN      5
r6      RN      6
r7      RN      7
r8      RN      8
r9      RN      9
r10     RN      10
r11     RN      11
r12     RN      12
r13     RN      13
r14     RN      14
r15     RN      15
sp      RN      13
lr      RN      14
pc      RN      15

CORE_S_OK	EQU	0
CORE_S_CONTINUE	EQU	1
CORE_S_SUCCESS	EQU	2

	AREA	|C$$CODE|, CODE, READONLY
	ALIGN	32
OGR
	DCD	  0,   1,   3,   6,  11,  17,  25,  34,  44,  55
	DCD	 72,  85, 106, 127, 151, 177, 199, 216, 246, 283
	DCD	333, 356, 372, 425, 480, 492, 553, 585, 623
choose
	DCD	ogr_choose_dat+3
firstblank
	DCB	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	DCB	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	DCB	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	DCB	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	DCB	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	DCB	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	DCB	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	DCB	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	DCB	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	DCB	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	DCB	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	DCB	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	DCB	3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
	DCB	3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
	DCB	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DCB	5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 8, 9

	ALIGN	32
	EXPORT	ogr_cycle_arm1
ogr_cycle_arm1
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, r10, r11, r12, r14}
	sub	sp, sp, #10*4

	str	r1, [r13, #0*4]		; save pnodes
	ldr	r1, [r1]
	str	r1, [r13, #6*4] 	; store nodeslimit
	ldr	r2, [r0, #48*4]		; load oState->depth
	add	r14, r2, #1		; depth
	add	r1, r0, #55*4
	add	r1, r1, r14, lsl#6
	add	r1, r1, r14, lsl#3	; lev
	mov	r12, #0			; nodes
	mov	r3, #CORE_S_CONTINUE
	str	r3, [r13, #7*4]		; save retval
	ldr	r8, [r1, #16*4]		; lev->cnt2
	ldr	r11, [r0, #2*4]		; oState->maxdepthm1
	
loop_start
	ldr	r5, [r13, #6*4]		; nodeslimit
	ldr	r7, [r0, #5*4]		; oState->half_depth2
	ldr	r6, [r0, #4*4]		; oState->half_depth
	cmp	r12, r5			; if(nodes>=nodeslimit)
	bge	loop_break		;   break;
	cmp	r14, r7
	bgt	depth_gt_halfdepth2
	cmp	r14, r6
	bgt	depth_gt_halfdepth

	adr	r5, OGR
	ldr	r4, [r0, #0*4]		; oState->max
	sub	r3, r11, r14
	ldr	r5, [r5, r3, lsl#2]	; OGR[oState->maxdepthm1-depth]
	ldr	r3, [r0, #3*4]		; oState->half_length
	sub	r10, r4, r5		; limit=oState->max-...
	cmp	r10, r3			; 
	movgt	r10, r3			; limit=limit<oState->half_length ? ...

	b	increment_nodes

depth_gt_halfdepth
	ldr	r7, [r1, #5*4]		; lev->dist[0]
	sub	r5, r11, r14		; y=oState->maxdepthm1-depth
	mov	r7, r7, lsr#32-12	; x=lev->dist[0]>>ttmDISTBITS
	add	r5, r5, r7, lsl#3
	add	r5, r5, r7, lsl#2	; 12*y+x
	ldr	r7, choose
	ldr	r4, [r0, #0*4]		; oState->max
	ldrb	r5, [r7, r5]		; choose(x,y)
	add	r3, r0, #6*4
	sub	r10, r4, r5		; limit=oState->max-choose(x,y)
	ldr	r7, [r3, r6, lsl#2]	; oState->marks[halfdepth]
	sub	r4, r4, #1
	sub	r4, r4, r7		; oState->max-oState->marks[halfdepth]-1
	cmp	r10, r4
	movgt	r10, r4
	b	increment_nodes

depth_gt_halfdepth2
	ldr	r7, [r1, #5*4]		; lev->dist[0]
	sub	r5, r11, r14		; y=oState->maxdepthm1-depth
	mov	r7, r7, lsr#32-12	; x=lev->dist[0]>>ttmDISTBITS
	add	r5, r5, r7, lsl#3
	add	r5, r5, r7, lsl#2	; 12*y+x
	ldr	r7, choose
	ldr	r4, [r0, #0*4]		; oState->max
	ldrb	r5, [r7, r5]		; choose(x,y)
	sub	r10, r4, r5		; limit=oState->max-choose(x,y)

increment_nodes
	add	r12, r12, #1

stay
	ldr	r9, [r1, #10*4]		; comp0=lev->comp0
	mov	r7, #0
	cmp	r9, #0xfffffffe
	bcs	firstblank_31_32

	adr	r6, firstblank
	cmp	r9, #0xffff0000
	movcs	r9, r9, lsl#16
	addcs	r7, r7, #16
	cmp	r9, #0xff000000
	movcs	r9, r9, lsl#8
	ldrb	r9, [r6, r9, lsr#24]
	addcs	r7, r7, #8
	add	r7, r7, r9		; s=LOOKUP_FIRSTBLANK(comp0)

	add	r8, r8, r7
	str	r8, [r1, #16*4]
	cmp	r8, r10
	bgt	up			; if ((lev->cnt2+=s)>limit) goto up

	add	pc, pc, r7, lsl#7
	mov	r0, r0			; NOP

; COMP_LEFT_LIST_RIGHT macro, must be always 32 instructions=128 bytes
; because of the method to jump to them!

	MACRO
	COMP_LEFT_LIST_RIGHT $N
	ldr	r2, [r1, #40]
	ldr	r3, [r1, #44]
	ldr	r4, [r1, #48]
	ldr	r5, [r1, #52]
	ldr	r6, [r1, #56]

	mov	r2, r2, lsl #$N
	orr	r2, r2, r3, lsr #32-$N
	str	r2, [r1, #40]		; lev->comp[0]

	mov	r3, r3, lsl #$N
	orr	r3, r3, r4, lsr #32-$N
	str	r3, [r1, #44]		; lev->comp[1]

	mov	r4, r4, lsl #$N
	orr	r4, r4, r5, lsr #32-$N
	str	r4, [r1, #48]		; lev->comp[2]

	mov	r5, r5, lsl #$N
	orr	r5, r5, r6, lsr #32-$N
	str	r5, [r1, #52]		; lev->comp[3]

	mov	r6, r6, lsl #$N
	str	r6, [r1, #56]		; lev->comp[4]

	ldmia	r1, {r2-r6}
	mov	r6, r6, lsr #$N
	orr	r6, r6, r5, lsl #32-$N

	mov	r5, r5, lsr #$N
	orr	r5, r5, r4, lsl #32-$N

	mov	r4, r4, lsr #$N
	orr	r4, r4, r3, lsl #32-$N

	mov	r3, r3, lsr #$N
	orr	r3, r3, r2, lsl #32-$N

	mov	r2, r2, lsr #$N		; lev->list[0]
	stmia	r1, {r2-r6}

	b	firstblank_32_back
	mov	r0, r0			; NOP
	MEND

	%	128
	COMP_LEFT_LIST_RIGHT 1
	COMP_LEFT_LIST_RIGHT 2
	COMP_LEFT_LIST_RIGHT 3
	COMP_LEFT_LIST_RIGHT 4
	COMP_LEFT_LIST_RIGHT 5
	COMP_LEFT_LIST_RIGHT 6
	COMP_LEFT_LIST_RIGHT 7
	COMP_LEFT_LIST_RIGHT 8
	COMP_LEFT_LIST_RIGHT 9
	COMP_LEFT_LIST_RIGHT 10
	COMP_LEFT_LIST_RIGHT 11
	COMP_LEFT_LIST_RIGHT 12
	COMP_LEFT_LIST_RIGHT 13
	COMP_LEFT_LIST_RIGHT 14
	COMP_LEFT_LIST_RIGHT 15
	COMP_LEFT_LIST_RIGHT 16
	COMP_LEFT_LIST_RIGHT 17
	COMP_LEFT_LIST_RIGHT 18
	COMP_LEFT_LIST_RIGHT 19
	COMP_LEFT_LIST_RIGHT 20
	COMP_LEFT_LIST_RIGHT 21
	COMP_LEFT_LIST_RIGHT 22
	COMP_LEFT_LIST_RIGHT 23
	COMP_LEFT_LIST_RIGHT 24
	COMP_LEFT_LIST_RIGHT 25
	COMP_LEFT_LIST_RIGHT 26
	COMP_LEFT_LIST_RIGHT 27
	COMP_LEFT_LIST_RIGHT 28
	COMP_LEFT_LIST_RIGHT 29
	COMP_LEFT_LIST_RIGHT 30
	COMP_LEFT_LIST_RIGHT 31


firstblank_32_back
	cmp	r14, r11
	beq	new_ruler
	
	ldr	r9, [r1, #15*4]
	mov	r7, #1
	sub	r9, r8, r9		; bitindex=lev->cnt2-lev->cnt1

	; Start COPY_LIST_SET_BIT_COPY_DIST_COMP
	ldmia	r1, {r2, r3, r4, r5, r6}
	cmp	r9, #32
	bgt	bitoflist_notfirstword
	orr	r2, r2, r7, ror r9

bit_is_set	
	str	r2, [r1, #72+0*4]	; lev2->list[0]=a0
	str	r3, [r1, #72+1*4]	; lev2->list[1]=a1
	str	r4, [r1, #72+2*4]	; lev2->list[2]=a2
	str	r5, [r1, #72+3*4]	; lev2->list[3]=a3
	ldr	r7, [r1, #20+0*4]	; b=lev->dist[0]
	str	r6, [r1, #72+4*4]	; lev2->list[4]=a4
	orr	r2, r2, r7		; a0=b|a0
	ldr	r7, [r1, #20+1*4]	; b=lev->dist[1]
	str	r2, [r1, #92+0*4]	; lev2->dist[0]=a0
	
	orr	r3, r3, r7		; a1=b|a1
	ldr	r7, [r1, #20+2*4]	; b=lev->dist[2]
	str	r3, [r1, #92+1*4]	; lev2->dist[1]=a1
	
	orr	r4, r4, r7		; a2=b|a2
	ldr	r7, [r1, #20+3*4]	; b=lev->dist[3]
	str	r4, [r1, #92+2*4]	; lev2->dist[2]=a2
	
	orr	r5, r5, r7		; a3=b|a3
	ldr	r7, [r1, #20+4*4]	; b=lev->dist[4]
	str	r5, [r1, #92+3*4]	; lev2->dist[3]=a3
	
	orr	r6, r6, r7		; a4=b|a4
	ldr	r7, [r1, #40+0*4]	; b=lev->comp[0]
	str	r6, [r1, #92+4*4]	; lev2->dist[4]=a4
	
	orr	r2, r2, r7		; a0=b|a0
	ldr	r7, [r1, #40+1*4]	; b=lev->comp[1]
	str	r2, [r1, #112+0*4]	; lev2->comp[0]=a0
	
	orr	r3, r3, r7		; a1=b|a1
	ldr	r7, [r1, #40+2*4]	; b=lev->comp[2]
	str	r3, [r1, #112+1*4]	; lev2->comp[1]=a1
	
	orr	r4, r4, r7		; a2=b|a2
	ldr	r7, [r1, #40+3*4]	; b=lev->comp[3]
	str	r4, [r1, #112+2*4]	; lev2->comp[2]=a2
	
	orr	r5, r5, r7		; a3=b|a3
	ldr	r7, [r1, #40+4*4]	; b=lev->comp[4]
	str	r5, [r1, #112+3*4]	; lev2->comp[3]=a3
	
	orr	r6, r6, r7		; a4=b|a4
	str	r6, [r1, #112+4*4]	; lev2->comp[4]=a4
	; End COPY_LIST_SET_BIT_COPY_DIST_COMP

	add	r9, r0, #6*4		; oState->marks
	str	r8, [r9, r14, lsl#2]	; oState->marks[depth]=lev->cnt2
	str	r8, [r1, #72+15*4]	; lev2->cnt1=lev->cnt2
	str	r8, [r1, #72+16*4]	; lev2->cnt2=lev->cnt2
	str	r10, [r1, #17*4]	; lev->limit=limit
	str	r14, [r0, #48*4]	; oState->depth=depth
	add	r1, r1, #72		; lev++
	add	r14, r14, #1		; depth++

	b	loop_start		; continue

bitoflist_notfirstword
	cmp	r9, #64
	orrle	r3, r3, r7, ror r9
	ble	bit_is_set
	cmp	r9, #96
	orrle	r4, r4, r7, ror r9
	ble	bit_is_set
	cmp	r9, #128
	orrle	r5, r5, r7, ror r9
	ble	bit_is_set
	cmp	r9, #160
	orrle	r6, r6, r7, ror r9
	b	bit_is_set

firstblank_31_32
	add	r8, r8, #32
	str	r8, [r1, #16*4]
	cmp	r8, r10
	bgt	up			; if ((lev->cnt2+=32)>limit) goto up

	ldr	r5, [r1, #44]
	ldr	r6, [r1, #48]
	str	r5, [r1, #40]
	ldr	r5, [r1, #52]
	str	r6, [r1, #44]
	ldr	r6, [r1, #56]
	str	r5, [r1, #48]
	ldr	r5, [r1, #12]
	str	r6, [r1, #52]
	ldr	r6, [r1, #8]
	str	r5, [r1, #16]
	ldr	r5, [r1, #4]
	str	r6, [r1, #12]
	ldr	r6, [r1, #0]
	str	r5, [r1, #8]
	str	r6, [r1, #4]
	str	r7, [r1, #56]
	str	r7, [r1, #0]		; COMP_LEFT_LIST_RIGHT_32(lev)

	cmp	r9, #0xffffffff
	beq	stay			; if (comp0==0xffffffff) goto stay
	
	b	firstblank_32_back

up
	sub	r1, r1, #72		; lev--
	sub	r14, r14, #1		; depth--
	sub	r9, r14, #1
	ldr	r7, [r0, #47*4]		; oState->startdepth
	str	r9, [r0, #48*4]		; oState->depth=depth-1
	cmp	r14, r7
	ble	finished_block
	
	ldr	r10, [r1, #17*4]	; limit=lev->limit
	ldr	r8, [r1, #16*4]		; lev->cnt2
	b	stay 

finished_block
	mov	r9, #CORE_S_OK
	str	r9, [r13, #7*4]		; retval=CORE_S_OK
	b	loop_break		; break

new_ruler
	add	r9, r0, #6*4		; oState->marks
	str	r8, [r9, r11, lsl#2]	; oState->marks[oState->maxdepthm1]=lev->cnt2
	stmdb	r13!, {r0-r3, r11, r12, r14}
	bl	found_one
	cmp	r0, #0
	ldmia	r13!, {r0-r3, r11, r12, r14}
	beq	stay
	mov	r9, #CORE_S_SUCCESS
	str	r9, [r13, #7*4]		; retval=CORE_S_SUCCESS

loop_break
	sub	r9, r14, #1
	str	r9, [r0, #48*4]		; oState->depth=depth-1
	ldr	r9, [r13]
	str	r12, [r9]		; *pnodes=nodes
	ldr	r0, [r13, #7*4]		; return retval
	add	sp, sp, #10*4
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, r10, r11, r12, pc}

;-----------------------------------------------------------------------------

	EXPORT	ogr_get_dispatch_table_arm1
ogr_get_dispatch_table_arm1
	stmdb	r13!, {r4, r14}
	bl	ogr_get_dispatch_table
	ldr	r4, pdispatch_table
	ldmia	r0!,{r1-r3}
	ldr	r3, pogr_cycle
	stmia	r4!,{r1-r3}
	ldmia	r0!,{r1-r3}
	stmia	r4!,{r1-r3}
	sub	r0, r4, #24
	ldmia	r13!, {r4, pc}

;-----------------------------------------------------------------------------

	EXPORT	ogr_p2_get_dispatch_table_arm1
ogr_p2_get_dispatch_table_arm1
	stmdb	r13!, {r4, r14}
	bl	ogr_p2_get_dispatch_table
	ldr	r4, pdispatch_table
	ldmia	r0!,{r1-r3}
	ldr	r3, pogr_cycle
	stmia	r4!,{r1-r3}
	ldmia	r0!,{r1-r3}
	stmia	r4!,{r1-r3}
	sub	r0, r4, #24
	ldmia	r13!, {r4, pc}

;-----------------------------------------------------------------------------

pdispatch_table
	DCD	dispatch_table
pogr_cycle
	DCD	ogr_cycle_arm1

;-----------------------------------------------------------------------------

	AREA	|C$$DATA|, DATA
	ALIGN	32
dispatch_table
	%	24

	END
