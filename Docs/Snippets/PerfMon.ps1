# Käytössä olevien laskurien selvittäminen
$Laskurit = Get-Counter -ListSet *
$Laskurit | Out-GridView
# Esimerkki vapaan levytilan laskurin lukemisesta
$VapaaLevytila = Get-Counter -Counter "\LogicalDisk(*)\% Free Space"
# Näytetään mitatut arvot taulukkomuodossa
$VapaaLevytila.CounterSamples | Out-GridView 
