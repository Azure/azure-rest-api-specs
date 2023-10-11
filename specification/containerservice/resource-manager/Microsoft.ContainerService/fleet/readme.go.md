## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/containerservicefleet/armcontainerservicefleet
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2023-08-preview
  - tag: package-2023-06-preview
  - tag: package-2023-03-preview
  - tag: package-2022-09-preview
  - tag: package-2022-07-preview
  - tag: package-2022-06-preview
```
