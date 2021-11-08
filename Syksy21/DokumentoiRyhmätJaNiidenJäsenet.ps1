# Kerätään kaikki AD:n ryhmät ja niiden jäsenet olioina vektoriin ja tehdään siitä CSV-tiedosto

# Määritellään uusi luokka, johon tallennetaan ryhmän ja jäsenen tiedot

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

# Kysytään käyttäjältä tiedoston nimi ja polku
$Tiedosto = Read-Host -Prompt "Anna tiedostopolku ja nimi"

# Tarkitetaan, onko tiedosto tyhjä, jos on, tallennetaan documents-kansioon nimellä GroupsAndUsers.csv
if($Tiedosto -eq "")
{
    $Tiedosto = $env:USERPROFILE + "\Documents\GroupsAndUsers.csv"
}

# Luodaan tyhjä vektori olioden säilyttämistä varten
$DokumentoidutJäsenet = @()

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
        $DokumentoidutJäsenet = $DokumentoidutJäsenet + $groupAndMember
    }

}

$DokumentoidutJäsenet | Export-Csv -Path $Tiedosto -Delimiter ";" -Encoding Unicode