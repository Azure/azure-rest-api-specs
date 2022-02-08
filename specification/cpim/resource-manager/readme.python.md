## Python

These settings apply only when `--track2` is specified on the command line.

```yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-azureadb2c
package-version: 1.0.0b2
no-namespace-folders: true
python-base-folder: azureadb2c/azure-mgmt-azureadb2c/azure/mgmt/azureadb2c
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi) && $(track2)
clear-output-folder: true
batch:
  - tag: package-2020-05-01-preview
  - tag: package-2019-01-01-preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/azureadb2c/azure-mgmt-azureadb2c/azure/mgmt/azureadb2c/
clear-output-folder: false
perform-load: false
```

### Tag: package-2020-05-01-preview and python

These settings apply only when `--tag=package-2020-05-01-preview --python` is specified on the command line. Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) =='package-2020-05-01-preview'
namespace: $(python-base-namespace).v2020_05_01_preview
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2020_05_01_preview
```

### Tag: package-2019-01-01-preview and python

These settings apply only when `--tag=package-2019-01-01-preview --python` is specified on the command line. Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) =='package-2019-01-01-preview'
namespace: $(python-base-namespace).v2019_01_01_preview
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2019_01_01_preview
```
