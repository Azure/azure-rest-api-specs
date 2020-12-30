## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_github_enterprise
package-version: 2020-09-23-preview
azure-arm: true
```

### Tag: package-2020-09-23-preview and ruby

These settings apply only when `--tag=package-2020-09-23-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-09-23-preview' && $(ruby)
namespace: GitHub.Enterprise
output-folder: $(ruby-sdks-folder)/github-enterprise
```
