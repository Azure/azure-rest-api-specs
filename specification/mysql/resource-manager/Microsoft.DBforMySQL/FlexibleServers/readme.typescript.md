## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  generate-metadata: true
title: MySQLManagementFlexibleServerClient
package-name: "@azure/arm-mysql-flexible"
output-folder: "$(typescript-sdks-folder)/sdk/mysql/arm-mysql-flexible/"
```
