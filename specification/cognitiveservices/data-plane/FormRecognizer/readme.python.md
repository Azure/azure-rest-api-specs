## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml
python-mode: create
license-header: MICROSOFT_MIT_NO_VERSION
add-credentials: true
namespace: azure.ai.formrecognizer
package-name: azure-ai-formrecognizer
credential-scopes: https://cognitiveservices.azure.com/.default
```

```yaml $(multiapi)
clear-output-folder: true
batch:
  - tag: release_2_0
  - tag: release_2_1_preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/formrecognizer/azure-ai-formrecognizer/azure/ai/formrecognizer/
clear-output-folder: false
perform-load: false
default-api: 2.1-preview.2
```

``` yaml $(tag) == 'release_2_0'
namespace: azure.ai.formrecognizer.v2_0
output-folder: $(python-sdks-folder)/formrecognizer/azure-ai-formrecognizer/azure/ai/formrecognizer/v2_0
```

``` yaml $(tag) == 'release_2_1_preview'
namespace: azure.ai.formrecognizer.v2_1_preview_2
output-folder: $(python-sdks-folder)/formrecognizer/azure-ai-formrecognizer/azure/ai/formrecognizer/v2_1_preview_2
```


``` yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/formrecognizer/azure-ai-formrecognizer/azure/ai/formrecognizer
```

``` yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/formrecognizer/azure-ai-formrecognizer
```