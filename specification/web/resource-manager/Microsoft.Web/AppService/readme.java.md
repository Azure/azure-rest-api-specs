## Java

These settings apply only when `--java` is specified on the command line.

```yaml $(java)
title: WebSiteManagementClient
service-name: AppService
add-inner: AppServiceCertificate
remove-inner: CsmDeploymentStatus
name-for-ungrouped-operations: ResourceProvider
enable-sync-stack: false
directive:
  - from: WebApps.json
    where: $.definitions.MSDeploy.properties.properties
    transform: >
      delete $.$ref;
      $['allOf'] = [{'$ref':'#/definitions/MSDeployCore'}];
      return $;
  - from: WebApps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/appsettings"].put
    transform: >
      $["x-ms-long-running-operation"] = true;
    reason: Swagger bug. Function App on ACA is LRO.
  - from: WebApps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/appsettings"].put.responses
    transform: >
      $["202"] = {
              "description": "Operation is in progress.",
              "schema": {
                "$ref": "./CommonDefinitions.json#/definitions/StringDictionary"
              }
            };
    reason: Swagger bug. Function App on ACA is LRO.
  - from: WebApps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/web"].put
    transform: >
      $["x-ms-long-running-operation"] = true;
    reason: Swagger bug. Function App on ACA is LRO.
  - from: WebApps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/web"].put.responses
    transform: >
      $["202"] = {
              "description": "Operation is in progress.",
              "schema": {
                "$ref": "#/definitions/SiteConfigResource"
              }
            };
    reason: Swagger bug. Function App on ACA is LRO.
  - from: WebApps.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}"].patch
    transform: >
      $["x-ms-long-running-operation"] = true;
    reason: Swagger bug. Function App on ACA is LRO.
```

### Tag: package-2025-03 and java

``` yaml $(java) && $(tag) == 'package-2025-03'
input-file:
  - ../../../../certificateregistration/resource-manager/Microsoft.CertificateRegistration/CertificateRegistration/stable/2024-11-01/AppServiceCertificateOrders.json
  - ../../../../certificateregistration/resource-manager/Microsoft.CertificateRegistration/CertificateRegistration/stable/2024-11-01/CertificateOrdersDiagnostics.json
  - ../../../../certificateregistration/resource-manager/Microsoft.CertificateRegistration/CertificateRegistration/stable/2024-11-01/CertificateRegistrationProvider.json
  - ../../../../domainregistration/resource-manager/Microsoft.DomainRegistration/DomainRegistration/stable/2024-11-01/DomainRegistrationProvider.json
  - ../../../../domainregistration/resource-manager/Microsoft.DomainRegistration/DomainRegistration/stable/2024-11-01/Domains.json
  - ../../../../domainregistration/resource-manager/Microsoft.DomainRegistration/DomainRegistration/stable/2024-11-01/TopLevelDomains.json
```

### Tag: profile-hybrid-2020-09-01 and java

These settings apply only when `--tag=profile-hybrid-2020-09-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'profile-hybrid-2020-09-01' && $(java)
input-file:
- stable/2018-02-01/Certificates.json
- stable/2018-02-01/CommonDefinitions.json
- stable/2018-02-01/DeletedWebApps.json
- stable/2018-02-01/Diagnostics.json
- stable/2018-02-01/Provider.json
- stable/2018-02-01/Recommendations.json
- stable/2018-02-01/ResourceProvider.json
- stable/2018-02-01/WebApps.json
- stable/2018-02-01/AppServiceEnvironments.json
- stable/2018-02-01/AppServicePlans.json
- stable/2018-02-01/ResourceHealthMetadata.json
directive:
  - from: CommonDefinitions.json
    where: $.definitions.Identifier.properties.properties.properties.id
    transform: >
      $['x-ms-client-name'] = "value";
```
