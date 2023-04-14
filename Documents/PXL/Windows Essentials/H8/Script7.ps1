clear-host

$cult = New-Object System.Globalization.CultureInfo("fr-FR")


$current = (Get-Date).ToString($cult.DateTimeFormat.FullDateTimePattern, $cult)

Write-Host "$current"