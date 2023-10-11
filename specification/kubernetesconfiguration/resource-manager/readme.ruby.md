## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_kubernetesconfiguration
package-version: "0.1.1"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2023-05
  - tag: package-preview-2023-05
  - tag: package-2022-11
  - tag: package-2022-07
  - tag: package-preview-2022-04
  - tag: package-2022-03
  - tag: package-preview-2022-01-15
  - tag: package-preview-2022-01
  - tag: package-preview-2021-11
  - tag: package-2021-09
  - tag: package-preview-2021-05
  - tag: package-2021-03-01
  - tag: package-preview-2020-10
  - tag: package-2020-07-01-preview
  - tag: package-2019-11-01-preview
```

### Tag: package-2023-05 and ruby

These settings apply only when `--tag=package-2023-05 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2023-05' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2023_05_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```

### Tag: package-preview-2023-05 and ruby

These settings apply only when `--tag=package-preview-2023-05 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-preview-2023-05' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2023_05_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```

### Tag: package-2022-11 and ruby

These settings apply only when `--tag=package-2022-11 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-11' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2022_11_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```

### Tag: package-2022-07 and ruby

These settings apply only when `--tag=package-2022-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-07' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2022_07_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```

### Tag: package-preview-2022-04 and ruby

These settings apply only when `--tag=package-preview-2022-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-preview-2022-04' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2022_04_02_preview"
```

### Tag: package-2022-03 and ruby

These settings apply only when `--tag=package-2022-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-03' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2022_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```

### Tag: package-preview-2022-01-15 and ruby

These settings apply only when `--tag=package-preview-2022-01-15 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-preview-2022-01-15' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2022_01_15_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```

### Tag: package-preview-2022-01 and ruby

These settings apply only when `--tag=package-preview-2022-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-preview-2022-01' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2022_01_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```

### Tag: package-preview-2021-11 and ruby

These settings apply only when `--tag=package-preview-2021-11 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-preview-2021-11' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2021_11_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```

### Tag: package-2021-09 and ruby

These settings apply only when `--tag=package-2021-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-09' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2021_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```

### Tag: package-preview-2021-05 and ruby

These settings apply only when `--tag=package-preview-2021-05 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-preview-2021-05' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2021_05_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```

### Tag: package-2021-03-01 and ruby

These settings apply only when `--tag=package-2021-03-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-03-01' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2021_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```

### Tag: package-preview-2020-10 and ruby

These settings apply only when `--tag=package-preview-2020-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-preview-2020-10' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2020_10_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```

### Tag: package-2020-07-01-preview and ruby

These settings apply only when `--tag=package-2020-07-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-07-01-preview' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2020_07_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```

### Tag: package-2019-11-01-preview and ruby

These settings apply only when `--tag=package-2019-11-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2019-11-01-preview' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Mgmt::V2019_11_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```
