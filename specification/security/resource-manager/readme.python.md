## Python

These settings apply only when `--python` is specified on the command line.


``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-security
package-version: 1.0.0b1
no-namespace-folders: true
modelerfour:
  lenient-model-deduplication: true
directive:
  - from: swagger-document
    where: $.definitions.AadConnectivityState.properties.connectivityState
    transform: > 
        $['x-ms-enum']['name'] = 'AadConnectivityStateEnum';
  - from: swagger-document
    where: $.definitions.ExternalSecuritySolutionKind.properties.kind
    transform: > 
        $['x-ms-enum']['name'] = 'ExternalSecuritySolutionKindEnum';
  - from: jitNetworkAccessPolicies.json
    where: $.definitions.JitNetworkAccessPortRule.properties.protocol
    transform: > 
        $['x-ms-enum']['name'] = 'protocolEnum';
  - from: alerts.json
    where: $.definitions.AlertSimulatorRequestProperties.properties.kind
    transform: > 
        $['x-ms-enum']['name'] = 'kindEnum';
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
clear-output-folder: true
multiapi: true
batch:
  - tag: package-preview-2022-07
  - tag: package-2022-05
  - tag: package-preview-2022-05
  - tag: package-2022-03
  - tag: package-2022-01-only
  - tag: package-2022-01-preview-only
  - tag: package-2021-10-preview-only
  - tag: package-2021-07-preview-only
  - tag: package-2021-07-only
  - tag: package-2021-06-only
  - tag: package-2021-05-preview-only
  - tag: package-2021-01-only
  - tag: package-2021-01-preview-only
  - tag: package-2020-07-preview-only
  - tag: package-2020-01-python-only
  - tag: package-2020-01-preview-python-only
  - tag: package-2019-08-python-only
  - tag: package-2019-01-python-only
  - tag: package-2019-01-preview-python-only
  - tag: package-2018-06-only
  - tag: package-2017-08-only
  - tag: package-2017-08-preview-python-only
  - tag: package-2015-06-preview-python-only
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/
perform-load: false
```

### Tag: package-preview-2022-07 and python

These settings apply only when `--tag=package-preview-2022-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-07' && $(python)
namespace: azure.mgmt.security.v2022_07_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2022_07_01_preview
```

### Tag: package-2022-05 and python

These settings apply only when `--tag=package-2022-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-05' && $(python)
namespace: azure.mgmt.security.v2022_05_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2022_05_01
```

### Tag: package-preview-2022-05 and python

These settings apply only when `--tag=package-preview-2022-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-05' && $(python)
namespace: azure.mgmt.security.v2022_05_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2022_05_01_preview
```

### Tag: package-2022-03 and python

These settings apply only when `--tag=package-2022-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-03' && $(python)
namespace: azure.mgmt.security.v2022_03_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2022_03_01
```

### Tag: package-2022-01-only and python

These settings apply only when `--tag=package-2022-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-01-only' && $(python)
namespace: azure.mgmt.security.v2022_01_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2022_01_01
```

### Tag: package-2022-01-preview-only and python

These settings apply only when `--tag=package-2022-01-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-01-preview-only' && $(python)
namespace: azure.mgmt.security.v2022_01_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2022_01_01_preview
```

### Tag: package-2021-10-preview-only and python

These settings apply only when `--tag=package-2021-10-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-10-preview-only' && $(python)
namespace: azure.mgmt.security.v2021_10_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2021_10_01_preview
```

### Tag: package-2021-07-preview-only and python

These settings apply only when `--tag=package-2021-07-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-07-preview-only' && $(python)
namespace: azure.mgmt.security.v2021_07_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2021_07_01_preview
```

### Tag: package-2021-07-only and python

These settings apply only when `--tag=package-2021-07-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-07-only' && $(python)
namespace: azure.mgmt.security.v2021_07_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2021_07_01
```

### Tag: package-2021-06-only and python

These settings apply only when `--tag=package-2021-06-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-06-only' && $(python)
namespace: azure.mgmt.security.v2021_06_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2021_06_01
```

### Tag: package-2021-05-preview-only and python

These settings apply only when `--tag=package-2021-05-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-05-preview-only' && $(python)
namespace: azure.mgmt.security.v2021_05_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2021_05_01_preview
```

### Tag: package-2021-01-only and python

These settings apply only when `--tag=package-2021-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-01-only' && $(python)
namespace: azure.mgmt.security.v2021_01_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2021_01_01
```

### Tag: package-2021-01-preview-only and python

These settings apply only when `--tag=package-2021-01-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-01-preview-only' && $(python)
namespace: azure.mgmt.security.v2021_01_15_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2021_01_15_preview
```

### Tag: package-2020-07-preview-only and python

These settings apply only when `--tag=package-2020-07-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-07-preview-only' && $(python)
namespace: azure.mgmt.security.v2020_07_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2020_07_01_preview
```

### Tag: package-2020-01-python-only and python

These settings apply only when `--tag=package-2020-01-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-python-only' && $(python)
namespace: azure.mgmt.security.v2020_01_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2020_01_01
```

### Tag: package-2020-01-preview-python-only and python

These settings apply only when `--tag=package-2020-01-preview-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-preview-python-only' && $(python)
namespace: azure.mgmt.security.v2020_01_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2020_01_01_preview
```

### Tag: package-2019-08-python-only and python

These settings apply only when `--tag=package-2019-08-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-08-python-only' && $(python)
namespace: azure.mgmt.security.v2019_08_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2019_08_01
```

### Tag: package-2019-01-python-only and python

These settings apply only when `--tag=package-2019-01-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-01-python-only' && $(python)
namespace: azure.mgmt.security.v2019_01_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2019_01_01
```

### Tag: package-2019-01-preview-python-only and python

These settings apply only when `--tag=package-2019-01-preview-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-01-preview-python-only' && $(python)
namespace: azure.mgmt.security.v2019_01_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2019_01_01_preview
```

### Tag: package-2018-06-only and python

These settings apply only when `--tag=package-2018-06-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-06-only' && $(python)
namespace: azure.mgmt.security.v2018_06_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2018_06_01
```

### Tag: package-2017-08-only and python

These settings apply only when `--tag=package-2017-08-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-08-only' && $(python)
namespace: azure.mgmt.security.v2017_08_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2017_08_01
```

### Tag: package-2017-08-preview-python-only and python

These settings apply only when `--tag=package-2017-08-preview-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-08-preview-python-only' && $(python)
namespace: azure.mgmt.security.v2017_08_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2017_08_01_preview
```

### Tag: package-2015-06-preview-python-only and python

These settings apply only when `--tag=package-2015-06-preview-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-06-preview-python-only' && $(python)
namespace: azure.mgmt.security.v2015_06_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2015_06_01_preview
```
