## Go

These settings apply only when `--go` is specified on the command line.

### Fix up regular expressions to support Unicode.

``` yaml 
directive:
  from: swagger-document # do it globally
  where: $.paths..parameters[?(@.name == "resourceGroupName" || @.name == "sourceResourceGroupName")].pattern
  set: ^[-\p{L}\._\(\)\w]+$ 
  reason: Necessary to match Unicode characters in the Go regexp engine.
```

``` yaml $(go) && $(track2) && $(package-resources)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/resources/armresources
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

``` yaml $(go) && $(track2) && $(package-features)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/resources/armfeatures
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

``` yaml $(go) && $(track2) && $(package-links)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/resources/armlinks
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

``` yaml $(go) && $(track2) && $(package-locks)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/resources/armlocks
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

``` yaml $(go) && $(track2) && $(package-managedapplications)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/resources/armmanagedapplications
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

``` yaml $(go) && $(track2) && $(package-policy)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/resources/armpolicy
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

``` yaml $(go) && $(track2) && $(package-subscriptions)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/resources/armsubscriptions
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
modelerfour:
  lenient-model-deduplication: true
```

``` yaml $(go) && $(track2) && $(package-changes)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/resources/armchanges
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

``` yaml $(go) && $(track2) && $(package-databoundaries)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/databoundaries/armdataboundaries
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```
