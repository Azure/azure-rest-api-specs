
## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: changeanalysis
    package-name: changeanalysis
clear-output-folder: true
output-folder: $(trenton-output-folder)/changeanalysis
```

```yaml $(tag) == 'package-2020-04-01-preview' && $(trenton)
gosdk-folder: services/preview/changeanalysis/mgmt/2020-04-01-preview/changeanalysis
```
