## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.nginx
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-nginx
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2023-04
  - tag: package-2022-08
  - tag: package-2021-05-preview
```

### Tag: package-2023-04 and java

These settings apply only when `--tag=package-2023-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.nginx.v2023_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/nginx/mgmt-v2023_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-08 and java

These settings apply only when `--tag=package-2022-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.nginx.v2022_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/nginx/mgmt-v2022_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-05-preview and java

These settings apply only when `--tag=package-2021-05-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-05-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.nginx.v2021_05_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/nginx/mgmt-v2021_05_01_preview
regenerate-manager: true
generate-interface: true
```