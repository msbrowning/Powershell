# Get all documents from a specified path that were created 30 days or more prior to the current date

# Variable assignements 

$location = "\\server\share\folder\"

Get-ChildItem -Path $location -Attributes !Directory |
Where-Object -FilterScript {$_.CreationTime -le (Get-Date).AddDays(-30)} | 
Select-Object -Property Name, LastWriteTime, LastAccessTime |
Format-Table