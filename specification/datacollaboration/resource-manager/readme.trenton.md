## overrides

These settings apply only when `--trenton` is specified on the command line.
``` yaml $(trenton)
overrides:
  - where:
      resource: "*"
    set:
      - NeedSeparated: false
  - where:
      resource: "Workspaces"
    set:
      - CombineCreateUpdate: false
```
## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: dataCollaboration
    package-name: datacollaboration
clear-output-folder: true
output-folder: $(trenton-output-folder)/datacollaboration
```
