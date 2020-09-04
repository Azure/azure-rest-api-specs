# Go HybridCompute

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: hybridcompute

  directive:
  - remove-operation: 
    - Machines_Reconnect
    - Machines_CreateOrUpdate
    - Machines_Update
```

## Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2019-12
  - tag: package-2020-08-02
```

### Tag: package-2020-08-02 and go

These settings apply only when `--tag=package-2020-08-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-08-02' && $(go)
output-folder: $(go-sdk-folder)/services/hybridcompute/mgmt/2020-08-02/hybridcompute
```

### Tag: package-2019-12 and go

These settings apply only when `--tag=package-2019-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-12' && $(go)
output-folder: $(go-sdk-folder)/services/hybridcompute/mgmt/2019-12-12/hybridcompute
```
