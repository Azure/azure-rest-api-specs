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
  test-setup:
    - name: Check name availability
    - name: Lists all of the available Healthcare service REST API operations.
    - name: Create or Update a service with all parameters
    - name: Delete service
    - name: Create or Update a service with minimum parameters
    - name: Get the metadata of a service instance.
    - name: List all services in subscription
    - name: List all services in resource group
    - name: Delete service
```
