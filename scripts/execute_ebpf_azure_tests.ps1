# Copyright (c) Microsoft Corporation
# SPDX-License-Identifier: MIT

# param([Parameter(Mandatory=$True)] [string] $WorkingDirectory,
#         [Parameter(Mandatory=$True)] [string] $LogFileName,
#         [parameter(Mandatory=$false)] [bool] $VerboseLogs = $false,
#         [parameter(Mandatory=$false)] [bool] $Coverage = $false)
Push-Location $WorkingDirectory
param ([parameter(Mandatory=$false)][string] $LogFileName = "TestLog.log",
       [parameter(Mandatory=$false)][string] $WorkingDirectory = $pwd.ToString())

Import-Module $WorkingDirectory\common.psm1 -ArgumentList ($LogFileName) -Force -WarningAction SilentlyContinue
Import-Module $WorkingDirectory\run_driver_tests.psm1 -ArgumentList ($WorkingDirectory, $LogFileName) -Force -WarningAction SilentlyContinue

Invoke-CICDTests 2>&1 | Write-Log

Pop-Location