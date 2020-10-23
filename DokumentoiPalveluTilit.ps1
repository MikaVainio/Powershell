# Dokumentoidaan palveluille luodut tilit (Managed Service Accounts)
$Palvelutilit = Get-ADUser -Filter * -SearchBase "CN=Managed Service Accounts, DC=firma, DC=intra"
$Palvelutilit | Out-GridView
