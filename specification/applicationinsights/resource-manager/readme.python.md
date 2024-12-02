## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-applicationinsights
package-version: 1.0.0b1
clear-output-folder: true
no-namespace-folders: true
```
### Python multi-api

``` yaml $(python)
multiapi: true
default-api-version: "2022-06-15"
clear-output-folder: true
batch:
  - tag: package-2015-05
  - tag: package-2017-10
  - tag: package-2018-05-01-preview
  - tag: package-2018-06-17-preview
  - tag: package-2019-10-17-preview
  - tag: package-2020-02-02-preview
  - tag: package-2020-02-02-only
  - tag: package-2020-03-01-preview
  - tag: package-preview-2020-06-only
  - tag: package-2020-11-only
  - tag: package-2021-03-08-only
  - tag: package-2021-08
  - tag: package-2021-10
  - tag: package-2022-04-01-only
  - tag: package-2022-06-15-only
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/
perform-load: false
```

### Tag: package-2022-06-15-only and python

These settings apply only when `--tag=package-2022-06-15-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2022-06-15-only' && $(python)
namespace: azure.mgmt.applicationinsights.v2022_06_15
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2022_06_15
```

### Tag: package-2015-05 and python

These settings apply only when `--tag=package-2015-05 --python` is specified on the command line.

``` yaml $(tag) == 'package-2015-05' && $(python)
namespace: azure.mgmt.applicationinsights.v2015_05_01
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2015_05_01
```

### Tag: package-2017-10 and python

These settings apply only when `--tag=package-2017-10 --python` is specified on the command line.

``` yaml $(tag) == 'package-2017-10' && $(python)
namespace: azure.mgmt.applicationinsights.v2017_10_01
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2017_10_01
```

### Tag: package-2018-06-17-preview and python

These settings apply only when `--tag=package-2018-06-17-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-17-preview' && $(python)
namespace: azure.mgmt.applicationinsights.v2018_06_17_preview
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2018_06_17_preview
```

### Tag: package-2019-10-17-preview and python

These settings apply only when `--tag=package-2019-10-17-preview --python` is specified on the command line.

```yaml $(tag) == 'package-2019-10-17-preview' && $(python)
namespace: azure.mgmt.applicationinsights.v2019_10_17_preview
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2019_10_17_preview
```

### Tag: package-2018-05-01-preview and python

These settings apply only when `--tag=package-2018-05-01-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2018-05-01-preview' && $(python)
namespace: azure.mgmt.applicationinsights.v2018_05_01_preview
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2018_05_01_preview
```

### Tag: package-2020-02-02-preview and python

These settings apply only when `--tag=package-2020-02-02-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2020-02-02-preview' && $(python)
namespace: azure.mgmt.applicationinsights.v2020_02_02_preview
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2020_02_02_preview
```

### Tag: package-2020-02-02-only and python

These settings apply only when `--tag=package-2020-02-02-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2020-02-02-only' && $(python)
namespace: azure.mgmt.applicationinsights.v2020_02_02
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2020_02_02
```

### Tag: package-2020-03-01-preview and python

These settings apply only when `--tag=package-2020-03-01-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2020-03-01-preview' && $(python)
namespace: azure.mgmt.applicationinsights.v2020_03_01_preview
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2020_03_01_preview
```

### Tag: package-preview-2020-06-only and python

These settings apply only when `--tag=package-preview-2020-06-only --python` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-06-only' && $(python)
namespace: azure.mgmt.applicationinsights.v2020_06_02_preview
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2020_06_02_preview
```

### Tag: package-2020-11-only and python

These settings apply only when `--tag=package-2020-11-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2020-11-only' && $(python)
namespace: azure.mgmt.applicationinsights.v2020_11_20
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2020_11_20
```

### Tag: package-2021-03-08-only and python

These settings apply only when `--tag=package-2021-03-08-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2021-03-08-only' && $(python)
namespace: azure.mgmt.applicationinsights.v2021_03_08
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2021_03_08
```

### Tag: package-2021-08 and python

These settings apply only when `--tag=package-2021-08 --python` is specified on the command line.

``` yaml $(tag) == 'package-2021-08' && $(python)
namespace: azure.mgmt.applicationinsights.v2021_08_01
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2021_08_01
```

### Tag: package-2021-10 and python

These settings apply only when `--tag=package-2021-10 --python` is specified on the command line.

``` yaml $(tag) == 'package-2021-10' && $(python)
namespace: azure.mgmt.applicationinsights.v2021_10
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2021_10
```

### Tag: package-2022-04-01-only and python

These settings apply only when `--tag=package-2022-04-01-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2022-04-01-only' && $(python)
namespace: azure.mgmt.applicationinsights.v2022_04_01
output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2022_04_01
```

```yaml $(python)
modelerfour:
  lenient-model-deduplication: true
```
