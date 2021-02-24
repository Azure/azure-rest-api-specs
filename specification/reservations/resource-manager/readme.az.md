# AZ Capacity

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: quota
    namespace: azure.mgmt.capacity
    package-name: azure-mgmt-capacity
az-output-folder: $(azure-cli-extension-folder)/src/capacity
```
