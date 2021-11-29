# Komentosovelma (comandlet), joka selvittää koneen verkkokortin tiedot

# Luokka tulosobjektien malliksi
class NicInfo
{
    [string]$ComputerName
    [string]$NICName
    [string]$AdapterType
    [string]$MACAddress
    [string[]]$IPAddress
    [bool]$DHCPEnabled
    [uint64]$Speed
}



# Esittelyfunktio, jossa määritellään komentosovelman parametrit
Function Get-EthernetNIC # Esittelyfunktio 
{
[CmdletBinding()] # Laajennettuparametrimäärittely 
Param
    (
    [Parameter(Mandatory=1, ValueFromPipeline=1, ValueFromPipelineByPropertyName=1)]
    [String[]]$Computername # parametri on määritelty merkkijonovektoriksi
    )
    BEGIN 
    {
        # Työfunktio, jonka avulla tarvittavat tiedot hankitaan
        function ScanNics
        {
            # Työfunktion parametrit
            param([string]$Computer)


            # Tyhjä vektori tuloksia varten
            $NICs = @()

            # Haetaan koneen Ethernet-verkkokortit
            $EthernetCards = Get-WmiObject -Class  Win32_NetworkAdapter -ComputerName $Computer | Where-Object {$_.AdapterType -Match "Ethernet"}

            # Käydään löydetyt verkkokortit yksitellen läpi
            foreach($EthernetCard in $EthernetCards)
            {
                $CardId = $EthernetCard.DeviceID 

                $IPInfo = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object {$_.Index -eq $CardId}


                $NicData = [NicInfo]::new()
                $NicData.NICName = $EthernetCard.Name
                $NicData.AdapterType =$EthernetCard.AdapterType
                $NicData.MACAddress = $EthernetCard.MACAddress
                $NicData.Speed = $EthernetCard.Speed / 1000000
                $NicData.IPAddress = $IPInfo.IPAddress
                $NicData.DHCPEnabled = $IPInfo.DHCPEnabled

                $NICs = $NICs + $NicData
            }
 
            Write-Output $NICs
        }
    
    }

    PROCESS 
    {
    foreach ($Computer in $ComputerName)
        {
        ScanNics -computername $Computer # kutsutaan työfuntiota
        }
    }
    END {}
}
