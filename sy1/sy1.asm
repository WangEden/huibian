DATAS SEGMENT
	;�˴��������ݶδ���
    msg1 db 'Input a character:', 0ah, 0dh, '$'
    msg2 db 0ah, 0dh, 'Its ASCII hexadecimal form: ', 0ah, 0dh, '$'
    xx db ?
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;�˴��������δ���
    mov dx, offset msg1
    MOV AH,09H
    INT 21H; ��ʾmsg1
    mov ah, 01h
    int 21h; ���������ַ�
    mov di, offset xx
    mov [di], al; д���ַ���ASCII��
    mov ch, 2
    mov cl, 4
    mov si, offset xx
    mov bl, [si]; ���ַ���ֵ�洢��bl
    mov dx, offset msg2
    mov ah, 09h
    int 21h; ��ʾmsg2
next:
	ror bl, cl
	mov dl, 0fh
	and dl, bl; ��һ��ȡ����λ���ڶ���ȡ����λ
	cmp dl, 0ah
	jl addz; С��A������+7��һ��
	add dl, 07h
	addz:
		add dl, 30h
		mov ah, 02h
		int 21h; ��һ����ʾ����λ��ascii�룬�ڶ�����ʾ����λ��ascii��
		dec ch
		jnz next
	mov ah, 4ch
	int 21h
CODES ENDS
    END START

