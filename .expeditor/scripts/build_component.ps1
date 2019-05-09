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

$destination_channel = $Env:BUILDKITE_BUILD_ID

$Env:HAB_LICENSE = "accept-no-persist"
$Env:HAB_STUDIO_SECRET_HAB_LICENSE = "accept-no-persist"

choco install habitat -y

hab pkg install core/hab

$hab_bin_path = & hab pkg path core/hab
$hab_binary="$hab_bin_path/bin/hab"
$hab_binary_version = & $hab_binary --version

Write-Host "--- Using habitat version $hab_binary_version"

Write-Host "--- Running a build $HAB_ORIGIN / $Component / $destination_channel"
$hab_binary origin key download $HAB_ORIGIN
$hab_binary origin key download --auth $SCOTTHAIN_HAB_AUTH_TOKEN --secret $HAB_ORIGIN


exit $LASTEXITCODE
