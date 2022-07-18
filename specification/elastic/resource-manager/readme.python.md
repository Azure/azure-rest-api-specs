## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.elastic
package-name: azure-mgmt-elastic
package-version: 2020-07-01-preview
clear-output-folder: true

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/elastic/azure-mgmt-elastic/azure/mgmt/elastic
```
