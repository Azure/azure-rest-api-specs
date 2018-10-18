## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-job-2017-09-preview
  - tag: package-catalog-2016-11
  - tag: package-job-2016-11
  - tag: package-job-2016-03-preview
  - tag: package-job-2015-11-preview
  - tag: package-catalog-2015-10-preview
```

### Tag: package-job-2017-09-preview and go

These settings apply only when `--tag=package-job-2017-09-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-job-2017-09-preview' && $(go)
namespace: job
output-folder: $(go-sdk-folder)/services/preview/datalake/analytics/2017-09-01-preview/$(namespace)
```

### Tag: package-catalog-2016-11 and go

These settings apply only when `--tag=package-catalog-2015-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-catalog-2016-11' && $(go)
namespace: catalog
output-folder: $(go-sdk-folder)/services/datalake/analytics/2016-11-01-preview/$(namespace)
```

### Tag: package-job-2016-11 and go

These settings apply only when `--tag=package-job-2016-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-job-2016-11' && $(go)
namespace: job
output-folder: $(go-sdk-folder)/services/datalake/analytics/2016-11-01/$(namespace)
```

### Tag: package-job-2016-03-preview and go

These settings apply only when `--tag=package-job-2016-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-job-2016-03-preview' && $(go)
namespace: job
output-folder: $(go-sdk-folder)/services/preview/datalake/analytics/2016-03-20-preview/$(namespace)
```

### Tag: package-job-2015-11-preview and go

These settings apply only when `--tag=package-job-2015-11-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-job-2015-11-preview' && $(go)
namespace: job
output-folder: $(go-sdk-folder)/services/preview/datalake/analytics/2015-11-01-preview/$(namespace)
```

### Tag: package-catalog-2015-10-preview and go

These settings apply only when `--tag=package-catalog-2015-10-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-catalog-2015-10-preview' && $(go)
namespace: catalog
output-folder: $(go-sdk-folder)/services/preview/datalake/analytics/2015-10-01-preview/$(namespace)
```
