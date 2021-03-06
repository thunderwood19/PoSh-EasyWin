function Search-CommandTreeNode {
    [cmdletbinding()]
    param(
        [string[]]$CommandSearchInput
    )

    [System.Windows.Forms.TreeNodeCollection]$AllCommandsNode = $script:CommandsTreeView.Nodes

    # Checks if the search node already exists
    $SearchNode = $false
    foreach ($root in $AllCommandsNode) { 
        if ($root.text -imatch 'Search Results') { $SearchNode = $true }
    }
    if ($SearchNode -eq $false) { $script:CommandsTreeView.Nodes.Add($script:TreeNodeCommandSearch) }


    # Sets the value of $CommandSearchText from that of the command line line parameter -CommandSearch
    if ($CommandSearchInput) {
        # Conducts the search, if something is found it will add it to the treeview
        # Will not produce multiple results if the host triggers in more than one field

        $SearchFound = @()
        foreach ($CommandSearchText in $CommandSearchInput) {
            Foreach($Command in $script:AllCommands) {
                if (($SearchFound -inotcontains $Command) -and (
                    ($Command.Name -imatch $CommandSearchText) -or
                    ($Command.Type -imatch $CommandSearchText) -or
                    ($Command.Description -imatch $CommandSearchText))) {
                    if ($Command.Command_RPC_PoSh)     { 
                        Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(RPC) PoSh -- $($Command.Name)" -ToolTip $Command.Command_RPC_PoSh 
                        $SearchFound += $Command
                    }
                    if ($Command.Command_WMI)          { 
                        Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(RPC) WMI -- $($Command.Name)" -ToolTip $Command.Command_WMI 
                        $SearchFound += $Command
                    }
                    #if ($Command.Command_RPC_CMD)     { 
                    #    Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(RPC) CMD -- $($Command.Name)" -ToolTip $Command.Command_RPC_CMD
                    #    $SearchFound += $Command
                    #}
                    #if ($Command.Command_WinRS_WMIC)  { 
                    #    Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(WinRM) WMIC -- $($Command.Name)" -ToolTip $Command.Command_WinRS_WMIC
                    #    $SearchFound += $Command
                    #}
                    #if ($Command.Command_WinRS_CMD)   { 
                    #    Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(WinRM) CMD -- $($Command.Name)" -ToolTip $Command.Command_WinRS_CMD
                    #    $SearchFound += $Command
                    #}
                    if ($Command.Command_WinRM_Script) { 
                        Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(WinRM) Script -- $($Command.Name)" -ToolTip $Command.Command_WinRM_Script        
                        $SearchFound += $Command
                    }
                    if ($Command.Command_WinRM_PoSh)   { 
                        Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(WinRM) PoSh -- $($Command.Name)" -ToolTip $Command.Command_WinRM_PoSh 
                        $SearchFound += $Command
                    }
                    if ($Command.Command_WinRM_WMI)    { 
                        Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(WinRM) WMI -- $($Command.Name)" -ToolTip $Command.Command_WinRM_WMI 
                        $SearchFound += $Command
                    }
                    if ($Command.Command_WinRM_CMD)    { 
                        Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(WinRM) CMD -- $($Command.Name)" -ToolTip $Command.Command_WinRM_CMD 
                        $SearchFound += $Command
                    }
                }
            }
        }
    }
    # Sets the value of $CommandSearchText from that of the the GUI Textbox
    else {
        $CommandSearchText = $CommandsTreeViewSearchComboBox.Text

        $MainBottomTabControl.SelectedTab = $Section3ResultsTab
    
        # Checks if the search has already been conduected
        $SearchCheck = $false
        foreach ($root in $AllCommandsNode) { 
            if ($root.text -imatch 'Search Results') {                    
                foreach ($Category in $root.Nodes) { 
                    if ($Category.text -eq $CommandSearchText) { $SearchCheck = $true}
                }
            }
        }
        # Conducts the search, if something is found it will add it to the treeview
        # Will not produce multiple results if the host triggers in more than one field
        $SearchFound = @()
        if ($CommandSearchText -ne "" -and $SearchCheck -eq $false) {
            $script:AllCommands  = $script:AllEndpointCommands
            $script:AllCommands += $script:AllActiveDirectoryCommands
    
            Foreach($Command in $script:AllCommands) {
                if (($SearchFound -inotcontains $Command) -and (
                    ($Command.Name -imatch $CommandSearchText) -or
                    ($Command.Type -imatch $CommandSearchText) -or
                    ($Command.Description -imatch $CommandSearchText))) {
                    if ($Command.Command_WMI)          { 
                        Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(RPC) WMI -- $($Command.Name)" -ToolTip $Command.Command_WMI 
                        $SearchFound += $Command
                    }
                    #if ($Command.Command_RPC_CMD)     { 
                    #    Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(RPC) CMD -- $($Command.Name)" -ToolTip $Command.Command_RPC_CMD
                    #    $SearchFound += $Command
                    #}
                    #if ($Command.Command_WinRS_WMIC)  { 
                    #    Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(WinRM) WMIC -- $($Command.Name)" -ToolTip $Command.Command_WinRS_WMIC
                    #    $SearchFound += $Command
                    #}
                    #if ($Command.Command_WinRS_CMD)   { 
                    #    Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(WinRM) CMD -- $($Command.Name)" -ToolTip $Command.Command_WinRS_CMD
                    #    $SearchFound += $Command
                    #}
                    if ($Command.Command_WinRM_Script) { 
                        Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(WinRM) Script -- $($Command.Name)" -ToolTip $Command.Command_WinRM_Script        
                        $SearchFound += $Command
                    }
                    if ($Command.Command_WinRM_PoSh)   { 
                        Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(WinRM) PoSh -- $($Command.Name)" -ToolTip $Command.Command_WinRM_PoSh 
                        $SearchFound += $Command
                    }
                    if ($Command.Command_WinRM_WMI)    { 
                        Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(WinRM) WMI -- $($Command.Name)" -ToolTip $Command.Command_WinRM_WMI 
                        $SearchFound += $Command
                    }
                    if ($Command.Command_WinRM_CMD)    { 
                        Add-CommandTreeNode -RootNode $script:TreeNodeCommandSearch -Category $($CommandSearchText) -Entry "(WinRM) CMD -- $($Command.Name)" -ToolTip $Command.Command_WinRM_CMD 
                        $SearchFound += $Command
                    }
                }
            }
        }
        
        # Expands the search results
        [System.Windows.Forms.TreeNodeCollection]$AllCommandsNode = $script:CommandsTreeView.Nodes 
        foreach ($root in $AllCommandsNode) { 
            if ($root.text -match 'Search Results'){ 
                $root.Collapse()
                $root.Expand()
                foreach ($Category in $root.Nodes) {
                    if ($CommandSearchText -in $Category.text) { 
                        $Category.EnsureVisible()
                        $Category.Expand() 
                    }
                    else {
                        $Category.Collapse()
                    }
                }
            }
        }
    
        $CommandSearchText = ""









    }
}
