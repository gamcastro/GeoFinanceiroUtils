function Get-GeoFaturaCartaoCredito {

    [cmdletBinding()]
    param(
        [Parameter(Mandatory = $True)]       
        [ValidateScript( {(Get-Content -Path $_ | Select-String -Pattern 'SISBB' -SimpleMatch -Quiet) -and (Test-Path -Path $_ -PathType Leaf)},ErrorMessage = "O arquivo não existe ou não é válido")]
        [ValidatePattern("\.txt$",ErrorMessage="Não é um arquivo .txt")]       
        [string]$FilePath,

        [Parameter(Mandatory=$True)]
        [string[]]$Filter,

        [switch]$SomaTotal
    )
    BEGIN {

    }
    PROCESS {
        #busca no arquivo linha por linha o o que foi inserido no parametro $filter (Ex: 'UBER')
        Write-Verbose "Consultando o arquivo $FilePath"
        foreach ($filtro in $Filter) {
            $params = @{'Path' = $FilePath
                'Pattern'      = $filtro
            }

            Write-Verbose "Processando o filtro $filtro"
            $valortotal = 0
            try {
                Select-String  @params |
                ForEach-Object {

                    # Busca a parte do valor na string e troca a virgula pelo ponto
                    $valor = ($_.Line.Substring(62, 7)).Replace(",", ".")
                    $valor_m = $valor -as [decimal]
                    $valortotal = $valortotal + $valor_m
            
                }
                $props = @{'Categoria' = $filtro
                    'Valor Total'      = $valortotal
                }

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