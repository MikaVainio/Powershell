# Komentoja Powershell-etähallinan aktivointiin ja asetusten tarkasteluun
# Selvitetään onko Windows Remote Managemet -palvelu käynnissä
$WrmTila = Get-Service winrm
$WrmTila.Status
# Selvitetään nykyiset asetukset, kysely käynnistää palvelun, kun komento annetaan hallittavan koneen konsolilta
$PSRemoteasetukset = Get-PSSessionConfiguration
$PSRemoteasetukset | Out-GridView
# Otetaan PowerShell-etähallinta käyttöön ja tehdään tarvittavat palomuuriasetukset ilman vahvistusta
Enable-PSRemoting -Force
# Otetaan PowerShell-etähallinta käyttöön myös julkisissa verkoissa (LAN) VAARALLINEN asetus
Enable-PSRemoting -SkipNetworkProfileCheck
# PowerShell-etähallinnan käyttöönotto mistä tahansa julkisen verkon IP-osoitteesta (LAN ja WAN)
# Asetus on VAARALLINEN, poista heti käytön jälkeen.
Set-NetFirewallRule -Name "WINRM-HTTP-In-PUBLIC" -RemoteAddress Any
# Kirjautumistietojen välittäminen etäkomennolle
$Käyttäjä = Get-Credential
Get-ADUser -filter * -Credential $Käyttäjä -Server "DC01"
