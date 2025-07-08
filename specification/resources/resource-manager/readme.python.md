## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-resource
package-version: 1.0.0b1
no-namespace-folders: true
reformat-next-link: false
combine-operation-files: true
modelerfour:
  lenient-model-deduplication: true
```

### Python multi-api

Generate all API versions currently shipped for this package


```yaml $(python)
multiapi: true
clear-output-folder: true
batch:
  - tag: package-privatelinks-2020-05
  - multiapiscript-privatelinks: true
  - tag: package-features-2021-07
  - tag: package-features-2015-12
  - multiapiscript-features: true
  - tag: package-links-2016-09
  - multiapiscript-links: true
  - tag: package-locks-2016-09
  - tag: package-locks-2015-01
  - multiapiscript-locks: true
  - tag: package-managedapplications-2019-07
  - multiapiscript-managedapplications: true
  - tag: package-policy-2023-04-only
  - tag: package-policy-2022-08-preview-only
  - tag: package-policy-2022-07-preview-only
  - tag: package-policy-2022-06-only
  - tag: package-policy-2021-06-only
  - tag: package-policy-2020-09-only
  - tag: package-policy-2020-07-preview-only
  - tag: package-policy-2019-09
  - tag: package-policy-2019-06
  - tag: package-policy-2019-01
  - tag: package-policy-2018-05
  - tag: package-policy-2018-03
  - tag: package-policy-2017-06-preview-only
  - tag: package-policy-2016-12
  - tag: package-policy-2016-04
  - tag: package-policy-2015-10
  - multiapiscript-policy: true
  - tag: package-resources-2025-04-python-only
  - tag: package-resources-2025-03-python-only
  - tag: package-resources-2024-11-python-only
  - tag: package-resources-2024-07-python-only
  - tag: package-resources-2022-09-python-only
  - tag: package-resources-2021-04-python-only
  - tag: package-resources-2021-01-python-only
  - tag: package-resources-2020-10-python-only
  - tag: package-resources-2020-06-python-only
  - tag: package-resources-2019-10-python-only
  - tag: package-resources-2019-08-python-only
  - tag: package-resources-2019-07-python-only
  - tag: package-resources-2019-0510-python-only
  - tag: package-resources-2019-05-python-only
  - tag: package-resources-2019-03-python-only
  - tag: package-resources-2018-05-python-only
  - tag: package-resources-2018-02-python-only
  - tag: package-resources-2017-05-python-only
  - tag: package-resources-2016-09-python-only
  - tag: package-resources-2016-02-python-only
  - multiapiscript-resources: true
  - tag: package-subscriptions-2022-12
  - tag: package-subscriptions-2021-01
  - tag: package-subscriptions-2019-11
  - tag: package-subscriptions-2019-06
  - tag: package-subscriptions-2018-06
  - tag: package-subscriptions-2016-06
  - multiapiscript-subscriptions: true
  - tag: package-changes-2022-05
  - multiapiscript-changes: true
  - tag: package-databoundaries-2024-08
  - multiapiscript-databoundaries: true
```

```yaml $(multiapiscript-changes)
package-name: azure-mgmt-resource#changes
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/changes
perform-load: false
clear-output-folder: false
```

```yaml $(multiapiscript-privatelinks)
package-name: azure-mgmt-resource#privatelinks
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/privatelinks
perform-load: false
clear-output-folder: false
```

```yaml $(multiapiscript-features)
package-name: azure-mgmt-resource#features
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/features
perform-load: false
clear-output-folder: false
```

```yaml $(multiapiscript-policy)
package-name: azure-mgmt-resource#policy
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy
perform-load: false
clear-output-folder: false
```

```yaml $(multiapiscript-resources)
package-name: azure-mgmt-resource#resources
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources
perform-load: false
clear-output-folder: false
```

```yaml $(multiapiscript-subscriptions)
package-name: azure-mgmt-resource#subscriptions
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/subscriptions
perform-load: false
clear-output-folder: false
```


```yaml $(multiapiscript-locks)
package-name: azure-mgmt-resource#locks
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/locks
perform-load: false
clear-output-folder: false
```

```yaml $(multiapiscript-managedapplications)
package-name: azure-mgmt-resource#managedapplications
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/managedapplications
perform-load: false
clear-output-folder: false
```

```yaml $(multiapiscript-links)
package-name: azure-mgmt-resource#links
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/links
perform-load: false
clear-output-folder: false
```

```yaml $(multiapiscript-databoundaries)
title: DataBoundaryMgmtClient
package-name: azure-mgmt-resource#databoundaries
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/databoundaries
perform-load: false
clear-output-folder: false
```

### Tag: package-databoundaries-2024-08 and python

These settings apply only when `--tag=package-databoundaries-2024-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-databoundaries-2024-08'
default-api-version: "2024-08-01"
title: DataBoundaryMgmtClient
namespace: azure.mgmt.resource.databoundaries.v2024_08_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/databoundaries/v2024_08_01
directive:
  - remove-operation: "Operations_List"
```

### Tag: package-changes-2022-05 and python

These settings apply only when `--tag=package-changes-2022-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-changes-2022-05'
default-api-version: "2022-05-01"
namespace: azure.mgmt.resource.changes.v2022_05_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/changes/v2022_05_01
```

### Tag: package-privatelinks-2020-05 and python

These settings apply only when `--tag=package-privatelinks-2020-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-privatelinks-2020-05'
default-api-version: "2020-05-01"
namespace: azure.mgmt.resource.privatelinks.v2020_05_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/privatelinks/v2020_05_01
```

### Tag: package-features-2021-07 and python

These settings apply only when `--tag=package-features-2021-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-features-2021-07'
default-api-version: "2021-07-01"
namespace: azure.mgmt.resource.features.v2021_07_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/features/v2021_07_01
```

### Tag: package-features-2015-12 and python

These settings apply only when `--tag=package-features-2015-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-features-2015-12'
namespace: azure.mgmt.resource.features.v2015_12_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/features/v2015_12_01
```

### Tag: package-links-2016-09 and python

These settings apply only when `--tag=package-links-2016-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-links-2016-09'
default-api-version: "2016-09-01"
namespace: azure.mgmt.resource.links.v2016_09_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/links/v2016_09_01
```

### Tag: package-locks-2016-09 and python

These settings apply only when `--tag=package-locks-2016-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-locks-2016-09'
default-api-version: "2016-09-01"
namespace: azure.mgmt.resource.locks.v2016_09_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/locks/v2016_09_01
```

### Tag: package-locks-2015-01 and python

These settings apply only when `--tag=package-locks-2015-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-locks-2015-01'
namespace: azure.mgmt.resource.locks.v2015_01_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/locks/v2015_01_01
```

### Tag: package-managedapplications-2019-07 and python

These settings apply only when `--tag=package-managedapplications-2019-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2019-07'
default-api-version: "2019-07-01"
namespace: azure.mgmt.resource.managedapplications.v2019_07_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/managedapplications/v2019_07_01
```

### Tag: package-policy-2023-04-only and python

These settings apply only when `--tag=package-policy-2023-04-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2023-04-only'
default-api-version: "2023-04-01"
namespace: azure.mgmt.resource.policy.v2023_04_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2023_04_01
```

### Tag: package-policy-2022-08-preview-only and python

These settings apply only when `--tag=package-policy-2022-08-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2022-08-preview-only'
namespace: azure.mgmt.resource.policy.v2022_08_01_preview
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2022_08_01_preview
```

### Tag: package-policy-2022-07-preview-only and python

These settings apply only when `--tag=package-policy-2022-07-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2022-07-preview-only'
namespace: azure.mgmt.resource.policy.v2022_07_01_preview
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2022_07_01_preview
```

### Tag: package-policy-2022-06-only and python

These settings apply only when `--tag=package-policy-2022-06-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2022-06-only'
default-api-version: "2022-06-01"
namespace: azure.mgmt.resource.policy.v2022_06_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2022_06_01
```

### Tag: package-policy-2021-06-only and python

These settings apply only when `--tag=package-policy-2021-06-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2021-06-only'
namespace: azure.mgmt.resource.policy.v2021_06_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2021_06_01
```

### Tag: package-policy-2020-09-only and python

These settings apply only when `--tag=package-policy-2020-09-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2020-09-only'
namespace: azure.mgmt.resource.policy.v2020_09_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2020_09_01
```

### Tag: package-policy-2020-07-preview-only and python

These settings apply only when `--tag=package-policy-2020-07-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2020-07-preview-only'
namespace: azure.mgmt.resource.policy.v2020_07_01_preview
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2020_07_01_preview
```

### Tag: package-policy-2019-09 and python

These settings apply only when `--tag=package-policy-2019-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2019-09'
namespace: azure.mgmt.resource.policy.v2019_09_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2019_09_01
```

### Tag: package-policy-2019-06 and python

These settings apply only when `--tag=package-policy-2019-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2019-06'
namespace: azure.mgmt.resource.policy.v2019_06_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2019_06_01
```

### Tag: package-policy-2019-01 and python

These settings apply only when `--tag=package-policy-2019-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2019-01'
namespace: azure.mgmt.resource.policy.v2019_01_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2019_01_01
```

### Tag: package-policy-2018-05 and python

These settings apply only when `--tag=package-policy-2018-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2018-05'
namespace: azure.mgmt.resource.policy.v2018_05_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2018_05_01
```

### Tag: package-policy-2018-03 and python

These settings apply only when `--tag=package-policy-2018-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2018-03'
namespace: azure.mgmt.resource.policy.v2018_03_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2018_03_01
```

### Tag: package-policy-2017-06-preview-only and python

These settings apply only when `--tag=package-policy-2017-06-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2017-06-preview-only'
namespace: azure.mgmt.resource.policy.v2017_06_01_preview
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2017_06_01_preview
```

### Tag: package-policy-2016-12 and python

These settings apply only when `--tag=package-policy-2016-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2016-12'
namespace: azure.mgmt.resource.policy.v2016_12_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2016_12_01
```

### Tag: package-policy-2016-04 and python

These settings apply only when `--tag=package-policy-2016-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2016-04'
namespace: azure.mgmt.resource.policy.v2016_04_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2016_04_01
```

### Tag: package-policy-2015-10 and python

These settings apply only when `--tag=package-policy-2015-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2015-10'
namespace: azure.mgmt.resource.policy.v2015_10_01_preview
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy/v2015_10_01_preview
```

### Tag: package-resources-2025-04-python-only and python

These settings apply only when `--tag=package-resources-2025-04-python-only --python` is specified on the command line. Please also
specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2025-04-python-only'
title: ResourceManagementClient
default-api-version: "2025-04-01"
namespace: azure.mgmt.resource.resources.v2025_04_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2025_04_01
input-file:
  - Microsoft.Resources/stable/2025-04-01/resources.json
  - Microsoft.Resources/deployments/stable/2025-04-01/deployments.json
```

### Tag: package-resources-2025-03-python-only and python

These settings apply only when `--tag=package-resources-2025-03-python-only --python` is specified on the command line. Please also
specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2025-03-python-only'
title: ResourceManagementClient
default-api-version: "2025-03-01"
namespace: azure.mgmt.resource.resources.v2025_03_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2025_03_01
input-file:
  - Microsoft.Resources/stable/2025-03-01/resources.json
  - Microsoft.Resources/deployments/stable/2025-03-01/deployments.json
```

### Tag: package-resources-2024-11-python-only and python

These settings apply only when `--tag=package-resources-2024-11-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2024-11-python-only'
title: ResourceManagementClient
default-api-version: "2024-11-01"
namespace: azure.mgmt.resource.resources.v2024_11_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2024_11_01
input-file:
  - Microsoft.Resources/stable/2024-11-01/resources.json
  - Microsoft.Resources/deployments/stable/2024-11-01/deployments.json
```

### Tag: package-resources-2024-07-python-only and python

These settings apply only when `--tag=package-resources-2024-07-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2024-07-python-only'
title: ResourceManagementClient
default-api-version: "2024-07-01"
namespace: azure.mgmt.resource.resources.v2024_07_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2024_07_01
input-file:
  - Microsoft.Resources/stable/2024-07-01/resources.json
  - Microsoft.Resources/deployments/stable/2024-07-01/deployments.json
```

### Tag: package-resources-2022-09-python-only and python

These settings apply only when `--tag=package-resources-2022-09-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2022-09-python-only'
title: ResourceManagementClient
default-api-version: "2022-09-01"
namespace: azure.mgmt.resource.resources.v2022_09_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2022_09_01
input-file:
  - Microsoft.Resources/stable/2022-09-01/resources.json
  - Microsoft.Resources/deployments/stable/2022-09-01/deployments.json
```

### Tag: package-resources-2021-04-python-only and python

These settings apply only when `--tag=package-resources-2021-04-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2021-04-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2021_04_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2021_04_01
input-file:
  - Microsoft.Resources/stable/2021-04-01/resources.json
  - Microsoft.Resources/deployments/stable/2021-04-01/deployments.json
```

### Tag: package-resources-2021-01-python-only and python

These settings apply only when `--tag=package-resources-2021-01-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2021-01-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2021_01_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2021_01_01
input-file:
  - Microsoft.Resources/stable/2021-01-01/resources.json
  - Microsoft.Resources/deployments/stable/2021-01-01/deployments.json
```

### Tag: package-resources-2020-10-python-only and python

These settings apply only when `--tag=package-resources-2020-10-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2020-10-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2020_10_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2020_10_01
input-file:
  - Microsoft.Resources/stable/2020-10-01/resources.json
  - Microsoft.Resources/deployments/stable/2020-10-01/deployments.json
```

### Tag: package-resources-2020-06-python-only and python

These settings apply only when `--tag=package-resources-2020-06-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2020-06-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2020_06_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2020_06_01
input-file:
  - Microsoft.Resources/stable/2020-06-01/resources.json
  - Microsoft.Resources/deployments/stable/2020-06-01/deployments.json
```

### Tag: package-resources-2019-10-python-only and python

These settings apply only when `--tag=package-resources-2019-10-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2019-10-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2019_10_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2019_10_01
input-file:
  - Microsoft.Resources/stable/2019-10-01/resources.json
  - Microsoft.Resources/deployments/stable/2019-10-01/deployments.json
```

### Tag: package-resources-2019-08-python-only and python

These settings apply only when `--tag=package-resources-2019-08-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2019-08-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2019_08_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2019_08_01
input-file:
  - Microsoft.Resources/stable/2019-08-01/resources.json
  - Microsoft.Resources/deployments/stable/2019-08-01/deployments.json
```

### Tag: package-resources-2019-07-python-only and python

These settings apply only when `--tag=package-resources-2019-07-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2019-07-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2019_07_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2019_07_01
input-file:
  - Microsoft.Resources/stable/2019-07-01/resources.json
  - Microsoft.Resources/deployments/stable/2019-07-01/deployments.json
```

### Tag: package-resources-2019-0510-python-only and python

These settings apply only when `--tag=package-resources-2019-0510-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2019-0510-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2019_05_10
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2019_05_10
input-file:
  - Microsoft.Resources/stable/2019-05-10/resources.json
  - Microsoft.Resources/deployments/stable/2019-05-10/deployments.json
```

### Tag: package-resources-2019-05-python-only and python

These settings apply only when `--tag=package-resources-2019-05-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2019-05-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2019_05_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2019_05_01
input-file:
  - Microsoft.Resources/stable/2019-05-01/resources.json
  - Microsoft.Resources/deployments/stable/2019-05-01/deployments.json
```

### Tag: package-resources-2019-03-python-only and python

These settings apply only when `--tag=package-resources-2019-03-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2019-03-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2019_03_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2019_03_01
input-file:
  - Microsoft.Resources/stable/2019-03-01/resources.json
  - Microsoft.Resources/deployments/stable/2019-03-01/deployments.json
```

### Tag: package-resources-2018-05-python-only and python

These settings apply only when `--tag=package-resources-2018-05-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2018-05-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2018_05_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2018_05_01
input-file:
  - Microsoft.Resources/stable/2018-05-01/resources.json
  - Microsoft.Resources/deployments/stable/2018-05-01/deployments.json
```

### Tag: package-resources-2018-02-python-only and python

These settings apply only when `--tag=package-resources-2018-02-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2018-02-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2018_02_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2018_02_01
input-file:
  - Microsoft.Resources/stable/2018-02-01/resources.json
  - Microsoft.Resources/deployments/stable/2018-02-01/deployments.json
```

### Tag: package-resources-2017-05-python-only and python

These settings apply only when `--tag=package-resources-2017-05-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2017-05-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2017_05_10
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2017_05_10
input-file:
  - Microsoft.Resources/stable/2017-05-10/resources.json
  - Microsoft.Resources/deployments/stable/2017-05-10/deployments.json
```

### Tag: package-resources-2016-09-python-only and python

These settings apply only when `--tag=package-resources-2016-09-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2016-09-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2016_09_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2016_09_01
input-file:
  - Microsoft.Resources/stable/2016-09-01/resources.json
  - Microsoft.Resources/deployments/stable/2016-09-01/deployments.json
```

### Tag: package-resources-2016-02-python-only and python

These settings apply only when `--tag=package-resources-2016-02-python-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2016-02-python-only'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources.v2016_02_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2016_02_01
input-file:
  - Microsoft.Resources/stable/2016-02-01/resources.json
  - Microsoft.Resources/deployments/stable/2016-02-01/deployments.json
```

### Tag: package-subscriptions-2022-12 and python

These settings apply only when `--tag=package-subscriptions-2022-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-subscriptions-2022-12'
default-api-version: "2022-12-01"
namespace: azure.mgmt.resource.subscriptions.v2022_12_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/subscriptions/v2022_12_01
```

### Tag: package-subscriptions-2021-01 and python

These settings apply only when `--tag=package-subscriptions-2021-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-subscriptions-2021-01'
namespace: azure.mgmt.resource.subscriptions.v2021_01_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/subscriptions/v2021_01_01
```

### Tag: package-subscriptions-2019-11 and python

These settings apply only when `--tag=package-subscriptions-2019-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-subscriptions-2019-11'
namespace: azure.mgmt.resource.subscriptions.v2019_11_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/subscriptions/v2019_11_01
```

### Tag: package-subscriptions-2019-06 and python

These settings apply only when `--tag=package-subscriptions-2019-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-subscriptions-2019-06'
namespace: azure.mgmt.resource.subscriptions.v2019_06_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/subscriptions/v2019_06_01
```

### Tag: package-subscriptions-2018-06 and python

These settings apply only when `--tag=package-subscriptions-2018-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-subscriptions-2018-06'
namespace: azure.mgmt.resource.subscriptions.v2018_06_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/subscriptions/v2018_06_01
```

### Tag: package-subscriptions-2016-06 and python

These settings apply only when `--tag=package-subscriptions-2016-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-subscriptions-2016-06'
namespace: azure.mgmt.resource.subscriptions.v2016_06_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/subscriptions/v2016_06_01
```