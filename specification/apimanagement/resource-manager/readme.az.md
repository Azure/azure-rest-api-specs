## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) == 'core'
tag: package-preview-2021-01
az:
    extensions: apim
    namespace: azure.mgmt.apimanagement
    package-name: azure-mgmt-apimanagement
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/apim
python-sdk-output-folder: $(az-output-folder)/vendored_sdks/apimanagement
cli:
    cli-directive:
        - where:
            group: "*"
            op: "*"
          hidden: true
```