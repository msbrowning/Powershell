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
        [Parameter(
            Mandatory=$true,
            Position=0,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(1,15)]
        [Alias('HostName')]
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
        try {
            # -ErrorAction Stop -ErrorVariable CurrentError
        }
        catch {
            Write-Warning -Message "An error was encountered with $C"
            if ($ErrorLog) {
                #TODO change to write-eventlog to record time savings
                # Idea based from https://channel9.msdn.com/series/advpowershell3/07
                Get-Date | Out-File $LogFile -Force
                $C | Out-File $LogFile -Append
                $CurrentError | Out-File $LogFile -Append
            }
        }
        finally {
            
        }
    }
    
    end {
    }
}