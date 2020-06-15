## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: datafactory
  namespace: azure.mgmt.datafactory
  package-name: azure-mgmt-datafactory
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
            group: ExposureControl
        hidden: true
      - where:
            group: integrationRuntimeObjectMetadata
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
            group: LinkedServices
            op: CreateOrUpdate#Update
            param: properties
        cli-flatten: true
      - where:
            group: Datasets
            op: CreateOrUpdate#Update
            param: properties
        cli-flatten: true
      - where:
            group: Pipelines
            op: CreateOrUpdate#Update
            param: pipeline
        cli-flatten: true
      - where:
            group: Triggers
            op: CreateOrUpdate#Update
            param: properties
        cli-flatten: true
      - where:
            group: DataFlows
            op: CreateOrUpdate#Update
            param: properties
        cli-flatten: true
```
