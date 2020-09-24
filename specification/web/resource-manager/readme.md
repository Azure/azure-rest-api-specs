# Web

> see https://aka.ms/autorest

This is the AutoRest configuration file for Web.


The App service RP comprises of services where each service has its own tag.
Hence, each sub-service has its own swagger spec.

All of them are tied together using this configuration and are packaged together into one compute client library.
This makes it easier for customers to download one (NuGet/npm/pip/maven/gem) compute client library package rather than installing individual packages for each sub service.


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
tag: package-2019-08
```

### Suppression

``` yaml
directive:
  - suppress: XmsResourceInPutResponse
    from: WebApps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/functions/{functionName}/keys/{keyName}"].put
    reason: Model type is not an Azure resource
  - suppress: RequiredPropertiesMissingInResourceModel
    from: WebApps.json
    where: $.definitions.KeyInfo
    reason: Model type is not an Azure resource
  - suppress: BodyTopLevelProperties
    from: WebApps.json
    where: $.definitions.KeyInfo.properties
    reason: Model type is not an Azure resource
```

### Tag: package-2020-06
These settings apply only when `--tag=package-2020-06` or `--tag=package-2020-06-only` is specified on the command line.
NOTE: Currently these tags are the same, but it will need to be split if any files from folders other than 2019-08-01 are included.
``` yaml $(tag) == 'package-2020-06' || $(tag) == 'package-2020-06-only' 
input-file:
- Microsoft.CertificateRegistration/stable/2020-06-01/AppServiceCertificateOrders.json
- Microsoft.CertificateRegistration/stable/2020-06-01/CertificateRegistrationProvider.json
- Microsoft.DomainRegistration/stable/2020-06-01/Domains.json
- Microsoft.DomainRegistration/stable/2020-06-01/TopLevelDomains.json
- Microsoft.DomainRegistration/stable/2020-06-01/DomainRegistrationProvider.json
- Microsoft.Web/stable/2020-06-01/Certificates.json
- Microsoft.Web/stable/2020-06-01/CommonDefinitions.json
- Microsoft.Web/stable/2020-06-01/DeletedWebApps.json
- Microsoft.Web/stable/2020-06-01/Diagnostics.json
- Microsoft.Web/stable/2020-06-01/Provider.json
- Microsoft.Web/stable/2020-06-01/Recommendations.json
- Microsoft.Web/stable/2020-06-01/ResourceProvider.json
- Microsoft.Web/stable/2020-06-01/WebApps.json
- Microsoft.Web/stable/2020-06-01/StaticSites.json
- Microsoft.Web/stable/2020-06-01/AppServiceEnvironments.json
- Microsoft.Web/stable/2020-06-01/AppServicePlans.json
- Microsoft.Web/stable/2020-06-01/ResourceHealthMetadata.json
directive:
  # suppress each RPC 3016 error
- where: $.definitions.FunctionSecrets.properties.trigger_url
  suppress: R3016
  reason: This requires a breaking change in functions runtime API.
  approved-by: "@weidongxu-microsoft"
```

### Tag: package-2019-08

These settings apply only when `--tag=package-2019-08` or `--tag=package-2019-08-only` is specified on the command line.
NOTE: Currently these tags are the same, but it will need to be split if any files from folders other than 2019-08-01 are included.

``` yaml $(tag) == 'package-2019-08' || $(tag) == 'package-2019-08-only' 

input-file:
- Microsoft.CertificateRegistration/stable/2019-08-01/AppServiceCertificateOrders.json
- Microsoft.CertificateRegistration/stable/2019-08-01/CertificateRegistrationProvider.json
- Microsoft.DomainRegistration/stable/2019-08-01/Domains.json
- Microsoft.DomainRegistration/stable/2019-08-01/TopLevelDomains.json
- Microsoft.DomainRegistration/stable/2019-08-01/DomainRegistrationProvider.json
- Microsoft.Web/stable/2019-08-01/Certificates.json
- Microsoft.Web/stable/2019-08-01/CommonDefinitions.json
- Microsoft.Web/stable/2019-08-01/DeletedWebApps.json
- Microsoft.Web/stable/2019-08-01/Diagnostics.json
- Microsoft.Web/stable/2019-08-01/Provider.json
- Microsoft.Web/stable/2019-08-01/Recommendations.json
- Microsoft.Web/stable/2019-08-01/ResourceProvider.json
- Microsoft.Web/stable/2019-08-01/WebApps.json
- Microsoft.Web/stable/2019-08-01/StaticSites.json
- Microsoft.Web/stable/2019-08-01/AppServiceEnvironments.json
- Microsoft.Web/stable/2019-08-01/AppServicePlans.json
- Microsoft.Web/stable/2019-08-01/ResourceHealthMetadata.json
```

### Tag: package-2018-12

These settings apply only when `--tag=package-2018-12` is specified on the command line.

``` yaml $(tag) == 'package-2018-12'
input-file:
- Microsoft.CertificateRegistration/stable/2018-02-01/AppServiceCertificateOrders.json
- Microsoft.CertificateRegistration/stable/2018-02-01/CertificateRegistrationProvider.json
- Microsoft.DomainRegistration/stable/2018-02-01/Domains.json
- Microsoft.DomainRegistration/stable/2018-02-01/TopLevelDomains.json
- Microsoft.DomainRegistration/stable/2018-02-01/DomainRegistrationProvider.json
- Microsoft.Web/stable/2018-11-01/Certificates.json
- Microsoft.Web/stable/2018-02-01/CommonDefinitions.json
- Microsoft.Web/stable/2018-02-01/DeletedWebApps.json
- Microsoft.Web/stable/2018-02-01/Diagnostics.json
- Microsoft.Web/stable/2018-02-01/Provider.json
- Microsoft.Web/stable/2018-02-01/Recommendations.json
- Microsoft.Web/stable/2018-02-01/ResourceProvider.json
- Microsoft.Web/stable/2018-11-01/WebApps.json
- Microsoft.Web/stable/2018-02-01/AppServiceEnvironments.json
- Microsoft.Web/stable/2018-02-01/AppServicePlans.json
- Microsoft.Web/stable/2018-02-01/ResourceHealthMetadata.json
directive:
  # suppress each RPC 3019 error
- where: $.definitions.Identifier.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
```

### Tag: package-2018-11

These settings apply only when `--tag=package-2018-11` is specified on the command line.

``` yaml $(tag) == 'package-2018-11'
input-file:
- Microsoft.CertificateRegistration/stable/2018-02-01/AppServiceCertificateOrders.json
- Microsoft.CertificateRegistration/stable/2018-02-01/CertificateRegistrationProvider.json
- Microsoft.DomainRegistration/stable/2018-02-01/Domains.json
- Microsoft.DomainRegistration/stable/2018-02-01/TopLevelDomains.json
- Microsoft.DomainRegistration/stable/2018-02-01/DomainRegistrationProvider.json
- Microsoft.Web/stable/2018-11-01/Certificates.json
- Microsoft.Web/stable/2018-02-01/CommonDefinitions.json
- Microsoft.Web/stable/2018-02-01/DeletedWebApps.json
- Microsoft.Web/stable/2018-02-01/Diagnostics.json
- Microsoft.Web/stable/2018-02-01/Provider.json
- Microsoft.Web/stable/2018-02-01/Recommendations.json
- Microsoft.Web/stable/2018-02-01/ResourceProvider.json
- Microsoft.Web/stable/2018-02-01/WebApps.json
- Microsoft.Web/stable/2018-02-01/AppServiceEnvironments.json
- Microsoft.Web/stable/2018-02-01/AppServicePlans.json
- Microsoft.Web/stable/2018-02-01/ResourceHealthMetadata.json
directive:
  # suppress each RPC 3019 error
- where: $.definitions.Identifier.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
```

### Tag: package-2018-11-only

These settings apply only when `--tag=package-2018-11-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-11-only'
input-file:
- Microsoft.Web/stable/2018-11-01/Certificates.json
directive:
  # suppress each RPC 3019 error
- where: $.definitions.Identifier.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
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
- Microsoft.Web/stable/2018-02-01/ResourceHealthMetadata.json
directive:
  # suppress each RPC 3019 error
- where: $.definitions.Identifier.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
```

### Tag: package-2018-02-only

These settings apply only when `--tag=package-2018-02` is specified on the command line.

``` yaml $(tag) == 'package-2018-02-only'
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
- Microsoft.Web/stable/2018-02-01/ResourceHealthMetadata.json
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

### Tag: package-2016-09-only

These settings apply only when `--tag=package-2016-09-only` is specified on the command line.

``` yaml $(tag) == 'package-2016-09-only'
input-file:
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

### Tag: package-2016-08-only

These settings apply only when `--tag=package-2016-08-only` is specified on the command line.

``` yaml $(tag) == 'package-2016-08-only'
input-file:
- Microsoft.Web/stable/2016-08-01/WebApps.json
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

### Tag: package-2016-03-only

These settings apply only when `--tag=package-2016-03-only` is specified on the command line.

``` yaml $(tag) == 'package-2016-03-only'
input-file:
- Microsoft.Web/stable/2016-03-01/Certificates.json
- Microsoft.Web/stable/2016-03-01/CommonDefinitions.json
- Microsoft.Web/stable/2016-03-01/DeletedWebApps.json
- Microsoft.Web/stable/2016-03-01/Diagnostics.json
- Microsoft.Web/stable/2016-03-01/Provider.json
- Microsoft.Web/stable/2016-03-01/Recommendations.json
- Microsoft.Web/stable/2016-03-01/ResourceHealthMetadata.json
- Microsoft.Web/stable/2016-03-01/ResourceProvider.json
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

### Tag: package-2015-08-only

These settings apply only when `--tag=package-2015-08-only` is specified on the command line.

``` yaml $(tag) == 'package-2015-08-only'
input-file:
- Microsoft.CertificateRegistration/stable/2015-08-01/AppServiceCertificateOrders.json
- Microsoft.CertificateRegistration/stable/2015-08-01/CertificateRegistrationProvider.json
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

### Tag: package-2015-04-only

These settings apply only when `--tag=package-2015-04-only` is specified on the command line.

``` yaml $(tag) == 'package-2015-04-only'
input-file:
- Microsoft.DomainRegistration/stable/2015-04-01/Domains.json
- Microsoft.DomainRegistration/stable/2015-04-01/TopLevelDomains.json
- Microsoft.DomainRegistration/stable/2015-04-01/DomainRegistrationProvider.json
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

### Tag: package-2020-09-01-hybrid-profile

These settings apply only when `--tag=package-2020-09-01-hybrid-profile` is specified on the command line.

``` yaml $(tag) == 'package-2020-09-01-hybrid-profile'
input-file:
- Microsoft.Web/stable/2018-02-01/Certificates.json
- Microsoft.Web/stable/2018-02-01/WebApps.json
- Microsoft.Web/stable/2018-02-01/ResourceProvider.json
- Microsoft.Web/stable/2016-09-01/AppServicePlans.json
- Microsoft.Web/stable/2016-03-01/Provider.json
- Microsoft.Web/stable/2016-03-01/ResourceProvider.json
- Microsoft.Web/stable/2016-03-01/Recommendations.json
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
    autorest_options:
      use: "@microsoft.azure/autorest.python@4.0.70"
    after_scripts:
      - python ./scripts/multiapi_init_gen.py azure-mgmt-web
      - python ./scripts/trim_aio.py ./sdk/appservice/azure-mgmt-web
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_web']
  - repo: azure-resource-manager-schemas
    after_scripts:
      - node sdkauto_afterscript.js web/resource-manager
```

## Go

See configuration in [readme.go.md](./readme.go.md)


## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.appservice
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-appservice
directive:
  from: WebApps.json
  where: $.definitions.MSDeploy.properties.properties
  transform: >
    delete $.$ref;
    $['allOf'] = [{'$ref':'#/definitions/MSDeployCore'}];
    return $;
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-08
  - tag: package-2018-02
  - tag: package-2016-03-01-web
  - tag: package-2016-08-01-web
  - tag: package-2016-09-01-web
```

### Tag: package-2019-08 and java

These settings apply only when `--tag=package-2019-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.appservice.v2019_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/appservice/mgmt-v2019_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-02 and java

These settings apply only when `--tag=package-2018-02 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.appservice.v2018_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/appservice/mgmt-v2018_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-03-01-web and java

These settings apply only when `--tag=package-2016-03-01-web --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-03-01-web' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.appservice.v2016_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/appservice/mgmt-v2016_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-08-01-web and java

These settings apply only when `--tag=package-2016-08-01-web --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-08-01-web' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.appservice.v2016_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/appservice/mgmt-v2016_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-09-01-web and java

These settings apply only when `--tag=package-2016-09-01-web --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-09-01-web' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.appservice.v2016_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/appservice/mgmt-v2016_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-03-01-hybrid

These settings apply only when `--tag=package-2018-03-01-hybrid` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile for csharp code generation.

``` yaml $(tag) == 'package-2018-03-01-hybrid'
input-file:
- Microsoft.Web/stable/2016-03-01/Certificates.json
- Microsoft.Web/stable/2016-03-01/CommonDefinitions.json
- Microsoft.Web/stable/2016-08-01/WebApps.json
- Microsoft.Web/stable/2016-03-01/ResourceProvider.json
- Microsoft.Web/stable/2016-03-01/Provider.json
- Microsoft.Web/stable/2016-03-01/Recommendations.json
- Microsoft.Web/stable/2016-09-01/AppServiceEnvironments.json
- Microsoft.Web/stable/2016-09-01/AppServicePlans.json
```

### Tag: profile-hybrid-2019-03-01

These settings apply only when `--tag=profile-hybrid-2019-03-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2019-03-01'
input-file:
- Microsoft.Web/stable/2018-02-01/Certificates.json
- Microsoft.Web/stable/2018-02-01/CommonDefinitions.json
- Microsoft.Web/stable/2018-02-01/WebApps.json
- Microsoft.Web/stable/2018-02-01/ResourceProvider.json
- Microsoft.Web/stable/2018-02-01/AppServicePlans.json
- Microsoft.Web/stable/2018-02-01/Provider.json
- Microsoft.Web/stable/2018-02-01/ResourceProvider.json
- Microsoft.Web/stable/2018-02-01/Recommendations.json
```

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)

