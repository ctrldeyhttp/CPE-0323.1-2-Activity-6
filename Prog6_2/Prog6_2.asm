.model small
.stack 100h
.data
    hexChars db '0123456789ABCDEF'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Load example value into AX
    mov ax, 1234h ; Initial value of AX

    ; Clear the most significant nibble of the higher byte of AX
    and ax, 0FFFh ; AX now retains its lower 12 bits, upper 4 bits cleared

    ; Set the least significant nibble of the lower byte of AX
    or ax, 000Fh  ; Sets the lowest 4 bits of AX

    ; Convert AX to hexadecimal string and display
    push ax        ; Save AX on stack
    call DisplayAX ; Call display function
    pop ax         ; Restore AX

    ; Exit program
    mov ax, 4C00h ; Terminate program
    int 21h       ; DOS interrupt

main endp

; Function to display AX in hexadecimal
DisplayAX proc
    push ax
    push bx
    push cx
    push dx

    mov cx, 4    ; There are 4 digits to process
    mov bx, ax   ; Store AX in BX for processing

next_digit:
    mov dx, 0    ; Clear DX for the division
    mov ax, bx   ; Get the current value in BX
    and ax, 000Fh; Isolate the lowest nibble
    push ax      ; Save the digit on stack

    shr bx, 4    ; Shift BX right by 4 bits to get the next digit
    loop next_digit

    ; Display each digit
    mov cx, 4    ; Four digits to display
print_digit:
    pop dx       ; Get digit from stack
    add dl, '0'  ; Convert to ASCII
    cmp dl, '9'  ; Check if the digit is greater than '9'
    jbe print_char
    add dl, 7    ; Adjust ASCII for A-F

print_char:
    mov ah, 02h  ; Function to display character
    int 21h      ; DOS interrupt for printing
    loop print_digit

    pop dx
    pop cx
    pop bx
    pop ax
    ret
DisplayAX endp

end main
