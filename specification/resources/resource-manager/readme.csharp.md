# C# ResourceManager

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

## Common C# Settings
``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION  
  clear-output-folder: true
```

``` yaml $(csharp) && !$(multiapi) && !$(csharp-profile)
namespace: Microsoft.Azure.Management.ResourceManager  
output-folder: $(csharp-sdks-folder)/resources/Microsoft.Azure.Management.ResourceManager/src/Generated

batch:
  - package-features: true
  - package-locks: true
  - package-policy: true
  - package-resources: true
  - package-subscriptions: true
  - package-links: true
  - package-deploymentscripts: true
  - package-templatespecs: true
#  - package-managedapplications: true
```

## Azure Stack Batch settings
These settings are for batch mode only: (ie, add `--multiapi` to the command line )


``` yaml $(multiapi)
namespace: Microsoft.Azure.Management.ResourceManager.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
  - resources-2016-02-01: true
    ApiVersionName: Api2016_02_01
  - links-2016-09-01: true
    ApiVersionName: Api2016_02_01
  - subscription-2016-06-01: true
    ApiVersionName: Api2016_02_01
  - locks-2015-01-01: true
    ApiVersionName: Api2016_02_01
  - policy-2015-10-01: true
    ApiVersionName: Api2016_02_01

  - resources-2018-02-01: true
    ApiVersionName: Api2018_02_01
  - links-2016-09-01: true
    ApiVersionName: Api2018_02_01
  - subscription-2016-06-01: true
    ApiVersionName: Api2018_02_01
  - locks-2016-09-01: true
    ApiVersionName: Api2018_02_01
  - policyA-2016-12-01: true
    ApiVersionName: Api2018_02_01
  - policyD-2016-12-01: true
    ApiVersionName: Api2018_02_01

  - resources-2018-05-01: true
    ApiVersionName: Api2018_05_01
  - links-2016-09-01: true
    ApiVersionName: Api2018_05_01
  - subscription-2016-06-01: true
    ApiVersionName: Api2018_05_01
  - locks-2016-09-01: true
    ApiVersionName: Api2018_05_01
  - policyA-2016-12-01: true
    ApiVersionName: Api2018_05_01
  - policyD-2016-12-01: true
    ApiVersionName: Api2018_05_01

  - resources-2019-05-01: true
    ApiVersionName: Api2019_05_01
  - links-2016-09-01: true
    ApiVersionName: Api2019_05_01
  - subscription-2016-06-01: true
    ApiVersionName: Api2019_05_01
  - locks-2016-09-01: true
    ApiVersionName: Api2019_05_01
  - policyA-2016-12-01: true
    ApiVersionName: Api2019_05_01
  - policyD-2016-12-01: true
    ApiVersionName: Api2019_05_01

  - resources-2019-05-10: true
    ApiVersionName: Api2019_05_10
  - links-2016-09-01: true
    ApiVersionName: Api2019_05_10
  - subscription-2016-06-01: true
    ApiVersionName: Api2019_05_10
  - locks-2016-09-01: true
    ApiVersionName: Api2019_05_10
  - policyA-2016-12-01: true
    ApiVersionName: Api2019_05_10
  - policyD-2016-12-01: true
    ApiVersionName: Api2019_05_10

  - resources-2019-07-01: true
    ApiVersionName: Api2019_07_01
  - links-2016-09-01: true
    ApiVersionName: Api2019_07_01
  - subscription-2016-06-01: true
    ApiVersionName: Api2019_07_01
  - locks-2016-09-01: true
    ApiVersionName: Api2019_07_01
  - policyA-2016-12-01: true
    ApiVersionName: Api2019_07_01
  - policyD-2016-12-01: true
    ApiVersionName: Api2019_07_01

  - resources-2019-08-01: true
    ApiVersionName: Api2019_08_01
  - links-2016-09-01: true
    ApiVersionName: Api2019_08_01
  - subscription-2016-06-01: true
    ApiVersionName: Api2019_08_01
  - locks-2016-09-01: true
    ApiVersionName: Api2019_08_01
  - policyA-2016-12-01: true
    ApiVersionName: Api2019_08_01
  - policyD-2016-12-01: true
    ApiVersionName: Api2019_08_01

  - resources-2019-10-01: true
    ApiVersionName: Api2019_10_01
  - links-2016-09-01: true
    ApiVersionName: Api2019_10_01
  - subscription-2016-06-01: true
    ApiVersionName: Api2019_10_01
  - locks-2016-09-01: true
    ApiVersionName: Api2019_10_01
  - policyA-2016-12-01: true
    ApiVersionName: Api2019_10_01
  - policyD-2016-12-01: true
    ApiVersionName: Api2019_10_01

  - resources-2020-06-01: true
    ApiVersionName: Api2020_06_01
  - links-2016-09-01: true
    ApiVersionName: Api2020_06_01
  - subscription-2016-06-01: true
    ApiVersionName: Api2020_06_01
  - locks-2016-09-01: true
    ApiVersionName: Api2020_06_01
  - policyA-2016-12-01: true
    ApiVersionName: Api2020_06_01
  - policyD-2016-12-01: true
    ApiVersionName: Api2020_06_01
```


``` yaml $(resources-2016-02-01)
tag: pkg-2016-02-Az-res
```

``` yaml $(links-2016-09-01)
tag: pkg-2016-02-Az-lnk
```

``` yaml $(subscription-2016-06-01)
tag: pkg-2016-02-Az-sub
```

``` yaml $(locks-2015-01-01)
tag: pkg-2016-02-Az-loc
```

``` yaml $(policy-2015-10-01)
tag: pkg-2016-02-Az-pol
```

## Tag: Packages for Azure Stack
### 1) pkg-2016-02-AzStk-res
``` yaml $(tag) == 'pkg-2016-02-Az-res'
input-file:
- Microsoft.Resources/stable/2016-02-01/resources.json
```

### 2) pkg-2016-02-AzStk-lnk
``` yaml $(tag) == 'pkg-2016-02-Az-lnk'
input-file:
- Microsoft.Resources/stable/2016-09-01/links.json
```

### 3) pkg-2016-02-AzStk-sub
``` yaml $(tag) == 'pkg-2016-02-Az-sub'
input-file:
- Microsoft.Resources/stable/2016-06-01/subscriptions.json
```

### 4) pkg-2016-02-AzStk-loc
``` yaml $(tag) == 'pkg-2016-02-Az-loc'
input-file:
- Microsoft.Authorization/stable/2015-01-01/locks.json
```

### 5) pkg-2016-02-AzStk-pol
``` yaml $(tag) == 'pkg-2016-02-Az-pol'
input-file:
- Microsoft.Authorization/preview/2015-10-01-preview/policy.json
```

``` yaml $(Separator)
###########################################################################
###########################################################################
```


``` yaml $(resources-2018-02-01)
tag: pkg-2018-02-Az-res
```

``` yaml $(links-2016-09-01)
tag: pkg-2018-02-Az-lnk
```

``` yaml $(subscription-2016-06-01)
tag: pkg-2018-02-Az-sub
```

``` yaml $(locks-2016-09-01)
tag: pkg-2018-02-Az-loc
```

``` yaml $(policyA-2016-12-01)
tag: pkg-2018-02-Az-polA
```

``` yaml $(policyD-2016-12-01)
tag: pkg-2018-02-Az-polD
```


## Tag: Packages for Azure Stack
### 1) pkg-2018-02-AzStk-res
``` yaml $(tag) == 'pkg-2018-02-Az-res'
input-file:
- Microsoft.Resources/stable/2018-02-01/resources.json
```

### 2) pkg-2018-02-AzStk-lnk
``` yaml $(tag) == 'pkg-2018-02-Az-lnk'
input-file:
- Microsoft.Resources/stable/2016-09-01/links.json
```

### 3) pkg-2018-02-AzStk-sub
``` yaml $(tag) == 'pkg-2018-02-Az-sub'
input-file:
- Microsoft.Resources/stable/2016-06-01/subscriptions.json
```

### 4) pkg-2018-02-AzStk-loc
``` yaml $(tag) == 'pkg-2018-02-Az-loc'
input-file:
- Microsoft.Authorization/stable/2016-09-01/locks.json
```

### 5) pkg-2018-02-AzStk-polA
``` yaml $(tag) == 'pkg-2018-02-Az-polA'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyAssignments.json
```

### 6) pkg-2018-02-AzStk-polD
``` yaml $(tag) == 'pkg-2018-02-Az-polD'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
```
``` yaml $(Separator)
###########################################################################
###########################################################################
```

``` yaml $(resources-2020-06-01)
tag: pkg-2020-06-Az-res
```

``` yaml $(links-2016-09-01)
tag: pkg-2020-06-Az-lnk
```

``` yaml $(subscription-2016-06-01)
tag: pkg-2020-06-Az-sub
```

``` yaml $(locks-2016-09-01)
tag: pkg-2020-06-Az-loc
```

``` yaml $(policyA-2016-12-01)
tag: pkg-2020-06-Az-polA
```

``` yaml $(policyD-2016-12-01)
tag: pkg-2020-06-Az-polD
```


## Tag: Packages for Azure Stack
### 1) pkg-2020-06-AzStk-res
``` yaml $(tag) == 'pkg-2020-06-Az-res'
input-file:
- Microsoft.Resources/stable/2019-05-01/resources.json
```

### 2) pkg-2020-06-AzStk-lnk
``` yaml $(tag) == 'pkg-2020-06-Az-lnk'
input-file:
- Microsoft.Resources/stable/2016-09-01/links.json
```

### 3) pkg-2020-06-AzStk-sub
``` yaml $(tag) == 'pkg-2020-06-Az-sub'
input-file:
- Microsoft.Resources/stable/2016-06-01/subscriptions.json
```

### 4) pkg-2020-06-AzStk-loc
``` yaml $(tag) == 'pkg-2020-06-Az-loc'
input-file:
- Microsoft.Authorization/stable/2016-09-01/locks.json
```

### 5) pkg-2020-06-AzStk-polA
``` yaml $(tag) == 'pkg-2020-06-Az-polA'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyAssignments.json
```

### 6) pkg-2020-06-AzStk-polD
``` yaml $(tag) == 'pkg-2020-06-Az-polD'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
```

``` yaml $(Separator)
###########################################################################
###########################################################################
```


``` yaml $(resources-2018-05-01)
tag: pkg-2018-05-Az-res
```

``` yaml $(links-2016-09-01)
tag: pkg-2018-05-Az-lnk
```

``` yaml $(subscription-2016-06-01)
tag: pkg-2018-05-Az-sub
```

``` yaml $(locks-2016-09-01)
tag: pkg-2018-05-Az-loc
```

``` yaml $(policyA-2016-12-01)
tag: pkg-2018-05-Az-polA
```

``` yaml $(policyD-2016-12-01)
tag: pkg-2018-05-Az-polD
```


## Tag: Packages for Azure Stack
### 1) pkg-2018-05-AzStk-res
``` yaml $(tag) == 'pkg-2018-05-Az-res'
input-file:
- Microsoft.Resources/stable/2018-05-01/resources.json
```

### 2) pkg-2018-05-AzStk-lnk
``` yaml $(tag) == 'pkg-2018-05-Az-lnk'
input-file:
- Microsoft.Resources/stable/2016-09-01/links.json
```

### 3) pkg-2018-05-AzStk-sub
``` yaml $(tag) == 'pkg-2018-05-Az-sub'
input-file:
- Microsoft.Resources/stable/2016-06-01/subscriptions.json
```

### 4) pkg-2018-05-AzStk-loc
``` yaml $(tag) == 'pkg-2018-05-Az-loc'
input-file:
- Microsoft.Authorization/stable/2016-09-01/locks.json
```

### 5) pkg-2018-05-AzStk-polA
``` yaml $(tag) == 'pkg-2018-05-Az-polA'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyAssignments.json
```

### 6) pkg-2018-05-AzStk-polD
``` yaml $(tag) == 'pkg-2018-05-Az-polD'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
```

``` yaml $(Separator)
###########################################################################
###########################################################################
```


``` yaml $(resources-2019-05-01)
tag: pkg-2019-05-Az-res
```

``` yaml $(links-2016-09-01)
tag: pkg-2019-05-Az-lnk
```

``` yaml $(subscription-2016-06-01)
tag: pkg-2019-05-Az-sub
```

``` yaml $(locks-2016-09-01)
tag: pkg-2019-05-Az-loc
```

``` yaml $(policyA-2016-12-01)
tag: pkg-2019-05-Az-polA
```

``` yaml $(policyD-2016-12-01)
tag: pkg-2019-05-Az-polD
```


## Tag: Packages for Azure Stack
### 1) pkg-2019-05-AzStk-res
``` yaml $(tag) == 'pkg-2019-05-Az-res'
input-file:
- Microsoft.Resources/stable/2019-05-01/resources.json
```

### 2) pkg-2019-05-AzStk-lnk
``` yaml $(tag) == 'pkg-2019-05-Az-lnk'
input-file:
- Microsoft.Resources/stable/2016-09-01/links.json
```

### 3) pkg-2019-05-AzStk-sub
``` yaml $(tag) == 'pkg-2019-05-Az-sub'
input-file:
- Microsoft.Resources/stable/2016-06-01/subscriptions.json
```

### 4) pkg-2019-05-AzStk-loc
``` yaml $(tag) == 'pkg-2019-05-Az-loc'
input-file:
- Microsoft.Authorization/stable/2016-09-01/locks.json
```

### 5) pkg-2019-05-AzStk-polA
``` yaml $(tag) == 'pkg-2019-05-Az-polA'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyAssignments.json
```

### 6) pkg-2019-05-AzStk-polD
``` yaml $(tag) == 'pkg-2019-05-Az-polD'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
```

``` yaml $(Separator)
###########################################################################
###########################################################################
```


``` yaml $(resources-2019-05-10)
tag: pkg-2019-0510-Az-res
```

``` yaml $(links-2016-09-01)
tag: pkg-2019-0510-Az-lnk
```

``` yaml $(subscription-2016-06-01)
tag: pkg-2019-0510-Az-sub
```

``` yaml $(locks-2016-09-01)
tag: pkg-2019-0510-Az-loc
```

``` yaml $(policyA-2016-12-01)
tag: pkg-2019-0510-Az-polA
```

``` yaml $(policyD-2016-12-01)
tag: pkg-2019-0510-Az-polD
```


## Tag: Packages for Azure Stack
### 1) pkg-2019-0510-AzStk-res
``` yaml $(tag) == 'pkg-2019-0510-Az-res'
input-file:
- Microsoft.Resources/stable/2019-05-10/resources.json
```

### 2) pkg-2019-0510-AzStk-lnk
``` yaml $(tag) == 'pkg-2019-0510-Az-lnk'
input-file:
- Microsoft.Resources/stable/2016-09-01/links.json
```

### 3) pkg-2019-0510-AzStk-sub
``` yaml $(tag) == 'pkg-2019-0510-Az-sub'
input-file:
- Microsoft.Resources/stable/2016-06-01/subscriptions.json
```

### 4) pkg-2019-0510-AzStk-loc
``` yaml $(tag) == 'pkg-2019-0510-Az-loc'
input-file:
- Microsoft.Authorization/stable/2016-09-01/locks.json
```

### 5) pkg-2019-0510-AzStk-polA
``` yaml $(tag) == 'pkg-2019-0510-Az-polA'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyAssignments.json
```

### 6) pkg-2019-0510-AzStk-polD
``` yaml $(tag) == 'pkg-2019-0510-Az-polD'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
```

``` yaml $(Separator)
###########################################################################
###########################################################################
```


``` yaml $(resources-2019-07-01)
tag: pkg-2019-07-Az-res
```

``` yaml $(links-2016-09-01)
tag: pkg-2019-07-Az-lnk
```

``` yaml $(subscription-2016-06-01)
tag: pkg-2019-07-Az-sub
```

``` yaml $(locks-2016-09-01)
tag: pkg-2019-07-Az-loc
```

``` yaml $(policyA-2016-12-01)
tag: pkg-2019-07-Az-polA
```

``` yaml $(policyD-2016-12-01)
tag: pkg-2019-07-Az-polD
```


## Tag: Packages for Azure Stack
### 1) pkg-2019-07-AzStk-res
``` yaml $(tag) == 'pkg-2019-07-Az-res'
input-file:
- Microsoft.Resources/stable/2019-07-01/resources.json
```

### 2) pkg-2019-07-AzStk-lnk
``` yaml $(tag) == 'pkg-2019-07-Az-lnk'
input-file:
- Microsoft.Resources/stable/2016-09-01/links.json
```

### 3) pkg-2019-07-AzStk-sub
``` yaml $(tag) == 'pkg-2019-07-Az-sub'
input-file:
- Microsoft.Resources/stable/2016-06-01/subscriptions.json
```

### 4) pkg-2019-07-AzStk-loc
``` yaml $(tag) == 'pkg-2019-07-Az-loc'
input-file:
- Microsoft.Authorization/stable/2016-09-01/locks.json
```

### 5) pkg-2019-07-AzStk-polA
``` yaml $(tag) == 'pkg-2019-07-Az-polA'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyAssignments.json
```

### 6) pkg-2019-07-AzStk-polD
``` yaml $(tag) == 'pkg-2019-07-Az-polD'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
```

``` yaml $(Separator)
###########################################################################
###########################################################################
```


``` yaml $(resources-2019-08-01)
tag: pkg-2019-08-Az-res
```

``` yaml $(links-2016-09-01)
tag: pkg-2019-08-Az-lnk
```

``` yaml $(subscription-2016-06-01)
tag: pkg-2019-08-Az-sub
```

``` yaml $(locks-2016-09-01)
tag: pkg-2019-08-Az-loc
```

``` yaml $(policyA-2016-12-01)
tag: pkg-2019-08-Az-polA
```

``` yaml $(policyD-2016-12-01)
tag: pkg-2019-08-Az-polD
```


## Tag: Packages for Azure Stack
### 1) pkg-2019-08-AzStk-res
``` yaml $(tag) == 'pkg-2019-08-Az-res'
input-file:
- Microsoft.Resources/stable/2019-08-01/resources.json
```

### 2) pkg-2019-08-AzStk-lnk
``` yaml $(tag) == 'pkg-2019-08-Az-lnk'
input-file:
- Microsoft.Resources/stable/2016-09-01/links.json
```

### 3) pkg-2019-08-AzStk-sub
``` yaml $(tag) == 'pkg-2019-08-Az-sub'
input-file:
- Microsoft.Resources/stable/2016-06-01/subscriptions.json
```

### 4) pkg-2019-08-AzStk-loc
``` yaml $(tag) == 'pkg-2019-08-Az-loc'
input-file:
- Microsoft.Authorization/stable/2016-09-01/locks.json
```

### 5) pkg-2019-08-AzStk-polA
``` yaml $(tag) == 'pkg-2019-08-Az-polA'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyAssignments.json
```

### 6) pkg-2019-08-AzStk-polD
``` yaml $(tag) == 'pkg-2019-08-Az-polD'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
```

``` yaml $(Separator)
###########################################################################
###########################################################################
```


``` yaml $(resources-2019-10-01)
tag: pkg-2019-10-Az-res
```

``` yaml $(links-2016-09-01)
tag: pkg-2019-10-Az-lnk
```

``` yaml $(subscription-2016-06-01)
tag: pkg-2019-10-Az-sub
```

``` yaml $(locks-2016-09-01)
tag: pkg-2019-10-Az-loc
```

``` yaml $(policyA-2016-12-01)
tag: pkg-2019-10-Az-polA
```

``` yaml $(policyD-2016-12-01)
tag: pkg-2019-10-Az-polD
```


## Tag: Packages for Azure Stack
### 1) pkg-2019-10-AzStk-res
``` yaml $(tag) == 'pkg-2019-10-Az-res'
input-file:
- Microsoft.Resources/stable/2019-10-01/resources.json
```

### 2) pkg-2019-10-AzStk-lnk
``` yaml $(tag) == 'pkg-2019-10-Az-lnk'
input-file:
- Microsoft.Resources/stable/2016-09-01/links.json
```

### 3) pkg-2019-10-AzStk-sub
``` yaml $(tag) == 'pkg-2019-10-Az-sub'
input-file:
- Microsoft.Resources/stable/2016-06-01/subscriptions.json
```

### 4) pkg-2019-10-AzStk-loc
``` yaml $(tag) == 'pkg-2019-10-Az-loc'
input-file:
- Microsoft.Authorization/stable/2016-09-01/locks.json
```

### 5) pkg-2019-10-AzStk-polA
``` yaml $(tag) == 'pkg-2019-10-Az-polA'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyAssignments.json
```

### 6) pkg-2019-10-AzStk-polD
``` yaml $(tag) == 'pkg-2019-10-Az-polD'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
```

### Profile: hybrid_2018_03_01

These settings apply only when `--profile=hybrid_2018_03_01` is specified on the command line.

```yaml $(csharp-profile)=='hybrid_2018_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).ResourceManager  
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Resource/Management.ResourceManager/Generated

batch:
  - tag: package-features-2015-12
  - tag: package-locks-2016-09
  - tag: package-policy-2018-03
  - tag: package-policy-2016-12
  - tag: package-resources-2018-02
  - tag: package-resources-2016-09
  - tag: package-subscriptions-2016-06
```

### Profile: profile_2017_03_09

These settings apply only when `--profile=profile_2017_03_09` is specified on the command line.

``` yaml $(csharp-profile)=='profile_2017_03_09'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).ResourceManager  
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Resource/Management.ResourceManager/Generated

batch:
 - tag: package-resources-2016-02
 - tag: package-links-2016-09
 - tag: package-subscriptions-2016-06
 ```

### Profile: hybrid_2019_03_01

These settings apply only when `--csharp-profile=hybrid_2019_03_01` is specified on the command line.

``` yaml $(csharp-profile)=='hybrid_2019_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).ResourceManager  
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Resource/Management.ResourceManager/Generated

batch:
 - tag: package-policy-2016-12
 - tag: package-locks-2016-09
 - tag: package-resources-2018-05
 ```

### Profile: hybrid_2020_09_01

These settings apply only when `--csharp-profile=hybrid_2020_09_01` is specified on the command line.

``` yaml $(csharp-profile)=='hybrid_2020_09_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).ResourceManager  
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Resource/Management.ResourceManager/Generated

batch:
#  - tag: package-subscriptions-2020-01
 - tag: package-resources-2020-06
 ```