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
module-name: sdk/resourcemanager/devcenter/armdevcenter
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

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2022-08-01-preview
```

### Tag: package-2022-08-01-preview and go

These settings apply only when `--tag=package-2022-08-01-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2022-08-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2022-08-01-preview/$(namespace)
```
