# Dokumentoidaan Levyn perustiedot
$Tiedosto = Read-Host "Anna tiedoston nimi ja polku"
$Levy = Get-WmiObject Win32_DiskDrive 
$Levy | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto
Write-Warning "Levytiedot listattu tiedostoon $Tiedosto"