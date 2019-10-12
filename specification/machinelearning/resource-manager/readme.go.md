## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-webservices-2017-01
  - tag: package-webservices-2016-05-preview
  - tag: package-workspaces-2016-04
  - tag: package-commitmentPlans-2016-05-preview
```

### Tag: package-webservices-2017-01 and go

These settings apply only when `--tag=package-webservices-2017-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-webservices-2017-01' && $(go)
namespace: webservices
output-folder: $(go-sdk-folder)/services/machinelearning/mgmt/2017-01-01/$(namespace)
```

### Tag: package-webservices-2016-05-preview and go

These settings apply only when `--tag=package-webservices-2016-05-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-webservices-2016-05-preview' && $(go)
namespace: webservices
output-folder: $(go-sdk-folder)/services/preview/machinelearning/mgmt/2016-05-01-preview/$(namespace)
```

### Tag: package-workspaces-2016-04 and go

These settings apply only when `--tag=package-workspaces-2016-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-workspaces-2016-04' && $(go)
namespace: workspaces
output-folder: $(go-sdk-folder)/services/machinelearning/mgmt/2016-04-01/workspaces
```

### Tag: package-commitmentPlans-2016-05-preview and go

These settings apply only when `--tag=package-commitmentPlans-2016-05-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-commitmentPlans-2016-05-preview' && $(go)
namespace: commitmentplans
output-folder: $(go-sdk-folder)/services/preview/machinelearning/mgmt/2016-05-01-preview/commitmentplans
```