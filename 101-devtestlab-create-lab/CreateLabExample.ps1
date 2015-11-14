﻿<##################################################################################################

    Usage
    =====
    
    - Powershell -executionpolicy bypass -file CreateLabExample.ps1  


    Pre-Requisites
    ==============

    - Please ensure that the powershell execution policy is set to unrestricted or bypass.
    - Please ensure that the latest version of Azure Powershell in installed on the machine.

##################################################################################################>

#
# Powershell Configurations
#

# Note: Because the $ErrorActionPreference is "Stop", this script will stop on first failure.  
$ErrorActionPreference = "stop"

###################################################################################################

#
# Custom Configurations
#

# Default exit code
$ExitCode = 0

##################################################################################################

try
{
    Login-AzureRmAccount

    Import-Module .\New-AzureDtlLab.ps1

    New-AzureDtlLab -LabName "ExampleLab1" -LabLocation "West US"
}

catch
{
    if (($null -ne $Error[0]) -and ($null -ne $Error[0].Exception) -and ($null -ne $Error[0].Exception.Message))
    {
        $errMsg = $Error[0].Exception.Message
        Write-Host $errMsg
    }

    # Important note: Throwing a terminating error (using $ErrorActionPreference = "stop") still returns exit 
    # code zero from the powershell script. The workaround is to use try/catch blocks and return a non-zero 
    # exit code from the catch block. 
    $ExitCode = -1
}

finally
{
    Write-Host $("Exiting with " + $ExitCode)
    exit $ExitCode
}