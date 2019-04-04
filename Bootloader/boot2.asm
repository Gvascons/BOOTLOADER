org 0x500  ; Endereco de início
jmp 0x0000:start ; Zera cs

;para guardar entrada do teclado
input times 2 db 0

story1 db ' > INITIALIZING SYSTEM', 13 ,10, 10, 0    
story2 db ' > FIRST BOOT HAS BEEN INITIALIZED', 13 ,10, 10, 0    
story3 db ' > INITIALIZING BOOT 2', 13 ,10, 10, 0    
story4 db ' > SETTING KERNEL POSITION', 13 ,10, 10, 0    
story5 db ' > INITIALIZING KERNEL', 13 ,10, 10, 0 
story6 db ' > Manual :', 13 ,10, 10, 0    
story7 db ' > Press any button after reading the question', 13 ,10, 10, 0    
story8 db ' > Tip :', 13 ,10, 10, 0    
story9 db ' > A for left and D for right', 13 ,10, 10, 0    
initialize db ' > PRESS ANY KEY THE START <', 13 ,10, 10, 0 

start:
    xor ax, ax
    mov ds, ax ; Seta ds = 0
    mov es, ax

    mov ax,0x7E0  ;0x7E0<<1 + 0 = 0x7E00 // 'Seta' em ax a posição escolhida para o boot2
    mov es,ax
    xor bx,bx   ;Zerando o offset

    mov ah, 0x02 ;Lê um setor do disco
    mov al, 30  ;Quantidade de setores/blocos ocupados pelo kernel

    ;Usaremos as seguintes posições na memoria:
    mov ch,0    ;trilha 1
    mov cl,3    ;setor 3
    mov dh,0    ;cabeca 3
    mov dl, 0   ;drive 0
    int 13h

    jc start  ;Se falhar volta o start
    jmp reset

reset:
    mov ah, 00h ;Reseta o controlador de disco
    mov dl, 0   ;Floppy disk
    int 13h

    jc reset    ;Se o acesso falhar, tenta novamente

    jmp load

load:
    ;Programa começa aqui

    ; Modo de vídeo
    mov ah, 0
    mov al, 12h
    int 10h

    ; Posição
    mov ah, 2
    mov bh, 0
    mov dh, 1
    mov dl, 0
    int 10h

    ; Cor do fundo
    mov ah, 0xb 
    mov bh, 0
    mov bl,0
    int 10h

    ;Cor da letra
    mov bl, 2

    cli ; Impede interrupções
    mov si, story1  ; Carrega o endereço da primeira mensagem em si
    call imprimirString  ; Chama a funcao imprimir
    mov dx, 1000
    call delay
    mov si, story2
    call imprimirString
    mov dx, 1000
    call delay
    mov si, story3
    call imprimirString
    mov dx, 1000
    call delay
    mov si, story4
    call imprimirString
    mov dx, 1000
    call delay
    mov si, story5
    call imprimirString
    mov si, story6
    call imprimirString
    mov dx, 1000
    mov si, story7
    call imprimirString
    mov dx, 1000
    mov si, story8
    call imprimirString
    mov dx, 1000
    mov si, story9
    call imprimirString
    mov dx, 6000 ; Pegamos dx referente ao delay

    ;Cor da letra
    mov bl, 15

    mov si, initialize
    call imprimirString
    
    ;espera usuario pressionar uma tecla
    call waitButton

    ;programa termina aqui

    jmp 0x7e00  ;pula para o setor de endereco 0x7e00 (start do boot2)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FUNÇÕES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

imprimirString:
    lodsb       ;Carrega uma letra de si em al e passa para o próximo caractere
    cmp al, 0   ;Ao chegar ao final, realiza o je
    je .done
    
    mov ah, 0xe ;Código da instrução para imprimir um caractere que está em al
    int 10h     ;Interrupção de vídeo.

    mov dx, 100
    call delay

    jmp imprimirString ;Loop condicional

    .done:   
        ret

delay:  ; Estabelece um tempo de resposta atraves de loop
  mov bp, dx
  loop:
  dec bp
  jnz loop
  dec dx   
  jnz loop
ret

waitButton:
    .main:
        ;coloca apontador na variavel
        mov di, input
        ;ler do teclado
        MOV AH, 0
        INT 16H

        stosb
        ;verifica se foi 'alguma coisa'
        mov dl, al
        cmp dl, 0
        ;se foi, acabou
        JNE .done
        ;senao, continua esperando
        JMP .main

    .done:
        ret