## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml
  azure-arm: false
  license-header: MICROSOFT_MIT_SMALL_NO_CODEGEN
  namespace: azure.deviceupdate
  package-name: azure-deviceupdate
  package-version: 2020-09-01-preview
  clear-output-folder: true
  add-credentials: true 
  credential-scopes: 6ee392c4-d339-4083-b04d-6b7947c6cf78/.default
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/sdk/deviceupdate/azure-deviceupdate/azure/deviceupdate
```
