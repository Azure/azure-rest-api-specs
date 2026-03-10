## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.frontdoor
package-name: azure-mgmt-frontdoor
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/network/azure-mgmt-frontdoor/azure/mgmt/frontdoor
```

``` yaml $(python)
directive:
  - from: swagger-document
    where: $.definitions.RulesEngineRule.properties.matchProcessingBehavior
    transform: >
         $['x-ms-enum'] = {
            "name": "MatchProcessingBehavior",
            "modelAsString": true,
            "values": [
                {
                  'name': 'CONTINUE_ENUM',
                  'value': 'Continue'
                },
                {
                  'name': 'STOP',
                  'value': 'Stop'
                }
            ]
         }
```
