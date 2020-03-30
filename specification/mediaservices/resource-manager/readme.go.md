## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: media
  clear-output-folder: true
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-2015-10
  - tag: package-2018-03-preview
  - tag: package-2018-06-preview
  - tag: package-2018-07
  - tag: package-2019-05-preview
```

### Tag: package-2015-10 and go

These settings apply only when `--tag=package-2015-10 --go` is specified on the command line.
Please also specify the `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2015-10' && $(go)
output-folder: $(go-sdk-folder)/services/mediaservices/mgmt/2015-10-01/$(namespace)
```

### Tag: package-2018-03-preview and go

These settings apply only when `--tag=package-2018-03-preview --go` is specified on the command line.
Please also specify the `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2018-03-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/mediaservices/mgmt/2018-03-30-preview/$(namespace)
```

### Tag: package-2018-06-preview and go

These settings apply only when `--tag=package-2018-06-preview --go` is specified on the command line.
Please also specify the `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2018-06-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/mediaservices/mgmt/2018-06-01-preview/$(namespace)
```

### Tag: package-2018-07 and go

These settings apply only when `--tag=package-2018-07 --go` is specified on the command line.
Please also specify the `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2018-07' && $(go)
output-folder: $(go-sdk-folder)/services/mediaservices/mgmt/2018-07-01/$(namespace)
```

### Tag: package-2019-05-preview and go

These settings apply only when `--tag=package-2019-05-preview --go` is specified on the command line.
Please also specify the `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2019-05-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/mediaservices/mgmt/2019-05-01-preview/$(namespace)
```
