## Java

These settings apply only when `--java` is specified on the command line.

```yaml $(java)
service-name: CertificateRegistration
add-inner: AppServiceCertificate
remove-inner: CsmDeploymentStatus
name-for-ungrouped-operations: ResourceProvider
enable-sync-stack: false
```

### Tag: profile-hybrid-2020-09-01 and java

These settings apply only when `--tag=profile-hybrid-2020-09-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'profile-hybrid-2020-09-01' && $(java)
input-file:
  - stable/2018-02-01/AppServiceCertificateOrders.json
  - stable/2018-02-01/CertificateRegistrationProvider.json
directive:
  - from: CommonDefinitions.json
    where: $.definitions.Identifier.properties.properties.properties.id
    transform: >
      $['x-ms-client-name'] = "value";
```
