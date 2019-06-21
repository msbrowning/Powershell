<#
 # Copy user profile folders from old computer to network location for backup
 # Copy backup to new computer
 #>
# Get computer name
$pcName
# Get username
$userName
# Define destination server
$serverPath
# Define new computer name
$newPCName
# User folders to backup
$folders = (
    "Desktop", "Documents", "AppData\Roaming\Microsoft\Signatures"
)
# Backup user files
<#Copy-Item -Path \\$pcname\c$\Users\$userName\Desktop\* -Destination "\\$serverPath\$userName\Desktop"
Copy-Item -Path "\\$pcname\c$\users\$userName\Documents" -Destination "\\$serverPath\$userName\Documents"
Copy-Item -Path "\\$pcname\c$\users\$userName\AppData\Roaming\Microsoft\Signatures" -Destination "\\$serverPath\$userName\Signatures"
#>
foreach ($folder in $folders) {
    Copy-Item -Path "\\$pcname\c$\users\$userName\$folder" -Destination "\\$serverPath\$userName\$folder"
}
# Test if the new computer is online
$connection = Test-Connection -ComputerName $newPCName -Count 1 -Quiet
if ($connection -eq $true) {
    Write-Host -ForegroundColor Green $newPCName "is online!"
}
else {
    Write-Host -ForegroundColor Red $newPCName "is not online. Please turn on" $newPCName "."
}
# If the new computer is online test that the user's profile has been created
$userSignedIn = Test-Path -Path \\$newPCName\c$\users\$userName
if ($userSignedIn -eq $true) {
    Write-Host -ForegroundColor Green $userName "has signed in!"
}
else {
    Write-Host -ForegroundColor Red $userName "has not signed in. Please sign in" $newPCName "."
}
# If the user's profile is online copy the backed up user files to the new computer