## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.


``` yaml $(python)
title: NotificationHubsManagementClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-notificationhubs
namespace: azure.mgmt.notificationhubs
package-version: 7.0.0
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/notificationhubs/azure-mgmt-notificationhubs/azure/mgmt/notificationhubs
```
