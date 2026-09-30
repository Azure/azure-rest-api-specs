# AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: edgeorder
    namespace: azure.mgmt.edgeorder
    package-name: azure-mgmt-edgeorder
az-output-folder: $(azure-cli-extension-folder)/src/edgeorder
python-sdk-output-folder: "$(az-output-folder)/azext_edgeorder/vendored_sdks/edgeorder"

# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
directive:
# add `address` subgroup
  - where:
      command: edgeorder create-address
    set:
      command: edgeorder address create
  - where:
      command: edgeorder delete-address
    set:
      command: edgeorder address delete
  - where:
      command: edgeorder show-address
    set:
      command: edgeorder address show
  - where:
      command: edgeorder update-address
    set:
      command: edgeorder address update
# add `order` subgroup
  - where:
      command: edgeorder show-order
    set:
      command: edgeorder order show
  - where:
      command: edgeorder list
    set:
      command: edgeorder order list
# add `order-item` subgroup
  - where:
      command: edgeorder create-order-item
    set:
      command: edgeorder order-item create
  - where:
      command: edgeorder show-order-item
    set:
      command: edgeorder order-item show
  - where:
      command: edgeorder update-order-item
    set:
      command: edgeorder order-item update
  - where:
      command: edgeorder delete-order-item
    set:
      command: edgeorder order-item delete
  - where:
      command: edgeorder cancel-order-item
    set:
      command: edgeorder order-item cancel
  - where:
      command: edgeorder return-order-item
    set:
      command: edgeorder order-item return
# simplify `list-configuration` with `list-config`
  - where:
      command: edgeorder list-configuration
    set:
      command: edgeorder list-config
# simplify `list-product-family` with `list-family`
  - where:
      command: edgeorder list-product-family
    set:
      command: edgeorder list-family
# simplify `list-product-family-metadata` with `list-metadata`
  - where:
      command: edgeorder list-product-family-metadata
    set:
      command: edgeorder list-metadata
```