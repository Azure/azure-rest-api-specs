## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml
generated-metadata: false
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.eventgrid._generated
package-name: azure-eventgrid
#  package-version: 1.3.0
clear-output-folder: true
no-namespace-folders: true
output-folder: $(python-sdks-folder)/eventgrid/azure-eventgrid/azure/eventgrid/_generated
v3: true
```
