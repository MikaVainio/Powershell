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
    # Metodi ominaisuuksien tiedostoon tallentamiseen
    [UserGroupDocument]SaveToFile([String]$Path)
    {
        $Käyttäjä = $this.UserName
        $Ryhmä = $this.GroupName
        $Tyyppi = $this.Type
        $Rivi = "$Käyttäjä `t $Ryhmä `t $Tyyppi"
        Out-File -InputObject $Rivi -FilePath $Path
        return $this
    }
 }
 $NewDoc = [UserGroupDocument]::new("jakke.jayna","Tietohallinto","User")
 $Tiedosto = "C:\Users\Mika\Documents\AutoDoc.txt"
 $NewDoc.SaveToFile($Tiedosto)
 $NewDoc | gm | Out-GridView