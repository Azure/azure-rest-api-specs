## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_sql
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-pure-2014-04
  - tag: package-pure-2015-05-preview
  - tag: package-pure-2017-03-preview
```

### Tag: package-pure-2014-04 and ruby

These settings apply only when `--tag=package-pure-2014-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-pure-2014-04' && $(ruby)
namespace: "Azure::SQL::Mgmt::V2014_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_sql/lib
```

### Tag: package-pure-2015-05-preview and ruby

These settings apply only when `--tag=package-pure-2015-05-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-pure-2015-05-preview' && $(ruby)
namespace: "Azure::SQL::Mgmt::V2015_05_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_sql/lib
```

### Tag: package-pure-2017-03-preview and ruby

These settings apply only when `--tag=package-pure-2017-03-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-pure-2017-03-preview' && $(ruby)
namespace: "Azure::SQL::Mgmt::V2017_03_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_sql/lib
```
