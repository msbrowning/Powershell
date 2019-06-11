#Sync Active Directory
param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [String]$dc
)
Invoke-Command -ComputerName $dc -ScriptBlock {
    Import-Module -Name adsync
    Start-ADSyncSyncCycle -PolicyType Delta
    }