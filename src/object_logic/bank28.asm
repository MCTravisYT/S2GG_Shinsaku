DATA_B28_8000:

.dw DATA_B28_8030
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_803E
.dw DATA_B28_804C 
.dw DATA_B28_8057
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_805F 
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_8036
.dw DATA_B28_8036

DATA_B28_8030:
.db $E0, $00  
	.dw LABEL_B28_8067
.db $FF, $00

DATA_B28_8036:
.db $FF, $07
	.dw LABEL_B28_81EE
	.dw LABEL_B28_8080
.db $FF, $00

DATA_B28_803E:
.db $FF, $04
	.dw $0000
	.dw $0000
.db $FF, $07
	.dw LABEL_B28_81EE
	.dw LABEL_B28_80F6
.db $FF, $00

DATA_B28_804C:
.db $FF, $07
	.dw LABEL_B28_81E7
	.dw LABEL_B28_8104
.db $FF, $05
	.db $0A
.db $FF, $00

DATA_B28_8057:
.db $FF, $07
	.dw LABEL_B28_81EE
	.dw LABEL_B28_8108
.db $FF, $00

DATA_B28_805F:
.db $FF, $07
	.dw LABEL_B28_81EE
	.dw LABEL_B28_8123
.db $FF, $00

LABEL_B28_8067:
	bit     6, (ix+$04)
	ret     nz
	set     7, (ix+$03)
	ld      a, (ix+$3F)
	and     $0F
	rlca    
	rlca    
	rlca    
	or      a
	jr      nz, +
	inc     a
+:	ld      (ix+$02), a
	ret     

LABEL_B28_8080:
	call    LABEL_200 + $39
	ld      a, (ix+$22)
	and     $0C
	jr      z, LABEL_B28_809B
	and     $04
	rlca    
	rlca    
	ld      b, a
	ld      a, (ix+$0A)
	and     $EF
	or      b
	ld      (ix+$0A), a
	jp      LABEL_B28_80D6

LABEL_B28_809B:
	ld      a, (ix+$1b)
	or      a
	jp      z, LABEL_B28_80D6
	ld      hl, ($D174)		;add 128 to the horizontal position
	ld      de, $0080
	add     hl, de
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_80C3
	ld      de, $00C0
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_80D6
	res     4, (ix+$0A)
	jp      LABEL_B28_80D6

LABEL_B28_80C3:
	dec     hl
	ld      a, h
	cpl     
	ld      h, a
	ld      a, l
	cpl     
	ld      l, a
	ld      de, $00C0
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_80D6
	set     4, (ix+$0A)
LABEL_B28_80D6:
	ld      a, $01
	bit     4, (ix+$0A)
	jr      z, +
	neg     
+:	ld      (ix+$17), a
	call    LABEL_B28_814F
	ld      a, (CurrentLevel)
	cp      $04
	ret     nz
	bit     6, (ix+$04)
	ret     z
	ld      (ix+$00), $FF
	ret     

LABEL_B28_80F6:
	call    LABEL_B28_814F
	ld      a, (ix+$21)
	and     $0F
	ret     z
	ld      (ix+$02), $09
	ret     

LABEL_B28_8104:
	call    LABEL_B28_814F
	ret     

LABEL_B28_8108:
	set     0, (ix+$04)
	ld      de, $0020
	ld      bc, $0600
	call    LABEL_200 + $0F
	call    LABEL_B28_814F
	ld      a, (ix+$1C)
	cp      $C0
	ret     c
	ld      (ix+$00), $FE
	ret     

LABEL_B28_8123:
	ld      (ix+$0b), $30
	call    LABEL_B28_8131
	call    LABEL_200 + $36
	call    LABEL_B28_814F
	ret     

LABEL_B28_8131:
	ld      a, (ix+$0A)
	or      a
	jp      z, LABEL_B28_8147
	ld      a, (ix+$1E)
	cpl     
	and     $01
	add     a, a
	dec     a
	add     a, (ix+$0a)
	ld      (ix+$0a), a
	ret     

LABEL_B28_8147:
	ld      (ix+$0a), $80
	inc     (ix+$1e)
	ret     

LABEL_B28_814F:
	ld      a, ($d521)
	ld      ($D100), a
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	jr      z, LABEL_B28_819B
	bit     1, a
	jr      nz, LABEL_B28_819B
	ld      a, ($d519)
	rla     
	jr      c, LABEL_B28_819B
	ld      a, ($d522)
	bit     1, a
	jr      nz, LABEL_B28_819B
	call    LABEL_200 + $57
	ld      (ix+$21), $01
	ld      a, $20
	ld      ($D521), a
	ld      a, ($D523)
	set     1, a
	ld      ($D523), a
	push    ix
	pop     hl
	call    LABEL_200 + $30
	ld      b, a
	ld      a, ($d3b9)
	or      a
	jr      z, +
	cp      b
	ret     nz
+:	ld      a, b
	ld      ($d3b9), a
	call    LABEL_B28_81B9
	ret     

LABEL_B28_819B:
	call    LABEL_200 + $57
	ld      (ix+$21), $00
	ld      a, ($d100)
	ld      ($d521), a
	ld      a, ($d3b9)
	ld      b, a
	push    ix
	pop     hl
	call    LABEL_200 + $30
	cp      b
	ret     nz
	xor     a
	ld      ($d3b9), a
	ret     

LABEL_B28_81B9:
	ld      e, (ix+$2d)
	ld      d, $00
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	inc     hl
	xor     a
	sbc     hl, de
	ld      ($d514), hl
	ld      hl, ($d510)
	ld      e, (ix+$16)
	ld      d, (ix+$17)
	ld      a, ($d512)
	ld      b, a
	ld      a, d
	and     $80
	rlca    
	dec     a
	cpl     
	add     hl, de
	adc     a, b
	ld      ($d512), a
	ld      ($d510), hl
	ret     

LABEL_B28_81E7:
	ld      (ix+$07), $20
	jp      LABEL_B28_81F2

LABEL_B28_81EE:
	ld      (ix+$07), $e0
LABEL_B28_81F2:
	ld      a, (ix+$3f)
	and     $f0
	rlca    
	rlca    
	rlca    
	rlca    
	inc     a
	ld      (ix+$06), a
	ret     

DATA_B28_8200:
.dw DATA_B28_820C
.dw DATA_B28_8212
.dw DATA_B28_823F
.dw DATA_B28_82B4
.dw DATA_B28_82D1
.dw DATA_B28_834C

DATA_B28_820C:
.db $01, $01
	.dw LABEL_B28_8352
.db $FF, $00

DATA_B28_8212:
.db $FF, $04
	.dw $0000
	.dw $FF00
.db $80, $01
	.dw LABEL_B28_837F
.db $80, $01
	.dw LABEL_B28_837F
.db $80, $01
	.dw LABEL_B28_837F
.db $FF, $04
	.dw $0000
	.dw $0100
.db $80, $01
	.dw LABEL_B28_837F
.db $80, $01
	.dw LABEL_B28_837F
.db $80, $01
	.dw LABEL_B28_837F
.db $FF, $05
	.db $00
.db $00, $01
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_823F:
.db $FF, $04
	.dw $0000
	.dw $FF00
.db $D0, $01
	.dw LABEL_B28_836A
.db $FF, $04
	.dw $0100
	.dw $0000
.db $60, $01
	.dw LABEL_B28_836A
.db $FF, $04
	.dw $0000
	.dw $FF00
.db $E0, $01
	.dw LABEL_B28_836A
.db $FF, $04
	.dw $0000
	.dw $0100
.db $60, $01
	.dw LABEL_B28_836A
.db $FF, $04
	.dw $FF00
	.dw $0000
.db $80, $01
	.dw LABEL_B28_836A
.db $80, $01
	.dw LABEL_B28_836A
.db $80, $01
	.dw LABEL_B28_836A
.db $FF, $04
	.dw $0000
	.dw $0100
.db $20, $01
	.dw LABEL_B28_836A
.db $FF, $04
	.dw $FF00
	.dw $0000
.db $80, $01
	.dw LABEL_B28_836A
.db $80, $01
	.dw LABEL_B28_836A
.db $60, $01
	.dw LABEL_B28_836A
.db $FF, $04
	.dw $0000
	.dw $0000
.db $20, $01
	.dw LABEL_B28_836A
.db $80, $01
	.dw LABEL_B28_8108
.db $80, $01
	.dw LABEL_B28_8108
.db $80, $01
	.dw LABEL_B28_8108
.db $FF, $05
	.db $00
.db $00, $01
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_82B4:
.db $FF, $04
	.dw $0280
	.dw $0000
.db $CC, $01
	.dw LABEL_B28_837F
.db $FF, $04
	.dw $FD80
	.dw $0000
.db $CC, $01
	.dw LABEL_B28_837F
.db $FF, $05
	.db $00
.db $00, $01
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_82D1:
.db $FF, $04
	.dw $0220
	.dw $0000
.db $80, $01
	.dw LABEL_B28_837F
.db $80, $01
	.dw LABEL_B28_837F
.db $78, $01
	.dw LABEL_B28_837F
.db $FF, $04
	.dw $0000
	.dw $FF00
.db $80, $01
	.dw LABEL_B28_837F
.db $FF, $04
	.dw $FE00
	.dw $0000
.db $08, $01
	.dw LABEL_B28_837F
.db $FF, $04
	.dw $F000
	.dw $0000
.db $07, $01
	.dw LABEL_B28_837F
.db $FF, $04
	.dw $0000
	.dw $F400
.db $08, $01
	.dw LABEL_B28_837F
.db $FF, $04
	.dw $FF00
	.dw $0000
.db $80, $01
	.dw LABEL_B28_837F
.db $FF, $04
	.dw $0000
	.dw $FF00
.db $A0, $01
	.dw LABEL_B28_837F
.db $FF, $04
	.dw $FF00
	.dw $0000
.db $80, $01
	.dw LABEL_B28_837F
.db $A0, $01
	.dw LABEL_B28_837F
.db $FF, $04
	.dw $0000
	.dw $0000
.db $20, $01
	.dw LABEL_B28_837F
.db $80, $01
	.dw LABEL_B28_8108
.db $80, $01
	.dw LABEL_B28_8108
.db $80, $01
	.dw LABEL_B28_8108
.db $FF, $05, $00
.db $00, $01
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_834C:
.db $06, $01
	.dw LABEL_B28_8383
.db $FF, $00


LABEL_B28_8352:
	set     7, (ix+$03)
	ld      a, (ix+$3f)
	dec     a
	jr      z, +
	bit     6, (ix+$04)
	ret     nz
	set     1, (ix+$04)
+:	ld      (ix+$02), $05
	ret

LABEL_B28_836A:
	call    LABEL_B28_814F
	res     1, (ix+$04)
	res     7, (ix+$04)
	bit     6, (ix+$04)
	ret     z
	ld      (ix+$02), $05
	ret     

LABEL_B28_837F:
	call    LABEL_B28_814F
	ret     

LABEL_B28_8383:
	ld      a, (ix+$3f)
	dec     a
	jr      z, +
	bit     6, (ix+$04)
	ret     nz
+:	ld      a, $00
	ld      (ix+$16), a
	ld      (ix+$17), a
	ld      (ix+$18), a
	ld      (ix+$19), a
	ld      a, (ix+$3b)
	ld      (ix+$12), a
	ld      a, (ix+$3a)
	ld      (ix+$11), a
	ld      a, (ix+$3d)
	ld      (ix+$15), a
	ld      a, (ix+$3c)
	ld      (ix+$14), a
	call    LABEL_B28_814F
	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      a, (ix+$3f)
	inc     a
	ld      (ix+$02), a
	ret     

DATA_B28_83C5:
.dw DATA_B28_83C9
.dw DATA_B28_83DD

DATA_B28_83C9:
.db $E0, $00
	.dw LABEL_B28_83CF
.db $FF, $00


LABEL_B28_83CF:
	bit     6, (ix+$04)
	ret     nz
	ld      (ix+$02), $01
	set     7, (ix+$03)
	ret     

DATA_B28_83DD:
.db $E0, $01
	.dw LABEL_B28_83E3
.db $FF, $00

LABEL_B28_83E3:
	ld      hl, $0100
	bit     0, (ix+$1e)
	jr      z, +
	ld      hl, $ff00
+:	ld      (ix+$16), l
	ld      (ix+$17), h
	call    LABEL_B28_814F
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	ld      e, (ix+$3a)
	ld      d, (ix+$3b)
	xor     a
	sbc     hl, de
	jr      nc, LABEL_B28_840E
	res     0, (ix+$1e)
	ret     

LABEL_B28_840E:
	ld		a, h
	or		a
	jr		nz, $05
	ld		a, l
	cp		(ix+$3F)
	ret		c
	set		0, (ix+$1E)
	ret


;Logic for crab badnik
.include "src\object_logic\logic_crab_badnik.asm"


DATA_B28_85F3:
.dw DATA_B28_85F9
.dw DATA_B28_8602
.dw DATA_B28_860E

DATA_B28_85F9:
.db $FF, $05
	.db $01
.db $E0, $00
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_8602:
.db $FF, $04
	.dw $FF00
	.dw $0000
.db $E0, $00
	.dw LABEL_B28_8618
.db $FF, $00

DATA_B28_860E:
.db $06, $01
	.dw LABEL_B28_8629
.db $06, $02
	.dw LABEL_B28_8629
.db $FF, $00


LABEL_B28_8618:
	ld      a, ($d523)
	cp      $06
	ret     nz
	ld      a, ($d137)
	cp      $08
	ret     nz
	ld      (ix+$02), $02
	ret     

LABEL_B28_8629:
	call    LABEL_200 + $57
	ld      de, $0020
	ld      bc, $0600
	call    LABEL_200 + $0F
	ld      hl, $0200
	call    LABEL_200 + $12
	bit     6, (ix+$04)
	ret     z
	ld      (ix+$00), $ff
	ret     

DATA_B28_8645:
.dw DATA_B28_865B
.dw DATA_B28_8661
.dw DATA_B28_8667
.dw DATA_B28_8661
.dw DATA_B28_8667
.dw DATA_B28_8673
.dw DATA_B28_8679
.dw DATA_B28_8685
.dw DATA_B28_868B
.dw DATA_B28_8697
.dw DATA_B28_869D

DATA_B28_865B:
.db $E0, $00
	.dw LABEL_B28_86A9
.db $FF, $00

DATA_B28_8661:
.db $E0, $01
	.dw LABEL_B28_86B2
.db $FF, $00

DATA_B28_8667:
.db $FF, $04
	.dw $0000
	.dw $FE00
.db $E0, $01
	.dw LABEL_B28_8746
.db $FF, $00

DATA_B28_8673:
.db $E0, $02
	.dw LABEL_B28_86E3
.db $FF, $00

DATA_B28_8679:
.db $FF, $04
	.dw $0000
	.dw $0200
.db $E0, $02
	.dw LABEL_B28_8746
.db $FF, $00

DATA_B28_8685:
.db $E0, $03
	.dw LABEL_B28_86F8
.db $FF, $00

DATA_B28_868B:
.db $FF, $04
	.dw $FE00
	.dw $0000
.db $E0, $03
	.dw LABEL_B28_8746
.db $FF, $00

DATA_B28_8697
.db $E0, $04
	.dw LABEL_B28_8729
.db $FF, $00

DATA_B28_869D
.db $FF, $04
	.dw $0200
	.dw $0000
.db $E0, $04
	.dw LABEL_B28_8746
.db $FF, $00

LABEL_B28_86A9:
	ld      a, (ix+$3f)
	add     a, a
	inc     a
	ld      (ix+$02), a
	ret     

LABEL_B28_86B2:
	bit     6, (ix+$04)
	ret     nz
	ld      hl, ($d514)
	ld      e, (ix+$14)
	ld      d, (ix+$15)
	xor     a
	sbc     hl, de
	ret     nc
LABEL_B28_86C4:
	ld      hl, ($d511)
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	jr      nc, +
	dec     hl
	ld      a, h
	cpl     
	ld      h, a
	ld      a, l
	cpl     
	ld      l, a
+:	ld      a, h
	or      a
	ret     nz
	ld      a, l
	cp      $30
	jp      c, LABEL_B28_873E
	ret     

LABEL_B28_86E3:
	bit     6, (ix+$04)
	ret     nz
	ld      hl, ($d514)
	ld      e, (ix+$14)
	ld      d, (ix+$15)
	xor     a
	sbc     hl, de
	ret     c
	jp      LABEL_B28_86C4

LABEL_B28_86F8:
	bit     6, (ix+$04)
	ret     nz
	ld      hl, ($d511)
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	ret     nc
LABEL_B28_870A:
	ld      hl, ($d514)
	ld      e, (ix+$14)
	ld      d, (ix+$15)
	xor     a
	sbc     hl, de
	jr      nc, +
	dec     hl
	ld      a, h
	cpl     
	ld      h, a
	ld      a, l
	cpl     
	ld      l, a
+:  ld      a, h
	or      a
	ret     nz
	ld      a, l
	cp      $30
	jp      c, LABEL_B28_873E
	ret

LABEL_B28_8729:
	bit     6, (ix+$04)
	ret     nz
	ld      hl, ($d511)
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	ret     c
	jp      LABEL_B28_870A

LABEL_B28_873E:
	ld      a, (ix+$01)
	inc     a
	ld      (ix+$02), a
	ret

LABEL_B28_8746:
	call    LABEL_200 + $57
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	jr      z, +
	ld      a, $ff
	ld      ($d3a8), a
+:	bit     6, (ix+$04)
	ret     z
	ld      (ix+$00), $fe
	ret     

DATA_B28_8762:
.dw LABEL_B28_876A
.dw LABEL_B28_8770
.dw LABEL_B28_8776
.dw LABEL_B28_877C

LABEL_B28_876A:
.db $01, $00
	.dw LABEL_B28_878E
.db $FF, $00

LABEL_B28_8770:
.db $F0, $01
	.dw LABEL_B28_8793
.db $FF, $00

LABEL_B28_8776:
.db $F0, $00
	.dw LABEL_B28_87B3
.db $FF, $00

LABEL_B28_877C:
.db $08, $01
	.dw LABEL_B28_87EF
.db $08, $02
	.dw LABEL_B28_87EF
.db $08, $03
	.dw LABEL_B28_87EF
.db $08, $04
	.dw LABEL_B28_87EF
.db $FF, $00


LABEL_B28_878E:
	ld      (ix+$02), $01
	ret     

LABEL_B28_8793:
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	or      a
	ret     z
	xor     a
	ld      (ix+$21), a
	ld      ($d521), a
	ld      a, $11
	ld      ($d502), a
	call    LABEL_200 + $7E
	ld      (ix+$02), $02
	set     7, (ix+$04)
	ret     

LABEL_B28_87B3:
	call    LABEL_200 + $09
	ld      bc, ($d511)
	ld      de, ($d514)
	ld      (ix+$3a), c
	ld      (ix+$3b), b
	ld      (ix+$3c), e
	ld      (ix+$3d), d
	ld      a, ($d501)
	cp      $11
	ret     nc
	ld      hl, ($d516)
	ld      de, $ff80
	add     hl, de
	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      bc, $ff00
	ld      (ix+$18), c
	ld      (ix+$19), b
	ld      (ix+$02), $03
	res     7, (ix+$04)
	ret

LABEL_B28_87EF:
	ld      l, (ix+$18)
	ld      h, (ix+$19)
	ld      de, $0008
	add     hl, de
	ld      (ix+$18), l
	ld      (ix+$19), h
	jp      LABEL_200 + $57


DATA_B28_8802:
.dw DATA_B28_8806
.dw DATA_B28_8813

DATA_B28_8806:
.db $01, $00
	.dw LABEL_B28_8819
.db $FF, $05
	.db $01
.db $01, $00
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_8813:
.db $E0, $01
	.dw LABEL_B28_881E
.db $FF, $00


LABEL_B28_8819:
	set     7, (ix+$03)
	ret     

LABEL_B28_881E:
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      a, ($d501)
	cp      $22
	jp      z, +
	ld      a, $22
	ld      ($d502), a
	ld      a, SFX_RollWheel
	ld      ($dd04), a
	ld      hl, $0300
	ld      ($d3c7), hl
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	ld      de, $fff4
	add     hl, de
	ex      de, hl
	ld      hl, ($d514)
	xor     a
	sbc     hl, de
	ld      ($d3cb), de
	jp      nc, LABEL_B28_8889
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	ld      ($d3c9), hl
	ld      de, $0028
	add     hl, de
	ld      de, ($d511)
	xor     a
	sbc     hl, de
	ld      a, h
	or      a
	jr      z, ++
	ld      l, $00
++:	ld      a, l
	cp      $4f
	jr      c, ++
	ld      a, $4f
++:	and     $f8
	rrca    
	rrca    
	rrca    
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B28_88BB
	add     hl, de
	ld      a, (hl)
	ld      ($d3c6), a
+:	ret     

LABEL_B28_8889:
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	ld      ($d3c9), hl
	ld      de, $0028
	add     hl, de
	ld      de, ($d511)
	xor     a
	sbc     hl, de
	ld      a, h
	or      a
	jr      z, +
	ld      l, $00
+:	ld      a, l
	cp      $4f
	jr      c, +
	ld      a, $4f
+:	and     $f8
	rrca    
	rrca    
	rrca    
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B28_88C5
	add     hl, de
	ld      a, (hl)
	ld      ($d3c6), a
	ret

DATA_B28_88BB:
.db $38, $30, $20, $10, $00, $00, $F0, $E0, $D0, $C8
DATA_B28_88C5
.db $48, $50, $60, $70, $80, $80, $90, $A0, $B0, $B8


;Minecart logic
.include "src\object_logic\logic_minecart.asm"


DATA_B28_8B5A:
.dw DATA_B28_8B5E
.dw DATA_B28_8B6B

DATA_B28_8B5E:
.db $01, $00
	.dw LABEL_B28_8B75
.db $FF, $05
	.db $01
.db $01, $00
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_8B6B:
.db $04, $01
	.dw LABEL_B28_8B7E
.db $04, $02
	.dw LABEL_B28_8B7E
.db $FF, $00


LABEL_B28_8B75:
	set     7, (ix+$03)
	ld      (ix+$0b), $40
	ret     

LABEL_B28_8B7E:
	ld      a, (ix+$0a)
	add     a, $04
	ld      (ix+$0a), a
	call    LABEL_200 + $36
	ld      hl, $0100
	bit     0, (ix+$1e)
	jr      z, +
	ld      hl, $ff00
+:	ld      (ix+$16), l
	ld      (ix+$17), h
	call    LABEL_200 + $57
	ld      a, (ix+$0a)
	and     $7f
	jp      nz, LABEL_B28_8BCC
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	ld      e, (ix+$3a)
	ld      d, (ix+$3b)
	xor     a
	sbc     hl, de
	jr      nc, LABEL_B28_8BBE
	res     0, (ix+$1e)
	jp      LABEL_B28_8BCC

LABEL_B28_8BBE
	ld      a, h
	or      a
	jr      nz, +
	ld      a, l
	cp      (ix+$3f)
	jr      c, LABEL_B28_8BCC
+:	set     0, (ix+$1e)
LABEL_B28_8BCC:
	ld      a, ($d3cd)
	or      a
	jp      z, +
	push    ix
	pop     hl
	call    LABEL_200 + $30
	ld      b, a
	ld      a, ($d3cd)
	cp      b
	ret     nz
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	set     7, h
	ld      ($d3c9), hl
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	ld      de, $fffa
	add     hl, de
	ld      ($d3cb), hl
+:	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      a, ($d501)
	cp      $22
	jp      z, +
	push    ix
	pop     hl
	call    LABEL_200 + $30
	ld      ($d3cd), a
	ld      a, $22
	ld      ($d502), a
	ld      a, $ae
	ld      ($dd04), a
	ld      hl, $0300
	ld      ($d3c7), hl
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	ld      de, $fffa
	add     hl, de
	ex      de, hl
	ld      hl, ($d514)
	xor     a
	sbc     hl, de
	ld      ($d3cb), de
	jp      nc, LABEL_B28_8C6D
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	set     7, h
	ld      ($d3c9), hl
	ld      de, $0028
	add     hl, de
	ld      de, ($d511)
	xor     a
	sbc     hl, de
	ld      a, h
	or      a
	jr      z, ++
	ld      l, $00
++:	ld      a, l
	cp      $4f
	jr      c, ++
	ld      a, $4f
++:	and     $f8
	rrca    
	rrca    
	rrca    
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B28_8CA1
	add     hl, de
	ld      a, (hl)
	ld      ($d3c6), a
+:	ret     

LABEL_B28_8C6D:
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	set     7, h
	ld      ($d3c9), hl
	ld      de, $0028
	add     hl, de
	ld      de, ($d511)
	xor     a
	sbc     hl, de
	ld      a, h
	or      a
	jr      z, +
	ld      l, $00
+:	ld      a, l
	cp      $4f
	jr      c, +
	ld      a, $4f
+:	and     $f8
	rrca    
	rrca    
	rrca    
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B28_8CAB
	add     hl, de
	ld      a, (hl)
	ld      ($d3c6), a
	ret     

DATA_B28_8CA1:
.db $38, $30, $20, $10, $00, $00, $F0, $E0, $D0, $C8

DATA_B28_8CAB:
.db $48, $50, $60, $70, $80, $80, $90, $A0, $B0, $B8

DATA_B28_8CB5:
.dw LABEL_B28_8CB9
.dw LABEL_B28_8CBF

LABEL_B28_8CB9:
.db $01 $01
	.dw LABEL_B28_8CC9
.db $FF $00

LABEL_B28_8CBF:
.db $10 $01
	.dw LABEL_B28_8CDB
.db $10 $02
	.dw LABEL_B28_8CDB
.db $FF $00


LABEL_B28_8CC9:
	ld      (ix+$02), $01
	ld      hl, $8000
	ld      (ix+$0a), h
	ld      (ix+$3f), l
	ld      (ix+$1f), $00
	ret     

LABEL_B28_8CDB:
	bit     0, (ix+$1f)
	jr      nz, LABEL_B28_8D1C
	ld      a, $00
	call    LABEL_B28_8D95
	ld      h, (ix+$0a)
	ld      l, (ix+$3f)
	ld      d, $00
	ld      e, (ix+$1e)
	xor     a
	add     hl, de
	ld      (ix+$0a), h
	ld      (ix+$3f), l
	jr      c, +
	xor     a
	add     hl, de
	ld      (ix+$0a), h
	ld      (ix+$3f), l
	jr      c, +
	xor     a
	add     hl, de
	ld      (ix+$0a), h
	ld      (ix+$3f), l
	jr      nc, LABEL_B28_8D78
+:	inc     (ix+$1f)
	ld      (ix+$0a), $80
	ld      (ix+$3f), $00
	jr      LABEL_B28_8D78

LABEL_B28_8D1C:
	ld      a, $01
	call    LABEL_B28_8D95
	ld      h, (ix+$0a)
	ld      l, (ix+$3f)
	ld      d, $00
	ld      e, (ix+$1e)
	xor     a
	sbc     hl, de
	ld      (ix+$0a), h
	ld      (ix+$3f), l
	jr      c, +
	xor     a
	sbc     hl, de
	ld      (ix+$0a), h
	ld      (ix+$3f), l
	jr      c, +
	xor     a
	sbc     hl, de
	ld      (ix+$0a), h
	ld      (ix+$3f), l
	jr      nc, LABEL_B28_8D78
+:  inc     (ix+$1f)
	ld      (ix+$0a), $80
	ld      (ix+$3f), $00
	ld      a, (ix+$3b)
	ld      (ix+$12), a
	ld      a, (ix+$3a)
	ld      (ix+$11), a
	ld      (ix+$10), $00
	ld      a, (ix+$3d)
	ld      (ix+$15), a
	ld      a, (ix+$3c)
	ld      (ix+$14), a
	ld      (ix+$13), $00
LABEL_B28_8D78:
	ld      a, (ix+$1e)
	sra     a
	ld      (ix+$0b), a
	call    LABEL_200 + $36
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      a, $ff
	ld      ($d3a8), a
	ret     

LABEL_B28_8D95:
	bit     0, a
	jr      nz, LABEL_B28_8DAC
	ld      a, (ix+$0a)
	cp      $c0
	jr      nc, LABEL_B28_8DA4
	sub     $80
	jr      LABEL_B28_8DA6

LABEL_B28_8DA4:
	neg  
LABEL_B28_8DA6:	
	add     a, $40
	ld      (ix+$1e), a
	ret     

LABEL_B28_8DAC:
	ld      a, (ix+$0a)
	cp      $40
	jr      c, +
	neg     
	sub     $80
+:	add     a, $40
	ld      (ix+$1e), a
	ret     

DATA_B28_8DBD:
.dw DATA_B28_8DC7
.dw DATA_B28_8DCC
.dw DATA_B28_8DD2
.dw DATA_B28_8DDC
.dw DATA_B28_8DF2

DATA_B28_8DC7:
.db $FF, $05
	.db $01
.db $FF, $03
DATA_B28_8DCC
.db $E0, $01
	.dw LABEL_B28_8DF8
.db $FF, $00

DATA_B28_8DD2:
.db $02, $02
	.dw LABEL_B28_8E5D
.db $02, $03
	.dw LABEL_B28_8E5D
.db $FF, $00

DATA_B28_8DDC:
.db $02, $02
	.dw LABEL_B28_8E66
.db $02, $03
	.dw LABEL_B28_8E66
.db $02, $02
	.dw LABEL_B28_8E66
.db $02, $03
	.dw LABEL_B28_8E66
.db $E0, $01
	.dw LABEL_B28_8E66
.db $FF, $00

DATA_B28_8DF2:
.db $E0, $01
	.dw LABEL_B28_8E89
.db $FF, $00

LABEL_B28_8DF8:
	bit     6, (ix+$04)
	ret     nz
	ld      hl, ($d514)
	ld      e, (ix+$14)
	ld      d, (ix+$15)
	xor     a
	sbc     hl, de
	ret     c
	ld      a, h
	or      a
	ret     nz
	ld      b, l
	srl     b
	ld      de, ($d516)
	bit     7, d
	jr      z, +
	dec     de
	ld      a, d
	cpl     
	ld      d, a
	ld      a, e
	cpl     
	ld      e, a
+:	ld      hl, $0180
	xor     a
	sbc     hl, de
	jr      nc, +
	ld      a, b
	add     a, a
	ld      b, a
	ld      hl, $0380
	xor     a
	sbc     hl, de
	jr      nc, +
	ld      a, b
	add     a, b
	ld      b, a
	jr      nc, +
	ld      b, $ff
+:	ld      hl, ($d511)
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	jr      nc, +
	ex      de, hl
	ld      hl, $0000
	xor     a
	sbc     hl, de
+:	ld      a, h
	or      a
	ret     nz
	ld      a, l
	cp      b
	ret     nc
	ld      (ix+$02), $02
	ld      (ix+$1f), $10
	ret     

LABEL_B28_8E5D:
	dec     (ix+$1f)
	ret     nz
	ld      (ix+$02), $03
	ret     

LABEL_B28_8E66:
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	jr      nz, +
	ld      de, $0050
	ld      bc, $0600
	call    LABEL_200 + $0F
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	bit     1, (ix+$22)
	ret     z
+:	ld      (ix+$02), $04
	ret     

LABEL_B28_8E89:
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	ld      a, l
	and     $e0
	ld      l, a
	ld      ($d35a), hl
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	ld      a, l
	and     $e0
	ld      l, a
	ld      ($d35c), hl
	call    LABEL_200 + $E4
	ld      (ix+$3f), $82
	ld      (ix+$3e), $00
	jp      LABEL_200 + $5D

DATA_B28_8EB1:
.dw DATA_B28_8EB5
.dw DATA_B28_8EBE

DATA_B28_8EB5:
.db $FF, $02
	.dw LABEL_B28_8EC4
.db $FF, $05
	.db $01
.db $FF, $03
DATA_B28_8EBE:
.db $E0, $01
	.dw LABEL_B28_8108
.db $FF, $00


LABEL_B28_8EC4:
	set     7, (ix+$03)
	ld      (ix+$08), $62
	ld      hl, ($d511)
	ld      a, l
	and     $f0
	or      $08
	ld      l, a
	ld      (ix+$11), l
	ld      (ix+$12), h
	ld      hl, ($d514)
	ld      bc, $0020
	add     hl, bc
	ld      a, l
	and     $e0
	ld      l, a
	ld      de, $fff4
	add     hl, de
	ld      (ix+$14), l
	ld      (ix+$15), h
	ret     

DATA_B28_8EF1:
.dw DATA_B28_8EF7
.dw DATA_B28_8EFD
.dw DATA_B28_8F03

DATA_B28_8EF7:
.db $01, $00
	.dw LABEL_B28_8F0D
.db $FF, $00

DATA_B28_8EFD:
.db $10, $01
	.dw LABEL_B28_8F12
.db $FF, $00

DATA_B28_8F03:
.db $10, $01
	.dw LABEL_B28_8FA3
.db $10, $02
	.dw LABEL_B28_8FA3
.db $FF, $00

LABEL_B28_8F0D:
	ld      (ix+$02), $01
	ret     

LABEL_B28_8F12
	set     7, (ix+$04)
	ld      a, (ix+$3b)
	ld      (ix+$12), a
	ld      a, (ix+$3a)
	ld      (ix+$11), a
	ld      a, (ix+$3d)
	ld      (ix+$15), a
	ld      a, (ix+$3c)
	ld      (ix+$14), a
	ld      a, (DATA_B28_901A+1)
	ld      h, a
	ld      a, (DATA_B28_901A)
	ld      l, a
	ld      (ix+$19), h
	ld      (ix+$18), l
	ld      (ix+$1e), $00
	res     0, (ix+$1f)
	bit     0, (ix+$3f)
	jr      nz, LABEL_B28_8F76
	ld      hl, ($d511)
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	jp      c, LABEL_B28_9017
	ld      de, $00a0
	xor     a
	sbc     hl, de
	jp      c, LABEL_B28_9017
	ld      (ix+$02), $02
	res     7, (ix+$04)
	ld      hl, $0180
	ld      (ix+$17), h
	ld      (ix+$16), l
	jp      LABEL_B28_9017

LABEL_B28_8F76:
	ld      de, ($d511)
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	xor     a
	sbc     hl, de
	jp      c, LABEL_B28_9017
	ld      de, $00a0
	xor     a
	sbc     hl, de
	jp      c, LABEL_B28_9017
	ld      (ix+$02), $02
	res     7, (ix+$04)
	ld      hl, $fe80
	ld      (ix+$17), h
	ld      (ix+$16), l
	jp      LABEL_B28_9017

LABEL_B28_8FA3:
	bit     6, (ix+$04)
	jr      z, LABEL_B28_8FB4
	bit     0, (ix+$1f)
	jr      z, LABEL_B28_8FB8
	ld      (ix+$02), $00
	ret     

LABEL_B28_8FB4:
	set     0, (ix+$1f)
LABEL_B28_8FB8:
	call    LABEL_200 + $39
	ld      a, (ix+$22)
	and     $0c
	jr      z, LABEL_B28_8FC9
	ld      (ix+$3f), $80
	jp      LABEL_200 + $5D

LABEL_B28_8FC9:
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_9017
	ld      h, (ix+$19)
	ld      l, (ix+$18)
	ld      de, $0020
	xor     a
	add     hl, de
	ld      (ix+$19), h
	ld      (ix+$18), l
	call    LABEL_200 + $60
	ld      a, (ix+$22)
	and     $02
	jr      z, LABEL_B28_9014
	ld      a, (ix+$1e)
	add     a, $01
	ld      b, a
	ld      (ix+$1e), a
	and     $08
	jp      nz, LABEL_B28_9017
	ld      a, (DATA_B28_901A + 1)
	ld      h, a
	ld      a, (DATA_B28_901A)
	ld      l, a
	ld      de, $0040
-:	add     hl, de
	djnz    -
	ld      (ix+$19), h
	ld      (ix+$18), l
LABEL_B28_9014:
	jp      LABEL_B28_9017

LABEL_B28_9017:
	jp      LABEL_200 + $0C
		

DATA_B28_901A:
.db $00, $FC


DATA_B28_901C:
.dw DATA_B28_901E

DATA_B28_901E:
.db $FF, $03

DATA_B28_9020:			;prison capsule logic?
.dw DATA_B28_902C
.dw DATA_B28_9043
.dw DATA_B28_90A5
.dw DATA_B28_90C4
.dw DATA_B28_9122
.dw DATA_B28_9128

DATA_B28_902C:
.db $FF, $08
	.db $10
.db $18, $00
	.dw VF_DoNothing
.db $FF, $06
	.db $06
	.dw $0000
	.dw $0000
	.db $00
.db $FF, $08
	.db $11
.db $FF, $05
	.db $04
.db $FF, $03

DATA_B28_9043:
.db $04, $01
	.dw LABEL_B28_920F
.db $04, $01
	.dw LABEL_B28_923F
.db $04, $01
	.dw LABEL_B28_921F
.db $04, $01
	.dw LABEL_B28_922F
.db $04, $01
	.dw LABEL_B28_921F
.db $04, $01
	.dw LABEL_B28_922F
.db $04, $01
	.dw LABEL_B28_920F
.db $04, $01
	.dw LABEL_B28_923F
.db $02, $01
	.dw LABEL_B28_923F
.db $02, $01
	.dw LABEL_B28_920F
.db $02, $01
	.dw LABEL_B28_922F
.db $02, $01
	.dw LABEL_B28_921F
.db	$04, $01
	.dw LABEL_B28_921F
.db $04, $01
	.dw LABEL_B28_922F
.db $04, $01
	.dw LABEL_B28_920F
.db $04, $01
	.dw LABEL_B28_923F
.db $04, $01
	.dw LABEL_B28_920F
.db $04, $01
	.dw LABEL_B28_923F
.db	$04, $01
	.dw LABEL_B28_921F
.db $04, $01
	.dw LABEL_B28_922F
.db $02, $01
	.dw LABEL_B28_922F
.db $02, $01
	.dw LABEL_B28_921F
.db $02, $01
	.dw LABEL_B28_923F
.db $02, $01
	.dw LABEL_B28_920F
.db $FF, $00

DATA_B28_90A5:
.db $FF, $04
	.dw $0000
	.dw $0000
.db $40, $01
	.dw LABEL_B28_91D7
.db $10, $02
	.dw LABEL_B28_91D7
.db $10, $03
	.dw LABEL_B28_91D7
.db $FF, $02
	.dw LABEL_200 + $2D
.db $FF, $05
	.db $03
.db $0C, $03
	.dw LABEL_B28_91D7
.db $FF, $00

DATA_B28_90C4:
.db $0C, $03
	.dw LABEL_B28_91D7
.db $FF, $06
	.db $0F
	.dw $0000
	.dw $FFFF
	.db $00
.db $0C, $03
	.dw LABEL_B28_91D7
.db $FF, $06
	.db $0F
	.dw $FFE8
	.dw $FFDC
	.db $00
.db $FF, $02
	.dw LABEL_B28_92A7
.db $0C, $03
	.dw LABEL_B28_91D7
.db $FF, $06
	.db $0F
	.dw $0008
	.dw $0004
	.db $00
.db $0C, $03
	.dw LABEL_B28_91D7
.db $FF, $02
	.dw LABEL_B28_92A7
.db $FF, $06
	.db $0F
	.dw $FFF8
	.dw $0000
	.db $00
.db $0C, $03
	.dw LABEL_B28_91D7
.db $FF, $06
	.db $0F
	.dw $0018
	.dw $FFDC
	.db $00
.db $0C, $03
	.dw LABEL_B28_91D7
.db $FF, $06
	.db $0F
	.dw $FFFA
	.dw $0000
	.db $00
.db $0C, $03
	.dw LABEL_B28_91D7
.db $FF, $02
	.dw LABEL_B28_92A7
.db $0C, $03
	.dw LABEL_B28_91D7
.db $FF, $00

DATA_B28_9122:
.db $E0, $01,
	.dw LABEL_B28_916E
.db $FF, $00

DATA_B28_9128:
.db $70, $01
	.dw LABEL_B28_912E
.db $FF, $00

LABEL_B28_912E:
	call    LABEL_200 + $18
	ld      hl, $00C0
	ld      (ix+$18), l
	ld      (ix+$19), h
	call    LABEL_200 + $57
	ld      a, (CurrentLevel)
	add     a, a
	add     a, a
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B28_91BB
	add     hl, de
	inc     hl
	inc     hl
	ld      e, (hl)
	inc     hl
	ld      d, (hl)
	ld      hl, $0040
	add     hl, de
	ld      e, (ix+$14)
	ld      d, (ix+$15)
	ld      a, d
	and     $80
	ret     nz
	xor     a
	sbc     hl, de
	ret     nc
	ld      (ix+$02), $01
	ld      hl, $0000
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     

LABEL_B28_916E:
	call    LABEL_200 + $0102
	set     1, (ix+$04)
	set     7, (ix+$03)
	res     6, (ix+$04)
	ld      hl, ($D176)
	ld      de, $FFD8
	add     hl, de
	ld      (ix+$14), l
	ld      (ix+$15), h
	ld      de, ($D174)
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	xor     a
	sbc     hl, de
	jr      c, +
	ld      a, h
	or      a
	ret     nz
	ld      a, l
	cp      $80
	ret     nc
+:	ld      (ix+$02), $05
	ld      a, (CurrentLevel)
	add     a, a
	add     a, a
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B28_91BB
	add     hl, de
	ld      c, (hl)
	inc     hl
	ld      b, (hl)
	inc     hl
	ld      e, (hl)
	inc     hl
	ld      d, (hl)
	call    LABEL_200 + $F6		;set the camera position
	ret     

DATA_B28_91BB:		;prison capsule positions?
.db $F4, $0E, $08, $00
.db $F2, $0A, $00, $01
.db $F5, $0E, $80, $00
.db $81, $13, $7E, $00
.db $F3, $03, $5E, $00
.db $F3, $03, $5E, $00
.db $E4, $0D, $5E, $02


LABEL_B28_91D7:
	call    LABEL_200 + $18
	ld      a, ($D501)
	cp      $20
	jr      z, LABEL_B28_91F3
	ld      a, ($D503)
	bit     0, a
	jp      nz, LABEL_B28_91F3
	ld      a, $20
	ld      ($D502), a
	ld      a, Music_EndOfLevel
	ld      ($DD04), a
LABEL_B28_91F3:
	ld      a, (ix+$1e)
	inc     (ix+$1e)
	and     $06
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B28_9207
	add     hl, de
	ld      a, (hl)
	inc     hl
	ld      h, (hl)
	ld      l, a
	jp      (hl)

DATA_B28_9207:
.dw LABEL_B28_9215
.dw LABEL_B28_9225
.dw LABEL_B28_9225
.dw LABEL_B28_9215

LABEL_B28_920F:
	call    LABEL_200 + $18
	call    LABEL_B28_924F
LABEL_B28_9215:
	call    LABEL_B28_925F
	call    LABEL_B28_9270
	call    LABEL_200 + $57
	ret     

LABEL_B28_921F:
	call    LABEL_200 + $18
	call    LABEL_B28_924F
LABEL_B28_9225:
	call    LABEL_B28_9281
	call    LABEL_B28_9294
	call    LABEL_200 + $57
	ret     

LABEL_B28_922F:
	call    LABEL_200 + $18
	call    LABEL_B28_924F
	call    LABEL_B28_9281
	call    LABEL_B28_9270
	call    LABEL_200 + $57
	ret     

LABEL_B28_923F:
	call    LABEL_200 + $18
	call    LABEL_B28_924F
	call    LABEL_B28_925F
	call    LABEL_B28_9294
	call    LABEL_200 + $57
	ret     

LABEL_B28_924F:
	ld      a, (ix+$21)
	and     $0F
	ret     z
	ld      (ix+$02), $02
	ld      a, $AA
	ld      ($DD04), a
	ret     

LABEL_B28_925F
	ld      l, (ix+$18)
	ld      h, (ix+$19)
	ld      de, $0040
	add     hl, de
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     

LABEL_B28_9270
	ld      l, (ix+$16)
	ld      h, (ix+$17)
	ld      de, $0060
	add     hl, de
	ld      (ix+$16), l
	ld      (ix+$17), h
	ret     

LABEL_B28_9281:
	ld      l, (ix+$18)
	ld      h, (ix+$19)
	ld      de, $0040
	xor     a
	sbc     hl, de
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     

LABEL_B28_9294:
	ld      l, (ix+$16)
	ld      h, (ix+$17)
	ld      de, $0060
	xor     a
	sbc     hl, de
	ld      (ix+$16), l
	ld      (ix+$17), h
	ret     

LABEL_B28_92A7:
	ld      a, (ix+$1f)
	cp      $10
	ret     nc
	call    LABEL_200 + $3
	ret     c
	ld      (iy+$00), $41
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	ld      (iy+$11), l
	ld      (iy+$12), h
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	ld      (iy+$14), l
	ld      (iy+$15), h
	ld      a, (ix+$04)
	and     $10
	ld      (iy+$04), a
	ld      a, (ix+$08)
	ld      (iy+$08), a
	ld      a, (ix+$09)
	ld      (iy+$09), a
	ld      a, (CurrentLevel)
	rlca    
	rlca    
	rlca    
	rlca    
	add     a, (ix+$1f)
	inc     (ix+$1f)
	ld      e, a
	ld      d, $00
	ld      hl, $92fa
	add     hl, de
	ld      a, (hl)
	ld      (iy+$3f), a
	ret     

DATA_B28_92FA:
.db $01, $02, $01, $02, $01, $02, $01, $02
.db $01, $02, $01, $02, $01, $02, $01, $02
.db $03, $04, $03, $04, $03, $04, $03, $04
.db $03, $04, $03, $04, $03, $04, $03, $04
.db $05, $06, $05, $06, $05, $06, $05, $06
.db $05, $06, $05, $06, $05, $06, $05, $06
.db $07, $08, $07, $08, $07, $08, $07, $08
.db $07, $08, $07, $08, $07, $08, $07, $08
.db $09, $0A, $09, $0A, $09, $0A, $09, $0A
.db $09, $0A, $09, $0A, $09, $0A, $09, $0A
.db $0B, $0C, $0B, $0C, $0B, $0C, $0B, $0C
.db $0B, $0C, $0B, $0C, $0B, $0C, $0B, $0C
.db $09, $0A, $09, $0A, $09, $0A, $09, $0A
.db $09, $0A, $09, $0A, $09, $0A, $09, $0A

DATA_B28_936A:
.dw DATA_B28_9370
.dw DATA_B28_9376
.dw DATA_B28_937E

DATA_B28_9370:
.db $01, $00
	.dw LABEL_B28_938C
.db $FF, $00

DATA_B28_9376
.db $FF, $07
	.dw LABEL_B28_9391
	.dw LABEL_B28_93AE
.db $FF, $00

DATA_B28_937E:
.db $FF, $07
	.dw LABEL_B28_9391
	.dw LABEL_B28_93D9
.db $FF, $07
	.dw LABEL_B28_939F
	.dw LABEL_B28_93D9
.db $FF, $00


LABEL_B28_938C:
	ld      (ix+$02), $01
	ret     

LABEL_B28_9391:
	ld      (ix+$07), $05
	ld      a, (ix+$3F)
	dec     a
	add     a, a
	inc     a
	ld      (ix+$06), a
	ret

LABEL_B28_939F:
	ld      (ix+$07), $05
	ld      a, (ix+$3F)
	dec     a
	add     a, a
	inc     a
	inc     a
	ld      (ix+$06), a
	ret

LABEL_B28_93AE:
	ld      de, $0020
	ld      bc, $0400
	call    LABEL_200 + $0F
	call    LABEL_200 + $57
	ld      bc, $0000
	ld      de, $0000
	call    LABEL_200 + $63
	cp      $00
	ret     z
	ld      (ix+$02), $02
	ld      a, (ix+$3f)
	ld      d, $fe
	and     $01
	jr      z, +
	ld      d, $02
+:	ld      (ix+$17), d
	ret     

LABEL_B28_93D9:
	bit     6, (ix+$04)
	jp      nz, LABEL_B28_9414
	ld      de, $0040
	ld      bc, $0600
	call    LABEL_200 + $0F
	call    LABEL_200 + $57
	ld      bc, $0000
	ld      de, $0000
	call    LABEL_200 + $63
	cp      $00
	ret     z
	ld      l, (ix+$18)
	ld      h, (ix+$19)
	bit     7, h
	ret     nz
	ex      de, hl
	ld      hl, $0040
	xor     a
	sbc     hl, de
	jr      c, +
	ld      hl, $0000
+:	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     

LABEL_B28_9414:
	ld      (ix+$00), $ff
	ret     

DATA_B28_9419:
.dw DATA_B28_9431
.dw DATA_B28_9440
.dw DATA_B28_9446
.dw DATA_B28_94A7
.dw DATA_B28_951D
.dw DATA_B28_959A
.dw DATA_B28_95A0
.dw DATA_B28_95AA
.dw DATA_B28_95B4
.dw DATA_B28_95BE
.dw DATA_B28_95DE
.dw DATA_B28_95E8

DATA_B28_9431:
.db $FF, $09
	.db $09
.db $FF, $08
	.db $16
.db $FF, $02
	.dw LABEL_B28_9632
.db $FF, $05
	.db $05
.db $FF, $03

DATA_B28_9440:
.db $20, $01
	.dw LABEL_B28_9663
.db $FF, $00

DATA_B28_9446:
.db $08, $05
	.dw LABEL_B28_9798
.db $FF, $09
	.db $A9
.db $08, $01
	.dw LABEL_B28_9798
.db $08, $07
	.dw LABEL_B28_9798
.db $FF, $09
	.db $A9
.db $08, $01
	.dw LABEL_B28_9798
.db $06, $08
	.dw LABEL_B28_9798
.db $06, $09
	.dw LABEL_B28_9798
.db $06, $0A
	.dw LABEL_B28_9798
.db $06, $0B
	.dw LABEL_B28_9798
.db $06, $0C
	.dw LABEL_B28_9798
.db $04, $0D
	.dw LABEL_B28_AC2B
.db $04, $0E
	.dw LABEL_B28_AC2B
.db $04, $0D
	.dw LABEL_B28_AC2B
.db $04, $0E
	.dw LABEL_B28_AC2B
.db $04, $0D
	.dw LABEL_B28_AC2B
.db $04, $0E
	.dw LABEL_B28_AC2B
.db $04, $0D
	.dw LABEL_B28_AC2B
.db $04, $0E
	.dw LABEL_B28_AC2B
.db $FF, $02
	.dw LABEL_200 + $3F
.db $FF, $04
	.dw $0040
	.dw $0000
.db $FF, $02
	.dw LABEL_B28_9518
.db $FF, $05
	.db $06
.db $08, $0C
	.dw LABEL_B28_97B4
.db $FF, $00

DATA_B28_94A7:
.db $08, $01
	.dw LABEL_B28_9798
.db $08, $02
	.dw LABEL_B28_9798
.db $08, $03
	.dw LABEL_B28_9798
.db $08, $04
	.dw LABEL_B28_9798
.db $08, $05
	.dw LABEL_B28_9798
.db $FF, $09
	.db $A9
.db $08, $01
	.dw LABEL_B28_9798
.db $08, $07
	.dw LABEL_B28_9798
.db $FF, $09
	.db $A9
.db $08, $01
	.dw LABEL_B28_9798
.db $06, $08
	.dw LABEL_B28_9798
.db $06, $09
	.dw LABEL_B28_9798
.db $06, $0A
	.dw LABEL_B28_9798
.db $06, $0B
	.dw LABEL_B28_9798
.db $06, $0C
	.dw LABEL_B28_9798
.db $04, $0D
	.dw LABEL_B28_AC2B
.db $04, $0E
	.dw LABEL_B28_AC2B
.db $04, $0D
	.dw LABEL_B28_AC2B
.db $04, $0E
	.dw LABEL_B28_AC2B
.db $04, $0D
	.dw LABEL_B28_AC2B
.db $04, $0E
	.dw LABEL_B28_AC2B
.db $04, $0D
	.dw LABEL_B28_AC2B
.db $04, $0E
	.dw LABEL_B28_AC2B
.db $FF, $02
	.dw LABEL_200 + $3F
.db $FF, $04
	.dw $0040
	.dw $0200
.db $FF, $02
	.dw LABEL_B28_9518
.db $FF, $05
	.db $07
.db $08, $0C
	.dw LABEL_B28_97B4
.db $FF, $00


LABEL_B28_9518:  
	res     4, (ix+$04)
	ret     

DATA_B28_951D:
.db $06, $01
	.dw LABEL_B28_9798
.db $06, $02
	.dw LABEL_B28_9798
.db $06, $03
	.dw LABEL_B28_9798
.db $06, $01
	.dw LABEL_B28_9798
.db $06, $02
	.dw LABEL_B28_9798
.db $06, $03
	.dw LABEL_B28_9798
.db $06, $04
	.dw LABEL_B28_9798
.db $08, $05
	.dw LABEL_B28_9798
.db $FF, $09
	.db $A9
.db $08, $01
	.dw LABEL_B28_9798
.db $08, $07
	.dw LABEL_B28_9798
.db $FF, $09
	.db $A9
.db $08, $01
	.dw LABEL_B28_9798
.db $06, $08
	.dw LABEL_B28_9798
.db $06, $09
	.dw LABEL_B28_9798
.db $06, $0A
	.dw LABEL_B28_9798
.db $06, $0B
	.dw LABEL_B28_9798
.db $06, $0C
	.dw LABEL_B28_9798
.db $04, $0D
	.dw LABEL_B28_AC2B
.db $04, $0E
	.dw LABEL_B28_AC2B
.db $04, $0D
	.dw LABEL_B28_AC2B
.db $04, $0E
	.dw LABEL_B28_AC2B
.db $04, $0D
	.dw LABEL_B28_AC2B
.db $04, $0E
	.dw LABEL_B28_AC2B
.db $04, $0D
	.dw LABEL_B28_AC2B
.db $04, $0E
	.dw LABEL_B28_AC2B
.db $FF, $02
	.dw LABEL_200 + $3F
.db $FF, $04
	.dw $0200
	.dw $FC00
.db $FF, $02
	.dw LABEL_B28_9518
.db $FF, $05
	.db $08
.db $08, $0C
	.dw LABEL_B28_97B4
.db $FF, $00

DATA_B28_959A:
.db $20, $01
	.dw LABEL_B28_963C
.db $FF, $00

DATA_B28_95A0:
.db $04, $0D
	.dw LABEL_B28_96CC
.db $04, $0E
	.dw LABEL_B28_96CC
.db $FF, $00

DATA_B28_95AA:
.db $04, $0D
	.dw LABEL_B28_96CC
.db $04, $0E
	.dw LABEL_B28_96CC
.db $FF, $00

DATA_B28_95B4:
.db $04, $0D
	.dw LABEL_B28_968D
.db $04, $0E
	.dw LABEL_B28_968D
.db $FF, $00

DATA_B28_95BE:
.db $FF, $02
	.dw LABEL_B28_9842
.db $FF, $09
	.db $AB
.db $04, $0D
	.dw LABEL_B28_9732
.db $04, $0E
	.dw LABEL_B28_9732
.db $04, $0D
	.dw LABEL_B28_9732
.db $04, $0E
	.dw LABEL_B28_9732
.db $FF, $05
	.db $0A
.db $04, $0E
	.dw LABEL_B28_9732
.db $FF, $00

DATA_B28_95DE:
.db $04, $0D
	.dw LABEL_B28_9732
.db $04, $0E
	.dw LABEL_B28_9732
.db $FF, $00

DATA_B28_95E8:
.db $FF, $02
	.dw VF_Score_AddBossValue
.db $08, $01
	.dw VF_DoNothing
.db $FF, $06
	.db $0F
	.dw $0008
	.dw $FFFC
	.db $05
.db $08, $01
	.dw VF_DoNothing
.db $FF, $06
	.db $0F
	.dw $FFF8
	.dw $FFFA
	.db $05
.db $08, $01
	.dw VF_DoNothing
.db $FF, $06
	.db $0F
	.dw $0004
	.dw $FFF8
	.db $05
.db $08, $01
	.dw VF_DoNothing
.db $FF, $06,
	.db $0F
	.dw $FFFC
	.dw $FFF6
	.db $05
.db $08, $01
	.dw VF_DoNothing
.db $FF, $06
	.db $0F
	.dw $0000
	.dw $FFF0
	.db $05
.db $E0, $00
	.dw VF_DoNothing
.db $08, $00
	.dw UGZ3_Pincers_State_03_Logic_01
.db $FF, $00

 
LABEL_B28_9632:
	ld      a, $ff
	ld      ($d4a2), a
	ld      (ix+$24), $08
	ret     

LABEL_B28_963C:
	call    LABEL_200 + $0102
	ld      de, ($D174)
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	xor     a
	sbc     hl, de
	jr      c, +
	ld      a, h
	or      a
	ret     nz
	ld      a, l
	cp      $e0
	ret     nc
+:	ld      (ix+$02), $01
	ld      bc, $11f8
	ld      de, $0090
	call    LABEL_200 + $F6
	ret

LABEL_B28_9663:
	ld      a, ($d2b9)
	and     $03
	add     a, a
	add     a, a
	ld      b, a
	ld      a, ($d511)
	and     $03
	add     a, b
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B28_967D
	add     hl, de
	ld      a, (hl)
	ld      (ix+$02), a
	ret


DATA_B28_967D:
.db $02, $03, $04, $03, $03, $04, $02, $04
.db $04, $02, $04, $03, $02, $04, $03, $02

LABEL_B28_968D:
	ld      de, $0018
	ld      bc, $0400
	call    LABEL_200 + $0F
	call    LABEL_200 + $60
	bit     7, (ix+$19)
	jr      nz, LABEL_B28_96B1
	bit     1, (ix+$22)
	jr      z, LABEL_B28_96B1
	ld      hl, $0100
	ld      (ix+$18), l
	ld      (ix+$19), h
	jp      LABEL_B28_96D2

LABEL_B28_96B1:
	call    LABEL_B28_AC2B
	call    LABEL_200 + $57
	call    LABEL_B28_974D
	ret     nc
	ld      hl, $0000
	ld      (ix+$16), l
	ld      (ix+$17), h
	bit     1, (ix+$22)
	ret     z
	jp      LABEL_B28_9706

LABEL_B28_96CC:
	call    LABEL_200 + $60
	call    LABEL_B28_AC2B
LABEL_B28_96D2:
	ld      a, (ix+$17)
	bit     7, a
	jr      z, +
	neg     
+:	cp      $04
	jr      nc, +
	ld      l, (ix+$16)
	ld      h, (ix+$17)
	ld      e, l
	ld      d, h
	ld      l, h
	ld      a, h
	and     $80
	rlca    
	neg     
	ld      h, a
	inc     a
	add     a, l
	ld      l, a
	add     hl, hl
	add     hl, hl
	add     hl, hl
	add     hl, de
	ld      (ix+$16), l
	ld      (ix+$17), h
+:	call    LABEL_200 + $57
	call    LABEL_B28_974D
	ret     nc
	jp      LABEL_B28_9706

LABEL_B28_9706:
	ld      hl, $fc00
	ld      (ix+$18), l
	ld      (ix+$19), h
	ld      hl, ($d174)
	ld      de, $0080
	add     hl, de
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	ld      bc, $ffc0
	jr      c, +
	ld      bc, $0040
+:	ld      (ix+$16), c
	ld      (ix+$17), b
	ld      (ix+$02), $09
	ret     

LABEL_B28_9732:
	call    LABEL_B28_AC2B
	call    LABEL_200 + $57
	ld      de, $0040
	ld      bc, $0600
	call    LABEL_200 + $0F
	ld      hl, $02c0
	call    LABEL_200 + $12
	ret     nc
	ld      (ix+$02), $01
	ret     

LABEL_B28_974D:
	ld      de, ($d174)
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_977F
	ld      a, h
	or      a
	jr      nz, LABEL_B28_9790
	ld      a, l
	cp      $20
	jr      c, LABEL_B28_977F
	cp      $f0
	jr      nc, LABEL_B28_9790
	ld      e, (ix+$16)
	ld      d, (ix+$17)
	ld      l, (ix+$18)
	ld      a, (ix+$19)
	or      l
	or      e
	or      d
	jp      z, LABEL_B28_977D
	xor     a
	ret     

LABEL_B28_977D:
	scf     
	ret     

LABEL_B28_977F:
	ld      e, (ix+$16)
	ld      a, (ix+$17)
	or      e
	jr      z, +
	xor     a
	bit     7, (ix+$17)
	ret     z
+:	scf     
	ret     

LABEL_B28_9790:
	xor     a
	bit     7, (ix+$17)
	ret     nz
	scf     
	ret     

LABEL_B28_9798:
	call    LABEL_B28_97B4
	ld      hl, $0000
	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      hl, $0100
	ld      (ix+$18), l
	ld      (ix+$19), h
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	ret     

LABEL_B28_97B4:
	call    LABEL_200 + $24
	ld      a, (ix+$24)
	or      a
	ret     nz
	ld      (ix+$02), $0b
	ret

DATA_B28_97C1:
.dw DATA_B28_97D5
.dw DATA_B28_97E2
.dw DATA_B28_97E8
.dw DATA_B28_97FA
.dw DATA_B28_9848
.dw DATA_B28_984E
.dw DATA_B28_98B2
.dw DATA_B28_98C4
.dw DATA_B28_98CA
.dw DATA_B28_98D0

DATA_B28_97D5:
.db $FF, $02 
	.dw LABEL_B28_98DF
.db $FF $05
	.db $08
.db $02, $00
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_97E2:
.db $20, $01
	.dw LABEL_B28_9900
.db $FF, $00

DATA_B28_97E8:
.db $04, $01
	.dw LABEL_B28_9938
.db $04, $02
	.dw LABEL_B28_9938
.db $04, $03
	.dw LABEL_B28_9938
.db $04, $04
	.dw LABEL_B28_9938
.db $FF, $00

DATA_B28_97FA:
.db $FF, $04
	.dw $0000
	.dw $0000
.db $08, $06
	.dw LABEL_B28_99E2
.db $FF, $06
	.db $45
	.dw $0000
	.dw $0000
	.db $00
.db $FF, $06
	.db $45
	.dw $0000
	.dw $0000
	.db $01
.db $FF, $06
	.db $45
	.dw $0000
	.dw $0000
	.db $02
.db $08, $07
	.dw LABEL_B28_99E2
.db $08, $06
	.dw LABEL_B28_99E2
.db $08, $07
	.dw LABEL_B28_99E2
.db $08, $06
	.dw LABEL_B28_99E2
.db $08, $07
	.dw LABEL_B28_99E2
.db $08, $06
	.dw LABEL_B28_99E2
.db $08, $05
	.dw LABEL_B28_99E2
.db $FF, $02
	.dw LABEL_B28_9A01
.db $80, $02
	.dw LABEL_B28_99E2
.db $FF, $00

LABEL_B28_9842:
	ld		a, $40
	ld		($D290), a
	ret

DATA_B28_9848:
.db $08, $05
	.dw LABEL_B28_9A2A
.db $FF, $00

DATA_B28_984E:
.db $FF, $02
	.dw LABEL_200 + $011A
.db $FF, $04
	.dw $0000
	.dw $0000
.db $08, $06
	.dw VF_DoNothing
.db $08, $07
	.dw VF_DoNothing
.db $08, $06
	.dw VF_DoNothing
.db $08, $07
	.dw VF_DoNothing
.db $08, $06
	.dw VF_DoNothing
.db $08, $07
	.dw VF_DoNothing
.db $FF, $06
	.db $0F
	.dw $000C
	.dw $FFFC
	.db $05
.db $08, $07
	.dw VF_DoNothing
.db $FF, $06
	.db $0F
	.dw $FFF4
	.dw $FFFC
	.db $05
.db $08, $06
	.dw VF_DoNothing
.db $FF, $06
	.db $0F
	.dw $0004
	.dw $FFF8
	.db $05
.db $08, $07
	.dw VF_DoNothing
.db $FF, $06
	.db $0F
	.dw $FFFC
	.dw $FFF8
	.db $05
.db $08, $06
	.dw VF_DoNothing
.db $FF, $06
	.db $0F
	.dw $0000
	.dw $FFF4
	.db $05
.db $E0, $00
	.dw VF_DoNothing
.db $08, $00
	.dw LABEL_B28_9A49
.db $FF, $00

DATA_B28_98B2:
.db $02, $01
	.dw LABEL_B28_9A51
.db $02, $02
	.dw LABEL_B28_9A51
.db $02, $03
	.dw LABEL_B28_9A51
.db $02, $04
	.dw LABEL_B28_9A51
.db $FF, $00

DATA_B28_98C4:
.db $01, $04
	.dw LABEL_B28_9A67
.db $FF, $00

DATA_B28_98CA:
.db $E0, $01
	.dw LABEL_B28_98E9
.db $FF, $00

DATA_B28_98D0:
.db $FF, $08
	.db $13
.db $FF, $09
	.db $09
.db $FF, $05
	.db $01
.db $20, $01
	.dw VF_DoNothing
.db $FF, $00

LABEL_B28_98DF:
	ld      a, $ff
	ld      ($d4a2), a
	ld      (ix+$24), $08
	ret     

LABEL_B28_98E9:
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	ld      de, $0010
	add     hl, de
	ld      de, ($d514)
	xor     a
	sbc     hl, de
	ret     c
	ld      (ix+$02), $09
	ret     

LABEL_B28_9900:
	call    LABEL_200 + $102
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	ld      de, $0010
	add     hl, de
	ld      de, ($d514)
	xor     a
	sbc     hl, de
	ret     c
	ld      de, ($d174)
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	xor     a
	sbc     hl, de
	jr      c, +
	ld      a, h
	or      a
	ret     nz
	ld      a, l
	cp      $e0
	ret     nc
+:	call    LABEL_B28_9A01
	ld      bc, $0221
	ld      de, $0048
	call    LABEL_200 + $F6
	ret     

LABEL_B28_9938:
	xor     a
	ld      (ix+$18), a
	ld      (ix+$19), a
	call    LABEL_200 + $1B
	call    LABEL_B28_9A7E
	bit     7, (ix+$17)
	jr      nz, LABEL_B28_9954
	bit     2, (ix+$21)
	jp      nz, LABEL_B28_99AD
	jr      LABEL_B28_9954

LABEL_B28_9954:
	bit     3, (ix+$21)
	jp      nz, LABEL_B28_99AD
	ld      (ix+$21), $00
	call    LABEL_200 + $3C
	call    LABEL_200 + $57
	ld      l, (ix+$16)
	ld      h, (ix+$17)
	ld      e, l
	ld      d, h
	ld      l, h
	ld      a, h
	and     $80
	rlca    
	neg     
	ld      h, a
	inc     a
	add     a, l
	ld      l, a
	add     hl, hl
	add     hl, hl
	add     hl, hl
	add     hl, de
	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      de, ($d174)
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_99A6
	ld      a, h
	or      a
	jr      nz, LABEL_B28_999F
	ld      a, l
	cp      $20
	jr      c, LABEL_B28_99A6
	cp      $e8
	jr      nc, LABEL_B28_999F
	ret     

LABEL_B28_999F:
	bit     7, (ix+$17)
	ret     nz
	jr      LABEL_B28_99AD

LABEL_B28_99A6:
	bit     7, (ix+$17)
	ret     z
	jr      LABEL_B28_99AD


LABEL_B28_99AD:
	ld      e, (ix+$16)
	ld      d, (ix+$17)
	ld      hl, $0000
	xor     a
	sbc     hl, de
	ld      a, l
	sra     h
	rra     
	sra     h
	rra     
	sra     h
	rra     
	sra     h
	rra     
	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      hl, $fc00
	ld      (ix+$18), l
	ld      (ix+$19), h
	call    LABEL_B28_9842
	ld      a, $aa
	ld      ($dd04), a
	ld      (ix+$02), $04
	ret     

LABEL_B28_99E2:
	call    LABEL_200 + $24
	call    LABEL_200 + $27
	ld      a, (ix+$24)
	or      a
	jr      z, LABEL_B28_99FC
	ld      a, (ix+$1f)
	or      a
	ret     z
	set     5, (ix+$04)
	ld      (ix+$02), $07
	ret     

LABEL_B28_99FC:
	ld      (ix+$02), $05
	ret     

LABEL_B28_9A01:
	ld      hl, ($d174)
	ld      de, $0080
	add     hl, de
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	rla     
	rlca    
	dec     a
	neg     
	ld      (ix+$16), a
	and     $80
	rlca    
	neg     
	ld      (ix+$17), a
	ld      (ix+$0a), $40
	ld      (ix+$02), $06
	ret

LABEL_B28_9A2A:
	call    LABEL_200 + $18
	ld      (ix+$21), $00
	call    LABEL_200 + $57
	ld      de, $0040
	ld      bc, $0600
	call    LABEL_200 +$0F
	ld      hl, $0300
	call    LABEL_200 + $12
	ret     nc
	ld      (ix+$02), $03
	ret

LABEL_B28_9A49:
	call    LABEL_200 + $F3
	ld      (ix+$00), $fe
	ret

LABEL_B28_9A51:
	call    LABEL_200 + $3C
	call    LABEL_200 + $1B
	call    LABEL_B28_9A7E
	ld      (ix+$21), $00
	dec     (ix+$0a)
	ret     nz
	ld      (ix+$02), $02
	ret     

LABEL_B28_9A67:
	call    LABEL_200 + $18
	ld      (ix+$21), $00
	dec     (ix+$1f)
	ret     nz
	res     5, (ix+$04)
	res     7, (ix+$04)
	call    LABEL_B28_9A01
	ret     

LABEL_B28_9A7E:
	ld      a, (ix+$21)
	and     $03
	ret     z
	ld      a, $FF
	ld      ($d3a8), a
	ret     

DATA_B28_9A8A:
.dw DATA_B28_9A8E
.dw DATA_B28_9A97

DATA_B28_9A8E:
.db $01, $00
	.dw LABEL_B28_9AA1
.db $FF, $05
	.db $01
.db $FF, $03

DATA_B28_9A97:
.db $08, $01
	.dw LABEL_B28_9ADD
.db $08, $02
	.dw LABEL_B28_9ADD
.db $FF, $00


LABEL_B28_9AA1:
	ld      hl, ($d176)
	ld      (ix+$14), l
	ld      (ix+$15), h
	ld      a, (ix+$3f)
	add     a, a
	add     a, a
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B28_9AD1
	add     hl, de
	ld      e, (hl)
	inc     hl
	ld      d, (hl)
	ex      de, hl
	ld      bc, ($d511)
	add     hl, bc
	ld      (ix+$11), l
	ld      (ix+$12), h
	ex      de, hl
	inc     hl
	ld      e, (hl)
	inc     hl
	ld      d, (hl)
	ld      (ix+$18), e
	ld      (ix+$19), d
	ret     

DATA_B28_9AD1:
.db $30, $00, $40, $01, $D0, $FF, $40, $01, $00, $00, $C0, $00


LABEL_B28_9ADD:
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_9B0B
	ld      de, $0004
	ld      bc, $0600
	call    LABEL_200 + $0F
	call    LABEL_200 + $57
	ld      hl, ($d176)
	ld      de, $00c0
	add     hl, de
	ld      e, (ix+$14)
	ld      d, (ix+$15)
	xor     a
	sbc     hl, de
	ret     nc
	ret     z
	ld      (ix+$00), $ff
	ret

LABEL_B28_9B0B:
	ld      a, $ff
	ld      ($d3a8), a
	ld      (ix+$00), $ff
	ret     

DATA_B28_9B15:
.dw DATA_B28_9B1B
.dw DATA_B28_9B26
.dw DATA_B28_9B2E

DATA_B28_9B1B:
.db $FF, $04
	.dw $0000
	.dw $F400
.db $FF, $05
	.db $01
.db $FF, $03

DATA_B28_9B26:
.db $FF, $07
	.dw LABEL_B28_9B42
	.dw LABEL_B28_9B63
.db $FF, $00

DATA_B28_9B2E:
.db $FF, $07
	.dw LABEL_B28_9B42
	.dw LABEL_B28_9B79
.db $FF, $07
	.dw LABEL_B28_9B49
	.dw LABEL_B28_9B79
.db $FF, $07
	.dw LABEL_B28_9B50
	.dw LABEL_B28_9B79
.db $FF, $00

LABEL_B28_9B42:
	ld      b, $01
	ld      c, $04
	jp      LABEL_B28_9B54

LABEL_B28_9B49:
	ld      b, $02
	ld      c, $05
	jp      LABEL_B28_9B54

LABEL_B28_9B50:
	ld      b, $03
	ld      c, $06
LABEL_B28_9B54:
	bit     7, (ix+$17)
	jr      z, +
	ld      b, c
+:	ld      (ix+$06), b
	ld      (ix+$07), $04
	ret     

LABEL_B28_9B63:
	call    LABEL_200 + $57
	ld      de, $0080
	ld      bc, $0600
	call    LABEL_200 + $0F
	bit     7, (ix+$19)
	ret     nz
	ld      (ix+$02), $02
	ret     

LABEL_B28_9B79:
	ld      a, ($d46a)
	or      a
	jp      nz, LABEL_B28_9BD5
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      de, $0020
	ld      bc, $0600
	call    LABEL_200 + $0F
	ld      hl, $0200
	call    LABEL_200 + $12
	jp      nz, ++
	ld      hl, ($d511)
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	ld      bc, $0080
	xor     a
	sbc     hl, de
	jr      nc, +
	ld      bc, $ff80
+:	ld      (ix+$16), c
	ld      (ix+$17), b
	ld      h, (ix+$19)
	ld      l, (ix+$18)
	ld      de, $fd00
	xor     a
	sbc     hl, de
	jr      nc, ++
	ld      (ix+$19), d
	ld      (ix+$18), e
++:	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      a, ($d503)
	bit     1, a
	ret     z
	call    LABEL_B28_9E5D
LABEL_B28_9BD5:
	call    LABEL_200 + $117
	jp      LABEL_200 + $5D

DATA_B28_9BDB:
.dw DATA_B28_9BE1
.dw DATA_B28_9BE7
.dw DATA_B28_9BF9

DATA_B28_9BE1:
.db $FF, $02
	.dw LABEL_B28_9BFF
.db $FF, $03

DATA_B28_9BE7:
.db $60, $01
	.dw LABEL_B28_9C13
.db $FF, $06
	.db $46
	.dw $0000
	.dw $FFF8
	.db $00
.db $C0, $01
	.dw LABEL_B28_9C13
.db $FF, $00

DATA_B28_9BF9:
.db $E0, $01
	.dw LABEL_B28_9C2B
.db $FF, $00


LABEL_B28_9BFF:
	ld      a, (ix+$3f)
	or      a
	jr      nz, LABEL_B28_9C0E
	ld      (ix+$02), $01
	set     7, (ix+$03)
	ret     

LABEL_B28_9C0E:
	ld      (ix+$02), $02
	ret     

LABEL_B28_9C13:
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0F
	ret     z
	ld      a, ($d503)
	bit     1, a
	ret     z
	call    LABEL_B28_9E5D
	call    LABEL_200 + $117
	jp      LABEL_200 + $5D

LABEL_B28_9C2B:
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      de, $0010
	ld      bc, $0600
	call    LABEL_200 + $0F
	bit     6, (ix+$04)
	ret     z
	ld      (ix+$00), $ff
	ret     

DATA_B28_9C44:
.dw DATA_B28_9C5E
.dw DATA_B28_9C67
.dw DATA_B28_9C6D
.dw DATA_B28_9CB9
.dw DATA_B28_9CBF
.dw DATA_B28_9D04
.dw DATA_B28_9D0A
.dw DATA_B28_9D18
.dw DATA_B28_9D65
.dw DATA_B28_9D6B
.dw DATA_B28_9D92
.dw DATA_B28_9DC8
.dw DATA_B28_9DD2

DATA_B28_9C5E:
.db $FF, $09
	.db $09
.db $FF, $02
	.dw LABEL_B28_9E74
.db $FF, $03

DATA_B28_9C67:
.db $E0, $00
	.dw LABEL_B28_9E95
.db $FF, $00

DATA_B28_9C6D:
.db $FF, $08
	.db $14
.db $40, $00
	.dw VF_DoNothing
.db $FF, $06
	.db $36
	.dw $0060
	.dw $FF30
	.db $01
.db $FF, $02
	.dw LABEL_B28_9E46
.db $10, $00
	.dw VF_DoNothing
.db $FF, $06
	.db $36
	.dw $0040
	.dw $FF30
	.db $00
.db $FF, $02
	.dw LABEL_B28_9E46
.db $10, $00
	.dw VF_DoNothing
.db $FF, $06
	.db $36
	.dw $FFA0
	.dw $FF30
	.db $00
.db $FF, $02
	.dw LABEL_B28_9E46
.db $10, $00
	.dw VF_DoNothing
.db $FF, $06
	.db $36
	.dw $FFC0
	.dw $FF30
	.db $00
.db $FF, $02
	.dw LABEL_B28_9E46
.db $FF, $05
	.db $03
.db $10, $00
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_9CB9:
.db $10, $00
	.dw LABEL_B28_9EB0
.db $FF, $00

DATA_B28_9CBF:
.db $FF, $06
	.db $46
	.dw $0050
	.dw $FF30
	.db $00
.db $FF, $02
	.dw LABEL_B28_9E46
.db $10, $00
	.dw VF_DoNothing
.db $FF, $06
	.db $46
	.dw $0030
	.dw $FF30
	.db $00
.db $FF, $02
	.dw LABEL_B28_9E46
.db $10, $00
	.dw VF_DoNothing
.db $FF, $06
	.db  $46
	.dw $FFE0
	.dw $FF30
	.db $00
.db $FF, $02
	.dw LABEL_B28_9E46
.db $10, $00
	.dw VF_DoNothing
.db $FF, $06
	.db $46
	.dw $FF90
	.dw $FF30
	.db $00
.db $FF, $02
	.dw LABEL_B28_9E46
.db $FF, $05
	.db $05
.db $10, $00
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_9D04:
.db $10, $00
	.dw LABEL_B28_9EB0
.db $FF, $00

DATA_B28_9D0A:
.db $20, $00
	.dw VF_DoNothing
.db $10, $00
	.dw LABEL_B28_9EC8
.db $10, $00
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_9D18:
.db $02, $00
	.dw VF_DoNothing
.db $FF, $06
	.db $47
	.dw $0050
	.dw $FFF4
	.db $00
.db $FF, $02
	.dw LABEL_B28_9E46
.db $08, $00
	.dw VF_DoNothing
.db $FF, $06
	.db $47
	.dw $0030
	.dw $FFF4
	.db $00
.db  $FF, $02
	.dw LABEL_B28_9E46
.db $10, $00
	.dw VF_DoNothing
.db $FF, $06
	.db $47
	.dw $FFD0
	.dw $FFF4
	.db $00
.db $FF, $02
	.dw LABEL_B28_9E46
.db $08, $00
	.dw VF_DoNothing
.db $FF, $06
	.db $47
	.dw $FF90
	.dw $FFF4
	.db $00
.db $FF, $02
	.dw LABEL_B28_9E46
.db $80, $00
	.dw VF_DoNothing
.db $FF, $05
	.db $08
.db $10, $00
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_9D65:
.db $10, $00
	.dw LABEL_B28_9EB0
.db $FF, $00

DATA_B28_9D6B:
.db $FF, $02
	.dw LABEL_B28_9EDB
.db $FF, $04
	.dw $0000
	.dw $FF00
.db $08, $02
	.dw LABEL_200 + $57
.db $08, $05
	.dw LABEL_200 + $57
.db $08, $02
	.dw LABEL_200 + $57
.db $08, $05
	.dw LABEL_200 + $57
.db $08, $02
	.dw LABEL_200 + $57
.db $FF, $05
	.db $0A
.db $08, $05
	.dw LABEL_200 + $57
.db $FF, $00

DATA_B28_9D92:
.db $08, $02
	.dw LABEL_B28_9EEE
.db $08, $05
	.dw LABEL_B28_9EEE
.db $08, $02
	.dw LABEL_B28_9EEE
.db $08, $05
	.dw LABEL_B28_9EEE
.db $10, $01
	.dw LABEL_B28_9EEE
.db $10, $03
	.dw LABEL_B28_9EEE
.db $FF, $06
	.db $49
	.dw $0010
	.dw $FFD0
	.db $00
.db $10, $03
	.dw LABEL_B28_9EEE
.db $08, $02
	.dw LABEL_B28_9EEE
.db $08, $05
	.dw LABEL_B28_9EEE
.db $08, $02
	.dw LABEL_B28_9EEE
.db $08, $05
	.dw LABEL_B28_9EEE
.db $FF, $00

DATA_B28_9DC8:
.db $03, $04
	.dw LABEL_B28_9F31
.db $04, $06
	.dw LABEL_B28_9F31
.db $FF, $00

DATA_B28_9DD2:
.db $FF, $02
	.dw LABEL_200 + $11A
.db $03, $04
	.dw VF_DoNothing
.db $FF, $06
	.db $0F
	.dw $000C
	.dw $FFEC
	.db $05
.db $08, $06
	.dw VF_DoNothing
.db $FF, $06
	.db $0F
	.dw $FFF4
	.dw $FFE8
	.db $05
.db $08, $04
	.dw VF_DoNothing
.db $FF, $06
	.db $0F
	.dw $0004
	.dw $FFE6
	.db $05
.db $08, $06
	.dw VF_DoNothing
.db $FF, $06
	.db $0F
	.dw $FFFC
	.dw $FFE4
	.db $05
.db $08, $04
	.dw VF_DoNothing
.db $FF, $06
	.db $0F
	.dw $0000
	.dw $FFE0
	.db $05
.db $FF, $04
	.dw $0080
	.dw $0100
.db $40, $06
	.dw LABEL_200 + $57
.db $03, $04
	.dw LABEL_B28_9E3E
.db $FF, $00

DATA_B28_9EE2:
.db $03, $04
	.dw VF_DoNothing
.db $FF, $06
	.db $48
	.dw $0000
	.dw $0050
	.db $01
.db $FF, $04
	.dw $0100
	.dw $0000
.db $20, $06
	.dw LABEL_200 + $57
.db $03, $04
	.dw LABEL_B28_9E3E
.db $FF, $00

LABEL_B28_9E3E:
	ld      a, $ff
	ld      ($d46a), a
	jp      LABEL_B28_9F59

LABEL_B28_9E46:
	ld      b, $08
	ld      de, $D3BC
-:	ld      a, (de)
	or      a
	jr      z, LABEL_B28_9E53
	inc     de
	djnz    -
	ret     

LABEL_B28_9E53:
	push    iy
	pop     hl
	push    de
	call    LABEL_200 + $30
	pop     de
	ld      (de), a
	ret     

LABEL_B28_9E5D:
	push    ix
	pop     hl
	call    LABEL_200 + $30
	ld      c, a
	ld      b, $08
	ld      de, $d3bc
-:	ld      a, (de)
	cp      c
	jr      z, LABEL_B28_9E71
	inc     de
	djnz    -
	ret     

LABEL_B28_9E71:
	xor     a
	ld      (de), a
	ret     

LABEL_B28_9E74:
	ld      a, $ff
	ld      ($d4a2), a
	xor     a
	ld      ($d46a), a
	ld      a, (ix+$3f)
	or      a
	jr      nz, LABEL_B28_9E8C
	ld      (ix+$02), $01
	ld      (ix+$24), $06
	ret     

LABEL_B28_9E8C
	ld      (ix+$02), $0d
	ld      (ix+$24), $08
	ret     

LABEL_B28_9E95:
	ld      hl, ($d511)
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	ret     c
	ld      bc, $0814
	ld      de, $003e
	call    LABEL_200 + $F6
	ld      (ix+$02), $02
	ret     

LABEL_B28_9EB0:
	ld      b, $08
	ld      de, $d3bc
	ld      c, $00
-:	ld      a, (de)
	or      c
	ld      c, a
	inc     de
	djnz    -
	ld      a, c
	or      a
	ret     nz
	ld      a, (ix+$01)
	inc     a
	ld      (ix+$02), a
	ret     

LABEL_B28_9EC8:
	call    LABEL_200 + $F3
	ld      hl, ($D280)		;set max camera Y pos to min cam y pos
	ld      ($d282), hl
	ld      (ix+$02), $07
	ld      a, $26
	ld      ($d502), a
	ret     

LABEL_B28_9EDB:
	ld      hl, $0840
	ld      (ix+$11), l
	ld      (ix+$12), h
	ld      hl, $01f0
	ld      (ix+$14), l
	ld      (ix+$15), h
	ret     

LABEL_B28_9EEE:
	call    LABEL_200 + $57
	call    LABEL_B28_9F0A
	call    LABEL_200 + $1B
	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      (ix+$1f), $40
	set     5, (ix+$04)
	ld      (ix+$02), $0b
	ret     

LABEL_B28_9F0A:
	ld      hl, ($d511)
	ld      de, $ffc0
	add     hl, de
	ld      de, $0000
	ld      bc, $00c0
	call    LABEL_200 + $48
	inc     (ix+$1e)
	ld      bc, $0070
	ld      a, (ix+$1e)
	and     $40
	jr      nz, +
	ld      bc, $ff90
+:	ld      (ix+$18), c
	ld      (ix+$19), b
	ret     

LABEL_B28_9F31:
	call    LABEL_200 + $57
	call    LABEL_B28_9F0A
	call    LABEL_200 + $1B
	xor     a
	ld      (ix+$21), a
	dec     (ix+$1f)
	ret     nz
	res     5, (ix+$04)
	res     7, (ix+$04)
	dec     (ix+$24)
	jr      z, LABEL_B28_9F54
	ld      (ix+$02), $0a
	ret     

LABEL_B28_9F54
	ld      (ix+$02), $0c
	ret

LABEL_B28_9F59:
	ld      hl, $0b00
	ld      ($d282), hl
	call    LABEL_200 + $78
	ld      (ix+$00), $fe
	ret


DATA_B28_9F67:
.dw DATA_B28_9F6B
.dw DATA_B28_9F70

DATA_B28_9F6B:
.db $FF, $05
	.db $01
.db $FF, $03

DATA_B28_9F70:
.db $06, $01
	.dw LABEL_B28_9F7E
.db $06, $02
	.dw LABEL_B28_9F7E
.db $06, $03
	.dw LABEL_B28_9F7E
.db $FF, $00


LABEL_B28_9F7E:
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	jr      z, +
	ld      a, $ff
	ld      ($d3a8), a
+:	call    LABEL_200 + $57
	ld      hl, ($d514)
	ld      de, $ffe8
	ld      bc, $00c0
	call    LABEL_200 + $4B
	ld      bc, $0180
	ld      (ix+$16), c
	ld      (ix+$17), b
	ld      hl, ($D174)
	inc     h
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	ret     nc
	ld      (ix+$00), $ff
	ret     

DATA_B28_9FB8:
.dw DATA_B28_A0D8
.dw DATA_B28_A0E7
.dw DATA_B28_A0F1
.dw DATA_B28_A12D
.dw DATA_B28_A145
.dw DATA_B28_A15D
.dw DATA_B28_A197
.dw DATA_B28_A1A1
.dw DATA_B28_A1AB
.dw DATA_B28_A1B1

DATA_B28_9FCC:
.dw DATA_B28_9FD2
.dw DATA_B28_9FDB
.dw DATA_B28_9FE1

DATA_B28_9FD2:
.db $01, $00
	.dw LABEL_B28_9FE7
.db $FF, $05
	.db $01
.db $FF, $03

DATA_B28_9FDB:
.db $E0, $03
	.dw LABEL_B28_A00C
.db $FF, $00

DATA_B28_9FE1:
.db $E0, $03
	.dw LABEL_B28_A09C
.db $FF, $00

LABEL_B28_9FE7:
	push    ix
	pop     hl
	call    LABEL_200 + $30
	ld      ($d46b), a
	ld      hl, $0040
	bit     4, (ix+$04)
	jr      z, +
	ld      hl, $ffc0
+:	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      hl, $fc80
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     

LABEL_B28_A00C
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_200 + $5D
	call    LABEL_200 + $57
	ld      de, $0020
	ld      bc, $0600
	call    LABEL_200 + $0F
	bit     7, (ix+$19)
	ret     nz
	ld      a, ($d46a)
	call    LABEL_200 + $33
	push    hl
	pop     iy
	ld      l, (iy+$14)
	ld      h, (iy+$15)
	ld      de, $ffe0
	add     hl, de
	ld      e, (ix+$14)
	ld      d, (ix+$15)
	xor     a
	sbc     hl, de
	ret     nc
	ld      a, (iy+$01)
	cp      $03
	jr      z, LABEL_B28_A055
	ld      (iy+$02), $05
	ld      (ix+$00), $ff
	ret     

LABEL_B28_A055:
	ld      a, (iy+$0a)
	and     $01
	jr      nz, LABEL_B28_A07C
	ld      hl, $fe80
	ld      (ix+$18), l
	ld      (ix+$19), h
	ld      hl, $0380
	bit     4, (ix+$04)
	jr      z, +
	ld      hl, $fc80
+:	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      (ix+$02), $02
	ret     

LABEL_B28_A07C
	ld      hl, $fa80
	ld      (ix+$18), l
	ld      (ix+$19), h
	ld      hl, $0100
	bit     4, (ix+$04)
	jr      z, +
	ld      hl, $ff00
+:	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      (ix+$02), $02
	ret     

LABEL_B28_A09C:
	bit     6, (ix+$04)
	jr      z, LABEL_B28_A0A7
	ld      (ix+$00), $ff
	ret     

LABEL_B28_A0A7:
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	jp      z, LABEL_B28_A0BA
	ld      a, $ff
	ld      ($d3a8), a
	jp      LABEL_200 + $5D

LABEL_B28_A0BA:
	call    LABEL_200 + $57
	ld      de, $0050
	ld      bc, $0600
	call    LABEL_200 + $0F
	ld      hl, $0080
	call    LABEL_200 + $12
	ret     nz
	bit     6, (ix+$04)
	ret     nz
	ld      a, $a8
	ld      ($dd04), a
	ret     

DATA_B28_A0D8:
.db $FF, $09
	.db $09
.db $FF, $08
	.db $15
.db $FF, $02
	.dw LABEL_B28_A24F
.db $FF, $05
	.db $01
.db $FF, $03

DATA_B28_A0E7:
.db $08, $01
	.dw LABEL_B28_A262
.db $08, $02
	.dw LABEL_B28_A262
.db $FF, $00

DATA_B28_A0F1:
.db $FF, $02
	.dw LABEL_200 + $3F
.db $FF, $04
	.dw $0000
	.dw $0000
.db $FF, $02
	.dw LABEL_B28_A213
.db $20, $01
	.dw LABEL_200 + $1B
.db $20, $02
	.dw LABEL_200 + $1B
.db $FF, $02
	.dw LABEL_200 + $3F
.db $20, $03
	.dw LABEL_200 + $1B
.db $20, $08
	.dw LABEL_B28_A289
.db $FF, $02
	.dw LABEL_200 + $3F
.db $20, $09
	.dw LABEL_B28_A289
.db $FF, $06
	.db $4F
	.dw $0004
	.dw $FFE2
	.db $00
.db $FF, $02
	.dw LABEL_B28_A217
.db $01, $04
	.dw LABEL_200 + $1B
.db $FF, $00

DATA_B28_A12D:
.db $32, $04
	.dw LABEL_200 + $1B
.db $FF, $04
	.dw $0100
	.dw $FE00
.db $10, $01
	.dw LABEL_B28_A29C
.db $FF, $02
	.dw LABEL_B28_A225
.db $10, $01
	.dw LABEL_200 + $1B
.db $FF, $00

DATA_B28_A145:
.db $12, $04
	.dw LABEL_200 + $1B
.db $FF, $04
	.dw $0100
	.dw $FE00
.db $40, $01
	.dw LABEL_B28_A29C
.db $FF, $02
	.dw LABEL_B28_A225
.db $10, $01
	.dw LABEL_200 + $1B
.db $FF, $00

DATA_B28_A15D:
.db $FF, $06
	.db $0F
	.dw $0004
	.dw $FFE2
	.db $00
.db $10, $05
	.dw LABEL_200 + $18
.db $FF, $02
	.dw LABEL_B28_A236
.db $08, $06
	.dw LABEL_200 + $18
.db $08, $07
	.dw LABEL_200 + $18
.db $08, $06
	.dw LABEL_200 + $18
.db $08, $07
	.dw LABEL_200 + $18
.db $08, $06
	.dw LABEL_200 + $18
.db $08, $07
	.dw LABEL_200 + $18
.db $08, $06
	.dw LABEL_200 + $18
.db $10, $05
	.dw LABEL_200 + $18
.db $FF, $02
	.dw LABEL_B28_A225
.db $08, $05
	.dw LABEL_200 + $18
.db $FF, $00

DATA_B28_A197:
.db $08, $01
	.dw LABEL_B28_A2CA
.db $08, $02
	.dw LABEL_B28_A2CA
.db $FF, $00

DATA_B28_A1A1:
.db $08, $01
	.dw LABEL_B28_A33A
.db $08, $02
	.dw LABEL_B28_A33A
.db $FF, $00

DATA_B28_A1AB:
.db $08, $04
	.dw LABEL_B28_A35D
.db $FF, $00

DATA_B28_A1B1:
.db $FF, $02
	.dw LABEL_200 + $11A
.db $FF, $06
	.db $0F
	.dw $0004
	.dw $FFE2
	.db $00
.db $10, $05
	.dw LABEL_200 + $18
.db $08, $06
	.dw LABEL_200 + $18
.db $08, $07
	.dw LABEL_200 + $18
.db $FF, $06
	.db $0F
	.dw $000C
	.dw $FFFC
	.db $05
.db $08, $06
	.dw LABEL_200 + $18
.db $FF, $06
	.db $0F
	.dw $FFF4
	.dw $FFFC
	.db $05
.db $08, $07
	.dw LABEL_200 + $18
.db $FF, $06
	.db $0F
	.dw $0004
	.dw $FFF8
	.db $05
.db $08, $06
	.dw LABEL_200 + $18
.db $FF, $06
	.db $0F
	.dw $FFFC
	.dw $FFF8
	.db $05
.db $08, $07
	.dw LABEL_200 + $18
.db $FF, $06
	.db $0F
	.dw $0000
	.dw $FFF4
	.db $05
.db $08, $06
	.dw LABEL_200 + $18
.db $10, $05
	.dw LABEL_200 + $18
.db $E0, $00
	.dw VF_DoNothing
.db $08, $00
	.dw LABEL_B28_A247
.db $FF, $00

LABEL_B28_A213:
	inc     (ix+$0a)
	ret

LABEL_B28_A217:
	ld      b, $03
	ld      a, (ix+$0a)
	dec     a
	jr      nz, +
	ld      b, $04
+:	ld      (ix+$02), b
	ret     

LABEL_B28_A225:
	res     5, (ix+$04)
	res     7, (ix+$04)
	ld      (ix+$02), $06
	ld      (ix+$1e), $80
	ret     

LABEL_B28_A236:
	set     5, (ix+$04)
	dec     (ix+$24)
	ret     nz
	res     5, (ix+$04)
	ld      (ix+$02), $09
	ret     

LABEL_B28_A247:
	call    LABEL_200 + $F3
	ld      (ix+$00), $fe
	ret

LABEL_B28_A24F:
	ld      a, $ff
	ld      ($d4a2), a
	push    ix
	pop     hl
	call    LABEL_200 + $30
	ld      ($d46a), a
	ld      (ix+$24), $06
	ret

LABEL_B28_A262:
	call    LABEL_200 + $102
	ld      de, ($d174)
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	xor     a
	sbc     hl, de
	jr      c, +
	ld      a, h
	or      a
	ret     nz
	ld      a, l
	cp      $e0
	ret     nc
+:	ld      (ix+$02), $02
	ld      bc, $0d60
	ld      de, $0080
	call    LABEL_200 + $F6
	ret     

LABEL_B28_A289:
	call    LABEL_200 + $18
	ld      a, (ix+$21)
	and     $01
	jr      nz, LABEL_B28_A297
	call    LABEL_200 + $1E
	ret     

LABEL_B28_A297:
	ld      (ix+$02), $05
	ret     

LABEL_B28_A29C:
	call    LABEL_200 + $1B
	call    LABEL_200 + $57
	ld      de, $0080
	ld      bc, $0200
	call    LABEL_200 + $0F
	ld      bc, $0000
	ld      de, $0000
	call    LABEL_200 + $63
	cp      $00
	ret     z
	bit     7, (ix+$19)
	ret     nz
	xor     a
	ld      (ix+$16), a
	ld      (ix+$17), a
	ld      (ix+$18), a
	ld      (ix+$19), a
	ret     

LABEL_B28_A2CA:
	call    LABEL_200 + $1B
	call    LABEL_200 + $57
	call    LABEL_200 + $3F
	dec     (ix+$1e)
	jr      z, LABEL_B28_A335
	ld      hl, ($d511)
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	ld      (ix+$16), a
	ld      (ix+$17), a
	bit     4, (ix+$04)
	jr      nz, LABEL_B28_A303
	xor     a
	sbc     hl, de
	ld      a, h
	or      a
	ret     nz
	ld      a, l
	cp      $60
	jr      c, LABEL_B28_A319
	ld      hl, $0100
	ld      (ix+$16), l
	ld      (ix+$17), h
	ret

LABEL_B28_A303:
	ex      de, hl
	xor     a
	sbc     hl, de
	ld      a, h
	or      a
	ret     nz
	ld      a, l
	cp      $60
	jr      c, LABEL_B28_A319
	ld      hl, $ff00
	ld      (ix+$16), l
	ld      (ix+$17), h
	ret     

LABEL_B28_A319:
	ld      a, ($d501)
	cp      $0a
	ret     nz
	ld      hl, ($d514)
	ld      de, $0028
	add     hl, de
	ld      e, (ix+$14)
	ld      d, (ix+$15)
	xor     a
	sbc     hl, de
	ret     nc
	ld      (ix+$02), $07
	ret     

LABEL_B28_A335:
	ld      (ix+$02), $02
	ret     

LABEL_B28_A33A:
	ld      a, ($d501)
	cp      $0a
	jp      nz, LABEL_B28_A335
	ld      de, $fff8
	call    LABEL_200 + $45
	call    LABEL_200 + $57
	call    LABEL_200 + $18
	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      (ix+$02), $08
	ld      (ix+$1e), $08
	ret

LABEL_B28_A35D:
	ld      hl, ($d174)
	ld      de, $0080
	add     hl, de
	ex      de, hl
	call    LABEL_200 + $42
	ld      de, $fff8
	call    LABEL_200 + $45
	call    VF_Engine_UpdateObjectPosition
	call    LABEL_200 + $18
	ld      a, (ix+$21)
	and     $0f
	ret     z
	dec     (ix+$1e)
	ret     nz
	ld      (ix+$02), $02
	ld      a, $1b
	ld      ($d502), a
	ld      hl, $f900
	ld      ($d518), hl
	ld      hl, $0500
	bit     4, (ix+$04)
	jr      z, + 
	ld      hl, $fb00
+:	ld      ($d516), hl
	ret     

;************************************
;* Logic for UGZ3 Boss - Robotnik	*
;************************************
.include "src\object_logic\logic_ugz3_boss.asm"



DATA_B28_A813:
.dw DATA_B28_A837
.dw DATA_B28_A850
.dw DATA_B28_A856
.dw DATA_B28_A860
.dw DATA_B28_A885
.dw DATA_B28_A88F
.dw DATA_B28_A899
.dw DATA_B28_A8A2
.dw DATA_B28_A8AB
.dw DATA_B28_A8BB
.dw DATA_B28_A8C5
.dw DATA_B28_A8D5
.dw DATA_B28_A8DF
.dw DATA_B28_A8E8
.dw DATA_B28_A8F8
.dw DATA_B28_A902
.dw DATA_B28_A90C
.dw DATA_B28_A973

DATA_B28_A837:
.db $FF, $09
	.db $09
.db $FF, $08
	.db $18
.db $FF, $02
	.dw LABEL_B28_A846
.db $FF, $05
	.db $01
.db $FF, $03


LABEL_B28_A846:
	ld      a, $ff
	ld      ($d4a2), a
	ld      (ix+$24), $08
	ret     


DATA_B28_A850:
.db $E0, $01
	.dw LABEL_B28_A9E9
.db $FF, $00

DATA_B28_A856:
.db $10, $01
	.dw LABEL_B28_AC93
.db $02, $01
	.dw LABEL_B28_AA21
.db $FF, $00

DATA_B28_A860:
.db $08, $04
	.dw LABEL_B28_AC93
.db $04, $05
	.dw LABEL_B28_AC93
.db $04, $06
	.dw LABEL_B28_AC93
.db $04, $05
	.dw LABEL_B28_AC93
.db $04, $06
	.dw LABEL_B28_AC93
.db $04, $05
	.dw LABEL_B28_AC93
.db $04, $06
	.dw LABEL_B28_AC93
.db $08, $04
	.dw LABEL_B28_AC93
.db $FF, $05
	.db $02
.db $FF, $00

DATA_B28_A885:
.db $04, $08
	.dw LABEL_B28_AA9F
.db $04, $09
	.dw LABEL_B28_AA9F
.db $FF, $00

DATA_B28_A88F:
.db $04, $08
	.dw LABEL_B28_AACB
.db $04, $09
	.dw LABEL_B28_AACB
.db $FF, $00

DATA_B28_A899:
.db $08, $02
	.dw LABEL_B28_AC93
.db $FF, $05
	.db $0A
.db $FF, $00

DATA_B28_A8A2:
.db $08, $02
	.dw LABEL_B28_AC93
.db $FF, $05
	.db $0D
.db $FF, $00

DATA_B28_A8AB:
.db $FF, $04
	.dw $0600
	.dw $0000
.db $04, $0A
	.dw LABEL_B28_AAF7
.db $04, $0B
	.dw LABEL_B28_AAF7
.db $FF, $00

DATA_B28_A8BB:
.db $04, $08
	.dw LABEL_B28_AB23
.db $04, $09
	.dw LABEL_B28_AB23
.db $FF, $00

DATA_B28_A8C5:
.db $FF, $04
	.dw $0600
	.dw $0000
.db $02, $07
	.dw LABEL_B28_AB4F
.db $02, $0C
	.dw LABEL_B28_AB4F
.db $FF, $00

DATA_B28_A8D5:
.db $02, $07
	.dw LABEL_B28_AB66
.db $02, $0C
	.dw LABEL_B28_AB66
.db $FF, $00

DATA_B28_A8DF:
.db $10, $02
	.dw LABEL_B28_AC93
.db $FF, $05
	.db $02
.db $FF, $00

DATA_B28_A8E8:
.db $FF, $04
	.dw $0400
	.dw $0000
.db $02, $07
	.dw LABEL_B28_ABA9
.db $02, $0C
	.dw LABEL_B28_ABA9
.db $FF, $00

DATA_B28_A8F8:
.db $02, $07
	.dw LABEL_B28_ABB5
.db $02, $0C
	.dw LABEL_B28_ABB5
.db $FF, $00

DATA_B28_A902:
.db $02, $07
	.dw LABEL_B28_ABB5
.db $02, $0C
	.dw LABEL_B28_ABB5
.db $FF, $00

DATA_B28_A90C:
.db $FF, $02
	.dw LABEL_200 + $11D
.db $FF, $04
	.dw $0000
	.dw $FF80
.db $08, $08
	.dw LABEL_200 + $57
.db $08, $09
	.dw LABEL_200 + $57
.db $08, $08
	.dw LABEL_200 + $57
.db $08, $09
	.dw LABEL_200 + $57
.db $08, $08
	.dw LABEL_200 + $57
.db $08, $09
	.dw LABEL_200 + $57
.db $FF, $06
	.db $0F
	.dw $0006
	.dw $FFFC
	.db $05
.db $08, $08
	.dw LABEL_200  + $57
.db $FF, $06
	.db $0F
	.dw $FFFA
	.dw $FFFC
	.db $05
.db $08, $09
	.dw LABEL_200 + $57
.db $FF, $06
	.db $0F
	.dw $0004
	.dw $FFF8
	.db $05
.db $08, $08
	.dw LABEL_200 + $57
.db $FF, $06
	.db $0F
	.dw $FFFC
	.dw $FFF8
	.db $05
.db $FF, $09
	.db Music_EndOfLevel
.db $08, $00
	.dw LABEL_200 + $57
.db $FF, $06
	.db $0F
	.dw $0000
	.dw $FFF4
	.db $05
.db $40, $00
	.dw LABEL_200 + $57
.db $08, $00
	.dw LABEL_B28_A9DF
.db $FF, $00

DATA_B28_A973:
.db $FF, $02
	.dw LABEL_200 + $11D
.db $FF, $04
	.dw $0000
	.dw $FF80
.db $08, $08
	.dw LABEL_200 + $57
.db $08, $09
	.dw LABEL_200 + $57
.db $08, $08
	.dw LABEL_200 + $57
.db $08, $09
	.dw LABEL_200 + $57
.db $08, $08
	.dw LABEL_200 + $57
.db $08, $09
	.dw LABEL_200 + $57
.db $FF, $06
	.db $0F
	.dw $0006
	.dw $FFFC
	.db $05
.db $08, $08
	.dw LABEL_200 + $57
.db $FF, $06
	.db $14
	.dw $0000
	.dw $0000
	.db $00
.db $FF, $06
	.db $0F
	.dw $FFFA
	.dw $FFFC
	.db $05
.db $08, $09
	.dw LABEL_200 + $57
.db $FF, $06
	.db $0F
	.dw $0004
	.dw $FFF8
	.db $05
.db $08, $08
	.dw LABEL_200 + $57
.db $FF, $06
	.db $0F
	.dw $FFFC
	.dw $FFF8
	.db $05
.db $08, $00
	.dw LABEL_200 + $57
.db $FF, $06
	.db $0F
	.dw $0000
	.dw $FFF4
	.db $05
.db $40, $00
	.dw LABEL_200 + $57
.db $08, $00
	.dw LABEL_B28_A9E4
.db $FF, $00


LABEL_B28_A9DF:
	ld      hl, $d293
	set     4, (hl)
LABEL_B28_A9E4:
	ld      (ix+$00), $fe
	ret     

LABEL_B28_A9E9:
	ld      hl, ($d511)
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	jr      nc, +
	ex      de, hl
	ld      hl, $0000
	xor     a
	sbc     hl, de
+:	ld      a, h
	or      a
	ret     nz
	ld      a, l
	cp      $80
	ret     nc
	ld      de, ($d514)
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	xor     a
	sbc     hl, de
	ret     c
	ld      (ix+$02), $02
	ld      bc, $00E0
	ld      de, $000A
	call    LABEL_200 + $F6
	ret     

LABEL_B28_AA21:
	ld      hl, ($d174)
	ld      de, $0080
	add     hl, de
	ex      de, hl
	call    LABEL_200 + $42
	ld      a, ($d2b9)
	ld      b, a
	ld      a, ($d2b9)
	rrca    
	rrca    
	rrca    
	ld      c, a
	ld      a, ($d510)
	add     a, b
	add     a, c
	and     $03
	add     a, a
	ld      e, a
	ld      d, $00
	ld      hl, DATA_B28_AA4B
	add     hl, de
	ld      a, (hl)
	inc     hl
	ld      h, (hl)
	ld      l, a
	jp      (hl)

DATA_B28_AA4B:
.dw LABEL_B28_AA65
.dw LABEL_B28_AA5C
.dw LABEL_B28_AA53
.dw LABEL_B28_AA7C

LABEL_B28_AA53:
	ld      (ix+$1e), $40
	ld      (ix+$02), $07
	ret     

LABEL_B28_AA5C:
	ld      (ix+$1e), $40
	ld      (ix+$02), $06
	ret     

LABEL_B28_AA65:
	ld      hl, $fe00
	ld      (ix+$18), l
	ld      (ix+$19), h
	ld      hl, $0000
	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      (ix+$02), $05
	ret     

LABEL_B28_AA7C:
	ld      a, ($d2b9)
	and     $01
	jr      z, LABEL_B28_AA88
	ld      (ix+$02), $03
	ret     

LABEL_B28_AA88:
	ld      hl, $fd00
	ld      (ix+$18), l
	ld      (ix+$19), h
	ld      hl, $0000
	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      (ix+$02), $04
	ret     

LABEL_B28_AA9F:
	call    LABEL_B28_AC6E
	ld      a, (ix+$24)
	or      a
	jp      z, LABEL_B28_AC9B
	call    LABEL_200 + $57
	ld      de, $0020
	ld      bc, $0100
	call    LABEL_200 + $0F
	bit     7, (ix+$19)
	ret     nz
	ld      bc, $0000
	ld      de, $0000
	call    LABEL_200 + $63
	cp      $00
	ret     z
	ld      (ix+$02), $02
	ret     

LABEL_B28_AACB:
	call    LABEL_B28_AC6E
	ld      a, (ix+$24)
	or      a
	jp      z, LABEL_B28_AC9B
	call    LABEL_200 + $57
	ld      de, $0020
	ld      bc, $0100
	call    LABEL_200 + $0F
	bit     7, (ix+$19)
	ret     nz
	ld      bc, $0000
	ld      de, $0002
	call    LABEL_200 + $63
	cp      $00
	ret     z
	ld      (ix+$02), $08
	ret     

LABEL_B28_AAF7:
	call    LABEL_B28_AC6E
	ld      a, (ix+$24)
	or      a
	jp      z, LABEL_B28_AC9B
	call    LABEL_200 + $57
	call    LABEL_B28_ABE0
	ret     nc
	ld      hl, $ff00
	ld      (ix+$18), l
	ld      (ix+$19), h
	ld      hl, $0000
	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      (ix+$02), $05
	ld      (ix+$02), $09
	ret     

LABEL_B28_AB23:
	call    LABEL_B28_AC6E
	ld      a, (ix+$24)
	or      a
	jp      z, LABEL_B28_AC9B
	call    LABEL_200 + $57
	ld      de, $0020
	ld      bc, $0100
	call    LABEL_200 + $0F
	bit     7, (ix+$19)
	ret     nz
	ld      bc, $0000
	ld      de, $0000
	call    LABEL_200 + $63
	cp      $00
	ret     z
	ld      (ix+$02), $02
	ret     

LABEL_B28_AB4F:
	call    LABEL_B28_AC2B
	dec     (ix+$1e)
	jr      z, LABEL_B28_AB58
	ret     

LABEL_B28_AB58:
	ld      hl, $fc00
	ld      (ix+$18), l
	ld      (ix+$19), h
	ld      (ix+$02), $0b
	ret     

LABEL_B28_AB66:
	call    LABEL_B28_AC2B
	ld      de, $001c
	ld      bc, $0400
	call    LABEL_200 + $0F
	bit     7, (ix+$19)
	jr      nz, LABEL_B28_AB8E
	ld      bc, $0000
	ld      de, $0000
	call    LABEL_200 + $63
	cp      $00
	jr      z, LABEL_B28_AB8E
	xor     a
	ld      (ix+$18), a
	ld      (ix+$19), a
	jr      LABEL_B28_AB9D

LABEL_B28_AB8E:
	call    LABEL_200 + $57
	call    LABEL_B28_ABE0
	ret     nc
	xor     a
	ld      (ix+$16), a
	ld      (ix+$17), a
	ret     

LABEL_B28_AB9D:
	call    LABEL_200 + $57
	call    LABEL_B28_ABE0
	ret     nc
	ld      (ix+$02), $0c
	ret     

LABEL_B28_ABA9:
	call    LABEL_B28_AC2B
	dec     (ix+$1e)
	ret     nz
	ld      (ix+$02), $0e
	ret     

LABEL_B28_ABB5:
	call    LABEL_B28_AC2B
	call    LABEL_200 + $57
	call    LABEL_B28_ABE0
	ret     nc
	ld      l, (ix+$16)
	ld      h, (ix+$17)
	ld      de, $0000
	ex      de, hl
	xor     a
	sbc     hl, de
	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      hl, $fc00
	ld      (ix+$18), l
	ld      (ix+$19), h
	ld      (ix+$02), $0b
	ret     

LABEL_B28_ABE0:
	ld      de, ($d174)
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_AC12
	ld      a, h
	or      a
	jr      nz, LABEL_B28_AC23
	ld      a, l
	cp      $30
	jr      c, LABEL_B28_AC12
	cp      $d0
	jr      nc, LABEL_B28_AC23
	ld      e, (ix+$16)
	ld      d, (ix+$17)
	ld      l, (ix+$18)
	ld      a, (ix+$19)
	or      l
	or      e
	or      d
	jp      z, LABEL_B28_AC10
	xor     a
	ret     

LABEL_B28_AC10:
	scf     
	ret     

LABEL_B28_AC12:
	ld      e, (ix+$16)
	ld      a, (ix+$17)
	or      e
	jr      z, +
	xor     a
	bit     7, (ix+$17)
	ret     z
+:	scf     
	ret     

LABEL_B28_AC23:
	xor     a
	bit     7, (ix+$17)
	ret     nz
	scf     
	ret     

LABEL_B28_AC2B:
	call    LABEL_200 + $1B
	ld      a, (ix+$00)
	cp      $42
	jr      nz, +
	ld      a, (ix+$21)
	and     $0f
	jr      z, ++
	ld      a, $ff
	ld      ($d3a8), a
+:  ld      a, (ix+$21)
	and     $0f
	jr      z, ++
	ld      e, (ix+$16)
	ld      d, (ix+$17)
	ld      hl, $0000
	xor     a
	sbc     hl, de
	ld      (ix+$16), l
	ld      (ix+$17), h
++:	ld      a, (ix+$1f)
	or      a
	jp      nz, LABEL_B28_ACAC
	res     5, (ix+$04)
	res     7, (ix+$04)
	ld      (ix+$21), $00
	ret     

LABEL_B28_AC6E:
	ld      a, (ix+$1f)
	or      a
	jp      nz, LABEL_B28_ACAC
	res     5, (ix+$04)
	res     7, (ix+$04)
	call    LABEL_200 + $18
	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      (ix+$1f), $40
	dec     (ix+$24)
	ld      a, $aa
	ld      ($dd04), a
	ret     

LABEL_B28_AC93:
	call    LABEL_B28_AC6E
	ld      a, (ix+$24)
	or      a
	ret     nz
LABEL_B28_AC9B:
	ld      a, ($d2c5)
	cp      $1f
	jr      z, LABEL_B28_ACA7
	ld      (ix+$02), $10
	ret     

LABEL_B28_ACA7:
	ld      (ix+$02), $11
	ret     

LABEL_B28_ACAC:
	dec     (ix+$1f)
	set     5, (ix+$04)
	ld      (ix+$21), $00
	ret     

DATA_B28_ACB8:
.dw DATA_B28_ACCA
.dw DATA_B28_ACD0
.dw DATA_B28_ACDA
.dw DATA_B28_ACFD
.dw DATA_B28_AD03
.dw DATA_B28_AD0D
.dw DATA_B28_AD13
.dw DATA_B28_AD1D
.dw DATA_B28_AD27

DATA_B28_ACCA:
.db $01, $00
	.dw LABEL_B28_AD31
.db $FF, $00

DATA_B28_ACD0:
.db $06, $01
	.dw LABEL_B28_AD47
.db $06, $02
	.dw LABEL_B28_AD47
.db $FF, $00

DATA_B28_ACDA:
.db $FF, $04
	.dw $0000
	.dw $FE00
.db $06, $03
	.dw LABEL_B28_AD74
.db $06, $04
	.dw LABEL_B28_AD74
.db $06, $03
	.dw LABEL_B28_AD74
.db $06, $04
	.dw LABEL_B28_AD74
.db $06, $03
	.dw LABEL_B28_AD74
.db $06, $04
	.dw LABEL_B28_AD74
.db $FF, $05
	.db $03
.db $FF, $00

DATA_B28_ACFD:
.db $01, $03
	.dw LABEL_B28_AD88
.db $FF, $00

DATA_B28_AD03:
.db $03, $03
	.dw LABEL_B28_ADC4
.db $03, $04
	.dw LABEL_B28_ADC4
.db $FF, $00

DATA_B28_AD0D:
.db $01, $03
	.dw LABEL_B28_ADD8
.db $FF, $00

DATA_B28_AD13:
.db $03, $03
	.dw LABEL_B28_AE0B
.db $03, $04
	.dw LABEL_B28_AE0B
.db $FF, $00

DATA_B28_AD1D:
.db $03, $03
	.dw LABEL_B28_AE3C
.db $03, $04
	.dw LABEL_B28_AE3C
.db $FF, $00

DATA_B28_AD27:
.db $08, $01
	.dw LABEL_B28_AE86
.db $08, $02
	.dw LABEL_B28_AE86
.db $FF, $00


LABEL_B28_AD31:
	bit     6, (ix+$04)
	ret     nz
	ld      a, (ix+$3f)
	and     $01
	jr      nz, LABEL_B28_AD42
	ld      (ix+$02), $01
	ret     

LABEL_B28_AD42:
	ld      (ix+$02), $05
	ret     

LABEL_B28_AD47:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $3F
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_AEB2
	ld      a, $40
	call    LABEL_B28_BC2B
	cp      $00
	jr      z, +
	ld      a, $40
	call    LABEL_B28_BC6F
	cp      $00
	jr      z, +
	ld      (ix+$02), $02
+:	ret     

LABEL_B28_AD74:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_AEB2
	ret     

LABEL_B28_AD88:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $3F
	ld      (ix+$19), $00
	ld      (ix+$18), $00
	ld      (ix+$02), $04
	ld      hl, ($d511)
	ld      d, (ix+$12)
	ld      e, (ix+$11)
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_ADBA
	bit     1, (ix+$3f)
	jr      nz, LABEL_B28_ADBA
	ld      hl, $0200
	ld      (ix+$17), h
	ld      (ix+$16), l
	ret     

LABEL_B28_ADBA:
	ld      hl, $fe00
	ld      (ix+$17), h
	ld      (ix+$16), l
	ret     

LABEL_B28_ADC4:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_AEB2
	ret     

LABEL_B28_ADD8:
	bit     6, (ix+$04)
	ret     nz
	ld      (ix+$02), $06
	ld      (ix+$19), $00
	ld      (ix+$18), $00
	ld      hl, ($d511)
	ld      d, (ix+$12)
	ld      e, (ix+$11)
	xor     a
	sbc     hl, de
	jr      nc, LABEL_B28_AE01
	ld      hl, $fe00
	ld      (ix+$17), h
	ld      (ix+$16), l
	ret     

LABEL_B28_AE01:
	ld      hl, $0200
	ld      (ix+$17), h
	ld      (ix+$16), l
	ret     

LABEL_B28_AE0B:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_AEB2
	ld      a, $40
	call    LABEL_B28_BC2B
	cp      $00
	ret     z
	ld      (ix+$17), $00
	ld      (ix+$16), $00
	ld      (ix+$02), $07
	ld      hl, $0100
	ld      (ix+$19), h
	ld      (ix+$18), l
	ret     

LABEL_B28_AE3C:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $3F
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_AEB2
	ld      bc, $0000
	ld      de, $0000
	call    LABEL_200 + $63
	cp      $81
	jr      nz, LABEL_B28_AE85
	ld      (ix+$02), $08
	ld      hl, ($d511)
	ld      d, (ix+$12)
	ld      e, (ix+$11)
	xor     a
	sbc     hl, de
	jr      nc, LABEL_B28_AE7B
	ld      hl, $ff80
	ld      (ix+$17), h
	ld      (ix+$16), l
	ret     

LABEL_B28_AE7B:
	ld      hl, $0080
	ld      (ix+$17), h
	ld      (ix+$16), l
	ret     

LABEL_B28_AE85:
	ret     

LABEL_B28_AE86
	bit     6, (ix+$04)
	ret     nz
	ld      hl, $0100
	ld      (ix+$18), l
	ld      (ix+$19), h
	call    LABEL_B28_BD36
	bit     0, a
	jr      z, LABEL_B28_AEA0
	ld      (ix+$02), $02
	ret     

LABEL_B28_AEA0:
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_AEB2
	ret     

LABEL_B28_AEB2:
	jp		LABEL_200 + $0C


DATA_B28_AEB5:
.dw DATA_B28_AEBD
.dw DATA_B28_AEC2
.dw DATA_B28_AECC
.dw DATA_B28_AED6

DATA_B28_AEBD:
.db $FF, $05
	.db $01
.db $FF, $03

DATA_B28_AEC2:
.db $30, $01
	.dw LABEL_B28_AEE0
.db $08, $02
	.dw LABEL_B28_AEEE
.db $FF, $00

DATA_B28_AECC:
.db $08, $01
	.dw LABEL_B28_AF43
.db $08, $02
	.dw LABEL_B28_AF43
.db $FF, $00

DATA_B28_AED6:
.db $08, $03
	.dw LABEL_B28_AF8A
.db $08, $04
	.dw LABEL_B28_AF8A
.db $FF, $00


LABEL_B28_AEE0:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $5A
	call    LABEL_200 + $3F
	jp      LABEL_200 + $0C

LABEL_B28_AEEE:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $5A
	call    LABEL_200 + $3F
	ld      hl, ($d511)
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	jr      nc, +
	ex      de, hl
	ld      hl, $0000
	xor     a
	sbc     hl, de
+:	ld      a, h
	or      a
	jp      nz, LABEL_200 + $0C
	ld      b, l
	ld      hl, ($d514)
	ld      e, (ix+$14)
	ld      d, (ix+$15)
	xor     a
	sbc     hl, de
	jr      nc, +
	ex      de, hl
	ld      hl, $0000
	xor     a
	sbc     hl, de
+:	ld      a, h
	or      a
	jp      nz, LABEL_200 + $0C
	ld      a, l
	add     a, b
	jp      c, LABEL_200 + $0C
	cp      $80
	jp      nc, LABEL_200 + $0C
	ld      (ix+$02), $02
	ld      (ix+$1f), $50
	jp      LABEL_200 + $0C

LABEL_B28_AF43:
	bit     6, (ix+$04)
	ret     nz
	ld      hl, ($d511)
	ld      de, $0000
	ld      bc, $00c0
	call    LABEL_200 + $48
	ld      hl, ($d514)
	ld      de, $0000
	ld      bc, $00c0
	call    LABEL_200 + $4B
	call    LABEL_200 + $5A
	call    LABEL_200 + $39
	ld      a, (ix+$22)
	and     $0c
	jr      nz, +
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	call    LABEL_200 + $3F
	ld      a, (ix+$21)
	and     $0f
	jr      nz, +
	dec     (ix+$1f)
	jp      nz, LABEL_200 + $0C
+:	ld      (ix+$02), $03
	jp      LABEL_200 + $0C

LABEL_B28_AF8A:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $60
	call    LABEL_200 + $3f
	ld      a, (ix+$06)
	cp      $04
	jr      z, +
	call    LABEL_200 + $57
+:	call    LABEL_200 + $5A
	ld      l, (ix+$3a)
	ld      h, (ix+$3b)
	ld      de, $0000
	ld      bc, $0180
	call    LABEL_200 + $48
	ld      l, (ix+$3c)
	ld      h, (ix+$3d)
	ld      de, $0000
	ld      bc, $0180
	call    LABEL_200 + $4B
	ld      a, (ix+$16)
	ld      h, (ix+$17)
	or      h
	jp      nz, LABEL_200 + $0C
	ld      a, (ix+$18)
	ld      h, (ix+$19)
	or      h
	jp      nz, LABEL_200 + $0C
	ld      (ix+$02), $01
	jp      LABEL_200 + $0C


DATA_B28_AFDB:
.dw DATA_B28_AFED
.dw DATA_B28_AFF3
.dw DATA_B28_B02C
.dw DATA_B28_B065
.dw DATA_B28_B073
.dw DATA_B28_B081
.dw DATA_B28_B0AE
.dw DATA_B28_B0DB
.dw DATA_B28_B0E9

DATA_B28_AFED:
.db $10, $01
	.dw LABEL_B28_B0F7
.db $FF, $00

DATA_B28_AFF3:
.db $08, $01
	.dw LABEL_B28_B101
.db $08, $02
	.dw LABEL_B28_B101
.db $08, $03
	.dw LABEL_B28_B101
.db $08, $01
	.dw LABEL_B28_B101
.db $08, $02
	.dw LABEL_B28_B101
.db $08, $03
	.dw LABEL_B28_B101
.db $08, $01
	.dw LABEL_B28_B101
.db $08, $02
	.dw LABEL_B28_B101
.db $08, $03
	.dw LABEL_B28_B101
.db $08, $01
	.dw LABEL_B28_B101
.db $08, $02
	.dw LABEL_B28_B101
.db $08, $03
	.dw LABEL_B28_B101
.db $FF, $05
	.db $03
.db $08, $03
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_B02C:
.db $08, $01
	.dw LABEL_B28_B161
.db $08, $02
	.dw LABEL_B28_B161
.db $08, $03
	.dw LABEL_B28_B161
.db $08, $01
	.dw LABEL_B28_B161
.db $08, $02
	.dw LABEL_B28_B161
.db $08, $03
	.dw LABEL_B28_B161
.db $08, $01
	.dw LABEL_B28_B161
.db $08, $02
	.dw LABEL_B28_B161
.db $08, $03
	.dw LABEL_B28_B161
.db $08, $01
	.dw LABEL_B28_B161
.db $08, $02
	.dw LABEL_B28_B161
.db $08, $03
	.dw LABEL_B28_B161
.db $FF, $05
	.db $04
.db $08, $03
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_B065:
.db $08, $01
	.dw LABEL_B28_B1C2
.db $08, $02
	.dw LABEL_B28_B1C2
.db $08, $03
	.dw LABEL_B28_B1C2
.db $FF, $00

DATA_B28_B073:
.db $08, $01
	.dw LABEL_B28_B205
.db $08, $02
	.dw LABEL_B28_B205
.db $08, $03
	.dw LABEL_B28_B205
.db $FF, $00

DATA_B28_B081:
.db $06, $01
	.dw LABEL_B28_B248
.db $06, $02
	.dw LABEL_B28_B248
.db $06, $03
	.dw LABEL_B28_B248
.db $06, $01
	.dw LABEL_B28_B248
.db $06, $02
	.dw LABEL_B28_B248
.db $06, $03
	.dw LABEL_B28_B248
.db $06, $01
	.dw LABEL_B28_B248
.db $06, $02
	.dw LABEL_B28_B248
.db $06, $03
	.dw LABEL_B28_B248
.db $FF, $05
	.db $02
.db $08, $03
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_B0AE:
.db $06, $01
	.dw LABEL_B28_B26C
.db $06, $02
	.dw LABEL_B28_B26C
.db $06, $03
	.dw LABEL_B28_B26C
.db $06, $01
	.dw LABEL_B28_B26C
.db $06, $02
	.dw LABEL_B28_B26C
.db $06, $03
	.dw LABEL_B28_B26C
.db $06, $01
	.dw LABEL_B28_B26C
.db $06, $02
	.dw LABEL_B28_B26C
.db $06, $03
	.dw LABEL_B28_B26C
.db $FF, $05
	.db $01
.db $08, $03
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_B0DB:
.db $02, $01
	.dw LABEL_B28_B290
.db $02, $02
	.dw LABEL_B28_B290
.db $02, $03
	.dw LABEL_B28_B290
.db $FF, $00

DATA_B28_B0E9:
.db $02, $01
	.dw LABEL_B28_B2D0
.db $02, $02
	.dw LABEL_B28_B2D0
.db $02, $03
	.dw LABEL_B28_B2D0
.db $FF, $00


LABEL_B28_B0F7:
	bit     6, (ix+$04)
	ret     nz
	ld      (ix+$02), $01
	ret     

LABEL_B28_B101:
	bit     6, (ix+$04)
	ret     nz
	ld      hl, $0100
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      hl, $0100
	ld      (ix+$19), h
	ld      (ix+$18), l
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	call    LABEL_200 + $5A
	ld      a, $40
	call    LABEL_B28_BC6F
	or      a
	jr      z, +
	ld      hl, ($d511)
	ld      d, (ix+$12)
	ld      e, (ix+$11)
	xor     a
	sbc     hl, de
	jr      c, +
	ld      de, $0040
	xor     a
	sbc     hl, de
	jr      nc, +
	ld      (ix+$02), $07
	ld      (ix+$17), $00
	ld      (ix+$16), $00
+:	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_B311
	call    LABEL_200 + $3C
	call    LABEL_B28_BD36
	bit     0, a
	ret     z
	ld      (ix+$02), $02
	ret     

LABEL_B28_B161:
	bit     6, (ix+$04)
	ret     nz
	ld      hl, $ff00
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      hl, $0100
	ld      (ix+$19), h
	ld      (ix+$18), l
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	ld      a, $40
	call    LABEL_B28_BC6F
	or      a
	jr      z, +
	ld      de, ($d511)
	ld      h, (ix+$12)
	ld      l, (ix+$11)
	xor     a
	sbc     hl, de
	jr      c, +
	ld      de, $0040
	xor     a
	sbc     hl, de
	jr      nc, +
	ld      (ix+$02), $08
	ld      (ix+$17), $00
	ld      (ix+$16), $00
+:	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_B311
	call    LABEL_200 + $3C
	call    LABEL_B28_BD36
	bit     0, a
	ret     z
	ld      (ix+$02), $01
	ret     

LABEL_B28_B1C2:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $3C
	call    LABEL_200 + $5A
	call    LABEL_B28_BD36
	bit     0, a
	jr      z, LABEL_B28_B1D9
	ld      (ix+$02), $05
	ret     

LABEL_B28_B1D9:
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_B311
	ld      h, (ix+$17)
	ld      l, (ix+$16)
	ld      de, $0002
	xor     a
	sbc     hl, de
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      de, $ff00
	xor     a
	sbc     hl, de
	ret     nz
	ld      (ix+$02), $02
	ret     

LABEL_B28_B205:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $3C
	call    LABEL_200 + $5A
	call    LABEL_B28_BD36
	bit     0, a
	jr      z, LABEL_B28_B21C
	ld      (ix+$02), $06
	ret     

LABEL_B28_B21C:
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_B311
	ld      h, (ix+$17)
	ld      l, (ix+$16)
	ld      de, $0002
	xor     a
	adc     hl, de
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      de, $0100
	xor     a
	sbc     hl, de
	ret     nz
	ld      (ix+$02), $01
	ret     

LABEL_B28_B248:
	ld      hl, $fffe
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      hl, $0100
	ld      (ix+$19), h
	ld      (ix+$18), l
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_B311
	ret     

LABEL_B28_B26C:
	ld      hl, $0002
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      hl, $0100
	ld      (ix+$19), h
	ld      (ix+$18), l
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_B311
	ret

LABEL_B28_B290:
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_B311
	call    LABEL_200 + $3C
	call    LABEL_B28_BD36
	bit     0, a
	jr      nz, +
	ld      h, (ix+$17)
	ld      l, (ix+$16)
	ld      de, $0004
	xor     a
	add     hl, de
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      de, $0280
	xor     a
	sbc     hl, de
	ret     c
+:	ld      (ix+$17), $00
	ld      (ix+$16), $00
	ld      (ix+$02), $05
	ret     

LABEL_B28_B2D0:
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_B311
	call    LABEL_200 + $3C
	call    LABEL_B28_BD36
	bit     0, a
	jr      nz, +
	ld      h, (ix+$17)
	ld      l, (ix+$16)
	ld      de, $0004
	xor     a
	sbc     hl, de
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      de, $fd80
	xor     a
	sbc     hl, de
	ret     nc
+:	ld      (ix+$17), $00
	ld      (ix+$16), $00
	ld      (ix+$02), $06
	ret     

LABEL_B28_B311:
	jp      LABEL_200 + $0C


DATA_B28_B314:
.dw DATA_B28_B320
.dw DATA_B28_B326
.dw DATA_B28_B32C
.dw DATA_B28_B39D
.dw DATA_B28_B3B5
.dw DATA_B28_B3FE

DATA_B28_B320:
.db $E0, $00
	.dw LABEL_B28_B404
.db $FF, $00

DATA_B28_B326:
.db $E0, $00
	.dw LABEL_B28_B412
.db $FF, $00

DATA_B28_B32C:
.db $01, $04
	.dw LABEL_B28_B425
.db $06, $00
	.dw LABEL_B28_B425
.db $01, $04
	.dw LABEL_B28_B425
.db $05, $00
	.dw LABEL_B28_B425
.db $01, $04
	.dw LABEL_B28_B425
.db $04, $00
	.dw LABEL_B28_B425
.db $01, $04
	.dw LABEL_B28_B425
.db $03, $00
	.dw LABEL_B28_B425
.db $01, $04
	.dw LABEL_B28_B425
.db $02, $00
	.dw LABEL_B28_B425
.db $01, $04
	.dw LABEL_B28_B425
.db $01, $00
	.dw LABEL_B28_B425
.db $01, $03
	.dw LABEL_B28_B425
.db $01, $01
	.dw LABEL_B28_B425
.db $01, $03
	.dw LABEL_B28_B425
.db $01, $01
	.dw LABEL_B28_B425
.db $01, $03
	.dw LABEL_B28_B425
.db $01, $01
	.dw LABEL_B28_B425
.db $01, $03
	.dw LABEL_B28_B425
.db $01, $01
	.dw LABEL_B28_B425
.db $01, $03
	.dw LABEL_B28_B425
.db $01, $01
	.dw LABEL_B28_B425
.db $01, $03
	.dw LABEL_B28_B425
.db $01, $01
	.dw LABEL_B28_B425
.db $01, $03
	.dw LABEL_B28_B425
.db $01, $01
	.dw LABEL_B28_B425
.db $FF, $05
	.db $03
.db $30, $01
	.dw LABEL_B28_B425
.db $FF, $00

DATA_B28_B39D:
.db $FF, $09
	.db $A8
.db $FF, $06
	.db $3C
	.dw $0008
	.dw $FFF8
	.db $00
.db $40, $02
	.dw LABEL_B28_B426
.db $FF, $05
	.db $04
.db $01, $02
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_B3B5:
.db $01, $03
	.dw LABEL_B28_B432
.db $01, $01
	.dw LABEL_B28_B432
.db $01, $03
	.dw LABEL_B28_B432
.db $01, $01
	.dw LABEL_B28_B432
.db $01, $03
	.dw LABEL_B28_B432
.db $01, $00
	.dw LABEL_B28_B432
.db $01, $03
	.dw LABEL_B28_B432
.db $01, $00
	.dw LABEL_B28_B432
.db $01, $03
	.dw LABEL_B28_B432
.db $01, $00
	.dw LABEL_B28_B432
.db $01, $03
	.dw LABEL_B28_B432
.db $03, $00
	.dw LABEL_B28_B432
.db $01, $04
	.dw LABEL_B28_B432
.db $03, $00
	.dw LABEL_B28_B432
.db $01, $04
	.dw LABEL_B28_B432
.db $03, $00
	.dw LABEL_B28_B432
.db $FF, $05
	.db $05
.db $01, $00
	.dw LABEL_B28_B432
.db $FF, $00

DATA_B28_B3FE:
.db $E0, $00
	.dw LABEL_B28_B433
.db $FF, $00


LABEL_B28_B404:
	bit     6, (ix+$04)
	ret     nz
	set     4, (ix+$04)
	ld      (ix+$02), $01
	ret     

LABEL_B28_B412:
	ld      a, $80
	call    LABEL_B28_BC2B
	or      a
	ret     z
	ld      a, $80
	call    LABEL_B28_BC6F
	or      a
	ret     z
	ld      (ix+$02), $02
	ret     

LABEL_B28_B425:
	ret     

LABEL_B28_B426:
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_B43C
	ret     

LABEL_B28_B432:
	ret     

LABEL_B28_B433:
	ld      (ix+$00), $ff
	ld      (ix+$3e), $00
	ret     

LABEL_B28_B43C:
	ld      (ix+$3f), $40
	jp      LABEL_200 + $0C


DATA_B28_B443:
.dw DATA_B28_B459
.dw DATA_B28_B465
.dw DATA_B28_B473
.dw DATA_B28_B481
.dw DATA_B28_B48F
.dw DATA_B28_B49D
.dw DATA_B28_B4AB
.dw DATA_B28_B4B9
.dw DATA_B28_B4C7
.dw DATA_B28_B4D5
.dw DATA_B28_B4E3

DATA_B28_B459:
.db $FF, $04
	.dw $0000
	.dw $F400
.db $01, $00
	.dw LABEL_B28_B4ED
.db $FF, $00

DATA_B28_B465:
.db $06, $01
	.dw LABEL_B28_B4F2
.db $06, $02
	.dw LABEL_B28_B4F2
.db $06, $03
	.dw LABEL_B28_B4F2
.db $FF, $00

DATA_B28_B473:
.db $06, $01
	.dw LABEL_B28_B512
.db $06, $02
	.dw LABEL_B28_B512
.db $06, $03
	.dw LABEL_B28_B512
.db $FF, $00

DATA_B28_B481:
.db $06, $01
	.dw LABEL_B28_B55A
.db $06, $02
	.dw LABEL_B28_B55A
.db $06, $03
	.dw LABEL_B28_B55A
.db $FF, $00

DATA_B28_B48F:
.db $06, $01
	.dw LABEL_B28_B56A
.db $06, $02
	.dw LABEL_B28_B56A
.db $06, $03
	.dw LABEL_B28_B56A
.db $FF, $00

DATA_B28_B49D:
.db $03, $01
	.dw LABEL_B28_B5A1
.db $03, $02
	.dw LABEL_B28_B5A1
.db $03, $03
	.dw LABEL_B28_B5A1
.db $FF, $00

DATA_B28_B4AB:
.db $03, $04
	.dw LABEL_B28_B5A1
.db $03, $05
	.dw LABEL_B28_B5A1
.db $03, $06
	.dw LABEL_B28_B5A1
.db $FF, $00

DATA_B28_B4B9:
.db $06, $04
	.dw LABEL_B28_B5F1
.db $06, $05
	.dw LABEL_B28_B5F1
.db $06, $06
	.dw LABEL_B28_B5F1
.db $FF, $00

DATA_B28_B4C7:
.db $0C, $01
	.dw LABEL_B28_B601
.db $0C, $02
	.dw LABEL_B28_B601
.db $0C, $03
	.dw LABEL_B28_B601
.db $FF, $00

DATA_B28_B4D5:
.db $0C, $04
	.dw LABEL_B28_B601
.db $0C, $05
	.dw LABEL_B28_B601
.db $0C, $06
	.dw LABEL_B28_B601
.db $FF, $00

DATA_B28_B4E3:
.db $10, $01
	.dw LABEL_B28_B61D
.db $10, $04
	.dw LABEL_B28_B61D
.db $FF, $00


LABEL_B28_B4ED:
	ld      (ix+$02), $01
	ret     

LABEL_B28_B4F2:
	call    LABEL_200 + $57
	ld      de, $0080
	ld      bc, $0600
	call    LABEL_200 + $0F
	bit     7, (ix+$19)
	ret     nz
	ld      (ix+$02), $02
	ld      (ix+$19), $00
	ld      (ix+$18), $00
	jp      LABEL_B28_B686

LABEL_B28_B512:
	ld      h, (ix+$19)
	ld      l, (ix+$18)
	ld      de, $0020
	add     hl, de
	ld      (ix+$19), h
	ld      (ix+$18), l
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	ld      bc, $0000
	ld      de, $0000
	call    LABEL_200 + $63
	cp      $81
	jp      nz, LABEL_B28_B686
	ld      (ix+$19), $00
	ld      (ix+$18), $00
	ld      (ix+$1e), $20
	ld      (ix+$02), $03
	ld      a, (ix+$3f)
	bit     0, a
	jr      nz, LABEL_B28_B553
	jp      LABEL_B28_B686

LABEL_B28_B553:
	ld      (ix+$02), $08
	jp      LABEL_B28_B686

LABEL_B28_B55A:
	call    LABEL_200 + $5A
	dec     (ix+$1e)
	jp      nz, LABEL_B28_B686
	ld      (ix+$02), $04
	jp      LABEL_B28_B686

LABEL_B28_B56A:
	ld      hl, $fb00
	ld      (ix+$19), h
	ld      (ix+$18), l
	ld      hl, ($d511)
	ld      d, (ix+$12)
	ld      e, (ix+$11)
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_B591
	ld      hl, $0100
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      (ix+$02), $05
	jp      LABEL_B28_B686

LABEL_B28_B591:
	ld      hl, $ff00
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      (ix+$02), $06
	jp      LABEL_B28_B686

LABEL_B28_B5A1:
	ld      h, (ix+$19)
	ld      l, (ix+$18)
	ld      de, $0040
	add     hl, de
	ld      (ix+$19), h
	ld      (ix+$18), l
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	ld      bc, $0000
	ld      de, $0008
	call    LABEL_200 + $63
	cp      $81
	jp      nz, LABEL_B28_B686
	ld      (ix+$17), $00
	ld      (ix+$16), $00
	ld      (ix+$19), $00
	ld      (ix+$18), $00
	ld      (ix+$1e), $20
	ld      a, (ix+$01)
	cp      $05
	jr      nz, LABEL_B28_B5EA
	ld      (ix+$02), $03
	jp      LABEL_B28_B686

LABEL_B28_B5EA:
	ld      (ix+$02), $07
	jp      LABEL_B28_B686

LABEL_B28_B5F1:
	call    LABEL_200 + $5A
	dec     (ix+$1e)
	jp      nz, LABEL_B28_B686
	ld      (ix+$02), $04
	jp      LABEL_B28_B686

LABEL_B28_B601:
	call    LABEL_200 + $57
	call    LABEL_200 + $5A
	dec     (ix+$1e)
	jp      nz, LABEL_B28_B686
	ld      (ix+$02), $0a
	ld      hl, $fb00
	ld      (ix+$19), h
	ld      (ix+$18), l
	jp      LABEL_B28_B686

LABEL_B28_B61D:
	ld      (ix+$17), $00
	ld      (ix+$16), $00
	ld      h, (ix+$19)
	ld      l, (ix+$18)
	ld      de, $0040
	add     hl, de
	ld      (ix+$19), h
	ld      (ix+$18), l
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	ld      bc, $0000
	ld      de, $0008
	call    LABEL_200 + $63
	cp      $81
	jp      nz, LABEL_B28_B686
	ld      (ix+$19), $00
	ld      (ix+$18), $00
	ld      (ix+$1e), $40
	ld      hl, ($d511)
	ld      d, (ix+$12)
	ld      e, (ix+$11)
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_B676
	ld      hl, $0080
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      (ix+$02), $08
	jp      LABEL_B28_B686

LABEL_B28_B676:
	ld      hl, $ff80
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      (ix+$02), $09
	jp      LABEL_B28_B686

LABEL_B28_B686:
	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      a, ($d503)
	bit     1, a
	ret     z
	call    LABEL_B28_B698
	jp      LABEL_200 + $0C

LABEL_B28_B698:
	push    ix
	pop     hl
	call    LABEL_200 + $30
	ld      c, a
	ld      b, $08
	ld      de, $D3BC
-:	ld      a, (de)
	cp      c
	jr      z, LABEL_B28_B6AC
	inc     de
	djnz    -
	ret     

LABEL_B28_B6AC:
	xor     a
	ld      (de), a
	ret     


DATA_B28_B6AF:
.dw DATA_B28_B6B3
.dw DATA_B28_B6B9

DATA_B28_B6B3:
.db $01, $01
	.dw LABEL_B28_B6C3
.db $FF, $00

DATA_B28_B6B9:
.db $06, $01
	.dw LABEL_B28_B6E3
.db $06, $02
	.dw LABEL_B28_B6E3
.db $FF, $00


LABEL_B28_B6C3:
	bit     6, (ix+$04)
	ret     nz
	ld      (ix+$02), $01
	ld      hl, $0080
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      (ix+$1e), $00
	ld      hl, $0020
	ld      (ix+$19), h
	ld      (ix+$18), l
	ret     

LABEL_B28_B6E3:
	bit     6, (ix+$04)
	ret     nz
	ld      a, (ix+$1e)
	add     a, $01
	ld      (ix+$1e), a
	and     $80
	jr      z, +
	ld      h, (ix+$19)
	ld      l, (ix+$18)
	call    LABEL_B28_BC23
	ld      (ix+$19), h
	ld      (ix+$18), l
	ld      (ix+$1e), $00
+:	call    LABEL_200 + $3C
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_B737
	ld      b, $c0
	call    LABEL_B28_BCB3
	call    LABEL_200 + $39
	ld      a, (ix+$22)
	and     $0c
	jr      z, +
	ld      h, (ix+$17)
	ld      l, (ix+$16)
	call    LABEL_B28_BC23
	ld      (ix+$17), h
	ld      (ix+$16), l
+:	ret     

LABEL_B28_B737:
	jp      LABEL_200 + $0C


DATA_B28_B73A:
.dw DATA_B28_B744
.dw DATA_B28_B74A 
.dw DATA_B28_B750 
.dw DATA_B28_B756 
.dw DATA_B28_B75C 

DATA_B28_B744:
.db $01, $01
	.dw LABEL_B28_B766
.db $FF, $00

DATA_B28_B74A:
.db $06, $04
	.dw LABEL_B28_B771
.db $FF, $00

DATA_B28_B750:
.db $12, $03
	.dw LABEL_B28_B7B1
.db $FF, $00

DATA_B28_B756:
.db $00, $01
	.dw LABEL_B28_B810
.db $FF, $00

DATA_B28_B75C:
.db $06, $01
	.dw LABEL_B28_B844
.db $06, $02
	.dw LABEL_B28_B844
.db $FF, $00


LABEL_B28_B766:
	bit     6, (ix+$04)
	jr      nz, +
	ld      (ix+$02), $01
+:	ret     

LABEL_B28_B771:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $3F
	ld      a, $60
	call    LABEL_B28_BC6F
	cp      $00
	jr      z, LABEL_B28_B7B0
	ld      a, $60
	call    LABEL_B28_BC2B
	cp      $00
	jr      z, LABEL_B28_B7B0
	ld      (ix+$02), $02
	ld      hl, $fe80
	ld      (ix+$19), h
	ld      (ix+$18), l
	bit     0, a
	jr      z, LABEL_B28_B7A6
	ld      hl, $ff80
	ld      (ix+$17), h
	ld      (ix+$16), l
	ret     

LABEL_B28_B7A6:
	ld      hl, $0080
	ld      (ix+$17), h
	ld      (ix+$16), l
	ret     

LABEL_B28_B7B0:
	ret     

LABEL_B28_B7B1:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $3F
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_B8DF
	ld      l, (ix+$18)
	ld      h, (ix+$19)
	ld      de, $0014
	add     hl, de
	ld      (ix+$18), l
	ld      (ix+$19), h
	call    LABEL_200 + $57
	ld      bc, $0000
	ld      de, $0000
	call    LABEL_200 + $63
	cp      $81
	jr      nz, LABEL_B28_B80F
	ld      (ix+$02), $03
	ld      h, (ix+$12)
	ld      l, (ix+$11)
	ld      d, (ix+$3b)
	ld      e, (ix+$3a)
	xor     a
	sbc     hl, de
	jr      nc, LABEL_B28_B806
	ld      hl, $0080
	ld      (ix+$17), h
	ld      (ix+$16), l
	ret     

LABEL_B28_B806:
	ld      hl, $ff80
	ld      (ix+$17), h
	ld      (ix+$16), l
LABEL_B28_B80F
	ret     

LABEL_B28_B810:
	bit     6, (ix+$04)
	ret     nz
	ld      (ix+$02), $04
	ld      hl, $0000
	ld      (ix+$19), h
	ld      (ix+$18), l
	ld      h, (ix+$17)
	ld      l, (ix+$16)
	ld      de, $0000
	xor     a
	sbc     hl, de
	jr      nc, LABEL_B28_B83A
	ld      hl, $0080
	ld      (ix+$17), h
	ld      (ix+$16), l
	ret     

LABEL_B28_B83A:
	ld      hl, $ff80
	ld      (ix+$17), h
	ld      (ix+$16), l
	ret     

LABEL_B28_B844:
	bit     6, (ix+$04)
	ret     nz
	ld      hl, $00c0
	ld      (ix+$19), h
	ld      (ix+$18), l
	call    LABEL_200 + $3F
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	call    LABEL_200 + $60
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_B8DF
	call    LABEL_B28_BD36
	bit     0, a
	jr      z, +
	call    LABEL_B28_BD26
+:	bit     7, (ix+$17)
	jr      nz, LABEL_B28_B89A
	ld      h, (ix+$12)
	ld      l, (ix+$11)
	ld      d, (ix+$3b)
	ld      e, (ix+$3a)
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_B8BC
	ld      de, $0080
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_B8BC
	ld      hl, $ff80
	ld      (ix+$17), h
	ld      (ix+$16), l
	jr      LABEL_B28_B8BC

LABEL_B28_B89A:
	ld      h, (ix+$3b)
	ld      l, (ix+$3a)
	ld      d, (ix+$12)
	ld      e, (ix+$11)
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_B8BC
	ld      de, $0080
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_B8BC
	ld      hl, $0080
	ld      (ix+$17), h
	ld      (ix+$16), l
		
LABEL_B28_B8BC:
	ld      a, $40
	call    LABEL_B28_BC2B
	or      a
	ret     z
	ld      a, ($d503)
	bit     0, a
	ret     z
	ld      (ix+$02), $02
	ld      hl, $fe80
	ld      (ix+$19), h
	ld      (ix+$18), l
	ld      (ix+$17), $00
	ld      (ix+$16), $00
	ret     

LABEL_B28_B8DF:
	jp      LABEL_200 + $0C


DATA_B28_B8E2:
.dw DATA_B28_B8EA
.dw DATA_B28_B8F0
.dw DATA_B28_B8FA
.dw DATA_B28_B829

DATA_B28_B8EA:
.db $80, $00
	.dw LABEL_B28_B93F
.db $FF, $00

DATA_B28_B8F0:
.db $10, $01
	.dw LABEL_B28_B956
.db $10, $02
	.dw LABEL_B28_B956
.db $FF, $00

DATA_B28_B8FA:
.db $FF, $04
	.dw $0200
	.dw $0000
.db $06, $01
	.dw LABEL_B28_B994
.db $06, $02
	.dw LABEL_B28_B994
.db $06, $01
	.dw LABEL_B28_B994
.db $06, $02
	.dw LABEL_B28_B994
.db $06, $01
	.dw LABEL_B28_B994
.db $06, $02
	.dw LABEL_B28_B994
.db $06, $01
	.dw LABEL_B28_B994
.db $06, $02
	.dw LABEL_B28_B994
.db $FF, $05
	.db $03
.db $10, $02
	.dw VF_DoNothing
.db $FF, $00

DATA_B28_B829:
.db $FF, $06
	.db $3B
	.dw $0000
	.dw $0000
	.db $01
.db $FF, $06
	.db $3B
	.dw $0000
	.dw $0000
	.db $02
.db $08, $02
	.dw LABEL_B28_B9BB
.db $FF, $00


LABEL_B28_B93F:
	bit     6, (ix+$04)
	ret     nz
	ld      (ix+$0a), $01
	ld      (ix+$02), $01
	ld      hl, $0020
	ld      (ix+$17), h
	ld      (ix+$16), l
	ret     

LABEL_B28_B956:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $3C
	ld      a, $40
	call    LABEL_B28_BC6F
	cp      $00
	jr      z, +
	ld      a, $40
	call    LABEL_B28_BC2B
	cp      $00
	jr      z, +
	ld      (ix+$02), $02
+:	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      a, $00
	ld      b, $60
	call    LABEL_B28_BCB3
	call    LABEL_B28_BD36
	bit     0, a
	jr      z, +
	call    LABEL_B28_BD26
+:	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_B9C6
	ret     

LABEL_B28_B994:
	call    LABEL_200 + $3C
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	call    LABEL_B28_BD26
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_B9C6
	ld      a, ($d503)
	bit     0, a
	ret     z
	ld      a, $10
	call    LABEL_B28_BC2B
	bit     0, a
	ret     z
	ld      (ix+$02), $03
	ret     

LABEL_B28_B9BB:
	jr      LABEL_B28_B9BE

LABEL_B28_B9BD:
	ret     

LABEL_B28_B9BE:
	ld      (ix+$3f), $80
	call    LABEL_200 + $5D
	ret     

LABEL_B28_B9C6:
	ld      a, $ff
	ld      ($d3a8), a
	ret     


DATA_B28_B9CC:
.dw DATA_B28_B9D4
.dw DATA_B28_B9DA
.dw DATA_B28_B9E4
.dw DATA_B28_B9EA

DATA_B28_B9D4:
.db $10, $01
	.dw LABEL_B28_B9F4
.db $FF, $00

DATA_B28_B9DA:
.db $20, $01
	.dw LABEL_B28_BA17
.db $20, $02
	.dw LABEL_B28_BA17
.db $FF, $00

DATA_B28_B9E4:
.db $10, $01
	.dw LABEL_B28_BA70
.db $FF, $00

DATA_B28_B9EA:
.db $18, $01
	.dw LABEL_B28_BAA3
.db $18, $02
	.dw LABEL_B28_BAA3
.db $FF, $00


LABEL_B28_B9F4:
	bit     6, (ix+$04)
	ret     nz
	ld      (ix+$17), $00
	ld      (ix+$16), $00
	ld      hl, $fe80
	ld      (ix+$18), l
	ld      (ix+$19), h
	ld      (ix+$1e), $00
	ld      (ix+$0a), $00
	ld      (ix+$02), $01
	ret     

LABEL_B28_BA17:
	bit     6, (ix+$04)
	ret     nz
	ld      (ix+$17), $00
	ld      (ix+$16), $00
	ld      a, (ix+$1e)
	cp      $03
	jr      nz, LABEL_B28_BA30
	ld      (ix+$02), $02
	ret     

LABEL_B28_BA30:
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_BB27
	ld      l, (ix+$18)
	ld      h, (ix+$19)
	ld      de, $0014
	add     hl, de
	ld      (ix+$18), l
	ld      (ix+$19), h
	call    LABEL_200 + $57
	ld      bc, $0000
	ld      de, $0000
	call    LABEL_200 + $63
	cp      $81
	jr      nz, +
	ld      hl, ($bb2a)
	ld      (ix+$18), l
	ld      (ix+$19), h
	ld      a, (ix+$1e)
	add     a, $01
	ld      (ix+$1e), a
+:	ret     

LABEL_B28_BA70:
	bit     6, (ix+$04)
	ret     nz
	ld      (ix+$1e), $00
	ld      hl, $ff00
	ld      (ix+$19), h
	ld      (ix+$18), l
	inc     (ix+$0a)
	ld      (ix+$02), $03
	bit     0, (ix+$0a)
	jr      nz, LABEL_B28_BA99
	ld      hl, $ffa0
	ld      (ix+$17), h
	ld      (ix+$16), l
	ret     

LABEL_B28_BA99:
	ld      hl, $0060
	ld      (ix+$16), l
	ld      (ix+$17), h
	ret     

LABEL_B28_BAA3:
	bit     6, (ix+$04)
	ret     nz
	ld      a, (ix+$1e)
	cp      $03
	jr      nz, LABEL_B28_BAC9
	ld      (ix+$1e), $00
	ld      (ix+$02), $01
	ld      (ix+$17), $00
	ld      (ix+$16), $00
	ld      hl, ($bb2a)
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     

LABEL_B28_BAC9:
	ld      a, (ix+$17)
	or      a
	jr      nz, +
	ld      a, (ix+$16)
	or      a
	jr      z, ++
+:	call    LABEL_200 + $39
	ld      a, (ix+$22)
	and     $0c
	jr      z, ++
	ld      (ix+$17), $00
	ld      (ix+$16), $00
++:	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_BB27
	ld      l, (ix+$18)
	ld      h, (ix+$19)
	ld      de, $0014
	add     hl, de
	ld      (ix+$18), l
	ld      (ix+$19), h
	call    LABEL_200 + $57
	ld      bc, $0000
	ld      de, $0000
	call    LABEL_200 + $63
	cp      $81
	jr      nz, +
	ld      hl, $ff00
	ld      (ix+$18), l
	ld      (ix+$19), h
	ld      a, (ix+$1e)
	add     a, $01
	ld      (ix+$1e), a
+:	ret     

LABEL_B28_BB27:
	jp      LABEL_200 + $0C


DATA_B28_BB2A:
.db $80, $FE

DATA_B28_BB2C:
.dw LABEL_B28_BB30
.dw LABEL_B28_BB36

LABEL_B28_BB30:
.db $10, $00
	.dw LABEL_B28_BB3C
.db $FF, $00

LABEL_B28_BB36:
.db $10, $01
	.dw LABEL_B28_BB94
.db $FF, $00


LABEL_B28_BB3C:
	bit     6, (ix+$04)
	jr      z, +
	ld      a, $ff
	ld      (ix+$00), a
+:	ld      (ix+$02), $01
	ld      (ix+$1e), $00
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	ld      (ix+$3a), l
	ld      (ix+$3b), h
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	ld      (ix+$3c), l
	ld      (ix+$3d), h
	ld      a, (ix+$3f)
	cp      $02
	jr      z, LABEL_B28_BB81
	ld      hl, $0140
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      hl, $fc80
	ld      (ix+$19), h
	ld      (ix+$18), l
	ret     

LABEL_B28_BB81:
	ld      hl, $00d0
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      hl, $fe20
	ld      (ix+$19), h
	ld      (ix+$18), l
	ret     

LABEL_B28_BB94:
	ld      hl, ($d176)
	ld      de, $00E0
	xor     a
	add     hl, de
	ld      d, (ix+$15)
	ld      e, (ix+$14)
	xor     a
	sbc     hl, de
	jr      nc, LABEL_B28_BBAD
	ld      a, $ff
	ld      (ix+$00), a
	ret     

LABEL_B28_BBAD:
	bit     0, (ix+$1e)
	jr      nz, LABEL_B28_BBD1
	inc     (ix+$1e)
	ld      h, (ix+$3b)
	ld      l, (ix+$3a)
	ld      b, h
	ld      c, l
	ld      d, (ix+$12)
	ld      e, (ix+$11)
	xor     a
	sbc     hl, de
	xor     a
	add     hl, bc
	ld      (ix+$12), h
	ld      (ix+$11), l
	jr      LABEL_B28_BBFD

LABEL_B28_BBD1:
	inc     (ix+$1e)
	ld      h, (ix+$12)
	ld      l, (ix+$11)
	ld      d, (ix+$3b)
	ld      e, (ix+$3a)
	xor     a
	sbc     hl, de
	ex      de, hl
	xor     a
	sbc     hl, de
	ld      (ix+$12), h
	ld      (ix+$11), l
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      hl, $d3a8
	ld      a, $ff
	ld      (hl), a
	ret     

LABEL_B28_BBFD:
	ld      h, (ix+$19)
	ld      l, (ix+$18)
	ld      de, $0030
	add     hl, de
	ld      (ix+$19), h
	ld      (ix+$18), l
	call    LABEL_200 + $57
	call    LABEL_200 + $57
	call    LABEL_200 + $5A
	ld      a, (ix+$21)
	and     $0f
	ret     z
	ld      hl, $d3a8
	ld      a, $ff
	ld      (hl), a
	ret     

LABEL_B28_BC23:
	dec     hl
	ld      a, l
	cpl     
	ld      l, a
	ld      a, h
	cpl     
	ld      h, a
	ret     

LABEL_B28_BC2B:
	ld      b, a
	ld      de, ($d511)
	ld      l, (ix+$11)
	ld      h, (ix+$12)
	xor     a
	sbc     hl, de
	jp      c, LABEL_B28_BC4B
	ld      a, h
	or      a
	jp      nz, LABEL_B28_BC69
	ld      a, l
	cp      b
	jp      nc, LABEL_B28_BC69
	ld      a, $01
	ld      b, $01
	ret     

LABEL_B28_BC4B:
	ld      hl, ($d511)
	ld      e, (ix+$11)
	ld      d, (ix+$12)
	xor     a
	sbc     hl, de
	jp      c, LABEL_B28_BC69
	ld      a, h
	or      a
	jp      nz, LABEL_B28_BC69
	ld      a, l
	cp      b
	jp      nc, LABEL_B28_BC69
	ld      a, $01
	ld      b, $00
	ret     

LABEL_B28_BC69:
	ld      a, $ff
	ld      b, a
	ld      a, $00
	ret     

LABEL_B28_BC6F:
	ld      b, a
	ld      de, ($d514)
	ld      l, (ix+$14)
	ld      h, (ix+$15)
	xor     a
	sbc     hl, de
	jp      c, LABEL_B28_BC8F
	ld      a, h
	or      a
	jp      nz, LABEL_B28_BCAD
	ld      a, l
	cp      b
	jp      nc, LABEL_B28_BCAD
	ld      a, $01
	ld      b, $01
	ret     

LABEL_B28_BC8F:
	ld      hl, ($d514)
	ld      e, (ix+$14)
	ld      d, (ix+$15)
	xor     a
	sbc     hl, de
	jp      c, LABEL_B28_BCAD
	ld      a, h
	or      a
	jp      nz, LABEL_B28_BCAD
	ld      a, l
	cp      b
	jp      nc, LABEL_B28_BCAD
	ld      a, $01
	ld      b, $00
	ret     

LABEL_B28_BCAD:
	ld      a, $ff
	ld      b, a
	ld      a, $00
	ret     

LABEL_B28_BCB3:
	ld      c, a
	ld      h, (ix+$12)
	ld      l, (ix+$11)
	ld      d, (ix+$3b)
	ld      e, (ix+$3a)
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_BCE4
	ld      a, h
	or      a
	jr      nz, LABEL_B28_BD14
	ld      a, l
	cp      b
	jr      c, LABEL_B28_BD14
	ld      a, c
	and     $01
	jr      nz, +
	ld      h, (ix+$17)
	ld      l, (ix+$16)
	call    LABEL_B28_BC23
	ld      (ix+$17), h
	ld      (ix+$16), l
+:	ld      a, $01
	ret     

LABEL_B28_BCE4:
	ld      d, (ix+$12)
	ld      e, (ix+$11)
	ld      h, (ix+$3b)
	ld      l, (ix+$3a)
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_BD14
	ld      a, h
	or      a
	jr      nz, LABEL_B28_BD14
	ld      a, l
	cp      b
	jr      c, LABEL_B28_BD14
	ld      a, c
	and     $01
	jr      nz, +
	ld      h, (ix+$17)
	ld      l, (ix+$16)
	call    LABEL_B28_BC23
	ld      (ix+$17), h
	ld      (ix+$16), l
+:	ld      a, $01
	ret     

LABEL_B28_BD14:
	ld      a, $00
	ret     

LABEL_B28_BD17:
	ld      h, (ix+$19)
	ld      l, (ix+$18)
	call    LABEL_B28_BC23
	ld      (ix+$19), h
	ld      (ix+$18), l
LABEL_B28_BD26:
	ld      h, (ix+$17)
	ld      l, (ix+$16)
	call    LABEL_B28_BC23
	ld      (ix+$17), h
	ld      (ix+$16), l
	ret     

LABEL_B28_BD36:
	bit     7, (ix+$17)		;which direction is the sprite moving?
	jr      nz, +			;jump if moving left
	ld      bc, $0008
	jr      ++
+:	ld      bc, $FFF8
++:	ld      de, $FFF0
	call    LABEL_200 + $63	;get collision value for block
	cp      $81
	jr      z, +
	cp      $8D
	jr      z, +
	cp      $90
	jr      z, +
	jr      LABEL_B28_BD68
+:	ld      a, ($D353)
	ld      hl, DATA_B28_BD86
	ld      bc, $0008
	cpir    
	jr      z, LABEL_B28_BD68
	ld      a, $01
	ret     

LABEL_B28_BD68:
	bit     7, (ix+$17)		;which direction is the sprite moving?
	jr      nz, +			;jump if moving left
	ld      bc, $0008
	jr      ++
+:	ld      bc, $FFF8
++:	ld      de, $0010
	call    LABEL_200 + $63
	bit     7, a
	jr      z, LABEL_B28_BD83
	ld      a, $00
	ret     

LABEL_B28_BD83:
	ld      a, $01
	ret     


DATA_B28_BD86:
.db $0D, $0F, $1D, $1F, $4D, $4F, $5D, $5F


DATA_B28_BD8E:
.dw LABEL_B28_BD94
.dw LABEL_B28_BD9A
.dw LABEL_B28_BDA3

LABEL_B28_BD94:
.db $01, $01
	.dw LABEL_B28_BDA9
.db $FF, $00

LABEL_B28_BD9A:
.db $20, $01
	.dw LABEL_B28_BDBF
.db $FF, $05
	.db $02
.db $FF, $00

LABEL_B28_BDA3:
.db $08, $01
	.dw LABEL_B28_BDD7
.db $FF, $00


LABEL_B28_BDA9:
	ld      hl, $fe90
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      (ix+$19), $00
	ld      (ix+$18), $00
	ld      (ix+$02), $01
	ret     

LABEL_B28_BDBF:
	bit     6, (ix+$04)
	jr      nz, LABEL_B28_BDEB
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      a, (ix+$21)
	and     $0f
	ret     z
LABEL_B28_BDD1:
	ld      hl, $d3a8
	ld      (hl), $ff
	ret

LABEL_B28_BDD7:
	bit     6, (ix+$04)
	jr      nz, LABEL_B28_BDEB
	call    LABEL_200 + $5A
	call    LABEL_200 + $57
	ld      a, (ix+$21)
	and     $0f
	ret     z
	jr      LABEL_B28_BDD1
LABEL_B28_BDEB:
	ld      (ix+$00), $ff
	ret     


DATA_B28_BDF0:
.dw DATA_B28_BDFA
.dw DATA_B28_BE00
.dw DATA_B28_BE0A
.dw DATA_B28_BE18
.dw DATA_B28_BE26

DATA_B28_BDFA:
.db $01, $01
	.dw LABEL_B28_BE37
.db $FF, $00

DATA_B28_BE00:
.db $06, $01
	.dw LABEL_B28_BE53
.db $06, $02
	.dw LABEL_B28_BE53
.db $FF, $00

DATA_B28_BE0A:
.db $FF, $06
	.db $3E
	.dw $0000
	.dw $0000
	.db $00
.db $01, $03
	.dw LABEL_B28_BEB8
.db $FF, $00

DATA_B28_BE18:
.db $FF, $06
	.db $3E
	.dw $0000
	.dw $0000
	.db $01
.db $01, $03
	.dw LABEL_B28_BEC9
.db $FF, $00

DATA_B28_BE26:
.db $10, $03
	.dw LABEL_B28_BEDA
.db $06, $03
	.dw LABEL_B28_BEDA
.db $06, $03
	.dw LABEL_B28_BEDA
.db $FF, $05
	.db $01
.db $FF, $00


LABEL_B28_BE37:
	bit     6, (ix+$04)
	ret     nz
	ld      hl, $00c0
	ld      (ix+$17), h
	ld      (ix+$16), l
	ld      hl, $0100
	ld      (ix+$19), h
	ld      (ix+$18), l
	ld      (ix+$02), $01
	ret     

LABEL_B28_BE53:
	bit     6, (ix+$04)
	ret     nz
	call    LABEL_200 + $3F
	call    LABEL_200 + $5A
	call    LABEL_B28_BD36
	bit     0, a
	jr      z, +
	call    LABEL_B28_BD26
+:	call    LABEL_200 + $57
	call    LABEL_200 + $60
	ld      a, (ix+$21)
	and     $0f
	jp      nz, LABEL_B28_BEE7
	ld      a, $00
	ld      b, $40
	call    LABEL_B28_BCB3
	and     $01
	jr      z, LABEL_B28_BEB7
	ld      h, (ix+$3b)
	ld      l, (ix+$3a)
	ld      d, (ix+$12)
	ld      e, (ix+$11)
	xor     a
	sbc     hl, de
	jr      nc, LABEL_B28_BEA5
	ld      hl, ($d511)
	ld      d, (ix+$12)
	ld      e, (ix+$11)
	xor     a
	sbc     hl, de
	jr      c, LABEL_B28_BEB7
	ld      (ix+$02), $02
	ret     

LABEL_B28_BEA5:
	ld      hl, ($d511)
	ld      d, (ix+$12)
	ld      e, (ix+$11)
	xor     a
	sbc     hl, de
	jr      nc,  LABEL_B28_BEB7
	ld      (ix+$02), $03
LABEL_B28_BEB7:
	ret

LABEL_B28_BEB8:
	bit     6, (ix+$04)
	ret     nz
	ld      a, (ix+$21)
	and     $0f
	jr      nz, LABEL_B28_BEE7
	ld      (ix+$02), $04
	ret     

LABEL_B28_BEC9:
	bit     6, (ix+$04)
	ret     nz
	ld      a, (ix+$21)
	and     $0f
	jr      nz, LABEL_B28_BEE7
	ld      (ix+$02), $04
	ret     

LABEL_B28_BEDA:
	bit     6, (ix+$04)
	ret     nz
	ld      a, (ix+$21)
	and     $0f
	jr      nz, LABEL_B28_BEE7
	ret     

LABEL_B28_BEE7:
	jp      LABEL_200 + $0C


DATA_B28_BEEA:
.dw DATA_B28_BEEE
.dw DATA_B28_BEF4

DATA_B28_BEEE:
.db $01, $00
	.dw LABEL_B28_BEFA
.db $FF, $00

DATA_B28_BEF4:
.db $06, $01
	.dw LABEL_B28_BF47
.db $FF, $00


LABEL_B28_BEFA:
	ld      (ix+$1e), $00
	ld      h, (ix+$12)
	ld      l, (ix+$11)
	ld      (ix+$3b), h
	ld      (ix+$3a), l
	ld      h, (ix+$15)
	ld      l, (ix+$14)
	ld      (ix+$3d), h
	ld      (ix+$3c), l
	ld      (ix+$02), $01
	ld      a, (ix+$3f)
	and     $01
	jr      z, LABEL_B28_BF34
	ld      hl, $ff00
	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      hl, $fc80
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     

LABEL_B28_BF34:
	ld      hl, $0100
	ld      (ix+$16), l
	ld      (ix+$17), h
	ld      hl, $fc80
	ld      (ix+$18), l
	ld      (ix+$19), h
	ret     

LABEL_B28_BF47:
	call    LABEL_200 + $5A
	ld      l, (ix+$18)
	ld      h, (ix+$19)
	ld      de, $0020
	add     hl, de
	ld      (ix+$18), l
	ld      (ix+$19), h
	call    LABEL_200 + $57
	ld      a, (ix+$21)
	and     $0f
	jp      z, LABEL_B28_BF6E
	ld      hl, $d3a8
	ld      a, $ff
	ld      (hl), a
	jp      LABEL_B28_BFA4

LABEL_B28_BF6E:
	call    LABEL_200 + $60
	ld      a, (ix+$22)
	bit     2, a
	jr      nz, LABEL_B28_BFA4
	bit     3, a
	jr      nz, LABEL_B28_BFA4
	bit     0, a
	jr      nz, LABEL_B28_BFA4
	bit     1, a
	jr      z, +
	ld      h, (ix+$19)
	ld      l, (ix+$18)
	call    LABEL_B28_BC23
	ld      de, $0040
	add     hl, de
	ld      (ix+$19), h
	ld      (ix+$18), l
	ld      a, (ix+$1e)
	add     a, $01
	ld      (ix+$1e), a
	cp      $06
	jr      nc, LABEL_B28_BFA4
+:	ret     

LABEL_B28_BFA4:
	ld      (ix+$3f), $80
	jp      LABEL_200 + $5D
	ret     

DATA_B28_BFAC: