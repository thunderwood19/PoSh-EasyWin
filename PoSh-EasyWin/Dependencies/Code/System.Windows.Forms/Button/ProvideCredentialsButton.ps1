$ProvideCredentialsButtonAdd_Click = {
    $MainBottomTabControl.SelectedTab = $Section3ResultsTab
    # Launches the Credential Management Form
    # Provides the abiltiy to select create, select, and save credentials
    # Provides the option to enable password auto rolling
    . "$Dependencies\Code\Credential Management\Launch-CredentialManagementForm.ps1"    
}

$ProvideCredentialsButtonAdd_MouseHover = {
    Show-ToolTip -Title "Specify Credentials" -Icon "Info" -Message @"
+  Credentials are stored in memory as credential objects.
+  Credentials stored on disk as XML files are encrypted credential objects using Windows Data Protection API.
    This encryption ensures that only your user account on only that computer can decrypt the contents of the 
    credential object. The exported CLIXML file can't be used on a different computer or by a different user.
+  If checked, credentials are applied to:
    RDP, PSSession, PSExec
"@ 
}
