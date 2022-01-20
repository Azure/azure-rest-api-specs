## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: datafactory
  namespace: azure.mgmt.datafactory
  package-name: azure-mgmt-datafactory
  disable-checks: true
  randomize-names: true
az-output-folder:  $(azure-cli-extension-folder)/src/datafactory
python-sdk-output-folder: "$(az-output-folder)/azext_datafactory/vendored_sdks/datafactory"

input-file:
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/DataFlow.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/Dataset.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/IntegrationRuntime.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/LinkedService.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/Pipeline.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/Trigger.json

directive:
    - from: swagger-document
      where: $.definitions.JsonFormatFilePattern
      transform: >
          $['type'] = 'string';
    - from: swagger-document
      where: $.definitions.CompressionLevel
      transform: >
          $['type'] = 'string'; 
    - from: swagger-document
      where: $.definitions.DynamicsLinkedServiceTypeProperties.properties.servicePrincipalCredentialType
      transform: >
          $['type'] = 'string'; 
    - from: swagger-document
      where: $.definitions.ScriptAction.properties.roles
      transform: >
          $['type'] = 'string'; 
    - where:
          command: datafactory integration-runtime create-linked-integration-runtime
      set:
          command: datafactory integration-runtime linked-integration-runtime create

cli:
    cli-directive:
    # directive on operationGroup
      - where:
            group: Pipelines
            op: CreateOrUpdate$|CreateOrUpdate#Create
            parameter: pipeline
        json: true
      - where:
            group: IntegrationRuntimes
            op: CreateOrUpdate
            param: properties
        poly-resource: true
      - where:
            group: IntegrationRuntimes
            op: CreateOrUpdate#*
            param: properties
        poly-resource: true
      - where:
            group: ExposureControl|IntegrationRuntimeObjectMetadata|DataFlows|DataFlowDebugSession|ManagedVirtualNetworks|ManagedPrivateEndpoints
        hidden: true
      - where:
            group: Factories
            op: ConfigureFactoryRepo
            param: locationId
        name: location
      - where:
            group: IntegrationRuntimes
            op: CreateLinkedIntegrationRuntime
            param: dataFactoryLocation
        name: location
      - where:
            group: Triggers|LinkedServices|Datasets
            op: CreateOrUpdate#Update
            param: properties
        cli-flatten: true
      - where:
            group: Pipelines
            op: CreateOrUpdate#Update
            param: pipeline
        cli-flatten: true
```
