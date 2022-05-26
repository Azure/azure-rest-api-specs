## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: communication
    namespace: azure.mgmt.communication
    package-name: azure-mgmt-communication
    randomize-names: true
az-output-folder: $(azure-cli-extension-folder)/src/communication
python-sdk-output-folder: "$(az-output-folder)/azext_communication/vendored_sdks/communication"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```

# Az.Communication

``` yaml
extension-mode: preview

directive:
    - where:
          group: communication communication-service
      set:
          group: communication
    - where:
          command: communication operation-statuses show
      set:
          command: communication show-status

cli:
    cli-directive:
        - where:
            group: CommunicationService
            param: CommunicationServiceName
          name: name
          alias:
            - name
            - n
```
