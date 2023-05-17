# Copyright (c) Microsoft Corporation
# SPDX-License-Identifier: MIT

param ([parameter(Mandatory=$false)][string] $WorkingDirectory = $pwd.ToString(),)

Push-Location $WorkingDirectory


# Load other utility modules.
Import-Module $PSScriptRoot\install_ebpf.psm1 -Force -ArgumentList ($WorkingDirectory, $LogFileName) -WarningAction SilentlyContinue


# Install eBPF Components on the test VM.
Write-Host "Installing eBPF..."
Install-eBPFComponents

Pop-Location
