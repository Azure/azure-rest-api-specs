## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

### Tag: package-2025-03-python

``` yaml $(tag) == 'package-2025-03-python'
input-file:
  - stable/2025-03-01/AppServiceEnvironments.json
  - stable/2025-03-01/AppServicePlans.json
  - stable/2025-03-01/Certificates.json
  - stable/2025-03-01/CommonDefinitions.json
  - stable/2025-03-01/DeletedWebApps.json
  - stable/2025-03-01/Diagnostics.json
  - stable/2025-03-01/Global.json
  - stable/2025-03-01/KubeEnvironments.json
  - stable/2025-03-01/Provider.json
  - stable/2025-03-01/Recommendations.json
  - stable/2025-03-01/ResourceHealthMetadata.json
  - stable/2025-03-01/ResourceProvider.json
  - stable/2025-03-01/SiteCertificates.json
  - stable/2025-03-01/StaticSites.json
  - stable/2025-03-01/WebApps.json
  - ../../../../certificateregistration/resource-manager/Microsoft.CertificateRegistration/CertificateRegistration/stable/2024-11-01/AppServiceCertificateOrders.json
  - ../../../../certificateregistration/resource-manager/Microsoft.CertificateRegistration/CertificateRegistration/stable/2024-11-01/CertificateOrdersDiagnostics.json
  - ../../../../certificateregistration/resource-manager/Microsoft.CertificateRegistration/CertificateRegistration/stable/2024-11-01/CertificateRegistrationProvider.json
  - ../../../../domainregistration/resource-manager/Microsoft.DomainRegistration/DomainRegistration/stable/2024-11-01/DomainRegistrationProvider.json
  - ../../../../domainregistration/resource-manager/Microsoft.DomainRegistration/DomainRegistration/stable/2024-11-01/Domains.json
  - ../../../../domainregistration/resource-manager/Microsoft.DomainRegistration/DomainRegistration/stable/2024-11-01/TopLevelDomains.json
```

``` yaml $(python)
title: WebSiteManagementClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-web
namespace: azure.mgmt.web
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web
```
