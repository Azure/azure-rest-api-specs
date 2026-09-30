## Go
These settings apply only when `--go` is specified on the command line.
``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```
### Go multi-api
``` yaml $(go) && $(multiapi)
batch:
  - tag: package-1-0
```
### Tag:  package-1-0 and go
These settings apply only when `--tag=package-1-0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.
``` yaml $(tag) == 'package-1-0' && $(go)
namespace: appconfiguration
output-folder: $(go-sdk-folder)/services/appconfiguration/1.0/$(namespace)
```
