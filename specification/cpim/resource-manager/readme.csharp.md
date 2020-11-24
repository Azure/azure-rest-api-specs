# C# CPIM

> see https://aka.ms/autorest

This is the AutoRest configuration file for CPIM.

## Common C# Settings

```yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  client-side-validation: false
  payload-flattening-threshold: 1  
```

``` yaml $(csharp) && !$(multiapi) && !$(csharp-profile)
namespace: Microsoft.AzureActiveDirectory
output-folder: $(csharp-sdks-folder)/cpim/management/Microsoft.AzureActiveDirectory/GeneratedProtocol
```

## Batch settings

These settings are for batch mode only: (ie, add `--multiapi` to the command line )

```yaml $(multiapi)
namespace: Microsoft.AzureActiveDirectory.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
  - tag: package-2019-01-01-preview 
  - tag: package-2020-05-01-preview 
```

### Tag: package-2019-01-01-preview

These settings apply only when `--tag=package-2019-01-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-01-01-preview'
input-file:
- Microsoft.AzureActiveDirectory/preview/2019-01-01-preview/cpimTenant.json
```

### Tag: package-2020-05-01-preview

These settings apply only when `--tag=package-2020-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-05-01-preview'
input-file:
- Microsoft.AzureActiveDirectory/preview/2020-05-01-preview/cpimTenant.json
```
