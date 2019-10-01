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
function Get-DirectoryACL {
    [CmdletBinding()]
    param (
        # Root directory to check
        [Parameter(
            Mandatory=$true,
            Position=0,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$RootPath,
        # Result output file
        [Parameter()]
        [string]$OutFile = "$HOME\Documents\share_folder_permission.csv",
        # Header information for the output file
        [Parameter()]
        [string]$Header = "Folder Path,IdentityReference,AccessLevel,IsInherited,InheritanceFlags,PropagationFlags",
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
        Add-Content -Value $Header -Path $OutFile 
    }
    
    process {
        try {
            $Folders = Get-ChildItem $RootPath -recurse -Directory -ErrorAction Inquire -ErrorVariable CurrentError
            foreach ($Folder in $Folders){
                $ACLs = Get-Acl $Folder.fullname | ForEach-Object { $_.Access  }
                Foreach ($ACL in $ACLs){
                    $OutInfo = $Folder.Fullname + "," + $ACL.IdentityReference  + "," + $ACL.FileSystemRights + "," + $ACL.IsInherited + "," + $ACL.InheritanceFlags + "," + $ACL.PropagationFlags
                    Add-Content -Value $OutInfo -Path $OutFile
                }
            }
        }
        catch {
            Write-Warning -Message "An error was encountered with $RootPath"
            if ($ErrorLog) {
                #TODO change to write-eventlog to record time savings
                # Idea based from https://channel9.msdn.com/series/advpowershell3/07
                Get-Date | Out-File $LogFile -Force
                $RootPath | Out-File $LogFile -Append
                $CurrentError | Out-File $LogFile -Append
            }
        }
        finally {
            
        }
    }
    
    end {
    }
}
