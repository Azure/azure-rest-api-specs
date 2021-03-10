## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(track2)
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azuredata
  no-namespace-folders: true
  package-version: 2019-07-24
```

``` yaml $(python-mode) == 'update'
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt/azuredata
```

``` yaml $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/azure-mgmt/azuredata
```