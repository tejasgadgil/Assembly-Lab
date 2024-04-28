; This assembly code calculates the sum of elements in the array 'arr' and then adds '30h' (for ascii) to the sum. The result is then printed to stdout.

section .data
    arr db 02h, 01h, 01h, 02h, 02h

section .bss
    sum resb 2

section .text
    global _start
_start:
    mov ecx, 5         ; Set loop counter to 5 (number of elements in arr)
    mov eax, sum       ; Load address of sum into eax
    mov esi, arr       ; Load address of arr into esi

UP:
    mov edx, [esi]     ; Load value at address pointed by esi into edx
    add [eax], edx     ; Add value in edx to sum in memory pointed by eax
    inc esi            ; Increment esi to point to the next element in arr
    dec ecx            ; Decrement loop counter
    jnz UP             ; Jump to UP if ecx is not zero

    mov dl, 30h        ; Load '0x30' (48 in decimal) into dl
    add [eax], dl      ; Add '0x30' to the sum in memory

    ; System call to write sum to stdout
    mov eax, 4         ; syscall number 4 (sys_write)
    mov ebx, 1         ; file descriptor 1 (stdout)
    mov ecx, sum       ; address of sum (to be printed)
    mov edx, 1         ; number of bytes to write
    int 80h            ; make syscall

    ; Exit program
    mov eax, 1         ; syscall number 1 (sys_exit)
    mov ebx, 0         ; exit status 0
    int 80h            ; make syscall
