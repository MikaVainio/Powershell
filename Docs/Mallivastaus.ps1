# Dokumentoidaan kaikkien koneiden asennetut ohjelmat
# Kohdekoneiden palomuurin pitää sallia WMI-yhteydet
# Ota koneiden palomuureissa käyttöön sääntö: Windows Management Instrumentation (WMI-In)

# Kysytään käyttäjältä tallennustiedoston nimi ja polku
$Tiedosto = Read-Host "Anna luotavan CSV-tiedoston polku ja nimi"

# Tyhjä vektori tuloksille ja laskurit läpikäytyjen koneiden määrälle
$Tulosvektori = @()
$Konemäärä = 0 # Kaikken koneiden määrä
$Tavoittamattomia = 0 # Koneiden määrä, joihin ei saatu yhteyttä

# Luetaan konetilit muuttujaan
$Koneet = Get-ADComputer -Filter *

# Käydään konetilit yksitellen läpi
foreach($Kone in $Koneet)
{
    # Tallennetaan koneen NetBIOS-nimi muuttujaan $KoneNimi
    $KoneNimi = $Kone.Name

    # Yritetään muodostaa yhteys koneeseen ja selvittää ohjelmien tiedot
    try
    {
      # Luetaan ohjelmien tiedot koneesta
      $Ohjelmat = Get-WmiObject -Class Win32_Product -ComputerName $KoneNimi -ErrorAction Stop
      # Käydään koneen ohjelmat yksitellen läpi
      ForEach($Ohjelma in $Ohjelmat)
      {
        # Luodaan uusi PSObjekti $Tulosobjekti
        $TulosObjekti = New-Object -TypeName PSObject
        # Lisätään objektiin ominaisuutena KoneNimi
        $TulosObjekti | Add-Member -MemberType NoteProperty -Name Computer -Value $KoneNimi
        # Lisätään objektiin ominaisuuksiksi ohelmien tietoja objektimuuttujasta $Ohjelma
        $TulosObjekti | Add-Member -MemberType NoteProperty -Name Vendor -Value ($Ohjelma.Vendor)
        $TulosObjekti | Add-Member -MemberType NoteProperty -Name Software -Value ($Ohjelma.Name)
        $TulosObjekti | Add-Member -MemberType NoteProperty -Name Version -Value ($Ohjelma.Version)

        # Lisätään tulosobjekti tulosvektoriin
        $Tulosvektori = $Tulosvektori + $TulosObjekti
      } # Sisempi (ohjelmien käsittelyn) silmukka loppuu
    }

    # Vikatilanteessa tehtävät toiminnot
    catch
    {
        # Ilmoitetaan konsolissa, ettei koneeseen saatu yhteyttä
        Write-Warning "Laitteeseen $KoneNimi ei saatu yhteyttä"
        $Tavoittamattomia = $Tavoittamattomia + 1
    }

    # Sekä vika- että normaalitilanteessa suoritettavat toiminnot
    finally
    {
        $Konemäärä = $Konemäärä + 1
    }

} # Ulompi (koneiden käsittelyn) silmukka loppuu

# Putkitetaan vektorin sisältämien objektien ominaisuudet CSV-tiedostoon
$Tulosvektori | Export-Csv -Delimiter ";" -Encoding Unicode $Tiedosto

# Ilmoitetaan tiedot skriptin käyttäjälle
Write-Warning "Asennetut ohjelmat listattu tiedostoon $Tiedosto"
Write-Warning "Käsiteltiin yhteensä $Konemäärä tietokonetta. Yhteyttä ei saatu $Tavoittamattomia koneeseen"
