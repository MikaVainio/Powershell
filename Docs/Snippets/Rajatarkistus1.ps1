$Parametri1 = 44
# Tarkistetaan, onko parametrin arvo välillä 10 - 50
if($Parametri1 -ge 10 -and $Parametri1 -le 50)
{
    Write-Warning "parametrin arvo on oikealla alueella"
}
else
{
    Write-Error "parametrin arvo on sallitujen rajojen ulkopuolella"
}