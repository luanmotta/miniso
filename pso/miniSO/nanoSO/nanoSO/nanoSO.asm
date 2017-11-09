; Arquivo: nanoSO.asm
; Autor:   Roland Teodorowitsch
;


_TEXT	segment byte public 'CODE'
	assume	cs:_TEXT


_main	proc near

        ; desabilita interrupções
        cli

	; define a pilha
	mov ax,7c00h
	mov sp,ax
	mov ax,0
	mov ss,ax

	; desvia a interrupção 22h
        xor ax,ax
        mov ds,ax
	mov ax,offset _scall
        mov ds:[22h*4],ax
	mov ax,07e0h
        mov ds:[22h*4+2],ax

        ; habilita interrupções
        sti

	; laço principal
laco:   mov ah,0
	int 22h
	mov ah,1
	int 22h
        jmp laco
	
_main	endp


_scall	proc near

	cmp	ah,0
	jnz	nao_eh_servico_0

servico_0:
	mov	ah,10h
	int	16h
	iret

nao_eh_servico_0:
	cmp	ah,1
	jnz	tambem_nao_eh_servico_1

servico_1:
        mov     ah,0eh
        xor     bh,bh
	int	10h
        iret

tambem_nao_eh_servico_1:
	iret

_scall	endp


_TEXT	ends


	end
