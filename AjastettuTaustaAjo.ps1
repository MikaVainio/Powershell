# Suoritetaan ajastetusti keskiviikkoisin
# klo 19.30 käyttäjien dokumentointi tausta-ajona
$Skriptipolku = "C:\Users\Administrator\Documents\Jobi.ps1"
$PSPolku = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$Toiminto = New-ScheduledTaskAction -Execute $PSPolku -Argument "-NonInteractive -NoLogo -NoProfile -File $Skriptipolku"
$Käynnistys = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Wednesday -At 19:30
$Tehtävä = New-ScheduledTask -Action $Toiminto -Trigger $Käynnistys -Settings (New-ScheduledTaskSettingsSet)
$Tehtävä | Register-ScheduledTask -TaskName "Ajastettu käyttäjien dokumentointi" -User "Administrator" -Password "Q2werty"
