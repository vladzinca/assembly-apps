%include "io.mac"
;; de sters

; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages
    extern printf ;; de sters

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE
    xor     eax, eax
    xor     ebx, ebx    ; fara asta prima citire ar fi un numar random
    xor     edx, edx
label:
    mov     esi, [ebp + 12]
    PRINTF32 `Iteratia %d, \x0`, edx

    mov     ax, [esi + my_date.day]
    ; PRINTF32 `present day: %d, \x0`, eax
    mov     bx, [edi + edx * my_date_size + my_date.day]
    ; PRINTF32 `birthday: %d, \x0`, ebx

    xor     ecx, ecx
    mov     cx, [esi + my_date.month]

    cmp     bx, ax
    jle     label1
    ; PRINTF32 `present month: %d, \x0`, eax
    dec     cx
    ; PRINTF32 `present month after dec: %d\n\x0`, eax
label1:

    xor     eax, eax
    xor     ebx, ebx

    mov     ax, cx
    xor     ecx, ecx
    mov     ecx, [ebp + 20]

    ; PRINTF32 `present month after -1: %d, \x0`, eax
    mov     bx, [edi + edx * my_date_size + my_date.month]
    ; PRINTF32 `birth month: %d\n\x0`, ebx

    xor     ecx, ecx
    mov     ecx, [esi + my_date.year]

    cmp     bx, ax
    jle     label2
    dec     ecx

label2:

    xor     eax, eax
    xor     ebx, ebx

    mov     eax, ecx
    xor     ecx, ecx
    mov     ecx, [ebp + 20]

    PRINTF32 `present year after -1: %d, \x0`, eax
    mov     ebx, [edi + edx * my_date_size + my_date.year]
    PRINTF32 `birth year: %d, \x0`, ebx

    sub     eax, ebx
    PRINTF32 `age: %d\n\x0`, eax

    mov     dword [ecx + 4*edx], eax

    xor     eax, eax
    xor     ebx, ebx

    ;; mai ai de facut cu varsta negativa

    ; PRINTF32 `in prezent \x0`
    ; mov     bx, [esi + my_date.day]
    ; PRINTF32 `dd: %d \x0`, ebx
    ; mov     bx, [esi + my_date.month]
    ; PRINTF32 `mm: %d \x0`, ebx
    ; mov     ebx, [esi + my_date.year]
    ; PRINTF32 `yy: %d \x0`, ebx

    ; PRINTF32 `birthday \x0`
    ; mov     bx, [edi + eax*my_date_size + my_date.day]
    ; PRINTF32 `dd: %d \x0`, ebx
    ; mov     bx, [edi + eax*my_date_size + my_date.month]
    ; PRINTF32 `mm: %d \x0`, ebx
    ; mov     ebx, [edi + eax*my_date_size + my_date.year]
    ; PRINTF32 `yy: %d\n\x0`, ebx

    ; mov ebx, [edi + eax*my_date_size + my_date.year]
    ;sub ebx, esi
    ;mov dword [ecx + 4*eax], ebx

    inc     edx
    cmp     edx, [ebp + 8]
    jl      label

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
