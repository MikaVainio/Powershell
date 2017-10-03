[CmdletBinding()]
    param
    (
        [Parameter(Mandatory = 1)]
        [ValidateRange(0,255)]
        [int]$IPOktetti
    )