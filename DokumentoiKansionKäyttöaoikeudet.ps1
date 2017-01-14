# Dokumentoi Kansion käyttöoikeudet CSV-tiedostoon
$Kansio = Read-Host "Anna kansion polku ja nimi"
$Tiedosto = Read-Host "Anna CSV-tiedoston polku ja nimi"
Get-Acl -Path $Kansio | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto
Write-Warning "$Kansio -kansion käyttöoikeudet tallennettu tiedostoon $Tiedosto"