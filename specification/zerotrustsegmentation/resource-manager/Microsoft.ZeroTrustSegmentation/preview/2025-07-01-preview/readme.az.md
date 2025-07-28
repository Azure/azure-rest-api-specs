## AZ

These settings apply only when `--az` is specified on the command line.

```yaml $(az) && $(target-mode) != 'core'
az:
  extensions: zeroTrustSegmentation
  namespace: azure.mgmt.zeroTrustSegmentation
  package-name: azure-mgmt-zeroTrustSegmentation
az-output-folder: $(azure-cli-extension-folder)/src/zeroTrustSegmentation
python-sdk-output-folder: "$(az-output-folder)/azext_zeroTrustSegmentation/vendored_sdks/zeroTrustSegmentation"
```
