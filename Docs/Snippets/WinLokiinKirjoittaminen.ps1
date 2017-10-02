# Windows-lokien käyttäminen
# Sovelluksen rekisteröiminen Sovelluslokiin
$Sovellus = "AutoDoc"
New-EventLog -LogName Application -Source $Sovellus
# Esimerkki Windows-lokiin kirjoittamisesta
$Sovellus = "AutoDoc"
$Lokiteksti = "Käyttäjät dokumentoitu"
# Kaikki käytetyt parametrit ovat pakollisia EventId max 65535
Write-EventLog -LogName Application -Source $Sovellus -EventId 12345 -Message $Lokiteksti
# Valinnaisista parametreista kannattaa käyttää -EntryType-parmetria kertomaan vakavuusasteesta