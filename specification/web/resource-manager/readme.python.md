## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.


``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-web
package-version: 0.42.0
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package


```yaml $(python) && $(multiapi)
clear-output-folder: true
batch:
  - tag: package-2021-02-only
  - tag: package-2021-01-15-only
  - tag: package-2021-01-only
  - tag: package-2020-12-only
  - tag: package-2020-09-only
  - tag: package-2020-06-only
  - tag: package-2019-08-only
  - tag: package-2018-11-only
  - tag: package-2018-02-only
  - tag: package-2016-09-only
  - tag: package-2016-08-only
  - tag: package-2016-03-only
  - tag: package-2015-08-only
  - tag: package-2015-04-only
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/
clear-output-folder: false
perform-load: false

```
### Tag: package-2021-03-only and python

These settings apply only when `--tag=package-2021-03-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-03-only' && $(python)
namespace: azure.mgmt.web.v2021_03_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2021_03_01
```

### Tag: package-2021-02-only and python

These settings apply only when `--tag=package-2021-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-02-only' && $(python)
namespace: azure.mgmt.web.v2021_02_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2021_02_01
```

### Tag: package-2021-01-15-only and python

These settings apply only when `--tag=package-2021-01-15-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-01-15-only' && $(python)
namespace: azure.mgmt.web.v2021_01_15
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2021_01_15
```

### Tag: package-2021-01-only and python

These settings apply only when `--tag=package-2021-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-01-only' && $(python)
namespace: azure.mgmt.web.v2021_01_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2021_01_01
```

### Tag: package-2020-12-only and python

These settings apply only when `--tag=package-2020-12-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-12-only' && $(python)
namespace: azure.mgmt.web.v2020_12_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2020_12_01
```

### Tag: package-2020-09-only and python

These settings apply only when `--tag=package-2020-09-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-09-only' && $(python)
namespace: azure.mgmt.web.v2020_09_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2020_09_01
```

### Tag: package-2020-06-only and python

These settings apply only when `--tag=package-2020-06-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-06-only' && $(python)
namespace: azure.mgmt.web.v2020_06_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2020_06_01
```

### Tag: package-2019-08-only and python

These settings apply only when `--tag=package-2019-08-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-08-only' && $(python)
namespace: azure.mgmt.web.v2019_08_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2019_08_01
```

### Tag: package-2018-11-only and python

These settings apply only when `--tag=package-2018-11-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-11-only' && $(python)
namespace: azure.mgmt.web.v2018_11_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2018_11_01
```

### Tag: package-2018-02-only and python

These settings apply only when `--tag=package-2018-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-02-only' && $(python)
namespace: azure.mgmt.web.v2018_02_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2018_02_01
```

### Tag: package-2016-09-only and python

These settings apply only when `--tag=package-2016-09-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-09-only' && $(python)
namespace: azure.mgmt.web.v2016_09_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2016_09_01
```

### Tag: package-2016-08-only and python

These settings apply only when `--tag=package-2016-08-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-08-only' && $(python)
namespace: azure.mgmt.web.v2016_08_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2016_08_01
```

### Tag: package-2016-03-only and python

These settings apply only when `--tag=package-2016-03-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-03-only' && $(python)
namespace: azure.mgmt.web.v2016_03_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2016_03_01
```

### Tag: package-2015-08-only and python

These settings apply only when `--tag=package-2019-04-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-08-only' && $(python)
namespace: azure.mgmt.web.v2015_08_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2015_08_01
```

### Tag: package-2015-04-only and python

These settings apply only when `--tag=package-2019-04-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-04-only' && $(python)
namespace: azure.mgmt.web.v2015_04_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2015_04_01
```
