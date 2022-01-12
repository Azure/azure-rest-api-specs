## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.iothubprovisioningservices
package-name: azure-mgmt-iothubprovisioningservices
package-version: 1.0.0b1
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi) && $(track2)
batch:
  - tag: package-2021-10
  - tag: package-preview-2020-09
  - tag: package-2020-03
  - tag: package-2020-01
  - tag: package-2018-01
  - tag: package-2017-11
  - tag: package-preview-2017-08
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothubprovisioningservices/azure/mgmt/iothubprovisioningservices/
clear-output-folder: false
perform-load: false
```

### Tag: package-2021-10 and python

These settings apply only when `--tag=package-2021-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-10' && $(python)
namespace: azure.mgmt.iothubprovisioningservices.v2021_10_15
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothubprovisioningservices/azure/mgmt/iothubprovisioningservices/v2021_10_15
```

### Tag: package-preview-2020-09 and python

These settings apply only when `--tag=package-preview-2020-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2020-09' && $(python)
namespace: azure.mgmt.iothubprovisioningservices.v2020_09_01_preview
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothubprovisioningservices/azure/mgmt/iothubprovisioningservices/v2020_09_01_preview
```

### Tag: package-2020-03 and python

These settings apply only when `--tag=package-2020-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-03' && $(python)
namespace: azure.mgmt.iothubprovisioningservices.v2020_03_01
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothubprovisioningservices/azure/mgmt/iothubprovisioningservices/v2020_03_01
```

### Tag: package-2020-03 and python

These settings apply only when `--tag=package-2020-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01' && $(python)
namespace: azure.mgmt.iothubprovisioningservices.v2020_01_01
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothubprovisioningservices/azure/mgmt/iothubprovisioningservices/v2020_01_01
```

### Tag: package-2018-01 and python

These settings apply only when `--tag=package-2018_01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018_01' && $(python)
namespace: azure.mgmt.iothubprovisioningservices.v2018_01_22
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothubprovisioningservices/azure/mgmt/iothubprovisioningservices/v2018_01_22
```

### Tag: package-2017-11 and python

These settings apply only when `--tag=package-2017-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-11' && $(python)
namespace: azure.mgmt.iothubprovisioningservices.v2017_11_15
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothubprovisioningservices/azure/mgmt/iothubprovisioningservices/v2017_11_15
```

### Tag: package-preview-2017-08 and python

These settings apply only when `--tag=package-preview-2017-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2017-08' && $(python)
namespace: azure.mgmt.iothubprovisioningservices.v2017_08_21_preview
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothubprovisioningservices/azure/mgmt/iothubprovisioningservices/v2017_08_21_preview
```
