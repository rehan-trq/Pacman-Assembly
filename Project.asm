INCLUDE Irvine32.inc
includelib Winmm.lib

PlaySound PROTO,
pszSound:PTR BYTE, 
hmod:DWORD, 
fdwSound:DWORD

.data

deviceConnect BYTE "DeviceConnect",0

SND_ALIAS    DWORD 00010000h
SND_RESOURCE DWORD 00040005h
SND_FILENAME DWORD 00020000h

file BYTE "C:\Users\HP\Downloads\Pac-Man-Theme-Song.wav",0

 pacman byte "|  __ \ /\   / ____|  \/  |   /\   | \ | |",0
pacman1 byte "| |__) /  \ | |    | \  / |  /  \  |  \| |",0
pacman2 byte "|  ___/ /\ \| |    | |\/| | / /\ \ | . ` |",0
pacman3 byte "| |  / ____ | |____| |  | |/ ____ \| |\  |",0
pacman4 byte "|_| /_/    \_\_____|_|  |_/_/    \_|_| \_|",0

levelc BYTE     "_        _______           _______  _          _______  _        _______  _______  _______  _______  ______",0  
levelc1 BYTE    "( \      (  ____ \|\     /|(  ____ \( \        (  ____ \( \      (  ____ \(  ___  )(  ____ )(  ____ \(  __  \",0 
levelc2 BYTE    "| (      | (    \/| )   ( || (    \/| (        | (    \/| (      | (    \/| (   ) || (    )|| (    \/| (  \  )",0
levelc3 BYTE    "| |      | (__    | |   | || (__    | |        | |      | |      | (__    | (___) || (____)|| (__    | |   ) |",0
levelc4 BYTE    "| |      |  __)   ( (   ) )|  __)   | |        | |      | |      |  __)   |  ___  ||     __)|  __)   | |   | |",0
levelc5 BYTE    "| |      | (       \ \_/ / | (      | |        | |      | |      | (      | (   ) || (\ (   | (      | |   ) |",0
levelc6 BYTE    "| (____/\| (____/\  \   /  | (____/\| (____/\  | (____/\| (____/\| (____/\| )   ( || ) \ \__| (____/\| (__/  )",0
levelc7 BYTE    "(_______/(_______/   \_/   (_______/(_______/  (_______/(_______/(_______/|/     \||/   \__/(_______/(______/",0 
                                                                                                                         

  gameover byte  " ______                        ____",0                 
  gameover1 byte "/ ________ _____ ___  ___     / __ \_   _____  _____",0
 gameover2 byte "/ / __/ __ `/ __ `__ \/ _ \   / / / | | / / _ \/ ___/",0
gameover3 byte "/ /_/ / /_/ / / / / / /  __/  / /_/ /| |/ /  __/ /",0    
gameover4 byte "\____/\__,_/_/ /_/ /_/\___/   \____/ |___/\___/_/",0    
gameover5 byte "Press to X to exit. ",0 

win BYTE   "|  \    /  \ /      \ |  \  |  \      |  \  _  |  \|      \|  \  |  \",0
win1 Byte   "\$$\  /  $$|  $$$$$$\| $$  | $$      | $$ / \ | $$ \$$$$$$| $$\ | $$",0
win2 BYTE    "\$$\/  $$ | $$  | $$| $$  | $$      | $$/  $\| $$  | $$  | $$$\| $$",0
win3 BYTE     "\$$  $$  | $$  | $$| $$  | $$      | $$  $$$\ $$  | $$  | $$$$\ $$",0
win4 BYTE      "\$$$$   | $$  | $$| $$  | $$      | $$ $$\$$\$$  | $$  | $$\$$ $$",0
win5 BYTE      "| $$    | $$__/ $$| $$__/ $$      | $$$$  \$$$$ _| $$_ | $$ \$$$$",0
win6 BYTE      "| $$     \$$    $$ \$$    $$      | $$$    \$$$|   $$ \| $$  \$$$",0
win7 BYTE       "\$$      \$$$$$$   \$$$$$$        \$$      \$$ \$$$$$$ \$$   \$$",0
win8 db 0

score1 BYTE "Your Score is ",0
 
name1 BYTE "Enter your Name to Start: ",0
nm1 BYTE "Username: ",0
inputname db 100 dup (?)

start BYTE "Start Game (Press 1) ",0
instructions BYTE "Instructions (Press 2)",0
exit1 BYTE "Exit Game (Press 3)",0
instruction1 BYTE "Instruction: ",0
instruction BYTE "Navigate Pac-Man through the maze, eating all the dots ('.') to advance to the next level.",0ah,0
instruct1 BYTE "1. Use W,S,A,D to move up, down, left and right respectively.",0ah,0
instruct2 BYTE "2. Gain points by eating dots (.). Extra Points for completing levels. ",0ah,0
instruct3 BYTE "3. Don't get close to the ghosts, they are looking for you.",0ah,0
instruct4 BYTE "4.  Press X to quit the Game ",0ah,0
instructionexit BYTE "Press R to exit the Instructions.",0ah, 0
menu1 BYTE "Main Menu (Press 3)",0
resume BYTE "Resume (Press 1)",0
restart BYTE "Restart (Press 2)",0
quit BytE "Quit Game (Press 3)",0

coins BYTE 20
coinsarrx BYTE 20 dup(?)
coinsarry BYTE 20 dup(?)


wall1 BYTE 0dbh,0ah, 0
wallx byte ?
wally byte ?
wall2 BYTE "----------",0ah,0
wallarrx db 40 dup (?)
wallarrx1 db 20 dup (?)
ground BYTE "------------------------------------------------------------------------------------------------------------------------",0
ground1 BYTE 0dbh,0ah,0
ground2 BYTE 0dbh,0

temp byte ?

strScore BYTE "Your score is: ",0
score BYTE 0

xPos BYTE 40
yPos BYTE 28

xCoinPos BYTE ?
yCoinPos BYTE ?

inputChar BYTE ?

lives BYTE "Lives: ",0
live db 3

ghostx db 70
ghosty db 16

ghostx1 db 40
ghosty1 db 8

ghostx2 db 20
ghosty2 db 21

level2flag db 0
fruit db "@",0
fruitx db -1
fruity db -1

teleportx db ?
teleporty db ?

.code
main PROC
     INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
     INVOKE PlaySound, OFFSET file, NULL, 1
    ; Name of Game
    mov eax,blue ;(blue * 16)
    call SetTextColor
    mov dl, 35
    mov dh, 10
    call Gotoxy
    mov edx, offset pacman
    call writestring
    mov eax, 200
    call Delay
    mov dl, 35
    mov dh, 11
    call Gotoxy
    mov edx, offset pacman1
    call writestring
    mov eax, 200
    call Delay
    mov dl, 35
    mov dh, 12
    call Gotoxy
    mov edx, offset pacman2
    call writestring
    mov eax, 200
    call Delay
    mov dl, 35
    mov dh, 13
    call Gotoxy
    mov edx, offset pacman3
    call writestring
    mov eax, 200
    call Delay
    mov dl, 35
    mov dh, 14
    call Gotoxy
    mov edx, offset pacman4
    call writestring
    mov eax, 1000
    call Delay
    call clrscr
    
    ;Name as input
    mov eax, white
    call SetTextColor
    mov dl,0
    mov dh,0
    call Gotoxy
    mov edx,OFFSET name1
    call WriteString

    mov edx, offset inputname
    mov ecx, lengthof inputname
    call ReadString

    ;Menu of the Game

    menu:
    call clrscr
    mov eax, blue
    call settextcolor
    mov dl, 35
    mov dh, 2
    call Gotoxy
    mov edx, offset pacman
    call writestring
    mov dl, 35
    mov dh, 3
    call Gotoxy
    mov edx, offset pacman1
    call writestring
    mov dl, 35
    mov dh, 4
    call Gotoxy
    mov edx, offset pacman2
    call writestring
    mov dl, 35
    mov dh, 5
    call Gotoxy
    mov edx, offset pacman3
    call writestring
    mov dl, 35
    mov dh, 6
    call Gotoxy
    mov edx, offset pacman4
    call writestring
    mov eax, 100
    call Delay
    mov eax, white
    call settextcolor
    mov dl, 35
    mov dh, 12
    call Gotoxy
    mov edx, offset start
    call writestring
    mov eax, 100
    call Delay
    mov dl, 35
    mov dh, 14
    call Gotoxy
    mov edx, offset instructions
    call writestring
    mov eax, 100
    call Delay
    mov dl, 35
    mov dh, 16
    call Gotoxy
    mov edx, offset exit1
    call writestring
    call Readchar
    
   call clrscr

    cmp al, "1"
    je startgame

    cmp al, "2"
    je instruct
    
    cmp al, "3"
    je exitGame
    
    instruct:
    mov dl, 0
    mov dh, 1
    call Gotoxy
    mov edx, offset instruction1
    call Writestring
    mov dl,0
    mov dh, 4
    call Gotoxy
    mov edx, offset instruction
    call writestring
    mov dl, 0
    mov dh, 6
    call Gotoxy
    mov edx, offset instruct1
    call writestring
    mov dl, 0
    mov dh, 8
    call Gotoxy
    mov edx, offset instruct2
    call writestring
    mov dl, 0
    mov dh, 10
    call Gotoxy
    mov edx, offset instruct3
    call writestring
    call Gotoxy
    mov dl, 0
    mov dh, 14
    call Gotoxy
    mov edx, offset instruct4
    call writestring
    mov dl, 6
    mov dh, 18
    call Gotoxy
    mov edx, offset instructionexit
    call writestring
    call ReadChar
    cmp al, "r"
    je menu
    cmp al,"R"
    je menu
    
    ; draw ground at (0,29):

    startgame:
    call clrscr
    
    mov al, 3
    mov live, al
    mov score, 0

    mov ghostx, 70
    mov ghosty, 16
    call Gotoxy

    call Drawboundaries
    call Drawghost
    mov xpos, 40
    mov ypos, 28
    call DrawPlayer

    mov esi, offset coinsarrx
    mov edi, offset coinsarry
    mov ecx, 20
    
    call Randomize
    looop:

        call createrandomcoin
        call drawcoin

        inc esi
        inc edi

    loop looop
    call Drawmaze

    gameLoop:
        call checkforlevel2
        comment @
        mov bl, level2flag
        cmp bl, 1
        @
        cmp score, 16
        jae level2
        

        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        mov ecx, 20
        mov bl, xpos
        mov dl, ypos

        loop1:
            cmp bl, [esi]
            jne notequal

            cmp dl, [edi]
            je equal
             notequal:
                inc esi
                inc edi

        loop loop1

        equal:
            cmp byte ptr [esi], 0
            je notequal1

            add score, 1
            mov byte ptr [esi], 0
            
        notequal1:
        mov eax, white 
        call settextcolor

        ;Name of the player
        mov dl, 3
        mov dh, 0
        call Gotoxy

        mov edx, offset inputname
        call writestring
        
        ; draw score:
        mov dl,50
        mov dh,0
        call Gotoxy
        mov edx,offset strScore
        call WriteString
        mov al,score
        sub al, 1
        call WriteInt


        ;Lives

        mov bl,xpos
        mov dl,ypos

        mov al,ghostx
        mov cl,ghosty

        cmp bl, al
        jne skipp

        cmp dl, cl
        jne skipp

        dec live

        cmp live, 0
        je exitgame

        call UpdatePlayer
        mov xpos, 40
        mov ypos, 28
        call DrawPlayer
        call GhostUpdate
        mov ghosty, 16
        mov ghostx, 70
        call Drawghost

        skipp:

        mov dl, 108
        mov dh, 0
        call gotoxy

        mov edx, offset lives
        call writestring

        mov al, live
        call writeint

        ;Ghost collision with coins

        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        
        mov bl, ghostx
        mov dl, ghosty

        mov ecx, 20
        loooopp1:
            cmp bl, [esi]
            jne neqq
            cmp dl, [edi]
            je eqqq

            neqq:
                inc esi
                inc edi
        loop loooopp1
        jmp neqq1
        eqqq:
            jmp movem 

        neqq1:
        call GhostUpdate
        call ghostmovement
        call Drawghost
        jmp rk
        movem:
        call ghostmovement
        call Drawghost
        call drawcoin

        rk:
        ; get user key input:

        mov eax, 100
        call Delay

        call Readkey
        mov inputChar,al

        cmp al, 1
        je gameloop

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame
        cmp inputChar, "X"
        je exitGame

        cmp inputChar,"w"
        je moveUp
        cmp inputChar, "W"
        je moveUp

        cmp inputChar,"s"
        je moveDown
        cmp inputChar, "S"
        je moveDown

        cmp inputChar,"a"
        je moveLeft
        cmp inputChar, "A"
        je moveLeft

        cmp inputChar,"d"
        je moveRight
        cmp inputChar, "D"
        je moveRight

        cmp inputChar, "P"
        je pause1
        cmp inputChar, "p"
        je pause1
        jmp pause1

    moveUp:
        cmp ypos, 4
        jz continue1
        jnz cont
        continue1:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop:
                mov al, [esi]
                cmp xpos, al
                je gameloop
                inc esi
            loop checkloop

         cont:
            cmp ypos, 11            
            jz continue2
            jnz cont1

            continue2:
                mov edi, offset wallarrx1
                mov ecx, 50
                checkloop1:
                    mov al, [edi]
                    cmp xpos, al
                    je gameloop
                    inc edi
                loop checkloop1
            
            cont1:
                cmp ypos, 18
                jz continue3
                jnz cont2

             continue3:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop2:
                    mov al, [esi]
                    cmp xpos, al
                    je gameloop
                    inc esi
                loop checkloop2

            cont2:
                cmp ypos, 25
                jz continue4
                jnz continue

            continue4:
                mov edi, offset wallarrx1
                mov ecx, 50
                checkloop3:
                    mov al, [edi]
                    cmp xpos, al
                    je gameloop
                    inc edi
                loop checkloop3
        
        continue:
            cmp yPos, 2 
            jle gameLoop
            ;mov ecx,1
            ;jumpLoop:
                call UpdatePlayer
                dec yPos
                call DrawPlayer
                ;call GhostUpdate
                ;inc ghosty
                ;call Drawghost
        
            ;loop jumpLoop
            jmp gameLoop

    moveDown:
        cmp ypos, 2
        jz continuee1
        jnz contt
        continuee1:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloopp:
                mov al, [esi]
                cmp xpos, al
                je gameloop
                inc esi
            loop checkloopp

         contt:
            cmp ypos, 9        
            jz continuee2
            jnz contt1

            continuee2:
                mov edi, offset wallarrx1
                mov ecx, 50
                checkloopp1:
                    mov al, [edi]
                    cmp xpos, al
                    je gameloop
                    inc edi
                loop checkloopp1
            
            contt1:
                cmp ypos, 16
                jz continuee3
                jnz contt2

             continuee3:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloopp2:
                    mov al, [esi]
                    cmp xpos, al
                    je gameloop
                    inc esi
                loop checkloopp2

            contt2:
                cmp ypos, 23
                jz continuee4
                jnz continuee

            continuee4:
                mov edi, offset wallarrx1
                mov ecx, 50
                checkloopp3:
                    mov al, [edi]
                    cmp xpos, al
                    je gameloop
                    inc edi
                loop checkloopp3

    continuee:
        cmp yPos, 28
        jge gameLoop
       ; cmp ghosty, 27
       ; jge gameloop
        call UpdatePlayer
        inc yPos
        call DrawPlayer
       ; call GhostUpdate
       ; dec ghosty
       ; call Drawghost
        jmp gameLoop

    moveLeft:
        cmp ypos, 3
        jz continueee1
        jnz conttt
        continueee1:
            mov esi, offset wallarrx
            mov ecx, 40
            checklooopp:
                mov al, [esi]
                add al, 1
                cmp xpos, al
                je gameloop
                inc esi
            loop checklooopp

         conttt:
            cmp ypos, 10           
            jz continueee2
            jnz conttt1

            continueee2:
                mov edi, offset wallarrx1
                mov ecx, 50
                checklooopp1:
                    mov al, [edi]
                    add al, 1
                    cmp xpos, al
                    je gameloop
                    inc edi
                loop checklooopp1
            
            conttt1:
                cmp ypos, 17
                jz continueee3
                jnz conttt2

             continueee3:
                mov esi, offset wallarrx
                mov ecx, 40
                checklooopp2:
                    mov al, [esi]
                    add al, 1
                    cmp xpos, al
                    je gameloop
                    inc esi
                loop checklooopp2

            conttt2:
                cmp ypos, 24
                jz continueee4
                jnz continueee

            continueee4:
                mov edi, offset wallarrx1
                mov ecx, 50
                checklooopp3:
                    mov al, [edi]
                    add al, 1
                    cmp xpos, al
                    je gameloop
                    inc edi
                loop checklooopp3


    continueee:
        cmp xPos, 2
        jle gameLoop
       ; cmp ghostx, 1
       ; jle gameloop
        call UpdatePlayer
        dec xPos
        call DrawPlayer
      ;  call GhostUpdate
      ;  inc ghostx
      ;  call Drawghost
        jmp gameLoop

    moveRight:
        cmp ypos, 3
        jz continueeee1
        jnz contttt
        continueeee1:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloooppp:
                mov al, [esi]
                sub al, 1
                cmp xpos, al
                je gameloop
                inc esi
            loop checkloooppp

        contttt:
            cmp ypos, 10           
            jz continueeee2
            jnz contttt1

            continueeee2:
                mov edi, offset wallarrx1
                mov ecx, 50
                checkloooppp1:
                    mov al, [edi]
                    sub al, 1
                    cmp xpos, al
                    je gameloop
                    inc edi
                loop checkloooppp1
            
            contttt1:
                cmp ypos, 17
                jz continueeee3
                jnz contttt2

             continueeee3:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloooppp2:
                    mov al, [esi]
                    sub al, 1
                    cmp xpos, al
                    je gameloop
                    inc esi
                loop checkloooppp2

            contttt2:
                cmp ypos, 24
                jz continueeee4
                jnz continueeee

            continueeee4:
                mov edi, offset wallarrx1
                mov ecx, 50
                checkloooppp3:
                    mov al, [edi]
                    sub al, 1
                    cmp xpos, al
                    je gameloop
                    inc edi
                loop checkloooppp3


    continueeee:
        cmp xPos, 117
        jge gameLoop
       ; mov ghostx, 118
       ; jge gameloop
        call UpdatePlayer
        inc xPos
        call DrawPlayer
      ;  call GhostUpdate
       ; dec ghostx
        ;call Drawghost
        jmp gameLoop

    pause1:
        call clrscr
        mov eax,blue ;(blue * 16)
        call SetTextColor
        mov dl, 35
        mov dh, 2
        call Gotoxy
        mov edx, offset pacman
        call writestring
        mov dl, 35
        mov dh, 3
        call Gotoxy
        mov edx, offset pacman1
        call writestring
        mov dl, 35
        mov dh, 4
        call Gotoxy
        mov edx, offset pacman2
        call writestring
        mov dl, 35
        mov dh, 5
        call Gotoxy
        mov edx, offset pacman3
        call writestring
        mov dl, 35
        mov dh, 6
        call Gotoxy
        mov edx, offset pacman4
        call writestring

        mov eax, white
        call settextcolor
        mov eax, 100
        call Delay
        mov dl, 45
        mov dh, 10
        call Gotoxy

        mov edx, offset resume
        call writestring
        mov eax, 100
        call Delay
        mov dl, 45
        mov dh, 13
        call Gotoxy

        mov edx, offset restart
        call writestring
        mov eax, 100
        call Delay
        mov dl, 45
        mov dh, 16
        call Gotoxy
        mov edx, offset quit
        call writestring

        call readchar

        cmp al, "1"
        je unpause

        cmp al, "2"
        je startgame

        cmp al, "3"
        je exitgame

    unpause:
        call clrscr
        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        mov ecx, 20
        loop2:
            call Drawcoin
            inc esi
            inc edi
        loop loop2

        call Drawmaze
        call Drawboundaries
        call Drawplayer
        call Drawghost
        jmp gameloop
    
    ;skipmovement:  
    

    jmp gameloop
   
   level2:
        call levelcleared

        call clrscr
        mov esi, offset coinsarrx
        mov edi, offset coinsarry        
        mov ecx, 20        
        call Randomize
        l1:            
            call CreateRandomCoin
            call Drawcoin
            inc esi
            inc edi
        loop l1

        call drawboundaries
        call drawmaze2
        mov al, 40
        mov xpos, al
        mov al, 28
        mov ypos, al
        mov al, 70
        mov ghostx, al
        mov al, 16
        mov ghosty, al
        call Drawghost
        call DrawPlayer

        gameLoop1:

        cmp score, 50
        jae level3

        comment @
        cmp win8, 1
        je ex
        @

        cmp score, 31

        jne nofruit1      

        call drawfruit

        
        nofruit1:
        mov al, fruitx
        mov bl, fruity        
       
        cmp xpos, al
        jne nobonus
        cmp ypos, bl
        jne nobonus

        add score, 10
        mov fruitx, -1
        mov fruity, -1

        nobonus:

        cmp score, 51

        jne nofruitt1      

        call drawfruit
        nofruitt1:
        mov al, fruitx
        mov bl, fruity
       
        cmp xpos, al
        jne nobonuss
        cmp ypos, bl
        jne nobonuss

        add score, 10
        mov fruitx, -1
        mov fruity, -1

        nobonuss:

        cmp score, 71

        jne nofruittt1      

        call drawfruit

        nofruittt1:

        mov al, fruitx
        mov bl, fruity
       
        cmp xpos, al
        jne nobonusss
        cmp ypos, bl
        jne nobonusss

        add score, 10
        mov fruitx, -1
        mov fruity, -1

        nobonusss:
        
        comment !
        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        
        mov bl, ghostx
        mov dl, ghosty

        mov ecx, 20
        looopp1:
            cmp bl, [esi]
            jne neq
            cmp dl, [edi]
            je eqq

            neq:
                inc esi
                inc edi
        loop looopp1
        jmp neq1
        eqq:
            mov dl, [esi]
            mov dh, [edi]
            call Gotoxy
            mov al, "."
            call writechar
        
        neq1:
       !
        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        mov ecx, 20
        mov bl, xpos
        mov dl, ypos

        looop1:
            cmp bl, [esi]
            jne notequall

            cmp dl, [edi]
            je equall

            notequall:
                inc esi
                inc edi

        loop looop1

        equall:
            cmp byte ptr [esi], -1
            je notequall1

            add score, 3
            mov byte ptr [esi], -1
            
        notequall1:
        mov eax, white 
        call settextcolor

        ;Name of the player
        mov dl, 3
        mov dh, 0
        call Gotoxy

        mov edx, offset inputname
        call writestring
        
        ; draw score:
        mov dl,50
        mov dh,0
        call Gotoxy
        mov edx,offset strScore
        call WriteString
        mov al,score
        sub al, 3
        call WriteInt


        ;Lives

        mov bl,xpos
        mov dl,ypos

        mov al,ghostx
        mov cl,ghosty

        cmp bl, al
        jne skippp

        cmp dl, cl
        jne skippp

        dec live

        cmp live, 0
        je exitgame

        call UpdatePlayer
        mov xpos, 40
        mov ypos, 28
        call DrawPlayer
        call GhostUpdate
        mov ghosty, 16
        mov ghostx, 70
        call Drawghost

        skippp:

        mov dl, 108
        mov dh, 0
        call gotoxy

        mov edx, offset lives
        call writestring

        mov al, live
        call writeint

        ;ghost collision with coins
        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        
        mov bl, ghostx
        mov dl, ghosty   
        mov ecx, 20
        loooopp11:
            cmp bl, [esi]
            jne neqqq11
            cmp dl, [edi]
            je eqqq1

            neqqq11:
                inc esi
                inc edi
        loop loooopp11
       
        jmp neqq11
        eqqq1:
            jmp movem1

        neqq11:
        call GhostUpdate
        call ghostmovement2
        call Drawghost
        jmp rk1
        movem1:
        
        call GhostUpdate
        call ghostmovement2
        call Drawghost
        call drawcoin

        rk1:

        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        
        mov bl, ghostx
        mov dl, ghosty   
        mov ecx, 20
        loooopp111:
            cmp bl, [esi]
            jne neqqq111
            cmp dl, [edi]
            je eqqq11

            neqqq111:
                inc esi
                inc edi
        loop loooopp111
       
        jmp neqq1111
        eqqq11:
            jmp movem11

        neqq1111:
        call GhostUpdate
        call ghostmovement2
        call Drawghost
        jmp rkk1
        movem11:
        
        call GhostUpdate
        call ghostmovement2
        call Drawghost
        call drawcoin

        rkk1:
        ; get user key input:

        mov al, 100
        call Delay

        call Readkey
        mov inputChar,al

        cmp al, 1
        je gameloop1

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame
        cmp inputChar, "X"
        je exitGame

        cmp inputChar,"w"
        je moveUp1
        cmp inputChar, "W"
        je moveUp1

        cmp inputChar,"s"
        je moveDown1
        cmp inputChar, "S"
        je moveDown1

        cmp inputChar,"a"
        je moveLeft1
        cmp inputChar, "A"
        je moveLeft1

        cmp inputChar,"d"
        je moveRight1
        cmp inputChar, "D"
        je moveRight1

        cmp inputChar, "P"
        je pausee1
        cmp inputChar, "p"
        je pausee1
        jmp pausee1

    moveUp1:
        cmp ypos, 5
        jz continuee211
        jnz cont211
        continuee211:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop211:
                mov al, [esi]
                cmp xpos, al
                je gameloop1
                inc esi
            loop checkloop211

         cont211:
            cmp ypos, 12            
            jz continue212
            jnz cont212

            continue212:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop212:
                    mov al, [edi]
                    cmp xpos, al
                    je gameloop1
                    inc edi
                loop checkloop212
            
            cont212:
                cmp ypos, 19
                jz continue213
                jnz cont213

             continue213:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop213:
                    mov al, [esi]
                    cmp xpos, al
                    je gameloop1
                    inc esi
                loop checkloop213

            cont213:
                cmp ypos, 26
                jz continue214
                jnz vchecky

            continue214:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop214:
                    mov al, [edi]
                    cmp xpos, al
                    je gameloop1
                    inc edi
                loop checkloop214
            
            vchecky:
                cmp xpos, 5
                jz continuee215
                jnz cont216

                continuee215:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check215:
                        mov al, [edi]
                        add al, 1
                        cmp ypos, al
                        je gameloop1
                        inc edi
                    loop check215

                cont216:
                    cmp xpos, 110
                    jz continue217
                    jnz continueee211

                    continue217:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check216:
                            mov al, [edi]
                            add al, 1
                            cmp ypos, al
                            je gameloop1
                            inc edi
                        loop check216

        continueee211:
            cmp yPos, 2 
            jle gameLoop1
             call UpdatePlayer
             dec yPos
             call DrawPlayer
         ;    call GhostUpdate
          ;   inc ghosty
           ;  call Drawghost
            jmp gameLoop1

    moveDown1:
        cmp ypos, 3
        jz continuee311
        jnz cont311
        continuee311:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop311:
                mov al, [esi]
                cmp xpos, al
                je gameloop1
                inc esi
            loop checkloop311

         cont311:
            cmp ypos, 10           
            jz continue312
            jnz cont312

            continue312:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop312:
                    mov al, [edi]
                    cmp xpos, al
                    je gameloop1
                    inc edi
                loop checkloop312
            
            cont312:
                cmp ypos, 17
                jz continue313
                jnz cont313

             continue313:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop313:
                    mov al, [esi]
                    cmp xpos, al
                    je gameloop1
                    inc esi
                loop checkloop313

            cont313:
                cmp ypos, 24
                jz continue314
                jnz vcheckyy

            continue314:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop314:
                    mov al, [edi]
                    cmp xpos, al
                    je gameloop1
                    inc edi
                loop checkloop314
            
            vcheckyy:
                cmp xpos, 5
                jz continuee315
                jnz cont316

                continuee315:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check315:
                        mov al, [edi]
                        sub al, 1
                        cmp ypos, al
                        je gameloop1
                        inc edi
                    loop check315

                cont316:
                    cmp xpos, 110
                    jz continue317
                    jnz continueee311

                    continue317:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check316:
                            mov al, [edi]
                            sub al, 1
                            cmp ypos, al
                            je gameloop1
                            inc edi
                        loop check316
       continueee311:
            cmp yPos, 28
            jge gameLoop1
            call UpdatePlayer
            inc yPos
            call DrawPlayer
        ;    call GhostUpdate
         ;   dec ghosty
          ;  call Drawghost
            jmp gameLoop1

    moveLeft1:
        cmp ypos, 4
        jz continuee411
        jnz cont411
        continuee411:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop411:
                mov al, [esi]
                add al, 1
                cmp xpos, al
                je gameloop1
                inc esi
            loop checkloop411

         cont411:
            cmp ypos, 11           
            jz continue412
            jnz cont412

            continue412:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop412:
                    mov al, [edi]
                    add al, 1
                    cmp xpos, al
                    je gameloop1
                    inc edi
                loop checkloop412
            
            cont412:
                cmp ypos, 18
                jz continue413
                jnz cont413

             continue413:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop413:
                    mov al, [esi]
                    add al, 1
                    cmp xpos, al
                    je gameloop1
                    inc esi
                loop checkloop413

            cont413:
                cmp ypos, 25
                jz continue414
                jnz vcheckyyy

            continue414:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop414:
                    mov al, [edi]
                    add al, 1
                    cmp xpos, al
                    je gameloop1
                    inc edi
                loop checkloop414
            
            vcheckyyy:
                cmp xpos, 6
                jz continuee415
                jnz cont416

                continuee415:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check415:
                        mov al, [edi]
                   ;    sub al, 1
                        cmp ypos, al
                        je gameloop1
                        inc edi
                    loop check415

                cont416:
                    cmp xpos, 111
                    jz continue417
                    jnz continueee411

                    continue417:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check416:
                            mov al, [edi]
                      ;      sub al, 1
                            cmp ypos, al
                            je gameloop1
                            inc edi
                        loop check416
    continueee411:
        cmp xPos, 2
        jle gameLoop1
        call UpdatePlayer
        dec xPos
        call DrawPlayer
    ;    call GhostUpdate
     ;   inc ghostx
      ;  call Drawghost
        jmp gameLoop1

    moveRight1:
        cmp ypos, 4
        jz continuee511
        jnz cont511
        continuee511:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop511:
                mov al, [esi]
                sub al, 1
                cmp xpos, al
                je gameloop1
                inc esi
            loop checkloop511

         cont511:
            cmp ypos, 11          
            jz continue512
            jnz cont512

            continue512:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop512:
                    mov al, [edi]
                    sub al, 1
                    cmp xpos, al
                    je gameloop1
                    inc edi
                loop checkloop512
            
            cont512:
                cmp ypos, 18
                jz continue513
                jnz cont513

             continue513:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop513:
                    mov al, [esi]
                    sub al, 1
                    cmp xpos, al
                    je gameloop1
                    inc esi
                loop checkloop513

            cont513:
                cmp ypos, 25
                jz continue514
                jnz vcheckyyyy

            continue514:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop514:
                    mov al, [edi]
                    sub al, 1
                    cmp xpos, al
                    je gameloop1
                    inc edi
                loop checkloop514
            
            vcheckyyyy:
                cmp xpos, 4
                jz continuee515
                jnz cont516

                continuee515:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check515:
                        mov al, [edi]
                     ;   sub al, 1
                        cmp ypos, al
                        je gameloop1
                        inc edi
                    loop check515

                cont516:
                    cmp xpos, 109
                    jz continue517
                    jnz continueee511

                    continue517:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check516:
                            mov al, [edi]
                        ;    sub al, 1
                            cmp ypos, al
                            je gameloop1
                            inc edi
                        loop check516
    continueee511:
        cmp xPos, 117
        jge gameLoop1
        call UpdatePlayer
        inc xPos
        call DrawPlayer
    ;    call GhostUpdate
     ;   dec ghostx
      ;  call Drawghost
        jmp gameLoop1

    pausee1:
        call clrscr
         mov eax,blue ;(blue * 16)
        call SetTextColor
        mov dl, 35
        mov dh, 2
        call Gotoxy
        mov edx, offset pacman
        call writestring
        mov dl, 35
        mov dh, 3
        call Gotoxy
        mov edx, offset pacman1
        call writestring
        mov dl, 35
        mov dh, 4
        call Gotoxy
        mov edx, offset pacman2
        call writestring
        mov dl, 35
        mov dh, 5
        call Gotoxy
        mov edx, offset pacman3
        call writestring
        mov dl, 35
        mov dh, 6
        call Gotoxy
        mov edx, offset pacman4
        call writestring

        mov eax, white
        call settextcolor
        mov eax, 100
        call Delay
        mov dl, 45
        mov dh, 10
        call Gotoxy

        mov edx, offset resume
        call writestring
        mov eax, 100
        call Delay
        mov dl, 45
        mov dh, 13
        call Gotoxy

        mov edx, offset restart
        call writestring
        mov eax, 100
        call Delay
        mov dl, 45
        mov dh, 16
        call Gotoxy
        mov edx, offset quit
        call writestring

        call readchar

        cmp al, "1"
        je unpausee

        cmp al, "2"
        je startgame

        cmp al, "3"
        je exitgame

    unpausee:
        call clrscr
        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        mov ecx, 20
        looop2:
            call Drawcoin
            inc esi
            inc edi
        loop looop2

        call Drawmaze2
        call Drawboundaries
        call Drawplayer
        call Drawghost
        jmp gameloop1
    
    ;skipmovement:  
    

    jmp gameloop1

    level3:
    call levelcleared

        call clrscr
        mov esi, offset coinsarrx
        mov edi, offset coinsarry        
        mov ecx, 20        
        call Randomize
        l3l1:            
            call CreateRandomCoin
            call Drawcoin
            inc esi
            inc edi
        loop l3l1

        call drawboundaries
        call drawmaze3
        mov al, 40
        mov xpos, al
        mov al, 28
        mov ypos, al
        mov al, 70
        mov ghostx, al
        mov al, 16
        mov ghosty, al
        call Drawghost
        call drawghost1
        call drawghost2
        call DrawPlayer

        gameLoop2:

        cmp score, 100
        jae youwin1

        cmp win8, 1
        je ex

        cmp score, 50
        jl noteleport
            

        ; Teleportation
        mov teleportx, 40
        mov teleporty, 14
        mov eax, 0
        mov al, teleportx
        mov ebx, 0
        mov bl, teleporty

        push eax
        push ebx
        call drawteleport

        mov teleportx, 80
        mov teleporty, 8
        call drawteleport

        call checkteleport
        noteleport:        

        ;chech collison of player and coins
        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        mov ecx, 20
        mov bl, xpos
        mov dl, ypos

        l3looop1:
            cmp bl, [esi]
            jne l3notequall

            cmp dl, [edi]
            je l3equall

            l3notequall:
                inc esi
                inc edi

        loop l3looop1

        l3equall:
            cmp byte ptr [esi], -1
            je l3notequall1

            add score, 5
            mov byte ptr [esi], -1
            
        l3notequall1:
        mov eax, white 
        call settextcolor

        ;Name of the player
        mov dl, 3
        mov dh, 0
        call Gotoxy

        mov edx, offset inputname
        call writestring
        
        ; draw score:
        mov dl,50
        mov dh,0
        call Gotoxy
        mov edx,offset strScore
        call WriteString
        mov al,score
        sub al, 5
        call WriteInt

        ;Lives

        mov bl, xpos
        mov dl, ypos

        mov al, ghostx1
        mov cl, ghosty1

        cmp bl, al
        jne g1skip
        cmp cl, dl
        jne g1skip

        dec live

        cmp live, 0
        je exitgame

        call UpdatePlayer
        mov xpos, 40
        mov ypos, 28
        call DrawPlayer
        call drawghost1

        g1skip:

        mov bl, xpos
        mov dl, ypos

        mov al, ghostx2
        mov cl, ghosty2

        cmp bl, al
        jne g2skip
        cmp cl, dl
        jne g2skip

        dec live
        cmp live, 0
        je exitgame

        call UpdatePlayer
        mov xpos, 40
        mov ypos, 28
        call DrawPlayer
        call drawghost2

        g2skip:

        mov bl,xpos
        mov dl,ypos

        mov al,ghostx
        mov cl,ghosty

        cmp bl, al
        jne l3skippp

        cmp dl, cl
        jne l3skippp

        dec live

        cmp live, 0
        je exitgame

        call UpdatePlayer
        mov xpos, 40
        mov ypos, 28
        call DrawPlayer
        call GhostUpdate
        mov ghosty, 16
        mov ghostx, 70
        call Drawghost

        l3skippp:

        mov dl, 108
        mov dh, 0
        call gotoxy

        mov edx, offset lives
        call writestring

        mov al, live
        call writeint
        

        ;check collision of ghost and coins

        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        
        mov bl, ghostx1
        mov dl, ghosty1 
        mov ecx, 20
        g1l3loooopp11:
            cmp bl, [esi]
            jne g1l3neqqq11
            cmp dl, [edi]
            je g1l3eqqq1

            g1l3neqqq11:
                inc esi
                inc edi
        loop g1l3loooopp11
       
        jmp g1l3neqq11
        g1l3eqqq1:
            jmp g1l3movem1

        g1l3neqq11:
        call updateghost1
        call ghost1movement
        call drawghost1
        jmp g1l3rk1
        g1l3movem1:
        
        call updateghost1
        call ghost1movement
        call drawghost1
        call drawcoin

        g1l3rk1:

        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        
        mov bl, ghostx2
        mov dl, ghosty2
        mov ecx, 20
        g2l3loooopp11:
            cmp bl, [esi]
            jne g2l3neqqq11
            cmp dl, [edi]
            je g2l3eqqq1

            g2l3neqqq11:
                inc esi
                inc edi
        loop g2l3loooopp11
       
        jmp g2l3neqq11
        g2l3eqqq1:
            jmp g2l3movem1

        g2l3neqq11:
        call updateghost2
        call ghost2movement
        call drawghost2
        jmp g2l3rk1
        g2l3movem1:
        
        call updateghost2
        call ghost2movement
        call drawghost2
        call drawcoin

        g2l3rk1:

        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        
        mov bl, ghostx
        mov dl, ghosty   
        mov ecx, 20
        l3loooopp11:
            cmp bl, [esi]
            jne l3neqqq11
            cmp dl, [edi]
            je l3eqqq1

            l3neqqq11:
                inc esi
                inc edi
        loop l3loooopp11
       
        jmp l3neqq11
        l3eqqq1:
            jmp l3movem1

        l3neqq11:
        call GhostUpdate
        call ghostmovement3
        call Drawghost
        jmp l3rk1
        l3movem1:
        
        call GhostUpdate
        call ghostmovement3
        call Drawghost
        call drawcoin

        l3rk1:

        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        
        mov bl, ghostx
        mov dl, ghosty   
        mov ecx, 20
        l3loooopp111:
            cmp bl, [esi]
            jne l3neqqq111
            cmp dl, [edi]
            je l3eqqq11

            l3neqqq111:
                inc esi
                inc edi
        loop l3loooopp111
       
        jmp l3neqq1111
        l3eqqq11:
            jmp l3movem11

        l3neqq1111:
        call GhostUpdate
        call ghostmovement3
        call Drawghost
        jmp l3rkk1
        l3movem11:
        
        call GhostUpdate
        call ghostmovement3
        call Drawghost
        call drawcoin

        l3rkk1:

        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        
        mov bl, ghostx
        mov dl, ghosty   
        mov ecx, 20
        l3loooopp1111:
            cmp bl, [esi]
            jne l3neqqq1111
            cmp dl, [edi]
            je l3eqqq111

            l3neqqq1111:
                inc esi
                inc edi
        loop l3loooopp1111
       
        jmp l3neqq11111
        l3eqqq111:
            jmp l3movem111

        l3neqq11111:
        call GhostUpdate
        call ghostmovement3
        call Drawghost
        jmp l3rkk11
        l3movem111:
        
        call GhostUpdate
        call ghostmovement3
        call Drawghost
        call drawcoin

        l3rkk11:

        ; get user key input:

        mov al, 100
        call Delay

        call Readkey
        mov inputChar,al

        cmp al, 1
        je gameloop2

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame
        cmp inputChar, "X"
        je exitGame

        cmp inputChar,"w"
        je moveUp2
        cmp inputChar, "W"
        je moveUp2

        cmp inputChar,"s"
        je moveDown2
        cmp inputChar, "S"
        je moveDown2

        cmp inputChar,"a"
        je moveLeft2
        cmp inputChar, "A"
        je moveLeft2

        cmp inputChar,"d"
        je moveRight2
        cmp inputChar, "D"
        je moveRight2

        cmp inputChar, "P"
        je pauseee2
        cmp inputChar, "p"
        je pauseee2
        jmp pauseee2

    moveUp2:
        cmp ypos, 5
        jz l3continuee211
        jnz l3cont211
        l3continuee211:
            mov esi, offset wallarrx
            mov ecx, 40
            l3checkloop211:
                mov al, [esi]
                cmp xpos, al
                je gameloop2
                inc esi
            loop l3checkloop211

         l3cont211:
            cmp ypos, 12            
            jz l3continue212
            jnz l3cont212

            l3continue212:
                mov edi, offset wallarrx
                mov ecx, 40
                l3checkloop212:
                    mov al, [edi]
                    cmp xpos, al
                    je gameloop2
                    inc edi
                loop l3checkloop212
            
            l3cont212:
                cmp ypos, 19
                jz l3continue213
                jnz l3cont213

             l3continue213:
                mov esi, offset wallarrx
                mov ecx, 40
                l3checkloop213:
                    mov al, [esi]
                    cmp xpos, al
                    je gameloop2
                    inc esi
                loop l3checkloop213

            l3cont213:
                cmp ypos, 26
                jz l3continue214
                jnz l3vchecky

            l3continue214:
                mov edi, offset wallarrx
                mov ecx, 40
                l3checkloop214:
                    mov al, [edi]
                    cmp xpos, al
                    je gameloop2
                    inc edi
                loop l3checkloop214
            
            l3vchecky:
                cmp xpos, 5
                jz l3continuee215
                jnz l3cont216

                l3continuee215:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    l3check215:
                        mov al, [edi]
                        add al, 1
                        cmp ypos, al
                        je gameloop2
                        inc edi
                    loop l3check215

                l3cont216:
                    cmp xpos, 110
                    jz l3continue217
                    jnz l3continue

                    l3continue217:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        l3check216:
                            mov al, [edi]
                            add al, 1
                            cmp ypos, al
                            je gameloop2
                            inc edi
                        loop l3check216

                    l3continue:
                        cmp xpos, 60
                        jz l3continue1
                        jnz l3continueee211

                        l3continue1:
                            mov edi, offset wallarrx1
                            mov ecx, 20
                            l3check1:
                                mov al, [edi]
                                add al, 1
                                cmp ypos, al
                                jz gameloop2
                                inc edi
                            loop l3check1

        l3continueee211:
            cmp yPos, 2 
            jle wrap
             call UpdatePlayer
             dec yPos
             call DrawPlayer
             jmp gameloop2
             wrap:
                call UpdatePlayer
                mov ypos, 28
                call DrawPlayer
                
            jmp gameLoop2

    moveDown2:
        cmp ypos, 3
        jz l3continuee311
        jnz l3cont311
        l3continuee311:
            mov esi, offset wallarrx
            mov ecx, 40
            l3checkloop311:
                mov al, [esi]
                cmp xpos, al
                je gameloop2
                inc esi
            loop l3checkloop311

         l3cont311:
            cmp ypos, 10           
            jz l3continue312
            jnz l3cont312

            l3continue312:
                mov edi, offset wallarrx
                mov ecx, 40
                l3checkloop312:
                    mov al, [edi]
                    cmp xpos, al
                    je gameloop2
                    inc edi
                loop l3checkloop312
            
            l3cont312:
                cmp ypos, 17
                jz l3continue313
                jnz l3cont313

             l3continue313:
                mov esi, offset wallarrx
                mov ecx, 40
                l3checkloop313:
                    mov al, [esi]
                    cmp xpos, al
                    je gameloop2
                    inc esi
                loop l3checkloop313

            l3cont313:
                cmp ypos, 24
                jz l3continue314
                jnz l3vcheckyy

            l3continue314:
                mov edi, offset wallarrx
                mov ecx, 40
                l3checkloop314:
                    mov al, [edi]
                    cmp xpos, al
                    je gameloop2
                    inc edi
                loop l3checkloop314
            
            l3vcheckyy:
                cmp xpos, 5
                jz l3continuee315
                jnz l3cont316

                l3continuee315:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    l3check315:
                        mov al, [edi]
                        sub al, 1
                        cmp ypos, al
                        je gameloop2
                        inc edi
                    loop l3check315

                l3cont316:
                    cmp xpos, 110
                    jz l3continue317
                    jnz l3continue11

                    l3continue317:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        l3check316:
                            mov al, [edi]
                            sub al, 1
                            cmp ypos, al
                            je gameloop2
                            inc edi
                        loop l3check316

                    l3continue11:
                        cmp xpos, 60
                        jz l3continue1111
                        jnz l3continueee311

                        l3continue1111:
                            mov edi, offset wallarrx1
                            mov ecx, 20
                            l3check11:
                                mov al, [edi]
                                sub al, 1
                                cmp ypos, al
                                jz gameloop2
                                inc edi
                            loop l3check11
                        
       l3continueee311:
            cmp yPos, 28
            jge wrap1
            call UpdatePlayer
            inc yPos
            call DrawPlayer
            jmp gameLoop2
            wrap1:
                call UpdatePlayer
                mov ypos, 3
                call DrawPlayer
                jmp gameloop2


    moveLeft2:
        cmp ypos, 4
        jz l3continuee411
        jnz l3cont411
        l3continuee411:
            mov esi, offset wallarrx
            mov ecx, 40
            l3checkloop411:
                mov al, [esi]
                add al, 1
                cmp xpos, al
                je gameloop2
                inc esi
            loop l3checkloop411

         l3cont411:
            cmp ypos, 11           
            jz l3continue412
            jnz l3cont412

            l3continue412:
                mov edi, offset wallarrx
                mov ecx, 40
                l3checkloop412:
                    mov al, [edi]
                    add al, 1
                    cmp xpos, al
                    je gameloop2
                    inc edi
                loop l3checkloop412
            
            l3cont412:
                cmp ypos, 18
                jz l3continue413
                jnz l3cont413

            l3continue413:
                mov esi, offset wallarrx
                mov ecx, 40
                l3checkloop413:
                    mov al, [esi]
                    add al, 1
                    cmp xpos, al
                    je gameloop2
                    inc esi
                loop l3checkloop413

            l3cont413:
                cmp ypos, 25
                jz l3continue414
                jnz l3vcheckyyy

            l3continue414:
                mov edi, offset wallarrx
                mov ecx, 40
                l3checkloop414:
                    mov al, [edi]
                    add al, 1
                    cmp xpos, al
                    je gameloop2
                    inc edi
                loop l3checkloop414
            
            l3vcheckyyy:
                cmp xpos, 6
                jz l3continuee415
                jnz l3cont416

                l3continuee415:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    l3check415:
                        mov al, [edi]
                       ; sub al, 1
                        cmp ypos, al
                        je gameloop2
                        inc edi
                    loop l3check415

                l3cont416:
                    cmp xpos, 111
                    jz l3continue417
                    jnz l3continue21

                    l3continue417:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        l3check416:
                            mov al, [edi]
                           ; sub al, 1
                            cmp ypos, al
                            je gameloop2
                            inc edi
                        loop l3check416

                    l3continue21:
                        cmp xpos, 61
                        jz l3continue23
                        jnz l3continueee411

                        l3continue23:
                            mov edi, offset wallarrx1
                            mov ecx, 20
                            l3check111:
                                mov al, [edi]
                                ;sub al, 1
                                cmp ypos, al
                                jz gameloop2
                                inc edi
                            loop l3check111
    l3continueee411:
        cmp xPos, 2
        jle wrap2
        call UpdatePlayer
        dec xPos
        call DrawPlayer
        jmp gameloop2
        wrap2:
            call UpdatePlayer
            mov xpos, 118
            call DrawPlayer
        jmp gameLoop2

    moveRight2:
        cmp ypos, 4
        jz l3continuee511
        jnz l3cont511
        l3continuee511:
            mov esi, offset wallarrx
            mov ecx, 40
            l3checkloop511:
                mov al, [esi]
                sub al, 1
                cmp xpos, al
                je gameloop2
                inc esi
            loop l3checkloop511

         l3cont511:
            cmp ypos, 11          
            jz l3continue512
            jnz l3cont512

            l3continue512:
                mov edi, offset wallarrx
                mov ecx, 40
                l3checkloop512:
                    mov al, [edi]
                    sub al, 1
                    cmp xpos, al
                    je gameloop2
                    inc edi
                loop l3checkloop512
            
            l3cont512:
                cmp ypos, 18
                jz l3continue513
                jnz l3cont513

             l3continue513:
                mov esi, offset wallarrx
                mov ecx, 40
                l3checkloop513:
                    mov al, [esi]
                    sub al, 1
                    cmp xpos, al
                    je gameloop2
                    inc esi
                loop l3checkloop513

            l3cont513:
                cmp ypos, 25
                jz l3continue514
                jnz l3vcheckyyyy

            l3continue514:
                mov edi, offset wallarrx
                mov ecx, 40
                l3checkloop514:
                    mov al, [edi]
                    sub al, 1
                    cmp xpos, al
                    je gameloop2
                    inc edi
                loop l3checkloop514
            
            l3vcheckyyyy:
                cmp xpos, 4
                jz l3continuee515
                jnz l3cont516

                l3continuee515:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    l3check515:
                        mov al, [edi]
                       ; add al, 1
                        cmp ypos, al
                        je gameloop2
                        inc edi
                    loop l3check515

                l3cont516:
                    cmp xpos, 109
                    jz l3continue517
                    jnz l3continue31

                    l3continue517:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        l3check516:
                            mov al, [edi]
                            ;add al, 1
                            cmp ypos, al
                            je gameloop2
                            inc edi
                        loop l3check516

                    l3continue31:
                        cmp xpos, 59
                        jz l3continue111
                        jnz l3continueee511

                        l3continue111:
                            mov edi, offset wallarrx1
                            mov ecx, 20
                            l3chec1k111:
                                mov al, [edi]
                            ;    add al, 1
                                cmp ypos, al
                                jz gameloop2
                                inc edi
                            loop l3chec1k111

    l3continueee511:    
        cmp xPos, 117
        jge wrap3
        call UpdatePlayer
        inc xPos
        call DrawPlayer
        jmp gameLoop2
        wrap3:
            call UpdatePlayer
            mov xpos, 2
            call DrawPlayer
            jmp gameloop2


    pauseee2:
        call clrscr
         mov eax,blue ;(blue * 16)
        call SetTextColor
        mov dl, 35
        mov dh, 2
        call Gotoxy
        mov edx, offset pacman
        call writestring
        mov dl, 35
        mov dh, 3
        call Gotoxy
        mov edx, offset pacman1
        call writestring
        mov dl, 35
        mov dh, 4
        call Gotoxy
        mov edx, offset pacman2
        call writestring
        mov dl, 35
        mov dh, 5
        call Gotoxy
        mov edx, offset pacman3
        call writestring
        mov dl, 35
        mov dh, 6
        call Gotoxy
        mov edx, offset pacman4
        call writestring

        mov eax, white
        call settextcolor
        mov eax, 100
        call Delay
        mov dl, 45
        mov dh, 10
        call Gotoxy

        mov edx, offset resume
        call writestring
        mov eax, 100
        call Delay
        mov dl, 45
        mov dh, 13
        call Gotoxy

        mov edx, offset restart
        call writestring
        mov eax, 100
        call Delay
        mov dl, 45
        mov dh, 16
        call Gotoxy
        mov edx, offset quit
        call writestring

        call readchar

        cmp al, "1"
        je unpauseee

        cmp al, "2"
        je startgame

        cmp al, "3"
        je exitgame

    unpauseee:
        call clrscr
        mov esi, offset coinsarrx
        mov edi, offset coinsarry
        mov ecx, 20
        l3looop2:
            call Drawcoin
            inc esi
            inc edi
        loop l3looop2

        call Drawmaze3
        call Drawboundaries
        call Drawplayer
        call Drawghost
        jmp gameloop2
    
    ;skipmovement:  
    

    jmp gameloop2
        


    exitGame:
    call clrscr
    mov eax, red
    call settextcolor

    mov dl, 40
    mov dh, 5
    call Gotoxy 
    mov edx, offset gameover
    call writestring
    mov dl, 39
    mov dh, 6
    call Gotoxy 
    mov edx, offset gameover1
    call writestring
    mov dl, 38
    mov dh, 7
    call Gotoxy 
    mov edx, offset gameover2
    call writestring
     mov dl, 37
    mov dh, 8
    call Gotoxy 
    mov edx, offset gameover3
    call writestring
    mov dl, 37
    mov dh, 9
    call Gotoxy 
    mov edx, offset gameover4
    call writestring

    mov dl, 38
    mov dh, 15
    call Gotoxy
    mov edx, offset nm1
    call writestring
    
    mov dl, 48
    mov dh, 15
    call Gotoxy
    mov edx, offset inputname
    call writestring

    mov dl, 38
    mov dh, 18
    call Gotoxy
    mov edx, offset score1
    call writestring
    mov al, score
    call writeint

    mov dl, 38
    mov dh, 20
    call Gotoxy
    mov edx, offset gameover5
    call writestring
    call readchar
    cmp al, "x"
    je ex

    ex:
        call clrscr

    exit
main ENDP

Drawmaze PROC

mov esi, offset wallarrx
mov edi, offset wallarrx1
mov eax, red
call settextcolor

mov cl,4
mov dl, 18
mov wallx, dl
mov dh, 3
mov wally, dh
l1:
    ;mov dl, wallx
    ;mov dh, wally
    mov bl, cl
    mov cl, 10
    ;mov [esi], dl
    ;mov [edi], dh
    l2:
        mov [esi], dl
        call Gotoxy
        mov al, wall1
        call writechar
        inc dl
        inc esi
    loop l2
    add dl, 15
    mov cl, bl
    ;inc esi
    ;inc edi
loop l1

mov cl,5
mov dl, 7
mov wallx, dl
mov dh, 10
mov wally, dh
l3:
    ;mov dl, wallx
    ;mov dh, wally
    mov bl, cl
    mov cl, 10
    ;mov [esi], dl
    ;mov [edi], dh
    l4:
        mov [edi], dl
        call Gotoxy
        mov al, wall1
        call writechar
        inc dl
        inc edi
    loop l4
    ;inc esi
    ;inc edi
    add dl, 15
    mov cl, bl
loop l3


mov cl,4
mov dl, 18
mov wallx, dl
mov dh, 17
mov wally, dh
l5:
    ;mov dl, wallx
    ;mov dh, wally
    mov bl, cl
    mov cl, 10
    ;mov [esi], dl
    ;mov [edi], dh
    l6:
        ;mov [esi], dl
        call Gotoxy
        mov al, wall1
        call writechar
        inc dl
        ;inc esi
    loop l6
    ;inc esi
    ;inc edi
    add dl, 15
    mov cl, bl
loop l5

mov cl,5
mov dl, 7
mov wallx, dl
mov dh, 24
mov wally, dh
l7:
    ;mov dl, wallx
    ;mov dh, wally
    mov bl, cl
    mov cl, 10
    ;mov [esi], dl
    ;mov [edi], dh
    l8:
        ;mov [edi], dl
        call Gotoxy
        mov al, wall1
        call writechar
        ;inc edi
        inc dl
    loop l8
    ;inc esi
    ;inc edi
    add dl, 15
    mov cl, bl
loop l7
mov esi, offset wallarrx
mov edi, offset wallarrx1

   ret
Drawmaze endp

drawmaze2 PROC

mov esi, offset wallarrx
mov edi, offset wallarrx1
mov eax, blue
call settextcolor

mov cl,4
mov dl, 18
mov wallx, dl
mov dh, 4
mov wally, dh
l1:
    ;mov dl, wallx
    ;mov dh, wally
    mov bl, cl
    mov cl, 10
    ;mov [esi], dl
    ;mov [edi], dh
    l2:
        mov [esi], dl
        call Gotoxy
        mov al, wall1
        call writechar
        inc dl
        inc esi
    loop l2
    add dl, 15
    mov cl, bl
    ;inc esi
    ;inc edi
loop l1

mov cl,4
mov dl, 18
mov wallx, dl
mov dh, 11
mov wally, dh
l3:
    ;mov dl, wallx
    ;mov dh, wally
    mov bl, cl
    mov cl, 10
    ;mov [esi], dl
    ;mov [edi], dh
    l4:
        mov [esi], dl
        call Gotoxy
        mov al, wall1
        call writechar
        inc dl
        inc esi
    loop l4
    add dl, 15
    mov cl, bl
    ;inc esi
    ;inc edi
loop l3

mov cl,4
mov dl, 18
mov wallx, dl
mov dh, 18
mov wally, dh
l5:
    ;mov dl, wallx
    ;mov dh, wally
    mov bl, cl
    mov cl, 10
    ;mov [esi], dl
    ;mov [edi], dh
    l6:
        mov [esi], dl
        call Gotoxy
        mov al, wall1
        call writechar
        inc dl
        inc esi
    loop l6
    add dl, 15
    mov cl, bl
    ;inc esi
    ;inc edi
loop l5

mov cl,4
mov dl, 18
mov wallx, dl
mov dh, 25
mov wally, dh
l7:
    ;mov dl, wallx
    ;mov dh, wally
    mov bl, cl
    mov cl, 10
    ;mov [esi], dl
    ;mov [edi], dh
    l8:
        mov [esi], dl
        call Gotoxy
        mov al, wall1
        call writechar
        inc dl
        inc esi
    loop l8
    add dl, 15
    mov cl, bl
    ;inc esi
    ;inc edi
loop l7


mov eax, red
call settextcolor
mov cl, 2
mov dl, 5
mov wallx, dl
mov dh, 6
mov wally, dh
l9:
    mov bl, cl
    mov cl, 5
    l10:
        mov al, wally
        mov [edi], al
        mov dl, wallx
        mov dh, wally
        call Gotoxy
        mov edx, offset ground2
        call writestring
        inc wally
        inc edi
     loop l10

     mov cl, bl
     ;add wallx, 100
     add wally, 6  
   ; inc wally

loop l9

mov cl, 2
mov dl, 110
mov wallx, dl
mov dh, 6
mov wally, dh
l11:
    mov bl, cl
    mov cl, 5
    l12:
        mov dl, wallx
        mov dh, wally
        call Gotoxy
        mov edx, offset ground2
        call writestring
        inc wally
     loop l12

     mov cl, bl
     ;add wallx, 100
     add wally, 6
    
   ; inc wally
loop l11

mov esi, offset wallarrx
mov edi, offset wallarrx1

ret

drawmaze2 endp

drawmaze3 PROC

    mov esi, offset wallarrx
    mov edi, offset wallarrx1
    mov eax, blue
    call settextcolor

    mov cl,4
    mov dl, 18
    mov wallx, dl
    mov dh, 4
    mov wally, dh
    l1:
        ;mov dl, wallx
        ;mov dh, wally
        mov bl, cl
        mov cl, 10
        ;mov [esi], dl
        ;mov [edi], dh
        l2:
            mov [esi], dl
            call Gotoxy
            mov al, wall1
            call writechar
            inc dl
            inc esi
        loop l2
        add dl, 15
        mov cl, bl
        ;inc esi
        ;inc edi
    loop l1

    mov cl,4
    mov dl, 18
    mov wallx, dl
    mov dh, 11
    mov wally, dh
    l3:
        ;mov dl, wallx
        ;mov dh, wally
        mov bl, cl
        mov cl, 10
        ;mov [esi], dl
        ;mov [edi], dh
        l4:
            mov [esi], dl
            call Gotoxy
            mov al, wall1
            call writechar
            inc dl
            inc esi
        loop l4
        add dl, 15
        mov cl, bl
        ;inc esi
        ;inc edi
    loop l3

    mov cl,4
    mov dl, 18
    mov wallx, dl
    mov dh, 18
    mov wally, dh
    l5:
        ;mov dl, wallx
        ;mov dh, wally
        mov bl, cl
        mov cl, 10
        ;mov [esi], dl
        ;mov [edi], dh
        l6:
            mov [esi], dl
            call Gotoxy
            mov al, wall1
            call writechar
            inc dl
            inc esi
        loop l6
        add dl, 15
        mov cl, bl
        ;inc esi
        ;inc edi
    loop l5

    mov cl,4
    mov dl, 18
    mov wallx, dl
    mov dh, 25
    mov wally, dh
    l7:
        ;mov dl, wallx
        ;mov dh, wally
        mov bl, cl
        mov cl, 10
        ;mov [esi], dl
        ;mov [edi], dh
        l8:
            mov [esi], dl
            call Gotoxy
            mov al, wall1
            call writechar
            inc dl
            inc esi
        loop l8
        add dl, 15
        mov cl, bl
        ;inc esi
        ;inc edi
    loop l7

    mov eax, red
    call settextcolor
    mov cl, 2
    mov dl, 5
    mov wallx, dl
    mov dh, 6
    mov wally, dh
    l9:
        mov bl, cl
        mov cl, 5
        l10:
            mov al, wally
            mov [edi], al
            mov dl, wallx
            mov dh, wally
            call Gotoxy
            mov edx, offset ground2
            call writestring
            inc wally
            inc edi
         loop l10

         mov cl, bl
         ;add wallx, 100
         add wally, 6  
       ; inc wally

    loop l9

    mov cl, 2
    mov dl, 110
    mov wallx, dl
    mov dh, 6
    mov wally, dh
    l11:
        mov bl, cl
        mov cl, 5
        l12:
            mov dl, wallx
            mov dh, wally
            call Gotoxy
            mov edx, offset ground2
            call writestring
            inc wally
         loop l12

         mov cl, bl
         ;add wallx, 100
         add wally, 6
    
       ; inc wally
    loop l11

    mov cl, 2
    mov dl, 60
    mov wallx, dl
    mov dh, 6
    mov wally, dh
    l111:
        mov bl, cl
        mov cl, 5
        l112:
            mov dl, wallx
            mov dh, wally
            call Gotoxy
            mov edx, offset ground2
            call writestring
            inc wally
         loop l112

         mov cl, bl
         ;add wallx, 100
         add wally, 6
    
       ; inc wally
    loop l111

    mov esi, offset wallarrx
    mov edi, offset wallarrx1

    ret


drawmaze3 endp

Drawboundaries PROC
    mov eax,blue ;(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov ecx, 119
    loop1:
         mov al, ground
         call WriteChar
         inc dl
         Call Gotoxy
    loop loop1
     
    mov ecx, 119
    mov dl,0
    mov dh,1
    call Gotoxy
    loop2:
        mov al, ground
        call WriteChar
        inc dl
        call Gotoxy
    loop loop2


    mov ecx,27
    mov dh,2
    mov temp,dh
    l1:
    mov dh,temp
    mov dl,0
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l1

    mov ecx,27
    mov dh,2
    mov temp,dh
    l2:
    mov dh,temp
    mov dl,119
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l2
    
    ret

Drawboundaries endp

Drawghost PROC
    mov eax, red
    call settextcolor

    mov dl, ghostx
    mov dh, ghosty

    call Gotoxy

    mov al, "$"
    call writechar
    ret

Drawghost endp

GhostUpdate PROC
    mov dl, ghostx
    mov dh, ghosty
    call Gotoxy

    mov al, " "
    call writechar

    ret

GhostUpdate endp

drawghost1 PROC
    mov eax, red
    call settextcolor

    mov dl, ghostx1
    mov dh, ghosty1

    call Gotoxy

    mov al, "$"
    call writechar
    ret

drawghost1 endp

updateghost1 PROC
    mov dl, ghostx1
    mov dh, ghosty1
    call Gotoxy

    mov al, " "
    call writechar

    ret

updateghost1 endp

drawghost2 PROC
    mov eax, red
    call settextcolor

    mov dl, ghostx2
    mov dh, ghosty2

    call Gotoxy

    mov al, "$"
    call writechar
    ret

drawghost2 endp

updateghost2 PROC
    mov dl, ghostx2
    mov dh, ghosty2
    call Gotoxy

    mov al, " "
    call writechar

    ret

updateghost2 endp

ghostmovement PROC
    mov eax, 4
    call randomrange

    cmp eax, 0
    je moveup

    cmp eax, 1
    je movedown

    cmp eax, 2
    je moveright

    cmp eax, 3
    je moveleft
    ;jne end1

    moveup:
        cmp ghosty, 4
        jz continue1
        jnz cont
        continue1:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop:
                mov al, [esi]
                cmp ghostx, al
                je end1
                inc esi
            loop checkloop

         cont:
            cmp ghosty, 11            
            jz continue2
            jnz cont1

            continue2:
                mov edi, offset wallarrx1
                mov ecx, 50
                checkloop1:
                    mov al, [edi]
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop1
            
            cont1:
                cmp ghosty, 18
                jz continue3
                jnz cont2

             continue3:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop2:
                    mov al, [esi]
                    cmp ghostx, al
                    je end1
                    inc esi
                loop checkloop2

            cont2:
                cmp ghosty, 25
                jz continue4
                jnz continue

            continue4:
                mov edi, offset wallarrx1
                mov ecx, 50
                checkloop3:
                    mov al, [edi]
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop3
        
        continue:
            cmp ghosty, 2 
            jle end1
            ;mov ecx,1
            dec ghosty
            ;dec ghosty
            ;jmp end1
            ret

    movedown:
        cmp ghosty, 2
        jz continuee1
        jnz contt
        continuee1:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloopp:
                mov al, [esi]
                cmp ghostx, al
                je end1
                inc esi
            loop checkloopp

         contt:
            cmp ghosty, 9        
            jz continuee2
            jnz contt1

            continuee2:
                mov edi, offset wallarrx1
                mov ecx, 50
                checkloopp1:
                    mov al, [edi]
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloopp1
            
            contt1:
                cmp ghosty, 16
                jz continuee3
                jnz contt2

             continuee3:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloopp2:
                    mov al, [esi]
                    cmp ghostx, al
                    je end1
                    inc esi
                loop checkloopp2

            contt2:
                cmp ghosty, 22
                jz continuee4
                jnz continuee

            continuee4:
                mov edi, offset wallarrx1
                mov ecx, 50
                checkloopp3:
                    mov al, [edi]
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloopp3

    continuee:
        cmp ghosty, 28
        jge end1

        inc ghosty
        ;inc ghosty
        ;jmp end1
        ret

    moveright:
        cmp ghosty, 3
        jz continueeee1
        jnz contttt
        continueeee1:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloooppp:
                mov al, [esi]
                sub al, 1
                cmp ghostx, al
                je end1
                inc esi
            loop checkloooppp

        contttt:
            cmp ghosty, 10           
            jz continueeee2
            jnz contttt1

            continueeee2:
                mov edi, offset wallarrx1
                mov ecx, 50
                checkloooppp1:
                    mov al, [edi]
                    sub al, 1
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloooppp1
            
            contttt1:
                cmp ghosty, 17
                jz continueeee3
                jnz contttt2

             continueeee3:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloooppp2:
                    mov al, [esi]
                    sub al, 1
                    cmp ghostx, al
                    je end1
                    inc esi
                loop checkloooppp2

            contttt2:
                cmp ghosty, 24
                jz continueeee4
                jnz continueeee

            continueeee4:
                mov edi, offset wallarrx1
                mov ecx, 50
                checkloooppp3:
                    mov al, [edi]
                    sub al, 1
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloooppp3


    continueeee:
        cmp ghostx, 117
        jge end1

        inc ghostx
        ;inc ghostx
        ;jmp end1
        ret

    moveleft:
        cmp ghosty, 3
        jz continueee1
        jnz conttt
        continueee1:
            mov esi, offset wallarrx
            mov ecx, 40
            checklooopp:
                mov al, [esi]
                add al, 1
                cmp ghostx, al
                je end1
                inc esi
            loop checklooopp

         conttt:
            cmp ghosty, 10           
            jz continueee2
            jnz conttt1

            continueee2:
                mov edi, offset wallarrx1
                mov ecx, 50
                checklooopp1:
                    mov al, [edi]
                    add al, 1
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checklooopp1
            
            conttt1:
                cmp ghosty, 17
                jz continueee3
                jnz conttt2

             continueee3:
                mov esi, offset wallarrx
                mov ecx, 40
                checklooopp2:
                    mov al, [esi]
                    add al, 1
                    cmp ghostx, al
                    je end1
                    inc esi
                loop checklooopp2

            conttt2:
                cmp ghosty, 24
                jz continueee4
                jnz continueee

            continueee4:
                mov edi, offset wallarrx1
                mov ecx, 50
                checklooopp3:
                    mov al, [edi]
                    add al, 1
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checklooopp3


    continueee:
        cmp ghostx, 2
        jle end1

        dec ghostx
        ;dec ghostx
        ;jmp end1
        ret

    end1:
    ret

ghostmovement endp

ghostmovement2 PROC
    
    mov eax, 4
    call randomrange

    cmp eax, 0
    je moveup

    cmp eax, 1
    je movedown

    cmp eax, 2
    je moveright

    cmp eax, 3
    je moveleft


    moveup:
        cmp ghosty, 5
        jz continuee211
        jnz cont211
        continuee211:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop211:
                mov al, [esi]
                cmp ghostx, al
                je end1
                inc esi
            loop checkloop211

         cont211:
            cmp ghosty, 12            
            jz continue212
            jnz cont212

            continue212:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop212:
                    mov al, [edi]
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop212
            
            cont212:
                cmp ghosty, 19
                jz continue213
                jnz cont213

             continue213:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop213:
                    mov al, [esi]
                    cmp ghostx, al
                    je end1
                    inc esi
                loop checkloop213

            cont213:
                cmp ghosty, 26
                jz continue214
                jnz vchecky

            continue214:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop214:
                    mov al, [edi]
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop214
            
            vchecky:
                cmp ghostx, 5
                jz continuee215
                jnz cont216

                continuee215:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check215:
                        mov al, [edi]
                    ;    add al, 1
                        cmp ghosty, al
                        je end1
                        inc edi
                    loop check215

                cont216:
                    cmp ghostx, 110
                    jz continue217
                    jnz continueee211

                    continue217:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check216:
                            mov al, [edi]
                         ;   add al, 1
                            cmp ghosty, al
                            je end1
                            inc edi
                        loop check216

        continueee211:
           cmp ghosty, 2 
           jle end1
           dec ghosty
     ;      dec ghosty
           ret
    
    movedown:
        cmp ghosty, 3
        jz continuee311
        jnz cont311
        continuee311:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop311:
                mov al, [esi]
                cmp ghostx, al
                je end1
                inc esi
            loop checkloop311

         cont311:
            cmp ghosty, 10           
            jz continue312
            jnz cont312

            continue312:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop312:
                    mov al, [edi]
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop312
            
            cont312:
                cmp ghosty, 17
                jz continue313
                jnz cont313

             continue313:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop313:
                    mov al, [esi]
                    cmp ghostx, al
                    je end1
                    inc esi
                loop checkloop313

            cont313:
                cmp ghosty, 24
                jz continue314
                jnz vcheckyy

            continue314:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop314:
                    mov al, [edi]
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop314
            
            vcheckyy:
                cmp ghostx, 5
                jz continuee315
                jnz cont316

                continuee315:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check315:
                        mov al, [edi]
                    ;    sub al, 1
                        cmp ghosty, al
                        je end1
                        inc edi
                    loop check315

                cont316:
                    cmp ghostx, 110
                    jz continue317
                    jnz continueee311

                    continue317:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check316:
                            mov al, [edi]
                          ;  sub al, 1
                            cmp ghosty, al
                            je end1
                            inc edi
                        loop check316
       continueee311:
            cmp ghosty, 28
            jge end1
            inc ghosty
      ;      inc ghosty
            ret

    moveright:
        cmp ghosty, 4
        jz continuee511
        jnz cont511
        continuee511:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop511:
                mov al, [esi]
                sub al, 1
                cmp ghostx, al
                je end1
                inc esi
            loop checkloop511

         cont511:
            cmp ghosty, 11          
            jz continue512
            jnz cont512

            continue512:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop512:
                    mov al, [edi]
                    sub al, 1
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop512
            
            cont512:
                cmp ghosty, 18
                jz continue513
                jnz cont513

             continue513:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop513:
                    mov al, [esi]
                    sub al, 1
                    cmp ghostx, al
                    je end1
                    inc esi
                loop checkloop513

            cont513:
                cmp ghosty, 25
                jz continue514
                jnz vcheckyyyy

            continue514:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop514:
                    mov al, [edi]
                    sub al, 1
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop514
            
            vcheckyyyy:
                cmp ghostx, 4
                jz continuee515
                jnz cont516

                continuee515:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check515:
                        mov al, [edi]
                      ;  sub al, 1
                        cmp ghosty, al
                        je end1
                        inc edi
                    loop check515

                cont516:
                    cmp ghostx, 109
                    jz continue517
                    jnz continueee511

                    continue517:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check516:
                            mov al, [edi]
                           ; sub al, 1
                            cmp ghosty, al
                            je end1
                            inc edi
                        loop check516


    continueee511:
        cmp ghostx, 117
        jge end1
        inc ghostx
      ; inc ghostx
        ret

    moveleft:
        cmp ghosty, 4
        jz continuee411
        jnz cont411
        continuee411:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop411:
                mov al, [esi]
                add al, 1
                cmp ghostx, al
                je end1
                inc esi
            loop checkloop411

         cont411:
            cmp ghosty, 11           
            jz continue412
            jnz cont412

            continue412:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop412:
                    mov al, [edi]
                    add al, 1
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop412
            
            cont412:
                cmp ghosty, 18
                jz continue413
                jnz cont413

             continue413:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop413:
                    mov al, [esi]
                    add al, 1
                    cmp ghostx, al
                    je end1
                    inc esi
                loop checkloop413

            cont413:
                cmp ghosty, 25
                jz continue414
                jnz vcheckyyy

            continue414:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop414:
                    mov al, [edi]
                    add al, 1
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop414
            
            vcheckyyy:
                cmp ghostx, 6
                jz continuee415
                jnz cont416

                continuee415:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check415:
                        mov al, [edi]
                     ;   sub al, 1
                        cmp ghosty, al
                        je end1
                        inc edi
                    loop check415

                cont416:
                    cmp ghostx, 111
                    jz continue417
                    jnz continueee411

                    continue417:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check416:
                            mov al, [edi]
                         ;   sub al, 1
                            cmp ghosty, al
                            je end1
                            inc edi
                        loop check416

    continueee411:
        cmp ghostx, 2
        jle end1
        dec ghostx
     ;  dec ghostx
        ret

  end1:
    ret

ghostmovement2 endp

ghostmovement3 PROC
    mov eax, 4
    call randomrange

    cmp eax, 0
    je moveup

    cmp eax, 1
    je movedown

    cmp eax, 2
    je moveright

    cmp eax, 3
    je moveleft


    moveup:
        cmp ghosty, 5
        jz continuee211
        jnz cont211
        continuee211:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop211:
                mov al, [esi]
                cmp ghostx, al
                je end1
                inc esi
            loop checkloop211

         cont211:
            cmp ghosty, 12            
            jz continue212
            jnz cont212

            continue212:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop212:
                    mov al, [edi]
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop212
            
            cont212:
                cmp ghosty, 19
                jz continue213
                jnz cont213

             continue213:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop213:
                    mov al, [esi]
                    cmp ghostx, al
                    je end1
                    inc esi
                loop checkloop213

            cont213:
                cmp ghosty, 26
                jz continue214
                jnz vchecky

            continue214:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop214:
                    mov al, [edi]
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop214
            
            vchecky:
                cmp ghostx, 5
                jz continuee215
                jnz cont216

                continuee215:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check215:
                        mov al, [edi]
                        add al, 1
                        cmp ghosty, al
                        je end1
                        inc edi
                    loop check215

                cont216:
                    cmp ghostx, 110
                    jz continue217
                    jnz continueee211

                    continue217:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check216:
                            mov al, [edi]
                            add al, 1
                            cmp ghosty, al
                            je end1
                            inc edi
                        loop check216

                    continueee211:
                        cmp ghostx, 60
                        jz continue1417
                        jnz continueee1411

                        continue1417:
                            mov edi, offset wallarrx1
                            mov ecx, 20
                            chec3k:
                                mov al, [edi]
                                cmp ghosty, al
                                jz end1
                                inc edi
                            loop chec3k


        continueee1411:
           cmp ghosty, 2 
           jle end1
           dec ghosty
     ;      dec ghosty
           ret
    
    movedown:
        cmp ghosty, 3
        jz continuee311
        jnz cont311
        continuee311:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop311:
                mov al, [esi]
                cmp ghostx, al
                je end1
                inc esi
            loop checkloop311

         cont311:
            cmp ghosty, 10           
            jz continue312
            jnz cont312

            continue312:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop312:
                    mov al, [edi]
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop312
            
            cont312:
                cmp ghosty, 17
                jz continue313
                jnz cont313

             continue313:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop313:
                    mov al, [esi]
                    cmp ghostx, al
                    je end1
                    inc esi
                loop checkloop313

            cont313:
                cmp ghosty, 24
                jz continue314
                jnz vcheckyy

            continue314:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop314:
                    mov al, [edi]
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop314
            
            vcheckyy:
                cmp ghostx, 5
                jz continuee315
                jnz cont316

                continuee315:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check315:
                        mov al, [edi]
                        sub al, 1
                        cmp ghosty, al
                        je end1
                        inc edi
                    loop check315

                cont316:
                    cmp ghostx, 110
                    jz continue317
                    jnz continueee311

                    continue317:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check316:
                            mov al, [edi]
                            sub al, 1
                            cmp ghosty, al
                            je end1
                            inc edi
                        loop check316
                   continueee311:
                   
                        cmp ghostx, 60
                        jz continue2417
                        jnz continueee2411

                        continue2417:
                            mov edi, offset wallarrx1
                            mov ecx, 20
                            chec2k:
                                mov al, [edi]
                                cmp ghosty, al
                                jz end1
                                inc edi
                            loop chec2k



       continueee2411:
            cmp ghosty, 28
            jge end1
            inc ghosty
      ;      inc ghosty
            ret

    moveright:
        cmp ghosty, 4
        jz continuee511
        jnz cont511
        continuee511:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop511:
                mov al, [esi]
                sub al, 1
                cmp ghostx, al
                je end1
                inc esi
            loop checkloop511

         cont511:
            cmp ghosty, 11          
            jz continue512
            jnz cont512

            continue512:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop512:
                    mov al, [edi]
                    sub al, 1
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop512
            
            cont512:
                cmp ghosty, 18
                jz continue513
                jnz cont513

             continue513:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop513:
                    mov al, [esi]
                    sub al, 1
                    cmp ghostx, al
                    je end1
                    inc esi
                loop checkloop513

            cont513:
                cmp ghosty, 25
                jz continue514
                jnz vcheckyyyy

            continue514:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop514:
                    mov al, [edi]
                    sub al, 1
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop514
            
            vcheckyyyy:
                cmp ghostx, 4
                jz continuee515
                jnz cont516

                continuee515:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check515:
                        mov al, [edi]
                        sub al, 1
                        cmp ghosty, al
                        je end1
                        inc edi
                    loop check515

                cont516:
                    cmp ghostx, 109
                    jz continue517
                    jnz continueee511

                    continue517:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check516:
                            mov al, [edi]
                            sub al, 1
                            cmp ghosty, al
                            je end1
                            inc edi
                        loop check516

                continueee511:

                    cmp ghostx, 59
                    jz continue3417
                    jnz continueee3411

                    continue3417:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        chec1k:
                            mov al, [edi]
                            cmp ghosty, al
                            jz end1
                            inc edi
                        loop chec1k

    continueee3411:
        cmp ghostx, 117
        jge end1
        inc ghostx
      ;  inc ghostx
        ret

    moveleft:
        cmp ghosty, 4
        jz continuee411
        jnz cont411
        continuee411:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop411:
                mov al, [esi]
                add al, 1
                cmp ghostx, al
                je end1
                inc esi
            loop checkloop411

         cont411:
            cmp ghosty, 11           
            jz continue412
            jnz cont412

            continue412:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop412:
                    mov al, [edi]
                    add al, 1
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop412
            
            cont412:
                cmp ghosty, 18
                jz continue413
                jnz cont413

             continue413:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop413:
                    mov al, [esi]
                    add al, 1
                    cmp ghostx, al
                    je end1
                    inc esi
                loop checkloop413

            cont413:
                cmp ghosty, 25
                jz continue414
                jnz vcheckyyy

            continue414:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop414:
                    mov al, [edi]
                    add al, 1
                    cmp ghostx, al
                    je end1
                    inc edi
                loop checkloop414
            
            vcheckyyy:
                cmp ghostx, 6
                jz continuee415
                jnz cont416

                continuee415:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check415:
                        mov al, [edi]
                        sub al, 1
                        cmp ghosty, al
                        je end1
                        inc edi
                    loop check415

                cont416:
                    cmp ghostx, 111
                    jz continue417
                    jnz continueee4412

                    continue417:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check416:
                            mov al, [edi]
                            sub al, 1
                            cmp ghosty, al
                            je end1
                            inc edi
                        loop check416

                continueee4412:
                    cmp ghostx, 61
                    jz continue4417
                    jnz continueee411

                    continue4417:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check1:
                            mov al, [edi]
                            cmp ghosty, al
                            jz end1
                            inc edi
                        loop check1

    continueee411:
        cmp ghostx, 2
        jle end1
        dec ghostx
     ;  dec ghostx
        ret

  end1:
    ret

ghostmovement3 endp

ghost1movement PROC
    mov eax, 4
    call randomrange

    cmp eax, 0
    je moveup

    cmp eax, 1
    je movedown

    cmp eax, 2
    je moveright

    cmp eax, 3
    je moveleft


    moveup:
        cmp ghosty1, 5
        jz continuee211
        jnz cont211
        continuee211:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop211:
                mov al, [esi]
                cmp ghostx1, al
                je end1
                inc esi
            loop checkloop211

         cont211:
            cmp ghosty1, 12            
            jz continue212
            jnz cont212

            continue212:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop212:
                    mov al, [edi]
                    cmp ghostx1, al
                    je end1
                    inc edi
                loop checkloop212
            
            cont212:
                cmp ghosty1, 19
                jz continue213
                jnz cont213

             continue213:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop213:
                    mov al, [esi]
                    cmp ghostx1, al
                    je end1
                    inc esi
                loop checkloop213

            cont213:
                cmp ghosty1, 26
                jz continue214
                jnz vchecky

            continue214:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop214:
                    mov al, [edi]
                    cmp ghostx1, al
                    je end1
                    inc edi
                loop checkloop214
            
            vchecky:
                cmp ghostx1, 5
                jz continuee215
                jnz cont216

                continuee215:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check215:
                        mov al, [edi]
                        add al, 1
                        cmp ghosty1, al
                        je end1
                        inc edi
                    loop check215

                cont216:
                    cmp ghostx1, 110
                    jz continue217
                    jnz continueee211

                    continue217:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check216:
                            mov al, [edi]
                            add al, 1
                            cmp ghosty1, al
                            je end1
                            inc edi
                        loop check216

                    continueee211:
                        cmp ghostx1, 60
                        jz continue1417
                        jnz continueee1411

                        continue1417:
                            mov edi, offset wallarrx1
                            mov ecx, 20
                            chec3k:
                                mov al, [edi]
                                cmp ghosty1, al
                                jz end1
                                inc edi
                            loop chec3k


        continueee1411:
           cmp ghosty1, 2 
           jle end1
           dec ghosty1
     ;      dec ghosty1
           ret
    
    movedown:
        cmp ghosty1, 3
        jz continuee311
        jnz cont311
        continuee311:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop311:
                mov al, [esi]
                cmp ghostx1, al
                je end1
                inc esi
            loop checkloop311

         cont311:
            cmp ghosty1, 10           
            jz continue312
            jnz cont312

            continue312:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop312:
                    mov al, [edi]
                    cmp ghostx1, al
                    je end1
                    inc edi
                loop checkloop312
            
            cont312:
                cmp ghosty1, 17
                jz continue313
                jnz cont313

             continue313:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop313:
                    mov al, [esi]
                    cmp ghostx1, al
                    je end1
                    inc esi
                loop checkloop313

            cont313:
                cmp ghosty1, 24
                jz continue314
                jnz vcheckyy

            continue314:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop314:
                    mov al, [edi]
                    cmp ghostx1, al
                    je end1
                    inc edi
                loop checkloop314
            
            vcheckyy:
                cmp ghostx1, 5
                jz continuee315
                jnz cont316

                continuee315:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check315:
                        mov al, [edi]
                        sub al, 1
                        cmp ghosty1, al
                        je end1
                        inc edi
                    loop check315

                cont316:
                    cmp ghostx1, 110
                    jz continue317
                    jnz continueee311

                    continue317:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check316:
                            mov al, [edi]
                            sub al, 1
                            cmp ghosty1, al
                            je end1
                            inc edi
                        loop check316
                   continueee311:
                   
                        cmp ghostx1, 60
                        jz continue2417
                        jnz continueee2411

                        continue2417:
                            mov edi, offset wallarrx1
                            mov ecx, 20
                            chec2k:
                                mov al, [edi]
                                cmp ghosty1, al
                                jz end1
                                inc edi
                            loop chec2k



       continueee2411:
            cmp ghosty1, 28
            jge end1
            inc ghosty1
      ;      inc ghosty1
            ret

    moveright:
        cmp ghosty1, 4
        jz continuee511
        jnz cont511
        continuee511:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop511:
                mov al, [esi]
                sub al, 1
                cmp ghostx1, al
                je end1
                inc esi
            loop checkloop511

         cont511:
            cmp ghosty1, 11          
            jz continue512
            jnz cont512

            continue512:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop512:
                    mov al, [edi]
                    sub al, 1
                    cmp ghostx1, al
                    je end1
                    inc edi
                loop checkloop512
            
            cont512:
                cmp ghosty1, 18
                jz continue513
                jnz cont513

             continue513:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop513:
                    mov al, [esi]
                    sub al, 1
                    cmp ghostx1, al
                    je end1
                    inc esi
                loop checkloop513

            cont513:
                cmp ghosty1, 25
                jz continue514
                jnz vcheckyyyy

            continue514:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop514:
                    mov al, [edi]
                    sub al, 1
                    cmp ghostx1, al
                    je end1
                    inc edi
                loop checkloop514
            
            vcheckyyyy:
                cmp ghostx1, 4
                jz continuee515
                jnz cont516

                continuee515:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check515:
                        mov al, [edi]
                        sub al, 1
                        cmp ghosty1, al
                        je end1
                        inc edi
                    loop check515

                cont516:
                    cmp ghostx1, 109
                    jz continue517
                    jnz continueee511

                    continue517:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check516:
                            mov al, [edi]
                            sub al, 1
                            cmp ghosty1, al
                            je end1
                            inc edi
                        loop check516

                continueee511:

                    cmp ghostx1, 59
                    jz continue3417
                    jnz continueee3411

                    continue3417:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        chec1k:
                            mov al, [edi]
                            cmp ghosty1, al
                            jz end1
                            inc edi
                        loop chec1k

    continueee3411:
        cmp ghostx1, 117
        jge end1
        inc ghostx1
      ;  inc ghostx1
        ret

    moveleft:
        cmp ghosty1, 4
        jz continuee411
        jnz cont411
        continuee411:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop411:
                mov al, [esi]
                add al, 1
                cmp ghostx1, al
                je end1
                inc esi
            loop checkloop411

         cont411:
            cmp ghosty1, 11           
            jz continue412
            jnz cont412

            continue412:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop412:
                    mov al, [edi]
                    add al, 1
                    cmp ghostx1, al
                    je end1
                    inc edi
                loop checkloop412
            
            cont412:
                cmp ghosty1, 18
                jz continue413
                jnz cont413

             continue413:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop413:
                    mov al, [esi]
                    add al, 1
                    cmp ghostx1, al
                    je end1
                    inc esi
                loop checkloop413

            cont413:
                cmp ghosty1, 25
                jz continue414
                jnz vcheckyyy

            continue414:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop414:
                    mov al, [edi]
                    add al, 1
                    cmp ghostx1, al
                    je end1
                    inc edi
                loop checkloop414
            
            vcheckyyy:
                cmp ghostx1, 6
                jz continuee415
                jnz cont416

                continuee415:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check415:
                        mov al, [edi]
                        sub al, 1
                        cmp ghosty1, al
                        je end1
                        inc edi
                    loop check415

                cont416:
                    cmp ghostx1, 111
                    jz continue417
                    jnz continueee4412

                    continue417:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check416:
                            mov al, [edi]
                            sub al, 1
                            cmp ghosty1, al
                            je end1
                            inc edi
                        loop check416

                continueee4412:
                    cmp ghostx1, 61
                    jz continue4417
                    jnz continueee411

                    continue4417:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check1:
                            mov al, [edi]
                            cmp ghosty1, al
                            jz end1
                            inc edi
                        loop check1

    continueee411:
        cmp ghostx1, 2
        jle end1
        dec ghostx1
     ;  dec ghostx1
        ret

  end1:
    ret

ghost1movement endp

ghost2movement PROC

    mov eax, 4
    call randomrange

    cmp eax, 0
    je moveup

    cmp eax, 1
    je movedown

    cmp eax, 2
    je moveright

    cmp eax, 3
    je moveleft


    moveup:
        cmp ghosty2, 5
        jz continuee211
        jnz cont211
        continuee211:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop211:
                mov al, [esi]
                cmp ghostx2, al
                je end1
                inc esi
            loop checkloop211

         cont211:
            cmp ghosty2, 12            
            jz continue212
            jnz cont212

            continue212:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop212:
                    mov al, [edi]
                    cmp ghostx2, al
                    je end1
                    inc edi
                loop checkloop212
            
            cont212:
                cmp ghosty2, 19
                jz continue213
                jnz cont213

             continue213:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop213:
                    mov al, [esi]
                    cmp ghostx2, al
                    je end1
                    inc esi
                loop checkloop213

            cont213:
                cmp ghosty2, 26
                jz continue214
                jnz vchecky

            continue214:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop214:
                    mov al, [edi]
                    cmp ghostx2, al
                    je end1
                    inc edi
                loop checkloop214
            
            vchecky:
                cmp ghostx2, 5
                jz continuee215
                jnz cont216

                continuee215:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check215:
                        mov al, [edi]
                        add al, 1
                        cmp ghosty2, al
                        je end1
                        inc edi
                    loop check215

                cont216:
                    cmp ghostx2, 110
                    jz continue217
                    jnz continueee211

                    continue217:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check216:
                            mov al, [edi]
                            add al, 1
                            cmp ghosty2, al
                            je end1
                            inc edi
                        loop check216

                    continueee211:
                        cmp ghostx2, 60
                        jz continue1417
                        jnz continueee1411

                        continue1417:
                            mov edi, offset wallarrx1
                            mov ecx, 20
                            chec3k:
                                mov al, [edi]
                                cmp ghosty2, al
                                jz end1
                                inc edi
                            loop chec3k


        continueee1411:
           cmp ghosty2, 2 
           jle end1
           dec ghosty2
     ;      dec ghosty2
           ret
    
    movedown:
        cmp ghosty2, 3
        jz continuee311
        jnz cont311
        continuee311:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop311:
                mov al, [esi]
                cmp ghostx2, al
                je end1
                inc esi
            loop checkloop311

         cont311:
            cmp ghosty2, 10           
            jz continue312
            jnz cont312

            continue312:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop312:
                    mov al, [edi]
                    cmp ghostx2, al
                    je end1
                    inc edi
                loop checkloop312
            
            cont312:
                cmp ghosty2, 17
                jz continue313
                jnz cont313

             continue313:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop313:
                    mov al, [esi]
                    cmp ghostx2, al
                    je end1
                    inc esi
                loop checkloop313

            cont313:
                cmp ghosty2, 24
                jz continue314
                jnz vcheckyy

            continue314:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop314:
                    mov al, [edi]
                    cmp ghostx2, al
                    je end1
                    inc edi
                loop checkloop314
            
            vcheckyy:
                cmp ghostx2, 5
                jz continuee315
                jnz cont316

                continuee315:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check315:
                        mov al, [edi]
                        sub al, 1
                        cmp ghosty2, al
                        je end1
                        inc edi
                    loop check315

                cont316:
                    cmp ghostx2, 110
                    jz continue317
                    jnz continueee311

                    continue317:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check316:
                            mov al, [edi]
                            sub al, 1
                            cmp ghosty2, al
                            je end1
                            inc edi
                        loop check316
                   continueee311:
                   
                        cmp ghostx2, 60
                        jz continue2417
                        jnz continueee2411

                        continue2417:
                            mov edi, offset wallarrx1
                            mov ecx, 20
                            chec2k:
                                mov al, [edi]
                                cmp ghosty2, al
                                jz end1
                                inc edi
                            loop chec2k



       continueee2411:
            cmp ghosty2, 28
            jge end1
            inc ghosty2
      ;      inc ghosty2
            ret

    moveright:
        cmp ghosty2, 4
        jz continuee511
        jnz cont511
        continuee511:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop511:
                mov al, [esi]
                sub al, 1
                cmp ghostx2, al
                je end1
                inc esi
            loop checkloop511

         cont511:
            cmp ghosty2, 11          
            jz continue512
            jnz cont512

            continue512:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop512:
                    mov al, [edi]
                    sub al, 1
                    cmp ghostx2, al
                    je end1
                    inc edi
                loop checkloop512
            
            cont512:
                cmp ghosty2, 18
                jz continue513
                jnz cont513

             continue513:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop513:
                    mov al, [esi]
                    sub al, 1
                    cmp ghostx2, al
                    je end1
                    inc esi
                loop checkloop513

            cont513:
                cmp ghosty2, 25
                jz continue514
                jnz vcheckyyyy

            continue514:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop514:
                    mov al, [edi]
                    sub al, 1
                    cmp ghostx2, al
                    je end1
                    inc edi
                loop checkloop514
            
            vcheckyyyy:
                cmp ghostx2, 4
                jz continuee515
                jnz cont516

                continuee515:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check515:
                        mov al, [edi]
                        sub al, 1
                        cmp ghosty2, al
                        je end1
                        inc edi
                    loop check515

                cont516:
                    cmp ghostx2, 109
                    jz continue517
                    jnz continueee511

                    continue517:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check516:
                            mov al, [edi]
                            sub al, 1
                            cmp ghosty2, al
                            je end1
                            inc edi
                        loop check516

                continueee511:

                    cmp ghostx2, 59
                    jz continue3417
                    jnz continueee3411

                    continue3417:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        chec1k:
                            mov al, [edi]
                            cmp ghosty2, al
                            jz end1
                            inc edi
                        loop chec1k

    continueee3411:
        cmp ghostx2, 117
        jge end1
        inc ghostx2
      ;  inc ghostx2
        ret

    moveleft:
        cmp ghosty2, 4
        jz continuee411
        jnz cont411
        continuee411:
            mov esi, offset wallarrx
            mov ecx, 40
            checkloop411:
                mov al, [esi]
                add al, 1
                cmp ghostx2, al
                je end1
                inc esi
            loop checkloop411

         cont411:
            cmp ghosty2, 11           
            jz continue412
            jnz cont412

            continue412:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop412:
                    mov al, [edi]
                    add al, 1
                    cmp ghostx2, al
                    je end1
                    inc edi
                loop checkloop412
            
            cont412:
                cmp ghosty2, 18
                jz continue413
                jnz cont413

             continue413:
                mov esi, offset wallarrx
                mov ecx, 40
                checkloop413:
                    mov al, [esi]
                    add al, 1
                    cmp ghostx2, al
                    je end1
                    inc esi
                loop checkloop413

            cont413:
                cmp ghosty2, 25
                jz continue414
                jnz vcheckyyy

            continue414:
                mov edi, offset wallarrx
                mov ecx, 40
                checkloop414:
                    mov al, [edi]
                    add al, 1
                    cmp ghostx2, al
                    je end1
                    inc edi
                loop checkloop414
            
            vcheckyyy:
                cmp ghostx2, 6
                jz continuee415
                jnz cont416

                continuee415:
                    mov edi, offset wallarrx1
                    mov ecx, 20
                    check415:
                        mov al, [edi]
                        sub al, 1
                        cmp ghosty2, al
                        je end1
                        inc edi
                    loop check415

                cont416:
                    cmp ghostx2, 111
                    jz continue417
                    jnz continueee4412

                    continue417:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check416:
                            mov al, [edi]
                            sub al, 1
                            cmp ghosty2, al
                            je end1
                            inc edi
                        loop check416

                continueee4412:
                    cmp ghostx2, 61
                    jz continue4417
                    jnz continueee411

                    continue4417:
                        mov edi, offset wallarrx1
                        mov ecx, 20
                        check1:
                            mov al, [edi]
                            cmp ghosty2, al
                            jz end1
                            inc edi
                        loop check1

    continueee411:
        cmp ghostx2, 2
        jle end1
        dec ghostx2
     ;  dec ghostx2
        ret

  end1:
    ret

ghost2movement endp

DrawPlayer PROC
    ; draw player at (xPos,yPos):   
    
    mov eax,yellow ;(blue*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"X"
    call WriteChar
    ;call coincollision
    ret 
DrawPlayer ENDP

UpdatePlayer PROC
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdatePlayer ENDP

DrawCoin PROC

    mov eax,yellow ;(red * 16)
    call SetTextColor
    mov dl,[esi]
    mov dh,[edi]
    call Gotoxy
    mov al,"."
    call WriteChar
    ret
DrawCoin ENDP

CreateRandomCoin PROC
    
    mov eax,118
    call RandomRange
    add eax, 1
    
    mov [esi],al

    mov eax,24
    call RandomRange
    add eax, 4

    mov [edi],al

    ret
CreateRandomCoin ENDP

drawfruit PROC
    mov eax, offset yellow
    call settextcolor
    mov fruitx, 40
    mov fruity, 8

    mov dl, fruitx
    mov dh, fruity
    call Gotoxy
    mov al, "@"
    call writechar

    ret

drawfruit endp

drawteleport PROC
    mov eax, blue 
    call settextcolor
    mov dl, teleportx
    mov dh, teleporty
    call Gotoxy
    mov al, 025h
    call writeChar

    ret


drawteleport ENDP

checkteleport PROC
    cmp xpos, 40
    jne skipp
    cmp ypos, 14
    jne skipp

    call UpdatePlayer
    mov xpos, 80
    mov ypos, 8
    call DrawPlayer

    ret

    skipp:
        cmp xpos, 80
        jne skippp
        cmp ypos, 8
        jne skippp

        call UpdatePlayer
        mov xpos, 40
        mov ypos, 14
        call DrawPlayer

    skippp:
        ret


checkteleport endp

checkforlevel2 PROC

    mov al, score
    inc al
    cmp score, 5
    je level2

    ret

    level2:
        mov bl, 1
        mov level2flag, 1
        
        ;jmp gameloop
        
    ret

checkforlevel2 endp

levelcleared PROC
call clrscr
    mov eax, blue
    call settextcolor

    mov dl, 5
    mov dh, 7
    call Gotoxy
    mov edx, offset levelc
    call writestring
    mov eax, 100
    call Delay

    mov dl, 5
    mov dh, 8
    call Gotoxy
    mov edx, offset levelc1
    call writestring
    mov eax, 100
    call Delay

    mov dl, 5
    mov dh, 9
    call Gotoxy
    mov edx, offset levelc2
    call writestring
    mov eax, 100
    call Delay

    mov dl, 5
    mov dh, 10
    call Gotoxy
    mov edx, offset levelc3
    call writestring
    mov eax, 100
    call Delay

    mov dl, 5
    mov dh, 11
    call Gotoxy
    mov edx, offset levelc4
    call writestring
    mov eax, 100
    call Delay

    mov dl, 5
    mov dh, 12
    call Gotoxy
    mov edx, offset levelc5
    call writestring
    mov eax, 100
    call Delay

    mov dl, 5
    mov dh, 13
    call Gotoxy
    mov edx, offset levelc6
    call writestring
    mov eax, 100
    call Delay

    mov dl, 5
    mov dh, 14
    call Gotoxy
    mov edx, offset levelc7
    call writestring

    mov eax, 3000
    call Delay


    ret

levelcleared endp

youwin1 PROC

call levelcleared

    call clrscr
    mov al, 1
    mov win8, al

    mov eax, blue
    call settextcolor

    mov dl, 25
    mov dh, 5
    call Gotoxy
    mov edx, offset win
    call writestring

    mov dl, 26
    mov dh, 6
    call Gotoxy
    mov edx, offset win1
    call writestring

    mov dl, 27
    mov dh, 7
    call Gotoxy
    mov edx, offset win2
    call writestring

     mov dl, 28
    mov dh, 8
    call Gotoxy
    mov edx, offset win3
    call writestring

     mov dl, 29
    mov dh, 9
    call Gotoxy
    mov edx, offset win4
    call writestring

     mov dl, 29
    mov dh, 10
    call Gotoxy
    mov edx, offset win5
    call writestring

     mov dl, 29
    mov dh, 11
    call Gotoxy
    mov edx, offset win6
    call writestring

    mov dl, 30
    mov dh, 12
    call Gotoxy
    mov edx, offset win7
    call writestring

    mov dl, 40
    mov dh, 15
    call Gotoxy
    mov edx, offset nm1
    call writestring

    
    mov dl, 50
    mov dh, 15
    call Gotoxy
    mov edx, offset inputname
    call writestring

    mov dl, 40
    mov dh, 17
    call Gotoxy
    mov edx,offset strscore
    call writestring

    mov dl, 55
    mov dh, 17
    call Gotoxy
    mov al, score
    call writeint

    mov dl, 40
    mov dh, 20
    call Gotoxy
    mov edx,offset gameover5
    call writestring

    call readchar

    ret
youwin1 endp

END main