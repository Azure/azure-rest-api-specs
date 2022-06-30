## Python

These settings apply only when `--track2` is specified on the command line.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-commerce
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi)
clear-output-folder: true
batch:
  - tag: package-2015-06-preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/commerce/azure-mgmt-commerce/azure/mgmt/commerce/
perform-load: false
```

### Tag: package-2015-06-preview and python

These settings apply only when `--tag=package-2015-06-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-06-preview'
namespace: azure.mgmt.commerce.v2015_06_01_preview
output-folder: $(python-sdks-folder)/commerce/azure-mgmt-commerce/azure/mgmt/commerce/v2015_06_01_preview
```

``` yaml $(python)
modelerfour:
  lenient-model-deduplication: true
directive:
  - from: swagger-document
    where: $.definitions.OfferTermInfo.properties.Name
    transform: > 
        $['x-ms-enum']['name'] = 'OfferTermInfoEnum';
```
