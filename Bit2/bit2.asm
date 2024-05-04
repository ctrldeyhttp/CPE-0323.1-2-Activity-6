TITLE bit.asm
.model small
.stack 100h
.data
num db 03dh
.code
main proc
mov ax,@data
mov ds,ax
mov bl,num
mov cx,8
here: shr bl,1
Jc is_one
Mov dl,30h
Jmp print
Is_one:
Mov dl,31h
Print:
Mov ah,2
int 21h
loop here
Exit: Mov ax, 4c00h
Int 21h
Main endp
End main
