;define data segment
data segment
        p1 db 'input the number:(1-9)','$'
        p2 db 'the result is :' , '$'
        cr db 0dh,0ah,'$'
data ends

;define stack segment
sstack segment stack 'stack'
        sa db 100 dup(?)
sstack ends

;define code segment
code segment
        assume cs:code , ds:data , ss:sstack
main    proc far
start:  push ds
        sub ax,ax
        push ax
        mov ax,data
        mov ds, ax
        mov ah,09
        lea dx,p1
        int 21h
        mov ah,1
        int 21h
        and al,0fh
        mov bl,al
        lea dx,cr
        mov ah,09h
        int 21h
        mov dx,0
        mov al,bl
        call fact
        mov bx,dx
        mov ah,09h
        lea dx,p2
        int 21h

        mov al,bh
        call dispal
        mov al,bl
        call dispal
        pop ax
        pop ds
        mov ah,4ch
        int 21h
main    endp

;input param: al=N
;output param: dx
fact    proc       ;sub procdure
        cmp al,1h
        jnz chn
        mov dl,0ah
        ret
chn:    push ax
        dec al
        call fact
        pop ax
        add dx,2h
        ret
fact endp

;input param: al
dispal  proc
        push cx
        push dx
        push ax
        mov cl,4
        shr al,cl
        or al,30h
        cmp al,3ah
        jb br1
        add al,7
br1:    mov dl,al
        mov ah,2
        int 21h
        pop ax
        and al,0fh
        or  al,30h
        cmp al,3ah
        jb br2
        add al,7
br2:    mov dl,al
        mov ah,2
        int 21h
        pop dx
        pop cx
        ret
dispal endp
code    ends
        end start
