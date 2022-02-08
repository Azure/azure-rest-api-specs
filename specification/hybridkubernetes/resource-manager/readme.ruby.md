
## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_hybridkubernetes
package-version: 2020-01-01-preview
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2020-01-01-preview
  - tag: package-2021-04-01-preview
  - tag: package-2021-03-01
  - tag: package-2021-10-01
```

### Tag: package-2020-01-01-preview and ruby

These settings apply only when `--tag=package-2020-01-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

### Tag: package-2021-04-01-preview and ruby

These settings apply only when `--tag=package-2021-04-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

### Tag: package-2021-03-01 and ruby

These settings apply only when `--tag=package-2021-03-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

### Tag: package-2021-10-01 and ruby

These settings apply only when `--tag=package-2021-10-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-01-01-preview' && $(ruby)
namespace: "Azure::Kubernetes::Mgmt::V2020_01_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_hybridkubernetes/lib
```
```yaml $(tag) == 'package-2021-04-01-preview' && $(ruby)
namespace: "Azure::Kubernetes::Mgmt::V2021_04_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_hybridkubernetes/lib
```
```yaml $(tag) == 'package-2021-03-01' && $(ruby)
namespace: "Azure::Kubernetes::Mgmt::V2021_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_hybridkubernetes/lib
```
```yaml $(tag) == 'package-2021-10-01' && $(ruby)
namespace: "Azure::Kubernetes::Mgmt::V2021_10_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_hybridkubernetes/lib
```