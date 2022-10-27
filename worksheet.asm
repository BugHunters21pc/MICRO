;2.  Write an ALP to convert a string in lower case letter entered through the keyboard to a string in UPPER CASE and print it on the screen. 
org 100h
include 'emu8086.inc'
mov si,1000H
print 'enter a string: '
start:
 	mov ah,01H
 	int 21H
 	mov [si],al
 	inc si
 	cmp al,'$'
 	je end    
    	jmp start
end:
lea si,[1000H]
lea di,[2000h]  
mov cx,6
rep movsb
mov di,2000h
step1:
	mov al,[di]
	cmp al,'$'
	je end1
	sub al,32
	mov [di],al
	inc di
	jmp step1
end1:
printn
mov dx,offset [2000H]
mov ah,09H
int 21H
ret 

;3.  Write an ALP to  move  the cursor right,  left, up or down correspondingly  with  the arrow keys pressed. 
;setting a cursor   
org 100h
include 'emu8086.inc'
mov ah,02H
mov dh,14
mov dl,14
mov bh,0
int 10H
;print 'start'
;getting key up(48),down(50),left(4B) ,right(4D)
start:
	mov ah,00h
	int 16H
	cmp ah,48H
	je up
    	cmp ah,50H
    	je down
        	cmp ah,04BH
        	je left
            	cmp ah,04DH
            	jmp right
                	cmp al,24H
                	je end
                	jmp start
       	 
    
    
up:
	 
	mov ah,02H
	dec dh
	mov bh,0
	int 10H
	print 'U'
	jmp start
down:
	mov ah,02H
	inc dh
	mov bh,0
	int 10H  
	print 'D'
	jmp start
left:
	mov ah,02H
	dec dl
	mov bh,0
	int 10H
	print 'L'
	jmp start
right:
	mov ah,02H
	inc dl
	mov bh,0
	print 'R'
	jmp start  

end:
ret


;4.  Write a program in Assembly language that will display the message “ Key” every time a key is pressed. 
org 100h
include 'emu8086.inc'
mov ah,00H
int 16H
cmp ax,0
jz go
	print 'key'  
	jmp end

go:
 print 'no key'
 end:

;5.  Write an ALP that will determine it two numbers ( 0-9) are pressed in sequence. A sequence could be 1-2 or 8-9 etc., the program will display the message “ Sequence” if sequence numbers are pressed else ” not sequence”  
org 100h
include 'emu8086.inc'
print 'enter 1 number: '
mov ah,01H
int 21H
mov bl,al
inc bl
printn
print 'enter 2 nmber: '
mov ah,01H
int 21H
 printn
cmp bl,al

je go
   print 'not sequence'
   jmp end

go:
print 'sequence'    
end:
ret
;6.  Write an ALP to display” Hello,Welcome”on the centre of the screen after the key H is pressed. 
org 100h
include 'emu8086.inc'
mov ah,01H
int 21H
cmp al,48H
je go
 	jmp end
go:
mov ah,02H
mov dh,12
mov dl,25
mov bh,0
int 10H
print 'Hello,Welcome'
end:
ret
;7.  Write an ALP to make the screen flying with different colored pixels ( or with any special  characters  like  @  .,  or  *)  continuously  in  the  following  context.                             
On pressing a character like R, G or B, the different symbols or characters should fly 
on the screen. 
mov ah, 2
mov dh, 0
mov dl, 15
mov bh, 0

int 10h
start:
  mov ah,08H
  int 21H
  cmp al,072h
   je red
     cmp  al,062h
       je blue
         cmp al,067h
             je green
              CMP AL,'$'
                je end
                  JMP start
   
 
 
red:
   
   mov ah,02h
   dec dh
   inc dl
   inc dl
   dec dh
   mov bh,0
   int 10h
  mov ah,09
  mov al,'@'
  mov bl,04h
  mov cx,1
  int 10h
 
  jmp start
 
blue:

    mov ah,02h
   INC dh
   DEC dl
   DEC dl
   INC dh
   mov bh,0
   int 10h
  mov ah,09
  mov al,'$'
  mov bl,01h
  mov cx,1
  int 10h
 
  jmp start
 
 green:
     mov ah,02h
   INC dh
   DEC dl
   DEC dl
   INC dh
   inc dh
   inc dh
   inc dh
   mov bh,0
   int 10h

   
  mov ah,09
  mov al,'#'
  mov bl,02h
  mov cx,1
  int 10h
 
  jmp start
 
  END:
ret      

;8.  Draw on the screen a series of four concentric rectangles made of character *, with the gap of 1 blank space in all directions. Have the program terminated on the press of the key q. 
include 'emu8086.inc'
mov ah,02h
mov dh,09h
mov dl,020h
mov bl,0
int 10h     

mov cx,10
right:
    mov ah,02h
    inc dl
    mov bh,0 
    int 10h
    print '*'
    
    loop right
mov cx,5
down:
    mov ah,02h
    inc dh
    mov bh,0 
    int 10h
    print '*'
    loop down    
mov cx,9
left:
    mov ah,02H
    dec dl
    mov bh,0
    int 10h
    print '*'
    loop left  
mov cx,4    
up:
  mov ah,02h
  dec dh
   mov bh,0
   int 10H
   print '*'
   loop up

;9. Write a program to display the bits of a register or memory location. Use the INT 21H interrupts to display data on the display monitor     For example, if AL = 55h, then your program must display  AL = 01010101

include 'emu8086.inc'
org 100h  
mov [1009h],'$'
mov si,1008h
print 'enter the number: '  
call scan_num 
mov al,cl
mov cx,0
start:
    cmp cx,8
    je end
    shr al,1 
    inc cx
    jc go 
        mov [si],'0'  
        inc si 
        

go:
    mov [si],'1'  
    dec si
    jmp start
    
end:

define_scan_num
