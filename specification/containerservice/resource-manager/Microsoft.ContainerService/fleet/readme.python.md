### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
multiapi: true
batch:
  - tag: package-2026-02-01-preview
  - tag: package-2024-05-preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/
clear-output-folder: true
perform-load: false
```

### Tag: package-2026-02-01-preview and python

These settings apply only when `--tag=package-2026-02-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2026-02-01-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2026_02_01_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2026_02_01_preview
```

### Tag: package-2024-05-preview and python

These settings apply only when `--tag=package-2024-05-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-05-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2024_05_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2024_05_02_preview
```