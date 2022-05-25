## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/orbital/armorbital
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
directive:
- from: orbital.json
  where: $.definitions.ContactsProperties.properties.status["x-ms-enum"]
  transform: >
    $["name"] = "ContactsStatus"
```