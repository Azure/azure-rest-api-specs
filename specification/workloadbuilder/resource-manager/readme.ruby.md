## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_cloudenvironment
package-version: 2021-03-01-privatepreview
azure-arm: true
```

### Tag: package-2020-07-01-privatepreview and ruby

These settings apply only when `--tag=package-2020-07-01-privatepreview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-07-01-privatepreview' && $(ruby)
namespace: Microsoft.WorkloadBuilder
output-folder: $(ruby-sdks-folder)/workloadbuilder
```

### Tag: package-2021-03-01-privatepreview and ruby

These settings apply only when `--tag=package-2021-03-01-privatepreview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-03-01-privatepreview' && $(ruby)
namespace: Microsoft.WorkloadBuilder
output-folder: $(ruby-sdks-folder)/workloadbuilder
```