$CredentialManagementForm = New-Object system.Windows.Forms.Form -Property @{
    Text          = "Credential Management"
    StartPosition = "CenterScreen"
    Size          = @{ Width  = 510
                       Height = 588 }
    Icon          = [System.Drawing.Icon]::ExtractAssociatedIcon("$Dependencies\Images\favicon.ico")
    Font          = New-Object System.Drawing.Font("$Font",11,0,0,0)
    ForeColor     = 'Black'
}

if (-not (Test-Path -Path $script:CredentialManagementPath) ) { New-Item -Path $script:CredentialManagementPath -Type Directory }
if (-not (Test-Path -Path "$script:CredentialManagementPath\Rolled Credentials") ) { New-Item -Path "$script:CredentialManagementPath\Rolled Credentials" -Type Directory }

function Check-RollingAccountPrerequisites {
    $PrerequisitesCheckDomainController = $false
    if ((Test-Path "$script:CredentialManagementPath\Specified Domain Controller.txt")) {
        if ( $script:CredentialManagementActiveDirectoryTextBox.text -ne (Get-Content "$script:CredentialManagementPath\Specified Domain Controller.txt")) {
            if ($script:CredentialManagementActiveDirectoryTextBox.text -eq ''){
                $script:CredentialManagementActiveDirectoryButton.Forecolor = 'Red'
                $script:CredentialManagementActiveDirectoryButton.Text      = "Provide Server Name"
                $PrerequisitesCheckDomainController = $false
            }
            else {
                $script:CredentialManagementActiveDirectoryButton.Forecolor = 'Red'
                $script:CredentialManagementActiveDirectoryButton.Text      = "Click to Save"
                $PrerequisitesCheckDomainController = $false
            }
        }
        else {
            $script:CredentialManagementActiveDirectoryButton.Forecolor = 'Green'
            $script:CredentialManagementActiveDirectoryButton.Text      = "Server Name Saved"
            $PrerequisitesCheckDomainController = $true
        }
        if ( (Get-Content "$script:CredentialManagementPath\Specified Domain Controller.txt").length -eq 0 ) { $PrerequisitesCheckDomainController = $false }
        else { $PrerequisitesCheckDomainController = $true }
    }
    else {
        if ($script:CredentialManagementActiveDirectoryTextBox.text -eq ''){
            $script:CredentialManagementActiveDirectoryButton.Forecolor = 'Red'
            $script:CredentialManagementActiveDirectoryButton.Text      = "Provide Server Name"
            $PrerequisitesCheckDomainController = $false
        }
        else {
            $script:CredentialManagementActiveDirectoryButton.Forecolor = 'Red'
            $script:CredentialManagementActiveDirectoryButton.Text      = "Click to Save"
            $PrerequisitesCheckDomainController = $false
        }
    }


    $PrerequisitesCheckRollingAccount = $false
    if ((Test-Path "$script:CredentialManagementPath\Specified Rolling Account.txt")) {
        if ( $script:CredentialManagementPasswordRollingAccountTextBox.text -ne (Get-Content "$script:CredentialManagementPath\Specified Rolling Account.txt")) {
            if ($script:CredentialManagementPasswordRollingAccountTextBox.text -eq ''){
                $script:CredentialManagementPasswordRollingAccountButton.Forecolor = 'Red'
                $script:CredentialManagementPasswordRollingAccountButton.Text      = "Provide Account Name"
                $PrerequisitesCheckRollingAccount = $false
            }
            else {
                $script:CredentialManagementPasswordRollingAccountButton.Forecolor = 'Red'
                $script:CredentialManagementPasswordRollingAccountButton.Text      = "Click to Save"
                $PrerequisitesCheckRollingAccount = $false
            }
        }
        else {
            $script:CredentialManagementPasswordRollingAccountButton.Forecolor = 'Green'
            $script:CredentialManagementPasswordRollingAccountButton.Text      = "Account Name Saved"
            $PrerequisitesCheckRollingAccount = $true
        }
        if ((Get-Content "$script:CredentialManagementPath\Specified Rolling Account.txt").length -eq 0){ $PrerequisitesCheckRollingAccount = $false }
        else { $PrerequisitesCheckRollingAccount = $true }
    }
    else {
        if ($script:CredentialManagementPasswordRollingAccountTextBox.text -eq ''){
            $script:CredentialManagementPasswordRollingAccountButton.Forecolor = 'Red'
            $script:CredentialManagementPasswordRollingAccountButton.Text      = "Provide Account Name"
            $PrerequisitesCheckRollingAccount = $false
        }
        else {
            $script:CredentialManagementPasswordRollingAccountButton.Forecolor = 'Red'
            $script:CredentialManagementPasswordRollingAccountButton.Text      = "Click to Save"
            $PrerequisitesCheckRollingAccount = $false
        }
    }


    $PrerequisitesCheckDomainName = $false
    if ((Test-Path "$script:CredentialManagementPath\Specified Domain Name.txt")) {
        if ( $script:CredentialManagementPasswordDomainNameTextBox.text -ne (Get-Content "$script:CredentialManagementPath\Specified Domain Name.txt")) {
            if ($script:CredentialManagementPasswordDomainNameTextBox.text -eq ''){
                $script:CredentialManagementPasswordDomainNameButton.Forecolor = 'Red'
                $script:CredentialManagementPasswordDomainNameButton.Text      = "Provide Domain Name"
                $PrerequisitesCheckDomainName = $false
            }
            else {
                $script:CredentialManagementPasswordDomainNameButton.Forecolor = 'Red'
                $script:CredentialManagementPasswordDomainNameButton.Text      = "Click to Save"
                $PrerequisitesCheckDomainName = $false
            }
        }
        else {
            $script:CredentialManagementPasswordDomainNameButton.Forecolor = 'Green'
            $script:CredentialManagementPasswordDomainNameButton.Text      = "Domain Name Saved"
            $PrerequisitesCheckDomainName = $true
        }
        if ( (Get-Content "$script:CredentialManagementPath\Specified Domain Name.txt").length -eq 0 ) { $PrerequisitesCheckDomainName = $false }
        else { $PrerequisitesCheckDomainName = $true }
    }
    else {
        if ($script:CredentialManagementPasswordDomainNameTextBox.text -eq ''){
            $script:CredentialManagementPasswordDomainNameButton.Forecolor = 'Red'
            $script:CredentialManagementPasswordDomainNameButton.Text      = "Provide Domain Name"
            $PrerequisitesCheckDomainName = $false
        }
        else {
            $script:CredentialManagementPasswordDomainNameButton.Forecolor = 'Red'
            $script:CredentialManagementPasswordDomainNameButton.Text      = "Click to Save"
            $PrerequisitesCheckDomainName = $false
        }
    }

    
    $PrerequisitesCheckSelectCredentialRollingAccount = $false
    if ((Test-Path "$script:CredentialManagementPath\Specified Credentials To Roll Credentials.txt")) {
        if ( $CredentialManagementSelectCredentialRollingAccountTextBox.text -ne (Get-Content "$script:CredentialManagementPath\Specified Credentials To Roll Credentials.txt")) {
            if ($CredentialManagementSelectCredentialRollingAccountTextBox.text -eq ''){
                $CredentialManagementSelectCredentialRollingAccountButton.Forecolor = 'Red'
                $CredentialManagementSelectCredentialRollingAccountButton.Text      = "Select Credentials"
                $PrerequisitesCheckSelectCredentialRollingAccount = $false
            }
            else {
                $CredentialManagementSelectCredentialRollingAccountButton.Forecolor = 'Red'
                $CredentialManagementSelectCredentialRollingAccountButton.Text      = "Click to Save"
                $PrerequisitesCheckSelectCredentialRollingAccount = $false
            }
        }
        else {
            $CredentialManagementSelectCredentialRollingAccountButton.Forecolor = 'Green'
            $CredentialManagementSelectCredentialRollingAccountButton.Text      = "Credentials Selected"
            $PrerequisitesCheckSelectCredentialRollingAccount = $true
        }
        if ( (Get-Content "$script:CredentialManagementPath\Specified Credentials To Roll Credentials.txt").length -eq 0 ) { $PrerequisitesCheckSelectCredentialRollingAccount = $false }
        else { $PrerequisitesCheckSelectCredentialRollingAccount = $true }
    }
    else {
        if ($CredentialManagementSelectCredentialRollingAccountTextBox.text -eq ''){
            $CredentialManagementSelectCredentialRollingAccountButton.Forecolor = 'Red'
            $CredentialManagementSelectCredentialRollingAccountButton.Text      = "Select Credentials"
            $PrerequisitesCheckSelectCredentialRollingAccount = $false
        }
        else {
            $CredentialManagementSelectCredentialRollingAccountButton.Forecolor = 'Red'
            $CredentialManagementSelectCredentialRollingAccountButton.Text      = "Click to Save"
            $PrerequisitesCheckSelectCredentialRollingAccount = $false
        }
    }
}  

#---------------------------------------------------
# Credential Management Select Credentials GroupBox
#---------------------------------------------------
$CredentialManagementAvailableCredentialsGroupBox  = New-Object System.Windows.Forms.Groupbox -Property @{
    Text     = "Specify Credentials:"
    Location = @{ X = 10
                  Y = 10 }
    Size     = @{ Width  = 475
                  Height = 178 }
    Font      = New-Object System.Drawing.Font("$Font",12,1,2,1)
    ForeColor = 'Blue'
}

    $CredentialManagementSelectCredentialsLabel = New-Object System.Windows.Forms.Label -Property @{
        Text     = "Select the credentials that PoSh-EasyWin will use while executing queries and for remote access. If no store XML credentials are selected, the credentials used will default to those that launched PoSh-EasyWin."
        Location = @{ X = 5
                      Y = 20 }
        Size     = @{ Width  = 465
                      Height = 44 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Black'
    }
    $CredentialManagementAvailableCredentialsGroupBox.Controls.Add($CredentialManagementSelectCredentialsLabel)


    $CredentialManagementSelectCredentialsTextBox = New-Object System.Windows.Forms.Textbox -Property @{
        Location = @{ X = $CredentialManagementSelectCredentialsLabel.Location.X
                      Y = $CredentialManagementSelectCredentialsLabel.Location.Y + $CredentialManagementSelectCredentialsLabel.Size.Height }
        Size     = @{ Width  = 300
                      Height = 25 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Black'
        BackColor = 'White'
        Enabled   = $false
    }
    $CredentialManagementAvailableCredentialsGroupBox.Controls.Add($CredentialManagementSelectCredentialsTextBox)


    $CredentialManagementSelectCredentialsButton = New-Object System.Windows.Forms.Button -Property @{
        Text     = "Select Credentials"
        Location = @{ X = $CredentialManagementSelectCredentialsTextBox.Location.X + $CredentialManagementSelectCredentialsTextBox.Size.Width + 10
                      Y = $CredentialManagementSelectCredentialsTextBox.Location.Y - 1}
        Size     = @{ Width  = 150
                      Height = 20 }
    }
    CommonButtonSettings -Button $CredentialManagementSelectCredentialsButton
    $CredentialManagementSelectCredentialsButton.Add_Click({ 
        try {
            [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
            $CredentialManagementSelectCredentialsOpenFileDialog                  = New-Object System.Windows.Forms.OpenFileDialog
            $CredentialManagementSelectCredentialsOpenFileDialog.Title            = "Select Credentials"
            $CredentialManagementSelectCredentialsOpenFileDialog.InitialDirectory = $script:CredentialManagementPath
            $CredentialManagementSelectCredentialsOpenFileDialog.filter           = "XML (*.xml)|*.xml|All files (*.*)|*.*"
            $CredentialManagementSelectCredentialsOpenFileDialog.ShowHelp         = $true
            $CredentialManagementSelectCredentialsOpenFileDialog.ShowDialog() | Out-Null
            $script:Credential = Import-CliXml -Path $($CredentialManagementSelectCredentialsOpenFileDialog.filename)
            $CredentialName = $null
            $CredentialName = $($CredentialManagementSelectCredentialsOpenFileDialog.filename).split('\')[-1]
            $CredentialManagementSelectCredentialsTextBox.text = $CredentialName
            $CredentialName | Out-File "$script:CredentialManagementPath\Specified Credentials.txt"
            $StatusListBox.Items.Clear()
            $StatusListBox.Items.Add("Credentials:  $CredentialName")
        }
        catch{}
        if ($script:CredentialManagementPasswordRollingAccountCheckbox.checked) {
            [System.Windows.MessageBox]::Show('Manually selecting credentials disables auto password rolling.')
            $script:CredentialManagementPasswordRollingAccountCheckbox.checked = $false
            $script:RollCredentialsState = $false
        }
        $ComputerListProvideCredentialsCheckBox.checked = $true
    })
    $CredentialManagementAvailableCredentialsGroupBox.Controls.Add($CredentialManagementSelectCredentialsButton)


    $CredentialManagementCreateCredentialsLabel = New-Object System.Windows.Forms.Label -Property @{
        Text     = "You can create and store credentials locally of existing accounts and easily switch between them as necessary. These credentials are stored in XML format and encrypted using Windows Data Protection API, which restricts decryption of the password to the user account and computer that created them."
        Location = @{ X = $CredentialManagementSelectCredentialsTextBox.Location.X
                      Y = $CredentialManagementSelectCredentialsTextBox.Location.Y + $CredentialManagementSelectCredentialsTextBox.Size.Height + 10 }
        Size     = @{ Width  = 465
                      Height = 52 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Black'
    }
    $CredentialManagementAvailableCredentialsGroupBox.Controls.Add($CredentialManagementCreateCredentialsLabel)


    $CredentialManagementCreateNewCredentialsButton = New-Object System.Windows.Forms.Button -Property @{
        Text     = "Create New Credentials"
        Location = @{ X = $CredentialManagementSelectCredentialsButton.Location.X
                      Y = $CredentialManagementCreateCredentialsLabel.Location.Y + $CredentialManagementCreateCredentialsLabel.Size.Height }
        Size     = @{ Width  = 150
                      Height = 20 }
    }
    CommonButtonSettings -Button $CredentialManagementCreateNewCredentialsButton
    $CredentialManagementCreateNewCredentialsButton.Add_Click({        
        Create-NewCredentials

        Start-Sleep -Seconds 2
        $ComputerListProvideCredentialsCheckBox.checked = $true
        $CredentialManagementForm.close()
    })
    $CredentialManagementAvailableCredentialsGroupBox.Controls.Add($CredentialManagementCreateNewCredentialsButton)


    $CredentialManagementDecryptCredentialButton = New-Object System.Windows.Forms.Button -Property @{
        Text     = "Decrypt Credentials"
        Location = @{ X = $CredentialManagementCreateNewCredentialsButton.Location.X - $CredentialManagementCreateNewCredentialsButton.Size.Width - 10
                      Y = $CredentialManagementCreateNewCredentialsButton.Location.Y }
        Size     = @{ Width  = 150
                      Height = 20 }
    }
    CommonButtonSettings -Button $CredentialManagementDecryptCredentialButton
    $CredentialManagementDecryptCredentialButton.Add_Click({
        [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
        $CredentialManagementDecryptCredentialOpenFileDialog                  = New-Object System.Windows.Forms.OpenFileDialog
        $CredentialManagementDecryptCredentialOpenFileDialog.Title            = "Decode Credentials"
        $CredentialManagementDecryptCredentialOpenFileDialog.InitialDirectory = $script:CredentialManagementPath
        $CredentialManagementDecryptCredentialOpenFileDialog.Filter           = "XML (*.xml)|*.xml|All files (*.*)|*.*"
        $CredentialManagementDecryptCredentialOpenFileDialog.ShowHelp         = $true
        $CredentialManagementDecryptCredentialOpenFileDialog.ShowDialog() | Out-Null
        $CredentialToDecode = Import-CliXml -Path $($CredentialManagementDecryptCredentialOpenFileDialog.filename)

        $DecodedUsername = $CredentialToDecode.UserName
        $DecodedPassword = $CredentialToDecode.GetNetworkCredential().Password
        [System.Windows.MessageBox]::Show("Username: $DecodedUsername`nPassword: $DecodedPassword")
    })
    $CredentialManagementAvailableCredentialsGroupBox.Controls.Add($CredentialManagementDecryptCredentialButton)

$CredentialManagementForm.Controls.Add($CredentialManagementAvailableCredentialsGroupBox)

#---------------------------------------------------------
# Credential Management Password Rolling Account GroupBox
#---------------------------------------------------------
$CredentialManagementPasswordRollingAccountGroupBox = New-Object System.Windows.Forms.GroupBox -Property @{
    Text     = "Automatic Password Rolling:"
    Location = @{ X = $CredentialManagementAvailableCredentialsGroupBox.Location.X
                  Y = $CredentialManagementAvailableCredentialsGroupBox.Location.Y + $CredentialManagementAvailableCredentialsGroupBox.Size.Height + 10 }
    Size     = @{ Width  = $CredentialManagementAvailableCredentialsGroupBox.Size.Width
                  Height = 342 }
    Font      = New-Object System.Drawing.Font("$Font",12,1,2,1)
    ForeColor = 'Blue'
}
    $script:CredentialManagementPasswordRollingAccountCheckbox = New-Object System.Windows.Forms.Checkbox -Property @{
        Text     = "Enable rolling of credentials after queries and remote connections"
        Location = @{ X = 5
                      Y = 18 }
        Size     = @{ Width  = 465
                    Height = 25 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Black'
        Checked  = $script:RollCredentialsState
    }
    $script:CredentialManagementPasswordRollingAccountCheckbox.Add_Click({ 
        if ($script:CredentialManagementActiveDirectoryTextBox.text -eq '' `
            -or $script:CredentialManagementPasswordRollingAccountTextBox.text -eq '' `
            -or $script:CredentialManagementPasswordDomainNameTextBox.text -eq '' `
            -or $CredentialManagementSelectCredentialRollingAccountTextBox.text -eq '') {
            [System.Windows.MessageBox]::Show('You must first specify a domain controller, user account, domain name, and the credentials used to roll the credentials.')
            $script:CredentialManagementPasswordRollingAccountCheckbox.checked = $false
        }
        else {
            if ($script:CredentialManagementPasswordRollingAccountCheckbox.checked) { 
                #[System.Windows.MessageBox]::Show('Checkboxing this also forces an initial credential roll.')
                Generate-NewRollingPassword
                $script:RollCredentialsState = $true

                $ComputerListProvideCredentialsCheckBox.checked = $true
                $CredentialManagementGenerateNewPasswordButton.enabled = $true
            }
            else { $script:RollCredentialsState = $false }
        }
    })
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($script:CredentialManagementPasswordRollingAccountCheckbox)






    #------------------------------------------------
    # Credential Management Password Rolling Account 
    #------------------------------------------------
    $CredentialManagementPasswordRollingAccountLabel = New-Object System.Windows.Forms.Label -Property @{
        Text     = "Enter the account name that will be used for password rolling after queries and remote connections are executed. This does not create the account, it just changes the account's password. You must coordinate with the administrator to create an account like: `"EasyWin`"" 
        Location = @{ X = 5
                      Y = $script:CredentialManagementPasswordRollingAccountCheckbox.Location.Y + $script:CredentialManagementPasswordRollingAccountCheckbox.Size.Height + 5 }
        Size     = @{ Width  = 465
                      Height = 45 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Black'
    }
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($CredentialManagementPasswordRollingAccountLabel)


    $script:CredentialManagementPasswordRollingAccountTextBox = New-Object System.Windows.Forms.TextBox -Property @{
        Location = @{ X = $CredentialManagementPasswordRollingAccountLabel.Location.X 
                      Y = $CredentialManagementPasswordRollingAccountLabel.Location.Y + $CredentialManagementPasswordRollingAccountLabel.Size.Height }
        Size     = @{ Width  = 300
                      Height = 25 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Black'
    }
    $script:CredentialManagementPasswordRollingAccountTextBox.Add_MouseEnter({ Check-RollingAccountPrerequisites })
    $script:CredentialManagementPasswordRollingAccountTextBox.Add_MouseLeave({ Check-RollingAccountPrerequisites })
    $script:CredentialManagementPasswordRollingAccountTextBox.Add_KeyDown({ if ($_.KeyCode -eq "Enter") { 
        if ($script:CredentialManagementPasswordRollingAccountTextBox.text -ne ''){
            $script:CredentialManagementPasswordRollingAccountTextBox.text | Out-File "$script:CredentialManagementPath\Specified Rolling Account.txt"
        }
        else {Remove-Item "$script:CredentialManagementPath\Specified Rolling Account.txt"}
        Check-RollingAccountPrerequisites
    } })
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($script:CredentialManagementPasswordRollingAccountTextBox)


    $script:CredentialManagementPasswordRollingAccountButton = New-Object System.Windows.Forms.Button -Property @{
        Location = @{ X = $script:CredentialManagementPasswordRollingAccountTextBox.Location.X + $script:CredentialManagementPasswordRollingAccountTextBox.Size.Width + 10 
                      Y = $script:CredentialManagementPasswordRollingAccountTextBox.Location.Y }
        Size     = @{ Width  = 150
                      Height = 20 }
    }
    CommonButtonSettings -Button $script:CredentialManagementPasswordRollingAccountButton
    $script:CredentialManagementPasswordRollingAccountButton.Add_Click({ 
        if ($script:CredentialManagementPasswordRollingAccountTextBox.text -ne ''){
            $script:CredentialManagementPasswordRollingAccountTextBox.text | Out-File "$script:CredentialManagementPath\Specified Rolling Account.txt"
        }
        else {Remove-Item "$script:CredentialManagementPath\Specified Rolling Account.txt"}
        Check-RollingAccountPrerequisites
    })
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($script:CredentialManagementPasswordRollingAccountButton)

    if ((Test-Path "$script:CredentialManagementPath\Specified Rolling Account.txt")) {
        $script:CredentialManagementPasswordRollingAccountTextBox.text = Get-Content "$script:CredentialManagementPath\Specified Rolling Account.txt"
    }
    else {$script:CredentialManagementPasswordRollingAccountTextBox.text = ''}











    #-----------------------------------------------------
    # Credential Management Domain Controller Server Name 
    #-----------------------------------------------------
    $CredentialManagementActiveDirectoryLabel = New-Object System.Windows.Forms.Label -Property @{
        Text     = "Enter the domain controller name that is used for credential management." 
        Location = @{ X = 5
                      Y = $script:CredentialManagementPasswordRollingAccountTextBox.Location.Y + $script:CredentialManagementPasswordRollingAccountTextBox.Size.Height + 10 }
        Size     = @{ Width  = 465
                      Height = 20 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Black'
    }
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($CredentialManagementActiveDirectoryLabel)


    $script:CredentialManagementActiveDirectoryTextBox = New-Object System.Windows.Forms.TextBox -Property @{
        Location = @{ X = $CredentialManagementActiveDirectoryLabel.Location.X 
                      Y = $CredentialManagementActiveDirectoryLabel.Location.Y  + $CredentialManagementActiveDirectoryLabel.Size.Height }
        Size     = @{ Width  = 300
                      Height = 25 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Black'
    }
    $script:CredentialManagementActiveDirectoryTextBox.Add_MouseEnter({ Check-RollingAccountPrerequisites })
    $script:CredentialManagementActiveDirectoryTextBox.Add_MouseLeave({ Check-RollingAccountPrerequisites })
    $script:CredentialManagementActiveDirectoryTextBox.Add_KeyDown({ if ($_.KeyCode -eq "Enter") { 
        if ($script:CredentialManagementActiveDirectoryTextBox.text -ne ''){
            $script:CredentialManagementActiveDirectoryTextBox.text | Out-File "$script:CredentialManagementPath\Specified Domain Controller.txt"
        }
        else {Remove-Item "$script:CredentialManagementPath\Specified Domain Controller.txt"}
        Check-RollingAccountPrerequisites 
    } })
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($script:CredentialManagementActiveDirectoryTextBox)


    $script:CredentialManagementActiveDirectoryButton = New-Object System.Windows.Forms.Button -Property @{
        Location = @{ X = $CredentialManagementActiveDirectoryTextBox.Location.X + $CredentialManagementActiveDirectoryTextBox.Size.Width + 10 
                      Y = $CredentialManagementActiveDirectoryTextBox.Location.Y}
        Size     = @{ Width  = 150
                      Height = 20 }
    }
    CommonButtonSettings -Button $script:CredentialManagementActiveDirectoryButton
    $script:CredentialManagementActiveDirectoryButton.Add_Click({ 
        if ($script:CredentialManagementActiveDirectoryTextBox.text -ne ''){
            $script:CredentialManagementActiveDirectoryTextBox.text | Out-File "$script:CredentialManagementPath\Specified Domain Controller.txt"
        }
        else {Remove-Item "$script:CredentialManagementPath\Specified Domain Controller.txt"}
        Check-RollingAccountPrerequisites
    })
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($script:CredentialManagementActiveDirectoryButton)

    if ((Test-Path "$script:CredentialManagementPath\Specified Domain Controller.txt")) {
        $script:CredentialManagementActiveDirectoryTextBox.text = Get-Content "$script:CredentialManagementPath\Specified Domain Controller.txt"
    }
    else {$script:CredentialManagementActiveDirectoryTextBox.text = ''}
    Check-RollingAccountPrerequisites


















    #--------------------------------------------
    # Credential Management Password Domain Name
    #--------------------------------------------
    $CredentialManagementPasswordDomainNameLabel = New-Object System.Windows.Forms.Label -Property @{
        Text     = "Enter the Domain Name for the credential rolling account." 
        Location = @{ X = 5
                      Y = $script:CredentialManagementActiveDirectoryButton.Location.Y + $script:CredentialManagementActiveDirectoryButton.Size.Height + 10 }
        Size     = @{ Width  = 465
                      Height = 22 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Black'
    }
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($CredentialManagementPasswordDomainNameLabel)


    $script:CredentialManagementPasswordDomainNameTextBox = New-Object System.Windows.Forms.TextBox -Property @{
        Location = @{ X = $CredentialManagementPasswordDomainNameLabel.Location.X 
                      Y = $CredentialManagementPasswordDomainNameLabel.Location.Y + $CredentialManagementPasswordDomainNameLabel.Size.Height }
        Size     = @{ Width  = 300
                      Height = 25 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Black'
    }
    $script:CredentialManagementPasswordDomainNameTextBox.Add_MouseEnter({ Check-RollingAccountPrerequisites })
    $script:CredentialManagementPasswordDomainNameTextBox.Add_MouseLeave({ Check-RollingAccountPrerequisites })
    $script:CredentialManagementPasswordDomainNameTextBox.Add_KeyDown({ if ($_.KeyCode -eq "Enter") { 
        if ($script:CredentialManagementPasswordDomainNameTextBox.text -ne ''){
            $script:CredentialManagementPasswordDomainNameTextBox.text | Out-File "$script:CredentialManagementPath\Specified Domain Name.txt"
        }
        else {Remove-Item "$script:CredentialManagementPath\Specified Domain Name.txt"}
        Check-RollingAccountPrerequisites
    } })
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($script:CredentialManagementPasswordDomainNameTextBox)


    $script:CredentialManagementPasswordDomainNameButton = New-Object System.Windows.Forms.Button -Property @{
        Location = @{ X = $script:CredentialManagementPasswordDomainNameTextBox.Location.X + $script:CredentialManagementPasswordDomainNameTextBox.Size.Width + 10 
                      Y = $script:CredentialManagementPasswordDomainNameTextBox.Location.Y }
        Size     = @{ Width  = 150
                      Height = 20 }
    }
    CommonButtonSettings -Button $script:CredentialManagementPasswordDomainNameButton
    $script:CredentialManagementPasswordDomainNameButton.Add_Click({ 
        if ($script:CredentialManagementPasswordDomainNameTextBox.text -ne ''){
            $script:CredentialManagementPasswordDomainNameTextBox.text | Out-File "$script:CredentialManagementPath\Specified Domain Name.txt"
        }
        else {Remove-Item "$script:CredentialManagementPath\Specified Domain Name.txt"}
        Check-RollingAccountPrerequisites
    })
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($script:CredentialManagementPasswordDomainNameButton)

    if ((Test-Path "$script:CredentialManagementPath\Specified Domain Name.txt")) {
        $script:CredentialManagementPasswordDomainNameTextBox.text = Get-Content "$script:CredentialManagementPath\Specified Domain Name.txt"
    }
    else {$script:CredentialManagementPasswordDomainNameTextBox.text = ''}





 












    




    $CredentialManagementSelectCredentialRollingAccountLabel = New-Object System.Windows.Forms.Label -Property @{
        Text     = "Select the credentials that roll the credentials used to query and connect to endpoints."
        Location = @{ X = 5
                      Y = $script:CredentialManagementPasswordDomainNameButton.Location.Y + $script:CredentialManagementPasswordDomainNameButton.Size.Height + 10 }
        Size     = @{ Width  = 465
                      Height = 22 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Black'
    }
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($CredentialManagementSelectCredentialRollingAccountLabel)


    $CredentialManagementSelectCredentialRollingAccountTextBox = New-Object System.Windows.Forms.Textbox -Property @{
        Location = @{ X = $CredentialManagementSelectCredentialRollingAccountLabel.Location.X
                      Y = $CredentialManagementSelectCredentialRollingAccountLabel.Location.Y + $CredentialManagementSelectCredentialRollingAccountLabel.Size.Height }
        Size     = @{ Width  = 300
                      Height = 25 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Black'
        BackColor = 'White'
        Enabled   = $false
    }
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($CredentialManagementSelectCredentialRollingAccountTextBox)


    $CredentialManagementSelectCredentialRollingAccountButton = New-Object System.Windows.Forms.Button -Property @{
        Text     = "Select Credentials"
        Location = @{ X = $CredentialManagementSelectCredentialRollingAccountTextBox.Location.X + $CredentialManagementSelectCredentialRollingAccountTextBox.Size.Width + 10
                      Y = $CredentialManagementSelectCredentialRollingAccountTextBox.Location.Y - 1}
        Size     = @{ Width  = 150
                      Height = 20 }
    }
    CommonButtonSettings -Button $CredentialManagementSelectCredentialRollingAccountButton
    $CredentialManagementSelectCredentialRollingAccountButton.Add_Click({ 
        try {
            [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
            $CredentialManagementSelectCredentialsOpenFileDialog                  = New-Object System.Windows.Forms.OpenFileDialog
            $CredentialManagementSelectCredentialsOpenFileDialog.Title            = "Select Credentials"
            $CredentialManagementSelectCredentialsOpenFileDialog.InitialDirectory = $script:CredentialManagementPath
            $CredentialManagementSelectCredentialsOpenFileDialog.filter           = "XML (*.xml)|*.xml|All files (*.*)|*.*"
            $CredentialManagementSelectCredentialsOpenFileDialog.ShowHelp         = $true
            $CredentialManagementSelectCredentialsOpenFileDialog.ShowDialog() | Out-Null
            $script:AdminCredsToRollPassword = Import-CliXml -Path $($CredentialManagementSelectCredentialsOpenFileDialog.filename)
            $CredentialName = $null
            $CredentialName = $($CredentialManagementSelectCredentialsOpenFileDialog.filename).split('\')[-1]
            $CredentialManagementSelectCredentialRollingAccountTextBox.text = $CredentialName
            $CredentialName | Out-File "$script:CredentialManagementPath\Specified Credentials To Roll Credentials.txt"
            $StatusListBox.Items.Clear()
            $StatusListBox.Items.Add("Credentials:  $CredentialName")
            Check-RollingAccountPrerequisites
        }
        catch{}
    })
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($CredentialManagementSelectCredentialRollingAccountButton)

































    #--------------------------------------------------------------
    # Credential Management Generate New Password Label and Button
    #--------------------------------------------------------------
    # note: Previous versions had the random password set at 250 characters, but this was scalled back because during testing cmdkey doesn't seem to support anything larger 
    # a-z,A-Z,0-9``~!@#$%^&*()_+-=[]\{}|;:',`"./<>?
    $CredentialManagementGenerateNewPasswordLabel = New-Object System.Windows.Forms.Label -Property @{
        Text     = "Generates a new password for the rolling account consisting of 32 alpha-numeric random characters. This is done automatically after connections, but can be executed on demand."
        Location = @{ X = 5
                      Y = $CredentialManagementSelectCredentialRollingAccountButton.Location.Y + $CredentialManagementSelectCredentialRollingAccountButton.Size.Height + 10 }
        Size     = @{ Width  = 465
                      Height = 35 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Black'
    }
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($CredentialManagementGenerateNewPasswordLabel)


    $script:CredentialManagementGeneratedRollingPasswordTextBox = New-Object System.Windows.Forms.TextBox -Property @{
        Location = @{ X = $CredentialManagementGenerateNewPasswordLabel.Location.X 
                      Y = $CredentialManagementGenerateNewPasswordLabel.Location.Y + $CredentialManagementGenerateNewPasswordLabel.Size.Height }
        Size     = @{ Width  = 300
                      Height = 25 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Black'
        Enabled    = $false
        BackColor = 'White'
    }
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($script:CredentialManagementGeneratedRollingPasswordTextBox)


    $CredentialManagementGenerateNewPasswordButton = New-Object System.Windows.Forms.Button -Property @{
        Text     = "Generate New Password"
        Location = @{ X = $script:CredentialManagementPasswordRollingAccountButton.Location.X
                      Y = $script:CredentialManagementGeneratedRollingPasswordTextBox.Location.Y }
        Size     = @{ Width  = 150
                      Height = 20 }
        Enabled   = $true
    }
    CommonButtonSettings -Button $CredentialManagementGenerateNewPasswordButton
    $CredentialManagementGenerateNewPasswordButton.Add_Click({
        if ($script:CredentialManagementActiveDirectoryTextBox.text -eq '' `
            -or $script:CredentialManagementPasswordRollingAccountTextBox.text -eq '' `
            -or $script:CredentialManagementPasswordDomainNameTextBox.text -eq '' `
            -or $CredentialManagementSelectCredentialRollingAccountTextBox.text -eq '') {
            [System.Windows.MessageBox]::Show('You must first specify a domain controller, user account, domain name, and the credentials used to roll the credentials.')
            $script:CredentialManagementPasswordRollingAccountCheckbox.checked = $false
        }
        else {
            $script:CredentialManagementPasswordRollingAccountCheckbox.checked = $true
            Generate-NewRollingPassword
            $script:RollCredentialsState = $true
            $ComputerListProvideCredentialsCheckBox.checked = $true
            $CredentialManagementGenerateNewPasswordButton.enabled = $false
        }
    })
    $CredentialManagementPasswordRollingAccountGroupBox.Controls.Add($CredentialManagementGenerateNewPasswordButton)




























$CredentialManagementForm.Controls.Add($CredentialManagementPasswordRollingAccountGroupBox)

if ((Test-Path "$script:CredentialManagementPath\Specified Credentials.txt")) {
    $CredentialManagementSelectCredentialsTextBox.text = Get-Content "$script:CredentialManagementPath\Specified Credentials.txt"
}
if ((Test-Path "$script:CredentialManagementPath\Specified Credentials To Roll Credentials.txt")) {
    $CredentialManagementSelectCredentialRollingAccountTextBox.text = Get-Content "$script:CredentialManagementPath\Specified Credentials To Roll Credentials.txt"
    $CredentialRoller = Get-Content "$script:CredentialManagementPath\Specified Credentials To Roll Credentials.txt"
    $script:AdminCredsToRollPassword = Import-CliXml "$script:CredentialManagementPath\$CredentialRoller" 
}
Check-RollingAccountPrerequisites
$CredentialManagementGenerateNewPasswordButton.enabled = $true


$CredentialManagementForm.ShowDialog()