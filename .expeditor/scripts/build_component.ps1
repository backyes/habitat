#!/usr/bin/env powershell

#Requires -Version 5

param (
    # The name of the component to be built. Defaults to none
    [string]$Component
)

$ErrorActionPreference="stop" 

if($Component.Equals("")) {
  Write-Error "--- :error: Component to build not specified, please use the -Component flag"
}

& hab pkg install core/hab

$hab_bin_path = & hab pkg path core/hab
$hab_binary="$hab_bin_path/bin/hab"
$hab_binary_version = & $hab_binary --version

Write-Host "--- Using habitat version $hab_binary_version"