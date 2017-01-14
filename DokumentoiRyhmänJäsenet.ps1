# Dokumentoi Ryhmän jäsenet AD:sta CSV-tiedostoon
$Ryhmä = Read-Host "Anna käyttäjäryhmän nimi"
$Tiedosto = Read-Host "Anna tiedoston polku ja nimi"
Get-ADGroupMember -Identity $Ryhmä | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto
Write-Warning "$Ryhmä tiedot tallennettu tiedostoon $Tiedosto"