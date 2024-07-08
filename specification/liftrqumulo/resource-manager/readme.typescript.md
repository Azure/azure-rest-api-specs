## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-qumulo"
  output-folder: "$(typescript-sdks-folder)/sdk/liftrqumulo/arm-qumulo"
  payload-flattening-threshold: 1
  generate-metadata: true

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
