# Malline komentosovelmalle, joka luo uusia objekteja
# Korvaa <> merkinnän sisällä olevat nimet tai määrittelyt

# Luokkamääritys luotaville uusille objekteille
class <LuokanNimi>
{
    [<tietotyyppi>]$<ominaisuus>
}

# Esittelyfunktio, jossa määritellään komentosovelman parametrit, näkyy ulospäin (public)
function <komento-sovelma> # Nimi muodostetaan sääntöjen mukaan: Verbi-Objekti
{
    [CmdletBinding()] # Laajennettuparametrimäärittely käyttöön 
    param
    (
        # Parametri on pakollinen ja  se voi saada arvonsa putkittamalla
        [Parameter(Mandatory=1, ValueFromPipeline=1, ValueFromPipelineByPropertyName=1)]
        [<Tietotyyppi>]$<parametri> # parametri on määritelty merkkijonovektoriksi -> arvona voi olla useita koneita 
    )

    # Lohko, jossa määritellään ulospäin näkymätön (private) työfunktio
    BEGIN 
    {
        # Työfunktio, jonka avulla tarvittavat tiedot hankitaan
        function <työfunktio>
        {
            # Työfunktion parametrit
            param
            (
                [<Tietotyyppi>]$<parameri>
            )


            # Tyhjä vektori tuloksia varten
            $Output = @()

            # Uuden olion muodostaminen
            $<olio> = <LuokanNimi>::new()
            $<olio>.<ominaisuus> = <arvo>

            # Lisätään objekti vektoriin
            $Output = $Output + $<olio>
            }
 
            # Tulostetaan tiedot
            Write-Output $Output
        }
    
    

    # Lohko, jossa kutsutaan työfunktiota ScanNics esittelyfunktion parametrina annetuissa koneissa
    PROCESS 
    {
        # Luodaan ja käynnistetään ajastinolio käyttöjärjestelmän luokasta
        $Timer =  [system.diagnostics.stopwatch]::StartNew()

        # Käydään parametrina annetut objektit yksitellen läpi
        foreach ($<jäsen> in $<lista>)
            {
                <työfunktio> -<parametri> $<arvo> # kutsutaan työfuntiota
            }
    }

    # Lohko, joka suoritetaan työfunktion jälkeen
    END 
    {
        # Pysäytetään ajastin ja kerrotaan paljonko aikaa skannaukseen meni
        $Timer.Stop()
        $ElapsedTime = $Timer.Elapsed.TotalSeconds
        Write-Warning "<ilmoitus teksti> $ElapsedTime seconds"
    }
}
