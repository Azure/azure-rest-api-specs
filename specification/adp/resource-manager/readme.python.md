## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-adp
clear-output-folder: true
no-namespace-folders: true
modelerfour:
  lenient-model-deduplication: true
```

```yaml $(multiapi)
clear-output-folder: true
batch:
  - tag: package-2020-07-01-preview
  - tag: package-2021-02-01-preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/adp/azure-mgmt-adp/azure/mgmt/adp/
clear-output-folder: false
perform-load: false
```

``` yaml
namespace: azure.mgmt.adp.v$(version-with-underscores)
output-folder: $(python-sdks-folder)/adp/azure-mgmt-adp/azure/mgmt/adp/v$(version-with-underscores)
python:
  namespace: azure.mgmt.adp.v$(version-with-underscores)
  output-folder: $(python-sdks-folder)/adp/azure-mgmt-adp/azure/mgmt/adp/v$(version-with-underscores)
```
