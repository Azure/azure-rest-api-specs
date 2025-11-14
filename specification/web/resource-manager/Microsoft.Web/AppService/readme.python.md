## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

### Tag: package-2025-03 and python

``` yaml $(python) && $(tag) == 'package-2025-03'
input-file:
  - ../../../../certificateregistration/resource-manager/Microsoft.CertificateRegistration/CertificateRegistration/stable/2024-11-01/AppServiceCertificateOrders.json
  - ../../../../certificateregistration/resource-manager/Microsoft.CertificateRegistration/CertificateRegistration/stable/2024-11-01/CertificateOrdersDiagnostics.json
  - ../../../../certificateregistration/resource-manager/Microsoft.CertificateRegistration/CertificateRegistration/stable/2024-11-01/CertificateRegistrationProvider.json
  - ../../../../domainregistration/resource-manager/Microsoft.DomainRegistration/DomainRegistration/stable/2024-11-01/DomainRegistrationProvider.json
  - ../../../../domainregistration/resource-manager/Microsoft.DomainRegistration/DomainRegistration/stable/2024-11-01/Domains.json
  - ../../../../domainregistration/resource-manager/Microsoft.DomainRegistration/DomainRegistration/stable/2024-11-01/TopLevelDomains.json
```

``` yaml $(python)
title: AppServiceManagementClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-appservice
namespace: azure.mgmt.appservice
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-appservice/azure/mgmt/appservice
```
