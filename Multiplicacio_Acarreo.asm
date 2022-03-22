.model small
.stack 
datos segment 
    nombre db "Multiplicacion de dos numero por teclado",13,10,'$'
    mensaje1 db "Ingrese el primer valor: ",13,10,'$'
    mensaje2 db "Ingrese el segundo valor: ",13,10,'$'
    mensaje3 db "El resultado es: ",'$'
    suma db 0
    num1 db 0
    num2 db 0
    byteh db 0
    bytel db 0
    salto db " ",13,10,'$'
datos ends
codigo segment
    assume cs:codigo, ds: datos
inicio proc far 
    mov ax,datos
    mov ds,ax
;limpiar la pantalla
    mov ah, 00
    mov al, 03h
    int 10h

;inicializar registros 

    mov ah,02h
    mov dl,00
    int 10h

    mov ah,09h
    lea dx,nombre
    int 21h
;multiplicacion 
    mov ah,09h
    lea dx,mensaje1   ;mensaje de solicitud del primer numero
    int 21h
    
    mov ah,01h      ;lee los caracteres del teclado
    int 21h
    
    ;Conversion del numero.
    
    sub al,30h       ;hace la conversion ascii
    mov num1,al        ; se pasaa la variable n1
    int 21h
    
    mov ah,09h       ;impresion de caracteres
    lea dx, salto    ;saltar de fila
    int 21h
    
    mov ah,09h
    lea dx, mensaje2   ;mensaje del segundo numero
    int 21h
    
    mov ah,01h         ;leer y mostrar numero digitado
    int 21h
    
    sub al,30h          ;conversion ASCII
    mov num2,al           ;se pasa ala variable n2
    int 21h
    
    ;Operacion de sumas sucesivas
    
    mov cl,num2
    
    sumar:
    
    mov al,num1          ;movemos el registro al a el valor del numero 1
    add al,suma        ;sumamos a al el valor de la suma
    mov suma,al        ;movemos a suma el valor del resultado
    loop sumar
    
    mov ah, 09h         ;impresion de caracteres
    lea dx, mensaje3    ;impresion del mensaje 3
    int 21h
    
    mov al,suma
    aam                 ;corrige el resultado de la multiplicacion de datos ASCII en el registro ax
    mov bytel,al
    mov byteh,ah
    
    mov ah,02h
    
    mov dl,byteh
    add dl,30h
    int 21h
    
    mov dl,bytel
    add dl,30h
    int 21h 
    
    mov ah,09h            ;ipresion de caracteres
    lea dx,salto          ;salto de fila
    int 21h
    
    salir:                 ;retorna el mando al DOS
    
    mov ax, 4c00h
    int 21h

inicio endp

end inicio