## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.
When used on the command line, you may need to specify `--verison=V2`.

``` yaml $(python)
package-version: 0.2.0
license-header: MICROSOFT_MIT_NO_VERSION
add-credentials: true
payload-flattening-threshold: 2
namespace: azure.cognitiveservices.personalizer
package-name: azure-cognitiveservices-personalizer
use: "@microsoft.azure/autorest.python@~4.0.71" 
version: V2
multiapi: true
no-async: true
```
``` yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
clear-output-folder: false
output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitiveservices-personalizer/azure/cognitiveservices/personalizer
```
``` yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
clear-output-folder: true
output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitiveservices-personalizer
```
