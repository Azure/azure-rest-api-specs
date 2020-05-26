## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: resourcegraph
    namespace: resourcegraph
clear-output-folder: true
output-folder: $(trenton-output-folder)/resourcegraph
overrides:
  - where:
      property: "/properties/properties"
    set:
      - GoVariableName: "propsInner"
```