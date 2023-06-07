# Copyright (c) Microsoft Corporation
# SPDX-License-Identifier: MIT

param([parameter(Mandatory=$false)][string] $LogFileName = "TestLog.log",
       [parameter(Mandatory=$false)][string] $WorkingDirectory = $pwd.ToString(),
       [parameter(Mandatory=$false)] [bool] $VerboseLogs = $false,
       [parameter(Mandatory=$false)] [bool] $Coverage = $false)

write-host ("Here is the directory")
Push-Location $WorkingDirectory
# $LogFileName = "TestLog.log"
write-host ("Import modules")
Import-Module .\common.psm1 -Force -ArgumentList ($LogFileName)
Import-Module .\run_driver_tests.psm1 -ArgumentList ($WorkingDirectory, $LogFileName) -Force -WarningAction SilentlyContinue
# $VerboseLogs = $false
# $Coverage = $false
write-host ("Invoke CICD")
Invoke-CICDTests -VerboseLogs $VerboseLogs -Coverage $Coverage 2>&1 | Write-Log

#Pop-Location