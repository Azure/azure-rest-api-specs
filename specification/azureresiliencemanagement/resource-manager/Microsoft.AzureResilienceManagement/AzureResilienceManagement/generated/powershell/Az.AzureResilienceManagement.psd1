@{
  RootModule           = 'Az.AzureResilienceManagement.psm1'
  ModuleVersion        = '0.1.0'
  CompatiblePSEditions = 'Core','Desktop'
  GUID                 = 'cf4fc371-12f4-447c-94af-df030beb2c37'
  Author               = 'Microsoft Corporation'
  CompanyName          = 'Microsoft Corporation'
  Copyright            = 'Microsoft Corporation. All rights reserved.'
  Description          = 'Microsoft Azure PowerShell: AzureResilienceManagement cmdlets (2026-08-31-preview).'
  PowerShellVersion    = '5.1'
  DotNetFrameworkVersion = '4.7.2'
  RequiredAssemblies   = './bin/Az.AzureResilienceManagement.private.dll'
  RequiredModules      = @(@{ ModuleName = 'Az.Accounts'; ModuleVersion = '2.7.5' })
  CmdletsToExport      = '*'
  AliasesToExport      = @()
  FunctionsToExport    = @()
}
