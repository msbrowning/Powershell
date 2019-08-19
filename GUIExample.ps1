<#
 # Example GUI
 # Reference: https://theitbros.com/powershell-gui-for-scripts/
 # Simple tool: https://poshgui.com/Editor
 #>
#TODO: Pasword Expired, Create AD User, Disable AD User, Reset AD password
# Add .Net forms type
Add-Type -assembly System.Windows.Forms

$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='GUI for my PoSh script'
$main_form.Width = 600
$main_form.Height = 400
$main_form.AutoSize = $true
$Label01 = New-Object System.Windows.Forms.Label
$Label01.Text = "AD users"
$Label01.Location  = New-Object System.Drawing.Point(0,10)
$Label01.AutoSize = $true
$main_form.Controls.Add($Label01)
$ComboBox = New-Object System.Windows.Forms.ComboBox
$ComboBox.Width = 300
$Users = get-aduser -Identity "msbrowning" -Properties SamAccountName
Foreach ($User in $Users){
    $ComboBox.Items.Add($User.SamAccountName);
}
$ComboBox.Location  = New-Object System.Drawing.Point(60,10)
$main_form.Controls.Add($ComboBox)
$Label02 = New-Object System.Windows.Forms.Label
$Label02.Text = "Last Password Set:"
$Label02.Location  = New-Object System.Drawing.Point(0,40)
$Label02.AutoSize = $true
$main_form.Controls.Add($Label02)
$Label03 = New-Object System.Windows.Forms.Label
$Label03.Text = ""
$Label03.Location  = New-Object System.Drawing.Point(110,40)
$Label03.AutoSize = $true
$main_form.Controls.Add($Label03)
$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(400,10)
$Button.Size = New-Object System.Drawing.Size(120,23)
$Button.Text = "Check"
$main_form.Controls.Add($Button)
$Button.Add_Click({
    $Label03.Text =  [datetime]::FromFileTime((Get-ADUser -identity $ComboBox.selectedItem -Properties pwdLastSet).pwdLastSet).ToString('MM dd yy : hh ss')
})

$main_form.ShowDialog()