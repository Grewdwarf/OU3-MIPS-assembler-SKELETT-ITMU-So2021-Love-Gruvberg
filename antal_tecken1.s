.data	# .data-sektionen. Här under specificerar man programmets data (variabler, strängar och andra värden). 
	# I den här delen specificerar vi endast värdet av en sträng (i raden under).
    strang: .ascii "Mellanslag räknas"	# Direktiv: vald datatyp är ascii. 
    					# ASCII -> "American Standard Code for Information Interchange".
.text	# .text-sektionen. Här under instrueras vad programmet ska göra.

main:	# 'main' huvuddel. Detta är en 'Label:'. 
	# Label är en referens till en 'location' i minnet (memory) varifrån du kan JUMPa från en refererad 
	# kodsnutt (som en address) till en annan namngiven instruktion eller variabel/datavärde.
	# En label är en referens för oss människor, den syns endast i assemblern; dvs. processorn kommer
	# alltså inte att läsa en label (lite på samma sätt som när den skippar exekveringen av #kommentarer!).
    li $t1, 0	# li -> 'load immediate' (en pseudoinstruktion), en operand som registrerar konstanta värden.
    		# Vi laddar in konstanta talet '0' i registret 't(emporary) 1' genom att skriva 'li $t1, 0'.
    la $t0, strang	# la -> 'load adress'..

loop:		# här börjar en loop som heter 'loop'
    lb   $a0,0($t0) 	# lb -> 'load byte'. Laddar t0 (som ju är 'strang')
    beqz $a0,klar	# beqz -> 'Branch if EQual Zero'. Branch-instruktionen förgrenar till en address villkorligt. 
    			# I detta fall är villkoret: 
    				# OM '$a0' är lika med '0', förgrena till 'klar'
    addi $t0,$t0,1	# addi -> 'ADDition Immediate overflow' eller 'ADD Immediate'. 	
    addi $t1,$t1,1		# Lägger till ett 'immediate' värde (konstant) till registret
    j     loop		# j -> 'jump unconditionally' med 'loop' som target. 
    			# Här går alltså loopens gräns.
klar:
    li   $v0,1
    add  $a0, $0,$t1	# add -> 'ADDition with overflow'. Både 'add' och 'addi' kommer att kalla på en exception (undantag) 
    			# om det förekommer ett s.k. overflow. Dvs. då integers (heltal) i MIPS är på 32 bitar, 
    			# görs ett undantag 'om' man överstigit bredden på 4 Byte.
    syscall	# 'syscall' utfärdar ett systemanrop (som anges av värdet i $v0).

    li   $v0,10
    syscall

# Antal tecken i strängen:
	# M	1
	# e	2
	# l	3
	# l	4
	# a	5
	# n	6
	# s	7
	# l	8
	# a	9
	# g	10
	#	11
	# r	12
	# ä	13
	# k	14
	# n	15
	# a	16
	# s	17