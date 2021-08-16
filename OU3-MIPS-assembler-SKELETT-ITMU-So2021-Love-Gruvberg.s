##############################################################################
# Kurs: IT - Mojligheter och utmaningar, 1DT110 VT-2021.  
#
# Obligatorisk inlamningsuppgift 3: Assemblerprogrammering i MIPS
#
# Namn:    Love Gruvberg
# Datum:   15/8 2021  
##############################################################################


           .text
        j   main

##############################################################################
# Beskrivning: Ger langden pa en textstrang i antal tecken raknat
#
# INPUT:     $a0 - Adressen till en (vilken som helst) nollterminerad strang
# OUTPUT:    $v0 - Langden (antal tecken) pa strangen, noll exkluderad
#
##############################################################################  
antal_tecken:


### Om du vill, skriv din assemblerkod (instruktioner) efter varje punkt nedan

## Forslag till algoritm:
#   1. Nollstall $v0                       # Kan ju innehalla vad som helst
for_alla_tecken:

	
#   2. Hamta den byte $a0 refererar till   # det vill saga, hamta tecknet
#   3. Ar byten noll? Ga till 7 nedan      # Ar det slut pa strangen?
#   4. Oka $v0 med ett                     # Raknar en bokstav till  
#   5. Oka adressregistret $a0 med ett  # Sa att det refererar till nasta tecken
#   6. Ga till 2 ovan                   # Las in nasta tecken
#   7. Avsluta subrutinen


slut_pa_tecken:
    jr      $ra        # Atervand till anropande kod
    
##############################################################################
# DESCRIPTION: Omvandlar en (OBS: EN! :-) gemen [a-z] (lower case) till 
#              en versal [A-Z] (upper case)
#   
# INPUT:       $a0 - Adressen till ETT tecken 
# OUTPUT:      (Inget)
##############################################################################      
till_versal:

##  Ledtradar:
##  "Avstandet" (vardet) mellan sma (gemener) och stora (versaler) bokstaver
##  ar 32 decimalt (se ASCII-tabellen).
##  Platsen i ASCII-tabellen motsvarar ett heltal

## Forslag till algoritm:
#   1. Hamta den byte ur minnet pa den adress $a0 pekar pa
#      och lagra byten i ett register.
#   2. Om byten ar mindre an XXX (se ASCII-tabellen) ga till 4 
#   3. subtrahera XXX fran innehallet registret 
#   4. Spara registrets som en byte pa den adress $a0 pekar pa.

#### SKRIV DIN ASSEMBLERKOD HAR ####

    jr      $ra         # Atervand till anropande kod

##############################################################################
# Beskrivning:  Beraknar den totala summan av alla element i en heltalsarray
#
# INPUT:        $a0 - Adressen till forsta talet i arrayen
#               $a1 - Antal heltal som finns lagrade i arrayen
#
# OUTPUT:       $v0 - Summan av alla tal i heltalsarrayen
##############################################################################
heltalsarray_summa:  

##  Ledtradar:
##  - Glom inte att nollstalla register som inte har ett kant innehall
##  - Ett heltal motsvarar 4 byte minne. Varje heltal ar alltsa 32 bitar
##  - Vill man multiplicera innehallet i ett register med en jamna tva-
##    potens ar ett vanligt trick (hint) att skifta bitar nagra steg vanster.
##    Exempel (verifiera med penna och papper. sll = Shift Left Logical):
##    sll $t1, $t0, 2     #    $t1 = $t0 * 4
##    sll $t0, $t1, 4     #    $t0 = $t1 * 16
    

## Varje rad nedan motsvarar en assemblerinstruktion.
## i betyder index i arrayen, N ar antalet tal (kom i $a0) och n ar
## det tal som just hamtats. A symboliserar adressen till arrayen
## OBS: Du maste forsta varje instruktion du skriver och
##      forsta hur funktionen du skriver fungerar!

#### SKRIV DIN ASSEMBLERKOD HAR ####

    # Nollstall $v0
    # Nollstall $t0
for_alla_tal:
    # Om $t0 (i) ar lika med $a1 hoppa till tal_slut   # Klart om i == N
    # Multiplicera $t0 med fyra och lagra det i $t1    # Indexadr = i * 4
    # Addera $t1 med $a0 och lagra i $t2               # Adress = $a0 + Indexadr
    # Hamta det tal ur minnet som $t2 pekar pa och lagra i $t3     # n = A[i]
    # Addera $t3 till $v0 (resultatregistret)          # Summa = Summa + n
    # Addera ett till register $t0                     # i = i + 1
    # Hoppa till for_alla_tal
    
tal_slut:
    jr      $ra                   # Atervand till anropande kod






##############################################################################
##############################################################################
##
##    *** Don't change or use ANYTHING below this line. 
##
##    *** Andra eller anvand INGENTING under detta avsnitt    
##  
##############################################################################
##############################################################################

### Data som anvands av huvudprogrammet

    .data
    
ANTAL_TAL:
    .word       11
TAL_ARRAY:
    .word       1, 3, 6, 9, 2, 4, 6, 8, 10, 55, 113
STR_att_omvandla:
    .asciiz "Kissekatten jamar och vill ha kattgodis"

TAL_1_str: 
    .asciiz "Summan av de " 
TAL_2_str:
    .asciiz " heltalen ar " 

STRlen_1_str:
    .asciiz "\n\nAntalet tecken i strangen \""
STRlen_2_str:
    .asciiz "\" ar "
STRlen_3_str:
   .asciiz " stycken.\n\n"

STRupper_1_str:
    .asciiz "Om alla gemener gors till versaler blir strangen: \""
STRupper_2_str:
    .asciiz "\"\n\n"


    .text
    .globl main
##############################################################################
#
# MAIN: Anropar subrutinerna och skriver ut resultaten
#
##############################################################################  
main:
    ##---
    ### heltalsarray_summa
    ##---
    li      $v0, 4
    la      $a0, TAL_1_str
    syscall                            # print string

    lw      $a0, ANTAL_TAL
    li      $v0, 1
    syscall                            # print integer

    li      $v0, 4
    la      $a0, TAL_2_str
    syscall                            # print string
    
    li      $v0, -1
    la      $a0, TAL_ARRAY
    lw      $a1, ANTAL_TAL
    jal     heltalsarray_summa         # run subroutine

    # Print sum
    add     $a0, $v0, $zero
    li      $v0, 1
    syscall                            # print integer (arraysumma)
    

    ##---
    ### antal_tecken 
    ##---
    li      $v0, 4
    la      $a0, STRlen_1_str
    syscall                            # print string

    li      $v0, 4
    la      $a0, STR_att_omvandla
    syscall                            # print string

    li      $v0, 4
    la      $a0, STRlen_2_str
    syscall                            # print string
    
    li      $v0, -2
    la      $a0, STR_att_omvandla
    jal     antal_tecken                # run subroutine

    add     $a0, $v0, $zero
    li      $v0, 1
    syscall                             # print integer (antal tecken)

    li      $v0, 4
    la      $a0, STRlen_3_str
    syscall                            # print string


    ##------
    ### to_upper
    ##-------
    
    li      $v0, 4
    la      $a0, STRupper_1_str
    syscall                            # print string
    
    la    $t9, STR_att_omvandla
repeat_chars:
    lb    $a0, ($t9)
    beq   $a0, $zero, finito_la_musica
    add   $a0, $t9, $zero
    jal   till_versal
    addi  $t9, $t9, 1
    b     repeat_chars
    
finito_la_musica:
    li      $v0, 4
    la      $a0, STR_att_omvandla
    syscall                            # print string
    
    li      $v0, 4
    la      $a0, STRupper_2_str
    syscall                            # print string
    
###--- EXIT
    li		$v0, 10                # MARS / SPIM exit
    syscall
    
#### EOF #####################################################################  

