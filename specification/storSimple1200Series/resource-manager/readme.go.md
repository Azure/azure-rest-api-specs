## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: storsimple
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/storsimple1200series/armstorsimple1200series
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-2016-10
```

### Tag: package-2016-10 and go

These settings apply only when `--tag=package-2016-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2016-10' && $(go)
output-folder: $(go-sdk-folder)/services/storsimple1200series/mgmt/2016-10-01/$(namespace)
```
