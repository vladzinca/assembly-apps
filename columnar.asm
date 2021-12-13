section .data
    extern len_cheie, len_haystack

section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]  ; key
    mov     esi, [ebp + 12] ; haystack
    mov     ebx, [ebp + 16] ; ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE
    ;; salveaza len_cheie in ecx
    mov     ecx, [len_cheie]
    ;; foloseste registrele ebx si edi pe post de contor care indica pozitia la
    ;; care se poate scrie in ciphertext, le initializeaza cu 0
    xor     ebx, ebx
    xor     edi, edi
fiecareColoana:
    ;; prelucreaza ecx ca sa itereze 0, 1, ..., (len_cheie - 1)
    dec     ecx
    neg     ecx
    add     ecx, [len_cheie]
    dec     ecx
    ;; scrie in edx valoarea coloanei de pe care trebuie citite elementele in
    ;; cadrul iteratiei curente
    mov     edi, [ebp + 8]
    mov     edx, [edi + 4 * ecx]
    ;; acum ca la aceasta iteratie nu se mai foloseste edi, dar se va folosi
    ;; ebx, muta contorul in ebx
    mov     edi, ebx
fiecareElement:
    ;; pentru fiecare coloana citeste elementele din haystack si le scrie in
    ;; ciphertext; scrie in eax elementul de pe linia curenta
    mov     al, byte [esi + edx]
    ;; scrie elementul in vectorul ciphertext, la pozitia indicata de contor
    mov     ebx, [ebp + 16]
    mov     byte [ebx + edi], al
    ;; incrementeaza valoarea contorului
    inc     edi
    ;; trece la elementul de pe urmatoarea linie si de pe coloana curenta
    add     edx, [len_cheie]
    ;; daca elementul de pe urmatoarea linie si de pe coloana curenta exista,
    ;; continua iteratia coloanei
    cmp     edx, [len_haystack]
    jl      fiecareElement
    ;; acum ca la inceputul urmatoarei iteratii nu se mai foloseste ebx, dar se
    ;; va folosi edi, muta contorul in edi
    mov     ebx, edi
    ;; reface in ecx valoarea necesara iteratiei cu loop
    ;; (len_cheie - 1), 19, ..., 1
    inc     ecx
    sub     ecx, [len_cheie]
    neg     ecx
    inc     ecx
    loop    fiecareColoana
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY