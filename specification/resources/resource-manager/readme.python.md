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
clear-output-folder: true
modelerfour:
  lenient-model-deduplication: true
```

### Python batch

```yaml $(python)
batch:
  - tag: package-privatelinks-2020-05
  - tag: package-features-2021-07
  - tag: package-links-2016-09
  - tag: package-locks-2016-09
  - tag: package-managedapplications-2019-07
  - tag: package-policy-2023-04
  - tag: package-resources-2025-04
  - tag: package-subscriptions-2022-12
  - tag: package-changes-2022-05
  - tag: package-databoundaries-2024-08
```

### Tag: package-privatelinks-2020-05 and python

These settings apply only when `--tag=package-privatelinks-2020-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-privatelinks-2020-05'
title: ResourcePrivateLinkClient
namespace: azure.mgmt.resource.privatelinks
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/privatelinks
```

### Tag: package-features-2021-07 and python

These settings apply only when `--tag=package-features-2021-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-features-2021-07'
title: FeatureClient
namespace: azure.mgmt.resource.features
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/features
```

### Tag: package-links-2016-09 and python

These settings apply only when `--tag=package-links-2016-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-links-2016-09'
title: ManagementLinkClient
namespace: azure.mgmt.resource.links
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/links
```

### Tag: package-locks-2016-09 and python

These settings apply only when `--tag=package-locks-2016-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-locks-2016-09'
title: ManagementLockClient
namespace: azure.mgmt.resource.locks
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/locks
```

### Tag: package-managedapplications-2019-07 and python

These settings apply only when `--tag=package-managedapplications-2019-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2019-07'
title: ApplicationClient
namespace: azure.mgmt.resource.managedapplications
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/managedapplications
```

### Tag: package-policy-2023-04 and python

These settings apply only when `--tag=package-policy-2023-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2023-04'
title: PolicyClient
namespace: azure.mgmt.resource.policy
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy
```

### Tag: package-resources-2025-04 and python

These settings apply only when `--tag=package-resources-2025-04 --python` is specified on the command line. Please also
specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2025-04'
title: ResourceManagementClient
namespace: azure.mgmt.resource.resources
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources
```

### Tag: package-subscriptions-2022-12 and python

These settings apply only when `--tag=package-subscriptions-2022-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-subscriptions-2022-12'
title: SubscriptionClient
namespace: azure.mgmt.resource.subscriptions
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/subscriptions
```

### Tag: package-changes-2022-05 and python

These settings apply only when `--tag=package-changes-2022-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-changes-2022-05'
title: ChangesClient
namespace: azure.mgmt.resource.changes
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/changes
```

### Tag: package-databoundaries-2024-08 and python

These settings apply only when `--tag=package-databoundaries-2024-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-databoundaries-2024-08'
title: DataBoundaryMgmtClient
namespace: azure.mgmt.resource.databoundaries
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/databoundaries
directive:
  - remove-operation: "Operations_List"
```
