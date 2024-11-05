## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: purview
    namespace: azure.mgmt.purview
    package-name: azure-mgmt-purview
az-output-folder: $(azure-cli-extension-folder)/src/purview
python-sdk-output-folder: "$(az-output-folder)/azext_purview/vendored_sdks/purview"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```
``` yaml
cli:
    cli-directive:
       - where:
           operationGroup: PrivateEndpointConnections
         hidden: true
       - where:
           operationGroup: PrivateLinkResources
         hidden: true
```
