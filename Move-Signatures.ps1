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
function Move-Signatures {
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
        [Alias('Source')]
        [string]$SourceComputerName,
        # Destination computer name
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,15)]
        [Alias('Destination')]
        [string]$NewComputerName,
        # Name of computer user 
        [Parameter(Mandatory=$true)]
        [Alias('User')]
        [string]$UserName,
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
            $SourcePath="\\$SoureComputerName\C$\Users\$UserName\AppData\Roaming\Microsoft\Signatures"
            $NewPath="\\$NewComputerName\C$\Users\$UserName\AppData\Roaming\Microsoft\Signatures"
            Copy-Item $SourcePath -Destination $NewPath -Recurse -Verbose -ErrorAction Stop -ErrorVariable CurrentError
           
        }
        catch {
            Write-Warning -Message "An error was encountered with $Computer"
            if ($ErrorLog) {
                #TODO change to write-eventlog to record time savings
                # Idea based from https://channel9.msdn.com/series/advpowershell3/07
                Get-Date | Out-File $LogFile -Force
                $Computer | Out-File $LogFile -Append
                $CurrentError | Out-File $LogFile -Append
            }
        }
        finally {
            
        }
    }
    
    end {
    }
}