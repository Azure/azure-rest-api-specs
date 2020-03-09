## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: datafactory
  namespace: azure.mgmt.datafactory
  package-name: azure-mgmt-datafactory
python-sdk-output-folder: "$(output-folder)/src/datafactory/azext_datafactory/vendored_sdks/datafactory"

#directive:
#  - from: swagger-document
#    where: $..parameters[?(@.in=='body')]
#    transform: >
#      $['x-ms-client-flatten'] = true;
#    reason: Flatten everything for Azure CLI
#  - from: swagger-document
#    where: $.definitions[*].properties.*
#    transform: >
#      $['x-ms-client-flatten'] = true;
#    reason: Flatten everything for Azure CLI
#  - from: swagger-document
#    where: $.definitions[?(@.discriminator)]
#    transform: >
#      $['x-ms-client-flatten'] = false;
#  - from: swagger-document
#    where: $.definitions[?(@.discriminator)].properties.*
#    transform: >
#      $['x-ms-client-flatten'] = false;
#  - from: swagger-document
#    where: $.definitions.FactoryRepoUpdate.properties.repoConfiguration
#    transform: >
#      $['x-ms-client-flatten'] = false;
#    reason: manually don't flatten the polymorphic base class
#  - from: swagger-document
#    where: $.definitions.FactoryProperties.properties.repoConfiguration
#    transform: >
#      $['x-ms-client-flatten'] = false;
#    reason: manually don't flatten the polymorphic base class
#  - from: swagger-document
#    where: $.definitions.Pipeline.properties.activities
#    transform: >
#      $['x-ms-client-flatten'] = false;
  #- from: swagger-document
  #  where: $.definitions.CmdkeySetupTypeProperties.properties.password
  #  transform: >
  #    $['x-ms-client-flatten'] = false;
  #  reason: manually don't flatten the polymorphic base class    
  #- from: swagger-document
  #  where: $.definitions.LicensedComponentSetupTypeProperties.properties.licenseKey
  #  transform: >
  #    $['x-ms-client-flatten'] = false;
  #  reason: manually don't flatten the polymorphic base class
  #- from: swagger-document
  #  where: $.definitions.*.properties.servicePrincipalKey
  #  transform: >
  #    $['x-ms-client-flatten'] = false;
  #  reason: manually don't flatten the polymorphic base class
  #- from: swagger-document
  #  where: $.definitions.DataFlowResource.properties.properties
  #  transform: >
  #    $['x-ms-client-flatten'] = false;
  #  reason: manually don't flatten the polymorphic base class
  #- from: swagger-document
  #  where: $.definitions.DataFlowDebugResource.properties.properties
  #  transform: >
  #    $['x-ms-client-flatten'] = false;
  #  reason: manually don't flatten the polymorphic base class
  #- from: swagger-document
  #  where: $.definitions.IntegrationRuntimeResource.properties.properties
  #  transform: >
  #    $['x-ms-client-flatten'] = false;
  #  reason: manually don't flatten the polymorphic base class
  #- from: swagger-document
  #  where: $.definitions.IntegrationRuntimeDebugResource.properties.properties
  #  transform: >
  #    $['x-ms-client-flatten'] = false;
  #  reason: manually don't flatten the polymorphic base class
  #- from: swagger-document
  #  where: $.definitions.LinkedServiceResource.properties.properties
  #  transform: >
  #    $['x-ms-client-flatten'] = false;

cli:
    cli-directive:
    # directive on operationGroup
      - select: 'operationGroup'
        where:
            operationGroup: 'operations'
            operation: 'list'
        hidden: true
      - where:
            parameter: location
        required: true
      - where:
            operationGroup: 'exposure_control'
        delete: true
      - where:
            operationGroup: 'integration_runtime_object_metadata'
        delete: true
      - where:
            operationGroup: 'datasets'
        delete: true
      - where:
            operationGroup: 'activity_runs'
        delete: true
      - where:
            operationGroup: 'data_flows'
        delete: true
      - where:
            operationGroup: 'data_flow_debug_session'
        delete: true
      - where:
            operationGroup: 'integration_runtimes'
        delete: true
      - where:
            operationGroup: 'integration_runtime_nodes'
        delete: true
      - where:
            operationGroup: 'linked_services'
        delete: true

```
