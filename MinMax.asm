; This assembly code finds the minimum and maximum values in the array 'arr', converts all array elements into ASCII characters, and then prints the array along with the min and max values to stdout.

section .data
    msg1 db "Your array: ", 0ah
    lmsg1 equ $ - msg1
    msg2 db "Min is: ", 0ah
    lmsg2 equ $ - msg2
    msg3 db "Max is: ", 0ah
    lmsg3 equ $ - msg3
    arr db 01h, 02h, 03h, 04h, 05h

section .bss
    min resb 1
    max resb 1

section .text
    global _start
_start:
    mov esi, arr       ; Point esi to the start of the array
    mov al, [esi]      ; Initialize al with the first element of the array (for min)
    mov bl, [esi]      ; Initialize bl with the first element of the array (for max)
    mov ecx, 4         ; Set loop counter to 4 (since we compare the rest of the elements)
    inc esi            ; Move esi to the next element

compare:
    mov dl, [esi]      ; Load the current array element into dl
    cmp dl, al         ; Compare dl with al (current min)
    jl update_min      ; Jump to update_min if dl < al
    cmp dl, bl         ; Compare dl with bl (current max)
    jg update_max      ; Jump to update_max if dl > bl

continue:
    add dl, 30h        ; Convert dl (element) to ASCII
    mov [esi], dl      ; Store the ASCII value back into the array
    inc esi            ; Move to the next element
    loop compare       ; Loop until all elements are compared

    add al, '0'        ; Convert al (min) to ASCII
    add bl, '0'        ; Convert bl (max) to ASCII
    mov [min], al      ; Store the ASCII value of min
    mov [max], bl      ; Store the ASCII value of max
    jmp print          ; Jump to the print section

update_min:
    mov al, [esi]      ; Update al with the new minimum value
    jmp continue       ; Continue with the loop

update_max:
    mov bl, [esi]      ; Update bl with the new maximum value
    jmp continue       ; Continue with the loop

print:
    mov eax, 4         ; sys_write
    mov ebx, 1         ; file descriptor (stdout)
    mov ecx, msg1      ; message to print ("Your array: ")
    mov edx, lmsg1     ; message length
    int 80h            ; syscall to print message

    mov eax, 4         ; sys_write
    mov ebx, 1         ; file descriptor (stdout)
    mov ecx, arr       ; array to print
    mov edx, 6         ; array length
    int 80h            ; syscall to print array

    mov eax, 4         ; sys_write
    mov ebx, 1         ; file descriptor (stdout)
    mov ecx, msg2      ; message to print ("Min is: ")
    mov edx, lmsg2     ; message length
    int 80h            ; syscall to print message

    mov eax, 4         ; sys_write
    mov ebx, 1         ; file descriptor (stdout)
    mov ecx, min       ; min value (converted to ASCII)
    mov edx, 1         ; length of min value
    int 80h            ; syscall to print min value

    mov eax, 4         ; sys_write
    mov ebx, 1         ; file descriptor (stdout)
    mov ecx, msg3      ; message to print ("Max is: ")
    mov edx, lmsg3     ; message length
    int 80h            ; syscall to print message

    mov eax, 4         ; sys_write
    mov ebx, 1         ; file descriptor (stdout)
    mov ecx, max       ; max value (converted to ASCII)
    mov edx, 1         ; length of max value
    int 80h            ; syscall to print max value

exit:
    mov eax, 1         ; sys_exit
    mov ebx, 0         ; exit status (success)
    int 80h            ; syscall to exit
