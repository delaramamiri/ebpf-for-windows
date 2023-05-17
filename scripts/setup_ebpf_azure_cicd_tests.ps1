# Copyright (c) Microsoft Corporation
# SPDX-License-Identifier: MIT

param ([parameter(Mandatory=$false)][string] $Target = "TEST_VM",
       [parameter(Mandatory=$false)][string] $LogFileName = "TestLog.log",
       [parameter(Mandatory=$false)][string] $WorkingDirectory = $pwd.ToString(),
       [parameter(Mandatory=$false)][string] $VMListJsonFileName = "vm_list.json",
       [parameter(Mandatory=$false)][string] $TestExecutionJsonFileName = "test_execution.json")

Push-Location $WorkingDirectory


# Load other utility modules.
Import-Module $PSScriptRoot\install_ebpf.psm1 -Force -ArgumentList ($WorkingDirectory, $LogFileName) -WarningAction SilentlyContinue


# Install eBPF Components on the test VM.
Write-Host "Installing eBPF..."
Install-eBPFComponents

Pop-Location
