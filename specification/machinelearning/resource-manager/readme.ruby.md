## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_machine_learning
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-webservices-2017-01
```

### Tag: package-webservices-2017-01 and ruby

These settings apply only when `--tag=package-webservices-2017-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-webservices-2017-01' && $(ruby)
namespace: "Azure::MachineLearning::Mgmt::V2017_01_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_machine_learning/lib
```
