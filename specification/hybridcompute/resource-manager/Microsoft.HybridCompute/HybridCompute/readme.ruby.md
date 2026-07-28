## Ruby HybridCompute

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_hybridcompute
azure-arm: true

directive:
  - remove-operation: 
    - Machines_Reconnect
    - Machines_CreateOrUpdate
    - Machines_Update
```
