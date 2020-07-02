## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  namespace: com.microsoft.azure.management.avs
  override-client-name: AvsClient
  license-header: MICROSOFT_MIT_NO_CODEGEN
  output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-avs
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-03-20
  - tag: package-2019-08-09-preview
```

### Tag: package-2020-03-20 and java

These settings apply only when `--tag=package-2020-03-20 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-03-20' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.avs.v2020_03_20
  output-folder: $(azure-libraries-for-java-folder)/sdk/avs/mgmt-v2020_03_20
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-08-09-preview and java

These settings apply only when `--tag=package-2019-08-09 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-08-09-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.avs.v2019_08_09_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/avs/mgmt-v2019_08_09_preview
regenerate-manager: true
generate-interface: true
```