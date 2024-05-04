section .data
NUM dq 123456789ABCDEF0h  ; 64-bit number

section .text
global _start

_start:
    mov rax, [NUM]         ; Load the 64-bit number into RAX
    mov rcx, 64            ; Set the loop counter for 64 bits

print_loop:
    shr rax, 1             ; Shift right by one, moving the LSB into the carry flag
    jc print_one           ; Jump if carry flag is set (bit was 1)
    mov rdi, '0'           ; Prepare to print '0'
    call print_char
    jmp next_bit

print_one:
    mov rdi, '1'           ; Prepare to print '1'
    call print_char

next_bit:
    dec rcx                ; Decrement the loop counter
    jnz print_loop         ; Continue loop if not zero

    ; Exit the program
    mov eax, 60            ; syscall number for exit
    xor edi, edi           ; status code 0
    syscall                ; make syscall to exit

print_char:                ; Procedure to print a character
    mov rax, 1             ; syscall number for write
    mov rsi, rsp           ; pointer to the top of the stack where the character will be
    push rdi               ; push the character onto the stack
    mov rdx, 1             ; number of bytes to write
    mov rdi, 1             ; file descriptor 1 is stdout
    syscall                ; make syscall to write
    pop rdi                ; clean the stack
    ret                    ; return from the procedure
