## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.marketplaceordering
package-name: azure-mgmt-marketplaceordering
clear-output-folder: true
package-version: 1.0.0b1
```

``` yaml $(python) 
no-namespace-folders: true
output-folder: $(python-sdks-folder)/marketplaceordering/azure-mgmt-marketplaceordering/azure/mgmt/marketplaceordering
```


Workaround invalid date-time returned by the server.

``` yaml $(python)
directive:
  - from: swagger-document
    where: $.definitions.AgreementProperties.properties.retrieveDatetime
    transform: delete $.format
```
