## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.


``` yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.datamigration
package-name: azure-mgmt-datamigration
package-version: 1.0.0b1
clear-output-folder: true
```



``` yaml $(python) && $(python-mode) == 'update' && $(track2)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/datamigration/azure-mgmt-datamigration/azure/mgmt/datamigration
```

``` yaml $(python) && $(python-mode) == 'create' && $(track2)
basic-setup-py: true
output-folder: $(python-sdks-folder)/datamigration/azure-mgmt-datamigration
```

``` yaml $(python) && $(track2)
directive:
  - from: swagger-document
    where: $.definitions.MigrateSchemaSqlServerSqlDbTaskOutput
    transform: >
        $['required'] = ['resultType'];  
```
