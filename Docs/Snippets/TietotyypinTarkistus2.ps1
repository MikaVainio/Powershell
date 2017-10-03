[CmdletBinding()] # Laajennettuparametrimäärittely 
param
( # parametriluettelon alku
    # Ensimmäinen pakollinen parametri
    [Parameter(Mandatory=1)]
    [String]$Parametri1,# parametri on merkkijono 
    # Toinen pakollinen parametri, ei putkitustukea
    [Parameter(Mandatory=1)]
    [int]$Parametri2 # parametri on kokonaisluku
) # parametriluettelon loppu
