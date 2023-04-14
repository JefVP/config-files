Clear-Host
do
{Write-Host "0. Exit"
Write-Host "1. Datum"
Write-Host "2. Lokale gebruikers"
[int]$choice = Read-Host "Maak een keuze: "
Switch($choice)
{
0
{[int]$result = 0
Write-Host "Exiting."}
1
{[int]$result = 1
Get-Date}
2
{[int]$result = 2
Get-LocalUser}
default
{}
}
}while($result -ne 0)


Remove-Variable -Name choice
Remove-Variable -Name result