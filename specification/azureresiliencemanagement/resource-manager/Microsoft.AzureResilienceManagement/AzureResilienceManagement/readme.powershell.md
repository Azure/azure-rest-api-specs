## PowerShell

These settings apply only when `--powershell` is specified on the command line.

``` yaml $(powershell)
azure-powershell-sdk-type: management-sdk
powershell:
  preview-chk: true
  service-name: AzureResilienceManagement
  root-namespace: Microsoft.Azure.PowerShell.Cmdlets.AzureResilienceManagement
  module-name: Az.AzureResilienceManagement
  subject-prefix: $(service-name)
```
