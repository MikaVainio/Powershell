# Dokumentoidaan Prosessorin perustiedot
$Tiedosto = Read-Host "Anna tiedoston nimi ja polku"
$Prosessori = Get-WmiObject Win32_Processor | Select-Object -Property DeviceID, Manufacturer, Name, NumberOfCores, MaxClockSpeed
$Prosessori | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto
Write-Warning "Prosessoritiedot listattu tiedostoon $Tiedosto"
