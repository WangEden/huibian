DATAS SEGMENT                   ; 数据段开始
    WYD DB 55H, 32H, 30H, 32H, 31H, 34H, 31H, 36H, 37H, 36H  ; 定义一个字节数组WYD并初始化
DATAS ENDS                     ; 数据段结束

CODES SEGMENT                   ; 代码段开始
    ASSUME CS:CODES,DS:DATAS    ; 设置代码段寄存器CS和数据段寄存器DS的关联

START:                          ; 程序入口
    MOV AX,DATAS                ; 将数据段DATAS的基地址加载到寄存器AX中
    MOV DS,AX                   ; 将AX中的值（即数据段基地址）移动到DS寄存器中
    MOV CX,10                   ; 将10存储到CX寄存器中，表示循环次数
    MOV SI,0                    ; 将0存储到SI寄存器中，作为WYD数组的索引
    MOV BH,WYD                  ; 将WYD数组的第一个元素的值移动到BH寄存器中
    MOV BL,WYD                  ; 将WYD数组的第一个元素的值移动到BL寄存器中

CMPP:                           ; 比较循环的开始
    CMP BH,WYD[SI]              ; 将BH寄存器的值与WYD数组索引为SI的元素进行比较
    JA SMA                      ; 如果BH大于WYD[SI]，则跳转到标签SMA
    MOV BH,WYD[SI]              ; 将WYD[SI]的值移动到BH寄存器中
    JMP LOOPP                   ; 无条件跳转到标签LOOPP

SMA:                            ; 如果不满足条件JA，则执行此处的代码
    CMP BL,WYD[SI]              ; 将BL寄存器的值与WYD数组索引为SI的元素进行比较
    JB LOOPP                    ; 如果BL小于WYD[SI]，则跳转到标签LOOPP
    MOV BL,WYD[SI]              ; 将WYD[SI]的值移动到BL寄存器中

LOOPP:                          ; 循环的末尾
    INC SI                      ; 将SI寄存器的值加1，用于下一次循环访问WYD数组中的下一个元素
    LOOP CMPP                   ; 循环次数减1，如果不为0，则跳转到标签CMPP，进行下一次循环比较

    MOV CH,4                    ; 将4存储到CH寄存器中
    MOV CL,4                    ; 将4存储到CL寄存器中

NEXT:                           ; 下一步操作
    ROL BX,CL                   ; 将BX寄存器的值循环左移CL位
    MOV DL,BL                   ; 将BL寄存器的值移动到DL寄存器中
   
    AND DL,0FH                ; 将DL寄存器与0FH进行按位与运算，将高位清零，保留低位的数值
    ADD DL,30H                ; 将DL寄存器的值加上30H，将其转换为ASCII码表示的字符
    CMP DL,'9'                ; 将DL寄存器的值与字符'9'进行比较
    JLE PRINT                 ; 如果DL小于等于'9'，则跳转到标签PRINT

    ADD DL,07H                ; 如果DL大于'9'，则加上07H，转换为大写字母字符

PRINT:                       ; 输出字符
    MOV AH,02H                ; 将02H存储到AH寄存器中，表示要进行字符输出的功能
    INT 21H                   ; 调用21H中断，执行字符输出功能

    DEC CH                    ; CH寄存器减1
    JNZ NEXT                  ; 如果CH不为0，则跳转到标签NEXT，进行下一次循环操作

    MOV AH,4CH                ; 将4CH存储到AH寄存器中，表示程序结束的功能
    INT 21H                   ; 调用21H中断，结束程序

CODES ENDS                   ; 代码段结束
END START                    ; 程序结束

