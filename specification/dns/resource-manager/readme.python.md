## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-dns
no-namespace-folders: true
package-version: 1.0.0b1
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi) && $(track2)
clear-output-folder: true
batch:
  - tag: package-2018-05
  - tag: package-2018-03-preview
  - tag: package-2016-04
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/network/azure-mgmt-dns/azure/mgmt/dns/
clear-output-folder: false
perform-load: false
```

### Tag: package-2018-05 and python

These settings apply only when `--tag=package-2018-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-05' && $(python) && $(track2)
namespace: azure.mgmt.dns.v2018_05_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-dns/azure/mgmt/dns/v2018_05_01
```

### Tag: package-2018-03-preview and python

These settings apply only when `--tag=package-2018-03-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-03-preview' && $(python) && $(track2)
namespace: azure.mgmt.dns.v2018_03_01_preview
output-folder: $(python-sdks-folder)/network/azure-mgmt-dns/azure/mgmt/dns/v2018_03_01_preview
```

### Tag: package-2016-04 and python

These settings apply only when `--tag=package-2016-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-04' && $(python) && $(track2)
namespace: azure.mgmt.dns.v2016_04_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-dns/azure/mgmt/dns/v2016_04_01
```

```yaml $(python) && $(track2)
modelerfour:
  lenient-model-deduplication: true
```