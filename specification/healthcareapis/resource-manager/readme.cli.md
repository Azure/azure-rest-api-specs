## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: healthcareapis
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.healthcareapis
  package-name: azure-mgmt-healthcareapis
  clear-output-folder: false
  debug: true
  adjustments:
    "/sku": "Sku*/"
    "/properties/authenticationconfiguration": "Authentication*/"
    "/properties/corsconfiguration": "Cors*/"
    "/properties/cosmosdbconfiguration": "CosmosDb*/"
    "/properties/accesspolicies": "AccessPolicies*/"
  disable-mm: true
  test-setup:
    - name: Create or Update a service with all parameters
```
