# SKRIPTI KOTIHAKEMISTOJEN LUOMISEEN PALVELIMEN VERKKOJAKOON
# Skriptissä käytetään komentosovelmia ja DLL-kirjastoja, jotka on ladattava erikseen
# Ladattavat komentosovelmat löytyvät osoitteesta https://gallery.technet.microsoft.com/scriptcenter/1abd77a5-9c0b-4a2b-acef-90dbb2b84e85
# Latauksen jälkeen komentosovelmat on purettava ja tallennettava ~\Documents\WindowsPowerShell\Modules\NTFSSecurity -kansioon
# Määritellään muuttuja kotihakemistojen päähakemistolle
$Jako = Read-Host "Anna kotihakemistojen päähakemiston nimi ja polku"
# Luodaan päähakemisto
New-Item -Path $Jako -ItemType directory
# Määritellään muuttuja päähakemiston jakonimelle
$Jakonimi = Read-Host "Anna päähakemiston jakonimi"
# Jaetaan päähekemisto
New-SmbShare -Name $Jakonimi -Path $Jako -FullAccess Everyone
# Haetaan kaikki käyttäjätilit muuttujaan 
$Käyttäjät = Get-ADUser -Filter *
# Käsitellään kaikki käyttäjät silmukassa
foreach($Käyttäjä in $Käyttäjät)
{
    # Luodaan muuttuja $Kansio, joka on sekä käyttäjän että hakmiston nimi
    $Kansio = $Käyttäjä.SamAccountName
    # Luodaan kansio kotihakemistoa varten
    New-Item -Path "$Jako\$Kansio" -ItemType directory
    # Katkaistaan käyttöoikeuksien periytyminen, jotta muiden käyttäjien oikeuksia voidaan poistaa
    Disable-NTFSAccessInheritance -Path "$Jako\$Kansio"
    #Annetaan käyttäjälle täydet oikeudet kansioon
    Add-NTFSAccess -Path "$Jako\$Kansio" -AccessRights FullControl -AccessType Allow -Account $Kansio -AppliesTo ThisFolderSubfoldersAndFiles
    #Poistetaan Users-käyttäjäryhmän periytyneet oletusoikeudet kansioon
    Remove-NTFSAccess -Path "$Jako\$Kansio" -AccessRights Read,ReadAndExecute,ListDirectory,CreateFiles,AppendData,Synchronize -Account Users
    }

# Palautetaan syntyneiden kansioiden käyttöoikeustiedot
# Luodaan tyhjä vektorimuuttuja käyttöoikeuksien näyttämistä varten
$Tulosvektori = @()
# Listataan alihakemistorakenne muuttujaan
$Alihakemistot = Get-ChildItem $Jako -Recurse
foreach($Alihakemisto in $Alihakemistot)
{
    $Polku = $Alihakemisto.FullName
    $Oikeudet = Get-NTFSAccess -Path $Polku
    foreach($Oikeus in $Oikeudet)
    {
    # Luodaan uusi PSObjekti $Tulosobjekti
    $TulosObjekti = New-Object -TypeName PSObject
    # Lisätään objektiin ominaisuutena hakemiston nimi
    $TulosObjekti | Add-Member -MemberType NoteProperty -Name Hakemisto -Value $Polku
    # Lisätään objektiin ominaisuuksiksi jäsenten tietoja objektimuuttujasta $Jäsen
    $TulosObjekti | Add-Member -MemberType NoteProperty -Name Tili -Value $Oikeus.Account
    $TulosObjekti | Add-Member -MemberType NoteProperty -Name Oikeus -Value $Oikeus.AccessRights
    $TulosObjekti | Add-Member -MemberType NoteProperty -Name Peritty -Value $Oikeus.IsInherited
    $TulosObjekti | Add-Member -MemberType NoteProperty -Name Hakemistosta -Value $Oikeus.InheritedFrom
    #Lisätään Tulosobjekti Tulosvektoriin
    $Tulosvektori += $TulosObjekti
    }
}
Write-Output $Tulosvektori | Out-GridView
