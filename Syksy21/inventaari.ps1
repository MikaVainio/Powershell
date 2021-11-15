# Haetaan ja dokumentoidaan työasemiin asennetut sovellukset

# Määritellään luokka dokumentointia varten

class InstalledApp
{
    [string]$ComputerName 
    [string]$AppName
    [string]$AppVendor
    [string]$AppVersion
    [string]$AppLanguage
}

# Luodaan tyhjä vektori tuloksia varten
$Results = @()

# Kysytään pääkäyttöoikeuden omaavan tunnnuksen tiedot ja tallennettaan ne muuttujaan
$AdminCredentials = Get-Credential

# Haetaan työasemat, jätetään DC-koneet haun ulkopuolelle, koska skripti suoritetaan AD-koneelta
$WSList = Get-ADComputer -Filter * -SearchBase "CN=Computers,DC=firma,DC=intra"

# Käydään työasemat yksitellen läpi
foreach($WS in $WSList)
{
    # Luodaan lista työaseman sovelluksista
    $AppList = Get-WmiObject -Class Win32_product -ComputerName $WS.DNSHostName -Credential $AdminCredentials

    # Haetaan yksittäisen sovelluksen tiedot ja luodaan niiden pohjalta uusi olio
    foreach($App in $AppList)
    {
        # Luodaan uusi olio ja määritellään ominaisuuksien arvot
        $installedApp = [InstalledApp]::new()
        $installedApp.ComputerName = $WS.DNSHostName
        $installedApp.AppName = $App.Name
        $installedApp.AppVendor = $App.Vendor
        $installedApp.AppVersion = $App.Version
        $installedApp.AppLanguage = $App.Language

        # Lisätään olio vektoriin
        $Results = $Results + $installedApp
    }
}

$Results | Out-GridView
