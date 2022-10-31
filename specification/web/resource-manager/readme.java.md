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
service-name: AppService
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
  - tag: package-2020-09
  - tag: package-2019-08
  - tag: package-2018-02
  - tag: package-2016-03-01-web
  - tag: package-2016-08-01-web
  - tag: package-2016-09-01-web
```

### Tag: package-2020-09 and java

These settings apply only when `--tag=package-2020-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.appservice.v2020_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/appservice/mgmt-v2020_09_01
regenerate-manager: true
generate-interface: true
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

### Tag: profile-hybrid-2020-09-01 and java

These settings apply only when `--tag=profile-hybrid-2020-09-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'profile-hybrid-2020-09-01' && $(java)
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
