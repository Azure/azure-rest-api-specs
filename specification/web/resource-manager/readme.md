# Web
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Web.


The App service RP comprises of services where each service has its own tag.
Hence, each sub-service has its own swagger spec. 

All of them are tied together using this configuration and are packaged together into one compute client library.
This makes it easier for customers to download one (nuget/npm/pip/maven/gem) compute client library package rather than installing individual packages for each sub service.


---
## Getting Started 
To build the SDK for Web, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Web API.

``` yaml
title: WebSiteManagementClient
description: WebSite Management Client
openapi-type: arm
tag: package-2016-09
```


### Tag: package-2016-09

These settings apply only when `--tag=package-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-2016-09'
input-file:
- Microsoft.CertificateRegistration/2015-08-01/AppServiceCertificateOrders.json
- Microsoft.DomainRegistration/2015-04-01/Domains.json
- Microsoft.DomainRegistration/2015-04-01/TopLevelDomains.json
- Microsoft.Web/2016-03-01/Certificates.json
- Microsoft.Web/2016-03-01/CommonDefinitions.json
- Microsoft.Web/2016-03-01/DeletedWebApps.json
- Microsoft.Web/2016-03-01/Provider.json
- Microsoft.Web/2016-03-01/Recommendations.json
- Microsoft.Web/2016-03-01/ResourceProvider.json
- Microsoft.Web/2016-08-01/WebApps.json
- Microsoft.Web/2016-09-01/AppServiceEnvironments.json
- Microsoft.Web/2016-09-01/AppServicePlans.json
```
 
### Tag: package-2015-08-preview

These settings apply only when `--tag=package-2015-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-08-preview'
input-file:
- Microsoft.Web/2015-08-01/service.json
- Microsoft.Web/2015-08-01-preview/logicAppsManagementClient.json
```


---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # last generated with commit e416af734666d658a04530df605f60480c01cc10
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.WebSites
  output-folder: $(csharp-sdks-folder)/WebSites/Management.WebSites/Generated
  clear-output-folder: true
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: web
  clear-output-folder: true
```

### Tag: package-2016-09 and go

These settings apply only when `--tag=package-2016-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-09' && $(go)
output-folder: $(go-sdk-folder)/services/web/mgmt/2016-09-01/web
```

### Tag: package-2015-08-preview and go

These settings apply only when `--tag=package-2015-08-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-08-preview' && $(go)
output-folder: $(go-sdk-folder)/services/web/mgmt/2015-08-preview/web
```


## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python:
  # override the default output folder
  output-folder: $(output-folder)/python
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.web
```
