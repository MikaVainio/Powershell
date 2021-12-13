# MODULI KONE- JA KÄYTTÄJÄTIETOJEN DOKUMENTOINTIIN


# LUOKAT
#------------------------------------------------------------------------------------------------

# Luokka verkkokortin tiedoille
class NicInfo
{
    [string]$Host # Tietokoneen nimi
    [string]$NICName # Verkkokortin nimi
    [string]$AdapterType # Verkkokortin tyyppi
    [string]$MACAddress # Fyysinen osoite
    [string[]]$IPAddress # Looginen osoite
    [bool]$DHCPEnabled # Osoite saatu DHCP-palvelimelta
    [uint64]$Speed # Verkkokortin nopeus Mb/s
}

# Luokka käyttäjä- ja ryhmatiedoille
class GroupAndMember 
{
    [String]$GroupName
    [String]$GroupSamAccountName
    [String]$GroupCategory
    [String]$GroupScope
    [String]$MemberName
    [String]$MemberSamAccountName
    [String]$MemberPrincipalName
    [String]$MemberObjectClass
}

# FUNKTIOT
#------------------------------------------------------------------------------------------------

# 1. Komentosovelma (comandlet), joka selvittää koneen verkkokortin tiedot, käyttää luokkaa NicInfo


# Esittelyfunktio, jossa määritellään komentosovelman parametrit, näkyy ulospäin (public)
function Get-EthernetNIC # Nimi muodostetaan sääntöjen mukaan: Verbi-Objekti
{
    [CmdletBinding()] # Laajennettuparametrimäärittely 
    param
    (
        # Parametri on pakollinen ja  se voi saada arvonsa putkittamalla
        [Parameter(Mandatory=1, ValueFromPipeline=1, ValueFromPipelineByPropertyName=1)]
        [String[]]$ComputerName # parametri on määritelty merkkijonovektoriksi -> arvona voi olla useita koneita 
    )

    # Lohko jossa määritellään ulospäin näkymätön (private) työfunktio
    BEGIN 
    {
        # Työfunktio, jonka avulla tarvittavat tiedot hankitaan
        function ScanNics
        {
            # Työfunktion parametrit
            param([string]$ComputerName)


            # Tyhjä vektori tuloksia varten
            $NICs = @()

            # Haetaan koneen Ethernet-verkkokortit
            $EthernetCards = Get-WmiObject -Class  Win32_NetworkAdapter -ComputerName $ComputerName | Where-Object {$_.AdapterType -Match "Ethernet"}

            # Käydään löydetyt verkkokortit yksitellen läpi
            foreach($EthernetCard in $EthernetCards)
            {
                $CardId = $EthernetCard.DeviceID # Verkkokortin numerotunniste

                # Haetaan verkkokortin IP-asetustiedot
                $IPInfo = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName $ComputerName | Where-Object {$_.Index -eq $CardId}

                # Luodaan uusi NicIfo-objekti ja määritellään sen ominaisuudet
                $NicData = [NicInfo]::new()
                $NicData.Host = $ComputerName
                $NicData.NICName = $EthernetCard.Name
                $NicData.AdapterType =$EthernetCard.AdapterType
                $NicData.MACAddress = $EthernetCard.MACAddress
                $NicData.Speed = $EthernetCard.Speed / 1000000
                $NicData.IPAddress = $IPInfo.IPAddress
                $NicData.DHCPEnabled = $IPInfo.DHCPEnabled

                # Lisätään objekti vektoriin
                $NICs = $NICs + $NicData
            }
 
            # Tulostetaan tiedot
            Write-Output $NICs
        }
    
    }

    # Lohko, jossa kutsutaan työfunktiota ScanNics esittelyfunktion parametrina annetuissa koneissa
    PROCESS 
    {
        # Luodaan ja käynnistetään ajastinolio käyttöjärjestelmän luokasta
        $Timer =  [system.diagnostics.stopwatch]::StartNew()

        # Käydään parametrina annetut koneet yksitellen läpi
        foreach ($Machine in $ComputerName)
            {
                ScanNics -ComputerName $Machine # kutsutaan työfuntiota
            }
    }

    # Lohko, joka suoritetaan työfunktion jälkeen
    END 
    {
        # Pysäytetään ajastin ja kerrotaan paljonko aikaa skannaukseen meni
        $Timer.Stop()
        $ElapsedTime = $Timer.Elapsed.TotalSeconds
        Write-Warning "NIC Information scanned in $ElapsedTime seconds"
    }
}

# 2. Komentosovelma (comandlet), joka selvittää toimialueen ryhmät ja niiden jäsenet

# Esittelyfunktio, jossa määritellään komentosovelman parametrit, näkyy ulospäin (public)
function Get-ADGroupsAndMembers # Nimi muodostetaan sääntöjen mukaan: Verbi-Objekti
{    
    # Lohko, jossa määritellään ulospäin näkymätön (private) työfunktio
    BEGIN 
    {
        # Työfunktio, jonka avulla haetaan tarvittavat tiedot ja luodaan uusi objekti
        function askGroupsAndMembers
        {         
            # Tyhjä vektori tuloksia varten
            $Output = @()

            # Luetaan ryhmät muuttujaan
            $Ryhmät = Get-ADGroup -Filter *

            # Käydään ryhmät yksitellen läpi For Each -silmukassa
            foreach($Ryhmä in $Ryhmät)
            {
                # Luetaan ryhmän jäsentiedot muuttujaan
                $Jäsenet = Get-ADGroupMember -Identity $Ryhmä.SamAccountName

                # Käydään jäsenet yksitellen läpi ja asetetaan ominaisuuksien arvot
                foreach($Jäsen in $Jäsenet)
                {
                    # Luodaan objekti
                    $groupAndMember = [GroupAndMember]::new()

                    # Määritellään objektin ominaisuuksien arvot
                    $groupAndMember.GroupName = $Ryhmä.Name
                    $groupAndMember.GroupSamAccountName = $Ryhmä.SamAccountName
                    $groupAndMember.GroupCategory = $Ryhmä.GroupCategory
                    $groupAndMember.GroupScope = $Ryhmä.GroupScope
                    $groupAndMember.MemberName = $Jäsen.name
                    $groupAndMember.MemberSamAccountName = $Jäsen.SamAccountName
                    $groupAndMember.MemberObjectClass = $Jäsen.objectClass

                    # Jos objektiluokka on user, haetaan UserPrincipalName
                    if($Jäsen.objectClass -eq "user")
                    {
                        $Käyttäjä = Get-ADUser -Identity $Jäsen.SamAccountName
                        $groupAndMember.MemberPrincipalName = $Käyttäjä.UserPrincipalName
                    }

                    # Lisätään olio vektoriin, kun kaikki tapeelliset tiedot on selvitetty
                    $Output = $Output + $groupAndMember
                }

            }

 
            # Tulostetaan tiedot vektorista konsolille
            Write-Output $Output

        } # TYÖFUNKTIO PÄÄTTYY
   
   } # BEGIN PÄÄTTYY

    # Lohko, jossa kutsutaan työfunktiota esittelyfunktion parametrina annetuissa objekteissa
    PROCESS 
    {
        # Luodaan ja käynnistetään ajastinolio käyttöjärjestelmän luokasta
        $Timer =  [system.diagnostics.stopwatch]::StartNew()
        askGroupsAndMembers
        
    } # PROCESS PÄÄTTYY

    # Lohko, joka suoritetaan työfunktion jälkeen
    END 
    {
        # Pysäytetään ajastin ja kerrotaan paljonko aikaa skannaukseen meni
        $Timer.Stop()
        $ElapsedTime = $Timer.Elapsed.TotalSeconds
        Write-Warning "Groups and their members documented in $ElapsedTime seconds"

    } # END PÄÄTTYY

} # ESITTELYFUNKTIO PÄÄTTYY
