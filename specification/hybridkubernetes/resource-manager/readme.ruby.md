
## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_hybridkubernetes
package-version: 2019-09-01-privatepreview
azure-arm: true
```

<<<<<<< HEAD
  ### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-09-01-privatepreview
```

=======
### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-11-01-preview
  - tag: package-2019-09-01-privatepreview
```

### Tag: package-2019-11-01-preview and ruby

These settings apply only when `--tag=package-2019-11-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2019-11-01-preview' && $(ruby)
namespace: "Azure::Kubernetes::Mgmt::V2019_11_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_hybridkubernetes/lib
```
>>>>>>> 308e7c948... changes in readme.md file

### Tag: package-2019-09-01-privatepreview and ruby

These settings apply only when `--tag=package-2019-09-01-privatepreview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2019-09-01-privatepreview' && $(ruby)
namespace: "Azure::Kubernetes::Mgmt::V2019_09_01_privatepreview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_hybridkubernetes/lib
```
