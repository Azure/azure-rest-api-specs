### Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/sql/armsql
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: sql
  clear-output-folder: true
```

#### Go multi-api

From api-version 2017-10 and onwards, only pure package versions should be used. Composite package versions are used for earlier api-versions (2017-03 and earlier) in order to ensure backwards compatibility with previously released versions of Go SDK,

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-composite-v5
  - tag: package-composite-v4
  - tag: package-composite-v3
  - tag: package-pure-2018-06-preview
  - tag: package-pure-2017-10-preview
  - tag: package-2017-03-preview
  - tag: package-2015-05-preview
  - tag: package-pure-2014-04
```

#### Tag: package-composite-v5 and go

These settings apply only when `--tag=package-composite-v5 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-composite-v5' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/v5.0/$(namespace)
```

#### Tag: package-composite-v4 and go

These settings apply only when `--tag=package-composite-v4 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-composite-v4' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/v4.0/$(namespace)
```

#### Tag: package-composite-v3 and go

These settings apply only when `--tag=package-composite-v3 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-composite-v3' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/v3.0/$(namespace)
```

#### Tag: package-pure-2018-06-preview and go

These settings apply only when `--tag=package-pure-2018-06-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-pure-2018-06-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-06-01-preview/$(namespace)
```

#### Tag: package-pure-2017-10-preview and go

These settings apply only when `--tag=package-2017-10-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-pure-2017-10-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-10-01-preview/$(namespace)
```

#### Tag: package-2017-03-preview and go

These settings apply only when `--tag=package-2017-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-03-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-03-01-preview/$(namespace)
```

#### Tag: package-2015-05-preview and go

These settings apply only when `--tag=package-2015-05-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-05-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2015-05-01-preview/$(namespace)
```

#### Tag: package-2014-04 and go

These settings apply only when `--tag=package-2014-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-pure-2014-04' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2014-04-01/$(namespace)
```
