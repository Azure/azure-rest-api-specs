## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.deviceupdate
  package-name: azure_mgmt_deviceupdate
  package-version: 2020-03-01-preview
  clear-output-folder: true
  add-credentials: true 
  credential-scopes: 9347d57b-9e24-4142-b4a3-20576bf22aa3/.default
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/sdk/deviceupdate/azure-mgmt-deviceupdate/azure/mgmt/deviceupdate
```
