%include "io.mac"
;; de sters

section .data
    extern len_cheie, len_haystack

section .text
    global columnar_transposition
    extern printf ;; de sters

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE
    mov ecx, [len_cheie]
    ; PRINTF32 `%d\n\x0`, ecx
label
    dec ecx
    neg ecx
    add ecx, [len_cheie]
    dec ecx
    mov eax, [edi + 4*ecx]
    PRINTF32 `ecx: %d si eax: %d\n\x0`, ecx, eax
    inc ecx
    sub ecx, [len_cheie]
    neg ecx
    inc ecx
    loop label

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY