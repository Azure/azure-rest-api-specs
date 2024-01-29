## AZ

These settings apply only when `--az` is specified on the command line.

```yaml $(az)
az:
  extensions: exposurecontrol
  namespace: azure.mgmt.exposurecontrol
  package-name: azure-mgmt-exposurecontrol
az-output-folder: $(azure-cli-extension-folder)/src/exposurecontrol
python-sdk-output-folder: "$(az-output-folder)/azext_exposurecontrol/vendored_sdks/exposurecontrol"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```
