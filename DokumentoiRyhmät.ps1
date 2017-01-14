# Dokumentoi kaikki Ryhmät AD:sta CSV-tiedostoon
$Tiedosto = Read-Host "Anna tiedoston polku ja nimi"
Get-ADGroup -Filter * | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto
Write-Warning "Kaikkien ryhmien tiedot tallennettu tiedostoon $Tiedosto"