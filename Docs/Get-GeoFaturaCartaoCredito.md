---
external help file: GeoFinanceiroUtils-help.xml
Module Name: GeoFinanceiroUtils
online version:
schema: 2.0.0
---

# Get-GeoFaturaCartaoCredito

## SYNOPSIS
Consulta informações na fatura do cartao de credito

## SYNTAX

```
Get-GeoFaturaCartaoCredito [-FilePath] <String> [-Filter] <String[]> [-SomaTotal] [<CommonParameters>]
```

## DESCRIPTION
Esse comando busca informações na fatura do cartão de credito.
As informações são consultadas
em um arquivo de texto contendo as operações do cartão de crédito em um mês específico.
O usuário deverá informar o caminho do arquivo texto bem como uma categoria de gastos que deseja
agrupar.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-GeoFaturaCartaoCredito -FilePath C:\Downloads\fatura.txt -Filter 'UBER'
Esse exemplo irá buscar no arquivo fatura.txt os gastos da categoria UBER
```

### EXAMPLE 2
```powershell
Get-GeoFaturaCartaoCredito -FilePath C:\Downloads\fatura.txt -Filter "UBER","MATEUS","IFOOD"
```
Esse exemplo irá buscar no arquivo fatura .txt os gastos da categoria UBER,MATEUS e IFOOD
## PARAMETERS

### -FilePath
O caminho do arquivo texto onde encontra-se as informações de despesas do cartão de crédito

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter
O(s) tipos de gastos a qual deseja-se agrupar

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SomaTotal
{{ Fill SomaTotal Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
