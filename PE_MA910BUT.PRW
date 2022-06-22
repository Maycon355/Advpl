#Include "Totvs.ch"

/*/{Protheus.doc} MTA910E
// Antes da exclusão da NF
//Ponto de entrada para validação de exclusão de NF saída
@type 		Function 
@author 	Motta
@since 		21/06/2022
@history 	21/06/2022, , Desenvolvimento inicial (acrescentar um LF nas notas do MetaPosto)
/*/
Static cFilAnt  := SUBSTR(cNumEmp,3,LEN(cNumEmp))

User Function MA910BUT()
    Local lRet      := .T.
    Local aArea     := GetArea()
    Local cFunc     := ProcName(4)
    Local nPos      := At("5",cFunc)

    if nPos > 0 .and. (cFilAnt == '01096' .or. cFilAnt == '01087')
        If FindFunction("U_GTFIN028") 
            lRet := U_GTFIN028()
        EndIf
    Endif 
    RestArea(aArea)

Return lRet


