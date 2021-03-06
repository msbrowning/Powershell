# Get all documents from a specified path that were created 30 days or more prior to the current date

# Variable assignements 

$location = "\\server\share\folder\"

Get-ChildItem -Path $location -Attributes !Directory |
Where-Object -FilterScript {$_.CreationTime -le (Get-Date).AddDays(-7)} | 
Select-Object -Property Name, LastWriteTime, LastAccessTime |
Format-Table
Move-Item -Path "\\server\share\folder\" -Destination "\\server\share\folder\archive" #Moves the file to the archived folder
