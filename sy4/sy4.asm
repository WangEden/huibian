DATAS SEGMENT                   ; ���ݶο�ʼ
    WYD DB 55H, 32H, 30H, 32H, 31H, 34H, 31H, 36H, 37H, 36H  ; ����һ���ֽ�����WYD����ʼ��
DATAS ENDS                     ; ���ݶν���

CODES SEGMENT                   ; ����ο�ʼ
    ASSUME CS:CODES,DS:DATAS    ; ���ô���μĴ���CS�����ݶμĴ���DS�Ĺ���

START:                          ; �������
    MOV AX,DATAS                ; �����ݶ�DATAS�Ļ���ַ���ص��Ĵ���AX��
    MOV DS,AX                   ; ��AX�е�ֵ�������ݶλ���ַ���ƶ���DS�Ĵ�����
    MOV CX,10                   ; ��10�洢��CX�Ĵ����У���ʾѭ������
    MOV SI,0                    ; ��0�洢��SI�Ĵ����У���ΪWYD���������
    MOV BH,WYD                  ; ��WYD����ĵ�һ��Ԫ�ص�ֵ�ƶ���BH�Ĵ�����
    MOV BL,WYD                  ; ��WYD����ĵ�һ��Ԫ�ص�ֵ�ƶ���BL�Ĵ�����

CMPP:                           ; �Ƚ�ѭ���Ŀ�ʼ
    CMP BH,WYD[SI]              ; ��BH�Ĵ�����ֵ��WYD��������ΪSI��Ԫ�ؽ��бȽ�
    JA SMA                      ; ���BH����WYD[SI]������ת����ǩSMA
    MOV BH,WYD[SI]              ; ��WYD[SI]��ֵ�ƶ���BH�Ĵ�����
    JMP LOOPP                   ; ��������ת����ǩLOOPP

SMA:                            ; �������������JA����ִ�д˴��Ĵ���
    CMP BL,WYD[SI]              ; ��BL�Ĵ�����ֵ��WYD��������ΪSI��Ԫ�ؽ��бȽ�
    JB LOOPP                    ; ���BLС��WYD[SI]������ת����ǩLOOPP
    MOV BL,WYD[SI]              ; ��WYD[SI]��ֵ�ƶ���BL�Ĵ�����

LOOPP:                          ; ѭ����ĩβ
    INC SI                      ; ��SI�Ĵ�����ֵ��1��������һ��ѭ������WYD�����е���һ��Ԫ��
    LOOP CMPP                   ; ѭ��������1�������Ϊ0������ת����ǩCMPP��������һ��ѭ���Ƚ�

    MOV CH,4                    ; ��4�洢��CH�Ĵ�����
    MOV CL,4                    ; ��4�洢��CL�Ĵ�����

NEXT:                           ; ��һ������
    ROL BX,CL                   ; ��BX�Ĵ�����ֵѭ������CLλ
    MOV DL,BL                   ; ��BL�Ĵ�����ֵ�ƶ���DL�Ĵ�����
   
    AND DL,0FH                ; ��DL�Ĵ�����0FH���а�λ�����㣬����λ���㣬������λ����ֵ
    ADD DL,30H                ; ��DL�Ĵ�����ֵ����30H������ת��ΪASCII���ʾ���ַ�
    CMP DL,'9'                ; ��DL�Ĵ�����ֵ���ַ�'9'���бȽ�
    JLE PRINT                 ; ���DLС�ڵ���'9'������ת����ǩPRINT

    ADD DL,07H                ; ���DL����'9'�������07H��ת��Ϊ��д��ĸ�ַ�

PRINT:                       ; ����ַ�
    MOV AH,02H                ; ��02H�洢��AH�Ĵ����У���ʾҪ�����ַ�����Ĺ���
    INT 21H                   ; ����21H�жϣ�ִ���ַ��������

    DEC CH                    ; CH�Ĵ�����1
    JNZ NEXT                  ; ���CH��Ϊ0������ת����ǩNEXT��������һ��ѭ������

    MOV AH,4CH                ; ��4CH�洢��AH�Ĵ����У���ʾ��������Ĺ���
    INT 21H                   ; ����21H�жϣ���������

CODES ENDS                   ; ����ν���
END START                    ; �������

