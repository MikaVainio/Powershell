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
        [<Tietotyyppi>]$<ParametrinNimi> # Huom! yleensä vektori, johon voi tallentaa useita arvoja, esim. [string[]]$ComputerName
    )

    # Lohko, jossa määritellään ulospäin näkymätön (private) työfunktio
    BEGIN 
    {
        # Työfunktio, jonka avulla haetaan tarvittavat tiedot ja luodaan uusi objekti
        function <työfunktio>
        {
            # Työfunktion parametrit
            param
            (
                [<Tietotyyppi>]$<ParametrinNimi>
            )

            # Tyhjä vektori tuloksia varten
            $Output = @()

            # Uuden olion muodostaminen
            $<olio> = <LuokanNimi>::new()
            $<olio>.<ominaisuus> = <arvo>

            # Lisätään objekti vektoriin
            $Output = $Output + $<olio>
 
            # Tulostetaan tiedot vektorista konsolille
            Write-Output $Output
        }
   
    # Lohko, jossa kutsutaan työfunktiota esittelyfunktion parametrina annetuissa objekteissa
    PROCESS 
    {
        # Luodaan ja käynnistetään ajastinolio käyttöjärjestelmän luokasta
        $Timer =  [system.diagnostics.stopwatch]::StartNew()

        # Käydään parametrina annetut objektit yksitellen läpi
        foreach ($<jäsen> in $<ParametrinNimi>)
            {
                <työfunktio> -<ParametrinNimi> $<jäsen> # kutsutaan työfuntiota
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
