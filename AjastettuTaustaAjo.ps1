# Suoritetaan ajastetusti keskiviikkoisin
# klo 19.15 käyttäjien dokumentointi tausta-ajona
$Skriptipolku = "C:\Users\Administrator\Documents\Jobi.ps1"
$PSPolku = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$Työ = New-ScheduledTaskAction -Execute $PSPolku -Argument "-NonInteractive -NoLogo -NoProfile -File $Skriptipolku"
$Käynnistys = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Wednesday -At 19:30
$Homma = New-ScheduledTask -Action $Työ -Trigger $Käynnistys -Settings (New-ScheduledTaskSettingsSet)
$Homma | Register-ScheduledTask -TaskName "Ajastettu käyttäjien dokumentointi" -User "Administrator" -Password "Q2werty"