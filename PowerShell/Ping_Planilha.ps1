#requires -version 2.0 
 
### Configurações ### 
 
#Caminho da Planilha 
$ArquivoXLS = "C:\temp\LISTA.xlsx" 
 
#Nome (Exemplo, Plan1) ou Número da Planilha (começa do 1) 
$Planilha = 1
 
#Primeira Linha que será lida, 2 no caso da primeira linha ser um cabeçalho 
$Linha=2 
 
 
### Inicio do Script ### 
 
$Excel = New-Object -ComObject "Excel.Application" 
$Workbook = $Excel.workbooks.open($ArquivoXLS) 
$Sheet = $Workbook.Worksheets.Item($Planilha) 
 
#Planilha visivel 
$Excel.Visible = $True 
 
 
#Limpa formatação da Linha inicial em diante 
$range = $excel.Range("A2","XFD1048576") 
$range.Interior.ColorIndex = 0 
 
#Apaga valores da Coluna 2 
$range = $excel.Range("B2","B1048576") 
$range.ClearContents() 
 
 
#Lê linha por linha até encontrar uma célula vazia 
while ($Sheet.Cells.Item($Linha,1).Text -ne ""){ 
 
    #Ler os valores da linha atual 
    $Valor_Coluna_1 = $Sheet.Cells.Item($Linha,1).Text 
     
      
    # Agora já tem os valores então use-os ################# 
     
    if(Test-Connection -cn $Valor_Coluna_1 -count 10 -quiet){ 
        $Sheet.Cells.Item($Linha,2) = "LIGADO" 
        $Sheet.Cells.Item($Linha, 1).Interior.ColorIndex = 4 
        $Sheet.Cells.Item($Linha, 2).Interior.ColorIndex = 4 
    }else{ 
        $Sheet.Cells.Item($Linha,2) = "Desligado" 
        $Sheet.Cells.Item($Linha, 1).Interior.ColorIndex = 3 
        $Sheet.Cells.Item($Linha, 2).Interior.ColorIndex = 3 
    } 
 
    #Incrementa $Linha para ler a próxima 
    $Linha+=1 
 
} 
 
 
#Salva alterações 
#$Workbook.Save() 
 
#Se quiser Fechar o arquivo descomente a linha abaixo 
#$Excel.quit()