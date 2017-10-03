Class UserGroupDocument
 {
    [String]$UserName
    [String]$GroupName
    [String]$Type
    # Muodostin kaikilla parametreilla
    UserGroupDocument ([string]$UserName,$GroupName,$Type)
    {
        # this on viittaus luokasta luotavaan olioon
        $this.UserName = $UserName
        $this.GroupName = $GroupName
        $this.Type = $Type
    }
    # Muodostin kahdella parametrilla
    UserGroupDocument ([string]$UserName,$GroupName)
    {
        $this.UserName = $UserName
        $this.GroupName = $GroupName
    }
 }
$UudetDokumentit = @() # Vektorimuuttuja uusille objekteille
# Luodaan uusi olio kahdella ja kolmella parametrilla ja lisätään vektoriin
$Hakala = [UserGroupDocument]::new("hakamikadm","Domain Admins")
$UudetDokumentit += $Hakala
$Vainio = [UserGroupDocument]::new("mika.vainio","Tietohallinto","User")
$UudetDokumentit += $Vainio
$UudetDokumentit | Out-GridView