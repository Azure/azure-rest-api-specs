## AZ
These settings apply only when `--az` is specified on the command line.
``` yaml $(az)
az:
    extensions: ai
    namespace: azure.mgmt.ai
    package-name: azure-mgmt-ai
    randomize-names: true
az-output-folder: $(azure-cli-extension-folder)/src/ai
python-sdk-output-folder: "$(az-output-folder)/azext_ai/vendored_sdks/ai"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```
