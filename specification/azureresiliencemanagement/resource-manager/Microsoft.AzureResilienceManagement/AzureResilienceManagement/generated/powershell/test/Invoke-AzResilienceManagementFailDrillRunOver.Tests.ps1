if(($null -eq $TestName) -or ($TestName -contains 'Invoke-AzResilienceManagementFailDrillRunOver'))
{
  $loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
  if (-Not (Test-Path -Path $loadEnvPath)) {
      $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
  }
  . ($loadEnvPath)
  $TestRecordingFile = Join-Path $PSScriptRoot 'Invoke-AzResilienceManagementFailDrillRunOver.Recording.json'
  $currentPath = $PSScriptRoot
  while(-not $mockingPath) {
      $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
      $currentPath = Split-Path -Path $currentPath -Parent
  }
  . ($mockingPath | Select-Object -First 1).FullName
}

Describe 'Invoke-AzResilienceManagementFailDrillRunOver' {
    It 'FailExpanded' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'FailViaJsonString' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'FailViaJsonFilePath' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'FailViaIdentityServiceGroupExpanded' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'FailViaIdentityServiceGroup' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'Fail' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'FailViaIdentityDrillExpanded' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'FailViaIdentityDrill' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'FailViaIdentityExpanded' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'FailViaIdentity' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }
}
