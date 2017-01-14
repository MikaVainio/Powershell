# Dokumentoi kaikki Organisaatioyksiköt AD:sta CSV-tiedostoon
$Tiedosto = Read-Host "Anna tiedoston polku ja nimi"
Get-ADOrganizationalUnit -Filter * | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto
Write-Warning "Kaikkien organisaatioyksiköiden tiedot tallennettu tiedostoon $Tiedosto"