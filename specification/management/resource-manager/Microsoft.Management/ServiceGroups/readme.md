# Service Groups

> see https://aka.ms/autorest

This is the AutoRest configuration file for Service Groups.

---

## Getting Started

To build the SDK for Service Groups, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the API.

``` yaml
openapi-type: arm
tag: package-2026-08
```

### Tag: package-2026-08

These settings apply only when `--tag=package-2026-08` is specified on the command line.

```yaml $(tag) == 'package-2026-08'
input-file:
  - stable/2026-08-01/serviceGroups.json
v3: true
```

### Tag: package-2024-02-preview

These settings apply only when `--tag=package-2024-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-02-preview'
input-file:
  - preview/2024-02-01-preview/serviceGroups.json
v3: true
```
---

# Suppression

``` yaml
suppressions:
  - code: TenantLevelAPIsNotAllowed
    reason: These are tenant level APIs and resource types by design.
    from: serviceGroups.json
    where: $.paths["/providers/Microsoft.Management/serviceGroups/{serviceGroupName}"]
```