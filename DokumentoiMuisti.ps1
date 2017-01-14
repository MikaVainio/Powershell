# Dokumentoidaan Muistin perustiedot
$Tiedosto = Read-Host "Anna tiedoston nimi ja polku"
$Muisti = Get-WmiObject Win32_PhysicalMemory | Select-Object -Property Capacity, DataWidth, Speed, BankLabel, PositionInRow 
$Muisti | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto
Write-Warning "Muistitiedot listattu tiedostoon $Tiedosto"