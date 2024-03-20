## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
directive:
  - from: swagger-document
    where: $.definitions.MigrateMySqlAzureDbForMySqlSyncTaskOutput
    transform: >
        $['required'] = ['resultType'];
  - from: swagger-document
    where: $.definitions.MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput
    transform: >
        $['required'] = ['resultType'];
  - from: swagger-document
    where: $.definitions.MigrateSqlServerSqlDbSyncTaskOutput
    transform: >
        $['required'] = ['resultType'];
  - from: swagger-document
    where: $.definitions.MigrateSqlServerSqlMITaskOutput
    transform: >
        $['required'] = ['resultType'];
  - from: swagger-document
    where: $.definitions.MigrateSqlServerSqlMISyncTaskOutput
    transform: >
        $['required'] = ['resultType'];
```
