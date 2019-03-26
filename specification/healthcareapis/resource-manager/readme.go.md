## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: healthcareapis
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-08
```

### Tag: package-2018-08

These settings apply only when `--tag=package-2018-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-08' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-08-20-preview/$(namespace)
```