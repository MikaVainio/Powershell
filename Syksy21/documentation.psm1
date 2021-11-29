# Komentosovelma (comandlet), joka selvittää koneen verkkokortin tiedot

# Luokka tulosobjektien malliksi
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



# Esittelyfunktio, jossa määritellään komentosovelman parametrit
function Get-EthernetNIC 
{
    [CmdletBinding()] # Laajennettuparametrimäärittely 
    param
    (
        # Parametri on pakollinen ja  se voi saada arvonsa putkittamalla
        [Parameter(Mandatory=1, ValueFromPipeline=1, ValueFromPipelineByPropertyName=1)]
        [String[]]$ComputerName # parametri on määritelty merkkijonovektoriksi -> arvona useita koneita 
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
        foreach ($Machine in $ComputerName)
            {
                ScanNics -ComputerName $Machine # kutsutaan työfuntiota
            }
    }

    # Lohko, joka suoritetaan työfunktion jälkeen
    END 
    {
        Write-Warning "NIC Information scanned"
    }
}

