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
                $os=Get-Wmiobject -ComputerName $Computer -Class Win32_OperatingSystem -ErrorAction Stop -ErrorVariable CurrentError
                $Disk=Get-WmiObject -ComputerName $Computer -class Win32_LogicalDisk -filter "DeviceID='c:'"
                $Bios=Get-WmiObject -ComputerName $Computer -Class Win32_bios 
                $GPU=Get-WmiObject -ComputerName $Computer -Class win32_VideoController

                $Prop=[ordered]@{ #With or without [ordered]
                    'ComputerName'=$Computer;
                    'OS Name'=$os.caption;
                    'OS Build'=$os.buildnumber;
                    'Bios Version'=$Bios.Version;
                    'Video Controller 1'=$GPU[0].Description
                    'Video Controller 2'=$GPU[1].Description
                    'FreeSpace'=$Disk.freespace / 1gb -as [int]
                    'Total Space'=$Disk.Size /  1gb -as [int]
                }
                $Obj=New-Object -TypeName PSObject -Property $Prop 
                Write-Output $Obj
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