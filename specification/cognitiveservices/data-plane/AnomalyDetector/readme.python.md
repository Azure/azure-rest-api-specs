## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

```yaml $(python)
python-mode: create
license-header: MICROSOFT_MIT_NO_VERSION
add-credentials: true
credential-default-policy-type: AzureKeyCredentialPolicy
credential-key-header-name: Ocp-Apim-Subscription-Key
payload-flattening-threshold: 1
namespace: azure.ai.anomalydetector
package-name: azure-ai-anomalydetector
package-version: 3.0.0b4
clear-output-folder: true
```

```yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/anomalydetector/azure-ai-anomalydetector/azure/ai/anomalydetector
```

```yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/anomalydetector/azure-ai-anomalydetector
```
