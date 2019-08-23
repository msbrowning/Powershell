# Reference: https://www.itprotoday.com/powershell/getting-computer-uptime-using-powershell
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
function Get-ComputerUptime {
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
        foreach ($Computer in $ComputerName){

            Try{
                $cimString = (Get-WmiObject Win32_OperatingSystem -ErrorAction Stop -ErrorVariable CurrentError -ComputerName $computer).LastBootUpTime
                $dateTime = [Management.ManagementDateTimeConverter]::ToDateTime($cimString)
                $timeSpan = (Get-Date) - $dateTime
                Write-Host $computer "uptime is:"
                "{0:00} d {1:00} h {2:00} m {3:00} s" -f $timeSpan.Days,$timeSpan.Hours,$timeSpan.Minutes,$timeSpan.Seconds
            }
            Catch{
                Write-warning "Cannot connect to computer: $Computer"
                If ($ErrorLog){
                    Get-Date | Out-File $LogFile -Force
                    $Computer | Out-File $LogFile -Append
                    $CurrentError | out-file $LogFile -Append
                }
                
            }
        }
    }
    
    end {
    }
}