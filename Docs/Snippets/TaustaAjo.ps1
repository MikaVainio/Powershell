# Määritellään työ suoritettavaksi taustalla
# Taustalla luetaan järjestelmälokin tiedot
$TaustaAjo = Start-Job -ScriptBlock {Get-EventLog -Log system}  
# Kun tausta-ajo on valmis, voidaan tehdä loput toimet
#Valmistuminen selviää tutkimalla State-ominaisuutta
$TaustaAjo.JobStateInfo.State
# Luetaan lokimerkinnät
$Lokitiedot = Receive-Job -Job $TaustaAjo
$Lokitiedot | Out-GridView 
