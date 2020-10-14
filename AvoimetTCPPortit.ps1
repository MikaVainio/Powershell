# LISTAA TCP-PORTTEJA KUUNTELEVAT SOVELLUKSET

# Luokka uusien objektien muodostamiseen
Class TCPListener
{
    [uint16] $LocalPort
    [uint32] $ProcessId
    [string] $ProcessName
    [string] $UserName

}

# Tyjä vektori tuloksia varten
$OutPut = @()

# Haetaan kuuntelevat TCP-portit
$ListenerCollection = Get-NetTCPConnection -State Listen

# Käydään kuuntelevat portit yksitellen läpi ja luodaan uudet objektit
foreach($Listener in $ListenerCollection)
{
    [TCPListener] $tcpListener = [TCPListener]::new()
    $tcpListener.LocalPort = $Listener.LocalPort
    $tcpListener.ProcessId = $Listener.OwningProcess

    #Haetaan prosessitiedot ja tallennetaan ne objktiin
    $ProcessInfo = Get-Process -Id $Listener.OwningProcess -IncludeUserName
    $tcpListener.ProcessName = $ProcessInfo.Name
    $tcpListener.UserName = $ProcessInfo.UserName

    # Lisätään objekti vektoriin
    $OutPut += $tcpListener
}   

$OutPut | Out-GridView
