<# Skripti, joka lukee AD:sta konetilit ja niiden
perusteella hakee jaetut hakemistot (smb share) käyttäen
Windows Management Instrumentation Win32 Share -luokan objekteja
#>

# Määritellään oma luokka dokumentoitavia ominaisuuksia varten
class ComputerShare
{
    # Määritellään luokan kentät (field) -> olion ominaisuudet (property)
    [string] $ComputerNetBiosName
    [string] $ComputerDNSName
    [string] $ComputerSAMName
    [string] $ShareName
    [string] $SharePath

    # Muodostin (constructor) kaikilla parametreilla
    ComputerShare([string] $ComputerNetBiosName, $ComputerDNSName, $ComputerSAMName, $ShareName, $SharePath)
    {
        $this.ComputerNetBiosName = $ComputerNetBiosName
        $this.ComputerDNSName = $ComputerDNSName
        $this.ComputerSAMName = $ComputerSAMName
        $this.ShareName = $ShareName
        $this.SharePath = $SharePath
    }
}

# Luodaan tuloksia varten tyhjä oliovektori
$ComputerShareCollection = @()

# Luetaan AD:n konelista muuttujaan
$ComputerCollection = Get-ADComputer -Filter *

# Käydään koneet yksitellen läpi
foreach( $Computer in $ComputerCollection )
{
    # Tallenetaan koneen jaot muuttujaan WMI-objekteista
    $ShareCollection = Get-WmiObject -class Win32_share -ComputerName $Computer.Name

    # Käydään jaot yksitellen läpi
    foreach( $Share in $ShareCollection)
    {
        # Luodaan uusi objekti ja lisätään se objektivektoriin
        [ComputerShare] $computerShare = [ComputerShare]::new($Computer.Name, $Computer.DNSHostName, $Computer.SamAccountName, $Share.Name, $Share.Path)
        $ComputerShareCollection = $ComputerShareCollection + $computerShare
    }

    
 }

 # Näytetään tulokset taulukkomuodossa
 $ComputerShareCollection | Out-GridView






