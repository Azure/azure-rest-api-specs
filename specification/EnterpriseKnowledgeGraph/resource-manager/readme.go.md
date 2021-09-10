## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: enterpriseknowledgegraphservice
  clear-output-folder: true
```

### Go multi-api
``` yaml $(go) && $(multiapi)
batch:
   - tag: package-2018-12-03
```

### Tag: package-2018-12-03 and go
These settings apply only when `--tag=package-2018-12-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-12-03' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/2018-12-03/$(namespace)
```
