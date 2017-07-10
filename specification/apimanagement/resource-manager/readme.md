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
tag: package-2016-10
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
## Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

