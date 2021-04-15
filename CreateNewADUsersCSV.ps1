<#
Create New Active Directory User from CSV file
#>
#Import CSV with new user data
$_ = import-csv -Path "\\server\share\folder\NewUsers.csv" | ForEach-Object
{

        #Define Attributes from CSV 
            
        $GivenName = $_.FirstName
        $Middle = $_.Middle
        $SurName = $_.LastName
        $Division = $_.Division
        $Department = $_.Department
        $JobTitle = $_.JobTitle
        $Manager = $_.Manager
        $Phone = $_.Phone
        #$Name = $SurName + ", " + $GivenName + ", " + $Middle
        $DisplayName = $GivenName + " " + $SurName
        $SAM = $GivenName[0] + $Middle + $SurName
        $Email = $SAM + '@winstonind.com'
        $Proxy = 'SMTP:' + $Email
        $Password = ConvertTo-SecureString -AsPlainText -String "P4ssword" -Force
        $Office = 'Contoso ' + " " + $Division
        $Company = "Contoso"
        $ScriptPath = "script.bat"
        $OU = $_.OU

        #Create New Users

        New-ADUser `
        -Name "$DisplayName" `
        -AccountPassword $Password `
        -Department "$Department" `
        -Enabled $true `
        -GivenName "$GivenName" `
        -Initials "$Middle" `
        -OtherAttributes @{'ProxyAddresses' = "$Proxy"} `
        -SamAccountName "$SAM" `
        -DisplayName "$DisplayName" `
        -Surname "$SurName" `
        -ScriptPath "$ScriptPath" `
        -Path "$OU" `
        -UserPrincipalName "$Email" `
        -Office "$Office" `
        -Company "$Company" `
        -Title "$JobTitle" `
        -EmailAddress "$Email" `
        -OfficePhone "$Phone" `
        -Manager "$Manager"

        # Set new user's password
        
        Set-ADAccountPassword -Identity $SAM -NewPassword $Password -Reset
}