# C# Compute

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

## Common C# settings

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 1
  clear-output-folder: true

# remove DUMMY member of enum
directive:
    # dynamically add a DummyOrchestrationServiceName value to the enum 
  - from: compute.json
    where: $..enum
    transform: >-
      if( $.length === 1 && $[0] === "AutomaticRepairs") { 
        $.push('DummyOrchestrationServiceName');
      }
      return $;
    
    # remove it from the C# generated code
  - from: source-file-csharp
    where: $ 
    transform: >-
      return $.
        replace(/.*public const string DummyOrchestrationServiceName.*/g,'').
        replace(/, 'DummyOrchestrationServiceName'/g,'');
```

``` yaml $(csharp) && !$(multiapi) && !$(csharp-profile)
namespace: Microsoft.Azure.Management.Compute
output-folder: $(csharp-sdks-folder)/compute/Microsoft.Azure.Management.Compute/src/Generated
```

## Batch settings
These settings are for batch mode only: (ie, add `--multiapi` to the command line )

```yaml $(multiapi)
namespace: Microsoft.Azure.Management.Compute.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
  - tag: package-2017-03
    ApiVersionName: Api2017_03_30

  - tag: package-2016-03
    ApiVersionName: Api2016_03_30
```


### Profile: hybrid_2018_03_01

These settings apply only when `--csharp-profile=hybrid_2018_03_01` is specified on the command line.

```yaml $(csharp-profile)=='hybrid_2018_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).Compute
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Compute/Management.Compute/Generated
batch:
  - tag: package-disks-2018-04
  - tag: package-compute-only-2017-12
  - tag: package-skus-2017-09
  - tag: package-compute-2017-03
```

### Profile: profile_2017_03_09

These settings apply only when `--csharp-profile=profile_2017_03_09` is specified on the command line.

``` yaml $(csharp-profile)=='profile_2017_03_09'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).Compute
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Compute/Management.Compute/Generated

batch:
 - tag: package-compute-2016-03
 ```

### Profile: hybrid_2019_03_01

These settings apply only when `--csharp-profile=hybrid_2019_03_01` is specified on the command line.

``` yaml $(csharp-profile)=='hybrid_2019_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).Compute
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Compute/Management.Compute/Generated

batch:
 - tag: profile-hybrid-2019-03-01
 ```
