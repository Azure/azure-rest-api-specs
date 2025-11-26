## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: appservice
  clear-output-folder: true
```

```yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/appservice/armappservice/v5
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
- rename-model:
    from: "Certificate"
    to: "AppCertificate"
- rename-model:
    from: "CertificateCollection"
    to: "AppCertificateCollection"
- rename-model:
    from: "CertificatePatchResource"
    to: "AppCertificatePatchResource"
- from: 
  - Certificates.json
  - SiteCertificates.json
  where: $..[?(@.$ref == "./CommonDefinitions.json#/definitions/Certificate")]
  transform:
    $["$ref"] = "./CommonDefinitions.json#/definitions/AppCertificate"
- from: 
  - Certificates.json
  - SiteCertificates.json
  where: $..[?(@.$ref == "./CommonDefinitions.json#/definitions/CertificateCollection")]
  transform:
    $["$ref"] = "./CommonDefinitions.json#/definitions/AppCertificateCollection"
- from: 
  - Certificates.json
  - SiteCertificates.json
  where: $..[?(@.$ref == "./CommonDefinitions.json#/definitions/CertificatePatchResource")]
  transform:
    $["$ref"] = "./CommonDefinitions.json#/definitions/AppCertificatePatchResource"
```

### Tag: package-2025-03 and go

``` yaml $(go) && $(tag) == 'package-2025-03'
input-file:
  - ../../../../certificateregistration/resource-manager/Microsoft.CertificateRegistration/CertificateRegistration/stable/2024-11-01/AppServiceCertificateOrders.json
  - ../../../../certificateregistration/resource-manager/Microsoft.CertificateRegistration/CertificateRegistration/stable/2024-11-01/CertificateOrdersDiagnostics.json
  - ../../../../certificateregistration/resource-manager/Microsoft.CertificateRegistration/CertificateRegistration/stable/2024-11-01/CertificateRegistrationProvider.json
  - ../../../../domainregistration/resource-manager/Microsoft.DomainRegistration/DomainRegistration/stable/2024-11-01/DomainRegistrationProvider.json
  - ../../../../domainregistration/resource-manager/Microsoft.DomainRegistration/DomainRegistration/stable/2024-11-01/Domains.json
  - ../../../../domainregistration/resource-manager/Microsoft.DomainRegistration/DomainRegistration/stable/2024-11-01/TopLevelDomains.json
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
```
