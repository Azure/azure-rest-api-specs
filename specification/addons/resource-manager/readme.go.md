## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: addons
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/addons/armaddons
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```


### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-03
  - tag: package-2017-05
```

### Tag: package-2018-03 and go

These settings apply only when `--tag=package-2018-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-03' && $(go)
output-folder: $(go-sdk-folder)/services/preview/addons/mgmt/2018-03-01/addons
```

### Tag: package-2017-05 and go

These settings apply only when `--tag=package-2017-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-05' && $(go)
output-folder: $(go-sdk-folder)/services/preview/addons/mgmt/2017-05-15/addons
```

