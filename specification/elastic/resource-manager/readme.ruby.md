## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_elastic
package-version: 2020-07-01-preview
azure-arm: true
```

### Tag: package-2020-07-01-preview and ruby

These settings apply only when `--tag=package-2020-07-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-07-01-preview' && $(ruby)
namespace: Microsoft.Elastic
output-folder: $(ruby-sdks-folder)/elastic
```

### Tag: package-2020-10-01-preview and ruby

These settings apply only when `--tag=package-2020-10-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-10-01-preview' && $(ruby)
namespace: Microsoft.Elastic
output-folder: $(ruby-sdks-folder)/elastic
```

### Tag: package-2022-05-05-preview and ruby

These settings apply only when `--tag=package-2022-05-05-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-05-05-preview' && $(ruby)
namespace: Microsoft.Elastic
output-folder: $(ruby-sdks-folder)/elastic
```

### Tag: package-2022-07-01-preview and ruby

These settings apply only when `--tag=package-2022-07-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-07-01-preview' && $(ruby)
namespace: Microsoft.Elastic
output-folder: $(ruby-sdks-folder)/elastic
```