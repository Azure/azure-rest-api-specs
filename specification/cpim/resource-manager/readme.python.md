## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-azureadexternalidentities
package-version: 1.0.0b2
no-namespace-folders: true
python-base-folder: azureadexternalidentities/azure-mgmt-azureadexternalidentities/azure/mgmt/azureadexternalidentities
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi) && $(python)
clear-output-folder: true
batch:
  - tag: package-2021-04-01
  - tag: package-2020-05-01-preview
  - tag: package-2019-01-01-preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/azureadexternalidentities/azure-mgmt-azureadexternalidentities/azure/mgmt/azureadexternalidentities/
perform-load: false
```

### Tag: package-2021-04-01 and python

These settings apply only when `--tag=package-2021-04-01 --python` is specified on the command line. Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) =='package-2021-04-01'&& $(python)
namespace: $(python-base-namespace).v2021_04_01
output-folder: $(python-sdks-folder)/azureadexternalidentities/azure-mgmt-azureadexternalidentities/azure/mgmt/azureadexternalidentities/v2021_04_01
```

### Tag: package-2020-05-01-preview and python

These settings apply only when `--tag=package-2020-05-01-preview --python` is specified on the command line. Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) =='package-2020-05-01-preview'&& $(python)
namespace: $(python-base-namespace).v2020_05_01_preview
output-folder: $(python-sdks-folder)/azureadexternalidentities/azure-mgmt-azureadexternalidentities/azure/mgmt/azureadexternalidentities/v2021_04_01
```

### Tag: package-2019-01-01-preview and python

These settings apply only when `--tag=package-2019-01-01-preview --python` is specified on the command line. Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) =='package-2019-01-01-preview'&& $(python)
namespace: $(python-base-namespace).v2019_01_01_preview
output-folder: $(python-sdks-folder)/azureadexternalidentities/azure-mgmt-azureadexternalidentities/azure/mgmt/azureadexternalidentities/v2021_04_01
```
