
## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: insights
    package-name: insights
clear-output-folder: true
output-folder: $(trenton-output-folder)/insights
```

``` yaml $(tag) == 'package-2017-09' && $(trenton)
gosdk-folder: services/preview/monitor/mgmt/2017-05-01-preview/insights
```

``` yaml $(tag) == 'package-2018-03' && $(trenton)
gosdk-folder: services/preview/monitor/mgmt/2018-03-01/insights
```

``` yaml $(tag) == 'package-2018-09' && $(trenton)
gosdk-folder: services/preview/monitor/mgmt/2018-09-01/insights
```

``` yaml $(tag) == 'package-2018-11-preview' && $(trenton)
gosdk-folder: services/preview/monitor/mgmt/2018-11-01-preview/insights
```

``` yaml $(tag) == 'package-2019-03' && $(trenton)
gosdk-folder: services/preview/monitor/mgmt/2019-03-01/insights
```

``` yaml $(tag) == 'package-2019-06' && $(trenton)
gosdk-folder: services/preview/monitor/mgmt/2019-06-01/insights
```

``` yaml $(tag) == 'package-2019-11' && $(trenton)
gosdk-folder: services/preview/monitor/mgmt/2019-11-01-preview/insights
```
