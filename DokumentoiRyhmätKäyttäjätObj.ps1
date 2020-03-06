# Määritellään luokka ryhmä-jäsen-olioiden luontia varten
Class UserGroupDoc
{
    # Objektin ominaisuudet (kentät)
    [String] $GroupName
    [String] $FullName
    [String] $LoginName
    [String] $Type

    # Muodostin
    UserGroupDoc ([String] $GroupName, $FullName, $LoginName, $Type)
    {
        $this.GroupName = $GroupName
        $this.FullName = $FullName
        $this.LoginName = $LoginName
        $this.Type = $Type

    }
}

# Vektori tuloksille, tyhjä
$GroupsAndMembers = @()

# Ryhmät muuttujaan
$Groups = Get-ADGroup -filter *

# Käydään ryhmät yksitellen läpi
Foreach($Group in $Groups)
{
    $Members = Get-ADGroupMember -identity $Group.SamAccountName

    # Käydään ryhmän jäsenet yksitellen läpi
    Foreach($Member in $Members)
    {
        # Luodaan uusi objekti ja lisätään se vektoriin
        $GroupsAndMembers += [UserGroupDoc]::New($Group.SamAccountName, $Member.Name, $Member.SamAccountName, $Member.ObjectClass)
    }
}

# Palautetaan objektit vektorista taulukkoon
$GroupsAndMembers | Out-GridView