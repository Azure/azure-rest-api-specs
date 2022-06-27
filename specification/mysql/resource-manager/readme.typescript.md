## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  generate-metadata: true
```

### Tag: package-flexibleserver-2021-05-01 and TypeScript

These settings apply only when `--tag=package-flexibleserver-2021-05-01 --typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to the root directory of your azure-sdk-for-typescript clone>`.

``` yaml $(tag) == 'package-flexibleserver-2021-05-01' && $(typescript)
title: MySQLManagementFlexibleServerClient
package-name: "@azure/arm-mysql-flexible"
output-folder: "$(typescript-sdks-folder)/sdk/mysql/arm-mysql-flexible/"
```

### Tag: package-2020-01-01 and TypeScript

These settings apply only when `--tag=package-2020-01-01 --typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to the root directory of your azure-sdk-for-typescript clone>`.

``` yaml $(tag) == 'package-2020-01-01' && $(typescript)
package-name: "@azure/arm-mysql"
output-folder: "$(typescript-sdks-folder)/sdk/mysql/arm-mysql/"
```
