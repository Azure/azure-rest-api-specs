## Python

These settings apply only when `--track2` is specified on the command line.

``` yaml
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-monitor
no-namespace-folders: true
python-base-folder: monitor/azure-mgmt-monitor/azure/mgmt/monitor
modelerfour:
  lenient-model-deduplication: true
```

These settings apply when `--track2` and `--AMCS` is specified on the command line.

``` yaml $(track2) && $(AMCS)
package-version: 0.1.0
namespace: azure.mgmt.amcs
package-name: azure-mgmt-amcs
basic-setup-py: true
output-folder: $(python-sdks-folder)/amcs/azure-mgmt-amcs
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi) && $(track2)
clear-output-folder: true
batch:
  - tag: package-2020-10
  - tag: package-2020-05-preview
  - tag: package-2020-01-01-preview-only
  - tag: package-2019-11-01-preview-only
  - tag: package-2019-10-17-preview-only
  - tag: package-2019-06-01-only
  - tag: package-2019-03-01-only
  - tag: package-2018-11-27-preview-only
  - tag: package-2018-09-01-only
  - tag: package-2018-06-01-preview-only
  - tag: package-2018-04-16-only
  - tag: package-2018-03-01-only
  - tag: package-2018-01-01-only
  - tag: package-2017-12-01-preview-only
  - tag: package-2017-11-01-preview-only
  - tag: package-2017-05-01-preview-only
  - tag: package-2017-04-01-only
  - tag: package-2017-03-01-preview-only
  - tag: package-2016-09-01-only
  - tag: package-2016-03-01-only
  - tag: package-2015-07-01-only
  - tag: package-2015-04-01-only
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/monitor/azure-mgmt-monitor/azure/mgmt/monitor/
clear-output-folder: false
perform-load: false
```

### Tag: package-2020-10 and python

These settings apply only when `--tag=package-2020-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-10'
namespace: $(python-base-namespace).v2020_10_01
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2020_10_01
```

### Tag: package-2020-05-preview and python

These settings apply only when `--tag=package-2020-05-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-05-preview'
namespace: $(python-base-namespace).v2020_05_01_preview
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2020_05_01_preview
```

### Tag: package-2020-01-01-preview-only and python

These settings apply only when `--tag=package-2020-01-01-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-01-preview-only'
namespace: $(python-base-namespace).v2020_01_01_preview
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2020_01_01_preview
```

### Tag: package-2019-11-01-preview-only and python

These settings apply only when `--tag=package-2019-11-01-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-11-01-preview-only'
namespace: $(python-base-namespace).v2019_11_01_preview
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2019_11_01_preview
```

### Tag: package-2019-10-17-preview-only and python

These settings apply only when `--tag=package-2019-10-17-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-10-17-preview-only'
namespace: $(python-base-namespace).v2019_10_17
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2019_10_17
```

### Tag: package-2019-06-01-only and python

These settings apply only when `--tag=package-2019-06-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-06-01-only'
namespace: $(python-base-namespace).v2019_06_01
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2019_06_01
```
### Tag: package-2019-03-01-only and python

These settings apply only when `--tag=package-2019-03-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-03-01-only'
namespace: $(python-base-namespace).v2019_03_01
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2019_03_01
```

### Tag: package-2018-11-27-preview-only and python

These settings apply only when `--tag=package-2018-11-27-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-11-27-preview-only'
namespace: $(python-base-namespace).v2018_11_27_preview
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2018_11_27_preview
```

### Tag: package-2018-09-01-only and python

These settings apply only when `--tag=package-2018-09-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-09-01-only'
namespace: $(python-base-namespace).v2018_09_01
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2018_09_01
```

### Tag: package-2018-06-01-preview-only and python

These settings apply only when `--tag=package-2018-06-01-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-06-01-preview-only'
namespace: $(python-base-namespace).v2018_06_01_preview
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2018_06_01_preview
```

### Tag: package-2018-04-16-only and python

These settings apply only when `--tag=package-2018-04-16-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-04-16-only'
namespace: $(python-base-namespace).v2018_04_16
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2018_04_16
```

### Tag: package-2018-03-01-only and python

These settings apply only when `--tag=package-2018-03-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-03-01-only'
namespace: $(python-base-namespace).v2018_03_01
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2018_03_01
```

### Tag: package-2018-01-01-only and python

These settings apply only when `--tag=package-2018-01-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-01-01-only'
namespace: $(python-base-namespace).v2018_01_01
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2018_01_01
```

### Tag: package-2017-12-01-preview-only and python

These settings apply only when `--tag=package-2017-12-01-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-12-01-preview-only'
namespace: $(python-base-namespace).v2017_12_01_preview
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2017_12_01_preview
```

### Tag: package-2017-11-01-preview-only and python

These settings apply only when `--tag=package-2017-11-01-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-11-01-preview-only'
namespace: $(python-base-namespace).v2017_11_01_preview
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2017_11_01_preview
```

### Tag: package-2017-05-01-preview-only and python

These settings apply only when `--tag=package-2017-05-01-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-05-01-preview-only'
namespace: $(python-base-namespace).v2017_05_01_preview
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2017_05_01_preview
```

### Tag: package-2017-04-01-only and python

These settings apply only when `--tag=package-2017-04-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-04-01-only'
namespace: $(python-base-namespace).v2017_04_01
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2017_04_01
```

### Tag: package-2017-03-01-preview-only and python

These settings apply only when `--tag=package-2017-03-01-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-03-01-preview-only'
namespace: $(python-base-namespace).v2017_03_01_preview
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2017_03_01_preview
```

### Tag: package-2016-09-01-only and python

These settings apply only when `--tag=package-2016-09-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-09-01-only'
namespace: $(python-base-namespace).v2016_09_01
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2016_09_01
```

### Tag: package-2016-03-01-only and python

These settings apply only when `--tag=package-2016-03-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-03-01-only'
namespace: $(python-base-namespace).v2016_03_01
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2016_03_01
```

### Tag: package-2015-07-01-only and python

These settings apply only when `--tag=package-2015-07-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-07-01-only'
namespace: $(python-base-namespace).v2015_07_01
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2015_07_01
```

### Tag: package-2015-04-01-only and python

These settings apply only when `--tag=package-2015-04-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-04-01-only'
namespace: $(python-base-namespace).v2015_04_01
output-folder: $(python-sdks-folder)/$(python-base-folder)/v2015_04_01
```
