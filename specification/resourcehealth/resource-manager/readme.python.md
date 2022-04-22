## Python

These settings apply only when `--track2` is specified on the command line.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-resourcehealth
no-namespace-folders: true
package-version: 1.0.0b1
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi)
clear-output-folder: true
batch:
  - tag: package-2015-01
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/resourcehealth/azure-mgmt-resourcehealth/azure/mgmt/resourcehealth/
perform-load: false
```
### Tag: package-2015-01 and python

These settings apply only when `--tag=package-2015-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-01'
namespace: azure.mgmt.resourcehealth.v2015_01_01
output-folder: $(python-sdks-folder)/resourcehealth/azure-mgmt-resourcehealth/azure/mgmt/resourcehealth/v2015_01_01
```
