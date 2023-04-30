function Get-GeoFaturaCartaoCredito{
<#
.SYNOPSIS
Consulta informações na fatura do cartao de credito

.DESCRIPTION
Esse comando busca informações na fatura do cartão de credito. As informações são consultadas
em um arquivo de texto contendo as operações do cartão de crédito em um mês específico.
O usuário deverá informar o caminho do arquivo texto bem como uma categoria de gastos que deseja
agrupar.

.PARAMETER FilePath
O caminho do arquivo texto onde encontra-se as informações de despesas do cartão de crédito

.PARAMETER Filter
O(s) tipos de gastos a qual deseja-se agrupar

.EXAMPLE
Get-GeoFaturaCartaoCredito -FilePath C:\Downloads\fatura.txt -Filter 'UBER'
Esse exemplo irá buscar no arquivo fatura.txt os gastos da categoria UBER

.EXAMPLE
Get-GeoFaturaCartaoCredito -FilePath C:\Downloads\fatura.txt -Filter "UBER","MATEUS","IFOOD"
Esse exemplo irá buscar no arquivo fatura .txt os gastos da categoria UBER,MATEUS e IFOOD
#>
    [cmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [ValidateScript({
            if (Test-Path $_){
                $True
            } else {
                Throw "Não existe o aquivo $_"
            }
})]
        [string]$FilePath,

        [Parameter(Mandatory)]
        [string[]]$Filter
    )
    BEGIN{

    }
    PROCESS{
        #busca no arquivo linha por linha o o que foi inserido no parametro $filter (Ex: 'UBER')
        Write-Verbose "Consultando o arquivo $FilePath"
        foreach($filtro in $Filter){
            $params=@{'Path'=$FilePath
            'Pattern'=$filtro}

            Write-Verbose "Processando o filtro $filtro"
            $valortotal = 0
            try{
                Select-String  @params |
            ForEach-Object {

                # Busca a parte do valor na string e troca a virgula pelo ponto
                $valor = ($_.Line.Substring(62,7)).Replace(",",".")
                $valor_m = $valor -as [decimal]
                $valortotal = $valortotal + $valor_m
            
            }
            $props=@{'Categoria' = $filtro
                    'Valor Total' = $valortotal}

            $obj = New-Object -TypeName psobject -Property $props

            Write-Output $obj
            }
            catch {
                Write-Warning "Falha ao ler o arquivo $FilePath"
            }
            
        }
       
    }
    END {

    }
}