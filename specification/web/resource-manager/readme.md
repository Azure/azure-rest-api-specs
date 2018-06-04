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

### Tag: package-2018-02

These settings apply only when `--tag=package-2018-02` is specified on the command line.

``` yaml $(tag) == 'package-2018-02'
input-file:
- Microsoft.CertificateRegistration/stable/2018-02-01/AppServiceCertificateOrders.json
- Microsoft.CertificateRegistration/stable/2018-02-01/CertificateRegistrationProvider.json
- Microsoft.DomainRegistration/stable/2018-02-01/Domains.json
- Microsoft.DomainRegistration/stable/2018-02-01/TopLevelDomains.json
- Microsoft.DomainRegistration/stable/2018-02-01/DomainRegistrationProvider.json
- Microsoft.Web/stable/2018-02-01/Certificates.json
- Microsoft.Web/stable/2018-02-01/CommonDefinitions.json
- Microsoft.Web/stable/2018-02-01/DeletedWebApps.json
- Microsoft.Web/stable/2018-02-01/Diagnostics.json
- Microsoft.Web/stable/2018-02-01/Provider.json
- Microsoft.Web/stable/2018-02-01/Recommendations.json
- Microsoft.Web/stable/2018-02-01/ResourceProvider.json
- Microsoft.Web/stable/2018-02-01/WebApps.json
- Microsoft.Web/stable/2018-02-01/AppServiceEnvironments.json
- Microsoft.Web/stable/2018-02-01/AppServicePlans.json
directive:
  # suppress each RPC 3019 error
- where: $.definitions.Identifier.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
```


### Tag: package-2016-09

These settings apply only when `--tag=package-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-2016-09'
input-file:
- Microsoft.CertificateRegistration/stable/2015-08-01/AppServiceCertificateOrders.json
- Microsoft.CertificateRegistration/stable/2015-08-01/CertificateRegistrationProvider.json
- Microsoft.DomainRegistration/stable/2015-04-01/Domains.json
- Microsoft.DomainRegistration/stable/2015-04-01/TopLevelDomains.json
- Microsoft.DomainRegistration/stable/2015-04-01/DomainRegistrationProvider.json
- Microsoft.Web/stable/2016-03-01/Certificates.json
- Microsoft.Web/stable/2016-03-01/CommonDefinitions.json
- Microsoft.Web/stable/2016-03-01/DeletedWebApps.json
- Microsoft.Web/stable/2016-03-01/Diagnostics.json
- Microsoft.Web/stable/2016-03-01/Provider.json
- Microsoft.Web/stable/2016-03-01/Recommendations.json
- Microsoft.Web/stable/2016-03-01/ResourceHealthMetadata.json
- Microsoft.Web/stable/2016-03-01/ResourceProvider.json
- Microsoft.Web/stable/2016-08-01/WebApps.json
- Microsoft.Web/stable/2016-09-01/AppServiceEnvironments.json
- Microsoft.Web/stable/2016-09-01/AppServicePlans.json
directive:
  # suppress each RPC 3019 error
- where: $.definitions.User.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.SourceControl.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.BackupRequest.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.Deployment.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.Identifier.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.PremierAddOn.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.SiteExtensionInfo.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.AppServicePlan.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.VnetRoute.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.FunctionEnvelope.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.CertificateOrderAction.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.ResourceMetricDefinition.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.TopLevelDomain.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.GeoRegion.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.PremierAddOnOffer.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.ContinuousWebJob.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.ProcessInfo.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.ProcessThreadInfo.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.SiteConfigurationSnapshotInfo.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.SiteInstance.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.SlotDifference.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.TriggeredJobRun.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.TriggeredWebJob.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.WebJob.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.MetricDefinition.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.Usage.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.AppServicePlanPatchResource.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
```

### Tag: package-2015-08-preview

These settings apply only when `--tag=package-2015-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-08-preview'
input-file:
- Microsoft.Web/stable/2015-08-01/service.json
- Microsoft.Web/preview/2015-08-01-preview/logicAppsManagementClient.json
```

### Tag: package-2015-08-certificate-registration

These settings apply only when `--tag=package-2015-08-certificate-registration` is specified on the command line.

``` yaml $(tag) == 'package-2015-08-certificate-registration'
input-file:
- Microsoft.CertificateRegistration/stable/2015-08-01/AppServiceCertificateOrders.json
- Microsoft.CertificateRegistration/stable/2015-08-01/CertificateRegistrationProvider.json
```

### Tag: package-2015-04-domain-registration

These settings apply only when `--tag=package-2015-04-domain-registration` is specified on the command line.

``` yaml $(tag) == 'package-2015-04-domain-registration'
input-file:
- Microsoft.DomainRegistration/stable/2015-04-01/Domains.json
- Microsoft.DomainRegistration/stable/2015-04-01/TopLevelDomains.json
- Microsoft.DomainRegistration/stable/2015-04-01/DomainRegistrationProvider.json
```

### Tag: package-2016-09-01-web

These settings apply only when `--tag=package-2016-09-01-web` is specified on the command line.

``` yaml $(tag) == 'package-2016-09-01-web'
input-file:
- Microsoft.Web/stable/2016-09-01/AppServiceEnvironments.json
- Microsoft.Web/stable/2016-09-01/AppServicePlans.json
```

### Tag: package-2016-08-01-web

These settings apply only when `--tag=package-2016-08-01-web` is specified on the command line.

``` yaml $(tag) == 'package-2016-08-01-web'
input-file:
- Microsoft.Web/stable/2016-08-01/WebApps.json
```

### Tag: package-2016-03-01-web

These settings apply only when `--tag=package-2016-03-01-web` is specified on the command line.

``` yaml $(tag) == 'package-2016-03-01-web'
input-file:
- Microsoft.Web/stable/2016-03-01/Certificates.json
- Microsoft.Web/stable/2016-03-01/CommonDefinitions.json
- Microsoft.Web/stable/2016-03-01/DeletedWebApps.json
- Microsoft.Web/stable/2016-03-01/Diagnostics.json
- Microsoft.Web/stable/2016-03-01/Provider.json
- Microsoft.Web/stable/2016-03-01/Recommendations.json
- Microsoft.Web/stable/2016-03-01/ResourceHealthMetadata.json
- Microsoft.Web/stable/2016-03-01/ResourceProvider.json
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-libraries-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_web']
```



## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.web
  package-name: azure-mgmt-web
  package-version: 0.36.0
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt-web/azure/mgmt/web
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-web
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: web
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-02
  - tag: package-2016-09
  - tag: package-2015-08-preview
```

### Tag: package-2018-02 and go

These settings apply only when `--tag=package-2018-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-02' && $(go)
output-folder: $(go-sdk-folder)/services/web/mgmt/2018-02-01/web
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
output-folder: $(go-sdk-folder)/services/preview/web/mgmt/2015-08-preview/web
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


## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  fluent: true
  namespace: com.microsoft.azure.management.web
  license-header: MICROSOFT_MIT_NO_CODEGEN
  payload-flattening-threshold: 1
  output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-web
```
