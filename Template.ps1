<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    Created by: Mark Browning III
#>
function Verb-Noun {
    [CmdletBinding()]
    param (
        # Support for multiple systems
        [Parameter(Mandatory=$true,
        Position=0,
        ValueFromPipelineByPropertyName=$true)]
        [string[]]$ComputerName,
        # Switch to enable Error logging
        [Parameter()]
        [switch]$ErrorLog,
        # Error log file location
        [Parameter()]
        [string]$LogFile = 'C:\errorlog.txt'
    )
    
    begin {
        if ($ErrorLog) {
            Write-Verbose 'Error logging is on'
        } else {
            Write-Verbose 'Error logging is off'
        }
        foreach ($Computer in $ComputerName) {
            Write-Verbose "Computer: $Computer"
        }
    }
    
    process {
    }
    
    end {
    }
}