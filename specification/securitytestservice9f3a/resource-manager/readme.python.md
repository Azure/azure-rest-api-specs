## Python

See configuration in https://aka.ms/autorest

``` yaml $(python)
python-mode: update
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.securitytest
no-namespace-folders: true
output-folder: sdk/securitytest/azure-mgmt-securitytest/azure/mgmt/securitytest
package-name: azure-mgmt-securitytest
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python) && $(multiapi)
batch:
  - tag: package-2026-01-01
```

``` yaml $(python) && $(multiapi) && $(tag) == 'package-2026-01-01'
namespace: azure.mgmt.securitytest.v2026_01_01
output-folder: sdk/securitytest/azure-mgmt-securitytest/azure/mgmt/securitytest/v2026_01_01
azure-arm: true
module-version: 1.0.0b1
```
