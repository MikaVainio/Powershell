# Esimerkki virheenkäsittelyn perusrutiinista
$Käyttäjä = "olematon"
# Try-lohkoon sijoitetaan toiminto, joka halutaa suorittaa
Try
{
    # Haetaan käyttäjän tiedot, virhetilanteessa lopetaan
    Get-ADUser -Identity $Käyttäjä -ErrorAction Stop
    $Tila = "onnistui"
}
# Catch-lohkoon sijoitetaan virheen tapahduttua suoritettavat toiminnot
Catch
{
    # Tallennetaan komennon virheviesti muuttujaan
    $Virheilmoitus = $_.Exception.Message
    # Annetaan virheilmoitus ja muutetaan teksti punaiseksi
    Write-Error -Message $Virheilmoitus
    $Tila = "epäonnistui"
    Break
}
# Finally lohko suoritetaan molemmissa tapauksissa
Finally
{
    # Kirjoitetaan viesti oranssilla tekstillä
    Write-Warning "Operaatio $Tila"
}
    