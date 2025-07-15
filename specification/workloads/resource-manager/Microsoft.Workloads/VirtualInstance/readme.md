# workloads

> see https://aka.ms/autorest

This is the AutoRest configuration file for workloads.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the workloads.

``` yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2025-06
```

### Tag: package-2024-12-01-preview

These settings apply only when `--tag=package-preview-2025-06` is specified on the command line.

``` yaml $(tag) == 'package-2025-06-01-preview'
input-file:
  - preview/2025-06-01-preview/VirtualInstance.json
  - ../operations/preview/2025-06-01-preview/operations.json
suppressions:
    - code: AvoidAdditionalProperties
      from: VirtualInstance.json
      where: $.definitions.VirtualInstanceProperties.properties.metadata
      reason: The set of key-value pairs depend on the type of the workload (kind of the resource) and is not user-defined. Service will use this field to perform workload-specific validations and provide custom functionality based on the type of the workload.
    - code: AvoidAdditionalProperties
      from: VirtualInstance.json
      where: $.definitions.WorkloadComponentProperties.properties.metadata
      reason: The set of key-value pairs depend on the type of the workload (kind of the resource) and is not user-defined. Service will use this field to perform workload-specific validations and provide custom functionality based on the type of the workload.
    - code: AvoidAdditionalProperties
      from: VirtualInstance.json
      where: $.definitions.UpdateVirtualInstanceProperties.properties.metadata
      reason: The set of key-value pairs depend on the type of the workload (kind of the resource) and is not user-defined. Service will use this field to perform workload-specific validations and provide custom functionality based on the type of the workload.
    - code: AvoidAdditionalProperties
      from: VirtualInstance.json
      where: $.definitions.UpdateWorkloadComponentProperties.properties.metadata
      reason: The set of key-value pairs depend on the type of the workload (kind of the resource) and is not user-defined. Service will use this field to perform workload-specific validations and provide custom functionality based on the type of the workload.
    - code: PatchBodyParametersSchema
      from: VirtualInstance.json
      reason: All the properties defined within PATCH payload are optional. The field getting flagged is within ManagedServiceIdentity and is not added by us. This seems like an open false positive from ARM common types.
```


### Tag: package-2024-12-01-preview

These settings apply only when `--tag=package-preview-2024-12` is specified on the command line.

``` yaml $(tag) == 'package-2024-12-01-preview'
input-file:
  - preview/2024-12-01-preview/VirtualInstance.json
  - ../operations/preview/2024-12-01-preview/operations.json
suppressions:
    - code: AvoidAdditionalProperties
      from: VirtualInstance.json
      where: $.definitions.VirtualInstanceProperties.properties.metadata
      reason: The set of key-value pairs depend on the type of the workload (kind of the resource) and is not user-defined. Service will use this field to perform workload-specific validations and provide custom functionality based on the type of the workload.
    - code: AvoidAdditionalProperties
      from: VirtualInstance.json
      where: $.definitions.WorkloadComponentProperties.properties.metadata
      reason: The set of key-value pairs depend on the type of the workload (kind of the resource) and is not user-defined. Service will use this field to perform workload-specific validations and provide custom functionality based on the type of the workload.
    - code: AvoidAdditionalProperties
      from: VirtualInstance.json
      where: $.definitions.UpdateVirtualInstanceProperties.properties.metadata
      reason: The set of key-value pairs depend on the type of the workload (kind of the resource) and is not user-defined. Service will use this field to perform workload-specific validations and provide custom functionality based on the type of the workload.
    - code: AvoidAdditionalProperties
      from: VirtualInstance.json
      where: $.definitions.UpdateWorkloadComponentProperties.properties.metadata
      reason: The set of key-value pairs depend on the type of the workload (kind of the resource) and is not user-defined. Service will use this field to perform workload-specific validations and provide custom functionality based on the type of the workload.
    - code: PatchBodyParametersSchema
      from: VirtualInstance.json
      reason: All the properties defined within PATCH payload are optional. The field getting flagged is within ManagedServiceIdentity and is not added by us. This seems like an open false positive from ARM common types.
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
```

## Az

See configuration in [readme.az.md](./readme.az.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)
