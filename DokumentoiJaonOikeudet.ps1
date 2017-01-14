# Dokumentoi jaetun resurssin jakotason käyttöoikeudet
$Jako = Read-host "Anna resurssin jakonimi"
$Tiedosto = Read-Host "Anna tallennustiedoston polku ja nimi"
Get-SmbShareAccess -Name $Jako | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto
Write-Warning "$Jako -resurssin oikeudet tallennettu $Tiedosto -tiedostoon"