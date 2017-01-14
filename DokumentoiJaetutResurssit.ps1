# Dokumentoin jaetut resurssit tiedostoon
$Tiedosto = Read-Host "Anna tiedoston polku ja nimi"
Get-SmbShare | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto
Write-Warning "Jaetut resurssit listattu tiedostoon $Tiedosto"