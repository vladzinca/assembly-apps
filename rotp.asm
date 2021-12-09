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
    mov     edx, ecx        ; salveaza lungimea in edx
label:
    ; PRINTF32 `%d\n\x0`, ecx
    neg     ecx
    add     ecx, edx        ; pune pe rand in ecx "i = " 0, 1, ... pana la len - 1
    lea     eax, [esi + ecx]    ; copiaza in eax tot plaintext-ul de la plaintext[i]
    sub     ecx, edx
    neg     ecx             ; reface ecx in valoarea iteratiei 20, 19, ... pana la 1
    ; PRINTF32 `%s\n\x0`, eax
    mov     al,  byte [eax] ; copiaza in eax doar plaintext[i]
    ; PRINTF32 `%c\n\x0`, eax
    ; neg     ecx
    lea     ebx, [edi + ecx - 1] ; copiaza in ebx tot key-ul de la key[len - i - 1]
    ; neg     ecx
    mov     bl,  byte [ebx] ; copiaza in ebx doar key[len - i - 1]
    ; PRINTF32 `%c si %c\n\x0`, eax, ebx
    xor     al, bl ; face operatia xor intre plaintext[ecx] si key[len-i-1] si salveaza rezultatul in eax
    mov     ebx, edx ; acum ca ebx e gol si o sa se ocupe edx-ul, pune in ebx lungimea
    mov     edx, [ebp + 8] ; muta edx unde trebuie sa scrie ciphertext[i]
    neg     ecx
    ; add     ecx, 20
    add     ecx, ebx ; face ecx "i = " 0, 1, ... pana la len - 1
    ; PRINTF32 `ecx: %d\n\x0`, ecx
    mov     byte [edx + ecx], al ; pune in ciphertext[i] valoarea lui xor
    ; sub     ecx, 20
    sub     ecx, ebx
    neg     ecx ; reface ecx in valoarea iteratiei 20, 19, ... pana la 1
    mov     edx, ebx ; acum ca edx e gol si o sa se ocupe ebx-ul, pune in edx lungimea
    loop    label

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY