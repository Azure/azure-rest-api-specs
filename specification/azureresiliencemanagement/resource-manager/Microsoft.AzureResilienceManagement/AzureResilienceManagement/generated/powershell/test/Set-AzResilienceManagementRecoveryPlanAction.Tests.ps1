if(($null -eq $TestName) -or ($TestName -contains 'Set-AzResilienceManagementRecoveryPlanAction'))
{
  $loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
  if (-Not (Test-Path -Path $loadEnvPath)) {
      $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
  }
  . ($loadEnvPath)
  $TestRecordingFile = Join-Path $PSScriptRoot 'Set-AzResilienceManagementRecoveryPlanAction.Recording.json'
  $currentPath = $PSScriptRoot
  while(-not $mockingPath) {
      $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
      $currentPath = Split-Path -Path $currentPath -Parent
  }
  . ($mockingPath | Select-Object -First 1).FullName
}

Describe 'Set-AzResilienceManagementRecoveryPlanAction' {
    It 'FailoverExpanded' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'Failover' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'FailoverViaJsonFilePath' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'FailoverViaJsonString' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }
}
