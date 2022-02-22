data segment
text1 db 'tache1 en cours d''execution....',0dh,0ah,'$'
text2 db 'tache2 en cours d''execution....',0dh,0ah,'$'
text5 db ,0dh,0ah,'$'
text0 db 'deroutement fait',0dh,0ah,'$'
text3 db 'tache3 en cours d''execution....',0dh,0ah,'$'
text4 db 'tache4 en cours d''execution....',0dh,0ah,'$'
melissa db 91
ancien_ip dw ?
ancien_cs dw ?
data ends


ma_pile segment stack
dw 128 dup(?)
tos label word
ma_pile ends


mon_code segment
assume cs:mon_code, ds:data,ss:ma_pile

effacer proc;effacer l'ecran
mov ax,3
int 10h
ret
effacer endp

sauvgarde proc  ; procedure de sauvegarde de l'ancienne routine
mov ax,data
mov ds,ax
mov al,1ch
mov ah,35h
int 21h
mov ancien_ip,bx
mov ancien_cs,es
ret
sauvgarde endp

restore proc ;procedure de restoration 
mov ax,ancien_cs
mov ds,ax
mov dx,ancien_ip
mov al,1ch
mov ah,25h
int 21h 
ret
restore endp

affiche_text1 proc ;
mov ax,data
mov ds,ax
mov dx,offset text1
mov ah,9
int 21h
ret
affiche_text1 endp 

affiche_text2 proc ;
mov ax,data
mov ds,ax
mov dx,offset text2
mov ah,9
int 21h
ret
affiche_text2 endp 

affiche_text3 proc ;
mov ax,data
mov ds,ax
mov dx,offset text3
mov ah,9
int 21h
ret
affiche_text3 endp 

affiche_text4 proc ;
mov ax,data
mov ds,ax
mov dx,offset text4
mov ah,9
int 21h
ret
affiche_text4 endp 

affiche_text5 proc ;
mov ax,data
mov ds,ax
mov dx,offset text5
mov ah,9
int 21h
ret
affiche_text5 endp 


install1 proc ;procedure d'installation de la nouvelle routine 
mov ax,mon_code
mov ds,ax
mov dx,offset affiche1
mov al,1ch
mov ah,25h
int 21h
ret
install1 endp

install2 proc ;procedure d'installation de la nouvelle routine 
mov ax,mon_code
mov ds,ax
mov dx,offset affiche2
mov al,1ch
mov ah,25h
int 21h
ret
install2 endp

install3 proc ;procedure d'installation de la nouvelle routine 
mov ax,mon_code
mov ds,ax
mov dx,offset affiche3
mov al,1ch
mov ah,25h
int 21h
ret
install3 endp

install4 proc ;procedure d'installation de la nouvelle routine 
mov ax,mon_code
mov ds,ax
mov dx,offset affiche4
mov al,1ch
mov ah,25h
int 21h
ret
install4 endp

affiche1:   ;nouvelle routine 
mov ax,data
mov ds,ax
dec melissa
jnz re1
call affiche_text1
mov melissa,91
re1:
iret

affiche2:   ;nouvelle routine 
mov ax,data
mov ds,ax
dec melissa
jnz re2
call affiche_text2
mov melissa,91
re2:
iret

affiche3:   ;nouvelle routine 
mov ax,data
mov ds,ax
dec melissa
jnz re3
call affiche_text3
mov melissa,91
re3:
iret

affiche4:   ;nouvelle routine 
mov ax,data
mov ds,ax
dec melissa
jnz re4
call affiche_text4
mov melissa,91
re4:
iret

affiche_text0 proc 
mov ax,data
mov ds,ax
mov dx,offset text0
mov ah,9
int 21h
ret
affiche_text0 endp



deb :  ;le programme principal 
call effacer
mov ax,data
mov ds,ax
mov bx,ma_pile
mov ss,bx
call sauvgarde
call affiche_text0

call affiche_text5
call affiche_text5




encore:
call install1
int 08

mov cx,0ffffh
boucle: 
mov al,0fh
bc1:
dec al
jnz bc1
mov al,0fh
bc2:
dec al
jnz bc2
mov al,0fh
bc3:
dec al
jnz bc3
mov al,0fh
bc4:
dec al
jnz bc4
mov al,0fh
bc5:
dec al
jnz bc5
mov al,0fh
bc6:
dec al
jnz bc6
mov al,0fh
bc7:
dec al
jnz bc7
mov al,0fh
bc8:
dec al
jnz bc8
loop boucle

call install2
int 08h



mov cx,0ffffh
boucle20: 
mov al,0fh
bc21:
dec al
jnz bc21
mov al,0fh
bc22:
dec al
jnz bc22
mov al,0fh
bc23:
dec al
jnz bc23
mov al,0fh
bc24:
dec al
jnz bc24
mov al,0fh
bc25:
dec al
jnz bc25
mov al,0fh
bc26:
dec al
jnz bc26
mov al,0fh
bc27:
dec al
jnz bc27
;mov al,0fh
;bc28:
;dec al
;jnz bc28
loop boucle20



call install3
int 08h



mov cx,0ffffh
boucle30: 
mov al,0fh
bc31:
dec al
jnz bc31
mov al,0fh
bc32:
dec al
jnz bc32
mov al,0fh
bc33:
dec al
jnz bc33
mov al,0fh
bc34:
dec al
jnz bc34
mov al,0fh
bc35:
dec al
jnz bc35
mov al,0fh
bc36:
dec al
jnz bc36
mov al,0fh
bc37:
dec al
jnz bc37
;mov al,0fh
;bc38:
;dec al
;jnz bc38
loop boucle30



call install4
int 08h

mov cx,0ffffh
boucle40: 
mov al,0fh
bc41:
dec al
jnz bc41
mov al,0fh
bc42:
dec al
jnz bc42
mov al,0fh
bc43:
dec al
jnz bc43
mov al,0fh
bc44:
dec al
jnz bc44
mov al,0fh
bc45:
dec al
jnz bc45
mov al,0fh
bc46:
dec al
jnz bc46
mov al,0fh
bc47:
dec al
jnz bc47
mov al,2h
bc48:
dec al
jnz bc48
loop boucle40

call affiche_text5
call affiche_text5
jmp encore


call restore
mov ax,4C00H
int 21h
mon_code ends
end deb
mon_code ends