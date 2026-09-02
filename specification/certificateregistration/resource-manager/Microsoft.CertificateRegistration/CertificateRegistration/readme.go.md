## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: certificateregistration
  clear-output-folder: true
```

```yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/certificateregistration/armcertificateregistration
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
