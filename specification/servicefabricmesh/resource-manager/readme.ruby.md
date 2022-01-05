## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml $(ruby)
ruby:
  package-name: azure_mgmt_service_fabric_mesh
  package-version: "0.1.0"
  azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2018-09-01-preview
  - tag: package-2018-07-01-preview
```

### Tag: package-2018-09-01-preview and ruby

These settings apply only when `--tag=package-2018-09-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-09-01-preview' && $(ruby)
namespace: "Azure::ServiceFabricMesh::Mgmt::V2018_09_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_service_fabric_mesh/lib
```

### Tag: package-2018-07-01-preview and ruby

These settings apply only when `--tag=package-2018-07-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-07-01-preview' && $(ruby)
namespace: "Azure::ServiceFabricMesh::Mgmt::V2018_07_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_service_fabric_mesh/lib
```

