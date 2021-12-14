## Python

These settings apply only when `--track2` is specified on the command line.

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-recoveryservicesbackup
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(track2)
clear-output-folder: true
batch:
  - tag: package-passivestamp-2018-12-20
  - tag: package-2021-10
```

### Tag: package-passivestamp-2018-12-20 and python

These settings apply only when `--tag=package-passivestamp-2018-12-20 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-passivestamp-2018-12-20'
title: Recovery Services Backup Passive Client
namespace: azure.mgmt.recoveryservicesbackup.passivestamp
output-folder: $(python-sdks-folder)/recoveryservices/azure-mgmt-recoveryservicesbackup/azure/mgmt/recoveryservicesbackup/passivestamp
```

### Tag: package-2021-10 and python

These settings apply only when `--tag=package-2021-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-10'
namespace: azure.mgmt.recoveryservicesbackup.activestamp
output-folder: $(python-sdks-folder)/recoveryservices/azure-mgmt-recoveryservicesbackup/azure/mgmt/recoveryservicesbackup/activestamp
```



``` yaml $(python) && $(track2)
modelerfour:
  lenient-model-deduplication: true
directive:
  - from: swagger-document
    where: $.definitions.ProtectionIntent
    transform: >
        $['required'] = ['protectionIntentItemType'];
  - from: swagger-document
    where: $.definitions.FeatureSupportRequest
    transform: >
        $['required'] = ['featureType'];

```
