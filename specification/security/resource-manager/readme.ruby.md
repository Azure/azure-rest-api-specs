## Ruby

These settings apply only when `--ruby` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml
package-name: azure_mgmt_security
package-version: "1.0.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-composite-v1
  - tag: package-composite-v2
```

### Tag: package-composite-v1 and ruby

These settings apply only when `--tag=package-composite-v1 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-composite-v1' && $(ruby)
    namespace: "Azure::Security::Mgmt::package_composite_v1"
    output-folder: $(ruby-sdks-folder)/management/azure_mgmt_security/lib
```

### Tag: package-composite-v2 and ruby

These settings apply only when `--tag=package-composite-v2 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-composite-v2' && $(ruby)
    namespace: "Azure::Security::Mgmt::package_composite_v2"
    output-folder: $(ruby-sdks-folder)/management/azure_mgmt_security/lib
```
