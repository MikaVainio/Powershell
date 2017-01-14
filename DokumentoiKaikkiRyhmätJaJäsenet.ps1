# Skritpi, jolla dokumentoidaan kaikki ryhmät ja niiden jäsenet
$Tiedosto = Read-Host "Anna tiedoston nimi ja polku"
# Haetaan kaikki AD:n ryhmät
$KaikkiRyhmät = Get-ADGroup -Filter *
# Määritellään vektori tulosobjektin tallentamiseen ja alustetaan se tyhjäksi
$Tulosvektori = @()
# Käydään ryhmät yksitellen läpi: ulompi silmukka
Foreach($Ryhmä in $KaikkiRyhmät)
{
# Haetaan  kaikki ryhmän jäsenobjektit muuttujaan $Jäsenet
$Jäsenet = Get-ADGroupMember -Identity $Ryhmä.SamAccountName
# Käydään kaikki jäsenet yksitellen läpi ja muodostetaan uudet objetit: sisempi silmukka
ForEach($Jäsen in $Jäsenet)
    {
    # Luodaan uusi PSObjekti $Tulosobjekti
    $TulosObjekti = New-Object -TypeName PSObject
    # Lisätään objektiin ominaisuutena Ryhmä ja annetaan sille arvoksi Ryhmäobjektin SamAccountName
    $TulosObjekti | Add-Member -MemberType NoteProperty -Name Ryhmä -Value ($Ryhmä.SamAccountName)
    # Lisätään objektiin ominaisuuksiksi jäsenten tietoja objektimuuttujasta $Jäsen
    $TulosObjekti | Add-Member -MemberType NoteProperty -Name Tunnus -Value ($Jäsen.Name)
    $TulosObjekti | Add-Member -MemberType NoteProperty -Name Tyyppi -Value ($Jäsen.ObjectClass)
    $Tulosvektori += $TulosObjekti # Lisätään tulosobjekti tulosvektoriin
    }
}
$Tulosvektori | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto
Write-Warning "Kaikki ryhmät ja niiden jäsenet dokumentoitu tiedostoon $Tiedosto"
