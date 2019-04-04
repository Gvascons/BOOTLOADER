org 0x7C00; 'Seta' o endereço do boot1
jmp 0x0000:start; Faz cs = 0

start:
    mov ax, 0
    mov ds, ax ; Seta ds = 0

reset: ;Reseta o disco
    mov ah,0        
    mov dl,0        
    int 13h         
    jc reset; Volta ao reset em caso de falha 

carregaBoot2: ;'Instancia' o boot2
    mov ax,0x50     ;0x50<<1 + 0 = 0x500 // 'Seta' em ax a posição escolhida para o boot2
    mov es,ax
    xor bx,bx       ;Zerando o offset

    mov ah, 0x02    ;lê setor do disco // 'Seta' posição de leitura de boot2 na memória
    mov al,1        ;quantidade de blocos ocupados por boot2
    mov dl,0        

    ;Usaremos as seguintes posições na memoria:
    mov ch,0	;trilha 1
    mov cl,2	;setor 2
    mov dh,0	;cabeca 3
    int 13h
    jc carregaBoot2	;Em caso de erro, tenta de novo
 
    jmp 0x500	;Pula para a posição carregada

end: 
times 510-($-$$) db 0	;Preenche o resto do setor com zeros 
dw 0xaa55  