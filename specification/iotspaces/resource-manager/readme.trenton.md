
## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: iotspaces
    package-name: iotspaces
clear-output-folder: true
output-folder: $(trenton-output-folder)/iotspaces
```

``` yaml $(tag)=='package-2017-10-preview' && $(trenton)
gosdk-folder: services/preview/iotspaces/mgmt/2017-10-01-preview/iotspaces
```
