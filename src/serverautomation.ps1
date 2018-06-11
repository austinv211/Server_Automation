<#
Name: serverautomation.ps1
Description: automates server build process
Author: Austin Vargason
Date Modified: 6/11/2018
#>

#function to set-powersaving by enabling or disabling powermanagement features
#references: https://docs.microsoft.com/en-us/powershell/module/netadapter/disable-netadapterpowermanagement?view=win10-ps
function Set-NICPowerSaving {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [bool]$setEnabled
    )
    
    begin {
        #get all network adapters
        $colNic = Get-NetAdapter
    }
    
    process {
        #foreach Net Adapter, either enable or disable powermanagement based on setEnabled Parameter
        foreach ($nic in $colNic) {
            if ($setEnabled) {
                $nic | Enable-NetAdapterPowerManagement
            }
            else {
                $nic | Disable-NetAdapterPowerManagement
            }
        }
    }
}




