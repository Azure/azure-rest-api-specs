## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
title: CosmosdbForPostgresqlMgmtClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-cosmosdbforpostgresql
package-version: 1.0.0b1
no-namespace-folders: true
```

``` yaml $(python)
namespace: azure.mgmt.cosmosdbforpostgresql
output-folder: $(python-sdks-folder)/cosmosdbforpostgresql/azure-mgmt-cosmosdbforpostgresql/azure/mgmt/cosmosdbforpostgresql
```
