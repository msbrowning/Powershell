Get-WmiObject -Class win32_product -ComputerName (Read-Host 'Input Computer Name') | Select-Object -Property Name, Vendor  |Sort-Object -Property Name | Format-Table