# Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_scvmm
package-version: 2023-04-01-preview
azure-arm: true
```

## Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2020-06-05-preview
  - tag: package-2022-05-21-preview
  - tag: package-2023-04-01-preview
```

## Tag: package-2020-06-05-preview and ruby

These settings apply only when `--tag=package-2020-06-05-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-06-05-preview' && $(ruby)
namespace: Microsoft.SCVMM
output-folder: $(ruby-sdks-folder)/scvmm
```

## Tag: package-2022-05-21-preview and ruby

These settings apply only when `--tag=package-2022-05-21-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-05-21-preview' && $(ruby)
namespace: "Azure::SCVMM::Mgmt::V2022-05-21-preview"
output-folder: $(ruby-sdks-folder)/scvmm
```

## Tag: package-2023-04-01-preview and ruby

These settings apply only when `--tag=package-2023-04-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2023-04-01-preview' && $(ruby)
namespace: "Azure::SCVMM::Mgmt::V2023-04-01-preview"
output-folder: $(ruby-sdks-folder)/scvmm
```
