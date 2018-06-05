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

``` yaml $(csharp) && !$(multiApi)
namespace: Microsoft.Azure.Management.ResourceManager  
output-folder: $(csharp-sdks-folder)/Resource/Management.ResourceManager/Generated

batch:
  - package-features: true
  - package-locks: true
  - package-policy: true
  - package-resources: true
  - package-subscriptions: true
  - package-links: true
#  - package-managedapplications: true
```











## Azure Stack Batch settings
These settings are for batch mode only: (ie, add `--MultiApi` to the command line )

``` yaml $(multiApi)
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

``` yaml $(Seperator)
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

``` yaml $(Seperator)
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
