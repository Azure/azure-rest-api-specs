## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-databox
namespace: azure.mgmt.databox
package-version: 3.0.0
clear-output-folder: true
title: DataBoxManagementClient
description: The DataBox Client.
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/databox/azure-mgmt-databox/azure/mgmt/databox
```
