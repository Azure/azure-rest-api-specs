## Python
 
These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.
 
``` yaml
python-mode: create
license-header: MICROSOFT_MIT_NO_VERSION
add-credentials: true
payload-flattening-threshold: 2
package-name: azure-ai-textanalytics
package-version: 0.0.1
clear-output-folder: true
credential-scopes: https://cognitiveservices.azure.com/.default
no-namespace-folders: true
```
 
```yaml $(multiapi)
batch:
 - tag: release_3_0
 - tag: release_3_1_preview.2
 - tag: release_3_1_preview.3
 - tag: release_3_1_preview.4
 - multiapiscript: true
```
 
``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/textanalytics/azure-ai-textanalytics/azure/ai/textanalytics
default-api: v3_0
clear-output-folder: false
perform-load: false
```
 
### Tag: release_3_0
``` yaml $(tag) == 'release_3_0'
namespace: azure.ai.textanalytics.v3_0
output-folder: $(python-sdks-folder)/textanalytics/azure-ai-textanalytics/azure/ai/textanalytics/v3_0
```
 
### Tag: release_3_1_preview_1
``` yaml $(tag) == 'release_3_1_preview.1'
namespace: azure.ai.textanalytics.v3_1_preview_1
output-folder: $(python-sdks-folder)/textanalytics/azure-ai-textanalytics/azure/ai/textanalytics/v3_1_preview_1
```
 
### Tag: release_3_1_preview_2
``` yaml $(tag) == 'release_3_1_preview.2'
namespace: azure.ai.textanalytics.v3_1_preview_2
output-folder: $(python-sdks-folder)/textanalytics/azure-ai-textanalytics/azure/ai/textanalytics/v3_1_preview_2
```

### Tag: release_3_1_preview_3
``` yaml $(tag) == 'release_3_1_preview.3'
namespace: azure.ai.textanalytics.v3_1_preview_3
output-folder: $(python-sdks-folder)/textanalytics/azure-ai-textanalytics/azure/ai/textanalytics/v3_1_preview_3
```

### Tag: release_3_1_preview_4
``` yaml $(tag) == 'release_3_1_preview.4'
namespace: azure.ai.textanalytics.v3_1_preview_4
output-folder: $(python-sdks-folder)/textanalytics/azure-ai-textanalytics/azure/ai/textanalytics/v3_1_preview_4
```

### Tag: release_3_1_preview_5
``` yaml $(tag) == 'release_3_1_preview.5'
namespace: azure.ai.textanalytics.v3_1_preview_5
output-folder: $(python-sdks-folder)/textanalytics/azure-ai-textanalytics/azure/ai/textanalytics/v3_1_preview_5
```