## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: healthcareapis
  namespace: azure.mgmt.healthcareapis
  package-name: azure-mgmt-healthcareapis
  debug: true
  adjustments:
    "/sku": "Sku*/"
    "/properties/authenticationconfiguration": "Authentication*/"
    "/properties/corsconfiguration": "Cors*/"
    "/properties/cosmosdbconfiguration": "CosmosDb*/"
    "/properties/accesspolicies": "AccessPolicies*/"
  test-scenario:
    - name: ServicePut
    - name: OperationResultsGet
    - name: ServiceGet
    - name: ServiceListByResourceGroup
    - name: ServiceList
    - name: OperationsList
    - name: ServicePatch
    - name: CheckNameAvailabilityPost
    - name: ServiceDelete
```
