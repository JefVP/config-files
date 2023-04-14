Clear-Host
for([int]$counter=5; $counter -gt 0; $counter--)
{
Write-Host "$counter"
Start-Sleep -Seconds 1
}
