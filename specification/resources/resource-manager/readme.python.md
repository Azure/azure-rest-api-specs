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
  - tag: package-policy-2023-04
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
  - tag: package-resources-2022-09
  - tag: package-resources-2021-04
  - tag: package-resources-2021-01
  - tag: package-resources-2020-10
  - tag: package-resources-2020-06
  - tag: package-resources-2019-10
  - tag: package-resources-2019-08
  - tag: package-resources-2019-07
  - tag: package-resources-2019-0510
  - tag: package-resources-2019-05
  - tag: package-resources-2019-03
  - tag: package-resources-2018-05
  - tag: package-resources-2018-02
  - tag: package-resources-2017-05
  - tag: package-resources-2016-09
  - tag: package-resources-2016-02
  - multiapiscript-resources: true
  - tag: package-subscriptions-2022-12
  - tag: package-subscriptions-2021-01
  - tag: package-subscriptions-2019-11
  - tag: package-subscriptions-2019-06
  - tag: package-subscriptions-2018-06
  - tag: package-subscriptions-2016-06
  - multiapiscript-subscriptions: true
  - tag: package-deploymentscripts-2023-08
  - tag: package-deploymentscripts-2020-10
  - tag: package-deploymentscripts-2019-10-preview
  - multiapiscript-deploymentscripts: true
  - tag: package-templatespecs-2022-02
  - tag: package-templatespecs-2021-05
  - tag: package-templatespecs-2021-03-preview
  - tag: package-templatespecs-2019-06-preview
  - multiapiscript-templatespecs: true
  - tag: package-deploymentstacks-2022-08-preview
  - multiapiscript-deploymentstacks: true
  - tag: package-changes-2022-05
  - multiapiscript-changes: true
```

```yaml $(multiapiscript-changes)
package-name: azure-mgmt-resource#changes
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/changes
perform-load: false
```

```yaml $(multiapiscript-privatelinks)
package-name: azure-mgmt-resource#privatelinks
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/privatelinks
perform-load: false
```

```yaml $(multiapiscript-features)
package-name: azure-mgmt-resource#features
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/features
perform-load: false
```

```yaml $(multiapiscript-policy)
package-name: azure-mgmt-resource#policy
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/policy
perform-load: false
```

```yaml $(multiapiscript-resources)
package-name: azure-mgmt-resource#resources
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources
perform-load: false
```

```yaml $(multiapiscript-subscriptions)
package-name: azure-mgmt-resource#subscriptions
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/subscriptions
perform-load: false
```

```yaml $(multiapiscript-deploymentscripts)
package-name: azure-mgmt-resource#deploymentscripts
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/deploymentscripts
perform-load: false
```


```yaml $(multiapiscript-templatespecs)
package-name: azure-mgmt-resource#templatespecs
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/templatespecs
perform-load: false
```

```yaml $(multiapiscript-deploymentstacks)
package-name: azure-mgmt-resource#deploymentstacks
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/deploymentstacks
perform-load: false
```

```yaml $(multiapiscript-locks)
package-name: azure-mgmt-resource#locks
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/locks
perform-load: false
```

```yaml $(multiapiscript-managedapplications)
package-name: azure-mgmt-resource#managedapplications
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/managedapplications
perform-load: false
```

```yaml $(multiapiscript-links)
package-name: azure-mgmt-resource#links
multiapiscript: true
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/links
perform-load: false
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

### Tag: package-policy-2023-04 and python

These settings apply only when `--tag=package-policy-2023-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2023-04'
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

### Tag: package-resources-2022-09 and python

These settings apply only when `--tag=package-resources-2022-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2022-09'
default-api-version: "2022-09-01"
namespace: azure.mgmt.resource.resources.v2022_09_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2022_09_01
```

### Tag: package-resources-2021-04 and python

These settings apply only when `--tag=package-resources-2021-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2021-04'
namespace: azure.mgmt.resource.resources.v2021_04_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2021_04_01
```

### Tag: package-resources-2021-01 and python

These settings apply only when `--tag=package-resources-2021-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2021-01'
namespace: azure.mgmt.resource.resources.v2021_01_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2021_01_01
```

### Tag: package-resources-2020-10 and python

These settings apply only when `--tag=package-resources-2020-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2020-10'
namespace: azure.mgmt.resource.resources.v2020_10_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2020_10_01
```

### Tag: package-resources-2020-06 and python

These settings apply only when `--tag=package-resources-2020-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2020-06'
namespace: azure.mgmt.resource.resources.v2020_06_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2020_06_01
```

### Tag: package-resources-2019-10 and python

These settings apply only when `--tag=package-resources-2019-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2019-10'
namespace: azure.mgmt.resource.resources.v2019_10_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2019_10_01
```

### Tag: package-resources-2019-08 and python

These settings apply only when `--tag=package-resources-2019-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2019-08'
namespace: azure.mgmt.resource.resources.v2019_08_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2019_08_01
```

### Tag: package-resources-2019-07 and python

These settings apply only when `--tag=package-resources-2019-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2019-07'
namespace: azure.mgmt.resource.resources.v2019_07_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2019_07_01
```

### Tag: package-resources-2019-0510 and python

These settings apply only when `--tag=package-resources-2019-0510 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2019-0510'
namespace: azure.mgmt.resource.resources.v2019_05_10
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2019_05_10
```

### Tag: package-resources-2019-05 and python

These settings apply only when `--tag=package-resources-2019-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2019-05'
namespace: azure.mgmt.resource.resources.v2019_05_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2019_05_01
```

### Tag: package-resources-2019-03 and python

These settings apply only when `--tag=package-resources-2019-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2019-03'
namespace: azure.mgmt.resource.resources.v2019_03_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2019_03_01
```

### Tag: package-resources-2018-05 and python

These settings apply only when `--tag=package-resources-2018-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2018-05'
namespace: azure.mgmt.resource.resources.v2018_05_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2018_05_01
```

### Tag: package-resources-2018-02 and python

These settings apply only when `--tag=package-resources-2018-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2018-02'
namespace: azure.mgmt.resource.resources.v2018_02_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2018_02_01
```

### Tag: package-resources-2017-05 and python

These settings apply only when `--tag=package-resources-2017-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2017-05'
namespace: azure.mgmt.resource.resources.v2017_05_10
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2017_05_10
```

### Tag: package-resources-2016-09 and python

These settings apply only when `--tag=package-resources-2016-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2016-09'
namespace: azure.mgmt.resource.resources.v2016_09_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2016_09_01
```

### Tag: package-resources-2016-02 and python

These settings apply only when `--tag=package-resources-2016-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2016-02'
namespace: azure.mgmt.resource.resources.v2016_02_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/resources/v2016_02_01
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

### Tag: package-deploymentscripts-2019-10-preview and python

These settings apply only when `--tag=package-deploymentscripts-2019-10-preview` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-deploymentscripts-2019-10-preview'
namespace: azure.mgmt.resource.deploymentscripts.v2019_10_01_preview
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/deploymentscripts/v2019_10_01_preview
```

### Tag: package-deploymentscripts-2020-10 and python

These settings apply only when `--tag=package-deploymentscripts-2020-10` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-deploymentscripts-2020-10'
default-api-version: "2020-10-01"
namespace: azure.mgmt.resource.deploymentscripts.v2020_10_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/deploymentscripts/v2020_10_01
```

### Tag: package-deploymentscripts-2023-08 and python

These settings apply only when `--tag=package-deploymentscripts-2023-08` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-deploymentscripts-2023-08'
default-api-version: "2023-08-01"
namespace: azure.mgmt.resource.deploymentscripts.v2023_08_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/deploymentscripts/v2023_08_01
```

### Tag: package-templatespecs-2019-06-preview and python

These settings apply only when `--tag=package-templatespecs-2019-06-preview` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-templatespecs-2019-06-preview'
namespace: azure.mgmt.resource.templatespecs.v2019_06_01_preview
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/templatespecs/v2019_06_01_preview
```

### Tag: package-templatespecs-2021-03-preview and python

These settings apply only when `--tag=package-templatespecs-2021-03-preview` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-templatespecs-2021-03-preview'
namespace: azure.mgmt.resource.templatespecs.v2021_03_01_preview
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/templatespecs/v2021_03_01_preview
```

### Tag: package-templatespecs-2021-05 and python

These settings apply only when `--tag=package-templatespecs-2021-05` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-templatespecs-2021-05'
namespace: azure.mgmt.resource.templatespecs.v2021_05_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/templatespecs/v2021_05_01
```

### Tag: package-templatespecs-2022-02 and python

These settings apply only when `--tag=package-templatespecs-2022-02` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-templatespecs-2022-02'
default-api-version: "2022-02-01"
namespace: azure.mgmt.resource.templatespecs.v2022_02_01
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/templatespecs/v2022_02_01
```

### Tag: package-deploymentstacks-2022-08-preview and python

These settings apply only when `--tag=package-deploymentstacks-2022-08-preview` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-deploymentstacks-2022-08-preview'
default-api-version: "2022-08-01-preview"
namespace: azure.mgmt.resource.deploymentstacks.v2022_08_01_preview
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/deploymentstacks/v2022_08_01_preview
```

``` yaml $(python)
modelerfour:
  lenient-model-deduplication: true
```
