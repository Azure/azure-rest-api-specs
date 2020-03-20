## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 2
package-name: azure-mgmt-keyvault
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi)
clear-output-folder: true
batch:
  - tag: package-2019-09
  - tag: package-2018-02
  - tag: package-2016-10
  - multiapiscript: true
```

### Multi-api script

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/
clear-output-folder: false
perform-load: false
```

### Tag: package-2019-09

These settings apply only when `--tag=package-2019-09` is specified on the command line.

``` yaml $(tag) == 'package-2019-09'
namespace: azure.mgmt.keyvault.v2019_09_01
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/v2019_09_01
```

### Tag: package-2018-02

These settings apply only when `--tag=package-2018-02` is specified on the command line.

``` yaml $(tag) == 'package-2018-02'
namespace: azure.mgmt.keyvault.v2018_02_14
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/v2018_02_14
```

### Tag: package-2016-10

These settings apply only when `--tag=package-2016-10` is specified on the command line.

``` yaml $(tag) == 'package-2016-10'
namespace: azure.mgmt.keyvault.v2016_10_01
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/v2016_10_01
```
