# Copyright (c) Microsoft Corporation
# SPDX-License-Identifier: MIT
param ([parameter(Mandatory=$false)][string] $LogFileName = "TestLog.log",
       [parameter(Mandatory=$false)][string] $WorkingDirectory = $pwd.ToString())

#Push-Location $WorkingDirectory
$WorkingDirectory = "$env:SystemDrive\$WorkingDirectory"

# Load other utility modules.
Import-Module $PSScriptRoot\install_ebpf.psm1 -Force -ArgumentList ($WorkingDirectory, $LogFileName)

# Install eBPF Components on the test VM.
Write-Host "Installing eBPF..."
Install-eBPFComponents

Pop-Location