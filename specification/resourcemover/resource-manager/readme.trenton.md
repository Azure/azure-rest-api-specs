
## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: resourcemover
    package-name: resourcemover
clear-output-folder: true
output-folder: $(trenton-output-folder)/resourcemover
```

``` yaml $(trenton)
overrides:
  - where:
      property: dependsOn
    set:
      - SchemaName: "dependency"
```
