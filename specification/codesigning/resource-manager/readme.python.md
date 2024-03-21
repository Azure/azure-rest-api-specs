## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.codesigning
package-name: azure-mgmt-codesigning
package-version: 0.1.0
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/codesigning/azure-mgmt-codesigning/azure/mgmt/codesigning
```

``` yaml $(python)
flatten-models: false
```