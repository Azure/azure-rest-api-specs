## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/migrationwaves/armmigrationwaves
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
modelerfour:
  lenient-model-deduplication: true
```
### Tag: package-preview-2025-12 and go
These settings apply only when `--tag=package-preview-2025-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-preview-2025-12' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2025-12-01/$(namespace)
```
### Tag: package-preview-2025-03 and go
These settings apply only when `--tag=package-preview-2025-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-preview-2025-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2025-03-30/$(namespace)
```