# Java DPS

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Device Provisioning Service.

## Java common settings

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to "SDKs" directory of your azure-sdk-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  regenerate-manager: true
  license-header: MICROSOFT_MIT_NO_CODEGEN
  payload-flattening-threshold: 1
  client-side-validation: false
  generate-interface: true
  clear-output-folder: true
  output-folder: $(azure-libraries-for-java-folder)/deviceprovisioningservices
```

## Tag: package-2020-03 and java

These settings apply only when `--tag=package-2020-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-03' && $(java)
java:
  namespace: com.microsoft.azure.management.deviceprovisioningservices.v2020_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/deviceprovisioningservices/mgmt-v2020_03_01
```

## Tag: package-2018-01 and java

These settings apply only when `--tag=package-2018-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.deviceprovisioningservices.v2018_01_22
  output-folder: $(azure-libraries-for-java-folder)/sdk/deviceprovisioningservices/mgmt-v2018_01_22
```

## Tag: package-2017-11 and java

These settings apply only when `--tag=package-2017-11 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.deviceprovisioningservices.v2017_11_15
  output-folder: $(azure-libraries-for-java-folder)/sdk/deviceprovisioningservices/mgmt-v2017_11_15
```

## Tag: package-2017-08 and java

These settings apply only when `--tag=package-2017-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.deviceprovisioningservices.v2017_08_21_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/deviceprovisioningservices/mgmt-v2017_08_21_preview
```
