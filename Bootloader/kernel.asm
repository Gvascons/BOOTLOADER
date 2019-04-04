org 0x7e00  ;Declara endereço de início
jmp 0x0000:start ; Inicializa cs como zero

input times 2 db 0

falha db 10, 10, 10, 10, 10, 10, 10, 10,'        YOU ARE A WIGHT NOW',0
acerto1 db 10, 10, 10, 10, 10, 10, 10, 10,'      CONGRATS MILORD',0
acerto2 db 10, 10, 10, 10, 10, 10, 10, 10,'      YOU AINT DEAD YET',0
ganhou db 10, 10, 10, 10, 10, 10, 10, 10,'       YOU WON THE IRON THRONE! LONG MAY YOU REIGN',0
spaceBar8 db 10, 10, 10, 10, 10, 10, 10, 10, 0
spaceBar3 db 10, 10, 10, 0
pergunta1 db ' > WHICH HOUSE USES OURS IS THE FURY AS ITS WORDS ?',13,10,0
opcoes1 db ' > (a)BARATHEON',13,10,10,10,' > (b)TYRELL',13,10,10,10,' > (c)GREYJOY',13,10,10,10,0
pergunta2 db ' > WHO GOT MARRIED AT THE RED WEDDING ?',13,10,0
opcoes2 db ' > (a)ROBB STARK',13,10,10,10,' > (b)EDMUND TULLY',13,10,10,10,' > (c)WALDER FREY',13,10,10,10,0
pergunta3 db ' > WHICH OF THESE CITIES IS PART OF THE SLAVERS BAY ?',13,10,0
opcoes3 db ' > (a)BRAVOS',13,10,10,10,' > (b)QARTH',13,10,10,10,' > (c)ASTAPOR', 13,10,10,10,0
pergunta4 db ' > WHAT DOES VALAR DOHAERIS MEAN ?',13,10,0
opcoes4 db ' > (a)ALL MEN MUST DIE',13,10,10,10,' > (b)ALL MEN MUST SERVE',13,10,10,10,' > (c)ALL MEN MUST SUFFER',13,10,10,0

alternativaa db 10,10,10,10,' (',4,')(b)(c)', 13,10,0
alternativab db 10,10,10,10,' (a)(',4,')(c)', 13,10,0
alternativac db 10,10,10,10,' (a)(b)(',4,')', 13,10,0

start:
	mov ax, 0
	mov ds, ax ; Inicializa ds como zero
	mov es, ax

	jmp reset

reset:
  mov ah, 00h ; Reseta o controlador de disco
  mov dl, 0   
  int 13h

  jc reset ; Em caso de falha, volta ao reset

  jmp Carregar1 ; 

;Foi feito um 'Carregar' para cada opçao, uma vez que cada um chama uma pergunta e uma opcao diferente

Carregar1:
	call Format
	cli; Impede interrupcoes
    mov si, spaceBar8
    call imprimirString
	mov si, pergunta1
	call imprimirString
	mov si, spaceBar3
	call imprimirString
	mov si, opcoes1
	call imprimirString
	mov dx, 300
	call delay
	call initial
    call choice1

Carregar2:
	call Format
	cli; Impede interrupcoes
    mov si, spaceBar8
    call imprimirString
	mov si, pergunta2
	call imprimirString
	mov si, spaceBar3
	call imprimirString
	mov si, opcoes2
	call imprimirString
	mov dx, 300
	call delay
	call initial
    call choice2

Carregar3:
	call Format
	cli; Impede interrupcoes
    mov si, spaceBar8
    call imprimirString
	mov si, pergunta3
	call imprimirString
	mov si, spaceBar3
	call imprimirString
	mov si, opcoes3
	call imprimirString
	mov dx, 300
	call delay
	call initial
    call choice3

 Carregar4:
	call Format
	cli; Impede interrupcoes
    mov si, spaceBar8
    call imprimirString
	mov si, pergunta4
	call imprimirString
	mov si, spaceBar3
	call imprimirString
	mov si, opcoes4
	call imprimirString
	mov dx, 300
	call delay
	call initial
    call choice4

Format:
    ; Modo de vídeo
    mov ah, 0
    mov al, 13h
    int 10h

    ; Cor do fundo
    mov ah, 0xb 
    mov bh, 0
    mov bl,0
    int 10h

    ;Cor da letra
    mov bl, 2

	ret

initial:
    ;move cursor
    call clearScr
    ;muda cor do texto
    mov bl, 15
    ;etc
    ;call novaPagina
    ;CX é a opçãozinha lá abc tá ligado, podendo ser 0, 1 ou 2
    mov cx, 0
    ret

choice1:
    mov di, input
    call wait_choice_input
    call clearScr
    cmp al, 100
    je .funcao1
    jmp .funcao2

        .funcao1:
            inc cx
            cmp cx, 3
            je .casod3
            jmp .ok1

            .casod3:
                dec cx
                dec cx
                dec cx
                jmp .parte1
            .ok1:
                cmp cx, 1
                je .parte2
                jmp .parte3

        .funcao2:
            cmp al, 0dh
            je confirmar1

            dec cx

            cmp cx, -1
            je .negativo
            jmp .ok2

            .negativo:
                inc cx
                inc cx
                inc cx
                jmp .parte3
            .ok2:
               cmp cx, 1
                je .parte2
                jmp .parte1


        .parte1:
        	call clearScr
            mov si, alternativaa
            call imprimirString
        	jmp choice1
        .parte2:
        	call clearScr
            mov si, alternativab
            call imprimirString
        	jmp choice1 
        .parte3:
        	call clearScr
            mov si, alternativac
            call imprimirString
        jmp choice1

choice2:
    mov di, input
    call wait_choice_input
    call clearScr
    cmp al, 100
    je .funcao1
    jmp .funcao2

        .funcao1:
            inc cx
            cmp cx, 3
            je .casod3
            jmp .ok1

            .casod3:
                dec cx
                dec cx
                dec cx
                jmp .parte1
            .ok1:
                cmp cx, 1
                je .parte2
                jmp .parte3

        .funcao2:
            cmp al, 0dh
            je confirmar2

            dec cx

            cmp cx, -1
            je .negativo
            jmp .ok2

            .negativo:
                inc cx
                inc cx
                inc cx
                jmp .parte3
            .ok2:
               cmp cx, 1
                je .parte2
                jmp .parte1


        .parte1:
        	call clearScr
            mov si, alternativaa
            call imprimirString
        	jmp choice2
        .parte2:
        	call clearScr
            mov si, alternativab
            call imprimirString
        	jmp choice2 
        .parte3:
        	call clearScr
            mov si, alternativac
            call imprimirString
        jmp choice2

choice3:
    mov di, input
    call wait_choice_input
    call clearScr
    cmp al, 100
    je .funcao1
    jmp .funcao2

        .funcao1:
            inc cx
            cmp cx, 3
            je .casod3
            jmp .ok1

            .casod3:
                dec cx
                dec cx
                dec cx
                jmp .parte1
            .ok1:
                cmp cx, 1
                je .parte2
                jmp .parte3

        .funcao2:
            cmp al, 0dh
            je confirmar3

            dec cx

            cmp cx, -1
            je .negativo
            jmp .ok2

            .negativo:
                inc cx
                inc cx
                inc cx
                jmp .parte3
            .ok2:
               cmp cx, 1
                je .parte2
                jmp .parte1


        .parte1:
        	call clearScr
            mov si, alternativaa
            call imprimirString
        	jmp choice3
        .parte2:
        	call clearScr
            mov si, alternativab
            call imprimirString
        	jmp choice3  
        .parte3:
        	call clearScr
            mov si, alternativac
            call imprimirString
        jmp choice3

choice4:
    mov di, input
    call wait_choice_input
    call clearScr
    cmp al, 100
    je .funcao1
    jmp .funcao2

        .funcao1:
            inc cx
            cmp cx, 3
            je .casod3
            jmp .ok1

            .casod3:
                dec cx
                dec cx
                dec cx
                jmp .parte1
            .ok1:
                cmp cx, 1
                je .parte2
                jmp .parte3

        .funcao2:
            cmp al, 0dh
            je confirmar4

            dec cx

            cmp cx, -1
            je .negativo
            jmp .ok2

            .negativo:
                inc cx
                inc cx
                inc cx
                jmp .parte3
            .ok2:
               cmp cx, 1
                je .parte2
                jmp .parte1


        .parte1:
        	call clearScr
            mov si, alternativaa
            call imprimirString
        	jmp choice4
        .parte2:
        	call clearScr
            mov si, alternativab
            call imprimirString
        	jmp choice4 
        .parte3:
        	call clearScr
            mov si, alternativac
            call imprimirString
        jmp choice4

imprimirString:
    lodsb       ;carrega uma letra de si em al e passa para o próximo caractere
    cmp al, 0   ;chegou no final? (equivalente a um \0)
    je .done
    
    mov ah, 0xe ;código da instrução para imprimir um caractere que está em al
    int 10h     ;interrupção de vídeo.

    mov dx, 1
    call delay

    jmp imprimirString ;loop

    .done:   
        ret

wait_choice_input:
    ;ler do teclado
    mov ah, 0
    int 16h
    stosb      
        ret

confirmar1:
    ;mov si, teste
    ;call printa_string
    call clearAll
    cmp cx, 0
    je Correct1
    cmp cx, 1
    je Fail
    cmp cx, 2
    je Fail

confirmar2:
    ;mov si, teste
    ;call printa_string
    call clearAll
    cmp cx, 0
    je Fail
    cmp cx, 1
    je Correct2
    cmp cx, 2
    je Fail

confirmar3:
    ;mov si, teste
    ;call printa_string
    call clearAll
    cmp cx, 0
    je Fail
    cmp cx, 1
    je Fail
    cmp cx, 2
    je Correct3

confirmar4:
    ;mov si, teste
    ;call printa_string
    call clearAll
    cmp cx, 0
    je Fail
    cmp cx, 1
    je Correct4
    cmp cx, 2
    je Fail

Fail:
	call novaPagina
	mov si, falha
	call imprimirString
	mov dx, 7000
	call delay
	jmp done

Correct1:
	call novaPagina
	mov si, acerto1
	call imprimirString
	mov dx, 7000
	call delay
	jmp Carregar2

Correct2:
	call novaPagina
	mov si, acerto2
	call imprimirString
	mov dx, 7000
	call delay
	jmp Carregar3

Correct3:
	call novaPagina
	mov si, acerto1
	call imprimirString
	mov dx, 7000
	call delay
	jmp Carregar4

Correct4:
	call novaPagina
	mov si, ganhou
	call imprimirString
	mov dx, 7000
	call delay
	call imprimirString
	jmp done

clearAll:
    pusha
    mov ah, 0
    mov al, 12h
    int 10h
    popa
    mov bl, 2
    ret

delay:  ; Estabelece um tempo de resposta atraves de loop
  mov bp, dx
  loop:
  dec bp
  jnz loop
  dec dx   
  jnz loop
ret

clearScr:
    ;seta coluna do cursor
    mov dl, 13
    ;seta linha do cursor
    mov dh, 0
    ;interrupcao pra mudar a posição do cursor pra [dh,dl]
    mov ah, 02h
    mov bh, 00
    int 10h
    ret

novaPagina:
;; Limpa a tela dos caracteres colocados pela BIOS
  ; Set the cursor to top left-most corner of screen
      mov dx, 0 
      mov bh, 0      
      mov ah, 0x2
      int 10h

      ; print 2000 blanck chars to clean  
      mov cx, 2000 
      mov bh, 0
      mov al, 0x20 ; blank char
      mov ah, 0x9
      int 10h
      
      ;Reset cursor to top left-most corner of screen
      mov dx, 0 
      mov bh, 0      
      mov ah, 0x2
      int 10h
ret

done: