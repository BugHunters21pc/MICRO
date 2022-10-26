
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h  

;clear screen
mov ah,00
mov al,02
int 10h
 
;toggle intensity/blinking.
mov ax, 1003h
mov bx, 0
int 10h                    


;set cursor position
mov dh, 10
mov dl, 20
mov bh, 0
mov ah, 2
int 10h  

;inputs 1 chr from user
mov ah,01h
int 21h

;display 1 chr stored in dl
mov dl,'a'
mov ah,02h
int 21h 

;output character to printer
mov ah, 5
mov dl, 'a'
int 21h

; direct console input or output
mov ah, 6
mov dl, 'a'
int 21h       ; output character. 

mov ah, 6
mov dl, 255
int 21h       ; get character from keyboard buffer (if any) or set ZF=1.

;character input without echo to AL
mov ah, 7
int 21h

;

;display string method1
lea dx,x
mov ah,09h
int 21h                

;display string method2
mov dx, offset msg
mov ah, 9
int 21h

;terminates the pro execution                             
mov ah,4ch
int 21h  

;write string
mov al, 1
mov bh, 0
mov bl, 0011_1011b
mov cx, msg1end - offset msg1 ; calculate message size. 
mov dl, 10
mov dh, 7
push cs
pop es
mov bp, offset msg1
mov ah, 13h
int 10h
jmp msg1end
msg1 db " hello, world! "
msg1end:

x db 'hello$'
msg db "hello world $" 

;gets user input and prints it
mov dx, offset buffer
mov ah, 0ah
int 21h
jmp print
buffer db 10,?, 10 dup(' ')
print:
xor bx, bx
mov bl, buffer[1]
mov buffer[bx+2], '$'
mov dx, offset buffer + 2
mov ah, 9
int 21h     

;make directory
mov dx, offset filepath
mov ah, 39h
int 21h

filepath DB "C:\mydir", 0 

;open existing file
mov al, 2
mov dx, offset filename
mov ah, 3dh
int 21h
jc err
mov handle, ax
jmp k
filename db "myfile.txt", 0
handle dw ?
err:
; .... 
k:

ret
