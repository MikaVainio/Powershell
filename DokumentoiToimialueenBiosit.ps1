# Dokumentoidaan kaikkien koneiden BIOS-versiot
# Tyhä vektori tuloksille
$Output = @()
# Luetaan konetilit muuttujaan 
$Koneet = Get-ADComputer -Filter *
# Käydään konetilit yksitellen läpi
foreach($Kone in $Koneet)
{
    $KoneNimi = $Kone.Name
    $KoneDNSNimi = $Kone.DNSHostName
    $KoneTyyppi = $Kone.ObjectClass

    $KoneBiosTieto = Get-WmiObject -Class Win32_BIOS -ComputerName $KoneNimi
    
        # Määritellään uuden objektin ominaisuudet
        $KoneBIOSValmistaja = $KoneBiosTieto.Manufacturer
        $KoneBIOSVersio = $KoneBiosTieto.SMBIOSBIOSVersion
        $Ominaisuudet = @{"Name" = $KoneNimi ; "DNSHostName" = $KoneDNSNimi`        ;"ObjectClass" = $KoneTyyppi ; "Manufacturer" = $KoneBIOSValmistaja ;`        "SMBIOSVersion" = $KoneBIOSVersio}
        # Luodaan uusi objekti
        $Objekti = New-Object -TypeName PSObject -Property $Ominaisuudet
        # Lisätään objekti vektoriin
        $Output = $Output + $Objekti
    
}
$Output | Write-Output


