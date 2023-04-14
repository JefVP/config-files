Clear-Host
[int]$num1 = Read-Host "Vul het eerste getal in: "
[int]$num2 = Read-Host "Vul het tweede getal in: "
Write-Host ""
Write-Host "De som van de getallen is " ($num1+$num2)

if ($num1 -lt $num2)
{[int]$num3 = ($num2-$num1)}
else
{[int]$num3 = ($num1-$num2)}

Write-Host "Het verschil tussen de getallen is " $num3

Remove-Variable -Name num?
Get-Variable -Name num?