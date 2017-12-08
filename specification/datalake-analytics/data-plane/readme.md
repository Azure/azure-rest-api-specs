# DataLakeAnalytics
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for DataLakeAnalytics.



---
## Getting Started 
To build the SDK for DataLakeAnalytics, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information 
These are the global settings for the DataLakeAnalytics API.

``` yaml
openapi-type: data-plane
```

``` yaml $(package-catalog)
tag: package-catalog-2016-11
```

``` yaml $(package-job)
tag: package-job-2017-09-preview
```

### Tag: package-catalog-2016-11

These settings apply only when `--tag=package-catalog-2016-11` is specified on the command line.

``` yaml $(tag) == 'package-catalog-2016-11'
input-file:
- Microsoft.DataLakeAnalytics/2016-11-01/catalog.json
```
 
### Tag: package-catalog-2015-10-preview

These settings apply only when `--tag=package-catalog-2015-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-catalog-2015-10-preview'
input-file:
- Microsoft.DataLakeAnalytics/2015-10-01-preview/catalog.json
```

### Tag: package-job-2017-09-preview

These settings apply only when `--tag=package-job-2017-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-job-2017-09-preview'
input-file:
- Microsoft.DataLakeAnalytics/2017-09-01-preview/job.json
```

### Tag: package-job-2016-11

These settings apply only when `--tag=package-job-2016-11` is specified on the command line.

``` yaml $(tag) == 'package-job-2016-11'
input-file:
- Microsoft.DataLakeAnalytics/2016-11-01/job.json
```
 
### Tag: package-job-2016-03-preview

These settings apply only when `--tag=package-job-2016-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-job-2016-03-preview'
input-file:
- Microsoft.DataLakeAnalytics/2016-03-20-preview/job.json
```
 
### Tag: package-job-2015-11-preview

These settings apply only when `--tag=package-job-2015-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-job-2015-11-preview'
input-file:
- Microsoft.DataLakeAnalytics/2015-11-01-preview/job.json
```

---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.DataLake.Analytics
  output-folder: $(csharp-sdks-folder)/DataLake.Analytics/Management.DataLake.Analytics/Generated
batch:
  - package-catalog: true
  - package-job: true
```

## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-datalake-analytics
  clear-output-folder: true
  no-namespace-folders: true
batch:
  - tag: package-catalog-2016-11
  - tag: package-job-2016-11
```

### Tag: package-job-2016-11 and python

These settings apply only when `--tag=package-job-2016-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-job-2016-11' && $(python)
python:
  namespace: azure.mgmt.datalake.analytics.job
  output-folder: $(python-sdks-folder)/azure-mgmt-datalake-analytics/azure/mgmt/datalake/analytics/job
```

### Tag: package-catalog-2016-11 and python

These settings apply only when `--tag=package-catalog-2016-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-catalog-2016-11' && $(python)
python:
  namespace: azure.mgmt.datalake.analytics.catalog
  output-folder: $(python-sdks-folder)/azure-mgmt-datalake-analytics/azure/mgmt/datalake/analytics/catalog
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Tag: package-job-2017-09-preview and go

These settings apply only when `--tag=package-job-2017-09-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-job-2017-09-preview' && $(go)
namespace: job
output-folder: $(go-sdk-folder)/services/datalake/analytics/2017-09-01-preview/job
```

### Tag: package-catalog-2016-11 and go

These settings apply only when `--tag=package-catalog-2015-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-catalog-2016-11' && $(go)
namespace: catalog
output-folder: $(go-sdk-folder)/services/datalake/analytics/2016-11-01-preview/catalog
```

### Tag: package-job-2016-11 and go

These settings apply only when `--tag=package-job-2016-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-job-2016-11' && $(go)
namespace: job
output-folder: $(go-sdk-folder)/services/datalake/analytics/2016-11-01/job
```

### Tag: package-job-2016-03-preview and go

These settings apply only when `--tag=package-job-2016-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-job-2016-03-preview' && $(go)
namespace: job
output-folder: $(go-sdk-folder)/services/datalake/analytics/2016-03-20-preview/job
```

### Tag: package-job-2015-11-preview and go

These settings apply only when `--tag=package-job-2015-11-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-job-2015-11-preview' && $(go)
namespace: job
output-folder: $(go-sdk-folder)/services/datalake/analytics/2015-11-01-preview/job
```

### Tag: package-catalog-2015-10-preview and go

These settings apply only when `--tag=package-catalog-2015-10-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-catalog-2015-10-preview' && $(go)
namespace: catalog
output-folder: $(go-sdk-folder)/services/datalake/analytics/2015-10-01-preview/catalog
```

# Validation

Since this RP has no unique default package, iterate over all of them for validation:

``` yaml $(validation)
batch:
  - package-catalog: true
  - package-job: true
```