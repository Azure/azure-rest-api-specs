## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-workloads"
  output-folder: "$(typescript-sdks-folder)/sdk/workloads/arm-workloads"
  payload-flattening-threshold: 1
  clear-output-folder: true
  generate-metadata: true
directive:
  - where-operation: monitors_Create
    transform: delete $["x-ms-long-running-operation-options"]

  - where-operation: ProviderInstances_Create
    transform: delete $["x-ms-long-running-operation-options"]

  - where-operation: PhpWorkloads_CreateOrUpdate
    transform: delete $["x-ms-long-running-operation-options"]

  - where-operation: WordpressInstances_CreateOrUpdate
    transform: $["x-ms-long-running-operation-options"] = undefined

  - where-operation: SAPVirtualInstances_Create
    transform: $["x-ms-long-running-operation-options"] = undefined

  - where-operation: SAPCentralInstances_Create
    transform: $["x-ms-long-running-operation-options"] = undefined

  - where-operation: SAPCentralInstances_Update
    transform: $["x-ms-long-running-operation-options"] = undefined
    
  - where-operation: SAPDatabaseInstances_Create
    transform: $["x-ms-long-running-operation-options"] = undefined
    
  - where-operation: SAPDatabaseInstances_Update
    transform: $["x-ms-long-running-operation-options"] = undefined
    
  - where-operation: SAPApplicationServerInstances_Create
    transform: $["x-ms-long-running-operation-options"] = undefined
        
  - where-operation: SAPApplicationServerInstances_Update
    transform: $["x-ms-long-running-operation-options"] = undefined
            
  - where-operation: SAPVirtualInstances_Start
    transform: $["x-ms-long-running-operation-options"] = undefined
            
  - where-operation: SAPVirtualInstances_Stop
    transform: $["x-ms-long-running-operation-options"] = undefined
```
