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
        #error variable to determine success of action
        $success = $true
    }
    
    process {
        #foreach Net Adapter, either enable or disable powermanagement based on setEnabled Parameter
        foreach ($nic in $colNic) {
            if ($setEnabled) {
                try {
                    $nic | Enable-NetAdapterPowerManagement -ErrorAction Stop
                }
                catch {
                    Write-Host -ForegroundColor Red "Error Trying to Enable Power Management on:" $nic.Name
                    $success = $false;
                }
            }
            else {
                try {
                $nic | Disable-NetAdapterPowerManagement -ErrorAction Stop
                }
                catch {
                    Write-Host -ForegroundColor Red "Error Trying to Disable Power Management on:" $nic.Name
                    $success = $false;
                }
            }
        }
        
        return $success
    }
}

#function to set the binding order, binding order must set prod netadapters first
function Set-NICBindingOrder {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory=$true)]
        [switch]$ascending,
        [Parameter(Mandatory=$true)]
        [switch]$descending
    )
    
    begin {
        #get current binding order
        Get-NetAdapterBinding
    }
    process {

    }
}






