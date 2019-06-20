 # Copy user profile folders from old computer to network location for backup
 # Copy backup to new computer
 #>
# Get computer name
$pcName
# Get username
$userName
# Define destination server
$serverPath
# Backup user files
Copy-Item -Path "\\$pcname\c$\users\$userName\Desktop" -Destination "\\$serverPath\$userName\Desktop"
Copy-Item -Path "\\$pcname\c$\users\$userName\Documents" -Destination "\\$serverPath\$userName\Documents"
Copy-Item -Path "\\$pcname\c$\users\$userName\AppData\Roaming\Microsoft\Signatures" -Destination "\\$serverPath\$userName\Signatures"
# Test if the new computer is online
# If the new computer is online test that the user's profile has been created
# If the user's profile is online copy the backed up user files to the new computer