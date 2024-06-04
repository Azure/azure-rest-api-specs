<#
.SYNOPSIS
This file contains scripts that can be used as a starting point for specs directory structure analysis.
#>

function Get-AllSpecDirsPaths(
    [ValidateScript({Test-Path $_})]
    [String] $Path="../../specification") {

    return Get-ChildItem -Path $Path -Recurse -Directory | ForEach-Object {
        Write-Output $_.FullName
    }
}

function Get-AllReadmeMdFilesPaths(
    [ValidateScript({Test-Path $_})]
    [String] $Path="../../specification") {

    return Get-ChildItem -Path $Path -Recurse -File -Filter "readme.md" | ForEach-Object {
        Write-Output $_.FullName
    }
}
