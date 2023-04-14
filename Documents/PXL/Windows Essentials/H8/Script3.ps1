Clear-Host
[int]$day = [int](Get-Date).DayOfWeek

if ($day -gt 5)
{Write-Host "Het is weekend"}
else
{"Het is geen weekend"}

Remove-Variable -Name day