### Ruby multi-api for source-control-configurations

``` yaml $(multiapi) && $(source-control-configurations)
package-name: azure_mgmt_kubernetesconfiguration_sourcecontrolconfigurations
package-version: "0.1.0"
azure-arm: true
batch:
  - tag: package-source-control-configurations-2021-03
  - tag: package-source-control-configurations-preview-2020-10
  - tag: package-source-control-configurations-preview-2020-07
  - tag: package-source-control-configurations-preview-2019-11
```

### Tag: package-source-control-configurations-2021-03 and ruby

These settings apply only when `--tag=package-source-control-configurations-2021-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-source-control-configurations-2021-03' && $(ruby)
namespace: "Azure::Mgmt::KubernetesConfiguration::SourceControlConfigurations::V2021_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration_sourcecontrolconfigurations/lib
```

### Tag: package-source-control-configurations-preview-2020-10 and ruby

These settings apply only when `--tag=package-source-control-configurations-preview-2020-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-source-control-configurations-preview-2020-10' && $(ruby)
namespace: "Azure::Mgmt::KubernetesConfiguration::SourceControlConfigurations::V2020_10_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration_sourcecontrolconfigurations/lib
```

### Tag: package-source-control-configurations-preview-2020-07 and ruby

These settings apply only when `--tag=package-source-control-configurations-preview-2020-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-source-control-configurations-preview-2020-07' && $(ruby)
namespace: "Azure::Mgmt::KubernetesConfiguration::SourceControlConfigurations::V2020_07_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration_sourcecontrolconfigurations/lib
```

### Tag: package-source-control-configurations-preview-2019-11 and ruby

These settings apply only when `--tag=package-source-control-configurations-preview-2019-11 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-source-control-configurations-preview-2019-11' && $(ruby)
namespace: "Azure::Mgmt::KubernetesConfiguration::SourceControlConfigurations::V2019_11_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration_sourcecontrolconfigurations/lib
```

### Ruby multi-api for extensions

``` yaml $(multiapi) && $(extensions)
package-name: azure_mgmt_kubernetesconfiguration_extensions
package-version: "0.1.0"
azure-arm: true
batch:
  - tag: package-extensions-preview-2020-07
```

### Tag: package-extensions-preview-2020-07 and ruby

These settings apply only when `--tag=package-extensions-preview-2020-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-extensions-preview-2020-07' && $(ruby)
namespace: "Azure::Mgmt::KubernetesConfiguration::Extensions::V2020_07_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration_extensions/lib
```