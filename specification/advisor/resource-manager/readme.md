# Advisor
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Advisor.



---
## Getting Started 
To build the SDK for Advisor, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Advisor API.

``` yaml
openapi-type: arm
tag: package-2017-04
```


### Tag: package-2017-04

These settings apply only when `--tag=package-2017-04` is specified on the command line.

``` yaml $(tag) == 'package-2017-04'
input-file:
- Microsoft.Advisor/2017-04-19/advisor.json
```
 
### Tag: package-2017-03

These settings apply only when `--tag=package-2017-03` is specified on the command line.

``` yaml $(tag) == 'package-2017-03'
input-file:
- Microsoft.Advisor/2017-03-31/advisor.json
```
 
### Tag: package-2016-07-preview

These settings apply only when `--tag=package-2016-07-preview` is specified on the command line.

``` yaml $(tag) == 'package-2016-07-preview'
input-file:
- Microsoft.Advisor/2016-07-12-preview/advisor.json
```


---
# Code Generation


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: advisor
  clear-output-folder: true
```

### Tag: package-2017-04 and go

These settings apply only when `--tag=package-2017-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-04' && $(go)
output-folder: $(go-sdk-folder)/services/advisor/mgmt/2017-04-19/advisor
```

### Tag: package-2017-03 and go

These settings apply only when `--tag=package-2017-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-03' && $(go)
output-folder: $(go-sdk-folder)/services/advisor/mgmt/2017-03-31/advisor
```

### Tag: package-2016-07-preview and go

These settings apply only when `--tag=package-2016-07-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-07-preview' && $(go)
output-folder: $(go-sdk-folder)/services/advisor/mgmt/2016-07-12-preview/advisor
```
