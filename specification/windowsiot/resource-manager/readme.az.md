## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
  extensions: windows-iot-services
  namespace: azure.mgmt.windowsiot
  package-name: azure-mgmt-windowsiot
az-output-folder: $(azure-cli-extension-folder)/src/windowsiot
python-sdk-output-folder: "$(az-output-folder)/azext_windowsiot/vendored_sdks/windowsiot"
extension-mode: experimental

directive:
  - where:
      group: windows-iot-services service
    set:
      group: windows-iot-services
  
cli:
    cli-directive:
        - where:
            group: Services
            op: CheckDeviceServiceNameAvailability
          hidden: true

        - where:
            group: Services
            param: deviceName
          alias:
            - name
            - n

        - where:
            group: Services
            op: CreateOrUpdate#Create
            param: billingDomainName|quantity
          required: true

        - where:
            group: Services
            param: tags|If-Match|etag
          hidden: true

        - where:
            group: Services
            op: Update
            param: location
          hidden: true
```
