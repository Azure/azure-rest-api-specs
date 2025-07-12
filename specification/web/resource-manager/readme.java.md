## Java

These settings apply only when `--java` is specified on the command line.

```yaml $(java)
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

### Tag: profile-hybrid-2020-09-01 and java

These settings apply only when `--tag=profile-hybrid-2020-09-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'profile-hybrid-2020-09-01' && $(java)
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
  - from: CommonDefinitions.json
    where: $.definitions.Identifier.properties.properties.properties.id
    transform: >
      $['x-ms-client-name'] = "value";
```
