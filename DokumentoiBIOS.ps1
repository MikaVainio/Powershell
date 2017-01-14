# Dokumentoidaan BIOS-tiedot
$Tiedosto = Read-Host "Anna tiedoston nimi ja polku"
$Bios = Get-WmiObject Win32_Bios 
$Bios | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto
Write-Warning "Levytiedot listattu tiedostoon $Tiedosto"