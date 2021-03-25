## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: Microsoft.ChangeAnalysis
package-name: changeanalysis
package-version: 2020-04-01-preview
clear-output-folder: true
```

```yaml $(python) && $(track2)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/azure-mgmt/changeanalysis
```
