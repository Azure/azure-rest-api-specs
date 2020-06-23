
## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: synapse
    package-name: synapse
clear-output-folder: true
output-folder: $(trenton-output-folder)/synapse
overrides:
  - where:
      resource: "SqlPools"
    set:
      - ModuleName: "SQLPools"
  - where:
      resource: BigDataPools/CreateOrUpdate
    set:
      - BodyPosition: 3
```
