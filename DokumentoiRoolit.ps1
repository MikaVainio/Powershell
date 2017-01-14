# Dokumentoidaan roolit ja ominaisuudet (features)
$Tiedosto = Read-Host "Anna tiedoston nimi ja polku"
$Tuloslista = Get-WindowsFeature | Select-Object -Property DisplayName, Name, FeatureType, InstallState
$Tuloslista | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto
Write-Warning "Asennetut roolit ja ominaisuudet listattu tiedostoon $Tiedosto"