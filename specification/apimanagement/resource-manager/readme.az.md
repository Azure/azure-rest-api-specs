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
        - where:
            group: "ApiManagementService"
            op: "*"
          hidden: false
        - where:
            group: "ApiManagementService"
            op: "GetDomainOwnershipIdentifier"
          hidden: true
        - where:
            group: "ApiManagementService"
            op: "GetSsoToken"
          hidden: true
directive:
  - where:
      group: apim api-management-service
    set:
      group: apim
  - where:
      command: apply-network-configuration-update
    set:
      command: apply-network-updates
```