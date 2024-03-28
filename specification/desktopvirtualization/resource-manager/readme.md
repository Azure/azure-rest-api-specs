# DesktopVirtualization

> see https://aka.ms/autorest

This is the AutoRest configuration file for Desktop Virtualization.

---

## Getting Started

To build the SDK for DesktopVirtualizationClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the DesktopVirtualizationClient API.

``` yaml
openapi-type: arm
tag: package-preview-2024-01
```


### Tag: package-preview-2024-01

These settings apply only when `--tag=package-preview-2024-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-01'
input-file:
  - Microsoft.DesktopVirtualization/preview/2024-01-16-preview/desktopvirtualization.json
suppressions:
  - code: ResourceNameRestriction
    from: desktopvirtualization.json
    reason: Pattern restriction will be a breaking change. Update for next stable version. Work item to fix https://microsoft.visualstudio.com/OS/_workitems/edit/47527278
```
### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-11'
input-file:
  - Microsoft.DesktopVirtualization/preview/2023-11-01-preview/desktopvirtualization.json
suppressions:
  - code: ResourceNameRestriction
    from: desktopvirtualization.json
    reason: Pattern restriction will be a breaking change. Update for next stable version. Work item to fix https://microsoft.visualstudio.com/OS/_workitems/edit/47527278
```

### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-10'
input-file:
  - Microsoft.DesktopVirtualization/preview/2023-10-04-preview/desktopvirtualization.json
suppressions:
  - code: ResourceNameRestriction
    reason: HostPoolName, ApplicationGroupName, WorkspaceName, ScalingPlanName were already implemented in previous versions of the API and we cannot change naming pattern now.
```

### Tag: package-2023-09

These settings apply only when `--tag=package-2023-09` is specified on the command line.

``` yaml $(tag) == 'package-2023-09'
input-file:
  - Microsoft.DesktopVirtualization/stable/2023-09-05/desktopvirtualization.json
```

### Tag: package-preview-2023-07

These settings apply only when `--tag=package-preview-2023-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-07'
input-file:
  - Microsoft.DesktopVirtualization/preview/2023-07-07-preview/desktopvirtualization.json

suppressions:
  - code: ResourceNameRestriction
    reason: ScalingPlan was already implemented in previous versions of the API and
      we cannot change naming pattern now.
  - code: PatchIdentityProperty
    reason: There is an error loop with the identity property. We received approval to suppress this error, but we still need to investigate error loop.
```

### Tag: package-preview-2022-10

These settings apply only when `--tag=package-preview-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-10'
input-file:
  - Microsoft.DesktopVirtualization/preview/2022-10-14-preview/desktopvirtualization.json
```

### Tag: package-2022-09

These settings apply only when `--tag=package-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-2022-09'
input-file:
  - Microsoft.DesktopVirtualization/stable/2022-09-09/desktopvirtualization.json
```

### Tag: package-preview-2022-04

These settings apply only when `--tag=package-preview-2022-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-04'
input-file:
  - Microsoft.DesktopVirtualization/preview/2022-04-01-preview/desktopvirtualization.json
```

### Tag: package-preview-2022-02

These settings apply only when `--tag=package-preview-2022-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-02'
input-file:
  - Microsoft.DesktopVirtualization/preview/2022-02-10-preview/desktopvirtualization.json
```

### Tag: package-preview-2021-09

These settings apply only when `--tag=package-preview-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-09'
input-file:
  - Microsoft.DesktopVirtualization/preview/2021-09-03-preview/desktopvirtualization.json
```

### Tag: package-2021-07

These settings apply only when `--tag=package-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-2021-07'
input-file:
  - Microsoft.DesktopVirtualization/stable/2021-07-12/desktopvirtualization.json
```

### Tag: package-2019-01-23-preview

These settings apply only when `--tag=package-2019-01-23-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-01-23-preview'
input-file:
- Microsoft.DesktopVirtualization/preview/2019-01-23-preview/desktopvirtualization.json
```

### Tag: package-2019-09-24-preview

These settings apply only when `--tag=package-2019-09-24-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-09-24-preview'
input-file:
- Microsoft.DesktopVirtualization/preview/2019-09-24-preview/desktopvirtualization.json
```

### Tag: package-2019-12-10-preview

These settings apply only when `--tag=package-2019-12-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-12-10-preview'
input-file:
- Microsoft.DesktopVirtualization/preview/2019-12-10-preview/desktopvirtualization.json
```

### Tag: package-2020-09-21-preview

These settings apply only when `--tag=package-2020-09-21-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-09-21-preview'
input-file:
- Microsoft.DesktopVirtualization/preview/2020-09-21-preview/desktopvirtualization.json
```

### Tag: package-2020-10-19-preview

These settings apply only when `--tag=package-2020-10-19-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-10-19-preview'
input-file:
- Microsoft.DesktopVirtualization/preview/2020-10-19-preview/desktopvirtualization.json
```

### Tag: package-2020-11-02-preview

These settings apply only when `--tag=package-2020-11-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-11-02-preview'
input-file:
- Microsoft.DesktopVirtualization/preview/2020-11-02-preview/desktopvirtualization.json
```

### Tag: package-2020-11-10-preview

``` yaml $(tag) == 'package-2020-11-10-preview'
input-file:
- Microsoft.DesktopVirtualization/preview/2020-11-10-preview/desktopvirtualization.json
```

### Tag: package-2021-01-14-preview

``` yaml $(tag) == 'package-2021-01-14-preview'
input-file:
- Microsoft.DesktopVirtualization/preview/2021-01-14-preview/desktopvirtualization.json
```

### Tag: package-2021-02-01-preview

``` yaml $(tag) == 'package-2021-02-01-preview'
input-file:
- Microsoft.DesktopVirtualization/preview/2021-02-01-preview/desktopvirtualization.json
```

### Tag: package-2021-03-09-preview

``` yaml $(tag) == 'package-2021-03-09-preview'
input-file:
- Microsoft.DesktopVirtualization/preview/2021-03-09-preview/desktopvirtualization.json
```

### Tag: package-2021-04-01-preview

``` yaml $(tag) == 'package-2021-04-01-preview'
input-file:
- Microsoft.DesktopVirtualization/preview/2021-04-01-preview/desktopvirtualization.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_desktop_virtualization']
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## Node

See configuration in [readme.node.md](./readme.node.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)
