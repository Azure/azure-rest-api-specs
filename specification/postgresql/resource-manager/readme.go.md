## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2) && $(package-singleservers)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/postgresql/armpostgresql
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

``` yaml $(go) && $(track2) && $(package-flexibleservers)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/postgresql/armpostgresqlflexibleservers/v5
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```
