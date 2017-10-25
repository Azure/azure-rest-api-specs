# ApiManagement
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for ApiManagement.



---
## Getting Started 
To build the SDK for ApiManagement, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the ApiManagement API.

``` yaml
title: ApiManagementClient
description: ApiManagement Client
openapi-type: arm
tag: package-2017-03
```


### Tag: package-2017-03

These settings apply only when `--tag=package-2017-03` is specified on the command line.

``` yaml $(tag) == 'package-2017-03'
input-file:
- Microsoft.ApiManagement/2017-03-01/apimanagement.json
- Microsoft.ApiManagement/2017-03-01/apimapis.json
- Microsoft.ApiManagement/2017-03-01/apimauthorizationservers.json
- Microsoft.ApiManagement/2017-03-01/apimbackends.json
- Microsoft.ApiManagement/2017-03-01/apimcertificates.json
- Microsoft.ApiManagement/2017-03-01/apimdeployment.json
- Microsoft.ApiManagement/2017-03-01/apimemailtemplate.json
- Microsoft.ApiManagement/2017-03-01/apimgroups.json
- Microsoft.ApiManagement/2017-03-01/apimidentityprovider.json
- Microsoft.ApiManagement/2017-03-01/apimloggers.json
- Microsoft.ApiManagement/2017-03-01/apimnetworkstatus.json
- Microsoft.ApiManagement/2017-03-01/apimopenidconnectproviders.json
- Microsoft.ApiManagement/2017-03-01/apimportalsettings.json
- Microsoft.ApiManagement/2017-03-01/apimproducts.json
- Microsoft.ApiManagement/2017-03-01/apimproperties.json
- Microsoft.ApiManagement/2017-03-01/apimquotas.json
- Microsoft.ApiManagement/2017-03-01/apimreports.json
- Microsoft.ApiManagement/2017-03-01/apimsubscriptions.json
- Microsoft.ApiManagement/2017-03-01/apimtenant.json
- Microsoft.ApiManagement/2017-03-01/apimusers.json
```


### Tag: package-2016-10

These settings apply only when `--tag=package-2016-10` is specified on the command line.

``` yaml $(tag) == 'package-2016-10'
input-file:
- Microsoft.ApiManagement/2016-10-10/apimanagement.json
- Microsoft.ApiManagement/2016-10-10/apimapis.json
- Microsoft.ApiManagement/2016-10-10/apimauthorizationservers.json
- Microsoft.ApiManagement/2016-10-10/apimbackends.json
- Microsoft.ApiManagement/2016-10-10/apimcertificates.json
- Microsoft.ApiManagement/2016-10-10/apimdeployment.json
- Microsoft.ApiManagement/2016-10-10/apimgroups.json
- Microsoft.ApiManagement/2016-10-10/apimidentityprovider.json
- Microsoft.ApiManagement/2016-10-10/apimloggers.json
- Microsoft.ApiManagement/2016-10-10/apimnetworkstatus.json
- Microsoft.ApiManagement/2016-10-10/apimopenidconnectproviders.json
- Microsoft.ApiManagement/2016-10-10/apimproducts.json
- Microsoft.ApiManagement/2016-10-10/apimproperties.json
- Microsoft.ApiManagement/2016-10-10/apimquotas.json
- Microsoft.ApiManagement/2016-10-10/apimreports.json
- Microsoft.ApiManagement/2016-10-10/apimsubscriptions.json
- Microsoft.ApiManagement/2016-10-10/apimtenant.json
- Microsoft.ApiManagement/2016-10-10/apimusers.json
```
 
### Tag: package-2016-07

These settings apply only when `--tag=package-2016-07` is specified on the command line.

``` yaml $(tag) == 'package-2016-07'
input-file:
- Microsoft.ApiManagement/2016-07-07/apimanagement.json
- Microsoft.ApiManagement/2016-07-07/apimdeployment.json
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
  namespace: Microsoft.Azure.Management.ApiManagement  
  output-folder: $(csharp-sdks-folder)/ApiManagement/Management.ApiManagement/Generated
  clear-output-folder: true
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: apimanagement
  clear-output-folder: true
```

### Tag: package-2017-03 and go

These settings apply only when `--tag=package-2017-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-03' && $(go)
output-folder: $(go-sdk-folder)/services/apimanagement/mgmt/2017-03-01/apimanagement
```

### Tag: package-2016-10 and go

These settings apply only when `--tag=package-2016-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-10' && $(go)
output-folder: $(go-sdk-folder)/services/apimanagement/mgmt/2016-10-10/apimanagement
```

### Tag: package-2016-07 and go

These settings apply only when `--tag=package-2016-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-07' && $(go)
output-folder: $(go-sdk-folder)/services/apimanagement/mgmt/2016-07-07/apimanagement
```
