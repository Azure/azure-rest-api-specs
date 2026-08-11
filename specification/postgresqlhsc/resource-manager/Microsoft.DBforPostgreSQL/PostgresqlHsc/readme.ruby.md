## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_postgresqlhsc
package-version: package-2022-11-08
azure-arm: true
```

### Tag: package-2022-11-08 and ruby

These settings apply only when `--tag=package-2022-11-08 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-11-08' && $(ruby)
namespace: "Azure::PostgreSQLHSC::Mgmt::Vpackage-2022-11-08"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_postgresqlhsc/lib
```