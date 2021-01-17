USE16                   ; 16-битный код
ORG 100h                ; Начало в адресе 100h
   MOV DX, hello
   MOV AH, 9
   INT 21h

   MOV AX, 4C00h
   INT 21h

hello db 'Hello, world!$'