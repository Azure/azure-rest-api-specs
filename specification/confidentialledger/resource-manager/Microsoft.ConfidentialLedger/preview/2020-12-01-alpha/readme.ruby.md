## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_cloudenvironment
package-version: 2020-12-01-alpha
azure-arm: true
```

### Tag: package-2020-12-01-alpha and ruby

These settings apply only when `--tag=package-2020-12-01-alpha --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-12-01-alpha' && $(ruby)
namespace: Microsoft.ConfidentialLedger
output-folder: $(ruby-sdks-folder)/confidentialledger
```
