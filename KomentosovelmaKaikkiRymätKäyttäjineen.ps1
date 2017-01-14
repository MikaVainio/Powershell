Function Get-ADUserGroupDocument # Julkinen funktio --> komentosovelma
{ # funktiomääritysten alku
[CmdletBinding()] # Laajennettuparametrimäärittely 
param
( # parametriluettelon alku
    # Pakollinen parametri, ei putkituksen tukea, koska vain yksi tiedosto, johon tallennetaan
    [Parameter(Mandatory=1, ValueFromPipeline=0, ValueFromPipelineByPropertyName=0)]
    [String]$Tiedosto # parametri on määritelty merkkijonoksi  
) # parametriluettelon loppu
    BEGIN # Aloituslohko, jossa työfunktio määritellään
    { # Begin-lohkon alku
        function AdkäyttäjäRyhmä # Työfunktion määrittely, yksityinen (private)
        { # työfunktiomääritysten alku
        # Haetaan kaikki AD:n ryhmät
        $KaikkiRyhmät = Get-ADGroup -Filter *
        # Määritellään vektori tulosobjektin tallentamiseen ja alustetaan se tyhjäksi
        $Tulosvektori = @()
        # Käydään ryhmät yksitellen läpi: ulompi silmukka
        foreach($Ryhmä in $KaikkiRyhmät)
            { # ulomman silmukan alku
            # Haetaan  kaikki ryhmän jäsenobjektit muuttujaan $Jäsenet
            $Jäsenet = Get-ADGroupMember -Identity $Ryhmä.SamAccountName
            # Käydään kaikki jäsenet yksitellen läpi ja muodostetaan uudet objetit: sisempi silmukka
            forEach($Jäsen in $Jäsenet)
                { # sisemmän silmukan alku
                # Luodaan uusi PSObjekti $Tulosobjekti
                $TulosObjekti = New-Object -TypeName PSObject
                # Lisätään objektiin ominaisuutena Ryhmä ja annetaan sille arvoksi Ryhmäobjektin SamAccountName
                $TulosObjekti | Add-Member -MemberType NoteProperty -Name Ryhmä -Value $Ryhmä.SamAccountName
                # Lisätään objektiin ominaisuuksiksi jäsenten tietoja objektimuuttujasta $Jäsen
                $TulosObjekti | Add-Member -MemberType NoteProperty -Name Tunnus -Value $Jäsen.Name
                $TulosObjekti | Add-Member -MemberType NoteProperty -Name Tyyppi -Value $Jäsen.ObjectClass
                # Jos jäsen on käyttäjä, lisätään sähköpostiosoite objektiin
                if($Jäsen.ObjectClass -eq "user") # huom. -eq, ei =-merkki
                    {
                        # Haetaan Get-ADUser-komennolla jäsenen s-postiosoite SamAccountName-ominaisuuden avulla 
                        $Käyttäjä = Get-ADUser -Identity $Jäsen.SamAccountName -Properties EmailAddress
                        $Sähköposti = $Käyttäjä.EmailAddress
                    }
                else
                    {
                        $Sähköposti = "N/A" # Muille objektityypeille arvoksi N/A
                    }
                $TulosObjekti | Add-Member -MemberType NoteProperty -Name Sposti -Value $Sähköposti
                $Tulosvektori += $TulosObjekti # Lisätään tulosobjekti tulosvektoriin
                } # sisemmän silmukan loppu
            } # ulomman silmukan loppu
        Write-Output $Tulosvektori # palautetaan työfunktion muodostama objekti
        } # työfunktiomääritysten loppu
    } # Begin-lohkon loppu
    

    PROCESS # Työlohko, jossa työfunktiota kutsutaan
    { # process-lohkon alku
    # Varoitetaan käyttäjää siitä, että toiminto saattaa kestää kauan
    Write-Warning "Käsitellään kaikki ryhmät ja käyttäjät AD:sta, tämä voi kestää jonkin aikaa..."
    # Kutsutaan työfunktiota ja putkitetaan tulos julkisen funktion parametrina annettuun tiedostoon
    AdkäyttäjäRyhmä | Export-Csv $Tiedosto -Encoding Unicode -Delimiter ";"
    } # process-lohkon loppu



    END # Lopetuslohko
    { # end-lohkon alku
    Write-Host "Ryhmäjäsenyydet käsitelty ja tallennettu tiedostoon $Tiedosto"
    } # end-lohkon loppu
} # funktiomääritysten loppu

# Testaus, joka poistetaan tallennettaessa funktiota komentosovelmaksi
Get-ADUserGroupDocument -Tiedosto "C:\Users\Administrator\Documents\ADRDoc.txt"

