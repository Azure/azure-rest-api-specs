
``` yaml $(tag) == 'package-2020-05' && $(trenton)
gosdk-folder: services/preview//mgmt/2020-05-01-preview/
```

``` yaml $(tag) == 'package-2019-02-preview' && $(trenton)
gosdk-folder: services/preview//mgmt/2019-02-28/
```

## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: mixedreality
    package-name: mixedreality
clear-output-folder: true
output-folder: $(trenton-output-folder)/mixedreality
```
