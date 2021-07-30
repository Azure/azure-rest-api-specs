## Python

These settings apply only when `--track2` is specified on the command line.

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-network
no-namespace-folders: true
package-version: 1.0.0b1
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi)
clear-output-folder: true
batch:
  - tag: package-2021-02
  - tag: package-2020-11
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/
clear-output-folder: true
perform-load: true
```
### Tag: package-2021-02 and python

These settings apply only when `--tag=package-2021-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-02'
namespace: azure.mgmt.network.v2021_02_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2021_02_01
```

### Tag: package-2020-11 and python

These settings apply only when `--tag=package-2020-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-11'
namespace: azure.mgmt.network.v2020_11_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_11_01
```
