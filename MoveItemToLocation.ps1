# Get all documents from a specified location and move to a new location

# Variable assignements 

$location = "\\server\share\folder\test"
$newLocation = "\\server\share\folder\test\Archive"

Get-ChildItem -Path $location -Attributes !Directory | 
Move-Item -Destination $newLocation