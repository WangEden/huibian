DATAS SEGMENT
	;此处输入数据段代码
    msg1 db 'Input a character:', 0ah, 0dh, '$'
    msg2 db 0ah, 0dh, 'Its ASCII hexadecimal form: ', 0ah, 0dh, '$'
    xx db ?
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    mov dx, offset msg1
    MOV AH,09H
    INT 21H; 显示msg1
    mov ah, 01h
    int 21h; 键盘输入字符
    mov di, offset xx
    mov [di], al; 写入字符的ASCII码
    mov ch, 2
    mov cl, 4
    mov si, offset xx
    mov bl, [si]; 把字符的值存储到bl
    mov dx, offset msg2
    mov ah, 09h
    int 21h; 显示msg2
next:
	ror bl, cl
	mov dl, 0fh
	and dl, bl; 第一次取高四位，第二次取第四位
	cmp dl, 0ah
	jl addz; 小于A则跳过+7这一步
	add dl, 07h
	addz:
		add dl, 30h
		mov ah, 02h
		int 21h; 第一次显示高四位的ascii码，第二次显示第四位的ascii码
		dec ch
		jnz next
	mov ah, 4ch
	int 21h
CODES ENDS
    END START

