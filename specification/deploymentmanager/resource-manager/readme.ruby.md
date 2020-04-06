## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_deploymentmanager
package-version: "0.9.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-11-01-preview
```

### Tag: package-2019-11-01-preview and ruby

These settings apply only when `--tag=package-2019-11-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-11-01-preview' && $(ruby)
namespace: "Azure::DeploymentManager::Mgmt::V2019-11-01-preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_deploymentmanager/lib
```

