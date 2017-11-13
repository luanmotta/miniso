	ifndef	??version
?debug	macro
	endm
publicdll macro	name
	public	name
	endm
$comm	macro	name,dist,size,count
	comm	dist name:BYTE:count*size
	endm
	else
$comm	macro	name,dist,size,count
	comm	dist name[size]:BYTE:count
	endm
	endif
	?debug	V 300h
	?debug	S "command.c"
	?debug	C E969AE6C4B09636F6D6D616E642E63
	?debug	C E94FAE6C4B086D696E69534F2E68
	?debug	C E9BA9C6C4B09636F6D6D616E642E68
	?debug	C E990AC6C4B056C69622E68
_TEXT	segment byte public 'CODE'
_TEXT	ends
DGROUP	group	_DATA,_BSS
	assume	cs:_TEXT,ds:DGROUP
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
_BSS	ends
_DATA	segment word public 'DATA'
num_var	label	word
	db	0
	db	0
commands	label	word
	dw	DGROUP:s@
	dw	DGROUP:s@+2
	dw	_cmd_help
	dw	DGROUP:s@+45
	dw	DGROUP:s@+50
	dw	_cmd_help
	dw	DGROUP:s@+90
	dw	DGROUP:s@+94
	dw	_cmd_ver
	dw	DGROUP:s@+134
	dw	DGROUP:s@+139
	dw	_cmd_date
	dw	DGROUP:s@+169
	dw	DGROUP:s@+174
	dw	_cmd_time
	dw	DGROUP:s@+204
	dw	DGROUP:s@+208
	dw	_cmd_cls
	dw	DGROUP:s@+238
	dw	DGROUP:s@+244
	dw	_cmd_cls
	dw	DGROUP:s@+272
	dw	DGROUP:s@+279
	dw	_cmd_reboot
	dw	DGROUP:s@+316
	dw	DGROUP:s@+321
	dw	_cmd_exit
	dw	DGROUP:s@+356
	dw	DGROUP:s@+361
	dw	_cmd_exit
	dw	DGROUP:s@+396
	dw	DGROUP:s@+399
	dw	_cmd_ps
	dw	DGROUP:s@+453
	dw	DGROUP:s@+458
	dw	_cmd_kill
	dw	DGROUP:s@+501
	dw	DGROUP:s@+506
	dw	_cmd_demo
	dw	DGROUP:s@+563
	dw	DGROUP:s@+567
	dw	_cmd_set
	dw	DGROUP:s@+630
	dw	DGROUP:s@+636
	dw	_cmd_unset
	dw	DGROUP:s@+668
	dw	DGROUP:s@+673
	dw	_cmd_echo
	dw	DGROUP:s@+708
	dw	DGROUP:s@+716
	dw	_cmd_waitpid
	dw	DGROUP:s@+765
	dw	DGROUP:s@+770
	dw	_cmd_wait
	dw	DGROUP:s@+815
	dw	DGROUP:s@+821
	dw	_cmd_semls
	dw	DGROUP:s@+862
	dw	DGROUP:s@+872
	dw	_cmd_semcreate
	dw	DGROUP:s@+900
	dw	DGROUP:s@+908
	dw	_cmd_semtest
	dw	DGROUP:s@+955
	dw	DGROUP:s@+961
	dw	_cmd_semup
	dw	DGROUP:s@+1010
	dw	DGROUP:s@+1021
	dw	_cmd_semdestroy
	dw	DGROUP:s@+1051
	dw	DGROUP:s@+1056
	dw	_cmd_stop
	dw	DGROUP:s@+1099
	dw	DGROUP:s@+1106
	dw	_cmd_resume
_DATA	ends
_TEXT	segment byte public 'CODE'
   ;	
   ;	void command()
   ;	
	assume	cs:_TEXT
_command	proc	near
	push	bp
	mov	bp,sp
	sub	sp,34
	push	si
	push	di
   ;	
   ;	{
   ;	  char car,str[10];
   ;	  int numcar;
   ;	  int i,achou,pos;
   ;	  int novalinha,res,argc;
   ;	  char far *ptrline,far *var;
   ;	
   ;	  /* Inicializações... */
   ;	  numcar = 0;
   ;	
	xor	si,si
   ;	
   ;	  end_command = 0;
   ;	
	mov	word ptr DGROUP:end_command,0
   ;	
   ;	  history_ini = 0;
   ;	
	mov	word ptr DGROUP:history_ini,0
   ;	
   ;	  history_nxt = 0;
   ;	
	mov	word ptr DGROUP:history_nxt,0
   ;	
   ;	  history_pos = -1;
   ;	
	mov	word ptr DGROUP:history_pos,-1
   ;	
   ;	  /* Mensagem inicial */
   ;	  setcolor(7);
   ;	
	mov	ax,7
	push	ax
	call	near ptr _setcolor
	pop	cx
   ;	
   ;	  clrscr();
   ;	
	call	near ptr _clrscr
   ;	
   ;	  setcolor(LOGOCOLOR);
   ;	
	mov	ax,1
	push	ax
	call	near ptr _setcolor
	pop	cx
   ;	
   ;	  putstr("                  ÜÜÜÜÜÜÜ  ÜÜÜÜÜÜ\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1147
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	  putstr(" ÜÜÜÜÜ  Ü  ÜÜÜ  Ü ÛÛ   ßß  ÛÛ  ÛÛ  "); setcolor(7); putstr("MinisSistema Operacional\n"); setcolor(LOGOCOLOR);
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1182
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
	mov	ax,7
	push	ax
	call	near ptr _setcolor
	pop	cx
	push	ds
	mov	ax,offset DGROUP:s@+1218
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
	mov	ax,1
	push	ax
	call	near ptr _setcolor
	pop	cx
   ;	
   ;	  putstr("ÜÛ Û Û ÜÛ ÜÛ Û ÜÛ ßßßßÛÛÛ ÛÛÛ  ÛÛ  "); setcolor(7); putstr("Vs "); putstr(miniSO_VERSION); putstr("\n"); setcolor(LOGO
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1244
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
	mov	ax,7
	push	ax
	call	near ptr _setcolor
	pop	cx
	push	ds
	mov	ax,offset DGROUP:s@+1280
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
	push	ds
	mov	ax,offset DGROUP:s@+1284
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
	push	ds
	mov	ax,offset DGROUP:s@+1289
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
	mov	ax,1
	push	ax
	call	near ptr _setcolor
	pop	cx
   ;	
   ;	  putstr("ÛÛ Û Û ÛÛ ÛÛ Û ÛÛ ÛÛÜÜÛÛÛ ÛÛÛÜÜÛÛ  "); setcolor(7); putstr("por Roland Teodorowitsch\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1291
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
	mov	ax,7
	push	ax
	call	near ptr _setcolor
	pop	cx
	push	ds
	mov	ax,offset DGROUP:s@+1327
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	  
   ;	  putstr("\nDigite 'help' ou '?' para ajuda...\n\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1353
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	  /* Inicializa variáveis de ambiente */
   ;	  command_var_init();
   ;	
	call	near ptr command_var_init
   ;	
   ;	  command_var_set("PROMPT","miniSO>");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1398
	push	ax
	push	ds
	mov	ax,offset DGROUP:s@+1391
	push	ax
	call	near ptr command_var_set
	add	sp,8
   ;	
   ;	  command_var_set("ERRORLEVEL","0");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1417
	push	ax
	push	ds
	mov	ax,offset DGROUP:s@+1406
	push	ax
	call	near ptr command_var_set
	add	sp,8
   ;	
   ;	  /* Imprime sinal de pronto */
   ;	  command_showprompt();
   ;	
	call	near ptr command_showprompt
	jmp	@1@3362
@1@58:
   ;	
   ;	  /* Laço para interpretação de comandos */
   ;	  while ( !end_command )  {
   ;	        car=getch();
   ;	
	call	near ptr _getch
	mov	byte ptr [bp-1],al
   ;	
   ;	        switch (car)  {
   ;	
	mov	al,byte ptr [bp-1]
	cbw	
	mov	word ptr [bp-32],ax
	mov	cx,5
	mov	bx,offset @1@C3234
@1@142:
	mov	ax,word ptr cs:[bx]
	cmp	ax,word ptr [bp-32]
	je	short @1@226
	add	bx,2
	loop	short @1@142
	jmp	@1@3306
@1@226:
	jmp	word ptr cs:[bx+10]
@1@254:
   ;	
   ;	               case 9:
   ;	                    break;
   ;	
	jmp	@1@3362
@1@282:
   ;	
   ;	               case 8:
   ;	                    if (numcar>0)  {
   ;	
	or	si,si
	jle	short @1@338
   ;	
   ;	                       --numcar;
   ;	
	dec	si
   ;	
   ;	                       command_backspace();
   ;	
	call	near ptr command_backspace
@1@338:
   ;	
   ;	                    }
   ;	                    break;
   ;	
	jmp	@1@3362
@1@366:
	jmp	short @1@422
@1@394:
   ;	
   ;	               case 27:
   ;	                    /* Limpa a linha de comandos */
   ;	                    while (numcar>0)  {
   ;	                          --numcar;
   ;	
	dec	si
   ;	
   ;	                          command_backspace();
   ;	
	call	near ptr command_backspace
@1@422:
	or	si,si
	jg	short @1@394
   ;	
   ;	                    }
   ;	                    break;
   ;	
	jmp	@1@3362
@1@478:
   ;	
   ;	               case 0:
   ;	                    car=getch();
   ;	
	call	near ptr _getch
	mov	byte ptr [bp-1],al
   ;	
   ;	                    switch (car)  {
   ;	
	mov	al,byte ptr [bp-1]
	cbw	
	mov	word ptr [bp-34],ax
	mov	cx,4
	mov	bx,offset @1@C3330
@1@562:
	mov	ax,word ptr cs:[bx]
	cmp	ax,word ptr [bp-34]
	je	short @1@646
	add	bx,2
	loop	short @1@562
	jmp	@1@2102
@1@646:
	jmp	word ptr cs:[bx+8]
@1@674:
   ;	
   ;	                           case 65: /* F7 */
   ;	                                history_pos = -1;
   ;	
	mov	word ptr DGROUP:history_pos,-1
	jmp	short @1@730
@1@702:
   ;	
   ;	                                /* Limpa a linha de comandos */
   ;	                                while (numcar>0)  {
   ;	                                      --numcar;
   ;	
	dec	si
   ;	
   ;	                                      command_backspace();
   ;	
	call	near ptr command_backspace
@1@730:
	or	si,si
	jg	short @1@702
   ;	
   ;	                                }
   ;	                                putch('\n');
   ;	
	mov	ax,10
	push	ax
	call	near ptr _putch
	pop	cx
   ;	
   ;	                                /* Imprime o histórico */
   ;	                                for (i=0;i<history_len;++i)  {
   ;	
	xor	di,di
	jmp	short @1@842
@1@786:
   ;	
   ;	                                    putstr(history[(history_ini+i)%MAXHISTORY]);
   ;	
	push	ds
	mov	ax,word ptr DGROUP:history_ini
	add	ax,di
	mov	bx,10
	cwd	
	idiv	bx
	mov	bx,31
	mov	ax,dx
	imul	bx
	add	ax,offset DGROUP:history
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	                                    putch('\n');
   ;	
	mov	ax,10
	push	ax
	call	near ptr _putch
	pop	cx
	inc	di
@1@842:
	cmp	di,word ptr DGROUP:history_len
	jl	short @1@786
   ;	
   ;	                                }
   ;	                                command_showprompt();
   ;	
	call	near ptr command_showprompt
   ;	
   ;	                                break;
   ;	
	jmp	@1@2102
@1@898:
   ;	
   ;	                           case 75: /* Seta para esquerda */
   ;	                                if (numcar>0)  {
   ;	
	or	si,si
	jle	short @1@954
   ;	
   ;	                                   --numcar;
   ;	
	dec	si
   ;	
   ;	                                   command_backspace();
   ;	
	call	near ptr command_backspace
@1@954:
   ;	
   ;	                                }
   ;	                                break;
   ;	
	jmp	@1@2102
@1@982:
   ;	
   ;	                           case 72: /* Seta para cima */
   ;	                                if (history_len>0)  {
   ;	
	cmp	word ptr DGROUP:history_len,0
	jg	@@0
	jmp	@1@1598
@@0:
   ;	
   ;	                                   novalinha=0;
   ;	
	mov	word ptr [bp-18],0
   ;	
   ;	                                   if (history_len<MAXHISTORY)  {
   ;	
	cmp	word ptr DGROUP:history_len,10
	jge	short @1@1178
   ;	
   ;	                                      if (history_pos==-1)  {
   ;	
	cmp	word ptr DGROUP:history_pos,-1
	jne	short @1@1094
   ;	
   ;	                                         history_pos=history_nxt-1;
   ;	
	mov	ax,word ptr DGROUP:history_nxt
	dec	ax
	mov	word ptr DGROUP:history_pos,ax
   ;	
   ;	                                         novalinha=1;
   ;	
	mov	word ptr [bp-18],1
   ;	
   ;	                                      }
   ;	
	jmp	short @1@1150
@1@1094:
   ;	
   ;	                                      else  {
   ;	                                         if (history_pos>0)  {
   ;	
	cmp	word ptr DGROUP:history_pos,0
	jle	short @1@1150
   ;	
   ;	                                            history_pos--;
   ;	
	dec	word ptr DGROUP:history_pos
   ;	
   ;	                                            novalinha=1;
   ;	
	mov	word ptr [bp-18],1
@1@1150:
   ;	
   ;	                                         }
   ;	                                      }
   ;	                                   }
   ;	
	jmp	short @1@1458
@1@1178:
   ;	
   ;	                                   else  {
   ;	                                      if (history_pos==-1)  {
   ;	
	cmp	word ptr DGROUP:history_pos,-1
	jne	short @1@1290
   ;	
   ;	                                         history_pos=history_nxt-1;
   ;	
	mov	ax,word ptr DGROUP:history_nxt
	dec	ax
	mov	word ptr DGROUP:history_pos,ax
   ;	
   ;	                                         if (history_pos<0)
   ;	
	cmp	word ptr DGROUP:history_pos,0
	jge	short @1@1262
   ;	
   ;	                                            history_pos=MAXHISTORY-1;
   ;	
	mov	word ptr DGROUP:history_pos,9
@1@1262:
   ;	
   ;	                                         novalinha=1;
   ;	
	mov	word ptr [bp-18],1
   ;	
   ;	                                      }
   ;	
	jmp	short @1@1458
@1@1290:
   ;	
   ;	                                      else  {
   ;	                                         if (history_pos!=history_ini)  {
   ;	
	mov	ax,word ptr DGROUP:history_pos
	cmp	ax,word ptr DGROUP:history_ini
	je	short @1@1458
   ;	
   ;	                                            novalinha=1;
   ;	
	mov	word ptr [bp-18],1
   ;	
   ;	                                            if (history_pos>history_ini)
   ;	
	mov	ax,word ptr DGROUP:history_pos
	cmp	ax,word ptr DGROUP:history_ini
	jle	short @1@1374
   ;	
   ;	                                               --history_pos;
   ;	
	dec	word ptr DGROUP:history_pos
	jmp	short @1@1458
@1@1374:
   ;	
   ;	                                            else  {  /* history_pos<history_ini */
   ;	                                               if (history_pos>0)
   ;	
	cmp	word ptr DGROUP:history_pos,0
	jle	short @1@1430
   ;	
   ;	                                                  history_pos--;
   ;	
	dec	word ptr DGROUP:history_pos
	jmp	short @1@1458
@1@1430:
   ;	
   ;	                                               else
   ;	                                                  history_pos=MAXHISTORY-1;
   ;	
	mov	word ptr DGROUP:history_pos,9
@1@1458:
   ;	
   ;	                                             }
   ;	                                         }
   ;	                                      }
   ;	                                   }
   ;	                                   if (novalinha)  {
   ;	
	cmp	word ptr [bp-18],0
	je	short @1@1598
	jmp	short @1@1542
@1@1514:
   ;	
   ;	                                      /* Limpa a linha de comandos */
   ;	                                      while (numcar>0)  {
   ;	                                            --numcar;
   ;	
	dec	si
   ;	
   ;	                                            command_backspace();
   ;	
	call	near ptr command_backspace
@1@1542:
	or	si,si
	jg	short @1@1514
   ;	
   ;	                                      }
   ;	                                      strcpy(cmdline,history[history_pos]);
   ;	
	push	ds
	mov	ax,word ptr DGROUP:history_pos
	mov	dx,31
	imul	dx
	add	ax,offset DGROUP:history
	push	ax
	push	ds
	mov	ax,offset DGROUP:cmdline
	push	ax
	call	near ptr _strcpy
	add	sp,8
   ;	
   ;	                                      putstr(cmdline);
   ;	
	push	ds
	mov	ax,offset DGROUP:cmdline
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	                                      numcar=strlen(cmdline);
   ;	
	push	ds
	mov	ax,offset DGROUP:cmdline
	push	ax
	call	near ptr _strlen
	pop	cx
	pop	cx
	mov	si,ax
@1@1598:
   ;	
   ;	                                   }
   ;	                                }
   ;	                                break;
   ;	
	jmp	@1@2102
@1@1626:
   ;	
   ;	                           case 80: /* Seta para baixo */
   ;	                                if (history_len>0 && history_pos!=-1)  {
   ;	
	cmp	word ptr DGROUP:history_len,0
	jg	@@1
	jmp	@1@2074
@@1:
	cmp	word ptr DGROUP:history_pos,-1
	jne	@@2
	jmp	@1@2074
@@2:
   ;	
   ;	                                   if (history_len<MAXHISTORY)  {
   ;	
	cmp	word ptr DGROUP:history_len,10
	jge	short @1@1822
   ;	
   ;	                                      if (history_pos<history_len-1)
   ;	
	mov	ax,word ptr DGROUP:history_len
	dec	ax
	cmp	ax,word ptr DGROUP:history_pos
	jle	short @1@1766
   ;	
   ;	                                         history_pos++;
   ;	
	inc	word ptr DGROUP:history_pos
	jmp	short @1@1794
@1@1766:
   ;	
   ;	                                      else
   ;	                                         history_pos = -1;
   ;	
	mov	word ptr DGROUP:history_pos,-1
@1@1794:
   ;	
   ;	                                   }
   ;	
	jmp	short @1@1934
@1@1822:
   ;	
   ;	                                   else  {
   ;	                                      history_pos++;
   ;	
	inc	word ptr DGROUP:history_pos
   ;	
   ;	                                      if (history_pos>=MAXHISTORY)
   ;	
	cmp	word ptr DGROUP:history_pos,10
	jl	short @1@1878
   ;	
   ;	                                         history_pos = 0;
   ;	
	mov	word ptr DGROUP:history_pos,0
@1@1878:
   ;	
   ;	                                      if (history_pos==history_nxt)
   ;	
	mov	ax,word ptr DGROUP:history_pos
	cmp	ax,word ptr DGROUP:history_nxt
	jne	short @1@1934
   ;	
   ;	                                         history_pos = -1;
   ;	
	mov	word ptr DGROUP:history_pos,-1
@1@1934:
	jmp	short @1@1990
@1@1962:
   ;	
   ;	                                   }
   ;	                                   /* Limpa a linha de comandos */
   ;	                                   while (numcar>0)  {
   ;	                                         --numcar;
   ;	
	dec	si
   ;	
   ;	                                         command_backspace();
   ;	
	call	near ptr command_backspace
@1@1990:
	or	si,si
	jg	short @1@1962
   ;	
   ;	                                   }
   ;	                                   if (history_pos!=-1)  {
   ;	
	cmp	word ptr DGROUP:history_pos,-1
	je	short @1@2074
   ;	
   ;	                                      strcpy(cmdline,history[history_pos]);
   ;	
	push	ds
	mov	ax,word ptr DGROUP:history_pos
	mov	dx,31
	imul	dx
	add	ax,offset DGROUP:history
	push	ax
	push	ds
	mov	ax,offset DGROUP:cmdline
	push	ax
	call	near ptr _strcpy
	add	sp,8
   ;	
   ;	                                      putstr(cmdline);
   ;	
	push	ds
	mov	ax,offset DGROUP:cmdline
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	                                      numcar=strlen(cmdline);
   ;	
	push	ds
	mov	ax,offset DGROUP:cmdline
	push	ax
	call	near ptr _strlen
	pop	cx
	pop	cx
	mov	si,ax
@1@2074:
   ;	
   ;	                                   }
   ;	                                }
   ;	                                break;
   ;	
	jmp	short @1@2102
@1@2102:
   ;	
   ;	                    }
   ;	                    break;
   ;	
	jmp	@1@3362
@1@2130:
   ;	
   ;	               case 13:
   ;	                    history_pos = -1;
   ;	
	mov	word ptr DGROUP:history_pos,-1
   ;	
   ;	                    putch('\n');
   ;	
	mov	ax,10
	push	ax
	call	near ptr _putch
	pop	cx
   ;	
   ;	                    cmdline[numcar]='\0';
   ;	
	mov	byte ptr DGROUP:cmdline[si],0
   ;	
   ;	                    /* Divide a linha de comandos em comando e opções */
   ;	                    ptrline = cmdline;
   ;	
	mov	word ptr [bp-24],ds
	mov	word ptr [bp-26],offset DGROUP:cmdline
   ;	
   ;	                    argc = 0;
   ;	
	mov	word ptr [bp-22],0
   ;	
   ;	                    pos = 0;
   ;	
	mov	word ptr [bp-16],0
@1@2158:
	jmp	short @1@2214
@1@2186:
   ;	
   ;	                    while (1) {
   ;	                          while (*ptrline!='\0' && (*ptrline==' ' || *ptrline=='\t'))
   ;	                                ++ptrline;
   ;	
	inc	word ptr [bp-26]
@1@2214:
	les	bx,dword ptr [bp-26]
	cmp	byte ptr es:[bx],0
	je	short @1@2298
	les	bx,dword ptr [bp-26]
	cmp	byte ptr es:[bx],32
	je	short @1@2186
	les	bx,dword ptr [bp-26]
	cmp	byte ptr es:[bx],9
	je	short @1@2186
@1@2298:
   ;	
   ;	                          if (*ptrline=='\0')
   ;	
	les	bx,dword ptr [bp-26]
	cmp	byte ptr es:[bx],0
	jne	short @1@2354
   ;	
   ;	                             break;
   ;	
	jmp	@1@2718
@1@2354:
   ;	
   ;	                          i = 0;     
   ;	
	xor	di,di
	jmp	short @1@2410
@1@2382:
   ;	
   ;	                          while (*ptrline!='\0' && *ptrline!=' ' && *ptrline!='\t')  {
   ;	                                palavra[i++] = *ptrline;
   ;	
	les	bx,dword ptr [bp-26]
	mov	al,byte ptr es:[bx]
	mov	byte ptr DGROUP:palavra[di],al
	inc	di
   ;	
   ;	                                ++ptrline;
   ;	
	inc	word ptr [bp-26]
@1@2410:
	les	bx,dword ptr [bp-26]
	cmp	byte ptr es:[bx],0
	je	short @1@2494
	les	bx,dword ptr [bp-26]
	cmp	byte ptr es:[bx],32
	je	short @1@2494
	les	bx,dword ptr [bp-26]
	cmp	byte ptr es:[bx],9
	jne	short @1@2382
@1@2494:
   ;	
   ;	                          }
   ;	                          palavra[i] = '\0';
   ;	
	mov	byte ptr DGROUP:palavra[di],0
   ;	
   ;	                          if (palavra[0]=='$')  {
   ;	
	cmp	byte ptr DGROUP:palavra,36
	jne	short @1@2606
   ;	
   ;	                             var = command_var_value(&palavra[1]);
   ;	
	push	ds
	mov	ax,offset DGROUP:palavra+1
	push	ax
	call	near ptr command_var_value
	pop	cx
	pop	cx
	mov	word ptr [bp-28],dx
	mov	word ptr [bp-30],ax
   ;	
   ;	                             if (var!=NULL)  {
   ;	
	mov	ax,word ptr [bp-30]
	or	ax,word ptr [bp-28]
	je	short @1@2578
   ;	
   ;	                                strcpy(palavra,var);
   ;	
	push	word ptr [bp-28]
	push	word ptr [bp-30]
	push	ds
	mov	ax,offset DGROUP:palavra
	push	ax
	call	near ptr _strcpy
	add	sp,8
   ;	
   ;	                                i = strlen(palavra);
   ;	
	push	ds
	mov	ax,offset DGROUP:palavra
	push	ax
	call	near ptr _strlen
	pop	cx
	pop	cx
	mov	di,ax
   ;	
   ;	                             }
   ;	
	jmp	short @1@2606
@1@2578:
   ;	
   ;	                             else
   ;	                                continue;
   ;	
	jmp	short @1@2690
@1@2606:
   ;	
   ;	                             
   ;	                          }
   ;	                          strcpy(&argline[pos],palavra);
   ;	
	push	ds
	mov	ax,offset DGROUP:palavra
	push	ax
	push	ds
	mov	ax,word ptr [bp-16]
	add	ax,offset DGROUP:argline
	push	ax
	call	near ptr _strcpy
	add	sp,8
   ;	
   ;	                          argv[argc++] = &argline[pos];
   ;	
	mov	ax,word ptr [bp-16]
	add	ax,offset DGROUP:argline
	mov	bx,word ptr [bp-22]
	mov	cl,2
	shl	bx,cl
	mov	word ptr DGROUP:argv[bx+2],ds
	mov	word ptr DGROUP:argv[bx],ax
	inc	word ptr [bp-22]
   ;	
   ;	                          pos+= (i+1);
   ;	
	mov	ax,di
	inc	ax
	add	word ptr [bp-16],ax
   ;	
   ;	                          if (*ptrline=='\0')
   ;	
	les	bx,dword ptr [bp-26]
	cmp	byte ptr es:[bx],0
	jne	short @1@2662
   ;	
   ;	                             break;
   ;	
	jmp	short @1@2718
@1@2662:
   ;	
   ;	                          ++ptrline;
   ;	
	inc	word ptr [bp-26]
@1@2690:
	jmp	@1@2158
@1@2718:
   ;	
   ;	                    }
   ;	                    /* Se é comando vazio não faz nada */
   ;	                    if (argc==0)  {
   ;	
	cmp	word ptr [bp-22],0
	jne	short @1@2774
   ;	
   ;	                       command_showprompt();
   ;	
	call	near ptr command_showprompt
   ;	
   ;	                       break;
   ;	
	jmp	@1@3362
@1@2774:
   ;	
   ;	                    }
   ;	                    /* Salva linha de comando no histórico */
   ;	                    strcpy (history[history_nxt],cmdline);
   ;	
	push	ds
	mov	ax,offset DGROUP:cmdline
	push	ax
	push	ds
	mov	ax,word ptr DGROUP:history_nxt
	mov	dx,31
	imul	dx
	add	ax,offset DGROUP:history
	push	ax
	call	near ptr _strcpy
	add	sp,8
   ;	
   ;	                    if (history_len<MAXHISTORY)
   ;	
	cmp	word ptr DGROUP:history_len,10
	jge	short @1@2830
   ;	
   ;	                       ++history_len;
   ;	
	inc	word ptr DGROUP:history_len
	jmp	short @1@2914
@1@2830:
   ;	
   ;	                    else  {
   ;	                       if (history_ini==MAXHISTORY-1)
   ;	
	cmp	word ptr DGROUP:history_ini,9
	jne	short @1@2886
   ;	
   ;	                          history_ini = 0;
   ;	
	mov	word ptr DGROUP:history_ini,0
	jmp	short @1@2914
@1@2886:
   ;	
   ;	                       else
   ;	                          ++history_ini;
   ;	
	inc	word ptr DGROUP:history_ini
@1@2914:
   ;	
   ;	                    }
   ;	                    if (history_nxt==MAXHISTORY-1)
   ;	
	cmp	word ptr DGROUP:history_nxt,9
	jne	short @1@2970
   ;	
   ;	                       history_nxt = 0;
   ;	
	mov	word ptr DGROUP:history_nxt,0
	jmp	short @1@2998
@1@2970:
   ;	
   ;	                    else
   ;	                       ++history_nxt;
   ;	
	inc	word ptr DGROUP:history_nxt
@1@2998:
   ;	
   ;	                    /* Verifica qual é o comando ... */
   ;	                    achou = 0;
   ;	
	mov	word ptr [bp-14],0
   ;	
   ;	                    for (i=0;i<MAXCOMMANDS;++i)  {
   ;	
	xor	di,di
	jmp	short @1@3110
@1@3026:
   ;	
   ;	                        if (strcmp(argv[0],commands[i].name)==0)  {
   ;	
	push	ds
	mov	ax,di
	mov	dx,6
	imul	dx
	mov	bx,ax
	push	word ptr DGROUP:commands[bx]
	push	word ptr DGROUP:argv+2
	push	word ptr DGROUP:argv
	call	near ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @1@3082
   ;	
   ;	                           achou=1;
   ;	
	mov	word ptr [bp-14],1
   ;	
   ;	                           break;
   ;	
	jmp	short @1@3138
@1@3082:
	inc	di
@1@3110:
	cmp	di,25
	jl	short @1@3026
@1@3138:
   ;	
   ;	                        }
   ;	                    }
   ;	
   ;	                    /* Executa o comando */
   ;	                    if (achou)  {
   ;	
	cmp	word ptr [bp-14],0
	je	short @1@3194
   ;	
   ;	                       res = commands[i].code(argc,argv);
   ;	
	mov	ax,offset DGROUP:argv
	push	ax
	push	word ptr [bp-22]
	mov	ax,di
	mov	dx,6
	imul	dx
	mov	bx,ax
	call	word ptr DGROUP:commands[bx+4]
	pop	cx
	pop	cx
	mov	word ptr [bp-20],ax
   ;	
   ;	                       inttostr(str,res);
   ;	
	push	word ptr [bp-20]
	push	ss
	lea	ax,word ptr [bp-12]
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;	                       command_var_set("ERRORLEVEL",str);
   ;	
	push	ss
	lea	ax,word ptr [bp-12]
	push	ax
	push	ds
	mov	ax,offset DGROUP:s@+1419
	push	ax
	call	near ptr command_var_set
	add	sp,8
   ;	
   ;	                    }
   ;	
	jmp	short @1@3222
@1@3194:
   ;	
   ;	                    else
   ;	                       putstr("Erro: comando desconhecido!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1430
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
@1@3222:
   ;	
   ;	
   ;	                    if (!end_command)
   ;	
	cmp	word ptr DGROUP:end_command,0
	jne	short @1@3278
   ;	
   ;	                       command_showprompt();
   ;	
	call	near ptr command_showprompt
@1@3278:
   ;	
   ;	
   ;	                    numcar=0;
   ;	
	xor	si,si
   ;	
   ;	                    break;
   ;	
	jmp	short @1@3362
@1@3306:
   ;	
   ;	               default:
   ;	                    if (numcar<MAXLINE)  {
   ;	
	cmp	si,30
	jge	short @1@3362
   ;	
   ;	                       putch(car);
   ;	
	mov	al,byte ptr [bp-1]
	cbw	
	push	ax
	call	near ptr _putch
	pop	cx
   ;	
   ;	                       cmdline[numcar++]=car;
   ;	
	mov	al,byte ptr [bp-1]
	mov	byte ptr DGROUP:cmdline[si],al
	inc	si
@1@3362:
	cmp	word ptr DGROUP:end_command,0
	jne	@@3
	jmp	@1@58
@@3:
   ;	
   ;	                    }
   ;	        }
   ;	  }
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_command	endp
@1@C3330	label	word
	db	65
	db	0
	db	72
	db	0
	db	75
	db	0
	db	80
	db	0
	dw	@1@674
	dw	@1@982
	dw	@1@898
	dw	@1@1626
@1@C3234	label	word
	db	0
	db	0
	db	8
	db	0
	db	9
	db	0
	db	13
	db	0
	db	27
	db	0
	dw	@1@478
	dw	@1@282
	dw	@1@254
	dw	@1@2130
	dw	@1@366
   ;	
   ;	static void command_backspace()
   ;	
	assume	cs:_TEXT
command_backspace	proc	near
	push	bp
	mov	bp,sp
	push	si
	push	di
   ;	
   ;	{
   ;	  int x,y;
   ;	
   ;	  x = wherex();
   ;	
	call	near ptr _wherex
	mov	si,ax
   ;	
   ;	  y = wherey();
   ;	
	call	near ptr _wherey
	mov	di,ax
   ;	
   ;	  --x;
   ;	
	dec	si
   ;	
   ;	  gotoxy(x,y);
   ;	
	push	di
	push	si
	call	near ptr _gotoxy
	pop	cx
	pop	cx
   ;	
   ;	  putch(' ');
   ;	
	mov	ax,32
	push	ax
	call	near ptr _putch
	pop	cx
   ;	
   ;	  gotoxy(x,y);
   ;	
	push	di
	push	si
	call	near ptr _gotoxy
	pop	cx
	pop	cx
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	pop	bp
	ret	
command_backspace	endp
   ;	
   ;	static void command_showprompt()
   ;	
	assume	cs:_TEXT
command_showprompt	proc	near
	push	bp
	mov	bp,sp
	sub	sp,6
   ;	
   ;	{
   ;	  char cor;
   ;	  char far *prompt;
   ;	
   ;	  prompt = command_var_value("PROMPT");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1459
	push	ax
	call	near ptr command_var_value
	pop	cx
	pop	cx
	mov	word ptr [bp-4],dx
	mov	word ptr [bp-6],ax
   ;	
   ;	  if (prompt!=NULL)  {
   ;	
	mov	ax,word ptr [bp-6]
	or	ax,word ptr [bp-4]
	je	short @3@86
   ;	
   ;	     cor = getcolor();
   ;	
	call	near ptr _getcolor
	mov	byte ptr [bp-1],al
   ;	
   ;	     setcolor(PROMPTCOLOR);
   ;	
	mov	ax,9
	push	ax
	call	near ptr _setcolor
	pop	cx
   ;	
   ;	     putstr(prompt);
   ;	
	push	word ptr [bp-4]
	push	word ptr [bp-6]
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	     setcolor(cor);
   ;	
	mov	al,byte ptr [bp-1]
	cbw	
	push	ax
	call	near ptr _setcolor
	pop	cx
@3@86:
   ;	
   ;	  }
   ;	  putch(' ');
   ;	
	mov	ax,32
	push	ax
	call	near ptr _putch
	pop	cx
   ;	
   ;	}
   ;	
	mov	sp,bp
	pop	bp
	ret	
command_showprompt	endp
   ;	
   ;	static void command_var_init()
   ;	
	assume	cs:_TEXT
command_var_init	proc	near
	push	bp
	mov	bp,sp
   ;	
   ;	{
   ;	  int i;
   ;	
   ;	  for (i=0;i<VAR_MAX;++i)  {
   ;	
	xor	cx,cx
	jmp	short @4@114
@4@58:
   ;	
   ;	      var[i].name[0]='\0';
   ;	
	mov	ax,cx
	mov	dx,50
	imul	dx
	mov	bx,ax
	mov	byte ptr DGROUP:var[bx],0
   ;	
   ;	      var[i].value[0]='\0';
   ;	
	mov	ax,cx
	mov	dx,50
	imul	dx
	mov	bx,ax
	mov	byte ptr DGROUP:var[bx+13],0
	inc	cx
@4@114:
	cmp	cx,10
	jl	short @4@58
   ;	
   ;	  }
   ;	  num_var = 0;
   ;	
	mov	word ptr DGROUP:num_var,0
   ;	
   ;	}
   ;	
	pop	bp
	ret	
command_var_init	endp
   ;	
   ;	static int command_var_nextfree()
   ;	
	assume	cs:_TEXT
command_var_nextfree	proc	near
	push	bp
	mov	bp,sp
   ;	
   ;	{
   ;	  int i;
   ;	
   ;	  if (num_var>=VAR_MAX)
   ;	
	cmp	word ptr DGROUP:num_var,10
	jl	short @5@114
@5@58:
   ;	
   ;	     return -1;
   ;	
	mov	ax,-1
@5@86:
	jmp	short @5@282
@5@114:
   ;	
   ;	  for (i=0;i<VAR_MAX;++i)
   ;	
	xor	cx,cx
	jmp	short @5@226
@5@142:
   ;	
   ;	      if (var[i].name[0]=='\0')
   ;	
	mov	ax,cx
	mov	dx,50
	imul	dx
	mov	bx,ax
	cmp	byte ptr DGROUP:var[bx],0
	jne	short @5@198
   ;	
   ;	         return i;
   ;	
	mov	ax,cx
	jmp	short @5@86
@5@198:
	inc	cx
@5@226:
	cmp	cx,10
	jl	short @5@142
	jmp	short @5@58
@5@282:
   ;	
   ;	  return -1;
   ;	}
   ;	
	pop	bp
	ret	
command_var_nextfree	endp
   ;	
   ;	static void command_var_list()
   ;	
	assume	cs:_TEXT
command_var_list	proc	near
	push	bp
	mov	bp,sp
	sub	sp,2
	push	si
   ;	
   ;	{
   ;	  int i;
   ;	  char cor;
   ;	
   ;	  cor = getcolor();
   ;	
	call	near ptr _getcolor
	mov	byte ptr [bp-1],al
   ;	
   ;	  for (i=0;i<VAR_MAX;++i)  {
   ;	
	xor	si,si
	jmp	short @6@142
@6@58:
   ;	
   ;	      if (var[i].name[0]!='\0')  {
   ;	
	mov	ax,si
	mov	dx,50
	imul	dx
	mov	bx,ax
	cmp	byte ptr DGROUP:var[bx],0
	je	short @6@114
   ;	
   ;	         putstr(var[i].name);
   ;	
	push	ds
	mov	ax,si
	mov	dx,50
	imul	dx
	add	ax,offset DGROUP:var
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	         putch('=');
   ;	
	mov	ax,61
	push	ax
	call	near ptr _putch
	pop	cx
   ;	
   ;	         setcolor(VARCOLOR);
   ;	
	mov	ax,14
	push	ax
	call	near ptr _setcolor
	pop	cx
   ;	
   ;	         putstr(var[i].value);
   ;	
	push	ds
	mov	ax,si
	mov	dx,50
	imul	dx
	add	ax,offset DGROUP:var+13
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	         setcolor(cor);
   ;	
	mov	al,byte ptr [bp-1]
	cbw	
	push	ax
	call	near ptr _setcolor
	pop	cx
   ;	
   ;	         putch('\n');
   ;	
	mov	ax,10
	push	ax
	call	near ptr _putch
	pop	cx
@6@114:
	inc	si
@6@142:
	cmp	si,10
	jl	short @6@58
   ;	
   ;	      }
   ;	  }
   ;	}
   ;	
	pop	si
	mov	sp,bp
	pop	bp
	ret	
command_var_list	endp
   ;	
   ;	static int  command_var_search(char far *nome)
   ;	
	assume	cs:_TEXT
command_var_search	proc	near
	push	bp
	mov	bp,sp
	push	si
   ;	
   ;	{
   ;	  int i;
   ;	
   ;	  if (nome[0] == '\0')
   ;	
	les	bx,dword ptr [bp+4]
	cmp	byte ptr es:[bx],0
	jne	short @7@114
@7@58:
   ;	
   ;	     return -1;
   ;	
	mov	ax,-1
@7@86:
	jmp	short @7@282
@7@114:
   ;	
   ;	  for (i=0;i<VAR_MAX;++i)  {
   ;	
	xor	si,si
	jmp	short @7@226
@7@142:
   ;	
   ;	      if (strcmp(nome,var[i].name)==0)
   ;	
	push	ds
	mov	ax,si
	mov	dx,50
	imul	dx
	add	ax,offset DGROUP:var
	push	ax
	push	word ptr [bp+6]
	push	word ptr [bp+4]
	call	near ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @7@198
   ;	
   ;	         return i;
   ;	
	mov	ax,si
	jmp	short @7@86
@7@198:
	inc	si
@7@226:
	cmp	si,10
	jl	short @7@142
	jmp	short @7@58
@7@282:
   ;	
   ;	  }
   ;	  return -1;
   ;	}
   ;	
	pop	si
	pop	bp
	ret	
command_var_search	endp
   ;	
   ;	static int  command_var_unset(char far *nome)
   ;	
	assume	cs:_TEXT
command_var_unset	proc	near
	push	bp
	mov	bp,sp
	push	si
   ;	
   ;	{
   ;	  int i;
   ;	
   ;	  i = command_var_search(nome);
   ;	
	push	word ptr [bp+6]
	push	word ptr [bp+4]
	call	near ptr command_var_search
	pop	cx
	pop	cx
	mov	si,ax
   ;	
   ;	  if (i==-1)
   ;	
	cmp	si,-1
	jne	short @8@114
   ;	
   ;	     return -1;
   ;	
	mov	ax,-1
@8@86:
	jmp	short @8@142
@8@114:
   ;	
   ;	  var[i].name[0]='\0';
   ;	
	mov	ax,si
	mov	dx,50
	imul	dx
	mov	bx,ax
	mov	byte ptr DGROUP:var[bx],0
   ;	
   ;	  var[i].value[0]='\0';
   ;	
	mov	ax,si
	mov	dx,50
	imul	dx
	mov	bx,ax
	mov	byte ptr DGROUP:var[bx+13],0
   ;	
   ;	  --num_var;
   ;	
	dec	word ptr DGROUP:num_var
   ;	
   ;	  return 0;
   ;	
	xor	ax,ax
	jmp	short @8@86
@8@142:
   ;	
   ;	}
   ;	
	pop	si
	pop	bp
	ret	
command_var_unset	endp
   ;	
   ;	static char far *command_var_value(char far *nome)
   ;	
	assume	cs:_TEXT
command_var_value	proc	near
	push	bp
	mov	bp,sp
	push	si
   ;	
   ;	{
   ;	  int i;
   ;	
   ;	  i = command_var_search(nome);
   ;	
	push	word ptr [bp+6]
	push	word ptr [bp+4]
	call	near ptr command_var_search
	pop	cx
	pop	cx
	mov	si,ax
   ;	
   ;	  if (i==-1)
   ;	
	cmp	si,-1
	jne	short @9@114
   ;	
   ;	     return NULL;
   ;	
	xor	dx,dx
	xor	ax,ax
@9@86:
	jmp	short @9@142
@9@114:
   ;	
   ;	  return var[i].value;
   ;	
	mov	ax,si
	mov	dx,50
	imul	dx
	add	ax,offset DGROUP:var+13
	mov	dx,ds
	jmp	short @9@86
@9@142:
   ;	
   ;	}
   ;	
	pop	si
	pop	bp
	ret	
command_var_value	endp
   ;	
   ;	static int command_var_set(char far *nome,char far *valor)
   ;	
	assume	cs:_TEXT
command_var_set	proc	near
	push	bp
	mov	bp,sp
	push	si
   ;	
   ;	{
   ;	  int i;
   ;	
   ;	  if (strlen(nome)>VAR_NOME_TAM)
   ;	
	push	word ptr [bp+6]
	push	word ptr [bp+4]
	call	near ptr _strlen
	pop	cx
	pop	cx
	cmp	ax,12
	jbe	short @10@114
   ;	
   ;	     return -3;
   ;	
	mov	ax,-3
@10@86:
	jmp	short @10@310
@10@114:
   ;	
   ;	  if (strlen(valor)>VAR_VALOR_TAM)
   ;	
	push	word ptr [bp+10]
	push	word ptr [bp+8]
	call	near ptr _strlen
	pop	cx
	pop	cx
	cmp	ax,36
	jbe	short @10@170
   ;	
   ;	     return -4;
   ;	
	mov	ax,-4
	jmp	short @10@86
@10@170:
   ;	
   ;	  i = command_var_search(nome);
   ;	
	push	word ptr [bp+6]
	push	word ptr [bp+4]
	call	near ptr command_var_search
	pop	cx
	pop	cx
	mov	si,ax
   ;	
   ;	  if (i==-1)  {
   ;	
	cmp	si,-1
	jne	short @10@282
   ;	
   ;	     i = command_var_nextfree();
   ;	
	call	near ptr command_var_nextfree
	mov	si,ax
   ;	
   ;	     if (i==-1)
   ;	
	cmp	si,-1
	jne	short @10@254
   ;	
   ;	        return -2;
   ;	
	mov	ax,-2
	jmp	short @10@86
@10@254:
   ;	
   ;	     strcpy(var[i].name,nome);
   ;	
	push	word ptr [bp+6]
	push	word ptr [bp+4]
	push	ds
	mov	ax,si
	mov	dx,50
	imul	dx
	add	ax,offset DGROUP:var
	push	ax
	call	near ptr _strcpy
	add	sp,8
@10@282:
   ;	
   ;	  }
   ;	  strcpy(var[i].value,valor);
   ;	
	push	word ptr [bp+10]
	push	word ptr [bp+8]
	push	ds
	mov	ax,si
	mov	dx,50
	imul	dx
	add	ax,offset DGROUP:var+13
	push	ax
	call	near ptr _strcpy
	add	sp,8
   ;	
   ;	  return 0;
   ;	
	xor	ax,ax
	jmp	short @10@86
@10@310:
   ;	
   ;	}
   ;	
	pop	si
	pop	bp
	ret	
command_var_set	endp
   ;	
   ;	int cmd_reboot(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_reboot	proc	near
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	si,word ptr [bp+4]
	mov	di,word ptr [bp+6]
   ;	
   ;	{
   ;	  argc=argc;
   ;	
   ;	
   ;	  argv=argv;
   ;	
   ;	
   ;	  reboot();
   ;	
	call	near ptr _reboot
   ;	
   ;	  return 0;
   ;	
	xor	ax,ax
	jmp	short @11@58
@11@58:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	pop	bp
	ret	
_cmd_reboot	endp
   ;	
   ;	int cmd_exit(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_exit	proc	near
	push	bp
	mov	bp,sp
	mov	dx,word ptr [bp+4]
	mov	bx,word ptr [bp+6]
   ;	
   ;	{
   ;	  argc=argc;
   ;	
   ;	
   ;	  argv=argv;
   ;	
   ;	
   ;	  end_command = 1;
   ;	
	mov	word ptr DGROUP:end_command,1
   ;	
   ;	  return 0;
   ;	
	xor	ax,ax
	jmp	short @12@58
@12@58:
   ;	
   ;	}
   ;	
	pop	bp
	ret	
_cmd_exit	endp
   ;	
   ;	int cmd_help(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_help	proc	near
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	di,word ptr [bp+4]
   ;	
   ;	{
   ;	  int i;
   ;	
   ;	  argc=argc;
   ;	
   ;	
   ;	  argv=argv;
   ;	
	mov	ax,word ptr [bp+6]
	mov	word ptr [bp+6],ax
   ;	
   ;	  putstr("Comandos do minisSistema Operacional:\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1466
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	  for (i=0;i<MAXCOMMANDS;++i)  {
   ;	
	xor	si,si
	jmp	short @13@114
@13@58:
   ;	
   ;	      putstr(commands[i].name);
   ;	
	push	ds
	mov	ax,si
	mov	dx,6
	imul	dx
	mov	bx,ax
	push	word ptr DGROUP:commands[bx]
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	      putstr(commands[i].help);
   ;	
	push	ds
	mov	ax,si
	mov	dx,6
	imul	dx
	mov	bx,ax
	push	word ptr DGROUP:commands[bx+2]
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	      putch('\n');
   ;	
	mov	ax,10
	push	ax
	call	near ptr _putch
	pop	cx
	inc	si
@13@114:
	cmp	si,25
	jl	short @13@58
   ;	
   ;	  }
   ;	  return 0;
   ;	
	xor	ax,ax
	jmp	short @13@170
@13@170:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	pop	bp
	ret	
_cmd_help	endp
   ;	
   ;	int cmd_date(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_date	proc	near
	push	bp
	mov	bp,sp
	sub	sp,24
	push	si
	push	di
	mov	si,word ptr [bp+4]
	mov	di,word ptr [bp+6]
   ;	
   ;	{
   ;	  struct date d;
   ;	  char str[20];
   ;	
   ;	  argc=argc;
   ;	
   ;	
   ;	  argv=argv;
   ;	
   ;	
   ;	
   ;	
   ;	
   ;	  getdate(&d);
   ;	
	push	ss
	lea	ax,word ptr [bp-4]
	push	ax
	call	near ptr _getdate
	pop	cx
	pop	cx
   ;	
   ;	  unsignedtostr(str,d.da_day,2,'0');
   ;	
	mov	al,48
	push	ax
	mov	ax,2
	push	ax
	mov	al,byte ptr [bp-2]
	cbw	
	push	ax
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _unsignedtostr
	add	sp,10
   ;	
   ;	  putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	  putch('/');
   ;	
	mov	ax,47
	push	ax
	call	near ptr _putch
	pop	cx
   ;	
   ;	  unsignedtostr(str,d.da_mon,2,'0');
   ;	
	mov	al,48
	push	ax
	mov	ax,2
	push	ax
	mov	al,byte ptr [bp-1]
	cbw	
	push	ax
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _unsignedtostr
	add	sp,10
   ;	
   ;	  putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	  putch('/');
   ;	
	mov	ax,47
	push	ax
	call	near ptr _putch
	pop	cx
   ;	
   ;	  unsignedtostr(str,d.da_year,4,'0');
   ;	
	mov	al,48
	push	ax
	mov	ax,4
	push	ax
	push	word ptr [bp-4]
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _unsignedtostr
	add	sp,10
   ;	
   ;	  putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	  putch('\n');
   ;	
	mov	ax,10
	push	ax
	call	near ptr _putch
	pop	cx
   ;	
   ;	  return 0;
   ;	
	xor	ax,ax
	jmp	short @14@58
@14@58:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_cmd_date	endp
   ;	
   ;	int cmd_time(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_time	proc	near
	push	bp
	mov	bp,sp
	sub	sp,24
	push	si
	push	di
	mov	si,word ptr [bp+4]
	mov	di,word ptr [bp+6]
   ;	
   ;	{
   ;	  struct time t;
   ;	  char str[20];
   ;	
   ;	  argc=argc;
   ;	
   ;	
   ;	  argv=argv;
   ;	
   ;	
   ;	  gettime(&t);
   ;	
	push	ss
	lea	ax,word ptr [bp-4]
	push	ax
	call	near ptr _gettime
	pop	cx
	pop	cx
   ;	
   ;	  unsignedtostr(str,t.ti_hour,2,'0');
   ;	
	mov	al,48
	push	ax
	mov	ax,2
	push	ax
	mov	al,byte ptr [bp-3]
	mov	ah,0
	push	ax
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _unsignedtostr
	add	sp,10
   ;	
   ;	  putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	  putch(':');
   ;	
	mov	ax,58
	push	ax
	call	near ptr _putch
	pop	cx
   ;	
   ;	
   ;	
   ;	  unsignedtostr(str,t.ti_min,2,'0');
   ;	
	mov	al,48
	push	ax
	mov	ax,2
	push	ax
	mov	al,byte ptr [bp-4]
	mov	ah,0
	push	ax
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _unsignedtostr
	add	sp,10
   ;	
   ;	  putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	  putch(':');
   ;	
	mov	ax,58
	push	ax
	call	near ptr _putch
	pop	cx
   ;	
   ;	  unsignedtostr(str,t.ti_sec,2,'0');
   ;	
	mov	al,48
	push	ax
	mov	ax,2
	push	ax
	mov	al,byte ptr [bp-1]
	mov	ah,0
	push	ax
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _unsignedtostr
	add	sp,10
   ;	
   ;	  putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	  putch('\n');
   ;	
	mov	ax,10
	push	ax
	call	near ptr _putch
	pop	cx
   ;	
   ;	  return 0;
   ;	
	xor	ax,ax
	jmp	short @15@58
@15@58:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_cmd_time	endp
   ;	
   ;	int cmd_cls(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_cls	proc	near
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	si,word ptr [bp+4]
	mov	di,word ptr [bp+6]
   ;	
   ;	{
   ;	  argc=argc;
   ;	
   ;	
   ;	  argv=argv;
   ;	
   ;	
   ;	  clrscr();
   ;	
	call	near ptr _clrscr
   ;	
   ;	  return 0;
   ;	
	xor	ax,ax
	jmp	short @16@58
@16@58:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	pop	bp
	ret	
_cmd_cls	endp
   ;	
   ;	int cmd_ver(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_ver	proc	near
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	si,word ptr [bp+4]
	mov	di,word ptr [bp+6]
   ;	
   ;	{
   ;	  argc=argc;
   ;	
   ;	
   ;	  argv=argv;
   ;	
   ;	
   ;	  putstr("minisSistema Operacional - Vs ");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1505
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	  putstr(miniSO_VERSION);
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1536
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	  putch('\n');
   ;	
	mov	ax,10
	push	ax
	call	near ptr _putch
	pop	cx
   ;	
   ;	  return 0;
   ;	
	xor	ax,ax
	jmp	short @17@58
@17@58:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	pop	bp
	ret	
_cmd_ver	endp
_TEXT	ends
_BSS	segment word public 'BSS'
	db	20 dup (?)
_BSS	ends
_TEXT	segment byte public 'CODE'
   ;	
   ;	int cmd_ps(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_ps	proc	near
	push	bp
	mov	bp,sp
	push	si
	push	di
   ;	
   ;	{
   ;	  int i,l;
   ;	  static char str[20];
   ;	  extern miniSO_PCB miniSO_thread[];
   ;	
   ;	  argc=argc;
   ;	
	mov	ax,word ptr [bp+4]
	mov	word ptr [bp+4],ax
   ;	
   ;	  argv=argv;
   ;	
	mov	ax,word ptr [bp+6]
	mov	word ptr [bp+6],ax
   ;	
   ;	  putstr(" BCP   PID   PPID  STATUS   WAIT   ZLIST  PREV   NEXT\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1541
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	  for (i=0;i<miniSO_MAXTHREADS;++i)  {
   ;	
	xor	di,di
	jmp	@18@1094
@18@58:
   ;	
   ;	      if (miniSO_thread[i].status!=FREE)  {
   ;	
	mov	ax,di
	mov	dx,26
	imul	dx
	mov	bx,ax
	cmp	word ptr DGROUP:_miniSO_thread[bx+4],-1
	jne	@@4
	jmp	@18@1066
@@4:
   ;	
   ;	         inttostr(str,i);
   ;	
	push	di
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;	         l=strlen(str);
   ;	
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _strlen
	pop	cx
	pop	cx
	mov	si,ax
	jmp	short @18@142
@18@114:
   ;	
   ;	         while (l++<3)
   ;	               putch(' ');
   ;	
	mov	ax,32
	push	ax
	call	near ptr _putch
	pop	cx
@18@142:
	mov	ax,si
	inc	si
	cmp	ax,3
	jl	short @18@114
   ;	
   ;	         putstr(str);
   ;	
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	         putstr("  ");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1596
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	         inttostr(str,miniSO_thread[i].pid);
   ;	
	mov	ax,di
	mov	dx,26
	imul	dx
	mov	bx,ax
	push	word ptr DGROUP:_miniSO_thread[bx]
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;	         l=strlen(str);
   ;	
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _strlen
	pop	cx
	pop	cx
	mov	si,ax
	jmp	short @18@226
@18@198:
   ;	
   ;	         while (l++<5)
   ;	               putch(' ');
   ;	
	mov	ax,32
	push	ax
	call	near ptr _putch
	pop	cx
@18@226:
	mov	ax,si
	inc	si
	cmp	ax,5
	jl	short @18@198
   ;	
   ;	         putstr(str);
   ;	
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	         putstr("  ");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1599
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	         inttostr(str,miniSO_thread[i].ppid);
   ;	
	mov	ax,di
	mov	dx,26
	imul	dx
	mov	bx,ax
	push	word ptr DGROUP:_miniSO_thread[bx+2]
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;	         l=strlen(str);
   ;	
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _strlen
	pop	cx
	pop	cx
	mov	si,ax
	jmp	short @18@310
@18@282:
   ;	
   ;	         while (l++<5)
   ;	               putch(' ');
   ;	
	mov	ax,32
	push	ax
	call	near ptr _putch
	pop	cx
@18@310:
	mov	ax,si
	inc	si
	cmp	ax,5
	jl	short @18@282
   ;	
   ;	         putstr(str);
   ;	
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	         putstr("  ");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1602
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	         switch(miniSO_thread[i].status)  {
   ;	
	mov	ax,di
	mov	dx,26
	imul	dx
	mov	bx,ax
	mov	bx,word ptr DGROUP:_miniSO_thread[bx+4]
	inc	bx
	cmp	bx,7
	ja	short @18@702
	shl	bx,1
	jmp	word ptr cs:@18@C1266[bx]
@18@450:
   ;	
   ;	               case FREE:    putstr(strFREE);    break;
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1605
@18@478:
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
	jmp	short @18@702
@18@506:
   ;	
   ;	               case READY:   putstr(strREADY);   break;
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1613
	jmp	short @18@478
@18@534:
   ;	
   ;	               case RUNNING: putstr(strRUNNING); break;
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1621
	jmp	short @18@478
@18@562:
   ;	
   ;	               case ZOMBIE:  putstr(strZOMBIE);  break;
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1629
	jmp	short @18@478
@18@590:
   ;	
   ;	               case WAIT:    putstr(strWAIT);    break;
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1637
	jmp	short @18@478
@18@618:
   ;	
   ;	               case WAITSIG: putstr(strWAITSIG); break;
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1645
	jmp	short @18@478
@18@646:
   ;	
   ;	               case WAITSEM: putstr(strWAITSEM); break;
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1653
	jmp	short @18@478
@18@674:
   ;	
   ;	               case STOPPED: putstr(strSTOPPED); break;
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1661
	jmp	short @18@478
@18@702:
   ;	
   ;	         }
   ;	         putstr("  ");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1669
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	         inttostr(str,miniSO_thread[i].wait);
   ;	
	mov	ax,di
	mov	dx,26
	imul	dx
	mov	bx,ax
	push	word ptr DGROUP:_miniSO_thread[bx+14]
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;	         l=strlen(str);
   ;	
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _strlen
	pop	cx
	pop	cx
	mov	si,ax
	jmp	short @18@758
@18@730:
   ;	
   ;	         while (l++<5)
   ;	               putch(' ');
   ;	
	mov	ax,32
	push	ax
	call	near ptr _putch
	pop	cx
@18@758:
	mov	ax,si
	inc	si
	cmp	ax,5
	jl	short @18@730
   ;	
   ;	         putstr(str);
   ;	
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	
   ;	         putstr("  ");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1672
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	         inttostr(str,miniSO_thread[i].zombies);
   ;	
	mov	ax,di
	mov	dx,26
	imul	dx
	mov	bx,ax
	push	word ptr DGROUP:_miniSO_thread[bx+20]
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;	         l=strlen(str);
   ;	
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _strlen
	pop	cx
	pop	cx
	mov	si,ax
	jmp	short @18@842
@18@814:
   ;	
   ;	         while (l++<5)
   ;	               putch(' ');
   ;	
	mov	ax,32
	push	ax
	call	near ptr _putch
	pop	cx
@18@842:
	mov	ax,si
	inc	si
	cmp	ax,5
	jl	short @18@814
   ;	
   ;	         putstr(str);
   ;	
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	
   ;	         putstr(" ");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1675
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	         inttostr(str,miniSO_thread[i].prev);
   ;	
	mov	ax,di
	mov	dx,26
	imul	dx
	mov	bx,ax
	push	word ptr DGROUP:_miniSO_thread[bx+22]
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;	         l=strlen(str);
   ;	
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _strlen
	pop	cx
	pop	cx
	mov	si,ax
	jmp	short @18@926
@18@898:
   ;	
   ;	         while (l++<5)
   ;	               putch(' ');
   ;	
	mov	ax,32
	push	ax
	call	near ptr _putch
	pop	cx
@18@926:
	mov	ax,si
	inc	si
	cmp	ax,5
	jl	short @18@898
   ;	
   ;	         putstr(str);
   ;	
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	
   ;	         putstr("  ");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1677
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	         inttostr(str,miniSO_thread[i].next);
   ;	
	mov	ax,di
	mov	dx,26
	imul	dx
	mov	bx,ax
	push	word ptr DGROUP:_miniSO_thread[bx+24]
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;	         l=strlen(str);
   ;	
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _strlen
	pop	cx
	pop	cx
	mov	si,ax
	jmp	short @18@1010
@18@982:
   ;	
   ;	         while (l++<5)
   ;	               putch(' ');
   ;	
	mov	ax,32
	push	ax
	call	near ptr _putch
	pop	cx
@18@1010:
	mov	ax,si
	inc	si
	cmp	ax,5
	jl	short @18@982
   ;	
   ;	         putstr(str);
   ;	
	push	ds
	mov	ax,offset DGROUP:b@w+0
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	         putch('\n');
   ;	
	mov	ax,10
	push	ax
	call	near ptr _putch
	pop	cx
@18@1066:
	inc	di
@18@1094:
	cmp	di,16
	jge	@@5
	jmp	@18@58
@@5:
   ;	
   ;	      }
   ;	  }
   ;	  return 0;
   ;	
	xor	ax,ax
	jmp	short @18@1150
@18@1150:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	pop	bp
	ret	
_cmd_ps	endp
@18@C1266	label	word
	dw	@18@450
	dw	@18@506
	dw	@18@534
	dw	@18@562
	dw	@18@590
	dw	@18@618
	dw	@18@646
	dw	@18@674
   ;	
   ;	int cmd_kill(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_kill	proc	near
	push	bp
	mov	bp,sp
	push	si
	push	di
   ;	
   ;	{
   ;	  int t=0;
   ;	
	xor	si,si
   ;	
   ;	  pid_t pid=0;
   ;	
	xor	di,di
   ;	
   ;	  char str[10];
   ;	
   ;	  if (argc<=1)  {
   ;	
	cmp	word ptr [bp+4],1
	jg	short @19@142
   ;	
   ;	     putstr("Erro em kill: parametro nao fornecido!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1680
@19@86:
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	     return 1;
   ;	
	mov	ax,1
@19@114:
	jmp	short @19@226
@19@142:
   ;	
   ;	  }
   ;	  pid = atoi(argv[1]);
   ;	
	mov	bx,word ptr [bp+6]
	push	word ptr [bx+6]
	push	word ptr [bx+4]
	call	near ptr _atoi
	pop	cx
	pop	cx
	mov	di,ax
   ;	
   ;	  t = kill(pid);
   ;	
	push	di
	call	near ptr _kill
	pop	cx
	mov	si,ax
   ;	
   ;	  if (t==miniSO_ERROR)  {
   ;	
	cmp	si,-1
	jne	short @19@198
   ;	
   ;	     putstr("kill: impossivel matar o processo/thread\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1720
	jmp	short @19@86
@19@198:
   ;	
   ;	     return 1;
   ;	  }
   ;	  return 0;
   ;	
	xor	ax,ax
	jmp	short @19@114
@19@226:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	pop	bp
	ret	
_cmd_kill	endp
   ;	
   ;	int cmd_set(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_set	proc	near
	push	bp
	mov	bp,sp
	sub	sp,2
	push	si
	push	di
	mov	si,word ptr [bp+4]
	mov	di,word ptr [bp+6]
   ;	
   ;	{
   ;	  int res;
   ;	
   ;	  if (argc == 1)  {
   ;	
	cmp	si,1
	jne	short @20@142
   ;	
   ;	     command_var_list();
   ;	
	call	near ptr command_var_list
   ;	
   ;	     return 0;
   ;	
@20@86:
	xor	ax,ax
@20@114:
	jmp	short @20@534
@20@142:
   ;	
   ;	  }
   ;	  if (argc == 2)
   ;	
	cmp	si,2
	jne	short @20@198
   ;	
   ;	     res = command_var_set(argv[1],"");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1762
	push	ax
	push	word ptr [di+6]
	push	word ptr [di+4]
	call	near ptr command_var_set
	add	sp,8
	mov	word ptr [bp-2],ax
	jmp	short @20@282
@20@198:
   ;	
   ;	  else if (argc == 3)
   ;	
	cmp	si,3
	jne	short @20@254
   ;	
   ;	       res = command_var_set(argv[1],argv[2]);
   ;	
	push	word ptr [di+10]
	push	word ptr [di+8]
	push	word ptr [di+6]
	push	word ptr [di+4]
	call	near ptr command_var_set
	add	sp,8
	mov	word ptr [bp-2],ax
	jmp	short @20@282
@20@254:
   ;	
   ;	  else
   ;	     res = -5;  
   ;	
	mov	word ptr [bp-2],-5
@20@282:
   ;	
   ;	  switch (res)  {
   ;	
	mov	bx,word ptr [bp-2]
	sub	bx,-5
	cmp	bx,3
	ja	short @20@506
	shl	bx,1
	jmp	word ptr cs:@20@C482[bx]
@20@366:
   ;	
   ;	         case -2:
   ;	              putstr("Erro em set: nao ha espaco para novas variaveis!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1763
	jmp	short @20@478
@20@394:
   ;	
   ;	              return 1;
   ;	         case -3:
   ;	              putstr("Erro em set: o tamanho do nome da variavel e muito grande!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1813
	jmp	short @20@478
@20@422:
   ;	
   ;	              return 1;
   ;	         case -4:
   ;	              putstr("Erro em set: o tamanho do conteudo da variavel e muito grande!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1873
	jmp	short @20@478
@20@450:
   ;	
   ;	              return 1;
   ;	         case -5:
   ;	              putstr("Erro em set: argumentos demais na linha de comando!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1937
@20@478:
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	              return 1;
   ;	
	mov	ax,1
	jmp	short @20@114
@20@506:
	jmp	short @20@86
@20@534:
   ;	
   ;	  }
   ;	  return 0;
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_cmd_set	endp
@20@C482	label	word
	dw	@20@450
	dw	@20@422
	dw	@20@394
	dw	@20@366
   ;	
   ;	int cmd_unset(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_unset	proc	near
	push	bp
	mov	bp,sp
	sub	sp,2
   ;	
   ;	{
   ;	  int res;
   ;	
   ;	  if (argc != 2)  {
   ;	
	cmp	word ptr [bp+4],2
	je	short @21@142
   ;	
   ;	     putstr("Erro em unset: numero invalido de argumentos!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+1990
@21@86:
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	     return 1;
   ;	
	mov	ax,1
@21@114:
	jmp	short @21@226
@21@142:
   ;	
   ;	  }
   ;	  res = command_var_unset(argv[1]);
   ;	
	mov	bx,word ptr [bp+6]
	push	word ptr [bx+6]
	push	word ptr [bx+4]
	call	near ptr command_var_unset
	pop	cx
	pop	cx
	mov	word ptr [bp-2],ax
   ;	
   ;	  if (res == -1)  {
   ;	
	cmp	word ptr [bp-2],-1
	jne	short @21@198
   ;	
   ;	     putstr("Erro em unset: variavel inexistente!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2037
	jmp	short @21@86
@21@198:
   ;	
   ;	     return 1;
   ;	  }
   ;	  return 0;
   ;	
	xor	ax,ax
	jmp	short @21@114
@21@226:
   ;	
   ;	}
   ;	
	mov	sp,bp
	pop	bp
	ret	
_cmd_unset	endp
   ;	
   ;	int cmd_echo(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_echo	proc	near
	push	bp
	mov	bp,sp
	sub	sp,2
	push	si
	push	di
	mov	di,word ptr [bp+6]
   ;	
   ;	{
   ;	  int i,control_n=1;
   ;	
	mov	word ptr [bp-2],1
   ;	
   ;	
   ;	  if (argc>1)  {
   ;	
	cmp	word ptr [bp+4],1
	jle	short @22@338
   ;	
   ;	     if (strcmp(argv[1],"-n")==0)
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2075
	push	ax
	push	word ptr [di+6]
	push	word ptr [di+4]
	call	near ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @22@114
   ;	
   ;	        control_n = 0;
   ;	
	mov	word ptr [bp-2],0
	jmp	short @22@142
@22@114:
   ;	
   ;	     else
   ;	        putstr(argv[1]);
   ;	
	push	word ptr [di+6]
	push	word ptr [di+4]
	call	near ptr _putstr
	pop	cx
	pop	cx
@22@142:
   ;	
   ;	     for (i=2;i<argc;++i)  {
   ;	
	mov	si,2
	jmp	short @22@310
@22@170:
   ;	
   ;	         if (i!=2 || control_n)
   ;	
	cmp	si,2
	jne	short @22@226
	cmp	word ptr [bp-2],0
	je	short @22@254
@22@226:
   ;	
   ;	            putch(' ');
   ;	
	mov	ax,32
	push	ax
	call	near ptr _putch
	pop	cx
@22@254:
   ;	
   ;	         putstr(argv[i]);
   ;	
	mov	bx,si
	mov	cl,2
	shl	bx,cl
	push	word ptr [bx+di+2]
	push	word ptr [bx+di]
	call	near ptr _putstr
	pop	cx
	pop	cx
	inc	si
@22@310:
	cmp	si,word ptr [bp+4]
	jl	short @22@170
@22@338:
   ;	
   ;	     }             
   ;	  }
   ;	  if (control_n)
   ;	
	cmp	word ptr [bp-2],0
	je	short @22@394
   ;	
   ;	     putch('\n');
   ;	
	mov	ax,10
	push	ax
	call	near ptr _putch
	pop	cx
@22@394:
   ;	
   ;	  return 0;
   ;	
	xor	ax,ax
	jmp	short @22@422
@22@422:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_cmd_echo	endp
_TEXT	ends
_DATA	segment word public 'DATA'
demo_linha	label	word
	db	252
	db	255
exitcode	label	word
	db	0
	db	0
_DATA	ends
_TEXT	segment byte public 'CODE'
   ;	
   ;	void demo()
   ;	
	assume	cs:_TEXT
demo	proc	near
	push	bp
	mov	bp,sp
	sub	sp,22
	push	si
	push	di
   ;	
   ;	{
   ;	  extern int demo_linha;
   ;	  extern int exitcode;
   ;	  unsigned i;
   ;	  int ini = demo_linha;
   ;	
	mov	di,word ptr DGROUP:demo_linha
   ;	
   ;	  char str[20];
   ;	  int ec = exitcode;
   ;	
	mov	ax,word ptr DGROUP:exitcode
	mov	word ptr [bp-2],ax
   ;	
   ;	
   ;	  putstrxy(65,ini+0,"ÚÄÄ Thread ÄÄÄÄ¿");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2078
	push	ax
	push	di
	mov	ax,65
	push	ax
	call	near ptr _putstrxy
	add	sp,8
   ;	
   ;	  putstrxy(65,ini+1,"³ PID  =       ³");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2095
	push	ax
	mov	ax,di
	inc	ax
	push	ax
	mov	ax,65
	push	ax
	call	near ptr _putstrxy
	add	sp,8
   ;	
   ;	  putstrxy(65,ini+2,"³ Execucao:    ³");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2112
	push	ax
	mov	ax,di
	add	ax,2
	push	ax
	mov	ax,65
	push	ax
	call	near ptr _putstrxy
	add	sp,8
   ;	
   ;	  putstrxy(65,ini+3,"³              ³");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2129
	push	ax
	mov	ax,di
	add	ax,3
	push	ax
	mov	ax,65
	push	ax
	call	near ptr _putstrxy
	add	sp,8
   ;	
   ;	  putstrxy(65,ini+4,"ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2146
	push	ax
	mov	ax,di
	add	ax,4
	push	ax
	mov	ax,65
	push	ax
	call	near ptr _putstrxy
	add	sp,8
   ;	
   ;	
   ;	  inttostr(str,getpid());
   ;	
	call	near ptr _getpid
	push	ax
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;	  putstrxy(74,ini+1,str);
   ;	
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	mov	ax,di
	inc	ax
	push	ax
	mov	ax,74
	push	ax
	call	near ptr _putstrxy
	add	sp,8
   ;	
   ;	
   ;	  for (i=0;i<60000U;++i)  {
   ;	
	xor	si,si
	jmp	short @23@114
@23@58:
   ;	
   ;	      unsignedtostr(str,i,5,'0');
   ;	
	mov	al,48
	push	ax
	mov	ax,5
	push	ax
	push	si
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	call	near ptr _unsignedtostr
	add	sp,10
   ;	
   ;	      putstrxy(70,ini+3,str);
   ;	
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	mov	ax,di
	add	ax,3
	push	ax
	mov	ax,70
	push	ax
	call	near ptr _putstrxy
	add	sp,8
	inc	si
@23@114:
	cmp	si,-5536
	jb	short @23@58
   ;	
   ;	  }
   ;	  for (i=0;i<60000U;++i)  {
   ;	
	xor	si,si
	jmp	short @23@226
@23@170:
   ;	
   ;	      unsignedtostr(str,i,5,'0');
   ;	
	mov	al,48
	push	ax
	mov	ax,5
	push	ax
	push	si
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	call	near ptr _unsignedtostr
	add	sp,10
   ;	
   ;	      putstrxy(70,ini+3,str);
   ;	
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	mov	ax,di
	add	ax,3
	push	ax
	mov	ax,70
	push	ax
	call	near ptr _putstrxy
	add	sp,8
	inc	si
@23@226:
	cmp	si,-5536
	jb	short @23@170
   ;	
   ;	  }
   ;	  for (i=0;i<60000U;++i)  {
   ;	
	xor	si,si
	jmp	short @23@338
@23@282:
   ;	
   ;	      unsignedtostr(str,i,5,'0');
   ;	
	mov	al,48
	push	ax
	mov	ax,5
	push	ax
	push	si
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	call	near ptr _unsignedtostr
	add	sp,10
   ;	
   ;	      putstrxy(70,ini+3,str);
   ;	
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	mov	ax,di
	add	ax,3
	push	ax
	mov	ax,70
	push	ax
	call	near ptr _putstrxy
	add	sp,8
	inc	si
@23@338:
	cmp	si,-5536
	jb	short @23@282
   ;	
   ;	  }
   ;	  for (i=0;i<60000U;++i)  {
   ;	
	xor	si,si
	jmp	short @23@450
@23@394:
   ;	
   ;	      unsignedtostr(str,i,5,'0');
   ;	
	mov	al,48
	push	ax
	mov	ax,5
	push	ax
	push	si
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	call	near ptr _unsignedtostr
	add	sp,10
   ;	
   ;	      putstrxy(70,ini+3,str);
   ;	
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	mov	ax,di
	add	ax,3
	push	ax
	mov	ax,70
	push	ax
	call	near ptr _putstrxy
	add	sp,8
	inc	si
@23@450:
	cmp	si,-5536
	jb	short @23@394
   ;	
   ;	  }
   ;	  for (i=0;i<60000U;++i)  {
   ;	
	xor	si,si
	jmp	short @23@562
@23@506:
   ;	
   ;	      unsignedtostr(str,i,5,'0');
   ;	
	mov	al,48
	push	ax
	mov	ax,5
	push	ax
	push	si
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	call	near ptr _unsignedtostr
	add	sp,10
   ;	
   ;	      putstrxy(70,ini+3,str);
   ;	
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	mov	ax,di
	add	ax,3
	push	ax
	mov	ax,70
	push	ax
	call	near ptr _putstrxy
	add	sp,8
	inc	si
@23@562:
	cmp	si,-5536
	jb	short @23@506
   ;	
   ;	  }
   ;	  for (i=0;i<60000U;++i)  {
   ;	
	xor	si,si
	jmp	short @23@674
@23@618:
   ;	
   ;	      unsignedtostr(str,i,5,'0');
   ;	
	mov	al,48
	push	ax
	mov	ax,5
	push	ax
	push	si
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	call	near ptr _unsignedtostr
	add	sp,10
   ;	
   ;	      putstrxy(70,ini+3,str);
   ;	
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	mov	ax,di
	add	ax,3
	push	ax
	mov	ax,70
	push	ax
	call	near ptr _putstrxy
	add	sp,8
	inc	si
@23@674:
	cmp	si,-5536
	jb	short @23@618
   ;	
   ;	  }
   ;	  exit(ec);
   ;	
	push	word ptr [bp-2]
	call	near ptr _exit
	pop	cx
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
demo	endp
   ;	
   ;	int cmd_demo(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_demo	proc	near
	push	bp
	mov	bp,sp
   ;	
   ;	{
   ;		extern int demo_linha;
   ;	
   ;		if	(argc != 2)  {
   ;	
	cmp	word ptr [bp+4],2
	je	short @24@142
   ;	
   ;			putstr("Erro em demo: numero invalido de argumentos!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2163
@24@86:
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;			return 1;
   ;	
	mov	ax,1
@24@114:
	jmp	short @24@282
@24@142:
   ;	
   ;		}
   ;		demo_linha += 5;
   ;	
	add	word ptr DGROUP:demo_linha,5
   ;	
   ;		if	(demo_linha >21)
   ;	
	cmp	word ptr DGROUP:demo_linha,21
	jle	short @24@198
   ;	
   ;			demo_linha = 1;
   ;	
	mov	word ptr DGROUP:demo_linha,1
@24@198:
   ;	
   ;		exitcode = atoi(argv[1]);
   ;	
	mov	bx,word ptr [bp+6]
	push	word ptr [bx+6]
	push	word ptr [bx+4]
	call	near ptr _atoi
	pop	cx
	pop	cx
	mov	word ptr DGROUP:exitcode,ax
   ;	
   ;		if	(fork(demo)==miniSO_ERROR)  {
   ;	
	mov	ax,offset demo
	push	ax
	call	near ptr _fork
	pop	cx
	cmp	ax,-1
	jne	short @24@254
   ;	
   ;			putstr("Erro em demo: fork() nao conseguiu criar thread!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2209
	jmp	short @24@86
@24@254:
   ;	
   ;			return 1;
   ;		}
   ;		return 0;
   ;	
	xor	ax,ax
	jmp	short @24@114
@24@282:
   ;	
   ;	}
   ;	
	pop	bp
	ret	
_cmd_demo	endp
   ;	
   ;	int cmd_waitpid(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_waitpid	proc	near
	push	bp
	mov	bp,sp
	sub	sp,22
	push	si
   ;	
   ;	{
   ;		int	status;
   ;		pid_t	pid;
   ;		char	str[20];
   ;	
   ;		if	(argc != 2)  {
   ;	
	cmp	word ptr [bp+4],2
	je	short @25@114
   ;	
   ;			putstr("Erro em waitpid: numero invalido de argumentos!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2259
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;			return 1;
   ;	
	mov	ax,1
@25@86:
	jmp	short @25@142
@25@114:
   ;	
   ;		}
   ;		pid = atoi(argv[1]);
   ;	
	mov	bx,word ptr [bp+6]
	push	word ptr [bx+6]
	push	word ptr [bx+4]
	call	near ptr _atoi
	pop	cx
	pop	cx
	mov	si,ax
   ;	
   ;		pid = waitpid(pid,&status);
   ;	
	push	ss
	lea	ax,word ptr [bp-2]
	push	ax
	push	si
	call	near ptr _waitpid
	add	sp,6
	mov	si,ax
   ;	
   ;		putstr("Processo ");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2308
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		inttostr(str,pid);
   ;	
	push	si
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;		putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		putstr(" encerrado com codigo de fim ");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2318
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		inttostr(str,status);
   ;	
	push	word ptr [bp-2]
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;		putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-22]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		putstr("!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2348
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		return 0;
   ;	
	xor	ax,ax
	jmp	short @25@86
@25@142:
   ;	
   ;	}
   ;	
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_cmd_waitpid	endp
   ;	
   ;	int cmd_wait(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_wait	proc	near
	push	bp
	mov	bp,sp
	sub	sp,24
	push	si
	push	di
	mov	si,word ptr [bp+4]
	mov	di,word ptr [bp+6]
   ;	
   ;	{
   ;		int	status=123;
   ;	
	mov	word ptr [bp-2],123
   ;	
   ;		pid_t	pid;
   ;		char	str[20];
   ;	
   ;		argc=argc;
   ;	
   ;	
   ;		argv=argv;
   ;	
   ;	
   ;		pid = wait(&status);
   ;	
	push	ss
	lea	ax,word ptr [bp-2]
	push	ax
	call	near ptr _wait
	pop	cx
	pop	cx
	mov	word ptr [bp-4],ax
   ;	
   ;		putstr("Processo ");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2351
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		inttostr(str,pid);
   ;	
	push	word ptr [bp-4]
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;		putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		putstr(" encerrado com codigo de fim ");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2361
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		inttostr(str,status);
   ;	
	push	word ptr [bp-2]
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;		putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		putstr("!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2391
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		return 0;
   ;	
	xor	ax,ax
	jmp	short @26@58
@26@58:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_cmd_wait	endp
   ;	
   ;	int cmd_semls(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_semls	proc	near
	push	bp
	mov	bp,sp
	sub	sp,20
	push	si
	push	di
   ;	
   ;	{
   ;		int i,n=0;
   ;	
	xor	di,di
   ;	
   ;		char str[20];
   ;		extern miniSO_SEM miniSO_sem[miniSO_MAXSEMAPHORES];
   ;	
   ;		argc=argc;
   ;	
	mov	ax,word ptr [bp+4]
	mov	word ptr [bp+4],ax
   ;	
   ;		argv=argv;
   ;	
	mov	ax,word ptr [bp+6]
	mov	word ptr [bp+6],ax
   ;	
   ;		putstr("Semaphores:\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2394
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		for	(i=0;i<miniSO_MAXSEMAPHORES;++i)
   ;	
	xor	si,si
	jmp	@27@142
@27@58:
   ;	
   ;			if	(miniSO_sem[i].status!=FREE) {
   ;	
	mov	bx,si
	mov	cl,3
	shl	bx,cl
	cmp	word ptr DGROUP:_miniSO_sem[bx],-1
	jne	@@6
	jmp	@27@114
@@6:
   ;	
   ;				putstr("- id=");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2407
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;				inttostr(str,miniSO_sem[i].semid);
   ;	
	mov	bx,si
	mov	cl,3
	shl	bx,cl
	push	word ptr DGROUP:_miniSO_sem[bx+2]
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;				putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;				putstr(" value=");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2413
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;				inttostr(str,miniSO_sem[i].value);
   ;	
	mov	bx,si
	mov	cl,3
	shl	bx,cl
	push	word ptr DGROUP:_miniSO_sem[bx+4]
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;				putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;				putstr(" queue=");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2421
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;				inttostr(str,miniSO_sem[i].queue);
   ;	
	mov	bx,si
	mov	cl,3
	shl	bx,cl
	push	word ptr DGROUP:_miniSO_sem[bx+6]
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;				putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;				putch('\n');
   ;	
	mov	ax,10
	push	ax
	call	near ptr _putch
	pop	cx
   ;	
   ;				++n;
   ;	
	inc	di
@27@114:
	inc	si
@27@142:
	cmp	si,10
	jge	@@7
	jmp	@27@58
@@7:
   ;	
   ;			}
   ;		putstr("TOTAL=");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2429
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		inttostr(str,n);
   ;	
	push	di
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;		putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		putstr("\n\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2436
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		return 0;
   ;	
	xor	ax,ax
	jmp	short @27@198
@27@198:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_cmd_semls	endp
   ;	
   ;	int cmd_semcreate(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_semcreate	proc	near
	push	bp
	mov	bp,sp
	sub	sp,20
	push	si
	push	di
   ;	
   ;	{
   ;		int	res,value;
   ;		semid_t	semid;
   ;		char	str[20];
   ;	
   ;		if	(argc != 2)	{
   ;	
	cmp	word ptr [bp+4],2
	je	short @28@142
   ;	
   ;			putstr("Erro em semcreate: numero invalido de argumentos!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2439
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;			return 1;
   ;	
@28@86:
	mov	ax,1
@28@114:
	jmp	short @28@226
@28@142:
   ;	
   ;		}
   ;		value = atoi(argv[1]);
   ;	
	mov	bx,word ptr [bp+6]
	push	word ptr [bx+6]
	push	word ptr [bx+4]
	call	near ptr _atoi
	pop	cx
	pop	cx
	mov	si,ax
   ;	
   ;		semid = semcreate(value);
   ;	
	push	si
	call	near ptr _semcreate
	pop	cx
	mov	di,ax
   ;	
   ;		if	(semid==miniSO_ERROR)
   ;	
	cmp	di,-1
	jne	short @28@198
	jmp	short @28@86
@28@198:
   ;	
   ;			return 1;
   ;		putstr("Semaforo id=");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2490
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		inttostr(str,semid);
   ;	
	push	di
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;		putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		putstr(" criado (value=");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2503
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		inttostr(str,value);
   ;	
	push	si
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;		putstr(str);
   ;	
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		putstr(")\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2519
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;		return 0;
   ;	
	xor	ax,ax
	jmp	short @28@114
@28@226:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_cmd_semcreate	endp
   ;	
   ;	void sem_aplic()
   ;	
	assume	cs:_TEXT
_sem_aplic	proc	near
	push	bp
	mov	bp,sp
	sub	sp,20
	push	si
	push	di
   ;	
   ;	{
   ;		extern int demo_linha;
   ;		extern semid_t semid;
   ;		unsigned i;
   ;		int ini = demo_linha;
   ;	
	mov	di,word ptr DGROUP:demo_linha
   ;	
   ;		char str[20];
   ;	
   ;		putstrxy(65,ini+0,"ÚÄÄ Thread ÄÄÄÄ¿");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2522
	push	ax
	push	di
	mov	ax,65
	push	ax
	call	near ptr _putstrxy
	add	sp,8
   ;	
   ;		putstrxy(65,ini+1,"³ PID  =       ³");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2539
	push	ax
	mov	ax,di
	inc	ax
	push	ax
	mov	ax,65
	push	ax
	call	near ptr _putstrxy
	add	sp,8
   ;	
   ;		putstrxy(65,ini+2,"³ Execucao:    ³");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2556
	push	ax
	mov	ax,di
	add	ax,2
	push	ax
	mov	ax,65
	push	ax
	call	near ptr _putstrxy
	add	sp,8
   ;	
   ;		putstrxy(65,ini+3,"³              ³");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2573
	push	ax
	mov	ax,di
	add	ax,3
	push	ax
	mov	ax,65
	push	ax
	call	near ptr _putstrxy
	add	sp,8
   ;	
   ;		putstrxy(65,ini+4,"ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2590
	push	ax
	mov	ax,di
	add	ax,4
	push	ax
	mov	ax,65
	push	ax
	call	near ptr _putstrxy
	add	sp,8
   ;	
   ;	
   ;		inttostr(str,getpid());
   ;	
	call	near ptr _getpid
	push	ax
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _inttostr
	add	sp,6
   ;	
   ;		putstrxy(74,ini+1,str);
   ;	
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	mov	ax,di
	inc	ax
	push	ax
	mov	ax,74
	push	ax
	call	near ptr _putstrxy
	add	sp,8
   ;	
   ;		for	(i=0;i<30000U;++i)  {
   ;	
	xor	si,si
	jmp	short @29@114
@29@58:
   ;	
   ;			unsignedtostr(str,i,5,'0');
   ;	
	mov	al,48
	push	ax
	mov	ax,5
	push	ax
	push	si
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _unsignedtostr
	add	sp,10
   ;	
   ;			putstrxy(70,ini+3,str);
   ;	
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	mov	ax,di
	add	ax,3
	push	ax
	mov	ax,70
	push	ax
	call	near ptr _putstrxy
	add	sp,8
	inc	si
@29@114:
	cmp	si,30000
	jb	short @29@58
   ;	
   ;		}
   ;		semdown(semid);
   ;	
	push	word ptr DGROUP:_semid
	call	near ptr _semdown
	pop	cx
	jmp	short @29@226
@29@170:
   ;	
   ;		for	(;i<60000U;++i)  {
   ;			unsignedtostr(str,i,5,'0');
   ;	
	mov	al,48
	push	ax
	mov	ax,5
	push	ax
	push	si
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	near ptr _unsignedtostr
	add	sp,10
   ;	
   ;			putstrxy(70,ini+3,str);
   ;	
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	mov	ax,di
	add	ax,3
	push	ax
	mov	ax,70
	push	ax
	call	near ptr _putstrxy
	add	sp,8
	inc	si
@29@226:
	cmp	si,-5536
	jb	short @29@170
   ;	
   ;	 	}
   ;		exit(0);
   ;	
	xor	ax,ax
	push	ax
	call	near ptr _exit
	pop	cx
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_sem_aplic	endp
   ;	
   ;	int cmd_semtest(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_semtest	proc	near
	push	bp
	mov	bp,sp
   ;	
   ;	{
   ;		extern int demo_linha;
   ;		extern semid_t semid;
   ;	
   ;		if	(argc != 2)	{
   ;	
	cmp	word ptr [bp+4],2
	je	short @30@142
   ;	
   ;			putstr("Erro em semtest: numero invalido de argumentos!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2607
@30@86:
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;			return 1;
   ;	
	mov	ax,1
@30@114:
	jmp	short @30@282
@30@142:
   ;	
   ;		}
   ;		semid = atoi(argv[1]);
   ;	
	mov	bx,word ptr [bp+6]
	push	word ptr [bx+6]
	push	word ptr [bx+4]
	call	near ptr _atoi
	pop	cx
	pop	cx
	mov	word ptr DGROUP:_semid,ax
   ;	
   ;		demo_linha += 5;
   ;	
	add	word ptr DGROUP:demo_linha,5
   ;	
   ;		if	(demo_linha >21)
   ;	
	cmp	word ptr DGROUP:demo_linha,21
	jle	short @30@198
   ;	
   ;			demo_linha = 1;
   ;	
	mov	word ptr DGROUP:demo_linha,1
@30@198:
   ;	
   ;		if	(fork(sem_aplic)==miniSO_ERROR)  {
   ;	
	mov	ax,offset _sem_aplic
	push	ax
	call	near ptr _fork
	pop	cx
	cmp	ax,-1
	jne	short @30@254
   ;	
   ;			putstr("Erro em demo: fork() nao conseguiu criar thread!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2656
	jmp	short @30@86
@30@254:
   ;	
   ;			return 1;
   ;	 	}
   ;		return 0;
   ;	
	xor	ax,ax
	jmp	short @30@114
@30@282:
   ;	
   ;	}
   ;	
	pop	bp
	ret	
_cmd_semtest	endp
   ;	
   ;	int cmd_semup(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_semup	proc	near
	push	bp
	mov	bp,sp
	sub	sp,2
   ;	
   ;	{
   ;		semid_t semid;
   ;	
   ;		if	(argc != 2)	{
   ;	
	cmp	word ptr [bp+4],2
	je	short @31@114
   ;	
   ;			putstr("Erro em semtest: numero invalido de argumentos!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2706
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;			return 1;
   ;	
	mov	ax,1
@31@86:
	jmp	short @31@142
@31@114:
   ;	
   ;		}
   ;		semid = atoi(argv[1]);
   ;	
	mov	bx,word ptr [bp+6]
	push	word ptr [bx+6]
	push	word ptr [bx+4]
	call	near ptr _atoi
	pop	cx
	pop	cx
	mov	word ptr [bp-2],ax
   ;	
   ;		return semup(semid);
   ;	
	push	word ptr [bp-2]
	call	near ptr _semup
	pop	cx
	jmp	short @31@86
@31@142:
   ;	
   ;	}
   ;	
	mov	sp,bp
	pop	bp
	ret	
_cmd_semup	endp
   ;	
   ;	int cmd_semdestroy(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_semdestroy	proc	near
	push	bp
	mov	bp,sp
	sub	sp,2
   ;	
   ;	{
   ;		semid_t semid;
   ;	
   ;		if	(argc != 2)	{
   ;	
	cmp	word ptr [bp+4],2
	je	short @32@114
   ;	
   ;			putstr("Erro em semtest: numero invalido de argumentos!\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2755
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;			return 1;
   ;	
	mov	ax,1
@32@86:
	jmp	short @32@142
@32@114:
   ;	
   ;		}
   ;		semid = atoi(argv[1]);
   ;	
	mov	bx,word ptr [bp+6]
	push	word ptr [bx+6]
	push	word ptr [bx+4]
	call	near ptr _atoi
	pop	cx
	pop	cx
	mov	word ptr [bp-2],ax
   ;	
   ;		return semdestroy(semid);
   ;	
	push	word ptr [bp-2]
	call	near ptr _semdestroy
	pop	cx
	jmp	short @32@86
@32@142:
   ;	
   ;	}
   ;	
	mov	sp,bp
	pop	bp
	ret	
_cmd_semdestroy	endp
   ;	
   ;	int cmd_stop(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_stop	proc	near
	push	bp
	mov	bp,sp
	push	si
	push	di
   ;	
   ;	{
   ;	    int t=0;
   ;	
	xor	si,si
   ;	
   ;	    pid_t pid=0;
   ;	
	xor	di,di
   ;	
   ;	    
   ;	    if (argc<2) {
   ;	
	cmp	word ptr [bp+4],2
	jge	short @33@114
   ;	
   ;	        putstr("stop: nenhum parametro foi fornecido\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2804
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	        return miniSO_ERROR;
   ;	
	mov	ax,-1
@33@86:
	jmp	short @33@198
@33@114:
   ;	
   ;	    }
   ;	    pid = atoi(argv[1]);
   ;	
	mov	bx,word ptr [bp+6]
	push	word ptr [bx+6]
	push	word ptr [bx+4]
	call	near ptr _atoi
	pop	cx
	pop	cx
	mov	di,ax
   ;	
   ;	    t = stop(pid);
   ;	
	push	di
	call	near ptr _stop
	pop	cx
	mov	si,ax
   ;	
   ;	    if (t==miniSO_ERROR)
   ;	
	cmp	si,-1
	jne	short @33@170
   ;	
   ;	        putstr("stop: impossivel suspender a thread\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2842
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
@33@170:
   ;	
   ;	    return t;
   ;	
	mov	ax,si
	jmp	short @33@86
@33@198:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	pop	bp
	ret	
_cmd_stop	endp
   ;	
   ;	int cmd_resume(int argc, char far *argv[])
   ;	
	assume	cs:_TEXT
_cmd_resume	proc	near
	push	bp
	mov	bp,sp
	push	si
	push	di
   ;	
   ;	{
   ;	    int t=0;
   ;	
	xor	si,si
   ;	
   ;	    pid_t pid=0;
   ;	
	xor	di,di
   ;	
   ;	    
   ;	    if (argc<2) {
   ;	
	cmp	word ptr [bp+4],2
	jge	short @34@114
   ;	
   ;	        putstr("resume: nenhum parametro foi fornecido\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2879
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
   ;	
   ;	        return miniSO_ERROR;
   ;	
	mov	ax,-1
@34@86:
	jmp	short @34@198
@34@114:
   ;	
   ;	    }
   ;	    pid = atoi(argv[1]);
   ;	
	mov	bx,word ptr [bp+6]
	push	word ptr [bx+6]
	push	word ptr [bx+4]
	call	near ptr _atoi
	pop	cx
	pop	cx
	mov	di,ax
   ;	
   ;	    t = resume(pid);
   ;	
	push	di
	call	near ptr _resume
	pop	cx
	mov	si,ax
   ;	
   ;	    if (t==miniSO_ERROR)
   ;	
	cmp	si,-1
	jne	short @34@170
   ;	
   ;	        putstr("resume: impossivel reiniciar a thread\n");
   ;	
	push	ds
	mov	ax,offset DGROUP:s@+2919
	push	ax
	call	near ptr _putstr
	pop	cx
	pop	cx
@34@170:
   ;	
   ;	    return t;
   ;	
	mov	ax,si
	jmp	short @34@86
@34@198:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	pop	bp
	ret	
_cmd_resume	endp
_TEXT	ends
_BSS	segment word public 'BSS'
_semid	label	word
	db	2 dup (?)
var	label	word
	db	500 dup (?)
history_pos	label	word
	db	2 dup (?)
history_nxt	label	word
	db	2 dup (?)
history_ini	label	word
	db	2 dup (?)
history_len	label	word
	db	2 dup (?)
history	label	byte
	db	310 dup (?)
argv	label	dword
	db	64 dup (?)
argline	label	byte
	db	607 dup (?)
palavra	label	byte
	db	31 dup (?)
cmdline	label	byte
	db	31 dup (?)
end_command	label	word
	db	2 dup (?)
	?debug	C E9
	?debug	C FA00000000
_BSS	ends
_DATA	segment word public 'DATA'
s@	label	byte
	db	'?'
	db	0
	db	'                   exibe estas informacoes'
	db	0
	db	'help'
	db	0
	db	'                exibe estas informacoes'
	db	0
	db	'ver'
	db	0
	db	'                 mostra a versao do MSO'
	db	0
	db	'date'
	db	0
	db	'                mostra a data'
	db	0
	db	'time'
	db	0
	db	'                mostra a hora'
	db	0
	db	'cls'
	db	0
	db	'                 limpa a tela'
	db	0
	db	'clear'
	db	0
	db	'               limpa a tela'
	db	0
	db	'reboot'
	db	0
	db	'              reinicializa o sistema'
	db	0
	db	'exit'
	db	0
	db	'                abandona o sistema'
	db	0
	db	'quit'
	db	0
	db	'                abandona o sistema'
	db	0
	db	'ps'
	db	0
	db	'                  exibe processos/threads em execucao'
	db	0
	db	'kill'
	db	0
	db	' <pid>          encerra um processo/thread'
	db	0
	db	'demo'
	db	0
	db	' <exitcode>     inicia processos/threads de demonstracao'
	db	0
	db	'set'
	db	0
	db	' [<var> [<val>]] define o valor da variavel ou exibe variavei'
	db	's'
	db	0
	db	'unset'
	db	0
	db	' <var>         apaga a variavel'
	db	0
	db	'echo'
	db	0
	db	' [-n] <args>... imprime argumentos'
	db	0
	db	'waitpid'
	db	0
	db	' <pid>       espera pelo processo-filho indicado'
	db	0
	db	'wait'
	db	0
	db	'                espera por um processo-filho'
	db	0
	db	'semls'
	db	0
	db	'               lista tabela de semaforos'
	db	0
	db	'semcreate'
	db	0
	db	' <value>   cria um semaforo'
	db	0
	db	'semtest'
	db	0
	db	' <semid>     aplicacao para teste de semaforos'
	db	0
	db	'semup'
	db	0
	db	' <semid>       incrementa o valor de um semaforo'
	db	0
	db	'semdestroy'
	db	0
	db	' <semid>  destroi um semaforo'
	db	0
	db	'stop'
	db	0
	db	'<pid>          suspende um processo/thread'
	db	0
	db	'resume'
	db	0
	db	'<pid>        reinicia um processo/thread'
	db	0
	db	'                  '
	db	-36
	db	-36
	db	-36
	db	-36
	db	-36
	db	-36
	db	-36
	db	'  '
	db	-36
	db	-36
	db	-36
	db	-36
	db	-36
	db	-36
	db	10
	db	0
	db	' '
	db	-36
	db	-36
	db	-36
	db	-36
	db	-36
	db	'  '
	db	-36
	db	'  '
	db	-36
	db	-36
	db	-36
	db	'  '
	db	-36
	db	' '
	db	-37
	db	-37
	db	'   '
	db	-33
	db	-33
	db	'  '
	db	-37
	db	-37
	db	'  '
	db	-37
	db	-37
	db	'  '
	db	0
	db	'MinisSistema Operacional'
	db	10
	db	0
	db	-36
	db	-37
	db	' '
	db	-37
	db	' '
	db	-37
	db	' '
	db	-36
	db	-37
	db	' '
	db	-36
	db	-37
	db	' '
	db	-37
	db	' '
	db	-36
	db	-37
	db	' '
	db	-33
	db	-33
	db	-33
	db	-33
	db	-37
	db	-37
	db	-37
	db	' '
	db	-37
	db	-37
	db	-37
	db	'  '
	db	-37
	db	-37
	db	'  '
	db	0
	db	'Vs '
	db	0
	db	'2015'
	db	0
	db	10
	db	0
	db	-37
	db	-37
	db	' '
	db	-37
	db	' '
	db	-37
	db	' '
	db	-37
	db	-37
	db	' '
	db	-37
	db	-37
	db	' '
	db	-37
	db	' '
	db	-37
	db	-37
	db	' '
	db	-37
	db	-37
	db	-36
	db	-36
	db	-37
	db	-37
	db	-37
	db	' '
	db	-37
	db	-37
	db	-37
	db	-36
	db	-36
	db	-37
	db	-37
	db	'  '
	db	0
	db	'por Roland Teodorowitsch'
	db	10
	db	0
	db	10
	db	'Digite '
	db	39
	db	'help'
	db	39
	db	' ou '
	db	39
	db	'?'
	db	39
	db	' para ajuda...'
	db	10
	db	10
	db	0
	db	'PROMPT'
	db	0
	db	'miniSO>'
	db	0
	db	'ERRORLEVEL'
	db	0
	db	'0'
	db	0
	db	'ERRORLEVEL'
	db	0
	db	'Erro: comando desconhecido!'
	db	10
	db	0
	db	'PROMPT'
	db	0
	db	'Comandos do minisSistema Operacional:'
	db	10
	db	0
	db	'minisSistema Operacional - Vs '
	db	0
	db	'2015'
	db	0
	db	' BCP   PID   PPID  STATUS   WAIT   ZLIST  PREV   NEXT'
	db	10
	db	0
	db	'  '
	db	0
	db	'  '
	db	0
	db	'  '
	db	0
	db	'FREE   '
	db	0
	db	'READY  '
	db	0
	db	'RUNNING'
	db	0
	db	'ZOMBIE '
	db	0
	db	'WAIT   '
	db	0
	db	'WAITSIG'
	db	0
	db	'WAITSEM'
	db	0
	db	'STOPPED'
	db	0
	db	'  '
	db	0
	db	'  '
	db	0
	db	' '
	db	0
	db	'  '
	db	0
	db	'Erro em kill: parametro nao fornecido!'
	db	10
	db	0
	db	'kill: impossivel matar o processo/thread'
	db	10
	db	0
	db	0
	db	'Erro em set: nao ha espaco para novas variaveis!'
	db	10
	db	0
	db	'Erro em set: o tamanho do nome da variavel e muito grande!'
	db	10
	db	0
	db	'Erro em set: o tamanho do conteudo da variavel e muito grande'
	db	'!'
	db	10
	db	0
	db	'Erro em set: argumentos demais na linha de comando!'
	db	10
	db	0
	db	'Erro em unset: numero invalido de argumentos!'
	db	10
	db	0
	db	'Erro em unset: variavel inexistente!'
	db	10
	db	0
	db	'-n'
	db	0
	db	-38
	db	-60
	db	-60
	db	' Thread '
	db	-60
	db	-60
	db	-60
	db	-60
	db	-65
	db	0
	db	-77
	db	' PID  =       '
	db	-77
	db	0
	db	-77
	db	' Execucao:    '
	db	-77
	db	0
	db	-77
	db	'              '
	db	-77
	db	0
	db	-64
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-39
	db	0
	db	'Erro em demo: numero invalido de argumentos!'
	db	10
	db	0
	db	'Erro em demo: fork() nao conseguiu criar thread!'
	db	10
	db	0
	db	'Erro em waitpid: numero invalido de argumentos!'
	db	10
	db	0
	db	'Processo '
	db	0
	db	' encerrado com codigo de fim '
	db	0
	db	'!'
	db	10
	db	0
	db	'Processo '
	db	0
	db	' encerrado com codigo de fim '
	db	0
	db	'!'
	db	10
	db	0
	db	'Semaphores:'
	db	10
	db	0
	db	'- id='
	db	0
	db	' value='
	db	0
	db	' queue='
	db	0
	db	'TOTAL='
	db	0
	db	10
	db	10
	db	0
	db	'Erro em semcreate: numero invalido de argumentos!'
	db	10
	db	0
	db	'Semaforo id='
	db	0
	db	' criado (value='
	db	0
	db	')'
	db	10
	db	0
	db	-38
	db	-60
	db	-60
	db	' Thread '
	db	-60
	db	-60
	db	-60
	db	-60
	db	-65
	db	0
	db	-77
	db	' PID  =       '
	db	-77
	db	0
	db	-77
	db	' Execucao:    '
	db	-77
	db	0
	db	-77
	db	'              '
	db	-77
	db	0
	db	-64
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-39
	db	0
	db	'Erro em semtest: numero invalido de argumentos!'
	db	10
	db	0
	db	'Erro em demo: fork() nao conseguiu criar thread!'
	db	10
	db	0
	db	'Erro em semtest: numero invalido de argumentos!'
	db	10
	db	0
	db	'Erro em semtest: numero invalido de argumentos!'
	db	10
	db	0
	db	'stop: nenhum parametro foi fornecido'
	db	10
	db	0
	db	'stop: impossivel suspender a thread'
	db	10
	db	0
	db	'resume: nenhum parametro foi fornecido'
	db	10
	db	0
	db	'resume: impossivel reiniciar a thread'
	db	10
	db	0
_DATA	ends
_TEXT	segment byte public 'CODE'
_TEXT	ends
	public	_sem_aplic
	public	_semid
	extrn	_miniSO_sem:word
_exitcode	equ	exitcode
_demo_linha	equ	demo_linha
_demo	equ	demo
	extrn	_miniSO_thread:word
_commands	equ	commands
_var	equ	var
_num_var	equ	num_var
_history_pos	equ	history_pos
_history_nxt	equ	history_nxt
_history_ini	equ	history_ini
_history_len	equ	history_len
_history	equ	history
_argv	equ	argv
_argline	equ	argline
_palavra	equ	palavra
_cmdline	equ	cmdline
_end_command	equ	end_command
	extrn	_resume:near
	extrn	_stop:near
	extrn	_semdestroy:near
	extrn	_semdown:near
	extrn	_semup:near
	extrn	_semcreate:near
	extrn	_getpid:near
	extrn	_exit:near
	extrn	_waitpid:near
	extrn	_wait:near
	extrn	_kill:near
	extrn	_fork:near
	extrn	_reboot:near
	extrn	_inttostr:near
	extrn	_unsignedtostr:near
	extrn	_atoi:near
	extrn	_strlen:near
	extrn	_strcmp:near
	extrn	_strcpy:near
	extrn	_gettime:near
	extrn	_getdate:near
	extrn	_gotoxy:near
	extrn	_wherey:near
	extrn	_wherex:near
	extrn	_setcolor:near
	extrn	_getcolor:near
	extrn	_putstrxy:near
	extrn	_putstr:near
	extrn	_clrscr:near
	extrn	_getch:near
	extrn	_putch:near
	public	_cmd_resume
	public	_cmd_stop
	public	_cmd_semdestroy
	public	_cmd_semup
	public	_cmd_semtest
	public	_cmd_semcreate
	public	_cmd_semls
	public	_cmd_waitpid
	public	_cmd_wait
	public	_cmd_echo
	public	_cmd_unset
	public	_cmd_set
	public	_cmd_demo
	public	_cmd_kill
	public	_cmd_ps
	public	_cmd_ver
	public	_cmd_cls
	public	_cmd_time
	public	_cmd_date
	public	_cmd_help
	public	_cmd_reboot
	public	_cmd_exit
_command_var_set	equ	command_var_set
_command_var_value	equ	command_var_value
_command_var_unset	equ	command_var_unset
_command_var_search	equ	command_var_search
_command_var_list	equ	command_var_list
_command_var_nextfree	equ	command_var_nextfree
_command_var_init	equ	command_var_init
_command_showprompt	equ	command_showprompt
_command_backspace	equ	command_backspace
	public	_command
_s@	equ	s@
	end
