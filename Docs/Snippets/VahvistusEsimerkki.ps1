# Laajennetun parametrimäärittelyn mukainen toiminnon vahvistus
$Käyttäjä = Read-Host -Prompt "Anna Poistettavan käyttäjän tunnus"
Remove-ADUser -Identity $Käyttäjä -Confirm