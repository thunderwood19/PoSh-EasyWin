$ComputerListWinRMCheckButtonAdd_Click = { 
    Create-ComputerNodeCheckBoxArray
    if (Verify-Action -Title "Verification: WinRM Check" -Question "Conduct a WinRM Check to the following?" -Computer $($script:ComputerTreeViewSelected -join ', ')) {
        Check-Connection -CheckType "WinRM Check" -MessageTrue "Able to Verify WinRM" -MessageFalse "Unable to Verify WinRM" 
    }
    else {
        [system.media.systemsounds]::Exclamation.play()
        $StatusListBox.Items.Clear()
        $StatusListBox.Items.Add("WinRM Check:  Cancelled")
    }
}

$ComputerListWinRMCheckButtonAdd_MouseHover = {
    Show-ToolTip -Title "WinRM Check" -Icon "Info" -Message @"
+  Unresponsive hosts can be removed from being nodes checked.
+  Command:
    Test-WSman -ComputerName <target>
+  Command  Alternative (Sends Ping First):
    Test-NetConnection CommonTCPPort WINRM -ComputerName <target>
"@ 
}
