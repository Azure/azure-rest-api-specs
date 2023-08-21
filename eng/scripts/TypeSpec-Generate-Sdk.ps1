[CmdletBinding()]
param (
  [Parameter(Position = 0)]
  [ValidateNotNullOrEmpty()]
  [string] $SdkRepoRootDirectory,
  [Parameter(Position = 1)]
  [string] $TypeSpecProjectDirectory = ".", # A directory of `tspconfig.yaml` or a remoteUrl of `tspconfig.yaml`
  [Parameter(Position = 2)]
  [string] $CommitHash,
  [Parameter(Position = 3)]
  [string] $RepoUrl
)

if ($TypeSpecProjectDirectory -contains ".") {
  $TypeSpecProjectDirectory = Resolve-Path $TypeSpecProjectDirectory
}

try {
  Push-Location $SdkRepoRootDirectory
  $commonScript = Join-Path . "eng/common/scripts/TypeSpec-Project-Process.ps1"
  if (Test-Path $commonScript) {
    . $commonScript -TypeSpecProjectDirectory $TypeSpecProjectDirectory -CommitHash $CommitHash -RepoUrl $RepoUrl
    if ($LASTEXITCODE) {
      exit $LASTEXITCODE
    }
  }
  else {
    Write-Error "Cannot find $commonScript at $SdkRepoRootDirectory"
  }
}
finally {
  Pop-Location
}

exit 0