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
    ;; testeaza daca data de nastere e in viitor
    mov     eax, [esi + my_date.year] ;;anul din prezent
    mov     ebx, [edi + edx * my_date_size + my_date.year] ;;anul nasteriii
    cmp     ebx, eax
    jle     label3
    ; daca anul nasterii e mai mare ca anul din prezent
    mov     eax, 0
    mov     dword [ecx + 4*edx], eax ; pune 0
    cmp     eax, 0
    je      labelfinal ; termina iteratia
    
;; daca anul nasterii nu e mai mare ca anul prezent    
label3:

    mov     eax, [esi + my_date.year] ;;anul din prezent
    mov     ebx, [edi + edx * my_date_size + my_date.year] ;;anul nasterii
    cmp     eax, ebx
    jne     label4
    ; daca anul nasterii si anul prezent sunt egali
    xor     eax, eax
    xor     ebx, ebx

    mov     ax, [esi + my_date.month] ;; luna din prezent
    mov     bx, [edi + edx * my_date_size + my_date.month] ;; luna nasterii
    cmp     bx, ax
    jle     label5
    ;; daca luna nasterii e mai mare ca luna din prezent
    mov     eax, 0
    mov     dword [ecx + 4*edx], eax ;; scrie 0
    cmp     eax, 0
    je      labelfinal ;; termina iteratia

; daca luna nasterii nu e mai mare ca luna din prezent
label5:

    mov     ax, [esi + my_date.month] ;; luna din prezent
    mov     bx, [edi + edx * my_date_size + my_date.month] ;; luna nasterii
    cmp     ax, bx
    jne     label4 ;; daca lunile nu sunt egale (si nici luna nasterii > luna curenta), sari
    ;; daca lunile sunt egale (nu s-a sarit mai sus)
    xor     eax, eax
    xor     ebx, ebx

    mov     ax, [esi + my_date.day] ;; ziua din prezent
    mov     bx, [edi + edx * my_date_size + my_date.day] ;; ziua nasterii
    cmp     bx, ax
    jle     label4 ;; daca ziua nasterii < ziua curenta (comportament normal), fa algoritmul obisnuit
    ;; daca ziua nasterii e mai mare ca ziua din prezent
    mov     eax, 0
    mov     dword [ecx + 4*edx], eax ;; scrie 0
    cmp     eax, 0
    je      labelfinal ;; termina iteratia

; daca anul nasterii si anul din prezent nu sunt egali, si nu s-a trecut de iteratie la "anul nasterii > anul din prezent"
label4:
    ;; daca data de nastere nu e in viitor:
    ;; algoritmul obisnuit (aici se ajunge pt input normal (data nasterii < data curenta))

    mov     ax, [esi + my_date.day] ;; ziua curenta
    ; PRINTF32 `present day: %d, \x0`, eax
    mov     bx, [edi + edx * my_date_size + my_date.day] ;; ziua nasterii
    ; PRINTF32 `birthday: %d, \x0`, ebx

    xor     ecx, ecx
    mov     cx, [esi + my_date.month] ;; luna curenta (din prezent)

    cmp     bx, ax
    jle     label1 ;; daca ziua nasterii <= ziua curenta, sari
    ; PRINTF32 `present month: %d, \x0`, eax

    ;; altfel scade o luna
    dec     cx
    ; PRINTF32 `present month after dec: %d\n\x0`, eax
label1: ;; aici sare daca ziua nasterii <= ziua curenta, cazul simplu

    xor     eax, eax
    xor     ebx, ebx

    mov     ax, cx ;; pune in ax luna din prezent (sau cu -1 depinde daca s-a facut)
    xor     ecx, ecx
    mov     ecx, [ebp + 20] ;; repara ecx ca reprezentand outputul (vectorul de varste)

    ; PRINTF32 `present month after -1: %d, \x0`, eax
    mov     bx, [edi + edx * my_date_size + my_date.month] ;; pune in bx luna nasterii
    ; PRINTF32 `birth month: %d\n\x0`, ebx

    xor     ecx, ecx
    mov     ecx, [esi + my_date.year] ;; pune in ecx anul prezent

    cmp     bx, ax ;; compara luna curenta cu luna nasterii
    jle     label2 ;; daca luna nasterii <= luna curenta, sari
    dec     ecx ;; altfel scade un an

label2: ;; aici sare daca lluna nasterii <= luna curenta, cazul simplu

    xor     eax, eax
    xor     ebx, ebx

    mov     eax, ecx ;; pune in eax anul din prezent (curent) (sau cu -1 depinde daca s-a facut)
    xor     ecx, ecx
    mov     ecx, [ebp + 20] ;; repara ecx ca reprezentand outputul

    ; PRINTF32 `present year after -1: %d, \x0`, eax
    mov     ebx, [edi + edx * my_date_size + my_date.year] ;; pune in ebx anul nasterii
    ; PRINTF32 `birth year: %d, \x0`, ebx

    sub     eax, ebx ;; scade din anul curent anul nasterii = varsta
    ; PRINTF32 `age: %d\n\x0`, eax

    mov     dword [ecx + 4*edx], eax ;; pune rezultatul in vectorul de varste

labelfinal: ;; cazul cand data nasterii e mai mare ca data din prezent, termina programul

    xor     eax, eax
    xor     ebx, ebx

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

    inc     edx ;; trece la urmatoarea iteratie
    cmp     edx, [ebp + 8] ;; daca a ajuns la lungime se opreste
    jl      label

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
