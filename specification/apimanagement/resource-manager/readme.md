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
tag: package-2018-01
```

### Tag: package-2018-01

These settings apply only when `--tag=package-2018-01` is specified on the command line.

``` yaml $(tag) == 'package-2018-01'
input-file:
- Microsoft.ApiManagement/preview/2018-01-01/apimanagement.json
- Microsoft.ApiManagement/preview/2018-01-01/apimapis.json
- Microsoft.ApiManagement/preview/2018-01-01/apimauthorizationservers.json
- Microsoft.ApiManagement/preview/2018-01-01/apimbackends.json
- Microsoft.ApiManagement/preview/2018-01-01/apimcertificates.json
- Microsoft.ApiManagement/preview/2018-01-01/apimdeployment.json
- Microsoft.ApiManagement/preview/2018-01-01/apimdiagnostics.json
- Microsoft.ApiManagement/preview/2018-01-01/apimemailtemplate.json
- Microsoft.ApiManagement/preview/2018-01-01/apimgroups.json
- Microsoft.ApiManagement/preview/2018-01-01/apimidentityprovider.json
- Microsoft.ApiManagement/preview/2018-01-01/apimloggers.json
- Microsoft.ApiManagement/preview/2018-01-01/apimnotifications.json
- Microsoft.ApiManagement/preview/2018-01-01/apimnetworkstatus.json
- Microsoft.ApiManagement/preview/2018-01-01/apimopenidconnectproviders.json
- Microsoft.ApiManagement/preview/2018-01-01/apimportalsettings.json
- Microsoft.ApiManagement/preview/2018-01-01/apimproducts.json
- Microsoft.ApiManagement/preview/2018-01-01/apimproperties.json
- Microsoft.ApiManagement/preview/2018-01-01/apimquotas.json
- Microsoft.ApiManagement/preview/2018-01-01/apimreports.json
- Microsoft.ApiManagement/preview/2018-01-01/apimsubscriptions.json
- Microsoft.ApiManagement/preview/2018-01-01/apimtagresources.json
- Microsoft.ApiManagement/preview/2018-01-01/apimtags.json
- Microsoft.ApiManagement/preview/2018-01-01/apimtenant.json
- Microsoft.ApiManagement/preview/2018-01-01/apimusers.json
- Microsoft.ApiManagement/preview/2018-01-01/apimversionsets.json
```

## Suppression
``` yaml
directive:
  - suppress: R3016
    reason: existing properties, can't be changed without breaking API.
    #where:
    #  - $.definitions.ApiManagementServiceUploadCertificateParameters.properties.certificate_password
    #  - $.definitions.QuotaCounterContract.properties.Value

```

### Tag: package-2017-03

These settings apply only when `--tag=package-2017-03` is specified on the command line.

``` yaml $(tag) == 'package-2017-03'
input-file:
- Microsoft.ApiManagement/stable/2017-03-01/apimanagement.json
- Microsoft.ApiManagement/stable/2017-03-01/apimapis.json
- Microsoft.ApiManagement/stable/2017-03-01/apimauthorizationservers.json
- Microsoft.ApiManagement/stable/2017-03-01/apimbackends.json
- Microsoft.ApiManagement/stable/2017-03-01/apimcertificates.json
- Microsoft.ApiManagement/stable/2017-03-01/apimdeployment.json
- Microsoft.ApiManagement/stable/2017-03-01/apimdiagnostics.json
- Microsoft.ApiManagement/stable/2017-03-01/apimemailtemplate.json
- Microsoft.ApiManagement/stable/2017-03-01/apimgroups.json
- Microsoft.ApiManagement/stable/2017-03-01/apimidentityprovider.json
- Microsoft.ApiManagement/stable/2017-03-01/apimloggers.json
- Microsoft.ApiManagement/stable/2017-03-01/apimnotifications.json
- Microsoft.ApiManagement/stable/2017-03-01/apimnetworkstatus.json
- Microsoft.ApiManagement/stable/2017-03-01/apimopenidconnectproviders.json
- Microsoft.ApiManagement/stable/2017-03-01/apimportalsettings.json
- Microsoft.ApiManagement/stable/2017-03-01/apimproducts.json
- Microsoft.ApiManagement/stable/2017-03-01/apimproperties.json
- Microsoft.ApiManagement/stable/2017-03-01/apimquotas.json
- Microsoft.ApiManagement/stable/2017-03-01/apimreports.json
- Microsoft.ApiManagement/stable/2017-03-01/apimsubscriptions.json
- Microsoft.ApiManagement/stable/2017-03-01/apimtagresources.json
- Microsoft.ApiManagement/stable/2017-03-01/apimtags.json
- Microsoft.ApiManagement/stable/2017-03-01/apimtenant.json
- Microsoft.ApiManagement/stable/2017-03-01/apimusers.json
- Microsoft.ApiManagement/stable/2017-03-01/apimversionsets.json
```


### Tag: package-2016-10

These settings apply only when `--tag=package-2016-10` is specified on the command line.

``` yaml $(tag) == 'package-2016-10'
input-file:
- Microsoft.ApiManagement/stable/2016-10-10/apimanagement.json
- Microsoft.ApiManagement/stable/2016-10-10/apimapis.json
- Microsoft.ApiManagement/stable/2016-10-10/apimauthorizationservers.json
- Microsoft.ApiManagement/stable/2016-10-10/apimbackends.json
- Microsoft.ApiManagement/stable/2016-10-10/apimcertificates.json
- Microsoft.ApiManagement/stable/2016-10-10/apimdeployment.json
- Microsoft.ApiManagement/stable/2016-10-10/apimgroups.json
- Microsoft.ApiManagement/stable/2016-10-10/apimidentityprovider.json
- Microsoft.ApiManagement/stable/2016-10-10/apimloggers.json
- Microsoft.ApiManagement/stable/2016-10-10/apimnetworkstatus.json
- Microsoft.ApiManagement/stable/2016-10-10/apimopenidconnectproviders.json
- Microsoft.ApiManagement/stable/2016-10-10/apimproducts.json
- Microsoft.ApiManagement/stable/2016-10-10/apimproperties.json
- Microsoft.ApiManagement/stable/2016-10-10/apimquotas.json
- Microsoft.ApiManagement/stable/2016-10-10/apimreports.json
- Microsoft.ApiManagement/stable/2016-10-10/apimsubscriptions.json
- Microsoft.ApiManagement/stable/2016-10-10/apimtenant.json
- Microsoft.ApiManagement/stable/2016-10-10/apimusers.json
```

### Tag: package-2016-07

These settings apply only when `--tag=package-2016-07` is specified on the command line.

``` yaml $(tag) == 'package-2016-07'
input-file:
- Microsoft.ApiManagement/stable/2016-07-07/apimanagement.json
- Microsoft.ApiManagement/stable/2016-07-07/apimdeployment.json
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-node
    autorest_options:
      use: "@microsoft.azure/autorest.python@~3.0"
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_api_management']
```


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

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: apimanagement
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-01
  - tag: package-2017-03
  - tag: package-2016-10
  - tag: package-2016-07
```

### Tag: package-2018-01 and go

These settings apply only when `--tag=package-2018-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-01' && $(go)
output-folder: $(go-sdk-folder)/services/preview/apimanagement/mgmt/2018-01-01/apimanagement
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


## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  fluent: true
  namespace: com.microsoft.azure.management.apimanagement
  license-header: MICROSOFT_MIT_NO_CODEGEN
  payload-flattening-threshold: 1
  output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-apimanagement
```
