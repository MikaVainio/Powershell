Class UserGroupDocument
 {
    [String]$UserName
    [String]$GroupName
    [String]$Type
  }
# Luodaan tyhjä olio (objekti) oletusmuodostimella
$NewUserGroupDoc = [UserGroupDocument]::New()
# Määritellään ominaisuuksien arvot
$NewUserGroupDoc.UserName = "Administrator"
$NewUserGroupDoc.GroupName = "Domain Admins"
$NewUserGroupDoc.Type = "User" 
# Testataan oliota
$NewUserGroupDoc | Out-GridView