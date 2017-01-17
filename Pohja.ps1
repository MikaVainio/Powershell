function <<Esittelyfunktio>> # Julkinen funktio --> komentosovelma
{ # funktiomääritysten alku
[CmdletBinding()] # Laajennettuparametrimäärittely
param
( # parametriluettelon alku
    [Parameter(Mandatory=1, ValueFromPipeline=1, ValueFromPipelineByPropertyName=1)]
    [String]$Parametri1 # parametri on määritelty merkkijonoksi
) # parametriluettelon loppu
BEGIN # Aloituslohko, jossa työfunktio määritellään
    { # Begin-lohkon alku
        function <<Työfunktio>> # Työfunktion määrittely, yksityinen (private)
        { # työfunktiomääritysten alku
          # Määritellään vektori tulosobjektin tallentamiseen ja alustetaan se tyhjäksi, jos funktio palauttaa useita objekteja
          $Tulosvektori = @()
          #Tehdään jotakin...
          $Tulosvektori += $TulosObjekti # Lisätään tulosobjekti tulosvektoriin
          Write-Output $Tulosvektori # palautetaan työfunktion muodostamat objektit
        } # työfunktiomääritysten loppu
    } # Begin-lohkon loppu

PROCESS # Työlohko, jossa työfunktiota kutsutaan
    { # process-lohkon alku
        # Kutsutaan työfunktiota esitelyfunktion parametreja käyttämällä
      <<Työfunktio>> $Parametri1
    } # process-lohkon loppu

END # Lopetuslohko
    { # end-lohkon alku
      # Virheilmoituksien ja infotekstien näyttäminen
    } # end-lohkon loppu
} # funktiomääritysten loppu
