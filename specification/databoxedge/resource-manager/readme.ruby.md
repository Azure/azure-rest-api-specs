## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml $(ruby)
package-name: azure_mgmt_databoxedge
package-version: "0.1.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2021-02-01
  - tag: package-2021-02-01-preview
  - tag: package-2020-12-01
  - tag: package-2020-09-01-preview
  - tag: package-2020-09-01
  - tag: package-2020-05-preview
  - tag: package-2019-08
  - tag: package-2019-07
  - tag: package-2019-03
```
### Tag: package-2021-02-01 and ruby

These settings apply only when `--tag=package-2021-02-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2021-02-01' && $(ruby)
namespace: "Azure::DataBoxEdge::Mgmt::V2021_02-01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_databoxedge/lib
```

### Tag: package-2021-02-01-preview and ruby

These settings apply only when `--tag=package-2021-02-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2021-02-01-preview' && $(ruby)
namespace: "Azure::DataBoxEdge::Mgmt::V2021_02-01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_databoxedge/lib
```

### Tag: package-2020-12-01 and ruby

These settings apply only when `--tag=package-2020-12-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-12-01' && $(ruby)
namespace: "Azure::DataBoxEdge::Mgmt::V2020_12-01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_databoxedge/lib
```

### Tag: package-2020-09-01-preview and ruby

These settings apply only when `--tag=package-2020-09-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-09-01-preview' && $(ruby)
namespace: "Azure::DataBoxEdge::Mgmt::V2020_09-01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_databoxedge/lib
```
### Tag: package-2020-09-01 and ruby

These settings apply only when `--tag=package-2020-09-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-09-01' && $(ruby)
namespace: "Azure::DataBoxEdge::Mgmt::V2020_09-01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_databoxedge/lib
```

### Tag: package-2020-05-preview and ruby

These settings apply only when `--tag=package-2020-05-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-05-preview' && $(ruby)
namespace: "Azure::DataBoxEdge::Mgmt::V2020_05_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_databoxedge/lib
```

### Tag: package-2019-08 and ruby

These settings apply only when `--tag=package-2019-08 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-08' && $(ruby)
namespace: "Azure::DataBoxEdge::Mgmt::V2019_08_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_databoxedge/lib
```

### Tag: package-2019-07 and ruby

These settings apply only when `--tag=package-2019-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-07' && $(ruby)
namespace: "Azure::DataBoxEdge::Mgmt::V2019_07_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_databoxedge/lib
```

### Tag: package-2019-03 and ruby

These settings apply only when `--tag=package-2019-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-03' && $(ruby)
namespace: "Azure::DataBoxEdge::Mgmt::V2019_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_databoxedge/lib
```