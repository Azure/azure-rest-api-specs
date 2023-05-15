## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.securityinsight
package-name: azure-mgmt-securityinsight
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/securityinsight/azure-mgmt-securityinsight/azure/mgmt/securityinsight
```

``` yaml $(python)
modelerfour:
  lenient-model-deduplication: true

directive:
  - from: EntityTypes.json
    where: $.definitions.AccountEntityProperties.properties.ntDomain
    transform: >
        $['description'] = 'The NetBIOS domain name as it appears in the alert format - domain/username. Examples: NT AUTHORITY.';
```
