## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/liftrqumulo/armqumulo
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
  - rename-model: 
      from: 'LiftrBase.Storage.FileSystemResourceUpdate'
      to: FileSystemResourceUpdate
  - rename-model: 
      from: 'LiftrBase.Storage.FileSystemResource'
      to: FileSystemResource
  - rename-model: 
      from: 'LiftrBase.Storage.FileSystemResourceUpdateProperties'
      to: FileSystemResourceUpdateProperties
  - rename-model: 
      from: 'LiftrBase.Storage.FileSystemResourceProperties'
      to: FileSystemResourceProperties
  - rename-model: 
      from: 'LiftrBase.MarketplaceDetails'
      to: MarketplaceDetails
  - rename-model: 
      from: 'LiftrBase.MarketplaceSubscriptionStatus'
      to: MarketplaceSubscriptionStatus
  - rename-model: 
      from: 'LiftrBase.UserDetails'
      to: UserDetails
  - rename-model: 
      from: 'LiftrBase.ProvisioningState'
      to: ProvisioningState
```