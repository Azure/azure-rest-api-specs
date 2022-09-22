## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.servicefabric
package-name: azure-mgmt-servicefabric
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/servicefabric/azure-mgmt-servicefabric/azure/mgmt/servicefabric
```


``` yaml $(python)
directive:
  - from: application.json
    where: $.paths["/providers/Microsoft.ServiceFabric/operations"].get
    transform: $['operationId'] = 'Application_List'

  - from: managedcluster.json
    where: $.paths["/providers/Microsoft.ServiceFabric/operations"].get
    transform: $['operationId'] = 'Managedcluster_List'

  - from: nodetype.json
    where: $.paths["/providers/Microsoft.ServiceFabric/operations"].get
    transform: $['operationId'] = 'Nodetype_List'
```
