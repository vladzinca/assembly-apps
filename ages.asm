; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

; void ages(int len, struct my_date* present, struct my_date* dates,
;           int* all_ages);
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
    ;; foloseste registrul edx pe post de contor, il initializeaza cu 0
    xor     edx, edx
iteration:
    ;; verifica daca data nasterii e in viitor; mai intai testeaza daca anul
    ;; nasterii e in viitor
    mov     eax, [esi + my_date.year]
    mov     ebx, [edi + edx * my_date_size + my_date.year]
    ;; daca anul nasterii nu e mai mare ca anul din prezent
    cmp     ebx, eax
    jle     anNastereLEanPrezent
    ;; daca anul nasterii e mai mare ca anul din prezent, scrie 0 la varsta si
    ;; sare la urmatoarea iteratie
    mov     eax, 0
    mov     dword [ecx + 4*edx], 0
    cmp     eax, 0
    je      finishIteration
anNastereLEanPrezent:
    ;; testeaza daca anul nasterii e acelasi cu anul din prezent
    mov     eax, [esi + my_date.year]
    mov     ebx, [edi + edx * my_date_size + my_date.year]
    ;; daca anul nasterii si anul din prezent nu sunt egali
    cmp     eax, ebx
    jne     notInTheFuture
    ;; daca anul nasterii si anul din prezent sunt egali, testeaza daca luna
    ;; nasterii e in viitor
    mov     ax, [esi + my_date.month]
    mov     bx, [edi + edx * my_date_size + my_date.month]
    ;; daca luna nasterii nu e mai mare ca luna din prezent
    cmp     bx, ax
    jle     lunaNastereLElunaPrezent
    ;; daca luna nasterii e mai mare ca luna din prezent, scrie 0 la varsta si
    ;; sare la urmatoarea iteratie
    mov     eax, 0
    mov     dword [ecx + 4*edx], eax
    cmp     eax, 0
    je      finishIteration
lunaNastereLElunaPrezent:
    ;; testeaza daca luna nasterii e aceeasi cu luna din prezent
    mov     ax, [esi + my_date.month]
    mov     bx, [edi + edx * my_date_size + my_date.month]
    ;; daca luna nasterii si luna din prezent nu sunt egale
    cmp     ax, bx
    jne     notInTheFuture
    ;; daca luna nasterii si luna din prezent sunt egale, testeaza daca ziua
    ;; nasterii e in viitor
    mov     ax, [esi + my_date.day]
    mov     bx, [edi + edx * my_date_size + my_date.day]
    ;; daca luna nasterii nu e mai mare ca luna din prezent, data nasterii nu e
    ;; in viitor
    cmp     bx, ax
    jle     notInTheFuture
    ;; daca ziua nasterii e mai mare ca ziua din prezent, scrie 0 la varsta si
    ;; sare la urmatoarea iteratie
    mov     eax, 0
    mov     dword [ecx + 4*edx], eax
    cmp     eax, 0
    je      finishIteration
notInTheFuture:
    ;; calculeaza varsta unei persoane care nu se naste in viitor
    mov     ax, [esi + my_date.day]
    mov     bx, [edi + edx * my_date_size + my_date.day]
    mov     cx, [esi + my_date.month]
    ;; daca ziua nasterii nu e mai mare ca ziua curenta, sare la compararea
    ;; lunilor
    cmp     bx, ax
    jle     comparareaLunilor
    ;; daca ziua nasterii e mai mare ca ziua curenta, scade o luna din luna din
    ;; prezent
    dec     cx
comparareaLunilor:
    ;; scrie in eax valoarea lunii din prezent calculata anterior
    mov     ax, cx
    mov     bx, [edi + edx * my_date_size + my_date.month]
    mov     ecx, [esi + my_date.year]
    ;; daca luna nasterii nu e mai mare ca luna curenta, sare la compararea
    ;; anilor
    cmp     bx, ax
    jle     comparareaAnilor
    ;; daca luna nasterii e mai mare ca luna curenta, scade un an din anul din
    ;; prezent
    dec     ecx
comparareaAnilor:
    ;; scrie in eax valoarea anului din prezent calculata anterior
    mov     eax, ecx
    mov     ebx, [edi + edx * my_date_size + my_date.year]
    ;; calculeaza varsta ca diferenta dintre anul din prezent calculat anterior
    ;; si anul nasterii
    sub     eax, ebx
    ;; scrie varsta in vectorul de varste all_ages
    mov     ecx, [ebp + 20]
    mov     dword [ecx + 4*edx], eax
    ;; trece la urmatoarea iteratie, fie pentru ca s-a calculat varsta la
    ;; iteratia curenta, fie pentru ca data nasterii e in viitor
finishIteration:
    inc     edx
    cmp     edx, [ebp + 8]
    jl      iteration
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY