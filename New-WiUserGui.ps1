# button to open CSV
# validate that csv has been opened & saved
# pull info from csv into empty boxes
# drop down to choose OU (alias IE 'Corporate', 'Corporate Kiosk', etc)
# text box for GLPI ticket number
# button to validate information is correct & create AD User
# Send confirmation that AD user has been created into (email or GLPI ticket)


<#
Github project to help??
https://github.com/Average-Bear/Create-NewUserGUI/blob/master/CreateNewUserGUI.ps1
#>
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
function New-WiUserGui {
    [CmdletBinding()]
    param (
        # Support for multiple systems
        [Parameter(Mandatory=$true,
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