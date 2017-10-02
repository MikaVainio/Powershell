# Sovelluksen omaan lokitiedostoon kirjoittaminen
# Luodaan ISO-aikaleima 
$Aikaleima = Get-Date -Format o
$Selitys = "Käyttäjät Dokumentoitu"
# Luodaan lokimerkinnän rivi `t on sarkaimen (tab) sekvenssimerkintä
$Lokimerkintä = "$Aikaleima `t $Selitys"
# Kirjoitetaan lokiin vanhojen merkintöjen perään
$Lokimerkintä | Out-File C:\Users\Administrator\Documents\AutoDoc.log -Append
