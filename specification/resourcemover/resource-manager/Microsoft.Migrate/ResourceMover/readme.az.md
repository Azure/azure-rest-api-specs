## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: resource-mover
  package-name: azure-mgmt-resourcemover
  namespace: azure.mgmt.resourcemover
az-output-folder: $(azure-cli-extension-folder)/src/resource-mover
python-sdk-output-folder: "$(az-output-folder)/azext_resource_mover/vendored_sdks/resourcemover"
directive:
  - where:
        group: resource-mover unresolved-dependency
    set:
        group: resource-mover move-collection
cli:
  cli-directive:
    - where:
        group: 'OperationsDiscovery'
      hidden: true
    - where: 
        group: 'MoveCollections'
        op: 'ListMoveCollectionsByResourceGroup'
      hidden: true
    - where:
        group: 'MoveCollections'
        op: 'ListMoveCollectionsBySubscription'
      name: List
    - where:
        group: 'UnresolvedDependencies'
        op: 'Get'
      name: List_Unresolved_Dependencies
    - where:
        group: 'MoveResources'
        op: 'Create'
      name: Add
```
