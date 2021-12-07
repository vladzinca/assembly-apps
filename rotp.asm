%include "io.mac"
;; de sters

section .text
    global rotp
    extern printf ;; de sters

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE
    mov     edx, ecx
label:
    ; PRINTF32 `%d\n\x0`, ecx
    neg     ecx
    add     ecx, edx
    lea     eax, [esi + ecx]
    sub     ecx, edx
    neg     ecx
    ; PRINTF32 `%s\n\x0`, eax
    mov     al,  byte [eax]
    ; PRINTF32 `%c\n\x0`, eax
    ; neg     ecx
    lea     ebx, [edi + ecx - 1]
    ; neg     ecx
    mov     bl,  byte [ebx]
    ; PRINTF32 `%c si %c\n\x0`, eax, ebx
    xor     al, bl
    mov     ebx, edx
    mov     edx, [ebp + 8]
    neg     ecx
    ; add     ecx, 20
    add     ecx, ebx
    mov     [edx + ecx], eax
    ; sub     ecx, 20
    sub     ecx, ebx
    neg     ecx
    mov     edx, ebx
    loop    label

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY