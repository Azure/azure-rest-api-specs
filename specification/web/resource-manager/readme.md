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
tag: package-2021-03
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
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: WebApps.json
    where: $.definitions.AzureActiveDirectoryLogin.properties.disableWWWAuthenticate
    reason: Property name contains WWW which is an acronym, so camel case does not apply here.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: WebApps.json
    where: $.definitions.AzureActiveDirectoryLogin.properties.disableWWWAuthenticate
    reason: Property name contains WWW which is an acronym, so camel case does not apply here.
```


### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

```yaml $(tag) == 'package-2021-03'
input-file:
  - Microsoft.CertificateRegistration/stable/2021-03-01/AppServiceCertificateOrders.json
  - Microsoft.CertificateRegistration/stable/2021-03-01/CertificateOrdersDiagnostics.json
  - Microsoft.CertificateRegistration/stable/2021-03-01/CertificateRegistrationProvider.json
  - Microsoft.DomainRegistration/stable/2021-03-01/Domains.json
  - Microsoft.DomainRegistration/stable/2021-03-01/TopLevelDomains.json
  - Microsoft.DomainRegistration/stable/2021-03-01/DomainRegistrationProvider.json
  - Microsoft.Web/stable/2021-03-01/AppServiceEnvironments.json
  - Microsoft.Web/stable/2021-03-01/AppServicePlans.json
  - Microsoft.Web/stable/2021-03-01/Certificates.json
  - Microsoft.Web/stable/2021-03-01/CommonDefinitions.json
  - Microsoft.Web/stable/2021-03-01/ContainerApps.json
  - Microsoft.Web/stable/2021-03-01/ContainerAppsRevisions.json
  - Microsoft.Web/stable/2021-03-01/DeletedWebApps.json
  - Microsoft.Web/stable/2021-03-01/Diagnostics.json
  - Microsoft.Web/stable/2021-03-01/Global.json
  - Microsoft.Web/stable/2021-03-01/KubeEnvironments.json
  - Microsoft.Web/stable/2021-03-01/Provider.json
  - Microsoft.Web/stable/2021-03-01/Recommendations.json
  - Microsoft.Web/stable/2021-03-01/ResourceHealthMetadata.json
  - Microsoft.Web/stable/2021-03-01/ResourceProvider.json
  - Microsoft.Web/stable/2021-03-01/StaticSites.json
  - Microsoft.Web/stable/2021-03-01/WebApps.json
directive:
  # suppress each RPC 3016 error
- where: $.definitions.FunctionSecrets.properties.trigger_url
  suppress: R3016
  reason: This requires a breaking change in functions runtime API.
- where: $.definitions.Identifier.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
- where: $.definitions.VnetGateway
  suppress: R4015
  reason: Does not have list operation
- where: $.definitions.VnetInfoResource
  suppress: R4015
  reason: Does not have list operation
- suppress: R4009
  from: AppServiceCertificateOrders.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CertificateOrdersDiagnostics.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CertificateRegistrationProvider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Domains.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: TopLevelDomains.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: DomainRegistrationProvider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Certificates.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CommonDefinitions.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: DeletedWebApps.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Diagnostics.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Global.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Provider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Recommendations.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: WebApps.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: StaticSites.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: AppServiceEnvironments.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: AppServicePlans.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: ResourceHealthMetadata.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: KubeEnvironments.json
  reason: SystemData will implement in next version.
- suppress: R4015
  from: WebApps.json
  where: $.definitions.NetworkFeatures
  reason: Will fix in next version
- suppress: R4019
  from: Recommendations.json
  reason: Will fix in next version
- suppress: R4019
  from: WebApps.json
  reason: Will fix in next version
- suppress: R3021
  from: WebApps.json
  reason: Will fix in next version
- suppress: R4011
  from: WebApps.json
  reason: Will fix in next version
- suppress: R4011
  from: AppServiceEnvironments.json
  reason: Will fix in next version
- suppress: R4011
  from: StaticSites.json
  reason: Will fix in next version
- suppress: R4011
  from: AppServicePlans.json
  reason: Will fix in next version
- suppress: D5001
  reason: Will fix in next version
- suppress: R1003
  reason: Will fix in next version
- suppress: R2001
  reason: Will fix in next version
- suppress: R2029
  reason: Will fix in next version
- suppress: R2063
  reason: Will fix in next version
- suppress: R3010
  reason: Will fix in next version
- where: $.definitions.TriggeredJobRun.properties.trigger_url
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- where: $.definitions.TriggeredJobRun.properties.web_job_name
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- where: $.definitions.TriggeredJobRun.properties.start_time
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- where: $.definitions.TriggeredJobRun.properties.end_time
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- where: $.definitions.TriggeredJobRun.properties.output_url
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- where: $.definitions.TriggeredJobRun.properties.error_url
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- where: $.definitions.TriggeredJobRun.properties.job_name
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- where: $.definitions.TriggeredJobRun.properties.web_job_id
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- suppress: R4009
  from: ContainerApps.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: ContainerAppsRevisions.json
  reason: SystemData will implement in next version.
- suppress: R3026
  from: ContainerApps.json
  reason: Patch operation will be implemented in later version.
- suppress: R3026
  from: ContainerAppsRevisions.json
  reason: Patch operation will be implemented in later version.
```

### Tag: package-2021-02

These settings apply only when `--tag=package-2021-02` is specified on the command line.

``` yaml $(tag) == 'package-2021-02' || $(tag) == 'package-2021-02-only'
input-file:
  - Microsoft.CertificateRegistration/stable/2021-02-01/AppServiceCertificateOrders.json
  - Microsoft.CertificateRegistration/stable/2021-02-01/CertificateOrdersDiagnostics.json
  - Microsoft.CertificateRegistration/stable/2021-02-01/CertificateRegistrationProvider.json
  - Microsoft.DomainRegistration/stable/2021-02-01/Domains.json
  - Microsoft.DomainRegistration/stable/2021-02-01/TopLevelDomains.json
  - Microsoft.DomainRegistration/stable/2021-02-01/DomainRegistrationProvider.json
  - Microsoft.Web/stable/2021-02-01/AppServiceEnvironments.json
  - Microsoft.Web/stable/2021-02-01/AppServicePlans.json
  - Microsoft.Web/stable/2021-02-01/Certificates.json
  - Microsoft.Web/stable/2021-02-01/CommonDefinitions.json
  - Microsoft.Web/stable/2021-02-01/DeletedWebApps.json
  - Microsoft.Web/stable/2021-02-01/Diagnostics.json
  - Microsoft.Web/stable/2021-02-01/Global.json
  - Microsoft.Web/stable/2021-02-01/KubeEnvironments.json
  - Microsoft.Web/stable/2021-02-01/Provider.json
  - Microsoft.Web/stable/2021-02-01/Recommendations.json
  - Microsoft.Web/stable/2021-02-01/ResourceHealthMetadata.json
  - Microsoft.Web/stable/2021-02-01/ResourceProvider.json
  - Microsoft.Web/stable/2021-02-01/StaticSites.json
  - Microsoft.Web/stable/2021-02-01/WebApps.json
directive:
  # suppress each RPC 3016 error
- where: $.definitions.FunctionSecrets.properties.trigger_url
  suppress: R3016
  reason: This requires a breaking change in functions runtime API.
- where: $.definitions.Identifier.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
- where: $.definitions.VnetGateway
  suppress: R4015
  reason: Does not have list operation
- where: $.definitions.VnetInfoResource
  suppress: R4015
  reason: Does not have list operation
- suppress: R4009
  from: AppServiceCertificateOrders.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CertificateOrdersDiagnostics.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CertificateRegistrationProvider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Domains.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: TopLevelDomains.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: DomainRegistrationProvider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Certificates.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CommonDefinitions.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: DeletedWebApps.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Diagnostics.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Global.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Provider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Recommendations.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: WebApps.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: StaticSites.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: AppServiceEnvironments.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: AppServicePlans.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: ResourceHealthMetadata.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: KubeEnvironments.json
  reason: SystemData will implement in next version.
- suppress: R4015
  from: WebApps.json
  where: $.definitions.NetworkFeatures
  reason: Will fix in next version
- suppress: R4019
  from: Recommendations.json
  reason: Will fix in next version
- suppress: R4019
  from: WebApps.json
  reason: Will fix in next version
- suppress: R3021
  from: WebApps.json
  reason: Will fix in next version
- suppress: R4011
  from: WebApps.json
  reason: Will fix in next version
- suppress: R4011
  from: AppServiceEnvironments.json
  reason: Will fix in next version
- suppress: R4011
  from: StaticSites.json
  reason: Will fix in next version
- suppress: R4011
  from: AppServicePlans.json
  reason: Will fix in next version
- suppress: D5001
  reason: Will fix in next version
- suppress: R1003
  reason: Will fix in next version
- suppress: R2001
  reason: Will fix in next version
- suppress: R2029
  reason: Will fix in next version
- suppress: R2063
  reason: Will fix in next version
- suppress: R3010
  reason: Will fix in next version
- where: $.definitions.TriggeredJobRun.properties.trigger_url
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- where: $.definitions.TriggeredJobRun.properties.web_job_name
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- where: $.definitions.TriggeredJobRun.properties.start_time
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- where: $.definitions.TriggeredJobRun.properties.end_time
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- where: $.definitions.TriggeredJobRun.properties.output_url
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- where: $.definitions.TriggeredJobRun.properties.error_url
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- where: $.definitions.TriggeredJobRun.properties.job_name
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
- where: $.definitions.TriggeredJobRun.properties.web_job_id
  suppress: R3016
  reason: This requires a breaking change in kudu runtime API.
```

### Tag: package-2021-01-15

These settings apply only when `--tag=package-2021-01-15` is specified on the command line.

``` yaml $(tag) == 'package-2021-01-15' || $(tag) == 'package-2021-01-15-only'
input-file:
  - Microsoft.CertificateRegistration/stable/2021-01-15/AppServiceCertificateOrders.json
  - Microsoft.CertificateRegistration/stable/2021-01-15/CertificateOrdersDiagnostics.json
  - Microsoft.CertificateRegistration/stable/2021-01-15/CertificateRegistrationProvider.json
  - Microsoft.DomainRegistration/stable/2021-01-15/Domains.json
  - Microsoft.DomainRegistration/stable/2021-01-15/TopLevelDomains.json
  - Microsoft.DomainRegistration/stable/2021-01-15/DomainRegistrationProvider.json
  - Microsoft.Web/stable/2021-01-15/AppServiceEnvironments.json
  - Microsoft.Web/stable/2021-01-15/AppServicePlans.json
  - Microsoft.Web/stable/2021-01-15/Certificates.json
  - Microsoft.Web/stable/2021-01-15/CommonDefinitions.json
  - Microsoft.Web/stable/2021-01-15/DeletedWebApps.json
  - Microsoft.Web/stable/2021-01-15/Diagnostics.json
  - Microsoft.Web/stable/2021-01-15/Global.json
  - Microsoft.Web/stable/2021-01-15/KubeEnvironments.json
  - Microsoft.Web/stable/2021-01-15/Provider.json
  - Microsoft.Web/stable/2021-01-15/Recommendations.json
  - Microsoft.Web/stable/2021-01-15/ResourceHealthMetadata.json
  - Microsoft.Web/stable/2021-01-15/ResourceProvider.json
  - Microsoft.Web/stable/2021-01-15/StaticSites.json
  - Microsoft.Web/stable/2021-01-15/WebApps.json
directive:
  # suppress each RPC 3016 error
- where: $.definitions.FunctionSecrets.properties.trigger_url
  suppress: R3016
  reason: This requires a breaking change in functions runtime API.
- where: $.definitions.Identifier.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
- where: $.definitions.VnetGateway
  suppress: R4015
  reason: Does not have list operation
- where: $.definitions.VnetInfo
  suppress: R4015
  reason: Does not have list operation
- suppress: R4009
  from: AppServiceCertificateOrders.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CertificateOrdersDiagnostics.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CertificateRegistrationProvider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Domains.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: TopLevelDomains.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: DomainRegistrationProvider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Certificates.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CommonDefinitions.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: DeletedWebApps.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Diagnostics.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Global.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Provider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Recommendations.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: WebApps.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: StaticSites.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: AppServiceEnvironments.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: AppServicePlans.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: ResourceHealthMetadata.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: KubeEnvironments.json
  reason: SystemData will implement in next version.
- suppress: R4015
  from: WebApps.json
  where: $.definitions.NetworkFeatures
  reason: Will fix in next version
- suppress: R4019
  from: Recommendations.json
  reason: Will fix in next version
- suppress: R4019
  from: WebApps.json
  reason: Will fix in next version
- suppress: R3021
  from: WebApps.json
  reason: Will fix in next version
- suppress: R4011
  from: WebApps.json
  reason: Will fix in next version
- suppress: R4011
  from: AppServiceEnvironments.json
  reason: Will fix in next version
- suppress: R4011
  from: StaticSites.json
  reason: Will fix in next version
- suppress: R4011
  from: AppServicePlans.json
  reason: Will fix in next version
- suppress: D5001
  reason: Will fix in next version
- suppress: R1003
  reason: Will fix in next version
- suppress: R2001
  reason: Will fix in next version
- suppress: R2029
  reason: Will fix in next version
- suppress: R2063
  reason: Will fix in next version
- suppress: R3010
  reason: Will fix in next version
```

### Tag: package-2021-01

These settings apply only when `--tag=package-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-01' || $(tag) == 'package-2021-01-only'
input-file:
  - Microsoft.CertificateRegistration/stable/2021-01-01/AppServiceCertificateOrders.json
  - Microsoft.CertificateRegistration/stable/2021-01-01/CertificateOrdersDiagnostics.json
  - Microsoft.CertificateRegistration/stable/2021-01-01/CertificateRegistrationProvider.json
  - Microsoft.DomainRegistration/stable/2021-01-01/Domains.json
  - Microsoft.DomainRegistration/stable/2021-01-01/TopLevelDomains.json
  - Microsoft.DomainRegistration/stable/2021-01-01/DomainRegistrationProvider.json
  - Microsoft.Web/stable/2021-01-01/AppServiceEnvironments.json
  - Microsoft.Web/stable/2021-01-01/AppServicePlans.json
  - Microsoft.Web/stable/2021-01-01/Certificates.json
  - Microsoft.Web/stable/2021-01-01/CommonDefinitions.json
  - Microsoft.Web/stable/2021-01-01/DeletedWebApps.json
  - Microsoft.Web/stable/2021-01-01/Diagnostics.json
  - Microsoft.Web/stable/2021-01-01/Global.json
  - Microsoft.Web/stable/2021-01-01/Provider.json
  - Microsoft.Web/stable/2021-01-01/Recommendations.json
  - Microsoft.Web/stable/2021-01-01/ResourceHealthMetadata.json
  - Microsoft.Web/stable/2021-01-01/ResourceProvider.json
  - Microsoft.Web/stable/2021-01-01/StaticSites.json
  - Microsoft.Web/stable/2021-01-01/WebApps.json
  - Microsoft.Web/stable/2021-01-01/KubeEnvironments.json
directive:
  # suppress each RPC 3016 error
- where: $.definitions.FunctionSecrets.properties.trigger_url
  suppress: R3016
  reason: This requires a breaking change in functions runtime API.
- where: $.definitions.Identifier.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
- where: $.definitions.VnetGateway
  suppress: R4015
  reason: Does not have list operation
- where: $.definitions.VnetInfo
  suppress: R4015
  reason: Does not have list operation
- suppress: R4009
  from: AppServiceCertificateOrders.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CertificateOrdersDiagnostics.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CertificateRegistrationProvider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Domains.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: TopLevelDomains.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: DomainRegistrationProvider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Certificates.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CommonDefinitions.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: DeletedWebApps.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Diagnostics.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Global.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Provider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Recommendations.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: WebApps.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: StaticSites.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: AppServiceEnvironments.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: AppServicePlans.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: ResourceHealthMetadata.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: KubeEnvironments.json
  reason: SystemData will implement in next version.
```

### Tag: package-2020-12

These settings apply only when `--tag=package-2020-12` or `--tag=package-2020-12-only` is specified on the command line.
NOTE: Currently these tags are the same, but it will need to be split if any files from folders other than 2020-06-01 are included.

``` yaml $(tag) == 'package-2020-12' || $(tag) == 'package-2020-12-only'
input-file:
- Microsoft.CertificateRegistration/stable/2020-12-01/AppServiceCertificateOrders.json
- Microsoft.CertificateRegistration/stable/2020-12-01/CertificateOrdersDiagnostics.json
- Microsoft.CertificateRegistration/stable/2020-12-01/CertificateRegistrationProvider.json
- Microsoft.DomainRegistration/stable/2020-12-01/Domains.json
- Microsoft.DomainRegistration/stable/2020-12-01/TopLevelDomains.json
- Microsoft.DomainRegistration/stable/2020-12-01/DomainRegistrationProvider.json
- Microsoft.Web/stable/2020-12-01/Certificates.json
- Microsoft.Web/stable/2020-12-01/CommonDefinitions.json
- Microsoft.Web/stable/2020-12-01/DeletedWebApps.json
- Microsoft.Web/stable/2020-12-01/Diagnostics.json
- Microsoft.Web/stable/2020-12-01/Global.json
- Microsoft.Web/stable/2020-12-01/Provider.json
- Microsoft.Web/stable/2020-12-01/Recommendations.json
- Microsoft.Web/stable/2020-12-01/ResourceProvider.json
- Microsoft.Web/stable/2020-12-01/WebApps.json
- Microsoft.Web/stable/2020-12-01/StaticSites.json
- Microsoft.Web/stable/2020-12-01/AppServiceEnvironments.json
- Microsoft.Web/stable/2020-12-01/AppServicePlans.json
- Microsoft.Web/stable/2020-12-01/ResourceHealthMetadata.json
directive:
  # suppress each RPC 3016 error
- where: $.definitions.FunctionSecrets.properties.trigger_url
  suppress: R3016
  reason: This requires a breaking change in functions runtime API.
- where: $.definitions.Identifier.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
- where: $.definitions.VnetGateway
  suppress: R4015
  reason: Does not have list operation
- where: $.definitions.VnetInfo
  suppress: R4015
  reason: Does not have list operation
- suppress: R4009
  from: AppServiceCertificateOrders.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CertificateOrdersDiagnostics.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CertificateRegistrationProvider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Domains.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: TopLevelDomains.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: DomainRegistrationProvider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Certificates.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: CommonDefinitions.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: DeletedWebApps.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Diagnostics.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Global.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Provider.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: Recommendations.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: WebApps.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: StaticSites.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: AppServiceEnvironments.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: AppServicePlans.json
  reason: SystemData will implement in next version.
- suppress: R4009
  from: ResourceHealthMetadata.json
  reason: SystemData will implement in next version.
```

### Tag: package-2020-10

These settings apply only when `--tag=package-2020-10` or `--tag=package-2020-10-only` is specified on the command line.
NOTE: Currently these tags are the same, but it will need to be split if any files from folders other than 2020-06-01 are included.

``` yaml $(tag) == 'package-2020-10' || $(tag) == 'package-2020-10-only'
input-file:
- Microsoft.CertificateRegistration/stable/2020-10-01/AppServiceCertificateOrders.json
- Microsoft.CertificateRegistration/stable/2020-10-01/CertificateRegistrationProvider.json
- Microsoft.DomainRegistration/stable/2020-10-01/Domains.json
- Microsoft.DomainRegistration/stable/2020-10-01/TopLevelDomains.json
- Microsoft.DomainRegistration/stable/2020-10-01/DomainRegistrationProvider.json
- Microsoft.Web/stable/2020-10-01/Certificates.json
- Microsoft.Web/stable/2020-10-01/CommonDefinitions.json
- Microsoft.Web/stable/2020-10-01/DeletedWebApps.json
- Microsoft.Web/stable/2020-10-01/Diagnostics.json
- Microsoft.Web/stable/2020-10-01/Provider.json
- Microsoft.Web/stable/2020-10-01/Recommendations.json
- Microsoft.Web/stable/2020-10-01/ResourceProvider.json
- Microsoft.Web/stable/2020-10-01/WebApps.json
- Microsoft.Web/stable/2020-10-01/StaticSites.json
- Microsoft.Web/stable/2020-10-01/AppServiceEnvironments.json
- Microsoft.Web/stable/2020-10-01/AppServicePlans.json
- Microsoft.Web/stable/2020-10-01/ResourceHealthMetadata.json
directive:
  # suppress each RPC 3016 error
- where: $.definitions.FunctionSecrets.properties.trigger_url
  suppress: R3016
  reason: This requires a breaking change in functions runtime API.
- where: $.definitions.Identifier.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
- where: $.definitions.VnetGateway
  suppress: R4015
  reason: Does not have list operation
- where: $.definitions.VnetInfo
  suppress: R4015
  reason: Does not have list operation
```

### Tag: package-2020-09

These settings apply only when `--tag=package-2020-09` or `--tag=package-2020-09-only` is specified on the command line.
NOTE: Currently these tags are the same, but it will need to be split if any files from folders other than 2020-06-01 are included.

``` yaml $(tag) == 'package-2020-09' || $(tag) == 'package-2020-09-only'
input-file:
- Microsoft.CertificateRegistration/stable/2020-09-01/AppServiceCertificateOrders.json
- Microsoft.CertificateRegistration/stable/2020-09-01/CertificateRegistrationProvider.json
- Microsoft.DomainRegistration/stable/2020-09-01/Domains.json
- Microsoft.DomainRegistration/stable/2020-09-01/TopLevelDomains.json
- Microsoft.DomainRegistration/stable/2020-09-01/DomainRegistrationProvider.json
- Microsoft.Web/stable/2020-09-01/Certificates.json
- Microsoft.Web/stable/2020-09-01/CommonDefinitions.json
- Microsoft.Web/stable/2020-09-01/DeletedWebApps.json
- Microsoft.Web/stable/2020-09-01/Diagnostics.json
- Microsoft.Web/stable/2020-09-01/Provider.json
- Microsoft.Web/stable/2020-09-01/Recommendations.json
- Microsoft.Web/stable/2020-09-01/ResourceProvider.json
- Microsoft.Web/stable/2020-09-01/WebApps.json
- Microsoft.Web/stable/2020-09-01/StaticSites.json
- Microsoft.Web/stable/2020-09-01/AppServiceEnvironments.json
- Microsoft.Web/stable/2020-09-01/AppServicePlans.json
- Microsoft.Web/stable/2020-09-01/ResourceHealthMetadata.json
directive:
  # suppress each RPC 3016 error
- where: $.definitions.FunctionSecrets.properties.trigger_url
  suppress: R3016
  reason: This requires a breaking change in functions runtime API.
  approved-by: "@weidongxu-microsoft"
- where: $.definitions.Identifier.properties
  suppress: R3019
  reason: It's an old API, will resolve in next API version
  approved-by: "@ravbhatnagar"
- where: $.definitions.VnetGateway
  suppress: R4015
  reason: Does not have list operation
  approved-by: "@mark.cowlishaw"
- where: $.definitions.VnetInfo
  suppress: R4015
  reason: Does not have list operation
  approved-by: "@mark.cowlishaw"
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

### Tag: package-2016-06-01

These settings apply only when `--tag=package-2016-06-01` is specified on the command line.

``` yaml $(tag) == 'package-2016-06-01'
input-file:
- Microsoft.Web/stable/2016-06-01/logicAppsManagementClient.json
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
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_web']
  - repo: azure-resource-manager-schemas
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

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

### Tag: profile-hybrid-2020-09-01

These settings apply only when `--tag=profile-hybrid-2020-09-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2020-09-01'
input-file:
- Microsoft.Web/stable/2018-02-01/Certificates.json
- Microsoft.Web/stable/2018-02-01/WebApps.json
- Microsoft.Web/stable/2018-02-01/ResourceProvider.json
- Microsoft.Web/stable/2018-02-01/AppServicePlans.json
- Microsoft.Web/stable/2018-02-01/Provider.json
- Microsoft.Web/stable/2018-02-01/ResourceProvider.json
- Microsoft.Web/stable/2018-02-01/Recommendations.json
```
