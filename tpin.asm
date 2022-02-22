data segment
txt0 db 'oh,la 1ch.......$'
text1 db '****Programme principal en cours****$'
text2 db ,0dh,0ah,'$'
text3 db 'deroutement fait$'
melissa db 18
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


install proc ;procedure d'installation de la nouvelle routine 
mov ax,mon_code
mov ds,ax
mov dx,offset affiche
mov al,1ch
mov ah,25h
int 21h
ret
install endp

affiche:   ;nouvelle routine 
mov ax,data
mov ds,ax
dec melissa
jnz re
call affiche_text0
mov melissa,18
re:
iret

affiche_text0 proc 
mov ax,data
mov ds,ax
mov dx,offset txt0
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
mov bx,0ffffh
mov si,0ffffh
call sauvgarde
call install
call affiche_text3
call affiche_text2
call affiche_text2
call affiche_text2
encore:
call affiche_text2
call affiche_text1
int 08h
mov cx,0fffh
boucle: 
mov ax,0ffh
bc1:
dec ax
jnz bc1
mov ax,0fffh
bc2:
dec ax
jnz bc2
mov ax,0ffh
bc3:
dec ax
jnz bc3
mov ax,0ffh
bc4:
dec ax
jnz bc4
mov al,0ffh
bc5:
dec al
jnz bc5
mov al,0ffh
bc6:
dec al
jnz bc6
mov al,0ffh
bc7:
dec al
jnz bc7
mov al,0ffh
bc8:
dec al
jnz bc8
mov al,0ffh
bc9:
dec al
jnz bc9
mov al,0ffh
bc10:
dec al
jnz bc10
mov al,0ffh
bc11:
dec al
jnz bc11
mov al,0ffh
bc12:
dec al
jnz bc12
mov al,0ffh
bc13:
dec al
jnz bc13
mov al,0fh
bc14:
dec al
jnz bc14
mov al,0fh
bc15:
dec al
jnz bc15
mov al,0fh
bc16:
dec al
jnz bc16
mov al,0fh
bc17:
dec al
jnz bc17
mov al,0fh
bc18:
dec al
jnz bc18
mov al,0fh
bc19:
dec al
jnz bc19
loop boucle
call affiche_text2
jmp encore
call restore
mov ax,4C00H
int 21h
mon_code ends
end deb

