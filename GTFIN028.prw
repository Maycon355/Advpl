#INCLUDE 'PROTHEUS.Ch'
#INCLUDE 'TOPCONN.CH'
#include 'TOTVS.CH'
#DEFINE CRLF chr(13) + chr(10)

/*/{Protheus.doc} GTFIN028
// Antes da exclusão da NF
//Ponto de entrada para validação de exclusão de NF saída
@type Function
@author MAYCON MOTTA
@history , MAYCON MOTTA, Desenvolvimento inicial (Regra para validar se a exclusão é do METAPOSTO)
/*/

Static cFilAnt  := SUBSTR(cNumEmp,3,LEN(cNumEmp))

User Function GTFIN028()

Local lRet      := .T.
Local cFunction := FUNNAME()
Local aArea := GetArea()

	if Alltrim(cFunction) == 'MATA910'
		dbSelectArea("SF1")
		dbSetOrder(1)
		DBGOTOP()
		if dbSeek(xFilial("SF1") +SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA+SD1->D1_TIPO)
				Reclock("SF1",.F.)
				SF1->F1_ORIGLAN := 'LF'
				MsUnlock()
				SF1->(DbSkip())
		else 
		lRet            := .F.
		ENDIF
	ENDIF

	if Alltrim(cFunction) == 'MATA920'
		DbSelectArea('SD2')
		SD2->(dbSetOrder(3))
		IF SD2 -> (dbSeek(cFilAnt + SD2->D2_DOC + SD2->D2_SERIE + SD2->D2_CLIENTE + SD2->D2_LOJA + SD2->D2_COD))
				RecLock('SD2', .F.)
				SD2->D2_ORIGLAN := 'LF'
				lRet            := .T.
				SD2->(MsUnlock())
		ELSE
			lRet            := .F.
		endif
	ENDIF
	RestArea(aArea)
return lRet
//D2_FILIAL, D2_COD, D2_LOCAL, D2_NUMSEQ, R_E_C_N_O_, D_E_L_E_T_
