# ServiceMap
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for ServiceMap.



---
## Getting Started 
To build the SDK for ServiceMap, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the ServiceMap API.

``` yaml
openapi-type: arm
tag: package-2015-11-preview
```


### Tag: package-2015-11-preview

These settings apply only when `--tag=package-2015-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-11-preview'
input-file:
- Microsoft.OperationalInsights/2015-11-01-preview/arm-service-map.json
```


---
# Code Generation


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: servicemap
  clear-output-folder: true
```

### Tag: package-2015-11-preview and go

These settings apply only when `--tag=package-2015-11-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-11-preview' && $(go)
output-folder: $(go-sdk-folder)/services/operationalinsights/mgmt/2015-11-01-preview/servicemap
```
