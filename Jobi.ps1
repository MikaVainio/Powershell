# Käyttäjien dokumentointi tausta-ajonona
$TaustaAjo = Start-Job -ScriptBlock {Get-ADGroupUserDoc -Path "C:\Users\Administrator\Documents\KäyttäjätTänään.txt"}
