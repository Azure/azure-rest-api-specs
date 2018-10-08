# C# Authorization

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

## Common C# Settings
``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION  
  clear-output-folder: true
```

### Tag: package-locks-2016-09

These settings apply only when `--tag=package-locks-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-locks-2016-09'
input-file:
- ../../resources/resource-manager/Microsoft.Authorization/stable/2016-09-01/locks.json
```

### Tag: package-locks-2015-01

These settings apply only when `--tag=package-locks-2015-01` is specified on the command line.

``` yaml $(tag) == 'package-locks-2015-01'
input-file:
- ../../resources/resource-manager/Microsoft.Authorization/stable/2015-01-01/locks.json
```

### Tag: package-policy-2016-12

These settings apply only when `--tag=package-policy-2016-12` is specified on the command line.

``` yaml $(tag) == 'package-policy-2016-12'
input-file:
- ../../resources/resource-manager/Microsoft.Authorization/stable/2016-12-01/policyAssignments.json
- ../../resources/resource-manager/Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
```

### Tag: package-policy-2015-10-01-preview

These settings apply only when `--tag=package-policy-2015-10-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-policy-2015-10-01-preview'
input-file:
- ../../resources/resource-manager/Microsoft.Authorization/preview/2015-10-01-preview/policy.json
```

``` yaml $(csharp) && !$(multiapi) && !$(profile)
namespace: Microsoft.Azure.Management.Authorization
output-folder: $(csharp-sdks-folder)/Authorization/Management.Authorization/Generated
```

## Batch settings
These settings are for batch mode only: (ie, add `--multiapi` to the command line )

``` yaml $(multiapi)
profile: hybrid_2018_03_01
namespace: Microsoft.Azure.Management.Profiles.$(profile).Authorization
output-folder: $(csharp-sdks-folder)/$(profile)/Authorization/Management.Authorization/Generated

batch:
 - tag: package-2015-07
 - tag: package-locks-2015-01
 ```

### Profile: hybrid_2018_03_01

These settings apply only when `--profile=hybrid_2018_03_01` is specified on the command line.

 ``` yaml $(profile)=='hybrid_2018_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(profile).Authorization
output-folder: $(csharp-sdks-folder)/$(profile)/Authorization/Management.Authorization/Generated

batch:
 - tag: package-2015-07
   apiVersion: package-2015-07
 - tag: package-locks-2016-09
   apiVersion: package-locks-2016-09
 - tag: package-policy-2016-12
   apiVersion: package-policy-2016-12
 ```

### Profile: profile_2017_03_09

These settings apply only when `--profile=profile_2017_03_09` is specified on the command line.

 ``` yaml $(profile)=='profile_2017_03_09'
namespace: Microsoft.Azure.Management.Profiles.$(profile).Authorization
output-folder: $(csharp-sdks-folder)/$(profile)/Authorization/Management.Authorization/Generated

batch:
 - tag: package-2015-07-authorization-only
   apiVersion: package-2015-07-authorization-only
 - tag: package-locks-2015-01
   apiVersion: package-locks-2015-01
 - tag: package-policy-2015-10-01-preview
   apiVersion: package-policy-2015-10-01-preview
 ```