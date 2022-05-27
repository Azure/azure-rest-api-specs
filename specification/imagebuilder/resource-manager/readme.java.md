## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
directive:
  - from: imagebuilder.json
    where: $.definitions.ImageTemplateProperties.properties.validate
    transform: >
      $["x-ms-client-name"] = "validation";
    reason: property name validate collides with built-in method name
```

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.imagebuilder
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-imagebuilder
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-02
```

### Tag: package-2018-02 and java

These settings apply only when `--tag=package-2018-02 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.imagebuilder.v2018_02_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/imagebuilder/mgmt-v2018_02_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-02 and java

These settings apply only when `--tag=package-2019-02 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.imagebuilder.v2019_02_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/imagebuilder/mgmt-v2019_02_01_preview
regenerate-manager: true
generate-interface: true
```
