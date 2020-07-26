$script:yqFound = $false

if($null -ne (Get-Command yq -ErrorAction SilentlyContinue)) {
    $script:yqFound = $true
}

function Test-YQInstalled {
    $script:yqFound -eq $true
}

. $PSScriptRoot\CompareYaml.ps1
. $PSScriptRoot\ConvertToYaml.ps1
. $PSScriptRoot\ImportYaml.ps1
. $PSScriptRoot\MergeYaml.ps1
. $PSScriptRoot\UpdateYaml.ps1