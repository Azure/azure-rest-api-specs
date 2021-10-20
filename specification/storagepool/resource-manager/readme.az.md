## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: diskpool
    namespace: azure.mgmt.storagepool
    package-name: azure-mgmt-storagepool
az-output-folder: $(azure-cli-extension-folder)/src/diskpool
python-sdk-output-folder: "$(az-output-folder)/azext_diskpool/vendored_sdks/storagepool"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```

## Az.DiskPool

``` yaml
directive:
  - where:
      command: diskpool disk-pool-zone list
    set:
      command: disk-pool disk-pool-zone list
  - where:
      command: disk-pool disk-pool-zone list
    set:
      command: disk-pool disk-pool-zone-list
  - where:
      command: disk-pool disk-pool-zone-list
    set:
      command: disk-pool list-zones
  - where:
      command: diskpool resource-sku list
    set:
      command: disk-pool resource-sku list
  - where:
      command: disk-pool resource-sku list
    set:
      command: disk-pool resource-sku-list
  - where:
      command: disk-pool resource-sku-list
    set:
      command: disk-pool list-skus
  - where:
      command: disk-pool resource-sku-list
    set:
      command: disk-pool list-skus


cli:
  cli-directive:
      - where:
          param: disks
        set:
          positional: true
          positionalKeys:
            - id
      - where:
          group: DiskPools
          parameter: additionalCapabilities
        alias:
          - additional_capabilities
          - a
      - where:
          group: diskPool
        name: disk_pool
      - where:
          group: 'DiskPools'
          op: 'Upgrade'
        name: 'redeploy'

```