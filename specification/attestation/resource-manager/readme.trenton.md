
## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: attestation
    package-name: attestation
clear-output-folder: true
output-folder: $(trenton-output-folder)/attestation
overrides:
  - where:
      property: "x5C"
    set:
      - GoFieldName: X5c
  - where:
      property: "/creationParams/properties"
    set:
      - GoFieldName: Properties
```
