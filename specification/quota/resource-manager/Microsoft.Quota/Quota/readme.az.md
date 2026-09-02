# AZ quota

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: quota
    namespace: azure.mgmt.quota
    package-name: azure-mgmt-quota
    client-subscription-bound: false
az-output-folder: $(azure-cli-extension-folder)/src/quota
python-sdk-output-folder: "$(az-output-folder)/azext_quota/vendored_sdks/quota"
```