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
function Move-MyModule {
    [CmdletBinding()]
    param (
        # Support for multiple systems
        [Parameter(
            Mandatory=$true,
            Position=0,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [string[]]$MyModulePath,
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
        foreach ($My in $MyModulePath) {
            Write-Verbose "Module Path: $My"
        }
    }
    
    process {
        try {
            # -ErrorAction Stop -ErrorVariable CurrentError
            foreach ($My in $MyModulePath) {
                Copy-Item -Path $My -Destination '$HOME\Documents\WindowsPowershell\Modules' -ErrorAction Stop -ErrorVariable CurrentError
            }
        }
        catch {
            Write-Warning -Message "An error was encountered with $My"
            if ($ErrorLog) {
                #TODO change to write-eventlog to record time savings
                # Idea based from https://channel9.msdn.com/series/advpowershell3/07
                Get-Date | Out-File $LogFile -Force
                $My | Out-File $LogFile -Append
                $CurrentError | Out-File $LogFile -Append
            }
        }
        finally {
            
        }
    }
    
    end {
    }
}