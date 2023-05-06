function Get-GeoFaturaCartaoCredito {

    [cmdletBinding()]
    param(
        [Parameter(Mandatory = $True)]       
        [ValidateScript( {(Get-Content -Path $_ | Select-String -Pattern 'SISBB' -SimpleMatch -Quiet) -and (Test-Path -Path $_ -PathType Leaf)},ErrorMessage = "O arquivo não existe ou não é válido")]
        [ValidatePattern("\.txt$",ErrorMessage="Não é um arquivo .txt")]       
        [string]$FilePath,

       
        [string[]]$Filter

        
    )
    BEGIN {

    }
    PROCESS {
        $params = @{'Path' = $FilePath
                    'Pattern' = "^\d{2}\.\d{2}\.\d{4}"
                    'Encoding' = 'utf8'
                    'Raw' = $True}
      
        select-string @params | ForEach-Object {
            $descCompra = $_.Substring(10,34)
             $valorItem = [decimal]::Parse(($_.Substring(62,7)),(Get-Culture))
             $dataDaCompra = [DateTime]::Parse(($_.Substring(0,10)),(Get-Culture))
            $props = @{'ItemCompra' = $descCompra
                        'ValorItem' = $valorItem
                        'DataDaCompra' = $dataDaCompra}
           $obj = New-Object -TypeName psobject -Property $props
           Write-Output $obj
        }
        
           
    }
    END {

    }
}