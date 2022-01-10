## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  generate-metadata: true
```

### Tag: package-flexibleserver-2021-06 and TypeScript

These settings apply only when `--tag=package-flexibleserver-2021-06 --typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to the root directory of your azure-sdk-for-typescript clone>`.

``` yaml $(tag) == 'package-flexibleserver-2021-06' && $(typescript)
title: PostgreSQLManagementFlexibleServerClient
package-name: "@azure/arm-postgresql-flexible"
output-folder: "$(typescript-sdks-folder)/sdk/postgresql/arm-postgresql-flexible/"
```

### Tag: package-flexibleserver-2021-06-preview and TypeScript

These settings apply only when `--tag=package-flexibleserver-2021-06-preview --typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to the root directory of your azure-sdk-for-typescript clone>`.

``` yaml $(tag) == 'package-flexibleserver-2021-06-preview' && $(typescript)
title: PostgreSQLManagementFlexibleServerClient
package-name: "@azure/arm-postgresql-flexible"
output-folder: "$(typescript-sdks-folder)/sdk/postgresql/arm-postgresql-flexible/"
```

### Tag: package-2021-04-10-privatepreview and TypeScript

These settings apply only when `--tag=package-2021-04-10-privatepreview --typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to the root directory of your azure-sdk-for-typescript clone>`.

``` yaml $(tag) == 'package-2021-04-10-privatepreview' && $(typescript)
title: PostgreSQLManagementFlexibleServerClient
package-name: "@azure/arm-postgresql-flexible"
output-folder: "$(typescript-sdks-folder)/sdk/postgresql/arm-postgresql-flexible/"
```

### Tag: package-2021-03-31-privatepreview and TypeScript

These settings apply only when `--tag=package-2021-03-31-privatepreview --typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to the root directory of your azure-sdk-for-typescript clone>`.

``` yaml $(tag) == 'package-2021-03-31-privatepreview' && $(typescript)
title: PostgreSQLManagementFlexibleServerClient
package-name: "@azure/arm-postgresql-flexible"
output-folder: "$(typescript-sdks-folder)/sdk/postgresql/arm-postgresql-flexible/"
```

### Tag: package-2020-01-01 and TypeScript

These settings apply only when `--tag=package-2020-01-01 --typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to the root directory of your azure-sdk-for-typescript clone>`.

``` yaml $(tag) == 'package-2020-01-01' && $(typescript)
package-name: "@azure/arm-postgresql"
output-folder: "$(typescript-sdks-folder)/sdk/postgresql/arm-postgresql/"
```
