display macro p1
    lea dx,p1
    mov ah,9
    int 21h
endm 

new_line macro 
    
    mov dl,10
    mov ah,2
    int 21h
    mov dl,13
    mov ah,2
    int 21h
endm

char macro p2
    mov dl,p2
    mov ah,2
    int 21h
endm

user_input macro
    
    mov ah,7
    int 21h
    mov dl,al
endm

terminate macro
    mov ah,4ch
    int 21h
endm

menup macro p1,p2,p3,p4,p5,p6,p7,p8,p9,p10
    display p1 
    new_line
    display p2
    new_line   
    display p3
    new_line
    display p4
    new_line
    display p5
    new_line
    display p6
    new_line    
    display p7
    new_line
    display p8
    new_line
    display p9
    new_line 
    new_line
    display p10 
    new_line
endm   

receiptp macro p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11
    display p1 
    new_line
    display p2
    new_line   
    display p3
    new_line
    display p4
    new_line
    display p5
    new_line
    display p6
    new_line    
    display p7
    new_line
    display p8
    new_line
    display p9
    new_line 
    new_line
    display p10 
    new_line 
    display p11 
    new_line
endm
 
.model small
.stack 100h
.data 

menup1 db "            #######  ##   ##          **  ####### $"
menup2 db "            ##***##  ##   ##         **   ####### $"
menup3 db "            ##   ##  ##   ##        **         ## $"
menup4 db "                 #*  ##   ##       **          ## $"
menup5 db "               *#*   ##***##      **           ## $"
menup6 db "             #*#      ######     **            ## $"
menup7 db "            #*#           ##    **             ## $" 
menup8 db "            #***###       ##   **              ## $"  
menup9 db "            #######       ##  **               ## $"  
menup10 db '                Welcome to 24/7 Clothing Store$'      

project_name db "Shopping management system$" 
wronginput db "Wrong input$"
kids db "Kids$"
mans db "Men$"
womans db "Women$"
summers db "Summer clothing$"
winters db "Winter clothing$"

;KID ITEMS 
   
Winterkid1 db "Kids Winter Jacket$"
Winterkid2 db "Kids Winter Trouser$" 
Winterkid3 db "Kids Winter Socks$"
summerkid1 db "Kids Summer Tee shirt$"
summerkid2 db "Kids Summer Shorts$"
summerkid3 db "Kids Summer Pants$"

;MEN ITEMS

Wintermen1 db "Men Winter Jacket$"
Wintermen2 db "Men Winter Trouser$" 
Wintermen3 db "Men Winter Socks$"
summermen1 db "Men Summer Tee shirt$"
summermen2 db "Men Summer Shorts$"
summermen3 db "Men Summer Pants$"

;WOMEN ITEMS

Winterwomen1 db "Women Winter Jacket$"
Winterwomen2 db "Women Winter Trouser$" 
Winterwomen3 db "Women Winter Socks$"
summerwomen1 db "Women Summer Tee shirt$"
summerwomen2 db "Women Summer Shorts$"
summerwomen3 db "Women Summer Pants$" 

price1 db " - 50 USD$"
price2 db " - 20 USD$"
price3 db " - 5 USD$"
price4 db " - 10 USD$"
price5 db " - 10 USD$"
price6 db " - 15 USD$"

jacketprice dw 50d
trouserprice dw 20d
socksprice dw 5d
teeshirtprice dw 10d
shortsprice dw 10d
pantsprice dw 15d
totalprice dw 0   

totwomenjacket db 0 
totwomentrouser db 0
totwomensock db 0
totl_shoes db 0  ;VARIABLES NOT IN USE CURRENTLY
tottshirt db 0 
totshort db 0
totpant db 0
totslippers  db 0
totalamount db 0 

kidwin db 0
kidsum db 0
womenwin db 0    ;VARIABLES TO KEEP TRACK WHICH CATEGORY WAS ACCESSED FOR 
womensum db 0    ;CALCULATIONS(TO SERVE AS A COUNTER)
menwin db 0      ;FOR EG: WOMENS WINTER ITEMS
mensum db 0  

ikidjacket db 48      ;0
ikidtrouser db 48
ikidsock db 48  
ikidtshirt db 48 
ikidshort db 48
ikidpant db 48      

imenjacket db 48 
imentrouser db 48
imensock db 48    ;ALL VARIABLES BEGINNING WITH i KEEPS RECORD OF TOTAL                    
imentshirt db 48  ;ITEMS OF INDIVIDUAL CATEGORY BOUGHT
imenshort db 48
imenpant db 48

iwomenjacket db 48 
iwomentrouser db 48
iwomensock db 48  
iwomentshirt db 48 
iwomenshort db 48
iwomenpant db 48

var1 db ?         ;TEMPORARY VALUE HOLDERS
var2 db ?   
var4 dw ? 
var5 db "do you want to run again press y otherwise press any key to terminate program&"
key1 db " 1) $"
key2 db " 2) $"    ;KEYS WHICH WILL BE DISPLAYED THROUGHOUT CODE
key3 db " 3) $"    ;TO LABEL ITEMS ETC 
key4 db " 4) $" 

enterkey db "Enter key to add item: $" 
printreceipt db "Print receipt$"

itemupdate db "Item added to cart!"   

spaceart db "       $" 
space db " $" 

receipt1 db '        =========================================================$'
receipt2 db '        =                                                       =$'
receipt3 db '        =          #### ### #### #### ##### #### #####          =$'
receipt4 db '        =          #  # #   #    #      #   #  #   #            =$'
receipt5 db '        =          ###  ##  #    ###    #   ###    #            =$'
receipt6 db '        =          # #  #   #    #      #   #      #            =$'
receipt7 db '        =          #  # ### #### #### ##### #      #            =$'
receipt8 db '        =                                                       =$'
receipt9 db '        =========================================================$' 
receipt10 db '                                            $'
receipt11 db '           Article           Number   Price    Sum    $'
receipt12 db '       =========================================================$'
receipt13 db '                               Total : $'
receipt14 db '       =========================================================$' 
menu2 db "***MENU***$"


.code
main proc 
    mov ax,@data
    mov ds,ax
                
    call menu1
           
    main endp  

;update procedure handles the count of items purchased  

print proc              
    ;initialize count    price store in ax
    mov cx,0
    mov dx,0
    label1:
        ; if ax is zero
        cmp ax,0
        je print1     
         
        ;initialize bx to 10
        mov bx,10       
         
        ; extract the last digit
        div bx                 
         
        ;push it in the stack divide  10/10  quotient ax=0, dx=1
        push dx             
         
        ;increment the count
        inc cx             
         
        ;set dx to 0
        xor dx,dx
        jmp label1
        
        
    print1:
        ;check if count
        ;is greater than zero
        cmp cx,0
        je exit
                
        
;        je j1: 
;        mov dl,13
;        mov ah,2
;        int 21h  
        j1:
        ;pop the top of stack
        pop dx
         
        ;add 48 so that it
        ;represents the ASCII
        ;value of digits
        add dx,48
         
        ;interrupt to print a
        ;character
        
        mov ah,02h
        int 21h
         
        ;decrease the count
        dec cx
        jmp print1
                
        
exit:
ret
print endp
     
update proc  
    mov dl,var1   
    
    cmp dl,kidsum
    je kidsumcmp
    cmp dl,kidwin
    je kidwincmp
      
    cmp dl,mensum
    je mensumcmp    ;compares the values to know which category was accessed 
    cmp dl,menwin   ;then jumps to the desired one (summer/winter)
    je menwincmp
      
    cmp dl,womensum
    je womensumcmp
    cmp dl,womenwin
    je womenwincmp  
        
     
;all the cmp labels then compares which item was bought then jumps to the
;desired label to increment the count of item which was bought
    
kidsumcmp:
    mov dl,var2
    
    cmp dl,"1"
    je kshirt
    cmp dl,"2"
    je kshort
    cmp dl,"3"
    je kpant  
    
    new_line
    display wronginput
    new_line
    jmp call menu1
        

kidwincmp: 
    mov dl,var2
    
    cmp dl,"1"
    je kjacket
    cmp dl,"2"
    je ktrouser
    cmp dl,"3"
    je ksock   
    
    new_line
    display wronginput
    new_line
    jmp call menu1
    
mensumcmp:
    mov dl,var2
    
    cmp dl,"1"
    je mshirt
    cmp dl,"2"
    je mshort
    cmp dl,"3"
    je mpant   
    
    new_line
    display wronginput
    new_line
    jmp call menu1
    
menwincmp: 
    mov dl,var2
    
    cmp dl,"1"
    je mjacket
    cmp dl,"2"
    je mtrouser
    cmp dl,"3"
    je msock           
    
    new_line
    display wronginput
    new_line
    jmp call menu1

womensumcmp:
    mov dl,var2
    
    cmp dl,"1"
    je wshirt
    cmp dl,"2"
    je wshort
    cmp dl,"3"
    je wpant      
    
    new_line
    display wronginput
    new_line
    jmp call menu1
     

womenwincmp: 
    mov dl,var2
    
    cmp dl,"1"
    je wjacket
    cmp dl,"2"
    je wtrouser
    cmp dl,"3"
    je wsock           
    
    new_line
    display wronginput
    new_line
    jmp call menu1
    
;all below labels increment the count of items if any of them is purchased    
    
kjacket:
    new_line 
    display itemupdate
    new_line  
    inc ikidjacket
    mov bx,jacketprice
    add totalprice,bx
    ;add totalprice,jacketprice
    call menu1

ktrouser:
    new_line 
    display itemupdate
    new_line 
    inc ikidtrouser
    mov bx,trouserprice
    add totalprice,bx
    ;add totalprice,trouserprice
    call menu1

ksock: 
    new_line 
    display itemupdate
    new_line 
    inc ikidsock
    mov bx,socksprice
    add totalprice,bx
    ;add totalprice,socksprice 
    call menu1

kshirt:           
    new_line 
    display itemupdate
    new_line 
    inc ikidtshirt
    mov bx,teeshirtprice
    add totalprice,bx
    ;add totalprice,teeshirtprice
    call menu1  

kshort:           
    new_line 
    display itemupdate
    new_line 
    inc ikidshort
    mov bx,shortsprice
    add totalprice,bx
    ;add totalprice,shortsprice
    call menu1

kpant:            
    new_line 
    display itemupdate
    new_line 
    inc ikidpant
    mov bx,pantsprice
    add totalprice,bx
    ;add totalprice,pantsprices
    call menu1

mjacket:          
    new_line 
    display itemupdate
    new_line 
    inc imenjacket
    mov bx,jacketprice
    add totalprice,bx
    ;add totalprice,jacketprice
    call menu1

mtrouser:         
    new_line 
    display itemupdate
    new_line 
    inc imentrouser
    mov bx,trouserprice
    add totalprice,bx
    ;add totalprice,trouserprice
    call menu1

msock:            
    new_line 
    display itemupdate
    new_line 
    inc imensock
    mov bx,socksprice
    add totalprice,bx
    ;add totalprice,socksprice 
    call menu1

mshirt:           
    new_line 
    display itemupdate
    new_line 
    inc imentshirt
    mov bx,teeshirtprice
    add totalprice,bx
    ;add totalprice,teeshirtprice
    call menu1  

mshort:           
    new_line 
    display itemupdate
    new_line 
    inc imenshort
    mov bx,shortsprice
    add totalprice,bx
    ;add totalprice,shortsprice
    call menu1

mpant:            
    new_line 
    display itemupdate
    new_line 
    inc imenpant
    mov bx,pantsprice
    add totalprice,bx
    ;add totalprice,pantsprices
    call menu1    
                                    
wjacket:          
    new_line 
    display itemupdate
    new_line 
    inc iwomenjacket
    mov bx,jacketprice
    add totalprice,bx
    ;add totalprice,jacketprice
    call menu1

wtrouser:         
    new_line 
    display itemupdate
    new_line 
    inc iwomentrouser
    mov bx,trouserprice
    add totalprice,bx
    ;add totalprice,trouserprice
    call menu1

wsock:            
    new_line 
    display itemupdate
    new_line 
    inc iwomensock
    mov bx,socksprice
    add totalprice,bx
    ;add totalprice,socksprice 
    call menu1

wshirt:           
    new_line 
    display itemupdate
    new_line 
    inc iwomentshirt
    mov bx,teeshirtprice
    add totalprice,bx
    ;add totalprice,teeshirtprice
    call menu1  

wshort:           
    new_line 
    display itemupdate
    new_line 
    inc iwomenshort
    mov bx,shortsprice
    add totalprice,bx
    ;add totalprice,shortsprice
    call menu1

wpant:            
    new_line 
    display itemupdate
    new_line 
    inc iwomenpant
    mov bx,pantsprice
    add totalprice,bx
    ;add totalprice,pantsprices
    call menu1
    
    ret
          
    update endp 
    
;receipt procedure prints receipt 
    
receipt proc
      call cls
;below lines are just for decoration to write 'RECEIPT'        

    receiptp receipt1,receipt2,receipt3,receipt4,receipt5,receipt6,receipt7,receipt8,receipt9,receipt10,receipt11

;below lines display kid items and how many purchased        
    
  
    cmp ikidjacket,48 ;48=0 
    je line396
    display spaceart          
    
    display Winterkid1 
    display spaceart
    char ikidjacket
    display spaceart
    mov ax,jacketprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,ikidjacket
    sub bl,30h
    mul bx        
    call print 
    
    ; pricee print
    new_line    

line396:
    cmp ikidtrouser,48
    je line408     
    display spaceart
    display Winterkid2 
    display spaceart
    char ikidtrouser
    display spaceart
    mov ax,trouserprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,ikidtrouser
    sub bl,30h
    mul bx        
    call print 
    
    new_line
      
line408:
    cmp ikidsock,48
    je line472       
    display spaceart
    display Winterkid3
    display spaceart
    char ikidsock 
    display spaceart
    mov ax,socksprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,ikidsock
    sub bl,30h
    mul bx        
    call print 
    
    new_line
        
line472:
    cmp ikidtshirt,48
    je line484         
    display spaceart
    display summerkid1 
    display spaceart
    char ikidtshirt
    display spaceart
    mov ax,teeshirtprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,ikidtshirt
    sub bl,30h
    mul bx        
    call print 
    
    new_line
    
line484:
    cmp ikidshort,48
    je line496   
    display spaceart
    display summerkid2
    display spaceart
    char ikidshort
    
    display spaceart
    mov ax,shortsprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,ikidshort
    sub bl,30h
    mul bx        
    call print 
    
    new_line
         
line496:
    cmp ikidpant,48
    je line510    
    display spaceart
    display summerkid3
    display spaceart
    char ikidpant   
    
    display spaceart
    mov ax,pantsprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,ikidpant
    sub bl,30h
    mul bx        
    call print 
    
    new_line 
    
;below lines display men items and how many purchased       

line510:
    cmp imenjacket,48
    je line522          
    display spaceart
    display Wintermen1 
    display spaceart
    char imenjacket     
    display spaceart
    mov ax,jacketprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,imenjacket
    sub bl,30h
    mul bx        
    call print 
    
    new_line   

line522:
    cmp imentrouser,48
    je line534      
    display spaceart
    display Wintermen2 
    display spaceart
    char imentrouser 
    display spaceart
    mov ax,trouserprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,imentrouser
    sub bl,30h
    mul bx        
    call print
    new_line          

line534:
    cmp imensock,48
    je line546    
    display spaceart
    display Wintermen3
    display spaceart
    char imensock   
    display spaceart
    mov ax,socksprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,imensock
    sub bl,30h
    mul bx        
    call print
    new_line     

line546:
    cmp imentshirt,48
    je line558        
    display spaceart
    display summermen1 
    display spaceart
    char imentshirt 
      display spaceart
    mov ax,teeshirtprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,imentshirt
    sub bl,30h
    mul bx        
    call print
    new_line         

line558:
    cmp imenshort,48
    je line570    
    display spaceart
    display summermen2
    display spaceart
    char imenshort  
      display spaceart
    mov ax,shortsprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,imenshort
    sub bl,30h
    mul bx        
    call print
    new_line       

line570:
    cmp imenpant,48
    je line584    
    display spaceart
    display summermen3
    display space
    char imenpant
      display spaceart
    mov ax,pantsprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,imenpant
    sub bl,30h
    mul bx        
    call print
    new_line  

;below lines display women items and how many purchased   

line584:
    cmp iwomenjacket,48
    je line596
    display spaceart
    display Winterwomen1 
    display spaceart
    char iwomenjacket
      display spaceart
    mov ax,jacketprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,iwomenjacket
    sub bl,30h
    mul bx        
    call print
    new_line
     
line596:
    cmp iwomentrouser,48
    je line608        
    display spaceart
    display Winterwomen2 
    display space
    char iwomentrouser   
      display spaceart
    mov ax,trouserprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,iwomentrouser
    sub bl,30h
    mul bx        
    call print
    new_line  

line608:
    cmp iwomensock,48
    je line620       
    display spaceart
    display Winterwomen3
    display spaceart   
    char iwomensock 
    display spaceart       
    mov ax,socksprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,iwomensock
    sub bl,30h
    mul bx        
    call print
    new_line
       
line620:
    cmp iwomentshirt,48
    je line632          
    display spaceart
    display summerwomen1 
    display spaceart
    char iwomentshirt
    
      display spaceart
    mov ax,teeshirtprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,iwomentshirt
    sub bl,30h
    mul bx        
    call print
    new_line     

line632:
    cmp iwomenshort,48
    je line644    
    display spaceart
    display summerwomen2
    display spaceart
    char iwomenshort
    
      display spaceart
    mov ax,shortsprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,iwomenshort
    sub bl,30h
    mul bx        
    call print
    new_line
          
line644:
    cmp iwomenpant,48
    je line655    
    display spaceart
    display summerwomen3
    display spaceart
    char iwomenpant 
    
      display spaceart
    mov ax,pantsprice   
    mov var4,ax
    call print          
    display spaceart
    xor bx,bx
    mov ax,var4
    mov bl,iwomenpant
    sub bl,30h
    mul bx        
    call print

line655: 
   
    new_line      
    display receipt12
    new_line
    display receipt13  
    mov ax,totalprice
    call print       
    new_line
    display receipt14
    terminate

    ret   
    
    
    receipt endp  
    
           
;menu function will show the menu eg "press 1 for men"  
   
menu1 proc ;first menu 1 call                   
    
;while label to run the menu on loop   
     
while_:
    mov kidwin,0
    mov kidsum,0
    mov womenwin,0
    mov womensum,0 
    mov menwin,0
    mov mensum,0  

;calling the new line macro and printing the menu options  
     
        
    new_line
    menup menup1,menup2,menup3,menup4,menup5,menup6,menup7,menup8,menup9,menup10
    new_line

    display key1
    display kids
    new_line

    display key2
    display mans
    new_line
          
    display key3
    display womans
    new_line   
    
    display key4
    display printreceipt
    new_line
                    
    
;taking a userinput and checking if the user pressed 1 it will go to the
;kid section if pressed 2 will go to the men section if pressed 3 then to
;women section if any other key is pressed it will go to wrong input label. 

    user_input  
    
    cmp dl,'1'
    je kid

    cmp dl,'2' 
    je men 

    cmp dl,'3'
    je  women 

    cmp dl,"4"
    je call receipt

 
    jmp wrong_input    
    
;display summer items for kids       
 
kidsummer:
    add kidsum,49  ;1
    mov var1,dl
    
    new_line  
    display key1 
    display summerkid1
    display price4
    new_line
       
    display key2 
    display summerkid2 
    display price5
    new_line 
       
    display key3 
    display summerkid3
    display price6
    new_line    
       
    user_input 
  
    mov var2,dl  
       
    call update 
       
    jmp loop1                     
    
;display summer items for men            

mensummer:
    add mensum,50 
    mov var1,dl
    add var1,1 
    
    new_line  
    display key1 
    display summermen1  
    display price4
    new_line  
    
    display key2 
    display summermen2
    display price5
    new_line 
       
    display key3 
    display summermen3
    display price6
    new_line    

    user_input 
       
    mov var2,dl
       
    call update
       
    jmp loop1 
       
;display summers items for women     
  
womensummer: 
    add womensum,51 
    mov var1,dl  
    add var1,2   
    
    new_line 
    display key1      
    display summerwomen1 
    display price4
    new_line     
    
    display key2  
    display summerwomen2
    display price5
    new_line     
    
    display key3  
    display summerwomen3
    display price6
    new_line

    user_input
       
    mov var2,dl
       
    call update
       
    jmp loop1      
       
;display all the winter items for kids  
     
kidwinter: 
    add kidwin,52 
    mov var1,dl  
    add var1,2 
    
    new_line
    display key1 
    display winterkid1
    display price1
    new_line     
         
    display key2 
    display winterkid2 
    display price2
    new_line      
    
    display key3 
    display winterkid3
    display price3
    new_line    
       
    user_input 
       
    mov var2,dl 
       
    call update
 
    jmp loop1      
       
;display all the winter items for men 
      
menwinter:
    add menwin,53 
    mov var1,dl 
    add var1,3 
 
    new_line         
    display key1 
    display wintermen1 
    display price1
    new_line   
    
    display key2 
    display wintermen2 
    display price2
    new_line    
    
    display key3 
    display wintermen3   
    display price3
    new_line    
       
    user_input   
       
    mov var2,dl 
       
    call update
       
    jmp loop1
        
;display all the winter items for women   
   
womenwinter: 
    add womenwin,54  
    mov var1,dl  
    add var1,4  
    
    new_line
    display key1 
    display winterwomen1 
    display price1
    new_line     
    
    display key2 
    display winterwomen2 
    display price2
    new_line 
       
    display key3 
    display winterwomen3 
    display price3
    new_line    
       
    user_input
      
    mov var2,dl
      
    call update
       
    jmp loop1

 
;kid label it will display whether you want to select 
;summer clothing or winter clothing            

kid:  
    new_line  
    display key1  
    display summers
    new_line
        
    display key2
    display winters     
    new_line    
 
    user_input
      
    cmp dl,'1'
    je kidsummer
    cmp dl,'2'
    je kidwinter
      
    jmp wronginput_kid        
      
;men label it will display whether you want to select summer 
;clothing or winter clothing  
    
men:   
    new_line 
    display key1   
    display summers
    new_line    
     
    display key2
    display winters     
    new_line   
    
    user_input  
    
    cmp dl,'1'
    je mensummer
    cmp dl,'2'
    je menwinter
                               
    jmp wronginput_men         
      
;women label it will display wether you want to select summer 
;clothing or winter clothing         

women:   
    new_line 
    display key1   
    display summers
    new_line   
       
    display key2
    display winters     
    new_line        
    
    user_input  
    
    cmp dl,'1'
    je womensummer
    cmp dl,'2'
    je womenwinter
      
    jmp wronginput_women   
         
;wrong input label if user pressed wrong input will jump to the kids label 
        
wronginput_kid: 
    new_line
    display wronginput
          
    jmp kid        
    
;wrong input label if user pressed wrong input will jump to the men label 

wronginput_men:   
    new_line
    display wronginput
        
    jmp men             
    
;wrong input label if user pressed wrong input will jump to the women label
    
wronginput_women:  
    new_line
    display wronginput
    
    jmp women                    
    
;wrong input label if user pressed wrong input will jump to 
;starting of the menu    

wrong_input:  
    new_line   
    display wronginput
    
    jmp while_                              
 
;loop label for running the menu function on loop    

loop1:
    jmp while_ 

    ret
    
    menu1 endp
    
;cls procedure just clears the screen      
        
cls proc    
    mov cx,30
    l1:
    new_line
        
    loop l1          
    ret    
    cls endp
end main