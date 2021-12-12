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
;     mov ecx, [len_haystack]
; label
;     dec ecx
;     neg ecx
;     add ecx, [len_haystack]
;     dec ecx
;     mov al, byte [esi + ecx]
;     PRINTF32 `ecx: %d si eax: %c\n\x0`, ecx, eax
;     inc ecx
;     sub ecx, [len_haystack]
;     neg ecx
;     inc ecx
;     loop label

    ; xor eax, eax
    mov ecx, [len_cheie] ;; 5
    xor edi, edi ;; foloseste edi si ebx interschimbabil ca sa mentina cursorul, le pune la loc [ebp + 8] si [ebp + 16] cand are nev
    xor ebx, ebx
label: ;; 5, 4, ... 1
    dec ecx ;; 4, 3, ... 0
    neg ecx ;; -4, -3, ..., 0
    add ecx, [len_cheie] ;; 1, 2, ..., 5
    dec ecx ;; 0, 1, ..., 4
    xor edx, edx
    mov edi, [ebp + 8]
    mov edx, [edi + 4*ecx] ;; pune in edx valoarea coloanei de pe care trebuie citite literele
    xor edi, edi ;; contorul i=0
    mov edi, ebx ;; pune valoarea contorului i cyphertext[i] in edi, urmeaza ca ebx sa fie folosit
label2: ;; pentru fiecare coloana citeste si pune literele de pe ea
    mov al, byte [esi + edx] ; pe rand, litera de pe coloana curenta
    mov ebx, [ebp + 16] ; adresa pentru a scrie in ciphertext
    ; PRINTF32 `%d\n\x0`, edi
    mov byte [ebx + edi], al ; pune in ciphertext[i] litera
    inc edi ; creste contorul i
    ; PRINTF32 `eax: %c\n\x0`, eax
    ; PRINTF32 `ecx: %d si edx: %d\n\x0`, ecx, edx
    add edx, [len_cheie] ; trece la elementul de pe coloana corecta si urmatoarea linie
    cmp edx, [len_haystack] ; continua doar daca acesta exista
    jl label2
    xor ebx, ebx ; reinitializeaza ebx
    ; PRINTF32 `ebx: %d\n\x0`, edi
    mov ebx, edi ; pune valoarea contorului i in ebx, urmeaza ca edi sa fie folosit
    
    inc ecx ;; repara ecx-ul ca sa poata face instructiunea loop 5 4 3 2 1
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