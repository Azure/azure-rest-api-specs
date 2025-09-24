## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_windowsiot
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-06
  - tag: package-2018-02-preview
```

### Tag: package-2019-06 and ruby

These settings apply only when `--tag=package-2019-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-06' && $(ruby)
namespace: "Azure::WindowsIoT::Mgmt::V2019_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_windowsiot/lib
```


### Tag: package-2018-02-preview and ruby

These settings apply only when `--tag=package-2018-02-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-02-preview' && $(ruby)
namespace: "Azure::WindowsIoT::Mgmt::V2018_02_16_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_windowsiot/lib
```
