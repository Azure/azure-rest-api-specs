## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.


``` yaml
license-header: MICROSOFT_MIT_NO_VERSION
add-credentials: true
namespace: azure.ai.formrecognizer
package-name: azure-ai-formrecognizer
credential-scopes: https://cognitiveservices.azure.com/.default
clear-output-folder: true
no-namespace-folders: true
```

``` yaml $(tag) == 'release_2_0'
namespace: azure.ai.formrecognizer.v2_0
output-folder: $(python-sdks-folder)/formrecognizer/azure-ai-formrecognizer/azure/ai/formrecognizer/_generated/v2_0
```

``` yaml $(tag) == 'release_2_1_preview.3'
namespace: azure.ai.formrecognizer.v2_1_preview_3
output-folder: $(python-sdks-folder)/formrecognizer/azure-ai-formrecognizer/azure/ai/formrecognizer/_generated/v2_1_preview_3
```


```yaml $(multiapi)
batch:
  - tag: release_2_0
  - tag: release_2_1_preview.3
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/formrecognizer/azure-ai-formrecognizer/azure/ai/formrecognizer/_generated
clear-output-folder: false
perform-load: false
default-api: 2.1-preview.3
```
