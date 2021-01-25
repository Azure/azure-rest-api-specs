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
clear-output-folder: true
credential-scopes: https://cognitiveservices.azure.com/.default
no-namespace-folders: true
```

```yaml $(multiapi)
batch:
 - tag: release_3_0
 - tag: release_3_1_preview.3
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


### Tag: release_3_1_preview_3
``` yaml $(tag) == 'release_3_1_preview.3'
namespace: azure.ai.textanalytics.v3_1_preview_3
output-folder: $(python-sdks-folder)/textanalytics/azure-ai-textanalytics/azure/ai/textanalytics/v3_1_preview_3
```

### Override Healthcare's pager and poller
``` yaml
directive:
    from: swagger-document
    where: '$.paths["/entities/health/jobs"].post'
    transform: >
        $["responses"]["200"] = {"description": "dummy schema", "schema": {"$ref": "#/definitions/HealthcareJobState"}};
        $["x-python-custom-poller-sync"] = "azure.ai.textanalytics.TextAnalyticsLROPoller";
        $["x-python-custom-poller-async"] = "azure.ai.textanalytics.AsyncTextAnalyticsLROPoller";
```

### Override Analyze's pager and poller
``` yaml
directive:
    from: swagger-document
    where: '$.paths["/analyze"].post'
    transform: >
        $["responses"]["200"] = {"description": "dummy schema", "schema": {"$ref": "#/definitions/AnalyzeJobState"}};
        $["x-python-custom-poller-sync"] = "...._polling.TextAnalyticsLROPoller";
        $["x-python-custom-poller-async"] = "...._polling.AsyncTextAnalyticsLROPoller";
```