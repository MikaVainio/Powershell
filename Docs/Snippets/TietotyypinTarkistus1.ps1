# Esimerkki tietotyypin tarkistuksesta
$Parametri1 = "hippopotamus"
$Parametri2 = 55
# Tarkistetaan onko ensimmäinen parametri merkkijono
if($Parametri1 -is [string])
{
    Write-Warning "tietotyyppi on oikea"
}
else
{
    Write-Error "tietotyyppi on väärä"
}
# Tarkistetaan onko toinen parametri kokonaisluku
if($Parametri2 -is [int])
{
    Write-Warning "tietotyyppi on oikea"
}
else
{
    Write-Error "tietotyyppi on väärä"
}