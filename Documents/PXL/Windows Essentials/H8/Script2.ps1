Clear-Host
[int]$num1 = Read-Host "Vul het eerste getal in: "
[int]$num2 = Read-Host "Vul het tweede getal in: "
if ($num1 -gt $num2)
{Write-Host "Het grootste getal is $num1"}
elseif ($num1 -eq $num2)
{Write-Host "De getallen zijn gelijk"}
else
{Write-Host "Het kleinste getal is $num1"}

Remove-Variable -Name num?
Get-Variable -Name num?