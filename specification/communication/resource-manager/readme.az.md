## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: communication
    namespace: azure.mgmt.communication
    package-name: azure-mgmt-communication
az-output-folder: $(azure-cli-extension-folder)/src/communication
python-sdk-output-folder: "$(az-output-folder)/azext_communication/vendored_sdks/communication"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```

# Az.Communication

``` yaml

directive:
  - where:
      group: communication service
    set:
      group: communication
  - where:
      group: communication status
    set:
      group: communication

cli:
    cli-directive:

# -------- CommunicationService --------
        - where:
            group: CommunicationService
          set:
            name: service
        - where:
            group: CommunicationService
            param: CommunicationServiceName
          name: name
          alias:
            - name
            - n

# -------- OperationStatuses --------
        - where:
            group: OperationStatuses
          set:
            name: status
        - where:
            group: OperationStatuses
            op: Get
          set:
            name: show_status

# -------- -------- --------
        - where:
            group: CommunicationService|OperationStatuses
          set:
            extensionMode: "preview"
```
