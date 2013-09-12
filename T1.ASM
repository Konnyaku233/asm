;define data segment
data segment
        p1 db 'The result is :$'
        p2 db 'the result is :' , '$'
        cr db 0dh,0ah,'$'
        num dw  1234h,5678h,1234h,5678h
        res dw  4 dup(0)
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

       ;mov ah,1
       ;int 21h
       ;and al,0fh
        sub bx,bx
        mov bx , offset res

        mov cx,word ptr num+6
        mov ax,word ptr num+2
        mul cx
        add [bx+6],ax
        add [bx+4],dx

        mov ax,word ptr num
        mul cx
        add [bx+4],ax
        jnc next1
        mov ax,01h
        add [bx+2],ax
next1:  add [bx+2],dx
        mov cx,word ptr num+4
        mov ax,word ptr num+2
        mul cx
        add [bx+4],ax
        jnc next2
        mov ax,01h
        add [bx+2],ax
next2:  add [bx+2],dx
        jnc next3
        mov ax,01h
        add [bx],ax
next3:  mov ax,word ptr num
        mul cx
        add [bx+2],ax
        jnc next4
        mov ax,01h
        add [bx],ax
next4:  add [bx],dx

        ;output result
        mov dx,[bx]
        mov al,dh
        call dispal
        mov al,dl
        call dispal

        mov dx,[bx+2]
        mov al,dh
        call dispal
        mov al,dl
        call dispal

        mov dx,[bx+4]
        mov al,dh
        call dispal
        mov al,dl
        call dispal

        mov dx,[bx+6]
        mov al,dh
        call dispal
        mov al,dl
        call dispal
        pop ax
        pop ds

        mov ah,4ch
        int 21h
main    endp

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
