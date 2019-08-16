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
    General notes
#>
function Get-CompInfo {
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
        [string[]]
        $ComputerName,
        # Switch to enable Error logging
        [Parameter()]
        [switch]
        $ErrorLog,
        # Error log file location
        [Parameter()]
        [string]
        $LogFile = 'C:\errorlog.txt'
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
        foreach ($C in $ComputerName) {
            $GPU=Get-WmiObject -Class win32_product
            $Prop=[ordered]@{
                'ComputerName'=$C
                'Video Card'=$GPU.Name
                'Manufacturer'=$GPU.Vendor
            }
            $obj=New-Object -TypeName psobject -Property $Prop
            Write-Output $obj
        }
    }
    
    end {
    }
}