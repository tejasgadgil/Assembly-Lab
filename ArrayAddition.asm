; This assembly code takes an array, converts its elements to ASCII characters, reverses them, and stores them in another array.
section .data
    msg1 db "Your array: ", 0ah
    lmsg1 equ $ - msg1
    msg2 db "Reversed array: ", 0ah
    lmsg2 equ $ - msg2
    arr1 db 01h, 02h, 03h, 04h, 05h
    arr2 db 00h, 00h, 00h, 00h, 00h

section .text
    global _start
    _start:
        mov esi, arr1   ; Point ESI to arr1
        mov edi, arr2   ; Point EDI to arr2
        mov ecx, 5      ; Set loop counter to 5

    up:
        mov al, [esi]       ; Load value from arr1 to AL
        add al, 30h         ; Convert value to ASCII
        mov [edi + ecx], al ; Store ASCII value in arr2
        mov dl, 30h         ; Reset DL to '0'
        add [esi], dl       ; Increment value in arr1
        inc esi             ; Move to next element in arr1
        loop up             ; Repeat until counter is 0

    ; Print original array
        mov eax, 4          ; syscall number for sys_write
        mov ebx, 1          ; file descriptor 1 (stdout)
        mov ecx, msg1       ; pointer to message
        mov edx, lmsg1      ; message length
        int 80h             ; call kernel

        mov eax, 4          ; syscall number for sys_write
        mov ebx, 1          ; file descriptor 1 (stdout)
        mov ecx, arr1       ; pointer to arr1
        mov edx, 6          ; array length (including newline character)
        int 80h             ; call kernel

    ; Print reversed array
        mov eax, 4          ; syscall number for sys_write
        mov ebx, 1          ; file descriptor 1 (stdout)
        mov ecx, msg2       ; pointer to message
        mov edx, lmsg2      ; message length
        int 80h             ; call kernel

        mov eax, 4          ; syscall number for sys_write
        mov ebx, 1          ; file descriptor 1 (stdout)
        mov ecx, arr2       ; pointer to arr2
        mov edx, 6          ; array length (including newline character)
        int 80h             ; call kernel

    ; Exit the program
        mov eax, 1          ; syscall number for sys_exit
        mov ebx, 0          ; exit code 0
        int 80h             ; call kernel
