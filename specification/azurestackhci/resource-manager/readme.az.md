# AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: stack-hci
    namespace: azure.mgmt.azurestackhci
    package-name: azure-mgmt-azurestackhci
az-output-folder: $(azure-cli-extension-folder)/src/stack-hci
python-sdk-output-folder: "$(az-output-folder)/azext_stack_hci/vendored_sdks/azurestackhci"

# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
cli:
  cli-directive:
# add alias to long parameters
    - where:
        group: ArcSettings
        op: Create
        parameter: arcInstanceResourceGroup
      alias:
        - instance_rg
    - where:
        group: Clusters
        op: Create
        parameter: cloudManagementEndpoint
      alias:
        - endpoint
    - where:
        group: Clusters
        op: Update
        parameter: cloudManagementEndpoint
      alias:
        - endpoint
    - where:
        group: Extensions
        op: Create
        parameter: autoUpgradeMinorVersion
      alias:
        - auto_upgrade
    - where:
        group: Extensions
        op: Update
        parameter: autoUpgradeMinorVersion
      alias:
        - auto_upgrade
    - where:
        group: Extensions
        op: Create
        parameter: type
      alias:
        - type
    - where:
        group: Extensions
        op: Update
        parameter: type
      alias:
        - type
```
