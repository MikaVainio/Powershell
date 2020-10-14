# KONEEN KAIKKIEN VERKKOJEN MÄÄRITYS YKSITYISIKSI

Write-Warning "Kaikki aktiiviset verkot muutetaan yksityisiksi"
$Vastaus= Read-Host "Haluatko jatkaa K/E"
if($Vastaus.ToUpper() -eq "K") 
{
   Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private 
} 
else 
{
   Write-Warning "Muutosta ei suoritettu"
}

Get-NetConnectionProfile | Out-GridView