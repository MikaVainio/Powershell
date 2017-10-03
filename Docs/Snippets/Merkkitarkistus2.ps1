[CmdletBinding()]
    param
    (
        [Parameter()]
        [ValidatePattern("^[a-z]+\.[a-z]+@firma.intra$")]
        [string]$Sähköpostiosoite
    )
