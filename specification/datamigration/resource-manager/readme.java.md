## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
directive:
  - from: swagger-document
    where: $.definitions.MigrateSchemaSqlServerSqlDbTaskOutput
    transform: >
        $['required'] = ['resultType'];  
```
