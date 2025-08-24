## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
override-client-name: AvsClient
uuid-as-string: true

directive:
- from: managedidentity.json
  where: definitions.SystemAssignedServiceIdentity
  transform: $["x-ms-client-name"] = "PrivateCloudIdentity"
- from: managedidentity.json
  where: definitions.SystemAssignedServiceIdentityType
  transform: $["x-ms-enum"].name = "ResourceIdentityType"
- from: vmware.json
  where: definitions.Addon.properties.properties
  transform: $["x-ms-mutability"] = undefined
```
