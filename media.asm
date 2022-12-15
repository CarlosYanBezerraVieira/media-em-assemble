.code
  
primeira_instrucao:

	LDI ptr1          
	SUB last_char

	JZ entrada_dados

	LDI ptr1           
	ADD video
	INT output 

	MOV 1             
	ADD ptr1
	STA ptr1

	JMP primeira_instrucao

continuar:
	MOV 0
	STA check_have_number

	MOV 1
	ADD grade
	STA grade
	


segunda_instrucao:

	LDI ptr2          
	SUB last_char

	JZ entrada_dados

	LDI ptr2          
	ADD video
	INT output 

	MOV 1             
	ADD ptr2
	STA ptr2

	JMP segunda_instrucao

entrada_dados:
	LDA teclado
    INT input

conversao_entrada:
	
	SUB converter; AC - 4
	STA auxiliar
	JMP check_value	

have_number:
	LDA check_have_number
	SUB one
	JZ entrada_dados

CALL print_linha


print_sucesso:

	LDI ptr3          
	SUB last_char

	JZ verificar_numero_da_questao
	

	LDI ptr3           
	ADD video
	INT output 

	MOV 1             
	ADD ptr3
	STA ptr3

	JMP print_sucesso

verificar_numero_da_questao:
	CALL print_linha
	MOV msg_sucesso
	STA ptr3
	MOV	1
	SUB grade
	JZ continuar
	

print_esperar:

	LDI ptr4          
	SUB last_char

	JZ fazer_calculo
	

	LDI ptr4           
	ADD video
	INT output 

	MOV 1             
	ADD ptr4
	STA ptr4

	JMP print_esperar

fazer_calculo:

	CALL print_linha
	LDA n1
	ADD n2
	SHIFT direita
	STA acumulador

saida_dados:

	LDI ptr5          
	SUB last_char

	JZ mostrar_nota
	

	LDI ptr5           
	ADD video
	INT output 

	MOV 1             
	ADD ptr5
	STA ptr5

	JMP saida_dados

mostrar_nota:
	MOV 10
	SUB acumulador
	JZ	mostrar_10
	MOV 0
	LDA video
	ADD acumulador
	ADD converter
	INT output

	JMP end

mostrar_10:
	MOV 0
	LDA video
	ADD one
	ADD converter
	INT output

	MOV 0
	LDA video
	ADD converter
	INT output
	JMP end

adiciona_10_n1:
	
	MOV 0
	STA check_have_number
	MOV 10
	STA n1
	JMP print_sucesso

adiciona_10_n2:

    MOV 0
	STA check_have_number
	MOV 10
	STA n2
	JMP print_sucesso

check_value:

	LDA auxiliar
	JN have_number
	JZ isZero

	MOV 1
	ADD check_have_number
	STA check_have_number

	
	MOV 2
	SUB check_have_number
	JN have_number

	LDA grade
	SUB one
	JZ n1_recebe

	MOV 2
	SUB grade
	JZ n2_recebe

	JMP have_number

isZero:

	LDA check_have_number
	SUB one
	JZ check_grade

	MOV 1
	ADD check_have_number
	STA check_have_number

	JMP entrada_dados

n1_recebe:
	LDA auxiliar
	ADD n1
	STA n1

	LDA check_have_number
	SUB one
	JZ entrada_dados
	JMP have_number

n2_recebe:
	LDA auxiliar
	ADD n2
	STA n2

	LDA check_have_number
	SUB one
	JZ entrada_dados
	JMP have_number


check_grade:

	
	MOV 2
	SUB grade
	JZ adiciona_10_n2

	MOV 1
	SUB grade
	JZ adiciona_10_n1

	RET

print_linha:

	LDA video
	ADD quebra_linha
	INT output
	RET
	

end:
	INT exit

.data
	;syscall exit

	exit: DD 25

	msg_nota1: INITB "Digite a primeira nota",0
	msg_nota2: INITB "Digite a segunda nota",0
	msg_sucesso: INITB "Nota lida com sucesso",0
	msg_espera: INITB "Calculando...",0
	msg_media: INITB "Media =",0

	last_char:  DD 0

	ptr1:  DD msg_nota1
	ptr2:  DD msg_nota2
	ptr3:  DD msg_sucesso
	ptr4:  DD msg_espera
	ptr5:  DD msg_media

	video: DD 0x000
	output:     DD 21

    teclado: DD 0x100
    input: DD 20

	n1:DD 0
	n2:DD 0
 
    grade: DD 1

	check_have_number: DD 0

    quebra_linha: DD 13
    converter: DD 48

	direita : DD 0

	one: DD 1

	acumulador: DD 0
	auxiliar: DD 0

.stack 1
