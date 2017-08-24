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

# Validation

Since this RP has no unique default package, iterate over all of them for validation:

``` yaml $(validation)
batch:
  - package-catalog: true
  - package-job: true
```