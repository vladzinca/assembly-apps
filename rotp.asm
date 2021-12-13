section .text
    global rotp

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
    ;; FREESTYLsE STARTS HERE
    ;; salveaza len in edx
    mov     edx, ecx
fiecareElement:
    ;; prelucreaza ecx ca sa itereze 0, 1, ..., (len - 1)
    neg     ecx
    add     ecx, edx
    ;; copiaza in eax tot plaintext-ul incepand cu elementul plaintext[i]
    lea     eax, [esi + ecx]
    ;; copiaza in eax doar plaintext[i]
    mov     al, byte [eax]
    ;; reface in ecx valoarea necesara iteratiei cu loop (len - 1), 19, ..., 1
    sub     ecx, edx
    neg     ecx
    ;; copiaza in ebx key[len - i - 1]
    lea     ebx, [edi + ecx - 1]
    mov     bl, byte [ebx]
    ;; executa operatia xor intre plaintext[i] si key[len - i - 1] si salveaza
    ;; rezultatul in eax
    xor     al, bl
    ;; acum ca la aceasta iteratie nu se mai foloseste ebx, dar se va folosi
    ;; edx, muta len in ebx
    mov     ebx, edx
    mov     edx, [ebp + 8]
    ;; prelucreaza ecx ca sa itereze 0, 1, ..., (len - 1)
    neg     ecx
    add     ecx, ebx
    ;; copiaza in ciphertext[i] valoarea operatiei xor
    mov     byte [edx + ecx], al
    ;; reface in ecx valoarea necesara iteratiei cu loop (len - 1), 19, ..., 1
    sub     ecx, ebx
    neg     ecx
    ;; acum ca la inceputul urmatoarei iteratii nu se mai foloseste edx, dar se
    ;; va folosi ebx, muta len in edx
    mov     edx, ebx
    loop    fiecareElement
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY