# Dokumentoi asennetut ohjelmat csv-tiedostoon
$Tiedosto = Read-Host "Anna tiedoston polku ja nimi"
$Täysilista = Get-WmiObject -Class Win32_Product
$Tuloslista = $Täysilista | Select-Object -Property Vendor, Name, Version, Language
$Tuloslista | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto
# Ilmoitetaan kun kaikki on valmista
Write-Warning "Asennetut ohjelmat listattu tiedostoon $Tiedosto"
