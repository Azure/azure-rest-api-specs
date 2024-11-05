## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
  extensions: nginx
  namespace: azure.mgmt.nginx
  package-name: azure-mgmt-nginx
az-output-folder: $(azure-cli-extension-folder)/src/nginx
python-sdk-output-folder: "$(az-output-folder)/azext_nginx/vendored_sdks/nginx"
```
