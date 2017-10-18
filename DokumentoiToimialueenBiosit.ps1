# Dokumentoidaan kaikkien koneiden BIOS-versiot
# Kohdekoneiden palomuurin pitää sallia WMI-yhteydet
# Ota käyttöön sääntö: Windows Management Instrumentation (WMI-In)
# 
# Tyhjä vektori tuloksille
$Output = @()
# Luetaan konetilit muuttujaan 
$Koneet = Get-ADComputer -Filter *
# Käydään konetilit yksitellen läpi
foreach($Kone in $Koneet)
{
    $KoneNimi = $Kone.Name
    $KoneDNSNimi = $Kone.DNSHostName
    $KoneTyyppi = $Kone.ObjectClass
    # Yritetään muodostaa yhteys koneeseen ja selvittää BIOS-tiedot
    try
    {
        $KoneBiosTieto = Get-WmiObject -Class Win32_BIOS -ComputerName $KoneDNSNimi -ErrorAction Stop
        # Määritellään muuttujien arvot, kun tiedot saadaan
        $KoneBIOSNimi = $KoneBiosTieto.Name
        $KoneBIOSValmistaja = $KoneBiosTieto.Manufacturer
        $KoneBIOSVersio = $KoneBiosTieto.SMBIOSBIOSVersion
        $KoneStatus = "Connected" 
    }
    catch
    {
        # Määritellään muuttujien arvot, kun tietoja ei saada
        Write-Warning "Koneeseen $KoneDNSNimi ei saatu yhteyttä"
        $KoneStatus = "Not connected"
        $KoneBIOSNimi = "NA"
        $KoneBIOSValmistaja = "NA"
        $KoneBIOSVersio = 0
    }
    finally
    {
        # Määritellään uuden objektin ominaisuudet
        $Ominaisuudet = @{"Name" = $KoneNimi ; "DNSHostName" = $KoneDNSNimi`
        ;"ObjectClass" = $KoneTyyppi ; "Manufacturer" = $KoneBIOSValmistaja ;`
        "BIOSName" = $KoneBIOSNimi ; "SMBIOSVersion" = $KoneBIOSVersio; "Status" = $KoneStatus}
        # Luodaan uusi objekti
        $Objekti = New-Object -TypeName PSObject -Property $Ominaisuudet
        # Lisätään objekti tulosvektoriin
        $Output = $Output + $Objekti
    }
}
$Output | Out-GridView

