## Ruby

These settings apply only when `--ruby` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml
package-name: azure_mgmt_security
package-version: "0.18.2"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2020-01-preview-only
  - tag: package-2020-01-only
  - tag: package-2019-08-only
  - tag: package-2019-01-only
  - tag: package-2018-06-only
  - tag: package-2017-08-only
  - tag: package-2019-01-preview-only
  - tag: package-2017-08-preview-only
  - tag: package-2015-06-preview-only
```

### Tag: package-2020-01-preview-only and ruby

These settings apply only when `--tag=package-2020-01-preview-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-01-preview-only' && $(ruby)
    namespace: "Azure::Security::Mgmt::V2020_01_01_preview"
    output-folder: $(ruby-sdks-folder)/management/azure_mgmt_security/lib
```

### Tag: package-2020-01-only and ruby

These settings apply only when `--tag=package-2020-01-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-01-only' && $(ruby)
    namespace: "Azure::Security::Mgmt::V2020_01_01"
    output-folder: $(ruby-sdks-folder)/management/azure_mgmt_security/lib
```

### Tag: package-2019-08-only and ruby

These settings apply only when `--tag=package-2019-08-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-08-only' && $(ruby)
    namespace: "Azure::Security::Mgmt::V2019_08_01"
    output-folder: $(ruby-sdks-folder)/management/azure_mgmt_security/lib
```

### Tag: package-2019-01-only and ruby

These settings apply only when `--tag=package-2019-01-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-01-only' && $(ruby)
    namespace: "Azure::Security::Mgmt::V2019_01_01"
    output-folder: $(ruby-sdks-folder)/management/azure_mgmt_security/lib
```

### Tag: package-2018-06-only and ruby

These settings apply only when `--tag=package-2018-06-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-03-only' && $(ruby)
    namespace: "Azure::Security::Mgmt::V2018_06_01"
    output-folder: $(ruby-sdks-folder)/management/azure_mgmt_security/lib
```

### Tag: package-2017-08-only and ruby

These settings apply only when `--tag=package-2017-08-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-08-only' && $(ruby)
    namespace: "Azure::Security::Mgmt::V2017_08_01"
    output-folder: $(ruby-sdks-folder)/management/azure_mgmt_security/lib
```
### Tag: package-2019-01-preview-only and ruby

These settings apply only when `--tag=package-2019-01-preview-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-01-preview-only' && $(ruby)
    namespace: "Azure::Security::Mgmt::V2019_01_01_preview"
    output-folder: $(ruby-sdks-folder)/management/azure_mgmt_security/lib
```

### Tag: package-2017-08-preview-only and ruby

These settings apply only when `--tag=package-2017-08-preview-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-08-preview-only' && $(ruby)
    namespace: "Azure::Security::Mgmt::V2017_08_01_preview"
    output-folder: $(ruby-sdks-folder)/management/azure_mgmt_security/lib
```

### Tag: package-2015-06-preview-only and ruby

These settings apply only when `--tag=package-2015-06-preview-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-06-preview-only' && $(ruby)
    namespace: "Azure::Security::Mgmt::V2015_06_01_preview"
    output-folder: $(ruby-sdks-folder)/management/azure_mgmt_security/lib
```

