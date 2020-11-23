## AZ

These settings apply only when `--az` is specified on the command line.
``` yaml $(az)
batch:
    - AMCS: true
```

``` yaml $(az) && $(AMCS)
az:
    extensions: amcs
    namespace: azure.mgmt.amcs
    package-name: azure-mgmt-amcs
az-output-folder: $(azure-cli-extension-folder)/src/monitor-control-service
python-sdk-output-folder: "$(az-output-folder)/azext_amcs/vendored_sdks/amcs"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```