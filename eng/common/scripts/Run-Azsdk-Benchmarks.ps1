# Run-Azsdk-Benchmarks.ps1
# Builds the argument list for the Azure SDK Benchmarks CLI based on the provided parameters.
# Called by the run-benchmarks composite action.

param(
  [string]$Scenario,
  [string]$Tags,
  [string]$Model
)

[System.Collections.ArrayList]$runArgs = @("run")

if ($Scenario) {
  $runArgs.Add($Scenario) | Out-Null
} else {
  $runArgs.Add('--all') | Out-Null
  if ($Tags) {
    $runArgs.Add('--tags') | Out-Null
    $runArgs.Add($Tags) | Out-Null
  }
}

if ($Model) {
  $runArgs.Add('--model') | Out-Null
  $runArgs.Add($Model) | Out-Null
}

Write-Host "Running: dotnet run -- $($runArgs -join ' ')"
& dotnet run --project tools/azsdk-cli/Azure.Sdk.Tools.Cli.Benchmarks -- @runArgs
