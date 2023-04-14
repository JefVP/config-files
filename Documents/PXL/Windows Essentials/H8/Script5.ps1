Clear-Host
[int]$age = Read-Host "Vul je leeftijd in (in jaren): "
Write-Host "0. maanden"
Write-Host "1. dagen"
Write-Host "2. uren"
Write-Host "3. seconden"

[int]$choice = Read-Host "Vul hier uw keuze in: "

Switch ($choice)
{
#maanden
0
{[int]$result = ($age * 12)
"Jouw leeftijd in maanden is $result"}
#dagen
1
{
[int]$result = ($age * 365)
"Jouw leeftijd in dagen is $result"}
#uren
2
{[int]$result = ($age * 8760)
"Jouw leeftijd in uren is $result"}
#seconden
3
{[int]$result = ($age * 31536000)
"Jouw leeftijd in uren is $result"}
default
{Write-Host "Het getal $choice was geen optie."}
}

Remove-Variable -Name age
Remove-Variable -Name choice
Remove-Variable -Name result