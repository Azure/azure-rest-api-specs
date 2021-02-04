
## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: apimanagement
    package-name: apimanagement
clear-output-folder: true
output-folder: $(trenton-output-folder)/apimanagement
```

``` yaml $(tag) == 'package-2019-12' && $(trenton)
gosdk-folder: services/apimanagement/mgmt/2019-12-01/apimanagement
```

``` yaml $(tag) == 'package-preview-2019-12' && $(trenton)
gosdk-folder: services/preview/apimanagement/mgmt/2019-12-01-preview/apimanagement
```

``` yaml $(tag) == 'package-2019-01' && $(trenton)
gosdk-folder: services/apimanagement/mgmt/2019-01-01/apimanagement
```

``` yaml $(tag) == 'package-2018-06-preview' && $(trenton)
gosdk-folder: services/preview/apimanagement/mgmt/2018-06-01-preview/apimanagement
```

``` yaml $(tag) == 'package-2018-01' && $(trenton)
gosdk-folder: services/apimanagement/mgmt/2018-01-01/apimanagement
```

``` yaml $(tag) == 'package-2017-03' && $(trenton)
gosdk-folder: services/apimanagement/mgmt/2017-03-01/apimanagement
```

``` yaml $(tag) == 'package-2016-10' && $(trenton)
gosdk-folder: services/apimanagement/mgmt/2016-10-10/apimanagement
```

``` yaml $(tag) == 'package-2016-07' && $(trenton)
gosdk-folder: services/apimanagement/mgmt/2016-07-07/apimanagement
```
