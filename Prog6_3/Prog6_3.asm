.model small
.stack 100h
.data
.code

main proc
    mov ax, @data
    mov ds, ax

    ; Assuming an initial value for AX
    mov ax, 1234h  ; Load AX with initial value

    ; Multiply AX by 8 using shift left
    mov bx, ax     ; Copy AX to BX
    shl bx, 3      ; BX = AX * 8

    ; Multiply AX by 2 using shift left
    mov cx, ax     ; Copy AX to CX
    shl cx, 1      ; CX = AX * 2

    ; Add BX and CX to get 10 * AX
    add bx, cx     ; BX = 8*AX + 2*AX

    ; At this point, BX contains the result 10*AX
    ; Display the result
    push bx        ; Save BX for displaying
    call DisplayAX ; Display BX
    pop bx         ; Restore BX

    ; Exit program
    mov ax, 4C00h  ; Terminate program
    int 21h        ; DOS interrupt

main endp

; Function to display AX in hexadecimal
DisplayAX proc
    push ax
    push bx
    push cx
    push dx

    mov cx, 4    ; There are 4 digits to process
    mov ax,  bx   ; Store AX in BX for processing

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
