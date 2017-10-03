$Käyttäjätunnus = "kaaleppi.mähönen"
# Selvitetään onko muuttujassa muita kuin sallittuja merkkejä
if ($Käyttäjätunnus -notmatch "^[a-z0-9_.-]*$")
{
    Write-Warning "Käyttäjätunnuksessa on kiellettyjä merkkejä"
}
else
{
    Write-Warning "Käyttäjätunnus on oikein muodostettu"
}