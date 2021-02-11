## Python
 
These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
 
``` yaml
license-header: MICROSOFT_MIT_NO_VERSION
add-credentials: true
payload-flattening-threshold: 2
namespace: azure.ai.translatortext
package-name: azure-ai-translatortext
clear-output-folder: true
credential-scopes: https://cognitiveservices.azure.com/.default
no-namespace-folders: true
python-sdks-folder: $(python-sdks-folder)
```