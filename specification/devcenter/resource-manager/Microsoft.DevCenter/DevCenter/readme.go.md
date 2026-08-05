## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: devcenter
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/devcenter/armdevcenter/v2
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
- rename-model:
    from: DevCenterSku
    to: SkuInfo
- from: vdi.json
  where: "$.definitions.SkuListResult.properties.value.items"
  transform: >-
    return {
            "$ref": "commonDefinitions.json#/definitions/SkuInfo"
          }
- rename-model:
    from: DevCenterProjectCatalogSettings
    to: ProjectCatalogSettingsInfo
- from: devcenter.json
  where: "$.definitions.DevCenterUpdateProperties.properties.projectCatalogSettings"
  transform: >-
    return {
           "$ref": "#/definitions/ProjectCatalogSettingsInfo",
           "description": "Dev Center settings to be used when associating a project with a catalog."
          }
```
