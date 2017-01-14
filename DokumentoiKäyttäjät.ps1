# Dokumentoi kaikki käyttäjätilit AD:sta CSV-tiedostoon
$Tiedosto = Read-Host "Anna tiedoston polku ja nimi"
Get-ADUser -Filter * | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto
Write-Warning "Kaikkien käyttäjien tiedot tallennettu tiedostoon $Tiedosto"