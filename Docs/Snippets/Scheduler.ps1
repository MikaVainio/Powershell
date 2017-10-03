# Ajettavan skriptin nimi ja polku
$Skripti = "C:\Users\vainmik\Documents\DokumentoiMuutokset.ps1"
# PowerShell-ohjelman polku
$PSPolku = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
# Määritellään suoritettava toiminto
$Toiminto = New-ScheduledTaskAction -Execute $PSPolku -Argument "-NonInteractive -NoLogo -NoProfile -File $Skripti"
# Määritellään ajoaikataulu
$Käynnistys = New-ScheduledTaskTrigger -DaysOfWeek Saturday -At "22:00"
# Määritellään uusi työ scheduler-ohjelman työjonoon
$Työ = New-ScheduledTask -Action $Toiminto -Trigger $Käynnistys -Settings (New-ScheduledTaskSettingsSet)
# Rekisteröidään työ scheduler-ohjelmaan
$Työ | Register-ScheduledTask -TaskName "MuutosDokumentointi" -User "mika.vainioadm" -Password "Q2werty" 

