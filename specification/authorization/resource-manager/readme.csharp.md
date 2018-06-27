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
 ```

 ``` yaml $(profile)=='hybrid-2018-03-01'
namespace: Microsoft.Azure.Management.Profiles.$(profile).Authorization
output-folder: $(csharp-sdks-folder)/$(profile)/Authorization/Management.Authorization/Generated

batch:
 - tag: package-2015-07

 directive:
  from: source-file-csharp
  where: $
  transform: >
    $ = $.replace( "hybrid-2018-03-01", "hybrid_2018_03_01" );
 ```