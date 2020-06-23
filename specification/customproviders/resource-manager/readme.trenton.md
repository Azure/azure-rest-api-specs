## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: CustomProviders
    package-name: customproviders
clear-output-folder: true
output-folder: $(trenton-output-folder)/customproviders
overrides:
  - where:
      property: resourceProviderName
    set:
    - IdPortion: "resourceproviders"
```
