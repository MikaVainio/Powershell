# Ajastettu tausta-ajo
$Käynnistys = New-JobTrigger -Weekly -DaysOfWeek Wednesday -At 14:15
Register-ScheduledJob -Name HaeKoneTilit -Trigger $Käynnistys -ScriptBlock {Get-ADComputer -Filter *}
# Tausta-ajon tilan tarkastus ja työn ID:n selvittäminen
Get-Job
# Tulosten lukeminen ja pitäminen muistissa
$TyöID = 1 # Numero edell. komennon tuloksista
Receive-Job -Id $TyöID -Keep